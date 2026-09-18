---
title: "A neural-level model of spatial memory and imagery"
source: "https://elifesciences.org/articles/33752"
author:
  - "[[Andrej Bicanski]]"
  - "[[Neil Burgess]]"
published: 2018-09-04
created: 2026-09-18
description: "The BB model explains spatial cognition in terms of interactions between specific neuronal populations, providing a common computational framework for the human neuropsychological and in vivo animal electrophysiological literatures."
tags:
  - "clippings"
---
###### Cite this article

(2018)

*eLife* **7**:e33752.

https://doi.org/10.7554/eLife.33752

We present a model of how neural representations of egocentric spatial experiences in parietal cortex interface with viewpoint-independent representations in medial temporal areas, via retrosplenial cortex, to enable many key aspects of spatial cognition. This account shows how previously reported neural responses (place, head-direction and grid cells, allocentric boundary- and object-vector cells, gain-field neurons) can map onto higher cognitive function in a modular way, and predicts new cell types (egocentric and head-direction-modulated boundary- and object-vector cells). The model predicts how these neural populations should interact across multiple brain regions to support spatial memory, scene construction, novelty-detection, ‘trace cells’, and mental navigation. Simulated behavior and firing rate maps are compared to experimental data, for example showing how object-vector cells allow items to be remembered within a contextual representation based on environmental boundaries, and how grid cells could update the viewpoint in imagery during planning and short-cutting by driving sequential place cell activity.

[https://doi.org/10.7554/eLife.33752.001](https://doi.org/10.7554/eLife.33752.001)

The ability to reconstruct perceptual experiences into imagery constitutes one of the hallmarks of human cognition, from the ability to imagine past episodes (Tulving 1985) to planning future scenarios ([Schacter et al., 2007](#bib125)). Intriguingly, this ability (also known as ‘scene construction’ and ‘episodic future thinking’) appears to depend on the hippocampal system ([Schacter et al., 2007](#bib125); [Hassabis et al., 2007](#bib64); [Buckner, 2010](#bib19)), in which direct (spatial) correlates of the activities of single neurons have long been identified in rodents ([O'Keefe and Nadel, 1978](#bib106); [Taube et al., 1990a](#bib139); [Hafting et al., 2005](#bib60)) and more recently in humans ([Ekstrom et al., 2003](#bib45); [Jacobs et al., 2010](#bib75)). The rich catalog of behavioral, neuropsychological and functional imaging findings on one side, and the vast literature of electrophysiological research on the other (see e.g. [Burgess et al., 2002](#bib23)), promises to allow an explanation of higher cognitive functions such as spatial memory and imagery directly in terms of the interactions of neural populations in specific brain areas. However, while attaining this type of understanding is a major aim of cognitive neuroscience, it cannot usually be captured by a few simple equations because of the number and complexity of the systems involved. Here, we show how neural activity could give rise to spatial cognition, using simulations of multiple brain areas whose predictions can be directly compared to experimental data at neuronal, systems and behavioral levels.

Extending the Byrne, Becker and Burgess model of spatial memory and imagery of empty environments ([Burgess et al., 2001a](#bib24); [Byrne et al., 2007](#bib30)), we propose a large-scale systems-level model of the interaction between Papez’ circuit, parietal, retrosplenial, and medial temporal areas. The model relates the neural response properties of well-known cells types in multiple brain regions to cognitive phenomena such as memory for the spatial context of encountered objects and mental navigation within familiar environments. In brief, egocentric (i.e. body-centered) representations of the local sensory environment, corresponding to a specific point of view, are transformed into viewpoint-independent (allocentric or world-centered) representations for long-term storage in the medial temporal lobes (MTL). The reverse process allows reconstruction of viewpoint-dependent egocentric representations from stored allocentric representations, supporting imagery and recollection.

Neural populations in the medial temporal lobe (MTL) are modeled after cell types reported in rodent electrophysiology studies. These include place cells (PCs), which fire when an animal traverses a specific location within the environment ([O'Keefe and Dostrovsky, 1971](#bib105)); head direction cells (HDCs), which fire according to the animal’s head direction relative to the external environment, irrespective of location ([Taube and Ranck, 1990](#bib141); [Taube et al., 1990a](#bib139); [Taube et al., 1990b](#bib140)); boundary vector cells ([Lever et al., 2009](#bib87)); henceforth BVCs), which fire in response to the presence of a boundary at a specific combination of distance and allocentric direction (i.e. North, East, West, South, irrespective of an agent’s orientation); and grid cells (GCs), which exhibit multiple, regularly spaced firing fields ([Hafting et al., 2005](#bib60)). Evidence for the presence of these cell types in human and non-human primates is mounting steadily ([Robertson et al., 1999](#bib120); [Ekstrom et al., 2003](#bib45); [Jacobs et al., 2010](#bib75); [Doeller et al., 2010](#bib37); [Bellmund et al., 2016](#bib14); [Horner et al., 2016](#bib72); [Nadasdy et al., 2017](#bib98)).

The egocentric representation supporting imagery has been suggested to reside in medial parietal cortex (e.g. the precuneus; [Fletcher et al., 1996](#bib49); [Knauff et al., 2000](#bib81); [Formisano et al., 2002](#bib50); [Sack et al., 2002](#bib121); [Wallentin et al. (2006)](#bib156); [Hebscher et al., 2018](#bib68)). In the model, it is referred to as the ‘parietal window’ (PW). Its neurons code for the presence of scene elements (boundaries, landmarks, objects) in peri-personal space (ahead, left, right) and correspond to a representation along the dorsal visual stream (the ‘where’ pathway; [Ungerleider, 1982](#bib149); [Mishkin et al., 1983](#bib93)). The parietal window boundary coding (PWb) cells are egocentric analogues of BVCs ([Barry et al., 2006](#bib12); [Lever et al., 2009](#bib87)), consistent with evidence that parietal areas support egocentric spatial processing ([Bisiach and Luzzatti, 1978](#bib17); [Nitz, 2009](#bib99); [Save and Poucet, 2009](#bib124); [Wilber et al., 2014](#bib160)).

The transformation between egocentric (parietal) and allocentric (MTL) reference frames is performed by a gain-field circuit in retrosplenial cortex ([Burgess et al., 2001a](#bib24); [Byrne et al., 2007](#bib30); [Wilber et al., 2014](#bib160); [Alexander and Nitz, 2015](#bib4); [Bicanski and Burgess, 2016](#bib15)), analogous to gain-field neurons found in posterior parietal cortex ([Snyder et al., 1998](#bib130); [Salinas and Abbott, 1995](#bib122); [Pouget and Sejnowski, 1997](#bib116); [Pouget et al., 2002](#bib115)) or parieto-occipital areas ([Galletti et al., 1995](#bib53)). Head-direction provides the gain-modulation in the transformation circuit, producing directionally modulated boundary vector cells which connect egocentric and allocentric boundary coding neurons. That this transformation between egocentric directions (left, right, ahead) and environmentally-referenced directions (nominally North, South, East, West) requires input from the head-direction cells found along Papez’s circuit ([Taube et al., 1990a](#bib139); [Taube et al., 1990b](#bib140)) is consistent with its involvement in episodic memory (e.g. [Aggleton and Brown, 1999](#bib2); [Delay and Brion, 1969](#bib34)).

During perception the egocentric parietal window representation is based on (highly processed) sensory inputs. That is, it is driven in a bottom-up manner, and the transformation circuit maps the egocentric PWb representation to allocentric BVCs. When the transformation circuit acts in reverse (top-down mode), it reconstructs the parietal representation from BVCs which are co-active with other medial temporal cell populations, forming the substrate of viewpoint-independent (i.e. allocentric) memory. This yields an orientation-specific (egocentric) parietal representation (a specific point of view) and constitutes the model’s account of (spatial) imagery and explicit recall of spatial configurations of known spaces ([Burgess et al., 2001a](#bib24); [Byrne et al., 2007](#bib30)). [Figure 1](#fig1) depicts a simplified schematic of the model.

![](https://iiif.elifesciences.org/lax/33752%2Felife-33752-fig1-v1.tif/full/1234,/0/default.webp)

Simplified model schematic. ( A ) Processed sensory inputs reach parietal areas and support an egocentric representation of the local environment (in a head-centered frame of reference). Retrosplenial cortex uses current head or … see more https://doi.org/10.7554/eLife.33752.002

To account for the presence of objects within the environment, we propose allocentric object vector cells (OVCs) analogous to BVCs, and show how object-locations can be embedded into spatial memory, supported by visuo-spatial attention. Importantly, the proposed object-coding populations in the MTL map onto recently discovered neuronal populations ([Deshmukh and Knierim, 2013](#bib35); [Hoydal et al., 2017](#bib73)). We also predict a population of egocentric object-coding cells in the parietal window (PWo cells: egocentric analogues to OVCs), as well as directionally modulated boundary and object coding neurons (in the transformation circuit). Finally, we include a grid cell population to account for mental navigation and planning, which drives sequential place cell firing reminiscent of hippocampal ‘replay’ ([Wilson and McNaughton, 1994](#bib162); [Foster and Wilson, 2006](#bib51); [Diba and Buzsáki, 2007](#bib36); [Karlsson and Frank, 2009](#bib78); [Carr et al., 2011](#bib31)) and preplay ([Dragoi and Tonegawa, 2011](#bib39); [Ólafsdóttir et al., 2015](#bib167)). We refer to this model as the BB-model.

Here, we describe the neural populations of the BB-model and how they interact in detail. Technical details of the implementation, equations, and parameter values can be found in the Appendix.

We visualize the firing properties of individual spatially selective neurons as firing rate maps that reflect the activity of a neuron averaged over time spent in each location. We also show population activity by arranging all neurons belonging to one population according to the relative locations of their receptive fields (see [Figure 2A–C](#fig2)), plotting a snapshot of their momentary firing rates. In the case of boundary-selective neurons such a population snapshot will yield an outline of the current sensory environment ([Figure 2C](#fig2)). Naturally, these neurons may not be physically organized in the same way, and these plots should not be confused with the firing rate maps of individual neurons ([Figure 2D](#fig2)). Hence, population snapshots (heat maps) and firing rate maps (Matlab ‘jet’ colormap) are shown in distinct color-codes ([Figure 2](#fig2)).

![](https://iiif.elifesciences.org/lax/33752%2Felife-33752-fig2-v1.tif/full/1234,/0/default.webp)

Receptive field topology and visualization of neural activity. ( A1 ) Illustration of the distribution of receptive field centers (RFs) of place cells (PCs), which tile the environment. ( A2 ) Receptive fields of boundary responsive neurons, be they allocentric … see more https://doi.org/10.7554/eLife.33752.003

![](https://iiif.elifesciences.org/lax/33752%2Felife-33752-fig2-figsupp1-v1.tif/full/1234,/0/default.webp)

Caption: Illustration of single cell coding in the retrosplenial transformation circuit. Shaded areas indicate the Parietal Window (PWb), the transformation circuit, head direction modulation, and boundary vector cells (BVCs). Example cells are represented as stylized firing rate maps … see more https://doi.org/10.7554/eLife.33752.004

![posterframe for video](https://iiif.elifesciences.org/lax/33752%2Felife-33752-video1.jpg/full/639,/0/default.jpg)

Surface plots (heat maps) visualize theneural activity of populations of cells. The video shows a visualization of the simulated neural activity in the retrosplenial transformation circuit as a simulated agent moves in a simple, familiar environment (See Figure 2-figure … see more https://doi.org/10.7554/eLife.33752.005

Perceived and imagined egocentric sensory experience is represented in the ‘parietal window’ (PW), which consists of two neural populations - one coding for extended boundaries (‘PWb neurons’), and one for discrete objects (‘PWo neurons’). The receptive fields of both populations lie in peri-personal space, that is are tuned to distances and directions ahead, left or right of the agent, tile the ground around the agent, and rotate together with the agent ([Figure 2A2](#fig2), [Figure 3](#fig3)). Reciprocal connections to and from the retrosplenial transformation circuit (RSC/TR, see below) allow the parietal window representations to be transformed into allocentric (orientation-independent) representations (i.e. boundary and object vector cells) in the MTL and vice versa. Intriguingly, cells that encode an egocentric representation of boundary locations (akin to parietal window neurons in the present model) have recently been described ([Hinman et al., 2017](#bib70)).

![](https://iiif.elifesciences.org/lax/33752%2Felife-33752-fig3-v1.tif/full/1234,/0/default.webp)

The agent model and population snapshots for object representations. ( A ) Top panel: The egocentric field of view of the agent (black arrow head). Purple boundaries fall into the forward-facing 180 degree field of view and provide bottom-up drive to the parietal … see more https://doi.org/10.7554/eLife.33752.006

An agent model supplies perceptual information, driving the parietal window in a bottom-up manner. The virtual agent moves along trajectories in simple 2D environments ([Figure 2B1](#fig2)). Turning motions of the agent act on the head direction network to shift the activity packet in the head direction ring attractor. Egocentric distances to environmental boundaries in a 180-degree field of view in front of the agent are used to drive the corresponding parietal window (PWb) neurons. The retrosplenial circuit (section "The Head Direction Attractor Network and the Transformation Circuit") transforms this parietal window activity into BVC activity, which in turn drives PC activity in the pattern-completing MTL network ([O'Keefe and Burgess, 1996](#bib103); [Hartley et al., 2000](#bib62)). Thus, simplified perceptual drive conveyed to the MTL allows the model to self-localize in the environment based purely on sensory inputs.

The medial temporal lobe (MTL) network for spatial context is comprised of three interconnected neural populations: the PCs and BVCs code for the position of the agent relative to a given boundary configuration, and perirhinal neurons code for the identity (e.g. texture, color etc) of boundaries (PRb neurons). Identity has to be signaled by cells separate from BVCs because the latter respond to any boundary at a given distance and direction.

The allocentric object code is comprised of two populations of neurons. First, similarly to extended boundaries, the identity of discrete objects must be coded for by perirhinal neurons (PRo neurons). Second, we hypothesize an allocentric representation of object location, termed object vector cells (OVCs), analogous to BVCs ([Figure 3B](#fig3)), with receptive fields at a fixed distance in an allocentric direction.

Interestingly, cells which respond to the presence of small objects and resemble OVCs have recently been identified in the rodent literature ([Deshmukh and Knierim, 2013](#bib35); [Hoydal et al., 2017](#bib73)), and could reside in the hippocampus proper or one synapse away. Although we treat them separately, BVCs and OVCs could in theory start out as one population in which individual cells specialize to respond only to specific types of object with experience (e.g. to small objects in the case of OVCs; see [Barry and Burgess, 2007](#bib11)).

OVCs, like BVCs and parietal window (PWo and PWb) neurons signal geometric relations between object or boundary locations and the agent, but not the identity of the object or boundary. OVCs and BVCs fire for any object or boundary occupying their receptive fields. Conversely, an object’s or boundary’s identity is indicated, irrespective of its location, by perirhinal neurons. They lie at the apex of the ventral visual stream (the ‘what’ pathway; [Ungerleider, 1982](#bib149); [Mishkin et al., 1983](#bib93); [Goodale and Milner, 1992](#bib56); [Davachi, 2006](#bib33); [Valyear et al., 2006](#bib150)) and encode the identities or sensory characteristics of boundaries and objects, driven by a visual recognition process which is not explicitly modeled. Only in concert with perirhinal identity neurons does the object or boundary code uniquely represent a specific object or boundary at a specific direction and distance from the agent.

BVCs and OVCs have reciprocal connections to the transformation circuit, allowing them to be driven by perceptual inputs (‘bottom up’), or to project their representations to the parietal window (‘top down’).

For simulations of the agent in a familiar environment, the connectivity among the medial temporal lobe populations which comprise the spatial context (PCs, BVCs, PRb neurons) is learned in a training phase, resulting in an attractor network, such that mutual excitatory connections between neurons ensure pattern completion. Hence, partial activity in a set of PCs, BVCs, and/or PRb neurons - will re-activate a complete, previously learned representation of spatial context in these populations. OVCs and PRo neurons are initially disconnected from the populations that represent the spatial context. The simulated agent can then explore the environment and encode objects into memory along the way.

Head direction cells (HDCs) are arranged in a simple ring-attractor circuit ([Skaggs et al., 1995](#bib129); [Zhang, 1996](#bib166)). Current head direction, encoded by activity in this attractor circuit, is updated by angular velocity information as the agent explores the environment. The head direction signal enables the egocentric-allocentric transformation carried out by retrosplenial cortex.

Because of their identical topology, the PWb/BVC population pair and the PWo/OVC population pair can each make use of the same transformation circuit. For simplicity we illustrate its function via BVCs and their PWb counterparts. The retrosplenial transformation circuit (RSC/TR) consists of 20 sublayers. Each sublayer is a copy of the BVC population, with firing within each sublayer also tuned to a specific head-direction (directions are evenly spaced in the \[0360\] degree range). That is, individual cells in the transformation circuit are directionally modulated boundary vector cells, and connect egocentric (parietal) PWb neurons and allocentric BVCs (in the MTL) in a mutually consistent way. All connections are reciprocal. For example, a BVC with a receptive field to the East is mapped onto a PWb neuron with a receptive field to the right of the agent when facing North, but is mapped onto a PWb neuron with a receptive field to the left of the agent when facing South. Similarly, a PWb neuron with a receptive field ahead of the agent is mapped onto a BVC with a receptive field to the West when facing West but is mapped onto a BVC with a receptive field to the North when facing North. [Figure 2C](#fig2) depicts population snapshots that are mapped onto each other by the transformation circuit (also see [Video 1](#video1)), while [Figure 2—figure supplement 1](https://elifesciences.org/articles/33752/figures#fig2s1) illustrates the connections and firing rate maps at the single cell level. We hypothesize that the egocentric-allocentric transformation circuit is set up during development (see Appendix for the setup of the circuit).

During perception, the egocentric parietal window representation is based on sensory inputs (‘bottom-up’ mode). The PW representations thus determine MTL activity via the transformation circuit. ‘Running the transformation in reverse’ (‘top-down’ mode), that is reconstructing parietal window activity based on BVCs/OVCs, is the BB-models account of visuo-spatial imagery. To implement the switch between modes of operation, we assume that the balance between bottom-up and top-down connections is subject to neuromodulation (see e.g. [Hasselmo, 2006](#bib67)); Appendix, [Equation 3](#equ3) and following). For example, connections from the parietal window (PWb and PWo) populations to the transformation circuit and thence onto BVCs/OVCs are at full strength in bottom-up mode, but down-regulated to 5% of their maximum value in top-down mode. Conversely, connections from BVCs/OVCs to the transformation circuit and onwards to the parietal window are down-regulated during bottom-up perception (5% of their maximum value) and reach full strength only during imagery (top-down reconstruction).

Unlike boundaries, which are hard-coded in the simulations (corresponding to the agent moving in a familiar environment), object representations are learned on the fly (simulating the ability to remember objects found in new locations in the environment).

As noted above (section "The Role of Perirhinal Neurons"), to uniquely characterize the egocentric perceptual state of encountering an object within an environment requires the co-activation of perirhinal (PRo) neurons (signaling identity) and the corresponding parietal window (PWo) (signaling location in peripersonal space). Moreover, maximal co-firing of only one PRo neuron with one PWo neuron (or OVC, in allocentric terms) at a given location is required for an unambiguous association ([Figure 3A–C](#fig3)). If multiple conjunctions of object location and identity are concurrently represented then it is impossible to associate each object identity uniquely with one location - that is, object-location binding would be ambiguous. To ensure a unique representation, we allow the agent to direct attention to each visible object in sequence (compare [Figure 3B and C](#fig3); for a review of attentional mechanisms see [VanRullen, 2013](#bib154)). This leads to a specific set of PWo, OVC and PRo neurons, corresponding to a single object at a given location, being co-active for a short period while connections between MTL neurons develop (including those with PCs, see [Figure 3D](#fig3)). Then, attention is redirected and a different set of PWo, OVC and PRo neurons becomes co-active. We set a fixed length for an attentional cycle (600 time units). However, we do not model the mechanistic origins of attention. Attention is supplied as a simple rhythmic modulation of perceptual activity in the parietal window.

To encode objects in their spatial context the connections between OVCs, PRo neurons and currently active PCs are strengthened. By linking OVCs and PRo neurons to PCs, the object code is explicitly attached to the spatial context because the same PCs are reciprocally connected to the BVCs that represent the geometric properties of the environment ([Figure 3D](#fig3)). A connection between PRo neurons and HDCs is also strengthened to allow recall to re-instantiate the head direction at encoding during imagery (see Simulation 1.0 below).

Finally, if multiple objects are present in a scene we do not by default encode all perceivable objects equally strongly into memory. We trigger encoding of an object when it reaches a threshold level of ‘salience’. In general, ‘salience’ could reflect many factors; here, we simulate relatively few objects and assume that salience becomes maximal at a given proximity, and prevent any further learning thereafter.

Grid cells (GCs; Hafting et al. 2005) are thought to interface self-motion information with place cells (PCs) to enable vector navigation ([Kubie and Fenton, 2012](#bib82); [Erdem and Hasselmo, 2012](#bib47); [Bush et al., 2015](#bib27); [Stemmler et al., 2015](#bib136)), shortcutting, and mental navigation ([Bellmund et al., 2016](#bib14)); Horner et al. 2016). Importantly, both self-motion inputs (via GCs) and sensory inputs (e.g. mediated via BVCs and OVCs) converge onto PCs and both types of inputs may be weighted according to their reliability ([Evans et al., 2016](#bib48)). GCs could thus support PC activity when sensory inputs are unreliable or absent. Here, GC inputs can drive PC firing during imagined navigation (see Section Novelty Detection (Simulations 1.3, 1.4)), whereas perceived scene elements, mediated via BVC and OVCs, provide the main input to PCs during unimpaired perception.

We include a GC module in the BB-model that, driven by heuristically implemented mock-motor-efference signals (self-motion signals with suppressed motor output), can update the spatial memory network in the absence of sensory inputs. The GC input allows the model to perform mental navigation (imagined movement through a known environment). By virtue of connections from GCs to PCs, the GCs can shift an activity bump smoothly along the sheet of PCs. Pattern completion in the medial temporal lobe network then updates the BVC representation according to the shifted PC representation. BVCs in turn update the parietal window representation (top-down), smoothly shifting the egocentric field of view in imagery (i.e. updating the parietal window representations) during imagined movement. Thus, self-motion related updating (sometimes referred to as ‘path integration’) and mental navigation share the same mechanism ([Tcheang et al., 2011](#bib143)).

Connection weights between GCs and PCs are calculated as a simple Hebbian association between PC firing at a given coordinate (according to the mapping shown in [Figure 2A,B](#fig2)) and pre-calculated firing rate maps of GCs (7 modules with 100 cells each, see Appendix for details).

An agent employing a simple model of attention alongside dedicated object-related neural populations in perirhinal, parietal and parahippocampal (BVCs and OVCs) cortices allow the encoding of scene representations (i.e. objects in a spatial context) into memory. Transforming egocentric representations via the retrosplenial transformation circuit yields viewpoint-independent (allocentric) representations in the medial temporal lobe, while reconstructing the parietal window representation (which is driven by sensory inputs during perception) from memory is the model’s account of recall as an act of visuo-spatial imagery. Grid cells allow for mental navigation. [Figure 4](#fig4) shows the complete schematic of the BB-model, see [Figure 2—figure supplement 1](https://elifesciences.org/articles/33752/figures#fig2s1) for details of the RSC transformation circuit.

![](https://iiif.elifesciences.org/lax/33752%2Felife-33752-fig4-v1.tif/full/1234,/0/default.webp)

The BB-model. ‘Bottom-up’ mode of operation: Egocentric representations of extended boundaries (PWb) and discrete objects (PWo) are instantiated in the parietal window (PWb/o) based on inputs from the agent model … see more https://doi.org/10.7554/eLife.33752.007

To obtain a measure of successful recall or of novelty detection (i.e. mismatch between the perceived and remembered scenes), we correlate the population vectors of the model’s neural populations between recall (the reconstruction in imagery) and encoding. These correlations are compared to correlations between recall and randomly sampled times as the agent navigates the environment in bottom-up mode. This measure of mismatch could potentially be compared to experimental measures of overlap between neuronal populations (e.g. [Guzowski et al., 1999](#bib59)) in animals, or ‘representational similarity’ measures in fMRI, e.g. [Ritchey et al., 2013](#bib119)).

In this section, we explore the capabilities of the BB-model in simulations and derive predictions for future research. Each simulation is accompanied by a Figure, a supplementary video visualizing the time course of activity patterns of neural populations, and a brief discussion. In Section Discussion, we offer a more general discussion of the model.

We let the agent model explore the square environment depicted in [Figure 3A](#fig3). However, the spatial context now contains an isolated object ([Figure 5](#fig5)). During exploration, parietal window (PWb) neurons activate BVCs via the retrosplenial transformation circuit (RSC/TR), which in turn drive place cell activity. Similarly, when the object is present PWo neurons are activated, which drive OVCs via the transformation circuit. At the same time, object/boundary identity is signalled by perirhinal neurons (PRb/o). When the agent comes within a certain distance (here 55 cm) of an object, the following connection weights are changed to form Hebbian associations: PRo neurons are associated with PCs, HDCs, and OVCs; OVCs are associated with PCs and PRo neurons (also see [Figure 3D](#fig3)); PCs are already connected to BVCs (in a familiar context). The weight change is calculated as the outer product of population vectors of the corresponding neuronal populations (yielding the Hebbian update), normalized, and added to the given weight matrix.

![](https://iiif.elifesciences.org/lax/33752%2Felife-33752-fig5-v1.tif/full/1234,/0/default.webp)

( A ) Bottom-up mode of operation. Population snapshots at the moment of encoding during an encounter with a single object in a familiar spatial context. Left to right: PWb/o populations driven by … see more https://doi.org/10.7554/eLife.33752.008

After the agent has finished its assigned trajectory, we test object-location memory via object-cued recall. That is, modeling some external trigger to remember a given object (e.g. ‘Where did I leave my keys?'), current is injected into the PRo neuron coding for the identity of the object to-be recalled. By virtue of learned connections, the PRo neuron drives the PCs which were active at encoding. Pattern completion in the MTL recovers the complete spatial context by driving activity in BVCs and PRb neurons. The connections from PRo neurons to head direction cells ([Figure 3D](#fig3)) ensure a modulation of the transformation circuit such that allocentric BVC and OVC activity will be transformed to yield the parietal representation (i.e. a point of view) similar to the one at the time of encoding. That is, object-cued recall corresponds to a full reconstruction of the scene when the object was encoded. [Figure 5](#fig5) depicts the encoding ([Figure 5A](#fig5)) and recall phases ([Figure 5B](#fig5)) of simulation 1.0. [Video 2](#video2) shows the entire trial. To facilitate matching simulation numbers and figures to videos, [Table 1](#table1) lists all simulations and relates them to their corresponding figures and videos.

Table 1

###### List of simulations, their content, corresponding Figures and videos

[https://doi.org/10.7554/eLife.33752.009](https://doi.org/10.7554/eLife.33752.009)

| Simulation no. | Content | Related figures | Video no. |
| --- | --- | --- | --- |
| 0 | Activity in the transformation circuit | [Figure 2—figure supplement 1](https://elifesciences.org/articles/33752/figures#fig2s1) | 1 |
| 1.0 | Object-cued recall | [Figures 5](#fig5) and [^4],8A | 2 |
| 1.0n1 | Object-cued recall with neuron loss | [Figure 8B](#fig8) | 3 |
| 1.0n2 | Object-cued recall with firing rate noise | [Figure 8C](#fig8) | 4 |
| 1.1 | Papez’ circuit Lesion (anterograde amnesia) | [Figure 7A](#fig7) | 5 |
| 1.2 | Papez’ circuit Lesion (retrograde amnesia) | [Figure 7B](#fig7) | 6 |
| 1.3 | Object novelty (intact hippocampus) | [Figure 9A](#fig9) | 7 |
| 1.4 | Object novelty (lesioned hippocampus) | [Figure 9B](#fig9) | 8 |
| 2.1 | Boundary trace responses | [Figure 10A,B,C](#fig10) | 9 |
| 2.2 | Object trace responses | [Figure 10D](#fig10) | 10 |
| 3.0 | Inspection of scene elements in imagery | [Figure 11](#fig11) | 11 |
| 4.0 | Mental Navigation | [Figure 12](#fig12) | 12 |
| 5.0 | Planning and short-cutting | [Figure 13](#fig13) | 13 |

![posterframe for video](https://iiif.elifesciences.org/lax/33752%2Felife-33752-video2.jpg/full/639,/0/default.jpg)

This video shows a visualization of the simulated neural activity as the agent moves in a familiar environment and encounters a novel object. The agent approaches the object and encodes it into long-term memory. Upon navigating past the object the agent initiates recall, reinstating patterns of neural activity similar to the patterns … see more https://doi.org/10.7554/eLife.33752.010

Recollection in the BB-model results in visuo-spatial imagery of a coherent scene from a single viewpoint and direction, that is it implements a process of scene construction ([Burgess et al., 2001a](#bib24); [Byrne et al., 2007](#bib30); [Schacter et al., 2007](#bib125); [Hassabis et al., 2007](#bib64); [Buckner, 2010](#bib19)) at the neuronal level. A mental image is re-constructed in the parietal window reminiscent of the perceptual activity present at encoding. Note that during imagery BVCs (and hence PWb neurons, [Figure 5B](#fig5)) all around the agent are reactivated by place cells, because the environment is familiar (the agent having experienced multiple points of view at each location during the training phase). We do not simulate selective attention for boundaries (i.e. PWb neurons), although see [Byrne et al., 2007](#bib30).

Similar tasks in humans appear to engage the full network, including Papez’ circuit, where head direction cells are found (for review see [Taube, 2007](#bib142)); retrosplenial cortex (where we hypothesize the transformation circuit to be located) ([Burgess et al., 2001a](#bib24); [Lambrey et al., 2012](#bib84); [Auger and Maguire, 2013](#bib8); [Epstein and Vass, 2014](#bib46); [Marchette et al., 2014](#bib89); [Shine et al., 2016](#bib127)); medial parietal areas ([Fletcher et al., 1996](#bib49); [Hebscher et al., 2018](#bib68)); parahippocampus and hippocampus ([Hassabis et al., 2007](#bib64); [Addis et al., 2007](#bib1); [Schacter et al., 2007](#bib125); [Bird et al., 2010](#bib16)); and possibly the entorhinal cortex ([Atance and O'Neill, 2001](#bib7); [Bellmund et al., 2016](#bib14); Horner et al. 2016; also see Simulation 4.0).

At the neuronal level, a key component of the BB-model are the object vector cells (OVCs) which code for the location of objects in peri-personal space. In Figure 5 the cells are organized according to the topology of their receptive fields in space, with the agent at the center (also compare to [Figure 2A2](#fig2)). However, in rodent experiments individual spatially selective cells (like PCs or GCs) are normally visualized as time-integrated firing rate maps. We ran a separate simulation with three objects in the environment to examine firing rate maps of individual cells. OVCs show firing fields at a fixed allocentric distance and angle from objects ([Figure 6](#fig6)). The BB-model predicts that OVC-like responses should be found as close as one synapse away from the hippocampus and were introduced as a parsimonious object code, analogous to BVCs and exploiting the existing transformation circuit. However, these rate maps show a striking resemblance to similar data from cells recently reported in the hippocampus of rodents ([Figure 6C](#fig6), compare to [Deshmukh and Knierim, 2013](#bib35)). While [Deshmukh and Knierim (2013)](#bib35) found these cells in the hippocampus, the object selectivity of these hippocampal neurons may have been inherited from other areas, such as lateral entorhinal cortex ([Tsao et al., 2013](#bib146)), parahippocampal cortex (due to their similarities to BVCs) or medial entorhinal cortex ([Solstad et al., 2008](#bib131); [Hoydal et al., 2017](#bib73)).

![](https://iiif.elifesciences.org/lax/33752%2Felife-33752-fig6-v1.tif/full/1234,/0/default.webp)

Firing fields of object vector cells. ( A ) Firing rate maps for representative object vector cells (OVCs), firing for objects with a fixed allocentric location and direction relative to the agent. Object locations superimposed as green … see more https://doi.org/10.7554/eLife.33752.011

Anatomical connections between the potential loci of BVCs/OVCs and retrosplenial cortex (the suggested location of the egocentric-allocentric transformation circuit) exist. BVCs have been found in the subicular complex ([Lever et al., 2009](#bib87)), and the related border cells and OVCs in medial entorhinal cortex ([Solstad et al., 2008](#bib131); [Hoydal et al., 2017](#bib73)). Both areas receive projections from retrosplenial cortex ([Jones and Witter, 2007](#bib77)), and project back to it ([Wyss and Van Groen, 1992](#bib164)).

[Figure 5](#fig5) depicts the model performing encoding and object-cued recall. However, the model also allows simulation of some of the classic pathologies of long-term memory. Lesions along Papez’ circuit have long been known to induce amnesia ([Delay and Brion, 1969](#bib34); [Squire and Slater, 1978](#bib135); [^8]; [Parker and Gaffan, 1997](#bib111); [Aggleton et al., 2016](#bib3)). Thus, lesions to the fornix and mammilary bodies severely impact recollection, although recognition can be less affected ([Tsivilis et al., 2008](#bib147)). In the context of spatial representations, Papez’ circuit is notable for containing head direction cells (as well as many other cell types not in the model). That is, the mammillary bodies (more specifically the lateral mammillary nucleus, LMN), anterior dorsal thalamus, retrosplenial cortex, parts of the subicular complex and medial entorhinal cortex all contain head direction cells ([Taube, 2007](#bib142); [Sargolini et al., 2006](#bib123)). Thus, lesioning Papez’ circuit removes (at least) the head direction signal from our model, and is modeled by setting the input from head direction cells to the retrosplenial transformation circuit (RSC/TR) to zero.

In the bottom-up mode of operation (perception), the lesion removes drive to the transformation circuit and consequently to the boundary vector cells and object vector cells. That is, the perceived location of an object (present in the egocentric parietal representation) cannot elicit activity in the MTL and thus cannot be encoded into memory ([Figure 7](#fig7)). Some residual MTL activity reflects input from perirhinal neurons representing the identity of perceived familiar boundaries (i.e. recognition mediated by perirhinal cells is spared). In the top-down mode of operation (recall) there are two effects: (i) Since no new elements can be encoded into memory, post-lesion events cannot be recalled (anterograde amnesia; Simulation 1.1, [Figure 7A](#fig7), Video 5); and (ii) For pre-existing memories (e.g. of an object encountered prior to the lesion), place cells (and thus the remaining MTL populations) can be driven via learned connections from perirhinal neurons (e.g. when cued with the object identity; Simulation 1.2, [Figure 7B](#fig7), Video 6), but no meaningful egocentric representation can be instantiated in parietal areas, preventing episodic recollection/imagery. Equating the absence of parietal activity with the inability to recollect is strongly suggested by the fact that visuo-spatial imagery in humans relies on access to an egocentric representation (as in hemispatial representational neglect; [Bisiach and Luzzatti, 1978](#bib17)). Simulations 1.1 and 1.2 show that the egocentric neural correlates of objects and boundaries present in the visual field persist in the parietal window only while the agent perceives them (they could also be held in working memory, which is not modelled here). Note that perirhinal cells and upstream ventral visual stream inputs are spared, so that an agent could still report the identity of the object.

![](https://iiif.elifesciences.org/lax/33752%2Felife-33752-fig7-v1.tif/full/1234,/0/default.webp)

Papez’ circuit lesions. ( A ) In the bottom-up mode of operation (perception), a lesion to the head direction circuit removes drive to the transformation circuit and consequently to the boundary vector cells (BVCs) and … see more https://doi.org/10.7554/eLife.33752.012

[Figure 8A](#fig8) shows correlations between population vectors of neural patterns during imagery/recall and those during encoding for Simulation 1.0 (Object-cued recall; [Figure 5](#fig5)). OVCs and PCs exhibit correlation values close to one, indicating faithful reproduction of patterns. BVC correlations are somewhat diminished because recall reactivates all boundaries fully, compared to a field of view of 180 degrees during perception with limited reactivation of cells representing boundaries outside the field of view. PW neurons show correlations below one because at recall reinstatement in parietal areas requires the egocentric-allocentric transformation (i.e. OVC signals passed through retrosplenial cells), which blurs the pattern compared to perceptual instatement in the parietal window (i.e. imagined representations are not as precise as those generated by perception).

![](https://iiif.elifesciences.org/lax/33752%2Felife-33752-fig8-v1.tif/full/1234,/0/default.webp)

Correlation of neural population vectors between recall/imagery and encoding. ( A ) In the intact model, OVCs and place cells exhibit correlation values close to one, indicating faithful reproduction of patterns. ( B ) Random neuron loss (20% of cells in all populations except … see more https://doi.org/10.7554/eLife.33752.013

To test the model’s robustness with regard to firing rate noise and neuron loss, we perform two sets of simulations (modifications of Simulation 1.0, object-cued recall). In the first set we randomly chose cells in equal proportions in all model areas (except HDCs) to be permanently deactivated and assess recall into visuo-spatial imagery. Up to 20% of the place cells, grid cells, OVCs, BVCs, parietal and retrosplenial neurons were deactivated. Head direction cells were excluded because of the very low number simulated (see below). Although we do not attempt to model any specific neurological condition, this type of simulation could serve as a starting point for models of diffuse damage, as might occur in anoxia, Alzheimer’s disease or aging. The average correlations between the population vectors at encoding versus recall are shown in [Figure 8B](#fig8).

The ability to maintain a stable attractor state among place cells and head direction cells is critical to the functioning of the model, while damage in the remaining (feed-forward) model components manifests in gradual degradation in the ability to represent the locations of objects and boundaries (see accompanying [Video 3](#video3)). For example, if certain parts of the parietal window suffer from neuron loss, the reconstruction in imagery is impaired only at the locations in peri-personal space encoded by the missing neurons (indeed, this can model representational neglect; [Byrne et al., 2007](#bib30)), see also [Pouget and Sejnowski, 1997](#bib116)). The place cell population was more robust to silencing than the head-direction population (containing only 100 neurons), simply because greater numbers of neurons were simulated, giving greater redundancy. As long as a stable attractor state is present, the model can still encode and recall meaningful representations, giving highly correlated perceived and recalled patterns ([Figure 8B](#fig8)).

![posterframe for video](https://iiif.elifesciences.org/lax/33752%2Felife-33752-video3.jpg/full/639,/0/default.jpg)

This video shows the same scenario as (object-cued recall), however, with 20% randomly chosen lesioned cells per area. The agent moves in a familiar environment and encounters a novel object. The agent approaches the object and encodes it into long-term memory. Upon navigating past the object, the agent initiates … see more https://doi.org/10.7554/eLife.33752.014

The model is also robust to adding firing rate noise (up to 20% of peak firing rate) to all cells. Correlations between patterns at encoding and recall remain similar to the noise-free case, see [Figure 8C](#fig8). [Videos 3](#video3) and [^5] show an instance from the neuron-loss and firing rate noise simulations respectively.

![posterframe for video](https://iiif.elifesciences.org/lax/33752%2Felife-33752-video4.jpg/full/639,/0/default.jpg)

This video shows the same scenario as (object-cued recall), however, with firing rate noise applied to all neurons (max. 20% of peak rate). The agent moves in a familiar environment and encounters a novel object. The agent approaches the object and encodes it into long-term memory. Upon navigating past the object the agent initiates … see more https://doi.org/10.7554/eLife.33752.015

![posterframe for video](https://iiif.elifesciences.org/lax/33752%2Felife-33752-video5.jpg/full/639,/0/default.jpg)

This video shows a visualization of the simulated neural activity as the agent encounters an object and subsequently tries to engage recall similar to Simulation 1.0 (). However, a lesion to the head direction system (head direction cells are found along Papez' circuit) precludes the agent from laying down new memories, because the transformation circuit cannot … see more https://doi.org/10.7554/eLife.33752.016

![posterframe for video](https://iiif.elifesciences.org/lax/33752%2Felife-33752-video6.jpg/full/639,/0/default.jpg)

This video shows a visualization of the simulated neural activity as the agent moves through an empty environment and tries to engage recall of a previously present object. A lesion to the head direction system (head direction cells are found along Papez' circuit) has been implemented similar to Simulation 1.1 ( Video 5 ). The agent is supplied with the connection … see more https://doi.org/10.7554/eLife.33752.017

In the model, hippocampal place cells bind all scene elements together. The locations of these scene elements relative to the agent are encoded in the firing of boundary vector cells (BVCs) and object vector cells (OVCs). Rats show a spontaneous preference for exploring novel/altered stimuli compared to familiar/unchanged ones. We simulate one of these experiments ([Mumby et al., 2002](#bib97)), in which rats preferentially explore one of two objects that has been shifted to a new location within a given environment, a behavior impaired by hippocampal lesions. In Simulations 1.3 and 1.4, the agent experiences an environment containing two objects, one of which is later moved. We define a mismatch signal as the difference in firing of object vector cells during encoding versus recall (modelled as imagery, at the encoding location), and assume that the relative amounts of exploration would be proportional to the mismatch signal.

With an intact hippocampus ([Figure 9](#fig9); [Video 7](#video7)), the moved object generates a significant novelty signal, due to the mismatch between recalled (top-down) OVC firing and perceptual (bottom-up) OVC firing at the encoding location. That detection of a change in position requires the hippocampus is consistent with place cells binding the relative location of an object (via object vector cells) to perirhinal neurons signalling the identity of an object.

![](https://iiif.elifesciences.org/lax/33752%2Felife-33752-fig9-v1.tif/full/1234,/0/default.webp)

Detection of moved objects via OVC firing mismatch. ( A ) Two objects are encoded from a given location (left). After encoding, object one is moved further North. When the agent returns to the encoding location, the perceived position of object one … see more https://doi.org/10.7554/eLife.33752.018

![posterframe for video](https://iiif.elifesciences.org/lax/33752%2Felife-33752-video7.jpg/full/639,/0/default.jpg)

This video shows a visualization of the simulated neural activity in a reproduction of the object novelty paradigm of; detecting that one of two objects has been moved). The agent is faced with two objects and encodes them (sequentially) into memory. Following some behavior one of the two objects is moved. Note, in real experiments the animal is removed for this … see more https://doi.org/10.7554/eLife.33752.019

Hippocampal lesions are implemented by setting the firing rates of hippocampal neurons to zero. A hippocampal lesion ([Figure 9](#fig9); [Video 8](#video8)) precludes the generation of a meaningful novelty signal because the agent is incapable of generating a coherent point of view for recollection, and the appropriate BVC configuration cannot be activated by the now missing hippocampal input. Connections between object vector cells and perirhinal neurons (see [Figure 3D](#fig3)) can still form during encoding in the lesioned agent. Thus some OVC activity is present during recall due to these connections. However, this activity is not location specific. Without the reference frame of place cells and thence BVC activity this residual OVC activity during recall can be generated anywhere (see [Figure 9F–H](#fig9)). It only tells the agent that it has seen this object at a given distance and direction, but not where in the environment it was seen. Hence, the mismatch signal is equal for both objects, and exploration time would be split roughly evenly between them. However, if the agent happens to be at the same distance and direction from the objects as at encoding, then perceptual OVC activity will match the recalled OVC activity ([Figure 9G,H](#fig9)), which might correspond to the ability of focal hippocampal amnesics to detect the familiarity of an arrangement of objects if tested from the same viewpoint as encoding ([King et al., 2002](#bib80); but see also [Shrager et al., 2007](#bib128)).

![posterframe for video](https://iiif.elifesciences.org/lax/33752%2Felife-33752-video8.jpg/full/639,/0/default.jpg)

should be compared to. It shows a reproduction of the object novelty paradigm of Mumby et al., 2002; detecting that one of two objects has been moved). The agent is faced with two objects and encodes an association … see more https://doi.org/10.7554/eLife.33752.020

Rats also show preferential exploration of a familiar object that was previously experienced in a different environment, compared with one previously experienced in the same environment, and this preference is also abolished by hippocampal lesions ([Mumby et al., 2002](#bib97); [Eacott and Norman, 2004](#bib43); [Langston and Wood, 2010](#bib86)). We have not simulated different environments (using separate place cell ensembles), but note that ‘remapping’ of PCs between distinct environments (i.e. much reduced overlap of PC population activity; e.g. [Bostock et al., 1991](#bib18); [Anderson and Jeffery, 2003](#bib6); [Wills et al., 2005](#bib161)) suggests a mismatch signal for the changed-context object would be present in PC population vectors. Initiating recall of object A, belonging to context 1, in context 2, would re-activate the PC ensemble belonging to context 1, creating an imagined scene from context one which would mismatch the activity of PCs representing context two during perception. A hippocampal lesion precludes such a mismatch signal by removing PCs.

Finally, it has been argued that object recognition (irrespective of context) is spared after hippocampal but not perirhinal lesions ([Aggleton and Brown, 1999](#bib2); [Winters et al., 2004](#bib163); [Norman and Eacott, 2004](#bib102)) which would be compatible with the model given that its perirhinal neuronal population signals an object’s identity irrespective of location.

Simulations 1.3 and 1.4 dealt with a moved object. Similarly, if a scene element (a boundary or an object) has been removed after encoding, probing the memorized MTL representation can reveal trace activity reflecting the previously encoded and now absent boundary or object.

Section (Bottom-up vs top-down modes of operation) summarizes how top-down and bottom-up phases are implemented by a modulation of connection strengths (see [Figures 1](#fig1) and [^3], Materials and methods section Embedding Object-representations into a Spatial Context: Attention and Encoding, and Appendix). During perception, the ‘top-down’ connections from the MTL to the transformation circuit and thence to the parietal window are reduced to 5% of their maximum strength, to ensure that learned connections do not interfere with on-going, perceptually driven activity. During imagery, the ‘bottom-up’ connections from the parietal window to the transformation circuit and thence to the MTL are reduced to 5 percent of their maximum strength.

In rodents, it has been proposed that encoding and retrieval are gated by the theta rhythm ([Hasselmo et al., 2002](#bib65)): a constantly present modulation of the local field potential during exploration. In humans, theta is restricted to shorter bursts, but is associated with encoding and retrieval ([Düzel et al., 2010](#bib41)). If rodent theta determines the flow of information (encoding vs retrieval) then it may be viewed as a periodic comparison between memorized and perceived representations, without deliberate recall of a specific item in its context (that is, without changing the point of view). In Simulations 2.1 and 2.2, we implement this scenario. There is no cue to recall anything specific, regular sensory inputs are continuously engaged, and we periodically switch between bottom-up and top-down modes (at roughly theta frequency) to allow for an on-going comparison between perception and recall. Activity due to the modulation of top-down connectivity during perception propagates to the parietal window representations (PWb/o), allowing for a detection of mismatch between sensorily driven and imagery representations.

In Simulation 2.1, the agent has a set of MTL weights which encode the contextual representation of a square room with an inserted barrier (i.e. a barrier was present in the training phase). However, when the agent explores the environment, the barrier is absent ([Figure 10A](#fig10)). Due to the modulation of top-down connectivity, the memory of the barrier (in form of BVC activity) periodically bleeds into the parietal representation during perception ([Figures 10B1](#fig10), [^1] and [^2] and [Video 9](#video9)). The resultant dynamics carry useful information. First, letting the memory representation bleed into the perceptual one allows an agent, in principle, to localize and attend to a region of space in the egocentric frame of reference (as indicated by parietal window activity) where a change has occurred. A mismatch between the perceived (low bottom-up gain) and partially reconstructed (high bottom-up gain) representations, can signal novelty (compare to Simulations 1.3, 1.4), and could underlie the production of memory-guided attention (e.g. [Moores et al., 2003](#bib95); [Summerfield et al., 2006](#bib138)). Moreover, the theta-like periodic modulation of top-down connectivity causes the appearance of ‘trace’ responses in BVC firing rate maps, indicating the location of previously encoded, now absent, boundary elements ([Figures 10C1](#fig10) and [^1])

![](https://iiif.elifesciences.org/lax/33752%2Felife-33752-fig10-v1.tif/full/1234,/0/default.webp)

‘Top-down’ activity and ‘trace’ responses. ( A ) An environment containing a small barrier (red outline) has been encoded in the connection weights in the MTL, but the barrier has been removed before the agent explores the environment again. ( B … see more https://doi.org/10.7554/eLife.33752.021

![posterframe for video](https://iiif.elifesciences.org/lax/33752%2Felife-33752-video9.jpg/full/639,/0/default.jpg)

This video shows a visualization of the simulated neural activity as the agent moves in a familiar environment. However, a previously present boundary has been removed. The agent is supplied with a periodic (akin to rodent theta) modulation of the top-down connection weights (please see main text). The … see more https://doi.org/10.7554/eLife.33752.022

Simulation 2.2 ([Figures 10D1,D2](#fig10) and [Video 10](#video10)) shows similar’ trace’ responses for OVCs. The agent has a set of MTL weights which encode the scene from Simulation 1.0 ([Figure 5](#fig5)) where it encountered and encoded an object. The object is now absent (small red circle in [Figure 10D1](#fig10)), but the periodic modulation of top-down connectivity reactivates corresponding OVCs, yielding trace fields in firing rate maps. This activity can bleed into the parietal representation during perception (e.g. at simulation time 9:40-10:00 in [Video 6](#video6)), albeit only when the location of encoding is crossed by the agent, and with weaker intensity than missing boundary activity (the smaller extent of the OVC representation leads to more attenuation of the pattern as it is processed by the transformation circuit).

![posterframe for video](https://iiif.elifesciences.org/lax/33752%2Felife-33752-video10.jpg/full/639,/0/default.jpg)

This video shows a visualization of the simulated neural activity as the agent moves in a familiar environment. However, a previously present (and encoded) object has been removed. The agent is supplied with a periodic (akin to rodent theta) modulation of the top-down connection weights (please see main … see more https://doi.org/10.7554/eLife.33752.023

Interestingly, perirhinal identity neurons, which normally fire irrespective of location, can appear as spatially selective trace cells due to the periodic modulation of top-down connectivity at the location of encoding. [Figure 10D3](#fig10) shows the firing rate map of a perirhinal identity neuron. Every time the memorized representation is probed (high top-down gain), if the agent is near the location of encoding, the learned connection from PCs to perirhinal cells (PRo) lead to perirhinal firing for the absent object, yielding a spatial trace firing field for this nominally non-spatial cell.

The presence of some memory-related activity during nominally bottom-up (perceptual) processing can have benefits beyond the assessment of change discussed above. For instance, additional activity in the contextual representations (BVCs, PC, PRb neurons) due to pattern completion in the MTL can enhance the firing of BVCs coding for scene elements outside the current field of view. This activity can propagate to the PW, as is readily apparent during full recall/imagery ([Figure 5](#fig5)) but is also present in weaker form during perception. Such activity may support awareness of our spatial surrounding outside of the immediate field of view, or may enhance perceptually driven representations when sensory inputs are weak or noisy.

Humans can focus attention on different elements in an imagined scene, sampling one after another, without necessarily adopting a new imagined viewpoint. This implies that the set of active PCs need not change while different objects are inspected in imagery. Moreover, humans can localize an object in imagined scenes and retrieve its identity (e.g. ‘What was next to the fireplace in the restaurant we ate at?”).

In Simulation 1.0 (encoding and object-cued recall, [Figure 5](#fig5)), in addition to connection weights from perirhinal (PRo) neurons to PCs and OVCs, the reciprocal weights from OVCs to PRo neurons were also learned. These connections allow the model to sample and inspect different objects in an imagined scene. To illustrate this we place two objects in a scene and allow the agent to encode both visible objects from the same point of view. Encoding still proceeds sequentially. That is, our attention model first samples one object (boosting its activity in the PW) and then the other.

We propose that encoded objects that are not currently the focus of attention in imagery can attract attention by virtue of their residual activity in the parietal window (weak secondary peak in the PWo population in [Figure 11B](#fig11)). Thus, any of these targets can be focused on by scanning the parietal window and shifting attention to the corresponding location (e.g. ‘the next object on a table’). Boosting the drive to such a cluster of PWo cells in the parietal window leads to corresponding activity in the OVC population (via the retrosplenial transformation circuit). The learned connection from OVCs to perirhinal PRo neurons will then drive PRo activity corresponding to the object which, at the time of encoding, was at the location in peripersonal space which is now the new focus of attention. Mutual inhibition between PRo neurons suppresses the previously active PRo neuron. The result is a top-down drive of perirhinal neurons (as opposed to bottom-up object recognition), which allows inferring the identity of a given object. That is, by shifting its focus of attention in peripersonal space (i.e. in the parietal window) during imagery the agent can infer the identity of scene elements which it did not initially recall.

![](https://iiif.elifesciences.org/lax/33752%2Felife-33752-fig11-v1.tif/full/1234,/0/default.webp)

Inspecting scene elements in imagery. The agent encounters two objects. ( A ) Activity in PWo (left) and OVCs (right) populations when the agent is attending to one of the two objects during encoding. Both objects are encoded sequentially … see more https://doi.org/10.7554/eLife.33752.024

[Figure 11](#fig11) and [Video 11](#video11) show sequential (attention-based) encoding, subsequent recall and attentional sampling of scene elements. The agent sequentially encodes two objects from one location ([Figure 11A](#fig11)), moves on until both objects are out of view, and engages imagery to recall object one in its spatial context ([Figure 11B](#fig11)). The agent can then sample object two by allocating attention to the secondary peak in the parietal window (boosting the residual activity by injecting current in the PWo cells corresponding to the location of object 2). This activity spreads back to the MTL network, via OVCs, driving the corresponding PRo neuron ([Figure 11C](#fig11)). Thus, the agent infers the identity of object 2, by inspecting it in imagery. Attention ensures disambiguation of objects at encoding, while reciprocity of connections in the MTL is necessary to form a stored attractor in spatial memory.

![posterframe for video](https://iiif.elifesciences.org/lax/33752%2Felife-33752-video11.jpg/full/639,/0/default.jpg)

This video shows a visualization of the simulated neural activity as the agent sequentially encodes two objects into long-term memory. Upon navigating past the objects the agent initiates recall, cueing with the first object. The OVC representations of both objects are bound to the same place cells. These place cells thus generate … see more https://doi.org/10.7554/eLife.33752.025

The parietal window neurons encode the perceived spatial layout of an environment, in an egocentric frame of reference, as an agent explores it (i.e. a representation of the current point of view). In imagery, this viewpoint onto a scene is reconstructed from memory (top-down mode as opposed to bottom-up mode). We refer to mental navigation as internally driven translation and rotation of the viewpoint in the absence of perceptual input. In Simulation 4.0, we let the agent encode a set of objects into memory and then perform mental navigation with the help of grid and head direction cells.

Grid cell (GC) firing is thought to update the location represented by place cell firing, driven by signals relating to self-motion ([O'Keefe and Burgess, 2005](#bib104); [McNaughton et al., 2006](#bib92); [Fuhs and Touretzky, 2006](#bib52); [Solstad et al., 2006](#bib132)). During imagination, we suppose that GC firing is driven by mock motor-efference signals (i.e. imagined movement without actual motor output) and used to translate the activity bump on the sheet of place cells. Pattern completion in the MTL network would then update the BVC population activity accordingly, which will spread through the transformation circuit and update parietal window activity. That is, mock motor efference could smoothly translate the viewpoint in imagery (i.e. scene elements represented in the parietal window flow past the point of view of the agent). Similarly, mock rotational signals to the head direction attractor could rotate the viewpoint in imagery. Both together are sufficient to implement mental navigation.

GCs are implemented heuristically, approximating the output of more sophisticated models (e.g., [Burgess et al., 2007](#bib21); [Burak and Fiete, 2009](#bib20); [Bush and Burgess, 2014](#bib28)). Firing rate maps for 7 modules of 100 cells each are pre-calculated (see Appendix), providing the firing rates of GCs as a function of location. GC to PC weights are pre-calculated as Hebbian associations (to simulate a familiar environment), where the connection strength is maximal if the center of a PC’s receptive field coincides with (one of) the GC’s firing peaks. During (bottom-up) perception and navigation, GC input provides a small contribution to PC activity, which is mainly determined by BVC inputs ([O'Keefe and Burgess, 1996](#bib103); [Hartley et al., 2000](#bib62); [Lever et al., 2009](#bib87)), to highlight the ability of the model to self-localize based on sensory inputs. Stronger grid cell input simply makes the location estimate more stable without detriment to the model. In the absence of reliable sensory information strong GC inputs are required to make PCs fire reliably ([Bush et al., 2014](#bib26); [Poucet et al., 2014](#bib114); [Evans et al., 2016](#bib48)). Imagery is an extreme case of this situation, where no sensory input is provided to PCs. Consequently, GC input is up-regulated during imagery (similar to other connections in the switch from bottom-up to top-down modes), constituting a major input to PCs. This GC input can then translate the agent’s viewpoint in imagery (via their effect on PCs) without directly affecting the transformation circuit.

[Figure 12](#fig12) and [Video 12](#video12) show an example of mental navigation. The agent approaches three objects in sequence, encodes them into memory and then initiates recall cued by object 1. From that (imagined) location, it initiates mental navigation in a straight line. GCs shift the PC activity bump along the trajectory. The allocentric boundary representation (BVCs) follows the shifting PCs (due to pattern completion) and the retrosplenial transformation circuit (RSC/TR) translates the shifting BVC representation into a shifting (i.e. ‘flowing past the agent’) egocentric representation of boundary distance (imagery of motion in an imagined scene, not shown in [Figure 12](#fig12), however, see [Video 12](#video12)). Importantly, the imagined trajectory takes the agent through the area of space at which object three was encoded, however this time coming from a novel direction. The transformation circuit nevertheless instantiates the correct activity in the parietal window for object 3, making it appear to the agent’s right, instead of to it’s left (as during its original encoding, coming from object 2). Not only does the object populate the imagined scene as the agent mentally navigates past it, the event also generates an imagined representation which has never been experienced by the agent.

Translating an established BVC pattern due to updated perceptual input (in response to real motion) also translates the PC activity bump. In fact, this is how perceptual information updates the estimate of position (self-localization) in a familiar environment (PWb→RSC→BVC→PC) in the model. Similarly, shifting the activity pattern across PCs via GCs in mental navigation can update the parietal window (PWb) during mental navigation (GC→PC→BVC→RSC→PWb). With this account of mental exploration of different routes (including potentially novel imagined experiences; see next section), the model provides a neural implementation of important aspects of ‘scene construction’ ([Hassabis et al., 2007](#bib64)) and ‘episodic future thinking’ ([Schacter et al., 2007](#bib125)), although these concepts also extend beyond the capabilities of the model (see Discussion). The inclusion of GCs allows for a parsimonious account of mental navigation in humans, consistent with observation of grid-like activity during imagined movement through familiar environments ([Bellmund et al., 2016](#bib14); Horner et al. 2016).

![](https://iiif.elifesciences.org/lax/33752%2Felife-33752-fig12-v1.tif/full/1234,/0/default.webp)

Mental navigation with grid cells. Left to right: allocentric agent position (black triangle) and recent trajectory (black dashed line); PWo, OVC, and PC population snapshots; GC input to PCs (i.e. GC firing rates multiplied by … see more https://doi.org/10.7554/eLife.33752.026

It is a small step from imagined movement to planned navigation. GCs have been suggested to compute the vector to a goal location from the current location (see [Kubie and Fenton, 2012](#bib82); [Erdem and Hasselmo, 2012](#bib47); [Bush et al., 2015](#bib27); [Stemmler et al., 2015](#bib136)), a capability necessary to explain the ability to take a shortcut across previously unexplored territory ([Tolman, 1948](#bib144)). We propose that this ability is based on mental (vector-based) navigation supported by GCs. In Simulation 5, we let the agent explore a novel part of the environment, extending a pre-existing representation of a spatial context. Simulation 5.0 consists of three distinct phases: planning movement across a previously unvisited area to a reward location (phase 1); actual navigation of this shortcut (phase 2); and finally mental navigation across the now familiar area (phase 3).

In phase 1, the agent generates a trajectory along the shortest path to the goal using GCs (i.e. a straight line where the barriers happened to be in the way, [Figure 13B](#fig13)). However, unlike in Simulation 4.0 ([Figure 12](#fig12)), this process differs from mental navigation since the unexplored part of the environment is devoid of any meaningful PC-BVC connections and so a scene cannot be generated in the parietal window (PWb). Extending the medial temporal lobe (MTL) representations requires incorporating additional place cells into the MTL attractor. These (future) place cells are referred to as ‘reservoir cells’ and have no relationship to physical space yet, so visualizing their firing rates in a topographic manner is not possible. However, as the agent generates a trajectory towards its goal using GCs, sparse random GC-to-PC connections cause a subset of the reservoir cells to fire ([Figure 13B](#fig13) and [Video 13](#video13)). The activity of reservoir cells does not form an attractor bump, as PC-PC connections have not been learned, but their firing is normalised to a level of activity similar to when an attractor bump is present (implemented by an adaptive feedback current, see Appendix). In [Figure 13B](#fig13) (rightmost panel) reservoir cells are ordered according to their time of maximum firing along the imagined trajectory.

![](https://iiif.elifesciences.org/lax/33752%2Felife-33752-fig13-v1.tif/full/1234,/0/default.webp)

Planning, taking and imaging a trajectory across an unexplored area. The agent is located in an environment where the direct trajectory between two salient locations (purple dots, left column) covers an unexplored part of the environment. PCs potentially firing in … see more https://doi.org/10.7554/eLife.33752.027

![posterframe for video](https://iiif.elifesciences.org/lax/33752%2Felife-33752-video12.jpg/full/639,/0/default.jpg)

This video shows a visualization of the simulated neural activity as the agent performs a complex trajectory and encodes three objects into long-term memory along the way. Upon navigating past the third object the agent initiates recall, cueing with the first object, and subsequently performs mental navigation (imagined movement in visuo-spatial imagery) with the help … see more https://doi.org/10.7554/eLife.33752.028

![posterframe for video](https://iiif.elifesciences.org/lax/33752%2Felife-33752-video13.jpg/full/639,/0/default.jpg)

This video shows a visualization of the simulated neural activity as the agent performs mental navigation across a blocked shortcut. Newly recruited cells in the hippocampus exhibit activity reminiscent of preplay. Upon removal of the barrier the agent traverses the shortcut and associates the newly recruited hippocampal cells … see more https://doi.org/10.7554/eLife.33752.029

In phase 2, the barriers are removed and the agent performs the previously imagined trajectory in real space, using the novel shortcut. The same GCs are active along the trajectory and hence the same reservoir cells which fired before exploring the area, now fire in a spatial sequence along the actual trajectory. Since the agent is now actively perceiving its environment BVCs are driven in a bottom-up manner and Hebbian-like plasticity can strengthen connections between BVCs and reservoir cells as they fire along the trajectory (an analogous mechanism should also associate perirhinal neurons, which is omitted here). Hence, the reservoir cells have now effectively become place cells, with firing fields tied to the agent’s location in space ([Figure 13C](#fig13) and [Video 13](#video13)). [Figure 13C](#fig13) (rightmost panel) shows place cell activity along the trajectory during phase 2. Crucially, these cells are plotted in the order of activity shown during the previous imagined navigation ([Figure 13B](#fig13)), indicating ‘pre-play-like’ behavior, in that the sequence of PC firing seen prior to first exploration is subsequently recapitulated during actual navigation ([Figure 13C](#fig13); [Dragoi and Tonegawa, 2011](#bib39); [Ólafsdóttir et al., 2015](#bib167)).

Finally, in phase 3, the agent initiates imagery and performs mental navigation along the shortcut (i.e. recalls the episode of traversal), demonstrating that the MTL representation has been extended, and that a scene can be generated ([Figure 13D](#fig13) and [Video 13](#video13)). The newly learned connections from reservoir PCs to BVCs complete the MTL representation of the spatial context and the transformation circuit reinstates the corresponding parietal window (PWb) representation (imagery, [Figure 10D](#fig10), panel 2).

The ability to plan a route by driving a sweep of PC activity with a sweep of GC activity via established GC-PC connections ([Figures 12](#fig12) – [^7]) could relate to the observation of ‘forward sweeps’ of PC activity during navigation ([Johnson and Redish, 2007](#bib76); [Pfeiffer and Foster, 2015](#bib112)) and ‘replay’ during rest ([Wilson and McNaughton, 1994](#bib162); [Foster and Wilson, 2006](#bib51); [Diba and Buzsáki, 2007](#bib36); [Karlsson and Frank, 2009](#bib78); [Carr et al., 2011](#bib31)). However, both of these phenomena, and the ‘pre-play-like’ activity discussed above, occur at compressed timescales in experimental animals. Thus, modeling forward sweeps, replay or pre-play would require a spiking neuron model able to capture the faster time scale of the sharp-wave ripple events associated with replay and pre-play, and the theta sequences associated with forward sweeps ([Burgess et al., 1994](#bib25); [Skaggs et al., 1995](#bib129); [Gupta et al., 2012](#bib57)).

We propose a model of how sensory experiences, which are ultimately egocentric in nature, are transformed into viewpoint-invariant representations for long-term spatial memory in the medial temporal lobe (MTL) via processing in parietal and retrosplenial cortices. According to the model, imagery and recollection of scenes correspond to the re-construction of egocentric representations in parietal areas (the parietal window, PWb/o) from MTL representations. The MTL is the repository of viewpoint-invariant knowledge which is used to generate spatially coherent scenes by retrieving information consistent with perception from a single location and orientation. Pattern completion (via attractor dynamics) implements retrieval of a neural representation across the MTL, while head-direction cells enable the translation into egocentric coordinates via a retrosplenial transformation circuit, making use of gain-field neurons ([Snyder et al., 1998](#bib130); [Galletti et al., 1995](#bib53); [Pouget and Sejnowski, 1997](#bib116)). Thus, for example, unilateral lesions in parietal regions could cause perceptual hemispatial neglect, and unilateral lesions to parietal or retrosplenial cortex could cause representational hemispatial neglect (in imagery) for a scene for which the MTL representation is complete ([Bisiach and Luzzatti, 1978](#bib17); see also [Pouget and Sejnowski, 1997](#bib116); [Burgess et al., 2001a](#bib24); [Byrne et al., 2007](#bib30)).

The model can be used to account for human spatial cognition at the level of single neurons far from the sensory periphery: Place cells, head direction cells, gain-field neurons, boundary- and object-vector cells (BVCs and OVCs), and grid cells. Future work should try to integrate the present account of spatial cognition with recent progress concerning spatial coding in parietal areas ([Nitz, 2006](#bib100); [Nitz, 2009](#bib99); [Nitz, 2012](#bib101); [Harvey et al., 2012](#bib63); [Whitlock et al., 2012](#bib159); [Raposo et al., 2014](#bib117); [Vedder et al., 2017](#bib155)), and a broader view of retrosplenial function (e.g., [Alexander and Nitz, 2015](#bib4); [Alexander and Nitz, 2017](#bib5)). Notably, BVCs were predicted by an early predecessor of the present model ([Hartley et al., 2000](#bib62); [Burgess et al., 2001a](#bib24)). Here, we have introduced OVCs to show how items introduced into a familiar environment may be coded for and incorporated into long-term memory. Intriguingly, OVC-like responses have been reported recently ([Deshmukh and Knierim, 2013](#bib35); [Hoydal et al., 2017](#bib73)). We also explored how long-term memory might be probed to assess novelty. Finally, we incorporated grid cells and investigated their role in exploratory behavior and mental navigation. We can thus begin to frame abstract notions such as episodic future thinking and scene construction in terms of neural mechanisms, although we note that these concepts extend beyond our model to include completely fictional scenes/scenarios ([Burgess et al., 2001a](#bib24); [Hassabis et al., 2007](#bib64); [Schacter et al., 2007](#bib125)).

We have proposed that items/objects are associated to a given (spatial) context via place cells, which index the local sensory panorama, including local objects. Attaching representations of discrete objects (in the form of object vector cell activity) to a contextual representation via place cells aligns well with neuropsychological experiments that show position specificity in visual object memory ([Hollingworth, 2007](#bib71)). In such experiments, object memory is superior when the target object is presented at the same position in the scene as it had been viewed originally (also see object novelty Simulations 1.3, 1.4). The hippocampus in particular has been implicated in combining information about objects, locations, and contexts ([Warburton and Brown, 2010](#bib157); [Eacott and Gaffan, 2005](#bib42); [Barker and Warburton, 2015](#bib10)), consistent with the model. Similarly, studies suggest the hippocampus and precuneus are necessary for maintaining object-location binding even in working memory ([Piekema et al., 2006](#bib113); [Olson et al., 2006](#bib109)).

The direction-independence of place cell firing in open environments implies that all possible local views at a given location could be associated with the corresponding place cells, potentially encompassing the boundaries in all directions around that location. Only by supplying head (or gaze) direction, and transforming the activity to the parietal window, a specific point of view can be represented. Note that given the anatomical loci of head direction cells along Papez circuit, the role of head direction as a modulatory factor in the egocentric-allocentric transformation (modeled as within retrosplenial cortex) provides a good explanation for impaired episodic memory resulting from Papez circuit lesions ([Figure 7](#fig7); [Delay and Brion, 1969](#bib34); [Squire and Slater, 1978](#bib135); [^8]; [Parker and Gaffan, 1997](#bib111); [Aggleton et al., 2016](#bib3); [Tsivilis et al., 2008](#bib147)). It also explains why permanent landmarks should evoke stronger responses in retrosplenial cortex ([Auger et al., 2012](#bib9)), because permanent landmarks provide a more stable directional reference for the transformation circuit (see also [Bicanski and Burgess, 2016](#bib15)). In summary, head direction cells likely serve to specify a direction of view, and not a movement direction ([Raudies et al., 2015](#bib118)), which could instead be expressed in the firing phase of grid cells or place cells ([Maurer et al., 2014](#bib91); [Cei et al., 2014](#bib32)).

The encoding strategy for objects allows an agent to reactivate the set of place cells which were active when the object was encountered and thus reconstruct the local view at encoding in the parietal window. This models the explicit recollection of a spatial scene populated with objects as an act of visuo-spatial imagery. It provides an explanation for the neural activity seen in the MTL, retrosplenial cortex and precuneus during imagery for familiar scenes ([Burgess et al., 2001a](#bib24); [Hassabis et al., 2007](#bib64); [Schacter et al., 2007](#bib125)). The agent could also use the place cells activated during imagery as ‘goal cells’ and use grid cells to calculate a vector to navigate to the remembered location ([Bush et al., 2015](#bib27)); not simulated here), accounting for the role of the MTL in goal-directed navigation (e.g. reviewed in [Burgess et al., 2002](#bib23)).

The present model of explicit recall for items in context is a small step on the long road to understanding episodic memory at the neuronal level. However, not all memories for items requires reconstruction of a spatial scene. Recall of factual information (semantic memory) is not modeled, while memory for the attributes of an object irrespective of its context would require only perirhinal involvement. The BB-model only applies to imagery for coherent spatial scenes, and suggests that this is necessary for episodic recollection in which the past event is ‘re-experienced’ ([Tulving, 1983](#bib148)), and certainly for remembering the spatial context of encountering an object.

Key components of the model are the ‘bottom-up’ transition from egocentric perceptual representations to allocentric MTL representations and the ‘top-down’ transition from MTL representations back to egocentric imagery. By informing perception in a top-down manner, the MTL can effectively predict perceptual input in familiar environments, allowing novelty detection and enhancing perception with remembered information. If we view imagery as a top-down reconstruction of perceptual representations, the MTL together with the retrosplenial transformation circuit could be seen as a generative model for scenes, consistent with generative models of memory such as ([Káli and Dayan, 2001](#bib83)). It has been proposed that the bottom-up/top-down transition between encoding and retrieving occurs rhythmically at the frequency of the theta rhythm ([Hasselmo et al., 1996](#bib66); [Burgess et al., 2001a](#bib24); [Hasselmo et al., 2002](#bib65); [Byrne et al., 2007](#bib30); [Douchamps et al., 2013](#bib38)). Theta might underlie a periodic probing of memorized representations; however, full recollection in imagery can last for long periods of time and need not correspond to specific phases of theta in humans ([Düzel et al., 2010](#bib41)).

We have proposed ([Figure 10](#fig10)) that the relative strength of top-down and bottom-up connections can change smoothly and under control of the agent (e.g. via the release of a neuromodulator) to allow memory representations to influence neural activity during perception. This allows the agent to localize and attend to a region of space in the egocentric frame of reference where a given scene element used to be located, even if it has subsequently been moved, changed or removed. Moreover, the neural activity caused by increasing top-down connections can signal where the environment has changed. Interestingly, [Tsao et al. (2013)](#bib146) recently reported ‘trace cells’ in lateral entorhinal cortex, whose firing reflects the previous presence of a now missing object, while related ‘mis-place’ cells have been reported in CA1 ([O'Keefe, 1976](#bib107)).

We have shown that nominally non-spatially selective cells like perirhinal identity neurons can manifest a spatial trace firing field when re-activation occurs at the encoding location ([Figure 10D3](#fig10)). This may help to reconcile the notion that lateral entorhinal cortex processes non-spatial information ([Van Cauter et al., 2013](#bib151); [Hargreaves et al., 2005](#bib61)) with the spatial responses of trace cells ([Tsao et al., 2013](#bib146)) in lateral entorhinal cortex. However, the trace cells of [Tsao et al. (2013)](#bib146) do not fire when the object is present, but only in the subsequent absence of the object. Thus they might signal the mismatch between the remembered object and its absence, that is reflecting a comparison of perceptually driven and memory driven firing of the model perirhinal cells.

Finally, even in the absence of changes to the memorized spatial configuration, mnemonic representations can enhance perception, for example allowing the firing of cells coding for scene elements outside the current field of view. This activity is supported by pattern completion in the MTL, and may support people’s awareness of the presence of boundaries or objects outside of their field of view within a familiar environment.

Although we do not model the mechanistic origins of attention (see e.g. [Itti and Koch, 2001](#bib74)), attentional modulation in the present model is crucial for unambiguous representations of multiple objects within a scene. If multiple objects are encoded from the same viewpoint, multiple OVC and perirhinal (PRo) neurons can be co-active, precluding the formation of a unique representation for each object-location conjunction, that is, precluding the solving the object-location binding problem. Thus, we require the objects to be sampled rhythmically and encoded sequentially in the parietal window ([Figures 3](#fig3) and [^6]), consistent with experimental literature suggesting rhythmic and sequential sampling ([VanRullen et al., 2007](#bib153); [Landau and Fries, 2012](#bib85); for review see [VanRullen, 2013](#bib154)). If attentional cycles have a limited duration, then there may be insufficient time for activity to build up in the corresponding neuronal populations and support robust encoding into memory if there are too many objects within a scene, producing a capacity limit (see also [Lisman and Idiart, 1995](#bib88); [Bays and Husain, 2008](#bib13)).

The attentional modulation described above can also act in imagery (within the parietal window), allowing the agent to inspect different parts of an imagined scene (see also [Byrne et al., 2007](#bib30)). The model proposes that, in the absence of perceptual inputs, perirhinal neurons can be driven in a top-down fashion from hippocampus, thus reinstating an activity pattern in perirhinal cortex similar to the one present at encoding. Only the co-firing of these perirhinal neurons (PRo) and the corresponding BVCs and OVCs provides a unique representation of a given object in a given context, at a given location. The proposed binding of OVCs and PRo neurons, subject to attention, might also provide a functional interpretation of the hippocampus’ role in memory-guided attention (e.g., [Summerfield et al., 2006](#bib138)).

The model suggests a role for grid cell activity in human spatial cognition. Since both self-motion related inputs (via grid cells) and sensory inputs converge onto place cells, grid cells can update the point of view and allow an agent to translate its imagined location. If imagery can inform degraded perception (e.g. in the dark), obstacles can be identified and a suitable path can be planned. Thus, although mental navigation cannot be equated with path integration, we suggest that they reflect a common grid cell-dependent mechanism, which is required when sensory inputs are absent or unreliable. Indeed, humans likely make use of spatial imagery even in apparently non-visual tasks such as triangle completion in darkness ([Tcheang et al., 2011](#bib143)), and there is evidence for grid-like brain activity during mental navigation ([Bellmund et al., 2016](#bib14); Horner et al. 2016).

The model of mental navigation provides a mechanistic neural-level account of some aspects of ‘scene construction’ and ‘episodic future thinking’ ([Schacter et al., 2007](#bib125); [Hassabis et al., 2007](#bib64); [Buckner, 2010](#bib19)) with regard to familiar spaces. Mental navigation allows an agent to test future behavior, like the approach of a target from a new direction as depicted in [Video 12](#video12). This suggests that the same neural infrastructure involved in scene perception and reconstruction also subserves planning and hypothesis testing (e.g. asking ‘Which way should I go?’ or ‘What would I encounter if I went that way?’). If grid cells (acting on place cells) change the point of view during imagined movement this must be reconciled with the relationships between grid cells and place cells seen during periods of rest or planning (see e.g., [Ólafsdóttir et al., 2016](#bib168); [O'Neill et al., 2017](#bib108); [Trettel et al., 2017](#bib145); [Buzsáki and Chrobak, 1995](#bib29)).

Grid cells have been proposed to support the computation of vectors to a goal ([Kubie and Fenton, 2012](#bib82); [Erdem and Hasselmo, 2012](#bib47); [Bush et al., 2015](#bib27); [Stemmler et al., 2015](#bib136)). That is, they can plan trajectories across known and potentially unknown terrain (shortcuts). We proposed that grid cells recruit new hippocampal cells (future place cells) in previously unexplored parts of a familiar environment ([Figure 13](#fig13) and [Video 13](#video13)). Planning a trajectory across unexplored space engenders preplay-like activity in place cells ([Dragoi and Tonegawa, 2011](#bib39); [Ólafsdóttir et al., 2015](#bib167)), whereas mental navigation is reminiscent of ‘replay’ ([Wilson and McNaughton, 1994](#bib162); [Foster and Wilson, 2006](#bib51); [Diba and Buzsáki, 2007](#bib36); [Karlsson and Frank, 2009](#bib78); [Carr et al., 2011](#bib31)) or ‘forward sweeps ([Johnson and Redish, 2007](#bib76); [Pfeiffer and Foster, 2015](#bib112)), although the faster propagation speed (e.g. during sharp wave ripples) of these sequences of place cell activity are beyond the scope of the present model. Nevertheless, the model suggests that sweeps of activity in the grid cell population may play are role in these aspects of place cell firing, and could correspond to route planning ([Kubie and Fenton, 2012](#bib82); [Erdem and Hasselmo, 2012](#bib47); [Bush et al., 2015](#bib27); [Yamamoto and Tonegawa, 2017](#bib165)).

It has been argued that the MTL-retrosplenial-parietal system supports the construction of coherent scenes ([Burgess et al., 2001b](#bib22); [Byrne et al., 2007](#bib30); [Hassabis et al., 2007](#bib64); [Schacter et al., 2007](#bib125); [Buckner, 2010](#bib19)). However, if recollection corresponds to the (re-)construction of something akin to a perceptual experience (the defining characteristic of episodic memory; Tulving 1985), then this places strong spatial constraints on how episodic memory works. A vast number of different combinations of information could be retrieved from the body of long-term knowledge in the MTL, but only a small subset would be consistent with a single point of view, making the episodic ‘re-experiencing’ of events or visuo-spatial imagery congruent with perceptual experiences. The BB-model combines this insight with established knowledge and new hypotheses about how location, orientation, and surrounding environmental features are associated and represented by neural population activity.

This account includes functional roles for the specific firing characteristics of diverse populations of spatially selective cells across multiple brain regions, and distinguishes the egocentric representations supporting conscious (re-)experience from the more abstract (allocentric) representations involved in supporting computations. The resultant systems-level account provides a strong conceptual framework for considering the interplay between structures in the MTL, retrosplenial cortex, Papez circuit’ and parietal cortex in support of spatial memory. It follows Tulving’s theoretical specification of episodic memory, and - spanning Marr’s theoretical, algorithmic and implementational levels ([Marr and Poggio, 1976](#bib90)) - bridges the gap between a neuropsychological description of spatial cognition (founded on behavioral and functional imaging data) and the neural representations supporting it.

All neuron populations in the BB-model, with the exception of for grid cells, are composed of rate-coded neurons and implemented according to the following equations.

(1) 
$$
x_{i}^{t + 1} = x_{i}^{t} + \frac{d t}{\tau} k_{i}^{t}
$$

(2) 
$$
r_{i}^{t + 1} = \frac{1}{1 + e x p \left(- 2 \beta_{i} \left(x_{i}^{t + 1} - \alpha_{i}\right)\right)}
$$

Where ***x*** is the vector of activations ([Equation 1](#equ1), vectors/matrices displayed in bold) for all neurons belonging to the population marked by the subscript *i* (e.g. PCs, BVC, etc.). Within a population all neurons are identical. The superscript indicates the temporal dimension, with t + 1 referring to the updated state variable for the next time step (step size *dt*). *τ* is the decay time-constant of the rate equation. The sigmoid with parameters *α*, *β* ([Equation 2](#equ2)) serves as a non-linearity to map activations onto firing rates. The term ***k <sub>i</sub>*** in [Equation 1](#equ1) contains all population specific inputs. [Equations 3](#equ3) through 13 summarize the inputs to the model populations.

(3) 
$$
\begin{aligned}
k_{P C} & = - x_{P C} + \varphi_{P C , P C} W_{P C , P C} r_{P C} + P_{m o d} \varphi_{B V C , P C} W_{B V C , P C} r_{B V C} \\ + \varphi_{P R b , P C} W_{P R b , P C} r_{P R b} + \varphi_{O V C , P C} W_{O V C , P C} r_{O V C} \\ + I_{m o d} \varphi_{P R o , P C} W_{P R o , P C} r_{P R o} + \varphi_{G C , P C} W_{G C , P C} r_{G C} + I_{F B}
\end{aligned}
$$

Here (and below) ***W <sub>i,j</sub>*** is the matrix of connection weights from population *i* to *j*, *φ <sub>i,j</sub>* is a gain factor, and ***r <sub>j</sub>*** refers to the vector of firing rates of population *j. I <sub>FB</sub>* is a feedback current ensuring a set total of activity in the place cell sheet (numerical value 15). *I <sub>mod</sub>* and *P <sub>mod</sub>* refer to neuromodulation for bottom-up vs top-down modes of operation, and the mode is set determined externally. that is setting these values according to behavioural needs of the agent (perception vs imagery/recollection) implements the switch between bottom-up and top-down modes. *P <sub>mod</sub>* is one in bottom-up mode of operation and 0.05 in top-down mode. *I <sub>mod</sub>* is 0.05 in bottom-up mode of operation and one in top-down mode. Abbreviations: PC; place cells, BVC; boundary vector cells, OVC; object vector cells; PRb; boundary selective perirhinal neurons, PRo; object selective perirhinal neurons, PW; parietal window neurons, TR; transformation circuit neurons, HDC; head direction cells, GC; grid cells.

(4) 
$$
\begin{aligned}
k_{B V C} & = - x_{B V C} + B I_{m o d} \varphi_{P C , B V C} W_{P C , B V C} r_{P C} + \varphi_{B V C , P C} W_{B V C , P C} r_{B V C} \\ + \varphi_{P R b , B V C} W_{P R b , B V C} r_{P R b} + B^{- 1} P_{m o d} \varphi_{T R b , B V C} W_{T R , B V C} r_{T R b_{i}}
\end{aligned}
$$

(5) 
$$
\begin{aligned}
k_{O V C} & = - x_{O V C} + \varphi_{O V C , O V C} W_{O V C , O V C} r_{O V C} + B I_{m o d} \varphi_{P C , O V C} W_{P C , O V C} r_{P C} \\ + B I_{m o d} \varphi_{P R o , O V C} W_{P R o , O V C} r_{P R o} + B^{- 1} P_{m o d} \varphi_{T R o , O V C} W_{T R , B V C} r_{T R o_{i}}
\end{aligned}
$$

B is the ‘bleed’ parameter for a smooth modulation of bottom-up vs top-down connectivity, during perception (simulations 2.1, 2.2). Sums over transformation sublayers run from 1 to 20, the number of distinct sublayers (see description of transformation circuit in main text and below).

(6) 
$$
k_{P R b} = - x_{P R b} + I_{m o d} \varphi_{P C , P R b} W_{P C , P R b} r_{P C} + \varphi_{B V C , P R b} W_{B V C , P R b} r_{B V C} + I_{P R b}
$$

(7) 
$$
\begin{aligned}
k_{P R o} & = - x_{P R o} + \varphi_{P R o , P R o} W_{P R o , P R o} r_{P R o} + \varphi_{P C , P R o} W_{P C , P R o} r_{P C} \\ + \varphi_{O V C , P R o} W_{O V C , P R o} r_{O V C} + I_{P R o} + I_{c u e}
\end{aligned}
$$

*I <sub>cue</sub>* is an externally supplied (i.e. not causally determined by other model components) trigger current to initiate recall in imagery.

*I <sub>PRo</sub>* and *I <sub>PRb</sub>* are externally supplied inputs to perirhinal identity neurons that represent the result of a recognition process along the ventral visual stream which is not explicitly modelled, and both inputs are only present in bottom-mode (i.e. during perception). *I <sub>PRo</sub>* is binary (object attended and present vs not attended/not present), while the magnitude of *I <sub>PRb</sub>* depends linearly on the extent of the boundary that is visible and its distance to the agent.

(8) 
$$
\begin{aligned}
k_{P W b} & = - x_{P W b} - P W b_{b a t h} \sum r_{P W b} + B^{- 1} I_{P W b}^{a g e n t} \\ + B I_{m o d} \varphi_{T R , P W b} W_{T R , P W b_{i}} r_{T R_{i}}
\end{aligned}
$$

(9) 
$$
\begin{aligned}
k_{P W o} & = - x_{P W o} - P W o_{b a t h} \sum r_{P W o} + B^{- 1} I_{P W o}^{a g e n t} \\ + B I_{m o d} \varphi_{T R , P W o} W_{T R , P W o_{i}} r_{T R_{i}}
\end{aligned}
$$

*PWb/o <sub>bath</sub>* is an inhibitory input based on the total activity in the PWb/o population (sum of the population vector in [Equations 8 and 9)](#equ8). I <sub>PWb/o</sub> <sup>agent</sup> refers to the sensory/perceptual inputs to the PWb/o populations. That is, these input currents are generated in response to the presence of boundaries/objects in the field of view in order to be injected into the corresponding populations.

(10) 
$$
r_{I P} = \left(1 + e x p \left(- 2 \beta_{I P} \left(\varphi_{H D , I P} \sum r_{H D} - \alpha_{I P}\right)\right)\right)^{- 1}
$$

connects onto the different sublayers of the transformation circuit (small hexagon in [Figure 4](#fig4)), ensuring suppression of activity in all sublayers except where the positive modulatory input from HDCs ensures that inhibition is overcome.

(11) 
$$
\begin{aligned}
k_{T R b}^{i} & = - x_{T R b}^{i} - T R b_{b a t h} \sum r_{T R b}^{i} + \varphi_{H D , T R b} W_{H D , T R b}^{i} r_{H D} \\ + \varphi_{I P , T R b} r_{I P} + I_{m o d} \varphi_{B V C , T R b} W_{B V C , T R b} r_{B V C} + \\ B^{- 1} P_{m o d} \varphi_{P W b , T R} W_{P W b , T R}^{i} r_{P W b} f o r i \epsilon \left\{1 , \cdots 20\right\}
\end{aligned}
$$

(12) 
$$
\begin{aligned}
k_{T R o}^{i} & = - x_{T R o}^{i} - T R o_{b a t h} \sum r_{T R o}^{i} + \varphi_{H D , T R o} W_{H D , T R o}^{i} r_{H D} \\ + \varphi_{I P , T R o} r_{I P} + I_{m o d} \varphi_{O V C , T R o} W_{O V C , T R o} r_{O V C} + \\ B^{- 1} P_{m o d} \varphi_{P W o , T R o} W_{P W o , T R o}^{i} r_{P W o} f o r i \epsilon \left\{1 , \cdots 20\right\}
\end{aligned}
$$

The superscript *i* in [Equations 11 and 12](#equ11) refers to the individual sublayers of the retrosplenial transformation circuit (*i* ranging from 1 to 20). For convenience and in order to visualize object (item) and boundary (contextual) related representations separately the transformation is applied separately to the PWb/o representations but the same connectivity is used. TRb/o <sub>bath</sub> are analogous to *PWb/o <sub>bath</sub>*.

(13) 
$$
\begin{aligned}
k_{H D} & = - x_{H D} + \varphi_{H D , H D} W_{H D , H D} r_{H D} + I_{c u e} \varphi_{P R o , H D} W_{P R o , H D} r_{P R o} \\ + \varphi_{r o t} c w W_{r o t} r_{H D} + \varphi_{r o t} c c w W_{r o t}^{'} r_{H D}
\end{aligned}
$$

*cw* and *ccw* in [Equation 13](#equ13) are 0 or 1 depending on whether on the agent is performing a clockwise or counterclockwise turn, respectively. The scaling factor *φ <sub>rot</sub>* is set to ensure a match between the agent’s rotations speed and the translation of the activity packet in the head direction ring attractor.

The firing rate dynamics of GCs are not modelled. GCs exist as firing rate maps which span the environment. GC rates are sampled from these rate maps by looking up the pixel value closest to the agent’s location. See section Grid cell rate maps, mental navigation, and preplay setup for the generation of the grid maps.

See [Appendix 1—table 1](#app1table1) for population sizes.

###### Model Parameters.

Top to bottom: *α*, *β* sigmoid parameters; *φ* connection gains; Φ constants subtracted from given weight matrices (e.g. PC to PC connections) to yield global inhibition; bath parameters; range … see more

[https://doi.org/10.7554/eLife.33752.032](https://doi.org/10.7554/eLife.33752.032)

| α | 5 |
| --- | --- |
| β | 0.1 |
| α <sub>IP</sub> | 50 |
| β <sub>IP</sub> | 0.1 |
| φ <sub>PWb-TR</sub> | 50 |
| φ <sub>TR-PWb</sub> | 35 |
| φ <sub>TR-BVC</sub> | 30 |
| φ <sub>BVC-TR</sub> | 45 |
| φ <sub>HD-HD</sub> | 15 |
| φ <sub>HD-IP</sub> | 10 |
| φ <sub>HD-TR</sub> | 15 |
| φ <sub>HDrot</sub> | 2 |
| φ <sub>IP-TR</sub> | 90 |
| φ <sub>PC-PC</sub> | 25 |
| φ <sub>PC-BVC</sub> | 1100 |
| φ <sub>PC-PRb</sub> | 6000 |
| φ <sub>BVC-PC</sub> | 440 |
| φ <sub>BVC-PRb</sub> | 75 |
| φ <sub>PRb-PC</sub> | 25 |
| φ <sub>PRb-BVC</sub> | 1 |
| φ <sub>GC-PC</sub> | 3 |
| φ <sub>PWo-TR</sub> | 60 |
| φ <sub>TR-PWo</sub> | 30 |
| φ <sub>TR-OVC</sub> | 60 |
| φ <sub>OVC-TR</sub> | 30 |
| φ <sub>PC-OVC</sub> | 1.7 |
| φ <sub>PRo-OVC</sub> | 6 |
| φ <sub>PC-PRo</sub> | 1 |
| φ <sub>OVC-PC</sub> | 5 |
| φ <sub>OVC-oPR</sub> | 5 |
| φ <sub>PRo-PC</sub> | 100 |
| φ <sub>PRo-PRo</sub> | 115 |
| φ <sub>inh-PC</sub> | 0.4 |
| φ <sub>inh-BVC</sub> | 0.2 |
| φ <sub>inh-PRb</sub> | 9 |
| φ <sub>inh-PRo</sub> | 1 |
| φ <sub>inh-HD</sub> | 0.4 |
| φ <sub>inh-TR</sub> | 0.075 |
| φ <sub>inh-TRo</sub> | 0.1 |
| φ <sub>inh-PW</sub> | 0.1 |
| φ <sub>inh-OVC</sub> | 0.5 |
| φ <sub>inh-PWo</sub> | 1 |
| Φ <sub>PC-PC</sub> | 0.4 |
| Φ <sub>BVC-BVC</sub> | 0.2 |
| Φ <sub>PR-PR</sub> | 9 |
| Φ <sub>HD-HD</sub> | 0.4 |
| Φ <sub>OVC-OVC</sub> | 0.5 |
| Φ <sub>PRo-PRo</sub> | 01 |
| PW <sub>bath</sub> | 0.1 |
| PW <sub>bath</sub> | 0.2 |
| TR <sub>bath</sub> | 0.088 |
| Object enc. threshold | 18 cm |
| Object enc. Threshold (3.1) | 36 cm |
| *l <sub>GC-resPC</sub>* | 0.65\*10^−5 |
| *l <sub>resPC-BVC</sub>* | 0.65\*10^−5 |
| *l <sub>BVC-resPC</sub>* | 0.65\*10^−5 |
| *S <sub>GC-resPC</sub>* | 3% |
| *S <sub>resPC-resPC</sub>* | 6% |
| *σ <sub>ρ</sub>* | (r + 8) \* *σ <sub>0</sub>* |
| *σ <sub>0</sub>* | 0.08 |
| *σ <sub>ϑ</sub>* | 0.2236 |
| *N <sub>PC</sub>* | 44 × 44 |
| *N <sub>BVC</sub>* | 16 × 51 |
| *N <sub>TRb/o</sub>* | 20 × 16×51 |
| *N <sub>OVC</sub>* | 16 × 51 |
| *N <sub>PRb/o</sub>* | Dependent on simulation environment |
| *N <sub>PWb/o</sub>* | 16 × 51 |
| *N <sub>IP</sub>* | 1 |
| *N <sub>HD</sub>* | 100 |
| *N <sub>GC</sub>* | 100 per module |
| *N <sub>reservoir</sub>* | 437 |

In the training phase for the contextual representation (see section Connection Profiles) BVC and PWb neurons have activation functions of the following type. If a boundary segment is located at the coordinates (ρ*,ϑ)*, then the activity of each boundary selective cell is proportional to the distance of its receptive field from that boundary segment. If *(ρ <sub>i</sub>, ϑ <sub>i</sub>)* are the polar coordinates of the receptive field of the i-th BVC or PWb neuron, then the firing rate *r* is calculated according to the following equation:

(14) 
$$
r_{B V C}^{i} = \frac{1}{\rho} e x p \left(- \left(\frac{\theta_{i}^{a} - \theta^{a}}{\sigma_{\theta}}\right)^{2}\right) e x p \left(- \left(\frac{\rho_{i} - \rho}{\sigma_{\rho}}\right)^{2}\right)
$$

where *σ <sub>ϑ</sub>* and *σ <sub>ρ</sub>* define the spatial dispersion of the rate function *r*. The radial dispersion increases with distance (i.e. *σ <sub>ρ</sub>* is a function of the radius; see e.g. Barry and Burgess 2007).

The radial separation of distance bins (see [Figure 2A2](#fig2)) increases linearly from 0.21 to 1.71 along the radius of length 16 distance units (corresponding to approx. 145 cm for the 2 × 2 m environment). Internal to the model a distance unit is given by 2/ *N <sub>PC</sub>* (see place cell resolution below). The same function is used to calculate the perceptual input to the parietal window due to objects and boundaries during simulation and to calculate activations of parietal window neurons and retrosplenial cells during the setup of the transformation circuit (see below). The receptive fields of BVCs, OVCs, PWb, PWo neurons and retrosplenial cells tile the space in polar coordinates with a radial resolution of 1 receptive fields per arbitrary distance unit (range: 0–16, see above) and an angular resolution of 51 receptive fields over 2π radians.

Similarly, to set up the PC weights in the training phase PC rates are calculated via the following equation:

(15) 
$$
r_{P C}^{i} = e x p \left(\frac{\left(x^{i} - x\right)^{2} \left(+ \left(y^{i} - y\right)\right)^{2}}{0.5^{2}}\right)
$$

where (*x,y*) is the location of the agent and (*x <sub>i</sub>,y <sub>i</sub>*) the location of the receptive field of the PC in question. The firing fields of PCs tile the environment in a Cartesian grid with resolution 0.5 (i.e. two PCs per arbitrary distance unit). However, note that during simulations PCs are never driven by this activation function. Only BVCs, PR neurons and GCs drive PCs during simulation, unlike PWb/o neurons which must receive sensory/perceptual inputs in bottom-up mode.

The encoding procedure (section Bottom-up vs top-down modes of operation) describes how object related connections are learned. The contextual representation of BVC, PC and PRb neurons, as well as the connections to and from the transformation circuit are set up in a training phase prior to running any simulations. To set up the transformation circuit randomly oriented boundary segments are chosen (20.000 times per transformation sublayer for a total of 400.000 instances), and the corresponding firing rates (calculated according to [Equation 14](#equ14)) for PWb neurons and the transformation circuit sublayers are instantiated. For each transformation circuit sublayer the randomly generated activity pattern is rotated by a different angle (rotation angle chosen from 20 evenly spaced head directions). Connection weights are then calculated as outer products of the population vectors, yielding a matrix of Hebbian-like associations between the populations. The connections from the retrosplenial transformation circuit to BVCs are one-to-one connections between BVCs and the cells in each of the 20 transformation sublayers (i.e. the connections are given by the identity matrix) since this connection only needs to convey the outcome of the gain modulation across the RSC sublayers. That is, rotations of activity patterns occur on the connection to and from the parietal window. [Video 1](#video1) shows all sublayers of the transformation circuit, subject to gain modulation from HDCs as a simulated agent navigates a simple environment, see also [Figure 2—figure supplement 1](https://elifesciences.org/articles/33752/figures#fig2s1). The entire transformation of egocentric boundary inputs to BVCs effectively constitutes a model of BVC generation from sensory inputs. Finally, connections between HDCs and the 20 transformation circuit sublayers are calculated algorithmically, by associating each sublayer with one of 20 evenly spaced HD activity bumps on the head direction ring.

With a functioning transformation circuit, and after specifying the location and extent of extended boundaries in the environment, the agent is placed at a random location and orientation in the environment and the activations of BVCs and PCs are calculated via [equations 14 and 15](#equ14). PRb activations are instantiated based on the identity of the visible landmark segments. Connection weights between these three populations (supporting the contextual representation) are again calculated as outer products of the corresponding population vectors, yielding matrices of Hebbian-like associations between the populations.

Weights are normalized such that the sum total of weights converging on a given target neuron is 1, which is assumed to be the result of some homeostatic process, a widely agreed upon feature of synaptic plasticity ([Keck et al., 2017](#bib79)). Weights are scaled by scalar gain factors *φ <sub>i</sub>* (see [Appendix 1—table 1](#app1table1)) to produce appropriate responses in targets of afferent connections.

Grid cells are implemented as firing rate maps. Each map consists of a matrix of the same dimensions as the PC sheet (44 × 44 pixels) and is computed as 60 degrees offset, superimposed cosine waves using the following set of equations.

(16) 
$$
b_{0} = \begin{pmatrix} c o s \left(0\right) \\ s i n \left(0\right) \end{pmatrix} b_{1} = \begin{pmatrix} c o s \left(\frac{\pi}{3}\right) \\ s i n \left(\frac{\pi}{3}\right) \end{pmatrix} b_{2} = \begin{pmatrix} c o s \left(\frac{2 \pi}{3}\right) \\ s i n \left(\frac{2 \pi}{3}\right) \end{pmatrix}
$$

(17) 
$$
z_{i} = R_{j} b_{i} \left(F \overset{\rightarrow}{x} + \overset{\rightarrow}{x}_{o f f s e t}\right)
$$

(18) 
$$
r_{G C} = m a x \left(0 , c o s \left(z_{0}\right) + c o s \left(z_{1}\right) + c o s \left(z_{2}\right)\right)
$$

Here *b <sub>0</sub>*, *b <sub>1</sub>* and *b <sub>2</sub>* are the normal vectors for the cosine waves. *Rj* is the standard 2D rotation matrix where the index j ranges from 1 to 7 and refers to the rotation angle of the matrix (7 random orientations for 7 grid modules, here 0, π/3, π/4, π/2, π/6, 1.2π, 1.7π). *F* is the frequency of the grids, starting at 0.0028\*2π. The scales of successive grids are related by the scaling factor $\sqrt{2}$ (Stensola et al. 2012). For each grid scale offsets are sampled uniformly along the principle axes of two adjacent equilateral triangles on the grid (i.e. the rhomboid made of 4 grid vertices).

Motion through GC maps (i.e. a GC sweep) during mental navigation and preplay is implemented by sampling the GC rate along the imagined trajectory superimposed on the GC rate map. The firing rate value (i.e. the pixel of the rate map) is determined by rounding the x and y values of the imagined trajectory to the nearest integer value. This sampling is equivalent to a shift of a hexagonal pattern of activation on a 2D sheet of entorhinal cells, as suggested in mechanistic models of grid cells ([Burak and Fiete, 2009](#bib20)).

For simulation 5.0 (planning; [Video 13](#video13) and [Figure 13](#fig13)) the reservoir place cells are supplied with random afferent connections from grid cells (sparseness 3%), and are also randomly interconnected amongst themselves (sparseness 6%). Place cells representing the familiar context and reservoir PCs inhibit each other (inhibitory connections 50% stronger than the default inhibition among place cells representing the context). Weights among reservoir place cells are normalized to the mean of the total amount of positive weights converging onto a typical place cell representing the familiar context. Grid cell weights to reservoir place cells are similarly normalized (80% stronger than default). These additions suffice to produce random, preplay-like activity in reservoir place cells as soon as the central peak of the grid cell ensemble begins to drive the reservoir. The inhibitory connections to and from the context network assure that either the reservoir place cells or the context network wins out. No changes to the adaptive feedback current are necessary (*I <sub>FB</sub>* in [Equation 3](#equ3)). Finally, during preplay connections from BVCs and perirhinal neurons to place cells are turned off to avoid interference which can arise due to the very simple layout of the environment (many boundary configurations experienced by the agent are similar). No other changes to the default model are necessary. To visualize the spatio-temporal sequence of the firing of reservoir place cells during the three phases of simulation 5.0 (planning, perception, recall; see main text) the firing of reservoir cells is recorded along the imagined or real trajectory, and stacked (rightmost panels in [Figure 13](#fig13)) to yield figures akin to typical preplay/replay experiments. The firing rates are normalized and thresholded at 10% of the maximum firing rate for clarity. That is, cells that do not fire, or fire at very low rates are not shown. Due to learning during the actual traversal of the novel part of the environment (phase 2, perception) some cells can increase their firing rate above the threshold. As a consequence the number of cells which is plotted in the stacked rate maps grows marginally between phase 1 (preplay) and phase 2. However, ordering PCs in phases 2 and 3 according to the sequence derived from the preplay is done before thresholding. Hence the correct order derived from phase 1 (preplay) is applied to the cells recorded in phases 2 and 3.

To ensure an unambiguous representation of an object at a given location (see main text) we implement a heuristic model of directed attention. A fixed length for an attentional cycle (600 ms) is allocated and divided by the number of visible objects, yielding a time per object *t <sub>O</sub>*. The PWo population is then driven for *t <sub>O</sub>* ms with the cueing current $I_{P W o}^{a g e n t}$ (see [Equation 9](#equ9)) for each visible object in sequence.

The agent moves in straight lines within the environment, following a path defined by a list of coordinates. Upon reaching a target the rotation towards the next subgoal is performed, followed by the next segment of translation. The rotational velocity is implicitly given by a fixed offset of the translation weights for the HD ring attractor (approximately 18 degrees; see e.g. [Zhang, 1996](#bib166); [Song and Wang, 2005](#bib133); [Bicanski and Burgess, 2016](#bib15) for more sophisticated methods of integrating rotational velocity). Translational velocity is fixed at 25 cm per second.

The agent model is agnostic about the size of the arena and nature of the agent. It can be viewed as rodent like agent or alternatively a human-like agent. The environment is covered by 44 × 44 PCs. that is 1/44 of the length/width of the environment corresponds to one distance unit. Assuming a timestep of e.g. 1ms and an arena size of approximately 2 × 2 m <sup>2</sup> for a rodent-like agent yields a translation speed of approximately 10 cm/s. Assuming a human-like agent in an environment of approximately 10 × 10 m <sup>2</sup> yields a translation speed of approximately 56 cm/s, corresponding to a slow paced walk for a human subject. In either case the speed is orders of magnitude below the time scale of neural rate dynamics.

Matlab code to build all model components and run all simulations will be made available on GitHub in the following repository: [https://github.com/bicanski/HBPcollab/tree/master/SpatialEpisodicMemoryModel](https://github.com/bicanski/HBPcollab/tree/master/SpatialEpisodicMemoryModel); copy archived at [https://github.com/elifesciences-publications/HBPcollab/tree/master/SpatialEpisodicMemoryModel](https://github.com/elifesciences-publications/HBPcollab/tree/master/SpatialEpisodicMemoryModel).

1. 1. [Aggleton JP](https://scholar.google.com/scholar?q=%22author:Aggleton+JP%22)
	2. [Brown MW](https://scholar.google.com/scholar?q=%22author:Brown+MW%22)
	(1999) [Episodic memory, amnesia, and the hippocampal-anterior thalamic Axis](https://doi.org/10.1017/S0140525X99002034)
	*Behavioral and Brain Sciences* **22**:425–444.
	[https://doi.org/10.1017/S0140525X99002034](https://doi.org/10.1017/S0140525X99002034)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/11301518)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Episodic+memory%2C+amnesia%2C+and+the+hippocampal-anterior+thalamic+Axis&author=Aggleton+JP&author=Brown+MW&publication_year=1999&journal=Behavioral+and+Brain+Sciences&volume=22&pages=pp.+425%E2%80%93444&pmid=11301518)
2. 1. [Aggleton JP](https://scholar.google.com/scholar?q=%22author:Aggleton+JP%22)
	2. [Pralus A](https://scholar.google.com/scholar?q=%22author:Pralus+A%22)
	3. [Nelson AJ](https://scholar.google.com/scholar?q=%22author:Nelson+AJ%22)
	4. [Hornberger M](https://scholar.google.com/scholar?q=%22author:Hornberger+M%22)
	(2016) [Thalamic pathology and memory loss in early Alzheimer's disease: moving the focus from the medial temporal lobe to Papez circuit](https://doi.org/10.1093/brain/aww083)
	*Brain* **139**:1877–1890.
	[https://doi.org/10.1093/brain/aww083](https://doi.org/10.1093/brain/aww083)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/27190025)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Thalamic+pathology+and+memory+loss+in+early+Alzheimer%27s+disease%3A+moving+the+focus+from+the+medial+temporal+lobe+to+Papez+circuit&author=Aggleton+JP&author=Pralus+A&author%5B2%5D=Nelson+AJ&author%5B3%5D=Hornberger+M&publication_year=2016&journal=Brain&volume=139&pages=pp.+1877%E2%80%931890&pmid=27190025)
3. 1. [Alexander AS](https://scholar.google.com/scholar?q=%22author:Alexander+AS%22)
	2. [Nitz DA](https://scholar.google.com/scholar?q=%22author:Nitz+DA%22)
	(2015) [Retrosplenial cortex maps the conjunction of internal and external spaces](https://doi.org/10.1038/nn.4058)
	*Nature Neuroscience* **18**:1143–1151.
	[https://doi.org/10.1038/nn.4058](https://doi.org/10.1038/nn.4058)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/26147532)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Retrosplenial+cortex+maps+the+conjunction+of+internal+and+external+spaces&author=Alexander+AS&author=Nitz+DA&publication_year=2015&journal=Nature+Neuroscience&volume=18&pages=pp.+1143%E2%80%931151&pmid=26147532)
4. 1. [Alexander AS](https://scholar.google.com/scholar?q=%22author:Alexander+AS%22)
	2. [Nitz DA](https://scholar.google.com/scholar?q=%22author:Nitz+DA%22)
	(2017) [Spatially periodic activation patterns of retrosplenial cortex encode route Sub-spaces and distance traveled](https://doi.org/10.1016/j.cub.2017.04.036)
	*Current Biology* **27**:1551–1560.
	[https://doi.org/10.1016/j.cub.2017.04.036](https://doi.org/10.1016/j.cub.2017.04.036)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/28528904)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Spatially+periodic+activation+patterns+of+retrosplenial+cortex+encode+route+Sub-spaces+and+distance+traveled&author=Alexander+AS&author=Nitz+DA&publication_year=2017&journal=Current+Biology&volume=27&pages=pp.+1551%E2%80%931560&pmid=28528904)
5. 1. [Anderson MI](https://scholar.google.com/scholar?q=%22author:Anderson+MI%22)
	2. [Jeffery KJ](https://scholar.google.com/scholar?q=%22author:Jeffery+KJ%22)
	(2003) [Heterogeneous modulation of place cell firing by changes in context](https://doi.org/10.1523/JNEUROSCI.23-26-08827.2003)
	*The Journal of Neuroscience* **23**:8827–8835.
	[https://doi.org/10.1523/JNEUROSCI.23-26-08827.2003](https://doi.org/10.1523/JNEUROSCI.23-26-08827.2003)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/14523083)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Heterogeneous+modulation+of+place+cell+firing+by+changes+in+context&author=Anderson+MI&author=Jeffery+KJ&publication_year=2003&journal=The+Journal+of+Neuroscience&volume=23&pages=pp.+8827%E2%80%938835&pmid=14523083)
6. 1. [Atance CM](https://scholar.google.com/scholar?q=%22author:Atance+CM%22)
	2. [O'Neill DK](https://scholar.google.com/scholar?q=%22author:O%27Neill+DK%22)
	(2001) [Episodic future thinking](https://doi.org/10.1016/S1364-6613\(00\)01804-0)
	*Trends in Cognitive Sciences* **5**:533–539.
	[https://doi.org/10.1016/S1364-6613(00)01804-0](https://doi.org/10.1016/S1364-6613\(00\)01804-0)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/11728911)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Episodic+future+thinking&author=Atance+CM&author=O%27Neill+DK&publication_year=2001&journal=Trends+in+Cognitive+Sciences&volume=5&pages=pp.+533%E2%80%93539&pmid=11728911)
7. 1. [Auger SD](https://scholar.google.com/scholar?q=%22author:Auger+SD%22)
	2. [Maguire EA](https://scholar.google.com/scholar?q=%22author:Maguire+EA%22)
	(2013) [Assessing the mechanism of response in the retrosplenial cortex of good and poor navigators](https://doi.org/10.1016/j.cortex.2013.08.002)
	*Cortex* **49**:2904–2913.
	[https://doi.org/10.1016/j.cortex.2013.08.002](https://doi.org/10.1016/j.cortex.2013.08.002)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/24012136)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Assessing+the+mechanism+of+response+in+the+retrosplenial+cortex+of+good+and+poor+navigators&author=Auger+SD&author=Maguire+EA&publication_year=2013&journal=Cortex&volume=49&pages=pp.+2904%E2%80%932913&pmid=24012136)
8. 1. [Barker GR](https://scholar.google.com/scholar?q=%22author:Barker+GR%22)
	2. [Warburton EC](https://scholar.google.com/scholar?q=%22author:Warburton+EC%22)
	(2015) [Object-in-place associative recognition memory depends on glutamate receptor neurotransmission within two defined hippocampal-cortical circuits: a critical role for AMPA and NMDA receptors in the Hippocampus, perirhinal, and prefrontal cortices](https://doi.org/10.1093/cercor/bht245)
	*Cerebral Cortex* **25**:472–481.
	[https://doi.org/10.1093/cercor/bht245](https://doi.org/10.1093/cercor/bht245)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/24035904)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Object-in-place+associative+recognition+memory+depends+on+glutamate+receptor+neurotransmission+within+two+defined+hippocampal-cortical+circuits%3A+a+critical+role+for+AMPA+and+NMDA+receptors+in+the+Hippocampus%2C+perirhinal%2C+and+prefrontal+cortices&author=Barker+GR&author=Warburton+EC&publication_year=2015&journal=Cerebral+Cortex&volume=25&pages=pp.+472%E2%80%93481&pmid=24035904)
9. 1. [Barry C](https://scholar.google.com/scholar?q=%22author:Barry+C%22)
	2. [Burgess N](https://scholar.google.com/scholar?q=%22author:Burgess+N%22)
	(2007) [Learning in a geometric model of place cell firing](https://doi.org/10.1002/hipo.20324)
	*Hippocampus* **17**:786–800.
	[https://doi.org/10.1002/hipo.20324](https://doi.org/10.1002/hipo.20324)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/17598149)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Learning+in+a+geometric+model+of+place+cell+firing&author=Barry+C&author=Burgess+N&publication_year=2007&journal=Hippocampus&volume=17&pages=pp.+786%E2%80%93800&pmid=17598149)
10. 1. [Barry C](https://scholar.google.com/scholar?q=%22author:Barry+C%22)
	2. [Lever C](https://scholar.google.com/scholar?q=%22author:Lever+C%22)
	3. [Hayman R](https://scholar.google.com/scholar?q=%22author:Hayman+R%22)
	4. [Hartley T](https://scholar.google.com/scholar?q=%22author:Hartley+T%22)
	5. [Burton S](https://scholar.google.com/scholar?q=%22author:Burton+S%22)
	6. [O'Keefe J](https://scholar.google.com/scholar?q=%22author:O%27Keefe+J%22)
	7. [Jeffery K](https://scholar.google.com/scholar?q=%22author:Jeffery+K%22)
	8. [Burgess N](https://scholar.google.com/scholar?q=%22author:Burgess+N%22)
	(2006) [The boundary vector cell model of place cell firing and spatial memory](https://doi.org/10.1515/REVNEURO.2006.17.1-2.71)
	*Reviews in the Neurosciences* **17**:71–98.
	[https://doi.org/10.1515/REVNEURO.2006.17.1-2.71](https://doi.org/10.1515/REVNEURO.2006.17.1-2.71)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/16703944)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=The+boundary+vector+cell+model+of+place+cell+firing+and+spatial+memory&author=Barry+C&author=Lever+C&author%5B2%5D=Hayman+R&author%5B3%5D=Hartley+T&author%5B4%5D=Burton+S&author%5B5%5D=O%27Keefe+J&author%5B6%5D=Jeffery+K&author%5B7%5D=Burgess+N&publication_year=2006&journal=Reviews+in+the+Neurosciences&volume=17&pages=pp.+71%E2%80%9398&pmid=16703944)
11. 1. [Bays PM](https://scholar.google.com/scholar?q=%22author:Bays+PM%22)
	2. [Husain M](https://scholar.google.com/scholar?q=%22author:Husain+M%22)
	(2008) [Dynamic shifts of limited working memory resources in human vision](https://doi.org/10.1126/science.1158023)
	*Science* **321**:851–854.
	[https://doi.org/10.1126/science.1158023](https://doi.org/10.1126/science.1158023)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/18687968)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Dynamic+shifts+of+limited+working+memory+resources+in+human+vision&author=Bays+PM&author=Husain+M&publication_year=2008&journal=Science&volume=321&pages=pp.+851%E2%80%93854&pmid=18687968)
12. 1. [Bicanski A](https://scholar.google.com/scholar?q=%22author:Bicanski+A%22)
	2. [Burgess N](https://scholar.google.com/scholar?q=%22author:Burgess+N%22)
	(2016) [Environmental anchoring of head direction in a computational model of retrosplenial cortex](https://doi.org/10.1523/JNEUROSCI.0516-16.2016)
	*The Journal of Neuroscience* **36**:11601–11618.
	[https://doi.org/10.1523/JNEUROSCI.0516-16.2016](https://doi.org/10.1523/JNEUROSCI.0516-16.2016)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/27852770)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Environmental+anchoring+of+head+direction+in+a+computational+model+of+retrosplenial+cortex&author=Bicanski+A&author=Burgess+N&publication_year=2016&journal=The+Journal+of+Neuroscience&volume=36&pages=pp.+11601%E2%80%9311618&pmid=27852770)
13. 1. [Bisiach E](https://scholar.google.com/scholar?q=%22author:Bisiach+E%22)
	2. [Luzzatti C](https://scholar.google.com/scholar?q=%22author:Luzzatti+C%22)
	(1978) [Unilateral neglect of representational space](https://doi.org/10.1016/S0010-9452\(78\)80016-1)
	*Cortex* **14**:129–133.
	[https://doi.org/10.1016/S0010-9452(78)80016-1](https://doi.org/10.1016/S0010-9452\(78\)80016-1)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/16295118)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Unilateral+neglect+of+representational+space&author=Bisiach+E&author=Luzzatti+C&publication_year=1978&journal=Cortex&volume=14&pages=pp.+129%E2%80%93133&pmid=16295118)
14. 1. [Buckner RL](https://scholar.google.com/scholar?q=%22author:Buckner+RL%22)
	(2010) [The role of the Hippocampus in prediction and imagination](https://doi.org/10.1146/annurev.psych.60.110707.163508)
	*Annual Review of Psychology* **61**:27–48.
	[https://doi.org/10.1146/annurev.psych.60.110707.163508](https://doi.org/10.1146/annurev.psych.60.110707.163508)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/19958178)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=The+role+of+the+Hippocampus+in+prediction+and+imagination&author=Buckner+RL&publication_year=2010&journal=Annual+Review+of+Psychology&volume=61&pages=pp.+27%E2%80%9348&pmid=19958178)
15. 1. [Burak Y](https://scholar.google.com/scholar?q=%22author:Burak+Y%22)
	2. [Fiete IR](https://scholar.google.com/scholar?q=%22author:Fiete+IR%22)
	(2009) [Accurate path integration in continuous attractor network models of grid cells](https://doi.org/10.1371/journal.pcbi.1000291)
	*PLoS Computational Biology* **5**:e1000291.
	[https://doi.org/10.1371/journal.pcbi.1000291](https://doi.org/10.1371/journal.pcbi.1000291)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/19229307)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Accurate+path+integration+in+continuous+attractor+network+models+of+grid+cells&author=Burak+Y&author=Fiete+IR&publication_year=2009&journal=PLoS+Computational+Biology&volume=5&pages=e1000291&pmid=19229307)
16. 1. [Burgess N](https://scholar.google.com/scholar?q=%22author:Burgess+N%22)
	2. [Becker S](https://scholar.google.com/scholar?q=%22author:Becker+S%22)
	3. [King JA](https://scholar.google.com/scholar?q=%22author:King+JA%22)
	4. [O'Keefe J](https://scholar.google.com/scholar?q=%22author:O%27Keefe+J%22)
	(2001b) [Memory for events and their spatial context: models and experiments](https://doi.org/10.1098/rstb.2001.0948)
	*Philosophical Transactions of the Royal Society B: Biological Sciences* **356**:1493–1503.
	[https://doi.org/10.1098/rstb.2001.0948](https://doi.org/10.1098/rstb.2001.0948)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Memory+for+events+and+their+spatial+context%3A+models+and+experiments&author=Burgess+N&author=Becker+S&author%5B2%5D=King+JA&author%5B3%5D=O%27Keefe+J&publication_year=2001&journal=Philosophical+Transactions+of+the+Royal+Society+B%3A+Biological+Sciences&volume=356&pages=pp.+1493%E2%80%931503)
17. 1. [Burgess N](https://scholar.google.com/scholar?q=%22author:Burgess+N%22)
	2. [Recce M](https://scholar.google.com/scholar?q=%22author:Recce+M%22)
	3. [O'Keefe J](https://scholar.google.com/scholar?q=%22author:O%27Keefe+J%22)
	(1994) [A model of hippocampal function](https://doi.org/10.1016/S0893-6080\(05\)80159-5)
	*Neural Networks* **7**:1065–1081.
	[https://doi.org/10.1016/S0893-6080(05)80159-5](https://doi.org/10.1016/S0893-6080\(05\)80159-5)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=A+model+of+hippocampal+function&author=Burgess+N&author=Recce+M&author%5B2%5D=O%27Keefe+J&publication_year=1994&journal=Neural+Networks&volume=7&pages=pp.+1065%E2%80%931081)
18. 1. [Bush D](https://scholar.google.com/scholar?q=%22author:Bush+D%22)
	2. [Burgess N](https://scholar.google.com/scholar?q=%22author:Burgess+N%22)
	(2014) [A hybrid oscillatory interference/continuous attractor network model of grid cell firing](https://doi.org/10.1523/JNEUROSCI.4017-13.2014)
	*Journal of Neuroscience* **34**:5065–5079.
	[https://doi.org/10.1523/JNEUROSCI.4017-13.2014](https://doi.org/10.1523/JNEUROSCI.4017-13.2014)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/24695724)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=A+hybrid+oscillatory+interference%2Fcontinuous+attractor+network+model+of+grid+cell+firing&author=Bush+D&author=Burgess+N&publication_year=2014&journal=Journal+of+Neuroscience&volume=34&pages=pp.+5065%E2%80%935079&pmid=24695724)
19. 1. [Buzsáki G](https://scholar.google.com/scholar?q=%22author:Buzs%C3%A1ki+G%22)
	2. [Chrobak JJ](https://scholar.google.com/scholar?q=%22author:Chrobak+JJ%22)
	(1995) [Temporal structure in spatially organized neuronal ensembles: a role for interneuronal networks](https://doi.org/10.1016/0959-4388\(95\)80012-3)
	*Current Opinion in Neurobiology* **5**:504–510.
	[https://doi.org/10.1016/0959-4388(95)80012-3](https://doi.org/10.1016/0959-4388\(95\)80012-3)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/7488853)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Temporal+structure+in+spatially+organized+neuronal+ensembles%3A+a+role+for+interneuronal+networks&author=Buzs%C3%A1ki+G&author=Chrobak+JJ&publication_year=1995&journal=Current+Opinion+in+Neurobiology&volume=5&pages=pp.+504%E2%80%93510&pmid=7488853)
20. 1. [Davachi L](https://scholar.google.com/scholar?q=%22author:Davachi+L%22)
	(2006) [Context and relational episodic encoding in humans](https://doi.org/10.1016/j.conb.2006.10.012)
	*Current Opinion in Neurobiology* **16**:693–700.
	[https://doi.org/10.1016/j.conb.2006.10.012](https://doi.org/10.1016/j.conb.2006.10.012)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/17097284)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Context+and+relational+episodic+encoding+in+humans&author=Davachi+L&publication_year=2006&journal=Current+Opinion+in+Neurobiology&volume=16&pages=pp.+693%E2%80%93700&pmid=17097284)
21. 1. [Delay J](https://scholar.google.com/scholar?q=%22author:Delay+J%22)
	2. [Brion S](https://scholar.google.com/scholar?q=%22author:Brion+S%22)
	(1969)
	Le Syndrome De Korsakoff. Masson
	Le Syndrome De Korsakoff. Masson.
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Le+Syndrome+De+Korsakoff.+Masson&author=Delay+J&author=Brion+S&publication_year=1969)
22. 1. [Deshmukh SS](https://scholar.google.com/scholar?q=%22author:Deshmukh+SS%22)
	2. [Knierim JJ](https://scholar.google.com/scholar?q=%22author:Knierim+JJ%22)
	(2013) [Influence of local objects on hippocampal representations: landmark vectors and memory](https://doi.org/10.1002/hipo.22101)
	*Hippocampus* **23**:253–267.
	[https://doi.org/10.1002/hipo.22101](https://doi.org/10.1002/hipo.22101)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/23447419)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Influence+of+local+objects+on+hippocampal+representations%3A+landmark+vectors+and+memory&author=Deshmukh+SS&author=Knierim+JJ&publication_year=2013&journal=Hippocampus&volume=23&pages=pp.+253%E2%80%93267&pmid=23447419)
23. 1. [Diba K](https://scholar.google.com/scholar?q=%22author:Diba+K%22)
	2. [Buzsáki G](https://scholar.google.com/scholar?q=%22author:Buzs%C3%A1ki+G%22)
	(2007) [Forward and reverse hippocampal place-cell sequences during ripples](https://doi.org/10.1038/nn1961)
	*Nature Neuroscience* **10**:1241–1242.
	[https://doi.org/10.1038/nn1961](https://doi.org/10.1038/nn1961)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/17828259)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Forward+and+reverse+hippocampal+place-cell+sequences+during+ripples&author=Diba+K&author=Buzs%C3%A1ki+G&publication_year=2007&journal=Nature+Neuroscience&volume=10&pages=pp.+1241%E2%80%931242&pmid=17828259)
24. 1. [Douchamps V](https://scholar.google.com/scholar?q=%22author:Douchamps+V%22)
	2. [Jeewajee A](https://scholar.google.com/scholar?q=%22author:Jeewajee+A%22)
	3. [Blundell P](https://scholar.google.com/scholar?q=%22author:Blundell+P%22)
	4. [Burgess N](https://scholar.google.com/scholar?q=%22author:Burgess+N%22)
	5. [Lever C](https://scholar.google.com/scholar?q=%22author:Lever+C%22)
	(2013) [Evidence for encoding versus retrieval scheduling in the Hippocampus by theta phase and acetylcholine](https://doi.org/10.1523/JNEUROSCI.4483-12.2013)
	*Journal of Neuroscience* **33**:8689–8704.
	[https://doi.org/10.1523/JNEUROSCI.4483-12.2013](https://doi.org/10.1523/JNEUROSCI.4483-12.2013)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/23678113)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Evidence+for+encoding+versus+retrieval+scheduling+in+the+Hippocampus+by+theta+phase+and+acetylcholine&author=Douchamps+V&author=Jeewajee+A&author%5B2%5D=Blundell+P&author%5B3%5D=Burgess+N&author%5B4%5D=Lever+C&publication_year=2013&journal=Journal+of+Neuroscience&volume=33&pages=pp.+8689%E2%80%938704&pmid=23678113)
25. 1. [Dragoi G](https://scholar.google.com/scholar?q=%22author:Dragoi+G%22)
	2. [Tonegawa S](https://scholar.google.com/scholar?q=%22author:Tonegawa+S%22)
	(2011) [Preplay of future place cell sequences by hippocampal cellular assemblies](https://doi.org/10.1038/nature09633)
	*Nature* **469**:397–401.
	[https://doi.org/10.1038/nature09633](https://doi.org/10.1038/nature09633)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/21179088)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Preplay+of+future+place+cell+sequences+by+hippocampal+cellular+assemblies&author=Dragoi+G&author=Tonegawa+S&publication_year=2011&journal=Nature&volume=469&pages=pp.+397%E2%80%93401&pmid=21179088)
26. 1. [Eacott MJ](https://scholar.google.com/scholar?q=%22author:Eacott+MJ%22)
	2. [Gaffan EA](https://scholar.google.com/scholar?q=%22author:Gaffan+EA%22)
	(2005) [The roles of perirhinal cortex, postrhinal cortex, and the fornix in memory for objects, contexts, and events in the rat](https://doi.org/10.1080/02724990444000203)
	*The Quarterly Journal of Experimental Psychology Section B* **58**:202–217.
	[https://doi.org/10.1080/02724990444000203](https://doi.org/10.1080/02724990444000203)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=The+roles+of+perirhinal+cortex%2C+postrhinal+cortex%2C+and+the+fornix+in+memory+for+objects%2C+contexts%2C+and+events+in+the+rat&author=Eacott+MJ&author=Gaffan+EA&publication_year=2005&journal=The+Quarterly+Journal+of+Experimental+Psychology+Section+B&volume=58&pages=pp.+202%E2%80%93217)
27. 1. [Eacott MJ](https://scholar.google.com/scholar?q=%22author:Eacott+MJ%22)
	2. [Norman G](https://scholar.google.com/scholar?q=%22author:Norman+G%22)
	(2004) [Integrated memory for object, place, and context in rats: a possible model of episodic-like memory?](https://doi.org/10.1523/JNEUROSCI.2975-03.2004)
	*Journal of Neuroscience* **24**:1948–1953.
	[https://doi.org/10.1523/JNEUROSCI.2975-03.2004](https://doi.org/10.1523/JNEUROSCI.2975-03.2004)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/14985436)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Integrated+memory+for+object%2C+place%2C+and+context+in+rats%3A+a+possible+model+of+episodic-like+memory%3F&author=Eacott+MJ&author=Norman+G&publication_year=2004&journal=Journal+of+Neuroscience&volume=24&pages=pp.+1948%E2%80%931953&pmid=14985436)
28. 1. [Epstein RA](https://scholar.google.com/scholar?q=%22author:Epstein+RA%22)
	2. [Vass LK](https://scholar.google.com/scholar?q=%22author:Vass+LK%22)
	(2014) [Neural systems for landmark-based wayfinding in humans](https://doi.org/10.1098/rstb.2012.0533)
	*Philosophical Transactions of the Royal Society B: Biological Sciences* **369**:20120533.
	[https://doi.org/10.1098/rstb.2012.0533](https://doi.org/10.1098/rstb.2012.0533)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/24366141)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Neural+systems+for+landmark-based+wayfinding+in+humans&author=Epstein+RA&author=Vass+LK&publication_year=2014&journal=Philosophical+Transactions+of+the+Royal+Society+B%3A+Biological+Sciences&volume=369&pages=20120533&pmid=24366141)
29. 1. [Formisano E](https://scholar.google.com/scholar?q=%22author:Formisano+E%22)
	2. [Linden DE](https://scholar.google.com/scholar?q=%22author:Linden+DE%22)
	3. [Di Salle F](https://scholar.google.com/scholar?q=%22author:Di+Salle+F%22)
	4. [Trojano L](https://scholar.google.com/scholar?q=%22author:Trojano+L%22)
	5. [Esposito F](https://scholar.google.com/scholar?q=%22author:Esposito+F%22)
	6. [Sack AT](https://scholar.google.com/scholar?q=%22author:Sack+AT%22)
	7. [Grossi D](https://scholar.google.com/scholar?q=%22author:Grossi+D%22)
	8. [Zanella FE](https://scholar.google.com/scholar?q=%22author:Zanella+FE%22)
	9. [Goebel R](https://scholar.google.com/scholar?q=%22author:Goebel+R%22)
	(2002) [Tracking the mind's image in the brain I: time-resolved fMRI during visuospatial mental imagery](https://doi.org/10.1016/S0896-6273\(02\)00747-X)
	*Neuron* **35**:185–194.
	[https://doi.org/10.1016/S0896-6273(02)00747-X](https://doi.org/10.1016/S0896-6273\(02\)00747-X)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/12123618)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Tracking+the+mind%27s+image+in+the+brain+I%3A+time-resolved+fMRI+during+visuospatial+mental+imagery&author=Formisano+E&author=Linden+DE&author%5B2%5D=Di+Salle+F&author%5B3%5D=Trojano+L&author%5B4%5D=Esposito+F&author%5B5%5D=Sack+AT&author%5B6%5D=Grossi+D&author%5B7%5D=Zanella+FE&author%5B8%5D=Goebel+R&publication_year=2002&journal=Neuron&volume=35&pages=pp.+185%E2%80%93194&pmid=12123618)
30. 1. [Foster DJ](https://scholar.google.com/scholar?q=%22author:Foster+DJ%22)
	2. [Wilson MA](https://scholar.google.com/scholar?q=%22author:Wilson+MA%22)
	(2006) [Reverse replay of behavioural sequences in hippocampal place cells during the awake state](https://doi.org/10.1038/nature04587)
	*Nature* **440**:680–683.
	[https://doi.org/10.1038/nature04587](https://doi.org/10.1038/nature04587)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/16474382)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Reverse+replay+of+behavioural+sequences+in+hippocampal+place+cells+during+the+awake+state&author=Foster+DJ&author=Wilson+MA&publication_year=2006&journal=Nature&volume=440&pages=pp.+680%E2%80%93683&pmid=16474382)
31. 1. [Fuhs MC](https://scholar.google.com/scholar?q=%22author:Fuhs+MC%22)
	2. [Touretzky DS](https://scholar.google.com/scholar?q=%22author:Touretzky+DS%22)
	(2006) [A spin glass model of path integration in rat medial entorhinal cortex](https://doi.org/10.1523/JNEUROSCI.4353-05.2006)
	*Journal of Neuroscience* **26**:4266–4276.
	[https://doi.org/10.1523/JNEUROSCI.4353-05.2006](https://doi.org/10.1523/JNEUROSCI.4353-05.2006)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/16624947)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=A+spin+glass+model+of+path+integration+in+rat+medial+entorhinal+cortex&author=Fuhs+MC&author=Touretzky+DS&publication_year=2006&journal=Journal+of+Neuroscience&volume=26&pages=pp.+4266%E2%80%934276&pmid=16624947)
32. 1. [Girardeau G](https://scholar.google.com/scholar?q=%22author:Girardeau+G%22)
	2. [Zugaro M](https://scholar.google.com/scholar?q=%22author:Zugaro+M%22)
	(2011) [Hippocampal ripples and memory consolidation](https://doi.org/10.1016/j.conb.2011.02.005)
	*Current Opinion in Neurobiology* **21**:452–459.
	[https://doi.org/10.1016/j.conb.2011.02.005](https://doi.org/10.1016/j.conb.2011.02.005)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/21371881)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Hippocampal+ripples+and+memory+consolidation&author=Girardeau+G&author=Zugaro+M&publication_year=2011&journal=Current+Opinion+in+Neurobiology&volume=21&pages=pp.+452%E2%80%93459&pmid=21371881)
33. 1. [Goodale MA](https://scholar.google.com/scholar?q=%22author:Goodale+MA%22)
	2. [Milner AD](https://scholar.google.com/scholar?q=%22author:Milner+AD%22)
	(1992) [Separate visual pathways for perception and action](https://doi.org/10.1016/0166-2236\(92\)90344-8)
	*Trends in Neurosciences* **15**:20–25.
	[https://doi.org/10.1016/0166-2236(92)90344-8](https://doi.org/10.1016/0166-2236\(92\)90344-8)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/1374953)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Separate+visual+pathways+for+perception+and+action&author=Goodale+MA&author=Milner+AD&publication_year=1992&journal=Trends+in+Neurosciences&volume=15&pages=pp.+20%E2%80%9325&pmid=1374953)
34. 1. [Hasselmo ME](https://scholar.google.com/scholar?q=%22author:Hasselmo+ME%22)
	2. [Bodelón C](https://scholar.google.com/scholar?q=%22author:Bodel%C3%B3n+C%22)
	3. [Wyble BP](https://scholar.google.com/scholar?q=%22author:Wyble+BP%22)
	(2002) [A proposed function for hippocampal theta rhythm: separate phases of encoding and retrieval enhance reversal of prior learning](https://doi.org/10.1162/089976602317318965)
	*Neural Computation* **14**:793–817.
	[https://doi.org/10.1162/089976602317318965](https://doi.org/10.1162/089976602317318965)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/11936962)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=A+proposed+function+for+hippocampal+theta+rhythm%3A+separate+phases+of+encoding+and+retrieval+enhance+reversal+of+prior+learning&author=Hasselmo+ME&author=Bodel%C3%B3n+C&author%5B2%5D=Wyble+BP&publication_year=2002&journal=Neural+Computation&volume=14&pages=pp.+793%E2%80%93817&pmid=11936962)
35. 1. [Hasselmo ME](https://scholar.google.com/scholar?q=%22author:Hasselmo+ME%22)
	(2006) [The role of acetylcholine in learning and memory](https://doi.org/10.1016/j.conb.2006.09.002)
	*Current Opinion in Neurobiology* **16**:710–715.
	[https://doi.org/10.1016/j.conb.2006.09.002](https://doi.org/10.1016/j.conb.2006.09.002)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/17011181)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=The+role+of+acetylcholine+in+learning+and+memory&author=Hasselmo+ME&publication_year=2006&journal=Current+Opinion+in+Neurobiology&volume=16&pages=pp.+710%E2%80%93715&pmid=17011181)
36. 1. [Hebscher M](https://scholar.google.com/scholar?q=%22author:Hebscher+M%22)
	2. [Levine B](https://scholar.google.com/scholar?q=%22author:Levine+B%22)
	3. [Gilboa A](https://scholar.google.com/scholar?q=%22author:Gilboa+A%22)
	(2018) [The precuneus and Hippocampus contribute to individual differences in the unfolding of spatial representations during episodic autobiographical memory](https://doi.org/10.1016/j.neuropsychologia.2017.03.029)
	*Neuropsychologia* **110**:123–133.
	[https://doi.org/10.1016/j.neuropsychologia.2017.03.029](https://doi.org/10.1016/j.neuropsychologia.2017.03.029)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/28365362)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=The+precuneus+and+Hippocampus+contribute+to+individual+differences+in+the+unfolding+of+spatial+representations+during+episodic+autobiographical+memory&author=Hebscher+M&author=Levine+B&author%5B2%5D=Gilboa+A&publication_year=2018&journal=Neuropsychologia&volume=110&pages=pp.+123%E2%80%93133&pmid=28365362)
37. 1. [Henson RN](https://scholar.google.com/scholar?q=%22author:Henson+RN%22)
	2. [Gagnepain P](https://scholar.google.com/scholar?q=%22author:Gagnepain+P%22)
	(2010) [Predictive, interactive multiple memory systems](https://doi.org/10.1002/hipo.20857)
	*Hippocampus* **20**:1315–1326.
	[https://doi.org/10.1002/hipo.20857](https://doi.org/10.1002/hipo.20857)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/20928831)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Predictive%2C+interactive+multiple+memory+systems&author=Henson+RN&author=Gagnepain+P&publication_year=2010&journal=Hippocampus&volume=20&pages=pp.+1315%E2%80%931326&pmid=20928831)
38. 1. [Hinman JR](https://scholar.google.com/scholar?q=%22author:Hinman+JR%22)
	2. [Chapman GW](https://scholar.google.com/scholar?q=%22author:Chapman+GW%22)
	3. [Hasselmo ME](https://scholar.google.com/scholar?q=%22author:Hasselmo+ME%22)
	(2017)
	Egocentric representation of environmental boundaries in the striatum
	*Society for Neuroscience*.
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Egocentric+representation+of+environmental+boundaries+in+the+striatum&author=Hinman+JR&author=Chapman+GW&author%5B2%5D=Hasselmo+ME&publication_year=2017&journal=%C2%A0Society+for+Neuroscience)
39. 1. [Hollingworth A](https://scholar.google.com/scholar?q=%22author:Hollingworth+A%22)
	(2007) [Object-position binding in visual memory for natural scenes and object arrays](https://doi.org/10.1037/0096-1523.33.1.31)
	*Journal of Experimental Psychology: Human Perception and Performance* **33**:31–47.
	[https://doi.org/10.1037/0096-1523.33.1.31](https://doi.org/10.1037/0096-1523.33.1.31)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Object-position+binding+in+visual+memory+for+natural+scenes+and+object+arrays&author=Hollingworth+A&publication_year=2007&journal=Journal+of+Experimental+Psychology%3A+Human+Perception+and+Performance&volume=33&pages=pp.+31%E2%80%9347)
40. 1. [Itti L](https://scholar.google.com/scholar?q=%22author:Itti+L%22)
	2. [Koch C](https://scholar.google.com/scholar?q=%22author:Koch+C%22)
	(2001) [Computational modelling of visual attention](https://doi.org/10.1038/35058500)
	*Nature Reviews. Neuroscience* **2**:194.
	[https://doi.org/10.1038/35058500](https://doi.org/10.1038/35058500)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/11256080)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Computational+modelling+of+visual+attention&author=Itti+L&author=Koch+C&publication_year=2001&journal=Nature+Reviews.+Neuroscience&volume=2&pages=194&pmid=11256080)
41. 1. [Johnson A](https://scholar.google.com/scholar?q=%22author:Johnson+A%22)
	2. [Redish AD](https://scholar.google.com/scholar?q=%22author:Redish+AD%22)
	(2007) [Neural ensembles in CA3 transiently encode paths forward of the animal at a decision point](https://doi.org/10.1523/JNEUROSCI.3761-07.2007)
	*Journal of Neuroscience* **27**:12176–12189.
	[https://doi.org/10.1523/JNEUROSCI.3761-07.2007](https://doi.org/10.1523/JNEUROSCI.3761-07.2007)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/17989284)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Neural+ensembles+in+CA3+transiently+encode+paths+forward+of+the+animal+at+a+decision+point&author=Johnson+A&author=Redish+AD&publication_year=2007&journal=Journal+of+Neuroscience&volume=27&pages=pp.+12176%E2%80%9312189&pmid=17989284)
42. 1. [Jones BF](https://scholar.google.com/scholar?q=%22author:Jones+BF%22)
	2. [Witter MP](https://scholar.google.com/scholar?q=%22author:Witter+MP%22)
	(2007) [Cingulate cortex projections to the parahippocampal region and hippocampal formation in the rat](https://doi.org/10.1002/hipo.20330)
	*Hippocampus* **17**:957–976.
	[https://doi.org/10.1002/hipo.20330](https://doi.org/10.1002/hipo.20330)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/17598159)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Cingulate+cortex+projections+to+the+parahippocampal+region+and+hippocampal+formation+in+the+rat&author=Jones+BF&author=Witter+MP&publication_year=2007&journal=Hippocampus&volume=17&pages=pp.+957%E2%80%93976&pmid=17598159)
43. 1. [Karlsson MP](https://scholar.google.com/scholar?q=%22author:Karlsson+MP%22)
	2. [Frank LM](https://scholar.google.com/scholar?q=%22author:Frank+LM%22)
	(2009) [Awake replay of remote experiences in the Hippocampus](https://doi.org/10.1038/nn.2344)
	*Nature Neuroscience* **12**:913–918.
	[https://doi.org/10.1038/nn.2344](https://doi.org/10.1038/nn.2344)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/19525943)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Awake+replay+of+remote+experiences+in+the+Hippocampus&author=Karlsson+MP&author=Frank+LM&publication_year=2009&journal=Nature+Neuroscience&volume=12&pages=pp.+913%E2%80%93918&pmid=19525943)
44. 1. [Keck T](https://scholar.google.com/scholar?q=%22author:Keck+T%22)
	2. [Toyoizumi T](https://scholar.google.com/scholar?q=%22author:Toyoizumi+T%22)
	3. [Chen L](https://scholar.google.com/scholar?q=%22author:Chen+L%22)
	4. [Doiron B](https://scholar.google.com/scholar?q=%22author:Doiron+B%22)
	5. [Feldman DE](https://scholar.google.com/scholar?q=%22author:Feldman+DE%22)
	6. [Fox K](https://scholar.google.com/scholar?q=%22author:Fox+K%22)
	7. [Gerstner W](https://scholar.google.com/scholar?q=%22author:Gerstner+W%22)
	8. [Haydon PG](https://scholar.google.com/scholar?q=%22author:Haydon+PG%22)
	9. [Hübener M](https://scholar.google.com/scholar?q=%22author:H%C3%BCbener+M%22)
	10. [Lee H-K](https://scholar.google.com/scholar?q=%22author:Lee+H-K%22)
	11. [Lisman JE](https://scholar.google.com/scholar?q=%22author:Lisman+JE%22)
	12. [Rose T](https://scholar.google.com/scholar?q=%22author:Rose+T%22)
	13. [Sengpiel F](https://scholar.google.com/scholar?q=%22author:Sengpiel+F%22)
	14. [Stellwagen D](https://scholar.google.com/scholar?q=%22author:Stellwagen+D%22)
	15. [Stryker MP](https://scholar.google.com/scholar?q=%22author:Stryker+MP%22)
	16. [Turrigiano GG](https://scholar.google.com/scholar?q=%22author:Turrigiano+GG%22)
	17. [van Rossum MC](https://scholar.google.com/scholar?q=%22author:van+Rossum+MC%22)
	(2017) [Integrating hebbian and homeostatic plasticity: the current state of the field and future research directions](https://doi.org/10.1098/rstb.2016.0158)
	*Philosophical Transactions of the Royal Society B: Biological Sciences* **372**:20160158.
	[https://doi.org/10.1098/rstb.2016.0158](https://doi.org/10.1098/rstb.2016.0158)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Integrating+hebbian+and+homeostatic+plasticity%3A+the+current+state+of+the+field+and+future+research+directions&author=Keck+T&author=Toyoizumi+T&author%5B2%5D=Chen+L&author%5B3%5D=Doiron+B&author%5B4%5D=Feldman+DE&author%5B5%5D=Fox+K&author%5B6%5D=Gerstner+W&author%5B7%5D=Haydon+PG&author%5B8%5D=H%C3%BCbener+M&author%5B9%5D=Lee+H-K&author%5B10%5D=Lisman+JE&author%5B11%5D=Rose+T&author%5B12%5D=Sengpiel+F&author%5B13%5D=Stellwagen+D&author%5B14%5D=Stryker+MP&author%5B15%5D=Turrigiano+GG&author%5B16%5D=van+Rossum+MC&publication_year=2017&journal=Philosophical+Transactions+of+the+Royal+Society+B%3A+Biological+Sciences&volume=372&pages=20160158)
45. 1. [Káli S](https://scholar.google.com/scholar?q=%22author:K%C3%A1li+S%22)
	2. [Dayan P](https://scholar.google.com/scholar?q=%22author:Dayan+P%22)
	(2001)
	Advances in Neural Information Processing Systems
	24–30, Hippocampally-dependent consolidation in a hierarchical model of neocortex, Advances in Neural Information Processing Systems.
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Advances+in+Neural+Information+Processing+Systems&author=K%C3%A1li+S&author=Dayan+P&publication_year=2001)
46. 1. [Landau AN](https://scholar.google.com/scholar?q=%22author:Landau+AN%22)
	2. [Fries P](https://scholar.google.com/scholar?q=%22author:Fries+P%22)
	(2012) [Attention samples stimuli rhythmically](https://doi.org/10.1016/j.cub.2012.03.054)
	*Current Biology* **22**:1000–1004.
	[https://doi.org/10.1016/j.cub.2012.03.054](https://doi.org/10.1016/j.cub.2012.03.054)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/22633805)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Attention+samples+stimuli+rhythmically&author=Landau+AN&author=Fries+P&publication_year=2012&journal=Current+Biology&volume=22&pages=pp.+1000%E2%80%931004&pmid=22633805)
47. 1. [Langston RF](https://scholar.google.com/scholar?q=%22author:Langston+RF%22)
	2. [Wood ER](https://scholar.google.com/scholar?q=%22author:Wood+ER%22)
	(2010) [Associative recognition and the Hippocampus: differential effects of hippocampal lesions on object-place, object-context and object-place-context memory](https://doi.org/10.1002/hipo.20714)
	*Hippocampus* **20**:1139–1153.
	[https://doi.org/10.1002/hipo.20714](https://doi.org/10.1002/hipo.20714)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/19847786)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Associative+recognition+and+the+Hippocampus%3A+differential+effects+of+hippocampal+lesions+on+object-place%2C+object-context+and+object-place-context+memory&author=Langston+RF&author=Wood+ER&publication_year=2010&journal=Hippocampus&volume=20&pages=pp.+1139%E2%80%931153&pmid=19847786)
48. 1. [Lisman JE](https://scholar.google.com/scholar?q=%22author:Lisman+JE%22)
	2. [Idiart MA](https://scholar.google.com/scholar?q=%22author:Idiart+MA%22)
	(1995) [Storage of 7 +/- 2 short-term memories in oscillatory subcycles](https://doi.org/10.1126/science.7878473)
	*Science* **267**:1512–1515.
	[https://doi.org/10.1126/science.7878473](https://doi.org/10.1126/science.7878473)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/7878473)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Storage+of+7+%2B%2F-+2+short-term+memories+in+oscillatory+subcycles&author=Lisman+JE&author=Idiart+MA&publication_year=1995&journal=Science&volume=267&pages=pp.+1512%E2%80%931515&pmid=7878473)
49. 1. [Marchette SA](https://scholar.google.com/scholar?q=%22author:Marchette+SA%22)
	2. [Vass LK](https://scholar.google.com/scholar?q=%22author:Vass+LK%22)
	3. [Ryan J](https://scholar.google.com/scholar?q=%22author:Ryan+J%22)
	4. [Epstein RA](https://scholar.google.com/scholar?q=%22author:Epstein+RA%22)
	(2014) [Anchoring the neural compass: coding of local spatial reference frames in human medial parietal lobe](https://doi.org/10.1038/nn.3834)
	*Nature Neuroscience* **17**:1598–1606.
	[https://doi.org/10.1038/nn.3834](https://doi.org/10.1038/nn.3834)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/25282616)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Anchoring+the+neural+compass%3A+coding+of+local+spatial+reference+frames+in+human+medial+parietal+lobe&author=Marchette+SA&author=Vass+LK&author%5B2%5D=Ryan+J&author%5B3%5D=Epstein+RA&publication_year=2014&journal=Nature+Neuroscience&volume=17&pages=pp.+1598%E2%80%931606&pmid=25282616)
50. 1. [Mishkin M](https://scholar.google.com/scholar?q=%22author:Mishkin+M%22)
	2. [Ungerleider LG](https://scholar.google.com/scholar?q=%22author:Ungerleider+LG%22)
	3. [Macko KA](https://scholar.google.com/scholar?q=%22author:Macko+KA%22)
	(1983) [Object vision and spatial vision: two cortical pathways](https://doi.org/10.1016/0166-2236\(83\)90190-X)
	*Trends in Neurosciences* **6**:414–417.
	[https://doi.org/10.1016/0166-2236(83)90190-X](https://doi.org/10.1016/0166-2236\(83\)90190-X)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Object+vision+and+spatial+vision%3A+two+cortical+pathways&author=Mishkin+M&author=Ungerleider+LG&author%5B2%5D=Macko+KA&publication_year=1983&journal=Trends+in+Neurosciences&volume=6&pages=pp.+414%E2%80%93417)
51. 1. [Mittelstaedt M-L](https://scholar.google.com/scholar?q=%22author:Mittelstaedt+M-L%22)
	2. [Mittelstaedt H](https://scholar.google.com/scholar?q=%22author:Mittelstaedt+H%22)
	(1980) [Homing by path integration in a mammal](https://doi.org/10.1007/BF00450672)
	*Naturwissenschaften* **67**:566–567.
	[https://doi.org/10.1007/BF00450672](https://doi.org/10.1007/BF00450672)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Homing+by+path+integration+in+a+mammal&author=Mittelstaedt+M-L&author=Mittelstaedt+H&publication_year=1980&journal=Naturwissenschaften&volume=67&pages=pp.+566%E2%80%93567)
52. 1. [Mumby DG](https://scholar.google.com/scholar?q=%22author:Mumby+DG%22)
	2. [Gaskin S](https://scholar.google.com/scholar?q=%22author:Gaskin+S%22)
	3. [Glenn MJ](https://scholar.google.com/scholar?q=%22author:Glenn+MJ%22)
	4. [Schramek TE](https://scholar.google.com/scholar?q=%22author:Schramek+TE%22)
	5. [Lehmann H](https://scholar.google.com/scholar?q=%22author:Lehmann+H%22)
	(2002) [Hippocampal damage and exploratory preferences in rats: memory for objects, places, and contexts](https://doi.org/10.1101/lm.41302)
	*Learning & Memory* **9**:49–57.
	[https://doi.org/10.1101/lm.41302](https://doi.org/10.1101/lm.41302)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/11992015)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Hippocampal+damage+and+exploratory+preferences+in+rats%3A+memory+for+objects%2C+places%2C+and+contexts&author=Mumby+DG&author=Gaskin+S&author%5B2%5D=Glenn+MJ&author%5B3%5D=Schramek+TE&author%5B4%5D=Lehmann+H&publication_year=2002&journal=Learning+%26+Memory&volume=9&pages=pp.+49%E2%80%9357&pmid=11992015)
53. 1. [Nitz DA](https://scholar.google.com/scholar?q=%22author:Nitz+DA%22)
	(2006) [Tracking route progression in the posterior parietal cortex](https://doi.org/10.1016/j.neuron.2006.01.037)
	*Neuron* **49**:747–756.
	[https://doi.org/10.1016/j.neuron.2006.01.037](https://doi.org/10.1016/j.neuron.2006.01.037)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/16504949)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Tracking+route+progression+in+the+posterior+parietal+cortex&author=Nitz+DA&publication_year=2006&journal=Neuron&volume=49&pages=pp.+747%E2%80%93756&pmid=16504949)
54. 1. [Norman G](https://scholar.google.com/scholar?q=%22author:Norman+G%22)
	2. [Eacott MJ](https://scholar.google.com/scholar?q=%22author:Eacott+MJ%22)
	(2004) [Impaired object recognition with increasing levels of feature ambiguity in rats with perirhinal cortex lesions](https://doi.org/10.1016/S0166-4328\(03\)00176-1)
	*Behavioural Brain Research* **148**:79–91.
	[https://doi.org/10.1016/S0166-4328(03)00176-1](https://doi.org/10.1016/S0166-4328\(03\)00176-1)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/14684250)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Impaired+object+recognition+with+increasing+levels+of+feature+ambiguity+in+rats+with+perirhinal+cortex+lesions&author=Norman+G&author=Eacott+MJ&publication_year=2004&journal=Behavioural+Brain+Research&volume=148&pages=pp.+79%E2%80%9391&pmid=14684250)
55. 1. [O'Keefe J](https://scholar.google.com/scholar?q=%22author:O%27Keefe+J%22)
	2. [Burgess N](https://scholar.google.com/scholar?q=%22author:Burgess+N%22)
	(1996) [Geometric determinants of the place fields of hippocampal neurons](https://doi.org/10.1038/381425a0)
	*Nature* **381**:425–428.
	[https://doi.org/10.1038/381425a0](https://doi.org/10.1038/381425a0)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/8632799)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Geometric+determinants+of+the+place+fields+of+hippocampal+neurons&author=O%27Keefe+J&author=Burgess+N&publication_year=1996&journal=Nature&volume=381&pages=pp.+425%E2%80%93428&pmid=8632799)
56. 1. [O'Keefe J](https://scholar.google.com/scholar?q=%22author:O%27Keefe+J%22)
	2. [Burgess N](https://scholar.google.com/scholar?q=%22author:Burgess+N%22)
	(2005) [Dual phase and rate coding in hippocampal place cells: theoretical significance and relationship to entorhinal grid cells](https://doi.org/10.1002/hipo.20115)
	*Hippocampus* **15**:853–866.
	[https://doi.org/10.1002/hipo.20115](https://doi.org/10.1002/hipo.20115)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/16145693)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Dual+phase+and+rate+coding+in+hippocampal+place+cells%3A+theoretical+significance+and+relationship+to+entorhinal+grid+cells&author=O%27Keefe+J&author=Burgess+N&publication_year=2005&journal=Hippocampus&volume=15&pages=pp.+853%E2%80%93866&pmid=16145693)
57. 1. [O'Keefe J](https://scholar.google.com/scholar?q=%22author:O%27Keefe+J%22)
	2. [Dostrovsky J](https://scholar.google.com/scholar?q=%22author:Dostrovsky+J%22)
	(1971) [The Hippocampus as a spatial map. preliminary evidence from unit activity in the freely-moving rat](https://doi.org/10.1016/0006-8993\(71\)90358-1)
	*Brain Research* **34**:171–175.
	[https://doi.org/10.1016/0006-8993(71)90358-1](https://doi.org/10.1016/0006-8993\(71\)90358-1)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/5124915)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=The+Hippocampus+as+a+spatial+map.+preliminary+evidence+from+unit+activity+in+the+freely-moving+rat&author=O%27Keefe+J&author=Dostrovsky+J&publication_year=1971&journal=Brain+Research&volume=34&pages=pp.+171%E2%80%93175&pmid=5124915)
58. Book
	1. [O'keefe J](https://scholar.google.com/scholar?q=%22author:O%27keefe+J%22)
	2. [Nadel L](https://scholar.google.com/scholar?q=%22author:Nadel+L%22)
	(1978)
	The Hippocampus as a Cognitive Map
	Oxford: Clarendon Press.
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=The+Hippocampus+as+a+Cognitive+Map&author=O%27keefe+J&author=Nadel+L&publication_year=1978)
59. 1. [O'Keefe J](https://scholar.google.com/scholar?q=%22author:O%27Keefe+J%22)
	(1976) [Place units in the Hippocampus of the freely moving rat](https://doi.org/10.1016/0014-4886\(76\)90055-8)
	*Experimental Neurology* **51**:78–109.
	[https://doi.org/10.1016/0014-4886(76)90055-8](https://doi.org/10.1016/0014-4886\(76\)90055-8)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/1261644)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Place+units+in+the+Hippocampus+of+the+freely+moving+rat&author=O%27Keefe+J&publication_year=1976&journal=Experimental+Neurology&volume=51&pages=pp.+78%E2%80%93109&pmid=1261644)
60. 1. [Panoz-Brown D](https://scholar.google.com/scholar?q=%22author:Panoz-Brown+D%22)
	2. [Corbin HE](https://scholar.google.com/scholar?q=%22author:Corbin+HE%22)
	3. [Dalecki SJ](https://scholar.google.com/scholar?q=%22author:Dalecki+SJ%22)
	4. [Gentry M](https://scholar.google.com/scholar?q=%22author:Gentry+M%22)
	5. [Brotheridge S](https://scholar.google.com/scholar?q=%22author:Brotheridge+S%22)
	6. [Sluka CM](https://scholar.google.com/scholar?q=%22author:Sluka+CM%22)
	7. [Wu JE](https://scholar.google.com/scholar?q=%22author:Wu+JE%22)
	8. [Crystal JD](https://scholar.google.com/scholar?q=%22author:Crystal+JD%22)
	(2016) [Rats remember items in context using episodic memory](https://doi.org/10.1016/j.cub.2016.08.023)
	*Current Biology* **26**:2821–2826.
	[https://doi.org/10.1016/j.cub.2016.08.023](https://doi.org/10.1016/j.cub.2016.08.023)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/27693137)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Rats+remember+items+in+context+using+episodic+memory&author=Panoz-Brown+D&author=Corbin+HE&author%5B2%5D=Dalecki+SJ&author%5B3%5D=Gentry+M&author%5B4%5D=Brotheridge+S&author%5B5%5D=Sluka+CM&author%5B6%5D=Wu+JE&author%5B7%5D=Crystal+JD&publication_year=2016&journal=Current+Biology&volume=26&pages=pp.+2821%E2%80%932826&pmid=27693137)
61. 1. [Parker A](https://scholar.google.com/scholar?q=%22author:Parker+A%22)
	2. [Gaffan D](https://scholar.google.com/scholar?q=%22author:Gaffan+D%22)
	(1997) [Mamillary body lesions in monkeys impair Object-in-Place memory: functional unity of the Fornix-Mamillary system](https://doi.org/10.1162/jocn.1997.9.4.512)
	*Journal of Cognitive Neuroscience* **9**:512–521.
	[https://doi.org/10.1162/jocn.1997.9.4.512](https://doi.org/10.1162/jocn.1997.9.4.512)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/23968214)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Mamillary+body+lesions+in+monkeys+impair+Object-in-Place+memory%3A+functional+unity+of+the+Fornix-Mamillary+system&author=Parker+A&author=Gaffan+D&publication_year=1997&journal=Journal+of+Cognitive+Neuroscience&volume=9&pages=pp.+512%E2%80%93521&pmid=23968214)
62. 1. [Pfeiffer BE](https://scholar.google.com/scholar?q=%22author:Pfeiffer+BE%22)
	2. [Foster DJ](https://scholar.google.com/scholar?q=%22author:Foster+DJ%22)
	(2015) [Place cells. autoassociative dynamics in the generation of sequences of hippocampal place cells](https://doi.org/10.1126/science.aaa9633)
	*Science* **349**:180–183.
	[https://doi.org/10.1126/science.aaa9633](https://doi.org/10.1126/science.aaa9633)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/26160946)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Place+cells.+autoassociative+dynamics+in+the+generation+of+sequences+of+hippocampal+place+cells&author=Pfeiffer+BE&author=Foster+DJ&publication_year=2015&journal=Science&volume=349&pages=pp.+180%E2%80%93183&pmid=26160946)
63. 1. [Poucet B](https://scholar.google.com/scholar?q=%22author:Poucet+B%22)
	2. [Sargolini F](https://scholar.google.com/scholar?q=%22author:Sargolini+F%22)
	3. [Song EY](https://scholar.google.com/scholar?q=%22author:Song+EY%22)
	4. [Hangya B](https://scholar.google.com/scholar?q=%22author:Hangya+B%22)
	5. [Fox S](https://scholar.google.com/scholar?q=%22author:Fox+S%22)
	6. [Muller RU](https://scholar.google.com/scholar?q=%22author:Muller+RU%22)
	(2014) [Independence of landmark and self-motion-guided navigation: a different role for grid cells](https://doi.org/10.1098/rstb.2013.0370)
	*Philosophical Transactions of the Royal Society B: Biological Sciences* **369**:20130370.
	[https://doi.org/10.1098/rstb.2013.0370](https://doi.org/10.1098/rstb.2013.0370)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Independence+of+landmark+and+self-motion-guided+navigation%3A+a+different+role+for+grid+cells&author=Poucet+B&author=Sargolini+F&author%5B2%5D=Song+EY&author%5B3%5D=Hangya+B&author%5B4%5D=Fox+S&author%5B5%5D=Muller+RU&publication_year=2014&journal=Philosophical+Transactions+of+the+Royal+Society+B%3A+Biological+Sciences&volume=369&pages=20130370)
64. 1. [Pouget A](https://scholar.google.com/scholar?q=%22author:Pouget+A%22)
	2. [Sejnowski TJ](https://scholar.google.com/scholar?q=%22author:Sejnowski+TJ%22)
	(1997) [Spatial transformations in the parietal cortex using basis functions](https://doi.org/10.1162/jocn.1997.9.2.222)
	*Journal of Cognitive Neuroscience* **9**:222–237.
	[https://doi.org/10.1162/jocn.1997.9.2.222](https://doi.org/10.1162/jocn.1997.9.2.222)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/23962013)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Spatial+transformations+in+the+parietal+cortex+using+basis+functions&author=Pouget+A&author=Sejnowski+TJ&publication_year=1997&journal=Journal+of+Cognitive+Neuroscience&volume=9&pages=pp.+222%E2%80%93237&pmid=23962013)
65. 1. [Raudies F](https://scholar.google.com/scholar?q=%22author:Raudies+F%22)
	2. [Brandon MP](https://scholar.google.com/scholar?q=%22author:Brandon+MP%22)
	3. [Chapman GW](https://scholar.google.com/scholar?q=%22author:Chapman+GW%22)
	4. [Hasselmo ME](https://scholar.google.com/scholar?q=%22author:Hasselmo+ME%22)
	(2015) [Head direction is coded more strongly than movement direction in a population of entorhinal neurons](https://doi.org/10.1016/j.brainres.2014.10.053)
	*Brain Research* **1621**:355–367.
	[https://doi.org/10.1016/j.brainres.2014.10.053](https://doi.org/10.1016/j.brainres.2014.10.053)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/25451111)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Head+direction+is+coded+more+strongly+than+movement+direction+in+a+population+of+entorhinal+neurons&author=Raudies+F&author=Brandon+MP&author%5B2%5D=Chapman+GW&author%5B3%5D=Hasselmo+ME&publication_year=2015&journal=Brain+Research&volume=1621&pages=pp.+355%E2%80%93367&pmid=25451111)
66. 1. [Sack AT](https://scholar.google.com/scholar?q=%22author:Sack+AT%22)
	2. [Sperling JM](https://scholar.google.com/scholar?q=%22author:Sperling+JM%22)
	3. [Prvulovic D](https://scholar.google.com/scholar?q=%22author:Prvulovic+D%22)
	4. [Formisano E](https://scholar.google.com/scholar?q=%22author:Formisano+E%22)
	5. [Goebel R](https://scholar.google.com/scholar?q=%22author:Goebel+R%22)
	6. [Di Salle F](https://scholar.google.com/scholar?q=%22author:Di+Salle+F%22)
	7. [Dierks T](https://scholar.google.com/scholar?q=%22author:Dierks+T%22)
	8. [Linden DE](https://scholar.google.com/scholar?q=%22author:Linden+DE%22)
	(2002) [Tracking the mind's image in the brain II: transcranial magnetic stimulation reveals parietal asymmetry in visuospatial imagery](https://doi.org/10.1016/S0896-6273\(02\)00745-6)
	*Neuron* **35**:195–204.
	[https://doi.org/10.1016/S0896-6273(02)00745-6](https://doi.org/10.1016/S0896-6273\(02\)00745-6)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/12123619)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Tracking+the+mind%27s+image+in+the+brain+II%3A+transcranial+magnetic+stimulation+reveals+parietal+asymmetry+in+visuospatial+imagery&author=Sack+AT&author=Sperling+JM&author%5B2%5D=Prvulovic+D&author%5B3%5D=Formisano+E&author%5B4%5D=Goebel+R&author%5B5%5D=Di+Salle+F&author%5B6%5D=Dierks+T&author%5B7%5D=Linden+DE&publication_year=2002&journal=Neuron&volume=35&pages=pp.+195%E2%80%93204&pmid=12123619)
67. 1. [Salinas E](https://scholar.google.com/scholar?q=%22author:Salinas+E%22)
	2. [Abbott LF](https://scholar.google.com/scholar?q=%22author:Abbott+LF%22)
	(1995) [Transfer of coded information from sensory to motor networks](https://doi.org/10.1523/JNEUROSCI.15-10-06461.1995)
	*The Journal of Neuroscience* **15**:6461–6474.
	[https://doi.org/10.1523/JNEUROSCI.15-10-06461.1995](https://doi.org/10.1523/JNEUROSCI.15-10-06461.1995)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/7472409)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Transfer+of+coded+information+from+sensory+to+motor+networks&author=Salinas+E&author=Abbott+LF&publication_year=1995&journal=The+Journal+of+Neuroscience&volume=15&pages=pp.+6461%E2%80%936474&pmid=7472409)
68. 1. [Sargolini F](https://scholar.google.com/scholar?q=%22author:Sargolini+F%22)
	2. [Fyhn M](https://scholar.google.com/scholar?q=%22author:Fyhn+M%22)
	3. [Hafting T](https://scholar.google.com/scholar?q=%22author:Hafting+T%22)
	4. [McNaughton BL](https://scholar.google.com/scholar?q=%22author:McNaughton+BL%22)
	5. [Witter MP](https://scholar.google.com/scholar?q=%22author:Witter+MP%22)
	6. [Moser MB](https://scholar.google.com/scholar?q=%22author:Moser+MB%22)
	7. [Moser EI](https://scholar.google.com/scholar?q=%22author:Moser+EI%22)
	(2006) [Conjunctive representation of position, direction, and velocity in entorhinal cortex](https://doi.org/10.1126/science.1125572)
	*Science* **312**:758–762.
	[https://doi.org/10.1126/science.1125572](https://doi.org/10.1126/science.1125572)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/16675704)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Conjunctive+representation+of+position%2C+direction%2C+and+velocity+in+entorhinal+cortex&author=Sargolini+F&author=Fyhn+M&author%5B2%5D=Hafting+T&author%5B3%5D=McNaughton+BL&author%5B4%5D=Witter+MP&author%5B5%5D=Moser+MB&author%5B6%5D=Moser+EI&publication_year=2006&journal=Science&volume=312&pages=pp.+758%E2%80%93762&pmid=16675704)
69. 1. [Save E](https://scholar.google.com/scholar?q=%22author:Save+E%22)
	2. [Poucet B](https://scholar.google.com/scholar?q=%22author:Poucet+B%22)
	(2009) [Role of the parietal cortex in long-term representation of spatial information in the rat](https://doi.org/10.1016/j.nlm.2008.08.005)
	*Neurobiology of Learning and Memory* **91**:172–178.
	[https://doi.org/10.1016/j.nlm.2008.08.005](https://doi.org/10.1016/j.nlm.2008.08.005)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/18782629)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Role+of+the+parietal+cortex+in+long-term+representation+of+spatial+information+in+the+rat&author=Save+E&author=Poucet+B&publication_year=2009&journal=Neurobiology+of+Learning+and+Memory&volume=91&pages=pp.+172%E2%80%93178&pmid=18782629)
70. 1. [Shine JP](https://scholar.google.com/scholar?q=%22author:Shine+JP%22)
	2. [Valdés-Herrera JP](https://scholar.google.com/scholar?q=%22author:Vald%C3%A9s-Herrera+JP%22)
	3. [Hegarty M](https://scholar.google.com/scholar?q=%22author:Hegarty+M%22)
	4. [Wolbers T](https://scholar.google.com/scholar?q=%22author:Wolbers+T%22)
	(2016) [The human retrosplenial cortex and thalamus code head direction in a global reference frame](https://doi.org/10.1523/JNEUROSCI.1268-15.2016)
	*The Journal of Neuroscience* **36**:6371–6381.
	[https://doi.org/10.1523/JNEUROSCI.1268-15.2016](https://doi.org/10.1523/JNEUROSCI.1268-15.2016)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/27307227)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=The+human+retrosplenial+cortex+and+thalamus+code+head+direction+in+a+global+reference+frame&author=Shine+JP&author=Vald%C3%A9s-Herrera+JP&author%5B2%5D=Hegarty+M&author%5B3%5D=Wolbers+T&publication_year=2016&journal=The+Journal+of+Neuroscience&volume=36&pages=pp.+6371%E2%80%936381&pmid=27307227)
71. 1. [Skaggs WE](https://scholar.google.com/scholar?q=%22author:Skaggs+WE%22)
	2. [Knierim JJ](https://scholar.google.com/scholar?q=%22author:Knierim+JJ%22)
	3. [Kudrimoti HS](https://scholar.google.com/scholar?q=%22author:Kudrimoti+HS%22)
	4. [McNaughton BL](https://scholar.google.com/scholar?q=%22author:McNaughton+BL%22)
	(1995)
	A model of the neural basis of the rat's sense of direction
	*Advances in Neural Information Processing Systems* **7**:173–182.
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/11539168)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=A+model+of+the+neural+basis+of+the+rat%27s+sense+of+direction&author=Skaggs+WE&author=Knierim+JJ&author%5B2%5D=Kudrimoti+HS&author%5B3%5D=McNaughton+BL&publication_year=1995&journal=Advances+in+Neural+Information+Processing+Systems&volume=7&pages=pp.+173%E2%80%93182&pmid=11539168)
72. 1. [Song P](https://scholar.google.com/scholar?q=%22author:Song+P%22)
	2. [Wang XJ](https://scholar.google.com/scholar?q=%22author:Wang+XJ%22)
	(2005) [Angular path integration by moving "hill of activity": a spiking neuron model without recurrent excitation of the head-direction system](https://doi.org/10.1523/JNEUROSCI.4172-04.2005)
	*Journal of Neuroscience* **25**:1002–1014.
	[https://doi.org/10.1523/JNEUROSCI.4172-04.2005](https://doi.org/10.1523/JNEUROSCI.4172-04.2005)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/15673682)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Angular+path+integration+by+moving+%22hill+of+activity%22%3A+a+spiking+neuron+model+without+recurrent+excitation+of+the+head-direction+system&author=Song+P&author=Wang+XJ&publication_year=2005&journal=Journal+of+Neuroscience&volume=25&pages=pp.+1002%E2%80%931014&pmid=15673682)
73. 1. [Squire LR](https://scholar.google.com/scholar?q=%22author:Squire+LR%22)
	2. [Amaral DG](https://scholar.google.com/scholar?q=%22author:Amaral+DG%22)
	3. [Zola-Morgan S](https://scholar.google.com/scholar?q=%22author:Zola-Morgan+S%22)
	4. [Kritchevsky M](https://scholar.google.com/scholar?q=%22author:Kritchevsky+M%22)
	5. [Press G](https://scholar.google.com/scholar?q=%22author:Press+G%22)
	(1989) [Description of brain injury in the amnesic patient N.A. based on magnetic resonance imaging](https://doi.org/10.1016/0014-4886\(89\)90168-4)
	*Experimental Neurology* **105**:23–35.
	[https://doi.org/10.1016/0014-4886(89)90168-4](https://doi.org/10.1016/0014-4886\(89\)90168-4)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/2744126)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Description+of+brain+injury+in+the+amnesic+patient+N.A.+based+on+magnetic+resonance+imaging&author=Squire+LR&author=Amaral+DG&author%5B2%5D=Zola-Morgan+S&author%5B3%5D=Kritchevsky+M&author%5B4%5D=Press+G&publication_year=1989&journal=Experimental+Neurology&volume=105&pages=pp.+23%E2%80%9335&pmid=2744126)
74. 1. [Squire LR](https://scholar.google.com/scholar?q=%22author:Squire+LR%22)
	2. [Slater PC](https://scholar.google.com/scholar?q=%22author:Slater+PC%22)
	(1978) [Anterograde and retrograde memory impairment in chronic amnesia](https://doi.org/10.1016/0028-3932\(78\)90025-8)
	*Neuropsychologia* **16**:313–322.
	[https://doi.org/10.1016/0028-3932(78)90025-8](https://doi.org/10.1016/0028-3932\(78\)90025-8)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/703946)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Anterograde+and+retrograde+memory+impairment+in+chronic+amnesia&author=Squire+LR&author=Slater+PC&publication_year=1978&journal=Neuropsychologia&volume=16&pages=pp.+313%E2%80%93322&pmid=703946)
75. 1. [Taube JS](https://scholar.google.com/scholar?q=%22author:Taube+JS%22)
	2. [Muller RU](https://scholar.google.com/scholar?q=%22author:Muller+RU%22)
	3. [Ranck JB](https://scholar.google.com/scholar?q=%22author:Ranck+JB%22)
	(1990a) [Head-direction cells recorded from the postsubiculum in freely moving rats. I. Description and quantitative analysis](https://doi.org/10.1523/JNEUROSCI.10-02-00420.1990)
	*The Journal of Neuroscience* **10**:420–435.
	[https://doi.org/10.1523/JNEUROSCI.10-02-00420.1990](https://doi.org/10.1523/JNEUROSCI.10-02-00420.1990)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/2303851)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Head-direction+cells+recorded+from+the+postsubiculum+in+freely+moving+rats.+I.+Description+and+quantitative+analysis&author=Taube+JS&author=Muller+RU&author%5B2%5D=Ranck+JB&publication_year=1990&journal=The+Journal+of+Neuroscience&volume=10&pages=pp.+420%E2%80%93435&pmid=2303851)
76. 1. [Taube JS](https://scholar.google.com/scholar?q=%22author:Taube+JS%22)
	2. [Muller RU](https://scholar.google.com/scholar?q=%22author:Muller+RU%22)
	3. [Ranck JB](https://scholar.google.com/scholar?q=%22author:Ranck+JB%22)
	(1990b) [Head-direction cells recorded from the postsubiculum in freely moving rats. II. Effects of environmental manipulations](https://doi.org/10.1523/JNEUROSCI.10-02-00436.1990)
	*The Journal of Neuroscience* **10**:436–447.
	[https://doi.org/10.1523/JNEUROSCI.10-02-00436.1990](https://doi.org/10.1523/JNEUROSCI.10-02-00436.1990)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/2303852)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Head-direction+cells+recorded+from+the+postsubiculum+in+freely+moving+rats.+II.+Effects+of+environmental+manipulations&author=Taube+JS&author=Muller+RU&author%5B2%5D=Ranck+JB&publication_year=1990&journal=The+Journal+of+Neuroscience&volume=10&pages=pp.+436%E2%80%93447&pmid=2303852)
77. 1. [Taube JS](https://scholar.google.com/scholar?q=%22author:Taube+JS%22)
	2. [Ranck JB](https://scholar.google.com/scholar?q=%22author:Ranck+JB%22)
	(1990)
	Head direction cells in the deep layer of dorsal presubiculum in freely moving rats. InSociety of neuroscience abstract
	*The Journal of Neuroscience: The Official Journal of the Society for Neuroscience* **10**:420–435.
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Head+direction+cells+in+the+deep+layer+of+dorsal+presubiculum+in+freely+moving+rats.+InSociety+of+neuroscience+abstract&author=Taube+JS&author=Ranck+JB&publication_year=1990&journal=The+Journal+of+Neuroscience+%3A+The+Official+Journal+of+the+Society+for+Neuroscience&volume=10&pages=pp.+420%E2%80%93435)
78. 1. [Taube JS](https://scholar.google.com/scholar?q=%22author:Taube+JS%22)
	(2007) [The head direction signal: origins and sensory-motor integration](https://doi.org/10.1146/annurev.neuro.29.051605.112854)
	*Annual Review of Neuroscience* **30**:181–207.
	[https://doi.org/10.1146/annurev.neuro.29.051605.112854](https://doi.org/10.1146/annurev.neuro.29.051605.112854)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/17341158)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=The+head+direction+signal%3A+origins+and+sensory-motor+integration&author=Taube+JS&publication_year=2007&journal=Annual+Review+of+Neuroscience&volume=30&pages=pp.+181%E2%80%93207&pmid=17341158)
79. 1. [Tolman EC](https://scholar.google.com/scholar?q=%22author:Tolman+EC%22)
	(1948) [Cognitive maps in rats and men](https://doi.org/10.1037/h0061626)
	*Psychological Review* **55**:189–208.
	[https://doi.org/10.1037/h0061626](https://doi.org/10.1037/h0061626)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/18870876)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Cognitive+maps+in+rats+and+men&author=Tolman+EC&publication_year=1948&journal=Psychological+Review&volume=55&pages=pp.+189%E2%80%93208&pmid=18870876)
80. Preprint
	1. [Trettel SG](https://scholar.google.com/scholar?q=%22author:Trettel+SG%22)
	2. [Trimper JB](https://scholar.google.com/scholar?q=%22author:Trimper+JB%22)
	3. [Hwaun E](https://scholar.google.com/scholar?q=%22author:Hwaun+E%22)
	4. [Fiete IR](https://scholar.google.com/scholar?q=%22author:Fiete+IR%22)
	5. [Colgin LL](https://scholar.google.com/scholar?q=%22author:Colgin+LL%22)
	(2017) [Grid cell co-activity patterns during sleep reflect spatial overlap of grid fields during active behaviors](https://doi.org/10.1101/198671)
	bioRxiv.
	[https://doi.org/10.1101/198671](https://doi.org/10.1101/198671)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Grid+cell+co-activity+patterns+during+sleep+reflect+spatial+overlap+of+grid+fields+during+active+behaviors&author=Trettel+SG&author=Trimper+JB&author%5B2%5D=Hwaun+E&author%5B3%5D=Fiete+IR&author%5B4%5D=Colgin+LL&publication_year=2017)
81. 1. [Tsivilis D](https://scholar.google.com/scholar?q=%22author:Tsivilis+D%22)
	2. [Vann SD](https://scholar.google.com/scholar?q=%22author:Vann+SD%22)
	3. [Denby C](https://scholar.google.com/scholar?q=%22author:Denby+C%22)
	4. [Roberts N](https://scholar.google.com/scholar?q=%22author:Roberts+N%22)
	5. [Mayes AR](https://scholar.google.com/scholar?q=%22author:Mayes+AR%22)
	6. [Montaldi D](https://scholar.google.com/scholar?q=%22author:Montaldi+D%22)
	7. [Aggleton JP](https://scholar.google.com/scholar?q=%22author:Aggleton+JP%22)
	(2008) [A disproportionate role for the fornix and mammillary bodies in recall versus recognition memory](https://doi.org/10.1038/nn.2149)
	*Nature Neuroscience* **11**:834–842.
	[https://doi.org/10.1038/nn.2149](https://doi.org/10.1038/nn.2149)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/18552840)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=A+disproportionate+role+for+the+fornix+and+mammillary+bodies+in+recall+versus+recognition+memory&author=Tsivilis+D&author=Vann+SD&author%5B2%5D=Denby+C&author%5B3%5D=Roberts+N&author%5B4%5D=Mayes+AR&author%5B5%5D=Montaldi+D&author%5B6%5D=Aggleton+JP&publication_year=2008&journal=Nature+Neuroscience&volume=11&pages=pp.+834%E2%80%93842&pmid=18552840)
82. Book
	1. [Tulving E](https://scholar.google.com/scholar?q=%22author:Tulving+E%22)
	(1983)
	Elements of Episodic Memory
	Clarenden Press.
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Elements+of+Episodic+Memory&author=Tulving+E&publication_year=1983)
83. 1. [Ungerleider LG](https://scholar.google.com/scholar?q=%22author:Ungerleider+LG%22)
	(1982)
	Two cortical visual systems
	*Analysis of visual behavior* pp. 549–586.
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Two+cortical+visual+systems&author=Ungerleider+LG&publication_year=1982&journal=Analysis+of+visual+behavior&pages=pp.+549%E2%80%93586)
84. 1. [Valyear KF](https://scholar.google.com/scholar?q=%22author:Valyear+KF%22)
	2. [Culham JC](https://scholar.google.com/scholar?q=%22author:Culham+JC%22)
	3. [Sharif N](https://scholar.google.com/scholar?q=%22author:Sharif+N%22)
	4. [Westwood D](https://scholar.google.com/scholar?q=%22author:Westwood+D%22)
	5. [Goodale MA](https://scholar.google.com/scholar?q=%22author:Goodale+MA%22)
	(2006) [A double dissociation between sensitivity to changes in object identity and object orientation in the ventral and dorsal visual streams: a human fMRI study](https://doi.org/10.1016/j.neuropsychologia.2005.05.004)
	*Neuropsychologia* **44**:218–228.
	[https://doi.org/10.1016/j.neuropsychologia.2005.05.004](https://doi.org/10.1016/j.neuropsychologia.2005.05.004)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/15955539)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=A+double+dissociation+between+sensitivity+to+changes+in+object+identity+and+object+orientation+in+the+ventral+and+dorsal+visual+streams%3A+a+human+fMRI+study&author=Valyear+KF&author=Culham+JC&author%5B2%5D=Sharif+N&author%5B3%5D=Westwood+D&author%5B4%5D=Goodale+MA&publication_year=2006&journal=Neuropsychologia&volume=44&pages=pp.+218%E2%80%93228&pmid=15955539)
85. 1. [Van Cauter T](https://scholar.google.com/scholar?q=%22author:Van+Cauter+T%22)
	2. [Camon J](https://scholar.google.com/scholar?q=%22author:Camon+J%22)
	3. [Alvernhe A](https://scholar.google.com/scholar?q=%22author:Alvernhe+A%22)
	4. [Elduayen C](https://scholar.google.com/scholar?q=%22author:Elduayen+C%22)
	5. [Sargolini F](https://scholar.google.com/scholar?q=%22author:Sargolini+F%22)
	6. [Save E](https://scholar.google.com/scholar?q=%22author:Save+E%22)
	(2013) [Distinct roles of medial and lateral entorhinal cortex in spatial cognition](https://doi.org/10.1093/cercor/bhs033)
	*Cerebral Cortex* **23**:451–459.
	[https://doi.org/10.1093/cercor/bhs033](https://doi.org/10.1093/cercor/bhs033)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/22357665)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Distinct+roles+of+medial+and+lateral+entorhinal+cortex+in+spatial+cognition&author=Van+Cauter+T&author=Camon+J&author%5B2%5D=Alvernhe+A&author%5B3%5D=Elduayen+C&author%5B4%5D=Sargolini+F&author%5B5%5D=Save+E&publication_year=2013&journal=Cerebral+Cortex&volume=23&pages=pp.+451%E2%80%93459&pmid=22357665)
86. 1. [VanRullen R](https://scholar.google.com/scholar?q=%22author:VanRullen+R%22)
	2. [Carlson T](https://scholar.google.com/scholar?q=%22author:Carlson+T%22)
	3. [Cavanagh P](https://scholar.google.com/scholar?q=%22author:Cavanagh+P%22)
	(2007) [The blinking spotlight of attention](https://doi.org/10.1073/pnas.0707316104)
	*PNAS* **104**:19204–19209.
	[https://doi.org/10.1073/pnas.0707316104](https://doi.org/10.1073/pnas.0707316104)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=The+blinking+spotlight+of+attention&author=VanRullen+R&author=Carlson+T&author%5B2%5D=Cavanagh+P&publication_year=2007&journal=PNAS&volume=104&pages=pp.+19204%E2%80%9319209)
87. 1. [VanRullen R](https://scholar.google.com/scholar?q=%22author:VanRullen+R%22)
	(2013) [Visual attention: a rhythmic process?](https://doi.org/10.1016/j.cub.2013.11.006)
	*Current Biology* **23**:R1110–R1112.
	[https://doi.org/10.1016/j.cub.2013.11.006](https://doi.org/10.1016/j.cub.2013.11.006)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/24355791)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Visual+attention%3A+a+rhythmic+process%3F&author=VanRullen+R&publication_year=2013&journal=Current+Biology&volume=23&pages=pp.+R1110%E2%80%93R1112&pmid=24355791)
88. 1. [Warburton EC](https://scholar.google.com/scholar?q=%22author:Warburton+EC%22)
	2. [Brown MW](https://scholar.google.com/scholar?q=%22author:Brown+MW%22)
	(2010) [Findings from animals concerning when interactions between perirhinal cortex, hippocampus and medial prefrontal cortex are necessary for recognition memory](https://doi.org/10.1016/j.neuropsychologia.2009.12.022)
	*Neuropsychologia* **48**:2262–2272.
	[https://doi.org/10.1016/j.neuropsychologia.2009.12.022](https://doi.org/10.1016/j.neuropsychologia.2009.12.022)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/20026141)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Findings+from+animals+concerning+when+interactions+between+perirhinal+cortex%2C+hippocampus+and+medial+prefrontal+cortex+are+necessary+for+recognition+memory&author=Warburton+EC&author=Brown+MW&publication_year=2010&journal=Neuropsychologia&volume=48&pages=pp.+2262%E2%80%932272&pmid=20026141)
89. 1. [Welday AC](https://scholar.google.com/scholar?q=%22author:Welday+AC%22)
	2. [Shlifer IG](https://scholar.google.com/scholar?q=%22author:Shlifer+IG%22)
	3. [Bloom ML](https://scholar.google.com/scholar?q=%22author:Bloom+ML%22)
	4. [Zhang K](https://scholar.google.com/scholar?q=%22author:Zhang+K%22)
	5. [Blair HT](https://scholar.google.com/scholar?q=%22author:Blair+HT%22)
	(2011) [Cosine directional tuning of theta cell burst frequencies: evidence for spatial coding by oscillatory interference](https://doi.org/10.1523/JNEUROSCI.0712-11.2011)
	*Journal of Neuroscience* **31**:16157–16176.
	[https://doi.org/10.1523/JNEUROSCI.0712-11.2011](https://doi.org/10.1523/JNEUROSCI.0712-11.2011)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/22072668)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Cosine+directional+tuning+of+theta+cell+burst+frequencies%3A+evidence+for+spatial+coding+by+oscillatory+interference&author=Welday+AC&author=Shlifer+IG&author%5B2%5D=Bloom+ML&author%5B3%5D=Zhang+K&author%5B4%5D=Blair+HT&publication_year=2011&journal=Journal+of+Neuroscience&volume=31&pages=pp.+16157%E2%80%9316176&pmid=22072668)
90. 1. [Wilber AA](https://scholar.google.com/scholar?q=%22author:Wilber+AA%22)
	2. [Clark BJ](https://scholar.google.com/scholar?q=%22author:Clark+BJ%22)
	3. [Forster TC](https://scholar.google.com/scholar?q=%22author:Forster+TC%22)
	4. [Tatsuno M](https://scholar.google.com/scholar?q=%22author:Tatsuno+M%22)
	5. [McNaughton BL](https://scholar.google.com/scholar?q=%22author:McNaughton+BL%22)
	(2014) [Interaction of egocentric and world-centered reference frames in the rat posterior parietal cortex](https://doi.org/10.1523/JNEUROSCI.0511-14.2014)
	*Journal of Neuroscience* **34**:5431–5446.
	[https://doi.org/10.1523/JNEUROSCI.0511-14.2014](https://doi.org/10.1523/JNEUROSCI.0511-14.2014)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/24741034)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Interaction+of+egocentric+and+world-centered+reference+frames+in+the+rat+posterior+parietal+cortex&author=Wilber+AA&author=Clark+BJ&author%5B2%5D=Forster+TC&author%5B3%5D=Tatsuno+M&author%5B4%5D=McNaughton+BL&publication_year=2014&journal=Journal+of+Neuroscience&volume=34&pages=pp.+5431%E2%80%935446&pmid=24741034)
91. 1. [Wilson MA](https://scholar.google.com/scholar?q=%22author:Wilson+MA%22)
	2. [McNaughton BL](https://scholar.google.com/scholar?q=%22author:McNaughton+BL%22)
	(1994) [Reactivation of hippocampal ensemble memories during sleep](https://doi.org/10.1126/science.8036517)
	*Science* **265**:676–679.
	[https://doi.org/10.1126/science.8036517](https://doi.org/10.1126/science.8036517)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/8036517)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Reactivation+of+hippocampal+ensemble+memories+during+sleep&author=Wilson+MA&author=McNaughton+BL&publication_year=1994&journal=Science&volume=265&pages=pp.+676%E2%80%93679&pmid=8036517)
92. 1. [Winters BD](https://scholar.google.com/scholar?q=%22author:Winters+BD%22)
	2. [Forwood SE](https://scholar.google.com/scholar?q=%22author:Forwood+SE%22)
	3. [Cowell RA](https://scholar.google.com/scholar?q=%22author:Cowell+RA%22)
	4. [Saksida LM](https://scholar.google.com/scholar?q=%22author:Saksida+LM%22)
	5. [Bussey TJ](https://scholar.google.com/scholar?q=%22author:Bussey+TJ%22)
	(2004) [Double dissociation between the effects of peri-postrhinal cortex and hippocampal lesions on tests of object recognition and spatial memory: heterogeneity of function within the temporal lobe](https://doi.org/10.1523/JNEUROSCI.1346-04.2004)
	*Journal of Neuroscience* **24**:5901–5908.
	[https://doi.org/10.1523/JNEUROSCI.1346-04.2004](https://doi.org/10.1523/JNEUROSCI.1346-04.2004)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/15229237)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Double+dissociation+between+the+effects+of+peri-postrhinal+cortex+and+hippocampal+lesions+on+tests+of+object+recognition+and+spatial+memory%3A+heterogeneity+of+function+within+the+temporal+lobe&author=Winters+BD&author=Forwood+SE&author%5B2%5D=Cowell+RA&author%5B3%5D=Saksida+LM&author%5B4%5D=Bussey+TJ&publication_year=2004&journal=Journal+of+Neuroscience&volume=24&pages=pp.+5901%E2%80%935908&pmid=15229237)
93. 1. [Wyss JM](https://scholar.google.com/scholar?q=%22author:Wyss+JM%22)
	2. [Van Groen T](https://scholar.google.com/scholar?q=%22author:Van+Groen+T%22)
	(1992) [Connections between the retrosplenial cortex and the hippocampal formation in the rat: a review](https://doi.org/10.1002/hipo.450020102)
	*Hippocampus* **2**:1–11.
	[https://doi.org/10.1002/hipo.450020102](https://doi.org/10.1002/hipo.450020102)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/1308170)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Connections+between+the+retrosplenial+cortex+and+the+hippocampal+formation+in+the+rat%3A+a+review&author=Wyss+JM&author=Van+Groen+T&publication_year=1992&journal=Hippocampus&volume=2&pages=pp.+1%E2%80%9311&pmid=1308170)
94. 1. [Yamamoto J](https://scholar.google.com/scholar?q=%22author:Yamamoto+J%22)
	2. [Tonegawa S](https://scholar.google.com/scholar?q=%22author:Tonegawa+S%22)
	(2017) [Direct Medial Entorhinal Cortex Input to Hippocampal CA1 Is Crucial for Extended Quiet Awake Replay](https://doi.org/10.1016/j.neuron.2017.09.017)
	*Neuron* **96**:217–227.
	[https://doi.org/10.1016/j.neuron.2017.09.017](https://doi.org/10.1016/j.neuron.2017.09.017)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/28957670)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Direct+Medial+Entorhinal+Cortex+Input+to+Hippocampal+CA1+Is+Crucial+for+Extended+Quiet+Awake+Replay&author=Yamamoto+J&author=Tonegawa+S&publication_year=2017&journal=Neuron&volume=96&pages=pp.+217%E2%80%93227&pmid=28957670)
95. 1. [Zhang K](https://scholar.google.com/scholar?q=%22author:Zhang+K%22)
	(1996) [Representation of spatial orientation by the intrinsic dynamics of the head-direction cell ensemble: a theory](https://doi.org/10.1523/JNEUROSCI.16-06-02112.1996)
	*The Journal of Neuroscience* **16**:2112–2126.
	[https://doi.org/10.1523/JNEUROSCI.16-06-02112.1996](https://doi.org/10.1523/JNEUROSCI.16-06-02112.1996)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/8604055)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Representation+of+spatial+orientation+by+the+intrinsic+dynamics+of+the+head-direction+cell+ensemble%3A+a+theory&author=Zhang+K&publication_year=1996&journal=The+Journal+of+Neuroscience&volume=16&pages=pp.+2112%E2%80%932126&pmid=8604055)

### Author details

1. #### Andrej Bicanski
	Institute of Cognitive Neuroscience, University College London, London, United Kingdom
	##### Contribution
	Conceptualization, Software, Formal analysis, Investigation, Visualization, Methodology, Writing—original draft, Project administration, Writing—review and editing
	##### For correspondence
	[a.bicanski@ucl.ac.uk](mailto:a.bicanski@ucl.ac.uk)
	##### Competing interests
	No competing interests declared
	![](https://elifesciences.org/assets/patterns/img/icons/orcid.5d420edc.svg)
2. #### Neil Burgess
	Institute of Cognitive Neuroscience, University College London, London, United Kingdom
	##### Contribution
	Conceptualization, Supervision, Funding acquisition, Methodology, Project administration, Writing—review and editing
	##### For correspondence
	[n.burgess@ucl.ac.uk](mailto:n.burgess@ucl.ac.uk)
	##### Competing interests
	Reviewing Editor, eLife
	![](https://elifesciences.org/assets/patterns/img/icons/orcid.5d420edc.svg)

- Andrej Bicanski
- Neil Burgess

- Andrej Bicanski
- Neil Burgess

- Andrej Bicanski
- Neil Burgess

- Andrej Bicanski
- Neil Burgess

- Neil Burgess

The funders had no role in study design, data collection and interpretation, or the decision to submit the work for publication.

We acknowledge funding by the ERC Advanced grant NEUROMEM, the Wellcome Trust, the European Union’s Horizon 2020 research and innovation programme under grant agreement No. 720270 Human Brain Project SGA1 and grant agreement No. 785907 Human Brain Project SGA2, and the EC Framework Program 7 Future and Emerging Technologies project SpaceCog. We thank all members of the SpaceCog project, and James Bisby, Daniel Bush and Tim Behrens for useful discussions. The authors declare no competing financial interests.

- 9,476
	views
- 1,196
	downloads
- 234
	citations

Views, downloads and citations are aggregated across all versions of this paper published by eLife.

### Citations by DOI

- 234
	citations for umbrella DOI [https://doi.org/10.7554/eLife.33752](https://doi.org/10.7554/eLife.33752)

[![Article has an altmetric score of 84](https://badges.altmetric.com/?size=240&score=84&types=mabttttt)](https://www.altmetric.com/details.php?domain=elifesciences.org&citation_id=47630563)

[Picked up by **6** news outlets](https://www.altmetric.com/details.php?domain=elifesciences.org&citation_id=47630563&tab=news)

[Blogged by **2**](https://www.altmetric.com/details.php?domain=elifesciences.org&citation_id=47630563&tab=blogs)

[Posted by **43** X users](https://www.altmetric.com/details.php?domain=elifesciences.org&citation_id=47630563&tab=twitter)

[Referenced in **2** patents](https://www.altmetric.com/details.php?domain=elifesciences.org&citation_id=47630563&tab=patents)

**320** readers on Mendeley

[https://doi.org/10.7554/eLife.33752](https://doi.org/10.7554/eLife.33752)

[^1]: Figure 2 with 1 supplement

[Download asset](https://elifesciences.org/download/aHR0cHM6Ly9paWlmLmVsaWZlc2NpZW5jZXMub3JnL2xheC8zMzc1MiUyRmVsaWZlLTMzNzUyLWZpZzItdjEudGlmL2Z1bGwvZnVsbC8wL2RlZmF1bHQuanBn/elife-33752-fig2-v1.jpg?_hash=hY%2BU0kxeQSejrzp8W6N64EG%2BpxZDjOmOnXWk9teTWHI%3D) [Open asset](https://iiif.elifesciences.org/lax/33752%2Felife-33752-fig2-v1.tif/full/1500,/0/default.jpg)

![](https://iiif.elifesciences.org/lax/33752%2Felife-33752-fig2-v1.tif/full/1234,/0/default.webp)

Receptive field topology and visualization of neural activity. ( A1 ) Illustration of the distribution of receptive field centers (RFs) of place cells (PCs), which tile the environment. ( A2 ) Receptive fields of boundary responsive neurons, be they allocentric … see more ↩ https://doi.org/10.7554/eLife.33752.003

[^2]: Figure 3

[Download asset](https://elifesciences.org/download/aHR0cHM6Ly9paWlmLmVsaWZlc2NpZW5jZXMub3JnL2xheC8zMzc1MiUyRmVsaWZlLTMzNzUyLWZpZzMtdjEudGlmL2Z1bGwvZnVsbC8wL2RlZmF1bHQuanBn/elife-33752-fig3-v1.jpg?_hash=C8K5NxHjaPrTNNx0c%2B5qzi7KtIagizBGGt1mAIhyXMg%3D) [Open asset](https://iiif.elifesciences.org/lax/33752%2Felife-33752-fig3-v1.tif/full/1500,/0/default.jpg)

![](https://iiif.elifesciences.org/lax/33752%2Felife-33752-fig3-v1.tif/full/1234,/0/default.webp)

The agent model and population snapshots for object representations. ( A ) Top panel: The egocentric field of view of the agent (black arrow head). Purple boundaries fall into the forward-facing 180 degree field of view and provide bottom-up drive to the parietal … see more ↩ https://doi.org/10.7554/eLife.33752.006

[^3]: Figure 4

[Download asset](https://elifesciences.org/download/aHR0cHM6Ly9paWlmLmVsaWZlc2NpZW5jZXMub3JnL2xheC8zMzc1MiUyRmVsaWZlLTMzNzUyLWZpZzQtdjEudGlmL2Z1bGwvZnVsbC8wL2RlZmF1bHQuanBn/elife-33752-fig4-v1.jpg?_hash=gDJJi2XzsNsoCoR6WaXE8vO1woEmJdTnraiCJTNVDAo%3D) [Open asset](https://iiif.elifesciences.org/lax/33752%2Felife-33752-fig4-v1.tif/full/1500,/0/default.jpg)

![](https://iiif.elifesciences.org/lax/33752%2Felife-33752-fig4-v1.tif/full/1234,/0/default.webp)

The BB-model. ‘Bottom-up’ mode of operation: Egocentric representations of extended boundaries (PWb) and discrete objects (PWo) are instantiated in the parietal window (PWb/o) based on inputs from the agent model … see more ↩ https://doi.org/10.7554/eLife.33752.007

[^4]: Figure 6

[Download asset](https://elifesciences.org/download/aHR0cHM6Ly9paWlmLmVsaWZlc2NpZW5jZXMub3JnL2xheC8zMzc1MiUyRmVsaWZlLTMzNzUyLWZpZzYtdjEudGlmL2Z1bGwvZnVsbC8wL2RlZmF1bHQuanBn/elife-33752-fig6-v1.jpg?_hash=XbvkB4UbIpo9VEp7Ogz0NRV4WlCM78cpbtmOfLKHAw0%3D) [Open asset](https://iiif.elifesciences.org/lax/33752%2Felife-33752-fig6-v1.tif/full/1500,/0/default.jpg)

![](https://iiif.elifesciences.org/lax/33752%2Felife-33752-fig6-v1.tif/full/1234,/0/default.webp)

Firing fields of object vector cells. ( A ) Firing rate maps for representative object vector cells (OVCs), firing for objects with a fixed allocentric location and direction relative to the agent. Object locations superimposed as green … see more ↩ https://doi.org/10.7554/eLife.33752.011

Anatomical connections between the potential loci of BVCs/OVCs and retrosplenial cortex (the suggested location of the egocentric-allocentric transformation circuit) exist. BVCs have been found in the subicular complex ([Lever et al., 2009](#bib87)), and the related border cells and OVCs in medial entorhinal cortex ([Solstad et al., 2008](#bib131); [Hoydal et al., 2017](#bib73)). Both areas receive projections from retrosplenial cortex ([Jones and Witter, 2007](#bib77)), and project back to it ([Wyss and Van Groen, 1992](#bib164)).

[^5]: Video 4

[Download asset](https://elifesciences.org/download/aHR0cHM6Ly9zdGF0aWMtbW92aWUtdXNhLmdsZW5jb2Vzb2Z0d2FyZS5jb20vbXA0LzEwLjc1NTQvNTIzLzgyZTgyNjc5MGJmMzNkNTU1MzQxMzZlZTYzZmNjNTE1MGMyNjUxMmUvZWxpZmUtMzM3NTItdmlkZW80Lm1wNA--/elife-33752-video4.mp4?_hash=hVDT7%2FCeS7aKbIAg%2FJMa7kxxlK5YQZxd0x99LYRZSik%3D)

![posterframe for video](https://iiif.elifesciences.org/lax/33752%2Felife-33752-video4.jpg/full/639,/0/default.jpg)

This video shows the same scenario as (object-cued recall), however, with firing rate noise applied to all neurons (max. 20% of peak rate). The agent moves in a familiar environment and encounters a novel object. The agent approaches the object and encodes it into long-term memory. Upon navigating past the object the agent initiates … see more https://doi.org/10.7554/eLife.33752.015

[^6]: Figure 11

[Download asset](https://elifesciences.org/download/aHR0cHM6Ly9paWlmLmVsaWZlc2NpZW5jZXMub3JnL2xheC8zMzc1MiUyRmVsaWZlLTMzNzUyLWZpZzExLXYxLnRpZi9mdWxsL2Z1bGwvMC9kZWZhdWx0LmpwZw--/elife-33752-fig11-v1.jpg?_hash=%2BQfpaAScXw76iDR8qqdEbnGnot4Pz%2FHlEeSmtjMKf88%3D) [Open asset](https://iiif.elifesciences.org/lax/33752%2Felife-33752-fig11-v1.tif/full/1500,/0/default.jpg)

![](https://iiif.elifesciences.org/lax/33752%2Felife-33752-fig11-v1.tif/full/1234,/0/default.webp)

Inspecting scene elements in imagery. The agent encounters two objects. ( A ) Activity in PWo (left) and OVCs (right) populations when the agent is attending to one of the two objects during encoding. Both objects are encoded sequentially … see more ↩ https://doi.org/10.7554/eLife.33752.024

[Figure 11](#fig11) and [Video 11](#video11) show sequential (attention-based) encoding, subsequent recall and attentional sampling of scene elements. The agent sequentially encodes two objects from one location ([Figure 11A](#fig11)), moves on until both objects are out of view, and engages imagery to recall object one in its spatial context ([Figure 11B](#fig11)). The agent can then sample object two by allocating attention to the secondary peak in the parietal window (boosting the residual activity by injecting current in the PWo cells corresponding to the location of object 2). This activity spreads back to the MTL network, via OVCs, driving the corresponding PRo neuron ([Figure 11C](#fig11)). Thus, the agent infers the identity of object 2, by inspecting it in imagery. Attention ensures disambiguation of objects at encoding, while reciprocity of connections in the MTL is necessary to form a stored attractor in spatial memory.

[^7]: Figure 13

[Download asset](https://elifesciences.org/download/aHR0cHM6Ly9paWlmLmVsaWZlc2NpZW5jZXMub3JnL2xheC8zMzc1MiUyRmVsaWZlLTMzNzUyLWZpZzEzLXYxLnRpZi9mdWxsL2Z1bGwvMC9kZWZhdWx0LmpwZw--/elife-33752-fig13-v1.jpg?_hash=XgGKA59Gwil0xnFSHEJzEaU0wOGTd5PCWZ%2BDyje1iNM%3D) [Open asset](https://iiif.elifesciences.org/lax/33752%2Felife-33752-fig13-v1.tif/full/1500,/0/default.jpg)

![](https://iiif.elifesciences.org/lax/33752%2Felife-33752-fig13-v1.tif/full/1234,/0/default.webp)

Planning, taking and imaging a trajectory across an unexplored area. The agent is located in an environment where the direct trajectory between two salient locations (purple dots, left column) covers an unexplored part of the environment. PCs potentially firing in … see more ↩ https://doi.org/10.7554/eLife.33752.027

[^8]: 1. [Squire LR](https://scholar.google.com/scholar?q=%22author:Squire+LR%22)
2. [Amaral DG](https://scholar.google.com/scholar?q=%22author:Amaral+DG%22)
3. [Zola-Morgan S](https://scholar.google.com/scholar?q=%22author:Zola-Morgan+S%22)
4. [Kritchevsky M](https://scholar.google.com/scholar?q=%22author:Kritchevsky+M%22)
5. [Press G](https://scholar.google.com/scholar?q=%22author:Press+G%22)
(1989) [Description of brain injury in the amnesic patient N.A. based on magnetic resonance imaging](https://doi.org/10.1016/0014-4886\(89\)90168-4)

*Experimental Neurology* **105**:23–35.

[https://doi.org/10.1016/0014-4886(89)90168-4](https://doi.org/10.1016/0014-4886\(89\)90168-4)
- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/2744126)
- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Description+of+brain+injury+in+the+amnesic+patient+N.A.+based+on+magnetic+resonance+imaging&author=Squire+LR&author=Amaral+DG&author%5B2%5D=Zola-Morgan+S&author%5B3%5D=Kritchevsky+M&author%5B4%5D=Press+G&publication_year=1989&journal=Experimental+Neurology&volume=105&pages=pp.+23%E2%80%9335&pmid=2744126)