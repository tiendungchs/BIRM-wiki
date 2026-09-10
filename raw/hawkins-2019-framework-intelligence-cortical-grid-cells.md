---
title: "A Framework for Intelligence and Cortical Function Based on Grid Cells in the Neocortex"
source: "https://www.frontiersin.org/journals/neural-circuits/articles/10.3389/fncir.2018.00121/full"
author:
  - "[[Jeff Hawkins]]"
  - "[[Marcus Lewis]]"
  - "[[Mirko Klukas]]"
  - "[[Scott Purdy]]"
  - "[[Subutai Ahmad]]"
published: 2019-01-11
created: 2026-09-10
description: "How the neocortex works is a mystery. In this paper we propose a novel framework for understanding its function. Grid cells are neurons in the entorhinal cor..."
tags:
  - "clippings"
---
- Numenta, Inc., Redwood City, CA, United States

Article metrics

[View details](#metrics)

158

Citations

87,9k

Views

16,2k

Downloads

## Abstract

How the neocortex works is a mystery. In this paper we propose a novel framework for understanding its function. Grid cells are neurons in the entorhinal cortex that represent the location of an animal in its environment. Recent evidence suggests that grid cell-like neurons may also be present in the neocortex. We propose that grid cells exist throughout the neocortex, in every region and in every cortical column. They define a location-based framework for how the neocortex functions. Whereas grid cells in the entorhinal cortex represent the location of one thing, the body relative to its environment, we propose that cortical grid cells simultaneously represent the location of many things. Cortical columns in somatosensory cortex track the location of tactile features relative to the object being touched and cortical columns in visual cortex track the location of visual features relative to the object being viewed. We propose that mechanisms in the entorhinal cortex and hippocampus that evolved for learning the structure of environments are now used by the neocortex to learn the structure of objects. Having a representation of location in each cortical column suggests mechanisms for how the neocortex represents object compositionality and object behaviors. It leads to the hypothesis that every part of the neocortex learns complete models of objects and that there are many models of each object distributed throughout the neocortex. The similarity of circuitry observed in all cortical regions is strong evidence that even high-level cognitive tasks are learned and represented in a location-based framework.

## Introduction

The human neocortex learns an incredibly complex and detailed model of the world. Each of us can recognize 1000s of objects. We know how these objects appear through vision, touch, and audition, we know how these objects behave and change when we interact with them, and we know their location in the world. The human neocortex also learns models of abstract objects, structures that don’t physically exist or that we cannot directly sense. The circuitry of the neocortex is also complex. Understanding how the complex circuitry of the neocortex learns complex models of the world is one of the primary goals of neuroscience.

Vernon Mountcastle was the first to propose that all regions of the neocortex are fundamentally the same. What distinguishes one region from another, he argued, is mostly determined by the inputs to a region and not by differences in intrinsic circuitry and function. He further proposed that a small volume of cortex, a cortical column, is the unit of replication (Mountcastle, 1978). These are compelling ideas, but it has been difficult to identify what a column could do that is sufficient to explain all cognitive abilities. Today, the most common view is that the neocortex processes sensory input in a series of hierarchical steps, extracting more and more complex features until objects are recognized (Fukushima, 1980; Riesenhuber and Poggio, 1999). Although this view explains some aspects of sensory inference, it fails to explain the richness of human behavior, how we learn multi-dimensional models of objects, and how we learn how objects themselves change and behave when we interact with them. It also fails to explain what most of the circuitry of the neocortex is doing. In this paper we propose a new theoretical framework based on location processing that addresses many of these shortcomings.

Over the past few decades some of the most exciting advances in neuroscience have been related to “grid cells” and “place cells.” These neurons exist in the hippocampal complex of mammals, a set of regions, which, in humans, is roughly the size and shape of a finger, one on each side of the brain. Grid cells in combination with place cells learn maps of the world (O’Keefe and Dostrovsky, 1971; Hafting et al., 2005; Moser et al., 2008). Grid cells represent the current location of an animal relative to those maps. Modeling work on the hippocampus has demonstrated the power of these neural representations for episodic and spatial memory (Byrne et al., 2007; Hasselmo et al., 2010; Hasselmo, 2012), and navigation (Erdem and Hasselmo, 2014; Bush et al., 2015). There is also evidence that grid cells play a role in more abstract cognitive tasks (Constantinescu et al., 2016; Behrens et al., 2018).

Recent experimental evidence suggests that grid cells may also be present in the neocortex. Using fMRI (Doeller et al., 2010; Constantinescu et al., 2016; Julian et al., 2018) have found signatures of grid cell-like firing patterns in prefrontal and parietal areas of the neocortex. Using single cell recording in humans (Jacobs et al., 2013) have found more direct evidence of grid cells in frontal cortex (Long and Zhang, 2018), using multiple tetrode recordings, have reported finding cells exhibiting grid cell, place cell, and conjunctive cell responses in rat S1. Our team has proposed that prediction of sensory input by the neocortex requires a representation of an object-centric location to be present throughout the sensory regions of the neocortex, which is consistent with grid cell-like mechanisms (Hawkins et al., 2017).

Here we propose that grid cell-like neurons exist in every column of the neocortex. Whereas grid cells in the medial entorhinal cortex (MEC) primarily represent the location of one thing, the body, we suggest that cortical grid cells simultaneously represent the location of multiple things. Columns in somatosensory cortex that receive input from different parts of the body represent the location of those inputs in the external reference frames of the objects being touched. Similarly, cortical columns in visual cortex that receive input from different patches of the retinas represent the location of visual input in the external reference frames of the objects being viewed. Whereas grid cells and place cells learn models of environments via movement of the body, we propose that cortical grid cells combined with sensory input learn models of objects via movement of the sensors.

Although much is known about the receptive field properties of grid cells in MEC and how these cells encode location (Rowland et al., 2016), the underlying mechanisms leading to those properties is not known. Experimental results suggest that grid cells have unique membrane and dendritic properties (Domnisoru et al., 2013; Schmidt-Hieber et al., 2017). There are two leading computational candidates, oscillatory interference models (O’Keefe and Burgess, 2005; Burgess et al., 2007; Giocomo et al., 2007, 2011; Burgess, 2008) and continuous attractor models (Fuhs and Touretzky, 2006; Burak and Fiete, 2009). The framework proposed in this paper assumes that “cortical grid cells” exhibit similar physiological properties as grid cells in MEC, but the framework is not dependent on how those properties arise.

Throughout this paper we refer to “cortical columns.” We use this term similarly to Mountcastle, to represent a small area of neocortex that spans all layers in depth and of sufficient lateral extent to capture all cell types and receptive field responses. For this paper, a cortical column is not a physically demarked entity. It is a convenience of nomenclature. We typically think of a column as being about one square millimeter of cortical area, although this size is not critical and could vary by species and region.

## How Grid Cells Represent Location

To understand our proposal, we first review how grid cells in the entorhinal cortex are believed to represent space and location, Figure [^1]. Although many details of grid cell function remain unknown, general consensus exists on the following principles. A grid cell is a neuron that becomes active at multiple locations in an environment, typically in a grid-like, or tiled, triangular lattice. A “grid cell module” is a set of grid cells that activate with the same lattice spacing and orientation but at shifted locations within an environment (Stensola et al., 2012). As an animal moves, the active grid cells in a grid cell module change to reflect the animal’s updated location. This change occurs even if the animal is in the dark, telling us that grid cells are updated using an internal, or “efference,” copy of motor commands (Hafting et al., 2005; McNaughton et al., 2006; Moser et al., 2008; Kropff et al., 2015). This process, called “path integration,” has the desirable property that regardless of the path of movement, when the animal returns to the same physical location, then the same grid cells in a module will be active.

FIGURE 1

![](https://www.frontiersin.org/api/ipx/w=340&f=webp/https://www.frontiersin.org/files/Articles/431889/xml-images/fncir-12-00121-g001.webp)

Due to tiling, a single grid cell module cannot represent a unique location. To form a representation of a unique location requires looking at the active cells in multiple grid cell modules where each grid cell module differs in its tile spacing and/or orientation relative to the environment, Figures. For example, if a single grid cell module can represent twenty different locations before repeating, then 10 grid cell modules can represent approximately 20 <sup>10</sup> different locations before repeating (Fiete et al., 2008). This method of representing location has several desirable properties:

- **(1)**
	Large representational capacity:

The number of locations that can be represented by a set of grid cell modules is large as it scales exponentially with the number of modules.

- **(2)**
	Path integration works from any location:

No matter what location the network starts with, path integration will work. This is a form of generalization. The path integration properties have to be learned once for each grid cell module, but then apply to all locations, even those the animal has never been in before.

- **(3)**
	Locations are unique to each environment:

Every learned environment is associated with a set of unique locations. Experimental recordings suggest that upon entering a learned environment, entorhinal grid cell modules “anchor” differently (Rowland and Moser, 2014; Marozzi et al., 2015). (The term “anchor” refers to selecting which grid cells in each module should be active at the current location.) This suggests that the current location and all the locations that the animal can move to in that environment will, with high certainty, have representations that are unique to that environment (Fiete et al., 2008; Sreenivasan and Fiete, 2011).

Combining these properties, we can now broadly describe how grid cells represent an environment such as a room, Figure. An environment consists of a set of location representations that are related to each other via path integration (i.e., the animal can move between these location representations). Each location representation in the set is unique to that environment and will not appear in any other environment. An environment consists of all the locations that the animal can move among, including locations that have not been visited, but could be visited. Associated with some of the location representations are observable landmarks.

FIGURE 2

![](https://www.frontiersin.org/api/ipx/w=340&f=webp/https://www.frontiersin.org/files/Articles/431889/xml-images/fncir-12-00121-g002.webp)

## Grid Cells in the Neocortex

Now let us consider a patch of neocortex that receives input from the tip of a finger, Figure. Our proposal is that some of the neurons in that patch of cortex represent the location of the fingertip as it explores an object. When the finger moves, these cortical grid cells update their representation of location via a motor efference copy and path integration. Objects, such as a coffee cup, have an associated set of locations, in the same way that environments, such as a room, have an associated set of locations. Associated with some of the object’s locations are observable features. The cortical area receiving input from the fingertip tracks the location of the sensory input from the fingertip in the location space of the object. Through movement and sensation, the fingertip cortical area learns models of objects in the same way that grid cells and place cells learn models of environments. Whereas the entorhinal cortex tracks the location of the body, different areas of the neocortex independently track the location of each movable sensory patch. For example, each area of somatosensory cortex tracks the location of sensory input from its associated body part. These areas operate in parallel and build parallel models of objects. The same basic method applies to vision. Patches of the retina are analogous to patches of skin. Different parts of the retina observe different locations on an object. Each patch of cortex receiving visual input tracks the location of its visual input in the location space of the object being observed. As the eyes move, visual cortical columns sense different locations on an object and learn parallel models of the observed object.

We have now covered the most basic aspects of our proposal:

- **(1)**
	Every cortical column has neurons that perform a function similar to grid cells. The activation pattern of these cortical grid cells represents the location of the column’s input relative to an external reference frame. The location representation is updated via a motor efference copy and path integration.
- **(2)**
	Cortical columns learn models of objects in the world similarly to how grid cells and place cells learn models of environments. The models learned by cortical columns consist of a set of location representations that are unique to each object, and where some of the locations have observable features.

## A Location-Based Framework for Cortical Computation

Our proposal suggests that cortical columns are more powerful than previously assumed. By pairing input with a grid cell-derived representation of location, individual columns can learn complex models of structure in the world (see also Lewis et al., 2018). In this section we show how a location-based framework allows neurons to learn the rich models that we know the neocortex is capable of.

### Object Compositionality

Objects are composed of other objects arranged in a particular way. For example, it would be inefficient to learn the morphology of a coffee cup by remembering the sensory sensation at each location on the cup. It is far more efficient to learn the cup as the composition of previously learned objects, such as a cylinder and a handle. Consider a coffee cup with a logo on it, Figure. The logo exists in multiple places in the world and is itself a learned “object.” To represent the cup with the logo we need a way of associating one object, “the logo,” at a relative position to another object, “the cup.” Compositional structure is present in almost all objects in the world, therefore cortical columns must have a neural mechanism that represents a new object as an arrangement of previously-learned objects. How can this functionality be achieved?

FIGURE 3

![](https://www.frontiersin.org/api/ipx/w=340&f=webp/https://www.frontiersin.org/files/Articles/431889/xml-images/fncir-12-00121-g003.webp)

We have proposed that each object is associated with a set of locations which are unique to the object and comprise a space around the object. If a finger is touching the coffee cup with the logo, then the cortical grid cells representing the location of the finger can at one moment represent the location of the finger in the space of the coffee cup and at another moment, after re-anchoring, represent the location of the finger in the space of the logo. If the logo is attached to the cup, then there is a fixed, one-to-one, relationship between any point in the space of the logo and the equivalent point in the space of the cup, Figure. The task of representing the logo on the cup can be achieved by creating a “displacement” vector that converts any point in cup space to the equivalent point in logo space.

Determining the displacement between two objects is similar to a previously-studied navigation problem, specifically, how an animal knows how to get from point **a** to point **b** within an environment, Figure. Mechanisms that solve the navigation problem (determining the displacement between two points in the same space) can also solve the object composition problem (determining the displacement between two points in two different spaces).

### Displacement Cells

Several solutions have been proposed for solving the point-to-point navigation problem using grid cells. One class of solutions detects the difference between two sets of active grid cells across multiple grid cell modules (Bush et al., 2015) and another uses linear look-ahead probes using grid cells for planning and computing trajectories (Erdem and Hasselmo, 2014). We suggest an alternate but related solution. Our proposal also relies on detecting differences between two sets of active grid cells, however, we propose this is done on a grid cell module by grid cell module basis. We refer to these cells as “displacement cells” (see for a more thorough description). Displacement cells are similar to grid cells in that they can’t on their own represent a unique displacement. (In the example, a displacement cell that represents a displacement of “two to the right and one up,” would also be active for “five over and four up.”) However, the cell activity in multiple displacement cell modules represents a unique displacement in much the same way as the cell activity in multiple grid cell modules represents a unique location, Figure. Hence, a single displacement vector can represent the logo on the coffee cup at a specific relative position. Note, a displacement vector not only represents the relative position of two objects, it also is unique to the two objects. Complex objects can be represented by a set of displacement vectors which define the components of an object and how they are arranged relative to each other. This is a highly efficient means of representing and storing the structure of objects.

This method of representing objects allows for hierarchical composition. For example, the logo on the cup is also composed of sub-objects, such as letters and a graphic. A displacement vector placing the logo on the cup implicitly carries with it all the sub-objects of the logo. The method also allows for recursive structures. For example, the logo could contain a picture of a coffee cup with a logo. Hierarchical and recursive composition are fundamental elements of not only physical objects but language, mathematics, and other manifestations of intelligent thought. The key idea is that the identity and relative position of two previously-learned objects, even complex objects, can be represented efficiently by a single displacement vector.

### Grid Cells and Displacement Cells Perform Complementary Operations

Grid cells and displacement cells perform complementary operations. Grid cells determine a new location based on a current location and a displacement vector (i.e., movement). Displacement cells determine what displacement is required to reach a new location from a current location.

Grid cells: (Location1+Displacement=>Location2) $Grid cells : (Location1+Displacement=>Location2)$

Displacement cells: (Location2−Location1=>Displacement) $Displacement cells : (Location2−Location1=>Displacement)$

If the two locations are in the same space, then grid cells and displacement cells are useful for navigation. In this case, grid cells predict a new location based on a starting location and a given movement. Displacement cells would represent what movement is needed to get from Location1 to Location2.

If the two locations are in different spaces (that is the same physical location relative to two different objects) then grid cells and displacement cells are useful for representing the relative position of two objects. Grid cells convert a location in one object space to the equivalent location in a second object space based on a given displacement. In this case, displacement cells represent the relative position of two objects.

We propose that grid cells and displacement cells exist in all cortical columns. They perform two fundamental and complementary operations in a location-based framework of cortical processing. By alternating between representations of locations in a single object space and representations of locations in two different object spaces, the neocortex can use grid cells and displacement cells to learn both the structure of objects and generate behaviors to manipulate those objects.

The existence of grid cells in the entorhinal cortex is well-documented. We propose they also exist in all regions of the neocortex. The existence of displacement cells is a prediction introduced in this paper. We propose displacement cells are also present in all regions of the neocortex. Given their complementary role to grid cells, it is possible that displacement cells are also present in the hippocampal complex.

### Object Behaviors

Objects may exhibit behaviors. For example, consider the stapler in Figure [^3]. The top of the stapler can be lifted and rotated. This action changes the stapler’s morphology but not its identity. We don’t perceive the open and closed stapler as two different objects even though the overall shape has changed. The movement of a part of an object relative to other parts of an object is a “behavior” of the object. The behaviors of an object can be learned, and therefore they must be represented in the neural tissue of cortical columns. We can represent behaviors in a location-based framework, again using displacement vectors. The top half and bottom half of the stapler are two components of the stapler. The relative position of the top and bottom is represented by a displacement vector in the same way as the relative position of the logo and the coffee cup. However, unlike the logo on the coffee cup, the two halves of the stapler can move relative to each other. As the stapler top rotates upward, the displacement of the stapler top to bottom changes. Thus, the rotation of the stapler top is represented by a sequence of displacement vectors. By learning this sequence, the system will have learned this behavior of the object.

FIGURE 4

![](https://www.frontiersin.org/api/ipx/w=340&f=webp/https://www.frontiersin.org/files/Articles/431889/xml-images/fncir-12-00121-g004.webp)

Opening and closing the stapler are different behaviors yet they are composed of the same displacement elements, just in reverse order. These are sometimes referred to as “high-order” sequences. Previously we described a neural mechanism for learning high-order sequences in a layer of neurons (Hawkins and Ahmad, 2016). This mechanism, if applied to the displacement modules, would allow the learning, inference, and recall of complex behavioral sequences of objects.

### “What” and “Where” Processing

Sensory processing occurs in two parallel sets of neocortical regions, often referred to as “what” and “where” pathways. In vision, damage to the “what,” or ventral, pathway is associated with the loss of ability to visually recognize objects whereas damage to the “where,” or dorsal, pathway is associated with the loss of ability to reach for an object even if it has been visually identified. Equivalent “what” and “where” pathways have been observed in other sensory modalities, thus it appears to be general principle of cortical organization (Goodale and Milner, 1992; Ungerleider and Haxby, 1994; Rauschecker, 2015). “What” and “where” cortical regions have similar anatomy and therefore we can assume they operate on similar principles.

A location-based framework for cortical function is applicable to both “what” and “where” processing. Briefly, we propose that the primary difference between “what” regions and “where” regions is that in “what” regions cortical grid cells represent locations that are allocentric, in the location space of objects, and in “where” regions cortical grid cells represent locations that are egocentric, in the location space of the body. Figure [^4] shows how a displacement vector representing movement could be generated in “what” and “where” regions. The basic operation, common to all, is that a region first attends to one location and then to a second location. The displacement cells will determine the movement vector needed to move from the first location to the second location. In a “what” region, Figure, the two locations are in the space of an object, therefore, the displacement vector will represent the movement needed to move the finger from the first location on the object to the second location on the object. In this example, the “what” region needs to know where the finger is relative to the cup, but it does not need to know where the cup or finger is relative to the body. In a “where” region, Figure, the two locations are in the space of the body, therefore, the displacement vector will represent how to move from one egocentric location to a second egocentric location. The “where” region can perform this calculation not knowing what object may or may not be at the second location. A more detailed discussion of processing in “where” regions is beyond the scope of this paper. We only want to point out that it is possible to understand both “what” and “where” processing using similar mechanisms by assuming different location spaces.

FIGURE 5

![](https://www.frontiersin.org/api/ipx/w=340&f=webp/https://www.frontiersin.org/files/Articles/431889/xml-images/fncir-12-00121-g005.webp)

### Rethinking Hierarchy, the Thousand Brains Theory of Intelligence

Regions of the neocortex are organized in a hierarchy (Felleman and Van Essen, 1991; Riesenhuber and Poggio, 1999; Markov et al., 2014). It is commonly believed that when sensory input enters the neocortex the first region detects simple features. The output of this region is passed to a second region that combines simple features into more complex features. This process is repeated until, several levels up in the hierarchy, cells respond to complete objects (Figure ). This view of the neocortex as a hierarchy of feature extractors also underlies many artificial neural networks (LeCun et al., 2015).

FIGURE 6

![](https://www.frontiersin.org/api/ipx/w=340&f=webp/https://www.frontiersin.org/files/Articles/431889/xml-images/fncir-12-00121-g006.webp)

We propose that cortical columns are more powerful than currently believed. Every cortical column learns models of complete objects. They achieve this by combining input with a grid cell-derived location, and then integrating over movements (see Hawkins et al., 2017; Lewis et al., 2018 for details). This suggests a modified interpretation of the cortical hierarchy, where complete models of objects are learned at every hierarchical level, and every region contains multiple models of objects (Figure ).

Feedforward and feedback projections between regions typically connect to multiple levels of the hierarchy (only one level of connection is shown in Figure [^5]). For example, the retina projects to thalamic relay cells in LGN, which then project to cortical regions V1, V2, and V4, not just V1. This form of “level skipping” is the rule, not the exception. Therefore, V1 and V2 are both, to some extent, operating on retinal input. The connections from LGN to V2 are more divergent suggesting that V2 is learning models at a different spatial scale than V1. We predict that the spatial scale of cortical grid cells in V2 will similarly be larger than those in V1. The level of convergence of input to a region, paired with the spatial scale of its grid cells, determines the range of object sizes the region can learn. For example, imagine recognizing printed letters of the alphabet. Letters at the smallest discernable size will be recognized in V1 and only V1. The direct input to V2 will lack the feature resolution needed. However, larger printed letters would be recognized in both V1 and V2, and even larger letters may be too large for V1 but recognizable in V2. Hierarchical processing still occurs. All we are proposing is that when a region such as V1 passes information to another region such as V2, it is not passing representations of unclassified features but, if it can, it passes representations of complete objects. This would be difficult to observe empirically if objects are represented by population codes as proposed in Hawkins et al. (2017). Individual neurons would participate in many different object representations and if observed in isolation will appear to represent sensory features, not objects. The number of objects that a cortical column can learn is large but limited (Hawkins et al., 2017). Not every column can learn every object. Analysis of system capacity requires a more thorough understanding of hierarchical flow and is beyond the scope of this paper.

There are many cortical-cortical projections that are inconsistent with pure hierarchical processing (Figure, green arrows). For example, there are long range projections between regions in the left and right hemispheres (Clarke and Zaidel, 1994), and there are numerous connections between regions in different sensory modalities, even at the lowest levels of the hierarchy (Schroeder and Foxe, 2005; Driver and Noesselt, 2008; Suter and Shepherd, 2015). These connections may not be hierarchical as their axons terminate on cells located outside of cellular layers associated with feedforward or feedback input. It has been estimated that 40% of all possible region-to-region connections actually exist which is much larger than a pure hierarchy would suggest (Felleman and Van Essen, 1991). What is the purpose of these long-range non-hierarchical connections? In Hawkins et al. (2017) we proposed that cell activity in some layers (e.g., L4 and L6) of a column changes with each new sensation, whereas, cell activity in other layers (e.g., L2/3), representing the observed “object,” are stable over changing input. We showed how long-range associative connections in the “object” layer allow multiple columns to vote on what object they are currently observing. For example, if we see and touch a coffee cup there will be many columns simultaneously observing different parts of the cup. These columns will be in multiple levels of both the visual and somatosensory hierarchies. Every one of these columns has a unique sensory input and a unique location, and therefore, long-range connections between the cells representing location and input do not make sense. However, if the columns are observing the same object, then connections between cells in the object layer allow the columns to rapidly settle on the correct object. Thus, non-hierarchical connections between any two regions, even primary and secondary sensory regions in different sensory modalities, make sense if the two regions often observe the same object at the same time (see Hawkins et al., 2017 for details).

One of the classic questions about perception is how does the neocortex fuse different sensory inputs into a unified model of a perceived object. We propose that the neocortex implements a decentralized model of sensor fusion. For example, there is no single model of a coffee cup that includes what a cup feels like and looks like. Instead there are 100s of models of a cup. Each model is based on a unique subset of sensory input within different sensory modalities. There will be multiple models based on visual input and multiple models based on somatosensory input. Each model can infer the cup on its own by observing input over movements of its associated sensors. However, long-range non-hierarchical connections allow the models to rapidly reach a consensus of the identity of the underlying object, often in a single sensation.

Just because each region learns complete models of objects does not preclude hierarchical flow. The main idea is that the neocortex has 100s, likely 1000s, of models of each object in the world. The integration of observed features does not just occur at the top of the hierarchy, it occurs in every column at all levels of the hierarchy. We call this “The Thousand Brains Theory of Intelligence.”

## Discussion

Crick (1979) wrote an essay titled, “Thinking about the Brain.” In it he wrote, “In spite of the steady accumulation of detailed knowledge, how the human brain works is still profoundly mysterious.” He posited that over the coming years we would undoubtedly accumulate much more data about the brain, but it may not matter, as “our entire way of thinking about such problems may be incorrect.” He concluded that we lacked a “theoretical framework,” a framework in which we can interpret experimental findings and to which detailed theories can be applied. Nearly 40 years after Crick wrote his essay, his observations are still largely valid.

Arguably, the most progress we have made toward establishing a theoretical framework is based on the discovery of place cells and grid cells in the hippocampal complex. These discoveries have suggested a framework for how animals learn maps of environments, and how they navigate through the world using these maps. The success of this framework has led to an explosion of interest in studying the entorhinal cortex and hippocampus.

In this paper we are proposing a theoretical framework for understanding the neocortex. Our proposed cortical framework is a derivative of the framework established by grid cells and place cells. Mechanisms that evolved for learning the structure of environments are now applied to learning the structure of objects. Mechanisms that evolved for tracking the location of an animal in its environments are now applied to tracking the location of limbs and sensory organs relative to objects in the world. How far this analogy can be taken is uncertain. Within the circuits formed by the hippocampus, subiculum, and entorhinal cortex are grid cells (Hafting et al., 2005), place cells (O’Keefe and Dostrovsky, 1971; O’Keefe and Burgess, 2005), head direction cells (Taube et al., 1990; Giocomo et al., 2014; Winter et al., 2015), border cells (Lever et al., 2009), object vector cells (Deshmukh and Knierim, 2013), and others, plus many conjunctive cells that exhibit properties that are combinations of these (Sargolini et al., 2006; Brandon et al., 2011; Stensola et al., 2012; Hardcastle et al., 2017). We are currently exploring the idea that the neocortex contains cells that perform equivalent functions to the variety of cells found in the hippocampal complex. The properties of these cells would only be detectable in an awake animal actively sensing learned objects. The recent work of Long and Zhang (2018) suggests this might be true.

### Orientation

In the entorhinal cortex, and elsewhere in the brain, are found head direction cells (Taube et al., 1990; Sargolini et al., 2006; Brandon et al., 2011; Giocomo et al., 2014; Winter et al., 2015; Raudies et al., 2016). These cells represent the allocentric orientation of an animal relative to its environment. Inferring where you are via sensation, predicting what you will sense after moving, and determining how to move to get to a new location all require knowing your current orientation relative to your environment. In the models reviewed in Hasselmo (2009) and Hasselmo et al. (2010) head direction cells are critical for accurately transitioning between spatial locations. The same need for orientation exists throughout the neocortex. For example, knowing that a finger is at a particular location on a coffee cup is not sufficient. The finger also has an orientation relative to the cup (which way it is rotated and its angle at contact). Predicting what the finger will sense when it contacts the cup or what movement is required to reach a new location on the cup requires knowing the finger’s orientation relative to the cup in addition to its location. Therefore, we predict that within each cortical column there will be a representation of orientation that performs an analogous function to head direction cells in the hippocampal complex. How orientation is represented in the cortex is unknown. There could be a set of orientation cells each with a preferred orientation, similar to head direction cells, but we are not aware of any evidence for this. Alternately, orientation could be represented via a population code, which would be more difficult to detect. For example, in somatosensory regions orientation could be represented by activating a sparse subset of egocentric orientation detectors (Hsiao et al., 2002; Bensmaia et al., 2008; Pruszynski and Johansson, 2014). How orientation is represented and interacts with cortical grid cells and displacement cells is largely unknown. It is an area we are actively studying.

### Prediction

A long standing principle behind many theories of cortical function is prediction (Lashley, 1951; Rao and Ballard, 1999; Hawkins and Blakeslee, 2004; Lotter et al., 2018). By representing the location of a sensor, a cortical column can associate sensory information within the location space of each object, similar to the way place cells associate sensory information with locations (O’Keefe and Nadel, 1978; Komorowski et al., 2009). This enables a column to build powerful predictive models. For example, when moving your finger from the bottom of a cup to the top, it can predict the sensation regardless of how the cup is rotated with respect to the sensor. Representing composite objects using displacement cells enables a column to generalize and predict sensations even when encountering a novel object. For example, suppose we see a cup with a familiar logo (Figure ) and that portions of the logo are obscured. Once a column has recognized the logo and the cup, it can make predictions regarding the entire logo in relation to the cup even if that combined object is new. Building such predictive models would be much harder without an explicit representation of location. In previous papers we proposed dendritic mechanisms that could serve as the neural basis for predictive networks (Hawkins and Ahmad, 2016; Hawkins et al., 2017). Overall, prediction underlies much of the framework discussed in this paper.

### Attention

One of the key elements of a location-based framework for cortical processing is the ability of an area of cortex to rapidly switch between object spaces. To learn there is a logo on the coffee cup we need to alternate our attention between the cup and the logo. With each shift of attention, the cortical grid cells re-anchor to the location space of the newly attended object. This shift to a new object space is necessary to represent the displacement between two objects, such as the logo and the cup. It is normal to continuously shift our attention between the objects around us. With each newly attended object the cortical grid cells re-anchor in the space of the new object, and displacement cells represent where the new object is relative to the previously attended object. Changing attention is intimately tied to movement of the sensor, re-anchoring of grid cells, and, as widely believed, feedback signals to the thalamus (Crick, 1984; McAlonan et al., 2006), presumably to select a subset of input for processing. How these elements work together is poorly understood and represents an area for further study.

### Uniqueness of Location Code

Our proposal is based on the idea that a set of grid cell modules can encode a very large number of unique locations. There are some observations that suggest that grid cells, on their own, may not be capable of forming enough unique codes. For example, because each grid cell exhibits activity over a fairly large area of physical space (Hafting et al., 2005), the activation of the cells in a grid cell module is not very sparse. Sparsity is helpful for creating easily discernable unique codes. The lack of sparsity can be overcome by sampling the activity over more grid cell modules, but not enough is known about the size of grid cell modules and how many can be realistically sampled (Gu et al., 2018) have shown that grid cell modules are composed of smaller sub-units that activate independently, which would also increase the representation capacity of grid cells. Another factor impacting capacity is conjunctive cells. In the entorhinal cortex there are more conjunctive cells than pure grid cells. Conjunctive cells exhibit some combination of “gridness” plus orientation and/or other factors (Sargolini et al., 2006). Conjunctive cells may have a sparser activation than pure grid cells and therefore would be a better basis for forming a set of unique location codes. If the neocortex has cells similar to conjunctive cells, they also might play a role in location coding. Not enough is known about how grid cells, orientation cells, and conjunctive cells work together to suggest exactly how locations are encoded in the neocortex. As we learn more about location coding in the neocortex, it is important to keep these possibilities in mind.

### Where Are Grid Cells and Displacement Cells in the Neocortex?

The neocortex is commonly divided into six layers that run parallel to the surface. There are dozens of different cell types, therefore, each layer contains multiple cell types. Several lines of evidence suggest that cortical grid cells are located in L6 \[specifically L6 cortical-cortical neurons (Thomson, 2010)\] and displacement cells are located in L5 (specifically L5 thick-tufted neurons) (Figure [^6]).

FIGURE 7

![](https://www.frontiersin.org/api/ipx/w=340&f=webp/https://www.frontiersin.org/files/Articles/431889/xml-images/fncir-12-00121-g007.webp)

One piece of evidence suggesting cortical grid cells are in L6 is the unusual connectivity between L4 and L6. L4 is the primary input layer. However, feed forward input forms less than 10% of the synapses on L4 cells (Ahmed et al., 1994, 1997; Sherman and Guillery, 2013), whereas approximately 45% of the synapses on L4 cells come from L6a cortical-cortical neurons (Ahmed et al., 1994; Binzegger et al., 2004). Similarly, L4 cells make large numbers of synapses onto those same L6 cells (McGuire et al., 1984; Binzegger et al., 2004; Kim et al., 2014). Also, the connections between L6 and L4 are relatively narrow in spread (Binzegger et al., 2004). The narrow connectivity between L6 and L4 is reminiscent of the topologically-aligned bidirectional connectivity between grid cells in MEC and place cells in hippocampus (Rowland et al., 2013; Zhang et al., 2013). We previously showed how the reciprocal connections between L6 and L4 can learn the structure of objects by movement of sensors if L6 represents a location in the space of the object (Lewis et al., 2018). For a column to learn the structure of objects in this fashion requires bidirectional connections between cells receiving sensory input and cells representing location. L6a is the only known set of cells that meet this requirement. Also, grid cells use motor input to update their representations for path integration. Experiments show significant motor projections to L6 (Nelson et al., 2013; Leinweber et al., 2017). The current experimental evidence for the presence of grid cells in the neocortex is unfortunately mute on what cortical layers contain grid cells. It should be possible to experimentally determine this in the near future. Our prediction is they will be in L6.

The main evidence for displacement cells being in L5 is again connectivity. A subset of L5 cells (known as “L5 thick-tufted cells”) that, as far as we know exists in all cortical regions, projects sub-cortically to brain regions involved with motor behavior. (For example, L5 cells in the visual cortex project to the superior colliculus which controls eye movements.) These L5 cells are the motor output cells of the neocortex. However, the same L5 cells send a branch of their axon to thalamic relay nuclei, which then project to hierarchically higher cortical regions (Douglas and Martin, 2004; Guillery and Sherman, 2011; Sherman and Guillery, 2011). It is difficult to understand how the same L5 cells can be both the motor output and the feedforward input to other regions. One interpretation put forth by Guillery and Sherman is that L5 cells represent a motor command and that the feedforward L5 projection can be interpreted as an efference copy of the motor command (Guillery and Sherman, 2002, 2011).

We offer a possible alternate interpretation. The L5 cells in question are displacement cells and they alternately represent movements (sent sub-cortically) and then represent compositional objects (sent to higher regions via thalamic relay cells). As described above, displacement cells will represent a movement vector when comparing two locations in the same space and will represent composite objects when comparing two locations in two different spaces. These two rapidly-changing representations could be disambiguated at their destination either by phase of an oscillatory cycle or by physiological firing patterns (Burgess et al., 2007; Hasselmo, 2008; Hasselmo and Brandon, 2012). Although we are far from having a complete understanding of what the different cellular layers do and how they work together, a location-based framework offers the opportunity of looking anew at the vast body of literature on cortical anatomy and physiology and making progress on this problem.

### Location-Based Framework for High-Level Thought and Intelligence

We have described our location-based framework using examples from sensory inference. Given that the anatomy in all cortical regions is remarkably similar, it is highly likely that everything the neocortex does, including language and other forms of high-level thought, will be built upon the same location-based framework. In support of this idea, the current empirical evidence that grid cells exist in the neocortex was collected from humans performing what might be called “cognitive tasks,” and it was detected in cortical regions that are far from direct sensory input (Doeller et al., 2010; Jacobs et al., 2013; Constantinescu et al., 2016).

The location-based framework can be applied to physical structures, such as a cup, and to abstract concepts, such as mathematics and language. A cortical column is fundamentally a system for learning predictive models. The models are learned from inputs and movements that lead to changes in the input. Successful models are ones that can predict the next input given the current state and an anticipated movement. However, the “inputs” and “movements” of a cortical column do not have to correspond to physical entities. The “input” to a column can originate from the retina or it can originate from other regions of the neocortex that have already recognized a visual object such as a word or a mathematical expression. A “movement” can represent the movement of the eyes or it can represent an abstract movement, such as a verb or a mathematical operator.

Success in learning a predictive model requires discovering the correct dimensionality of the space of the object, learning how movements update locations in that space, and associating input features with specific locations in the space of the object. These attributes apply to both sensory perception and high-level thought. Imagine a column trying to learn a model of a cup using visual input from the retina and movement input from a finger. This would fail, as the location spaced traversed by the finger would not map onto the feature space of the object as evidenced by the changing inputs from the eyes. Similarly, when trying to understand a mathematical problem you might fail when using one operator to manipulate an equation but succeed by switching to a different operator.

Grid cells in the neocortex suggests that all knowledge is learned and stored in the context of locations and location spaces and that “thinking” is movement through those location spaces. We have a long way to go before we understand the details of how the neocortex performs cognitive functions, however, we believe that the location-based framework will not only be at the core of the solutions to these problems, but will suggest solutions.

## Conclusion

It is sometimes said that neuroscience is “data rich and theory poor.” This notion is especially true for the neocortex. We are not lacking empirical data as much as lacking a theoretical framework that can bridge the gap between the heterogeneous capabilities of perception, cognition, and intelligence and the homogeneous circuitry observed in the neocortex. The closest we have to such a framework today is hierarchical feature extraction, which is widely recognized as insufficient.

One approach to developing a theory of neocortical function is to build in-silico models of a cortical column based on detailed anatomical data (Helmstaedter et al., 2007; Markram et al., 2015). This approach starts with anatomy and hopes to discover theoretical principles via simulation of a cortical column. We have used a different method. We start with a detailed function that we know the neocortex performs (such as sensory-motor learning and inference), we deduce neural mechanisms that are needed to perform those functions (such as cells that represent location), and then map those neural mechanisms onto detailed biological data.

Based on this method, this paper proposes a new framework for understanding how the neocortex works. We propose that grid cells are present everywhere in the neocortex. Cortical grid cells track the location of inputs to the neocortex in the reference frames of the objects being observed. We propose the existence of a new type of neuron, displacement cells, that complement grid cells, and are similarly present throughout the neocortex. The framework shows how it is possible that a small patch of cortex can represent and learn the morphology of objects, how objects are composed of other objects, and the behaviors of objects. The framework also leads to a new interpretation of how the neocortex works overall. Instead of processing input in a series of feature extraction steps leading to object recognition at the top of the hierarchy, the neocortex consists of 1000s of models operating in parallel as well as hierarchically.

Introspection can sometimes reveal basic truths that are missed by more objective experimental techniques. As we go about our day we perceive 1000s of objects, such as trees, printed and spoken words, buildings, and people. Everything is perceived at a location. As we attend to each object we perceive the distance and direction from ourselves to these objects, and we perceive where they are relative to each other. The sense of location and distance is inherent to perception, it occurs without effort or delay. It is self-evident that the brain must have neural representations for the locations of objects and for the distances between the objects as we attend to them in succession. The novelty of our claim is that these locations and distances are calculated everywhere in the neocortex, they are the principal data types of cortical function, perception, and intelligence.

## Statements

### Author contributions

JH, together with ML, MK, SP, and SA conceived of the overall theory and mapping to neuroscience. JH, together with SA, wrote the majority of the manuscript. ML, MK, and SP participated in writing, editing, and revising the manuscript.

### Funding

Numenta is a privately held company. Its funding sources are independent investors and venture capitalists.

### Acknowledgments

We thank the reviewers for many helpful and detailed comments which have significantly improved the overall manuscript. We thank David Eagleman, Weinan Sun, Michael Hasselmo, and Mehmet Fatih Yanik for their feedback and help with this manuscript. We also thank numerous collaborators at Numenta over the years for many discussions, especially Donna Dubinsky, Christy Maver, Celeste Baranski, Luiz Scheinkman, and Teri Fry. We also note that a version of this paper has been posted to the preprint server bioRxiv (Hawkins et al., 2018).

### Conflict of interest

JH, ML, MK, SP, and SA were employed by Numenta, Inc. Numenta has some patents relevant to the work. Numenta has stated that use of its intellectual property, including all the ideas contained in this work, is free for non-commercial research purposes. In addition Numenta has released all pertinent source code as open source under an AGPL V3 license (which includes a patent peace provision).

### Supplementary material

The Supplementary Material for this article can be found online at: [https://www.frontiersin.org/articles/10.3389/fncir.2018.00121/full#supplementary-material](#supplementary-material)

## References

- 1
	AhmedB.AndersonJ. C.DouglasR. J.MartinK. A.NelsonJ. C. (1994). Polyneuronal innervation of spiny stellate neurons in cat visual cortex.**J. Comp. Neurol.**34116–24. 10.1002/cne.903410103
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/8006220)
	- [CrossRef](https://doi.org/10.1002/cne.903410103)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=B..%2BAhmed&author=J.%2BC..%2BAnderson&author=R.%2BJ..%2BDouglas&author=K.%2BA..%2BMartin&author=J.%2BC..%2BNelson&publication_year=1994&title=Polyneuronal%2Binnervation%2Bof%2Bspiny%2Bstellate%2Bneurons%2Bin%2Bcat%2Bvisual%2Bcortex.&journal=J.+Comp.+Neurol.&volume=341&pages=16-24)
	- [View reference in article](#B1a)
- 2
	AhmedB.AndersonJ. C.MartinK. A.NelsonJ. C. (1997). Map of the synapses onto layer 4 basket cells of the primary visual cortex of the cat.**J. Comp. Neurol.**380230–242. 10.1002/(SICI)1096-9861(19970407)380:2<230::AID-CNE6>3.0.CO;2-4
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/9100134)
	- [CrossRef](https://doi.org/10.1002/\(SICI\)1096-9861\(19970407\)380:2%3C230::AID-CNE6%3E3.0.CO;2-4)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=B..%2BAhmed&author=J.%2BC..%2BAnderson&author=K.%2BA..%2BMartin&author=J.%2BC..%2BNelson&publication_year=1997&title=Map%2Bof%2Bthe%2Bsynapses%2Bonto%2Blayer%2B4%2Bbasket%2Bcells%2Bof%2Bthe%2Bprimary%2Bvisual%2Bcortex%2Bof%2Bthe%2Bcat.&journal=J.+Comp.+Neurol.&volume=380&pages=230-242)
	- [View reference in article](#B2a)
- 3
	BehrensT. E. J.MullerT. H.WhittingtonJ. C. R.MarkS.BaramA. B.StachenfeldK. L.et al (2018). What is a cognitive map? Organizing knowledge for flexible behavior.**Neuron** 100490–509. 10.1016/J.NEURON.2018.10.002
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/30359611)
	- [CrossRef](https://doi.org/10.1016/J.NEURON.2018.10.002)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=T.%2BE.%2BJ..%2BBehrens&author=T.%2BH..%2BMuller&author=J.%2BC.%2BR..%2BWhittington&author=S..%2BMark&author=A.%2BB..%2BBaram&author=K.%2BL..%2BStachenfeld&publication_year=2018&title=What%2Bis%2Ba%2Bcognitive%2Bmap%3F%2BOrganizing%2Bknowledge%2Bfor%2Bflexible%2Bbehavior.&journal=Neuron&volume=100&pages=490-509)
	- [View reference in article](#B3a)
- 4
	BensmaiaS. J.DenchevP. V.DammannJ. F.CraigJ. C.HsiaoS. S. (2008). The representation of stimulus orientation in the early stages of somatosensory processing.**J. Neurosci.**28776–786. 10.1523/JNEUROSCI.4162-07.2008
	- [CrossRef](https://doi.org/10.1523/JNEUROSCI.4162-07.2008)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=S.%2BJ..%2BBensmaia&author=P.%2BV..%2BDenchev&author=J.%2BF..%2BDammann&author=J.%2BC..%2BCraig&author=S.%2BS..%2BHsiao&publication_year=2008&title=The%2Brepresentation%2Bof%2Bstimulus%2Borientation%2Bin%2Bthe%2Bearly%2Bstages%2Bof%2Bsomatosensory%2Bprocessing.&journal=J.+Neurosci.&volume=28&pages=776-786)
	- [View reference in article](#B4a)
- 5
	BinzeggerT.DouglasR. J.MartinK. A. C. (2004). A quantitative map of the circuit of cat primary visual cortex.**J. Neurosci.**248441–8453. 10.1523/JNEUROSCI.1400-04.2004
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/15456817)
	- [CrossRef](https://doi.org/10.1523/JNEUROSCI.1400-04.2004)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=T..%2BBinzegger&author=R.%2BJ..%2BDouglas&author=K.%2BA.%2BC..%2BMartin&publication_year=2004&title=A%2Bquantitative%2Bmap%2Bof%2Bthe%2Bcircuit%2Bof%2Bcat%2Bprimary%2Bvisual%2Bcortex.&journal=J.+Neurosci.&volume=24&pages=8441-8453)
	- [View reference in article](#B5a)
- 6
	BrandonM. P.BogaardA. R.LibbyC. P.ConnerneyM. A.GuptaK.HasselmoM. E. (2011). Reduction of theta rhythm dissociates grid cell spatial periodicity from directional tuning.**Science** 332595–599. 10.1126/SCIENCE.1201652
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/21527714)
	- [CrossRef](https://doi.org/10.1126/SCIENCE.1201652)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M.%2BP..%2BBrandon&author=A.%2BR..%2BBogaard&author=C.%2BP..%2BLibby&author=M.%2BA..%2BConnerney&author=K..%2BGupta&author=M.%2BE..%2BHasselmo&publication_year=2011&title=Reduction%2Bof%2Btheta%2Brhythm%2Bdissociates%2Bgrid%2Bcell%2Bspatial%2Bperiodicity%2Bfrom%2Bdirectional%2Btuning.&journal=Science&volume=332&pages=595-599)
	- [View reference in article](#B6a)
- 7
	BurakY.FieteI. R. (2009). Accurate path integration in continuous attractor network models of grid cells.**PLoS Comput. Biol.**5:e1000291. 10.1371/journal.pcbi.1000291
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/19229307)
	- [CrossRef](https://doi.org/10.1371/journal.pcbi.1000291)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=Y..%2BBurak&author=I.%2BR..%2BFiete&publication_year=2009&title=Accurate%2Bpath%2Bintegration%2Bin%2Bcontinuous%2Battractor%2Bnetwork%2Bmodels%2Bof%2Bgrid%2Bcells.&journal=PLoS+Comput.+Biol.&volume=5)
	- [View reference in article](#B7a)
- 8
	BurgessN. (2008). Grid cells and theta as oscillatory interference: theory and predictions.**Hippocampus** 181157–1174. 10.1002/hipo.20518
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/19021256)
	- [CrossRef](https://doi.org/10.1002/hipo.20518)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=N..%2BBurgess&publication_year=2008&title=Grid%2Bcells%2Band%2Btheta%2Bas%2Boscillatory%2Binterference%3A%2Btheory%2Band%2Bpredictions.&journal=Hippocampus&volume=18&pages=1157-1174)
	- [View reference in article](#B8a)
- 9
	BurgessN.CaswellB.O’KeefeJ. (2007). An oscillatory interference model of grid cell firing.**Hippocampus** 17801–812. 10.1002/hipo
	- [CrossRef](https://doi.org/10.1002/hipo)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=N..%2BBurgess&author=B..%2BCaswell&author=J..%2BO%E2%80%99Keefe&publication_year=2007&title=An%2Boscillatory%2Binterference%2Bmodel%2Bof%2Bgrid%2Bcell%2Bfiring.&journal=Hippocampus&volume=17&pages=801-812)
	- [View reference in article](#B9a)
- 10
	BushD.BarryC.MansonD.BurgessN. (2015). Using grid cells for navigation.**Neuron** 87507–520. 10.1016/j.neuron.2015.07.006
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/26247860)
	- [CrossRef](https://doi.org/10.1016/j.neuron.2015.07.006)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=D..%2BBush&author=C..%2BBarry&author=D..%2BManson&author=N..%2BBurgess&publication_year=2015&title=Using%2Bgrid%2Bcells%2Bfor%2Bnavigation.&journal=Neuron&volume=87&pages=507-520)
	- [View reference in article](#B10a)
- 11
	ByrneP.BeckerS.BurgessN. (2007). Remembering the past and imagining the future: a neural model of spatial memory and imagery.**Psychol. Rev.**114340–375. 10.1037/0033-295X.114.2.340
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/17500630)
	- [CrossRef](https://doi.org/10.1037/0033-295X.114.2.340)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=P..%2BByrne&author=S..%2BBecker&author=N..%2BBurgess&publication_year=2007&title=Remembering%2Bthe%2Bpast%2Band%2Bimagining%2Bthe%2Bfuture%3A%2Ba%2Bneural%2Bmodel%2Bof%2Bspatial%2Bmemory%2Band%2Bimagery.&journal=Psychol.+Rev.&volume=114&pages=340-375)
	- [View reference in article](#B11a)
- 12
	ClarkeJ. M.ZaidelE. (1994). Anatomical-behavioral relationships: Corpus callosum morphometry and hemispheric specialization.**Behav. Brain Res.**64185–202. 10.1016/0166-4328(94)90131-7
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/7840886)
	- [CrossRef](https://doi.org/10.1016/0166-4328\(94\)90131-7)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J.%2BM..%2BClarke&author=E..%2BZaidel&publication_year=1994&title=Anatomical-behavioral%2Brelationships%3A%2BCorpus%2Bcallosum%2Bmorphometry%2Band%2Bhemispheric%2Bspecialization.&journal=Behav.+Brain+Res.&volume=64&pages=185-202)
	- [View reference in article](#B12a)
- 13
	ConstantinescuA. O.O’ReillyJ. X.BehrensT. E. J. (2016). Organizing conceptual knowledge in humans with a gridlike code.**Science** 3521464–1468. 10.1126/science.aaf0941
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/27313047)
	- [CrossRef](https://doi.org/10.1126/science.aaf0941)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A.%2BO..%2BConstantinescu&author=J.%2BX..%2BO%E2%80%99Reilly&author=T.%2BE.%2BJ..%2BBehrens&publication_year=2016&title=Organizing%2Bconceptual%2Bknowledge%2Bin%2Bhumans%2Bwith%2Ba%2Bgridlike%2Bcode.&journal=Science&volume=352&pages=1464-1468)
	- [View reference in article](#B13a)
- 14
	CrickF. (1984). Function of the thalamic reticular complex: the searchlight hypothesis.**Proc. Natl. Acad. Sci. U.S.A.**814586–4590. 10.1073/pnas.81.14.4586
	- [CrossRef](https://doi.org/10.1073/pnas.81.14.4586)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=F..%2BCrick&publication_year=1984&title=Function%2Bof%2Bthe%2Bthalamic%2Breticular%2Bcomplex%3A%2Bthe%2Bsearchlight%2Bhypothesis.&journal=Proc.+Natl.+Acad.+Sci.+U.S.A.&volume=81&pages=4586-4590)
	- [View reference in article](#B14a)
- 15
	CrickF. H. (1979). Thinking about the brain.**Sci. Am.**241219–232. 10.1038/scientificamerican0979-219
	- [CrossRef](https://doi.org/10.1038/scientificamerican0979-219)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=F.%2BH..%2BCrick&publication_year=1979&title=Thinking%2Babout%2Bthe%2Bbrain.&journal=Sci.+Am.&volume=241&pages=219-232)
	- [View reference in article](#B15a)
- 16
	DeshmukhS. S.KnierimJ. J. (2013). Influence of local objects on hippocampal representations: landmark vectors and memory.**Hippocampus** 23253–267. 10.1002/hipo.22101
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/23447419)
	- [CrossRef](https://doi.org/10.1002/hipo.22101)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=S.%2BS..%2BDeshmukh&author=J.%2BJ..%2BKnierim&publication_year=2013&title=Influence%2Bof%2Blocal%2Bobjects%2Bon%2Bhippocampal%2Brepresentations%3A%2Blandmark%2Bvectors%2Band%2Bmemory.&journal=Hippocampus&volume=23&pages=253-267)
	- [View reference in article](#B16a)
- 17
	DoellerC. F.BarryC.BurgessN. (2010). Evidence for grid cells in a human memory network.**Nature** 463657–661. 10.1038/nature08704
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/20090680)
	- [CrossRef](https://doi.org/10.1038/nature08704)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=C.%2BF..%2BDoeller&author=C..%2BBarry&author=N..%2BBurgess&publication_year=2010&title=Evidence%2Bfor%2Bgrid%2Bcells%2Bin%2Ba%2Bhuman%2Bmemory%2Bnetwork.&journal=Nature&volume=463&pages=657-661)
	- [View reference in article](#B17a)
- 18
	DomnisoruC.KinkhabwalaA. A.TankD. W. (2013). Membrane potential dynamics of grid cells.**Nature** 495199–204. 10.1038/nature11973
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/23395984)
	- [CrossRef](https://doi.org/10.1038/nature11973)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=C..%2BDomnisoru&author=A.%2BA..%2BKinkhabwala&author=D.%2BW..%2BTank&publication_year=2013&title=Membrane%2Bpotential%2Bdynamics%2Bof%2Bgrid%2Bcells.&journal=Nature&volume=495&pages=199-204)
	- [View reference in article](#B18a)
- 19
	DouglasR. J.MartinK. A. C. (2004). Neuronal circuits of the neocortex.**Annu. Rev. Neurosci.**27419–451. 10.1146/annurev.neuro.27.070203.144152
	- [CrossRef](https://doi.org/10.1146/annurev.neuro.27.070203.144152)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=R.%2BJ..%2BDouglas&author=K.%2BA.%2BC..%2BMartin&publication_year=2004&title=Neuronal%2Bcircuits%2Bof%2Bthe%2Bneocortex.&journal=Annu.+Rev.+Neurosci.&volume=27&pages=419-451)
	- [View reference in article](#B19a)
- 20
	DriverJ.NoesseltT. (2008). Multisensory interplay reveals crossmodal influences on ‘sensory-specific’ brain regions, neural responses, and judgments.**Neuron** 5711–23. 10.1016/J.NEURON.2007.12.013
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/18184561)
	- [CrossRef](https://doi.org/10.1016/J.NEURON.2007.12.013)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J..%2BDriver&author=T..%2BNoesselt&publication_year=2008&title=Multisensory%2Binterplay%2Breveals%2Bcrossmodal%2Binfluences%2Bon%2B%E2%80%98sensory-specific%E2%80%99%2Bbrain%2Bregions%2C%2Bneural%2Bresponses%2C%2Band%2Bjudgments.&journal=Neuron&volume=57&pages=11-23)
	- [View reference in article](#B20a)
- 21
	ErdemU. M.HasselmoM. E. (2014). A biologically inspired hierarchical goal directed navigation model.**J. Physiol. Paris** 10828–37. 10.1016/j.jphysparis.2013.07.002
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/23891644)
	- [CrossRef](https://doi.org/10.1016/j.jphysparis.2013.07.002)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=U.%2BM..%2BErdem&author=M.%2BE..%2BHasselmo&publication_year=2014&title=A%2Bbiologically%2Binspired%2Bhierarchical%2Bgoal%2Bdirected%2Bnavigation%2Bmodel.&journal=J.+Physiol.+Paris&volume=108&pages=28-37)
	- [View reference in article](#B21a)
- 22
	FellemanD. J.Van EssenD. C. (1991). Distributed hierarchical processing in the primate cerebral cortex.**Cereb. Cortex** 11–47. 10.1093/cercor/1.1.1
	- [CrossRef](https://doi.org/10.1093/cercor/1.1.1)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=D.%2BJ..%2BFelleman&author=D.%2BC..%2BVan%2BEssen&publication_year=1991&title=Distributed%2Bhierarchical%2Bprocessing%2Bin%2Bthe%2Bprimate%2Bcerebral%2Bcortex.&journal=Cereb.+Cortex&volume=1&pages=1-47)
	- [View reference in article](#B22a)
- 23
	FieteI. R.BurakY.BrookingsT. (2008). What grid cells convey about rat location.**J. Neurosci.**286858–6871. 10.1523/JNEUROSCI.5684-07.2008
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/18596161)
	- [CrossRef](https://doi.org/10.1523/JNEUROSCI.5684-07.2008)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=I.%2BR..%2BFiete&author=Y..%2BBurak&author=T..%2BBrookings&publication_year=2008&title=What%2Bgrid%2Bcells%2Bconvey%2Babout%2Brat%2Blocation.&journal=J.+Neurosci.&volume=28&pages=6858-6871)
	- [View reference in article](#B23a)
- 24
	FuhsM. C.TouretzkyD. S. (2006). A spin glass model of path integration in rat medial entorhinal cortex.**J. Neurosci.**10436–447. 10.1523/jneurosci.4353-05.2006
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/16624947)
	- [CrossRef](https://doi.org/10.1523/jneurosci.4353-05.2006)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M.%2BC..%2BFuhs&author=D.%2BS..%2BTouretzky&publication_year=2006&title=A%2Bspin%2Bglass%2Bmodel%2Bof%2Bpath%2Bintegration%2Bin%2Brat%2Bmedial%2Bentorhinal%2Bcortex.&journal=J.+Neurosci.&volume=10&pages=436-447)
	- [View reference in article](#B24a)
- 25
	FukushimaK. (1980). Neocognitron: a self-organizing neural network model for a mechanism of pattern recognition unaffected by shift in position.**Biol. Cybern.**36193–202. 10.1007/BF00344251
	- [CrossRef](https://doi.org/10.1007/BF00344251)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=K..%2BFukushima&publication_year=1980&title=Neocognitron%3A%2Ba%2Bself-organizing%2Bneural%2Bnetwork%2Bmodel%2Bfor%2Ba%2Bmechanism%2Bof%2Bpattern%2Brecognition%2Bunaffected%2Bby%2Bshift%2Bin%2Bposition.&journal=Biol.+Cybern.&volume=36&pages=193-202)
	- [View reference in article](#B25a)
- 26
	GiocomoL. M.MoserM. B.MoserE. I. (2011). Computational models of grid cells.**Neuron** 71589–603. 10.1016/j.neuron.2011.07.023
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/21867877)
	- [CrossRef](https://doi.org/10.1016/j.neuron.2011.07.023)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=L.%2BM..%2BGiocomo&author=M.%2BB..%2BMoser&author=E.%2BI..%2BMoser&publication_year=2011&title=Computational%2Bmodels%2Bof%2Bgrid%2Bcells.&journal=Neuron&volume=71&pages=589-603)
	- [View reference in article](#B26a)
- 27
	GiocomoL. M.StensolaT.BonnevieT.Van CauterT.MoserM.-B.MoserE. I. (2014). Topography of head direction cells in medial entorhinal cortex.**Curr. Biol.**24252–262. 10.1016/J.CUB.2013.12.002
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/24440398)
	- [CrossRef](https://doi.org/10.1016/J.CUB.2013.12.002)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=L.%2BM..%2BGiocomo&author=T..%2BStensola&author=T..%2BBonnevie&author=T..%2BVan%2BCauter&author=M.-B..%2BMoser&author=E.%2BI..%2BMoser&publication_year=2014&title=Topography%2Bof%2Bhead%2Bdirection%2Bcells%2Bin%2Bmedial%2Bentorhinal%2Bcortex.&journal=Curr.+Biol.&volume=24&pages=252-262)
	- [View reference in article](#B27a)
- 28
	GiocomoL. M.ZilliE. A.FransénE.HasselmoM. E. (2007). Temporal frequency of subthreshold oscillations scales with entorhinal grid cell field spacing.**Science** 3151719–1722. 10.1126/science.1139207
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/17379810)
	- [CrossRef](https://doi.org/10.1126/science.1139207)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=L.%2BM..%2BGiocomo&author=E.%2BA..%2BZilli&author=E..%2BFrans%C3%A9n&author=M.%2BE..%2BHasselmo&publication_year=2007&title=Temporal%2Bfrequency%2Bof%2Bsubthreshold%2Boscillations%2Bscales%2Bwith%2Bentorhinal%2Bgrid%2Bcell%2Bfield%2Bspacing.&journal=Science&volume=315&pages=1719-1722)
	- [View reference in article](#B28a)
- 29
	GoodaleM. A.MilnerA. D. (1992). Separate visual pathways for perception and action.**Trends Neurosci.**1520–25. 10.1016/0166-2236(92)90344-8
	- [CrossRef](https://doi.org/10.1016/0166-2236\(92\)90344-8)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M.%2BA..%2BGoodale&author=A.%2BD..%2BMilner&publication_year=1992&title=Separate%2Bvisual%2Bpathways%2Bfor%2Bperception%2Band%2Baction.&journal=Trends+Neurosci.&volume=15&pages=20-25)
	- [View reference in article](#B29a)
- 30
	GuY.LewallenS.KinkhabwalaA. A.DomnisoruC.YoonK.GauthierJ. L.et al (2018). A map-like micro-organization of grid cells in the medial entorhinal cortex.**Cell** 175736–750.e30. 10.1016/j.cell.2018.08.066
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/30270041)
	- [CrossRef](https://doi.org/10.1016/j.cell.2018.08.066)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=Y..%2BGu&author=S..%2BLewallen&author=A.%2BA..%2BKinkhabwala&author=C..%2BDomnisoru&author=K..%2BYoon&author=J.%2BL..%2BGauthier&publication_year=2018&title=A%2Bmap-like%2Bmicro-organization%2Bof%2Bgrid%2Bcells%2Bin%2Bthe%2Bmedial%2Bentorhinal%2Bcortex.&journal=Cell&volume=175&pages=736-750.e30)
	- [View reference in article](#B30a)
- 31
	GuilleryR. W.ShermanS. M. (2002). The thalamus as a monitor of motor outputs.**Philos. Trans. R. Soc. B Biol. Sci.**3571809–1821. 10.1098/rstb.2002.1171
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/12626014)
	- [CrossRef](https://doi.org/10.1098/rstb.2002.1171)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=R.%2BW..%2BGuillery&author=S.%2BM..%2BSherman&publication_year=2002&title=The%2Bthalamus%2Bas%2Ba%2Bmonitor%2Bof%2Bmotor%2Boutputs.&journal=Philos.+Trans.+R.+Soc.+B+Biol.+Sci.&volume=357&pages=1809-1821)
	- [View reference in article](#B31a)
- 32
	GuilleryR. W.ShermanS. M. (2011). Branched thalamic afferents: what are the messages that they relay to the cortex?**Brain Res. Rev.**66205–219. 10.1016/j.brainresrev.2010.08.001
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/20696186)
	- [CrossRef](https://doi.org/10.1016/j.brainresrev.2010.08.001)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=R.%2BW..%2BGuillery&author=S.%2BM..%2BSherman&publication_year=2011&title=Branched%2Bthalamic%2Bafferents%3A%2Bwhat%2Bare%2Bthe%2Bmessages%2Bthat%2Bthey%2Brelay%2Bto%2Bthe%2Bcortex%3F&journal=Brain+Res.+Rev.&volume=66&pages=205-219)
	- [View reference in article](#B32a)
- 33
	HaftingT.FyhnM.MoldenS.MoserM.-B.MoserE. I. (2005). Microstructure of a spatial map in the entorhinal cortex.**Nature** 436801–806. 10.1038/nature03721
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/15965463)
	- [CrossRef](https://doi.org/10.1038/nature03721)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=T..%2BHafting&author=M..%2BFyhn&author=S..%2BMolden&author=M.-B..%2BMoser&author=E.%2BI..%2BMoser&publication_year=2005&title=Microstructure%2Bof%2Ba%2Bspatial%2Bmap%2Bin%2Bthe%2Bentorhinal%2Bcortex.&journal=Nature&volume=436&pages=801-806)
	- [View reference in article](#B33a)
- 34
	HardcastleK.GanguliS.GiocomoL. M. (2017). Cell types for our sense of location: where we are and where we are going.**Nat. Neurosci.**201474–1482. 10.1038/nn.4654
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/29073649)
	- [CrossRef](https://doi.org/10.1038/nn.4654)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=K..%2BHardcastle&author=S..%2BGanguli&author=L.%2BM..%2BGiocomo&publication_year=2017&title=Cell%2Btypes%2Bfor%2Bour%2Bsense%2Bof%2Blocation%3A%2Bwhere%2Bwe%2Bare%2Band%2Bwhere%2Bwe%2Bare%2Bgoing.&journal=Nat.+Neurosci.&volume=20&pages=1474-1482)
	- [View reference in article](#B34a)
- 35
	HasselmoM. (2012). **How we Remember: Brain Mechanisms of Episodic Memory.**Cambridge, MA: MIT Press.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M..%2BHasselmo&publication_year=2012&journal=How+we+Remember%3A+Brain+Mechanisms+of+Episodic+Memory.)
	- [View reference in article](#B35a)
- 36
	HasselmoM. E. (2008). Grid cell mechanisms and function: contributions of entorhinal persistent spiking and phase resetting.**Hippocampus** 181213–1229. 10.1002/hipo.20512
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/19021258)
	- [CrossRef](https://doi.org/10.1002/hipo.20512)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M.%2BE..%2BHasselmo&publication_year=2008&title=Grid%2Bcell%2Bmechanisms%2Band%2Bfunction%3A%2Bcontributions%2Bof%2Bentorhinal%2Bpersistent%2Bspiking%2Band%2Bphase%2Bresetting.&journal=Hippocampus&volume=18&pages=1213-1229)
	- [View reference in article](#B36a)
- 37
	HasselmoM. E. (2009). A model of episodic memory: mental time travel along encoded trajectories using grid cells.**Neurobiol. Learn. Mem.**92559–573. 10.1016/j.nlm.2009.07.005
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/19615456)
	- [CrossRef](https://doi.org/10.1016/j.nlm.2009.07.005)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M.%2BE..%2BHasselmo&publication_year=2009&title=A%2Bmodel%2Bof%2Bepisodic%2Bmemory%3A%2Bmental%2Btime%2Btravel%2Balong%2Bencoded%2Btrajectories%2Busing%2Bgrid%2Bcells.&journal=Neurobiol.+Learn.+Mem.&volume=92&pages=559-573)
	- [View reference in article](#B37a)
- 38
	HasselmoM. E.BrandonM. P. (2012). A model combining oscillations and attractor dynamics for generation of grid cell firing.**Front. Neural Circuits** 6:30. 10.3389/fncir.2012.00030
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/22654735)
	- [CrossRef](https://doi.org/10.3389/fncir.2012.00030)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M.%2BE..%2BHasselmo&author=M.%2BP..%2BBrandon&publication_year=2012&title=A%2Bmodel%2Bcombining%2Boscillations%2Band%2Battractor%2Bdynamics%2Bfor%2Bgeneration%2Bof%2Bgrid%2Bcell%2Bfiring.&journal=Front.+Neural+Circuits&volume=6)
	- [View reference in article](#B38a)
- 39
	HasselmoM. E.GiocomoL. M.BrandonM. P.YoshidaM. (2010). Cellular dynamical mechanisms for encoding the time and place of events along spatiotemporal trajectories in episodic memory.**Behav. Brain Res.**215261–274. 10.1016/j.bbr.2009.12.010
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/20018213)
	- [CrossRef](https://doi.org/10.1016/j.bbr.2009.12.010)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M.%2BE..%2BHasselmo&author=L.%2BM..%2BGiocomo&author=M.%2BP..%2BBrandon&author=M..%2BYoshida&publication_year=2010&title=Cellular%2Bdynamical%2Bmechanisms%2Bfor%2Bencoding%2Bthe%2Btime%2Band%2Bplace%2Bof%2Bevents%2Balong%2Bspatiotemporal%2Btrajectories%2Bin%2Bepisodic%2Bmemory.&journal=Behav.+Brain+Res.&volume=215&pages=261-274)
	- [View reference in article](#B39a)
- 40
	HawkinsJ.AhmadS. (2016). Why neurons have thousands of synapses, a theory of sequence memory in neocortex.**Front. Neural Circuits** 10:23. 10.3389/fncir.2016.00023
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/27065813)
	- [CrossRef](https://doi.org/10.3389/fncir.2016.00023)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J..%2BHawkins&author=S..%2BAhmad&publication_year=2016&title=Why%2Bneurons%2Bhave%2Bthousands%2Bof%2Bsynapses%2C%2Ba%2Btheory%2Bof%2Bsequence%2Bmemory%2Bin%2Bneocortex.&journal=Front.+Neural+Circuits&volume=10)
	- [View reference in article](#B40a)
- 41
	HawkinsJ.AhmadS.CuiY. (2017). A theory of how columns in the neocortex enable learning the structure of the world.**Front. Neural Circuits** 11:81. 10.3389/FNCIR.2017.00081
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/29118696)
	- [CrossRef](https://doi.org/10.3389/FNCIR.2017.00081)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J..%2BHawkins&author=S..%2BAhmad&author=Y..%2BCui&publication_year=2017&title=A%2Btheory%2Bof%2Bhow%2Bcolumns%2Bin%2Bthe%2Bneocortex%2Benable%2Blearning%2Bthe%2Bstructure%2Bof%2Bthe%2Bworld.&journal=Front.+Neural+Circuits&volume=11)
	- [View reference in article](#B41a)
- 42
	HawkinsJ.BlakesleeS. (2004). **On Intelligence.**New York, NY: Times Books.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J..%2BHawkins&author=S..%2BBlakeslee&publication_year=2004&journal=On+Intelligence.)
	- [View reference in article](#B42a)
- 43
	HawkinsJ.LewisM.KlukasM.PurdyS.AhmadS. (2018). A framework for intelligence and cortical function based on grid cells in the neocortex.**bioRxiv** \[Preprint\]. 10.1101/442418
	- [CrossRef](https://doi.org/10.1101/442418)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J..%2BHawkins&author=M..%2BLewis&author=M..%2BKlukas&author=S..%2BPurdy&author=S..%2BAhmad&publication_year=2018&title=A%2Bframework%2Bfor%2Bintelligence%2Band%2Bcortical%2Bfunction%2Bbased%2Bon%2Bgrid%2Bcells%2Bin%2Bthe%2Bneocortex.&journal=bioRxiv)
- 44
	HelmstaedterM.de KockC. P. J.FeldmeyerD.BrunoR. M.SakmannB. (2007). Reconstruction of an average cortical column in silico.**Brain Res. Rev.**55193–203. 10.1016/J.BRAINRESREV.2007.07.011
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/17822776)
	- [CrossRef](https://doi.org/10.1016/J.BRAINRESREV.2007.07.011)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M..%2BHelmstaedter&author=C.%2BP.%2BJ..%2Bde%2BKock&author=D..%2BFeldmeyer&author=R.%2BM..%2BBruno&author=B..%2BSakmann&publication_year=2007&title=Reconstruction%2Bof%2Ban%2Baverage%2Bcortical%2Bcolumn%2Bin%2Bsilico.&journal=Brain+Res.+Rev.&volume=55&pages=193-203)
	- [View reference in article](#B44a)
- 45
	HsiaoS. S.LaneJ.FitzgeraldP. (2002). Representation of orientation in the somatosensory system.**Behav. Brain Res.**13593–103. 10.1016/S0166-4328(02)00160-2
	- [CrossRef](https://doi.org/10.1016/S0166-4328\(02\)00160-2)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=S.%2BS..%2BHsiao&author=J..%2BLane&author=P..%2BFitzgerald&publication_year=2002&title=Representation%2Bof%2Borientation%2Bin%2Bthe%2Bsomatosensory%2Bsystem.&journal=Behav.+Brain+Res.&volume=135&pages=93-103)
	- [View reference in article](#B45a)
- 46
	JacobsJ.WeidemannC. T.MillerJ. F.SolwayA.BurkeJ. F.WeiX. X.et al (2013). Direct recordings of grid-like neuronal activity in human spatial navigation.**Nat. Neurosci.**161188–1190. 10.1038/nn.3466
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/23912946)
	- [CrossRef](https://doi.org/10.1038/nn.3466)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J..%2BJacobs&author=C.%2BT..%2BWeidemann&author=J.%2BF..%2BMiller&author=A..%2BSolway&author=J.%2BF..%2BBurke&author=X.%2BX..%2BWei&publication_year=2013&title=Direct%2Brecordings%2Bof%2Bgrid-like%2Bneuronal%2Bactivity%2Bin%2Bhuman%2Bspatial%2Bnavigation.&journal=Nat.+Neurosci.&volume=16&pages=1188-1190)
	- [View reference in article](#B46a)
- 47
	JulianJ. B.KeinathA. T.FrazzettaG.EpsteinR. A. (2018). Human entorhinal cortex represents visual space using a boundary-anchored grid.**Nat. Neurosci.**21191–194. 10.1038/s41593-017-0049-1
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/29311745)
	- [CrossRef](https://doi.org/10.1038/s41593-017-0049-1)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J.%2BB..%2BJulian&author=A.%2BT..%2BKeinath&author=G..%2BFrazzetta&author=R.%2BA..%2BEpstein&publication_year=2018&title=Human%2Bentorhinal%2Bcortex%2Brepresents%2Bvisual%2Bspace%2Busing%2Ba%2Bboundary-anchored%2Bgrid.&journal=Nat.+Neurosci.&volume=21&pages=191-194)
	- [View reference in article](#B47a)
- 48
	KimJ.MatneyC. J.BlankenshipA.HestrinS.BrownS. P. (2014). Layer 6 corticothalamic neurons activate a cortical output layer, layer 5a.**J. Neurosci.**349656–9664. 10.1523/JNEUROSCI.1325-14.2014
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/25031405)
	- [CrossRef](https://doi.org/10.1523/JNEUROSCI.1325-14.2014)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J..%2BKim&author=C.%2BJ..%2BMatney&author=A..%2BBlankenship&author=S..%2BHestrin&author=S.%2BP..%2BBrown&publication_year=2014&title=Layer%2B6%2Bcorticothalamic%2Bneurons%2Bactivate%2Ba%2Bcortical%2Boutput%2Blayer%2C%2Blayer%2B5a.&journal=J.+Neurosci.&volume=34&pages=9656-9664)
	- [View reference in article](#B48a)
- 49
	KomorowskiR. W.MannsJ. R.EichenbaumH. (2009). Robust conjunctive item-place coding by hippocampal neurons parallels learning what happens where.**J. Neurosci.**299918–9929. 10.1523/JNEUROSCI.1378-09.2009
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/19657042)
	- [CrossRef](https://doi.org/10.1523/JNEUROSCI.1378-09.2009)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=R.%2BW..%2BKomorowski&author=J.%2BR..%2BManns&author=H..%2BEichenbaum&publication_year=2009&title=Robust%2Bconjunctive%2Bitem-place%2Bcoding%2Bby%2Bhippocampal%2Bneurons%2Bparallels%2Blearning%2Bwhat%2Bhappens%2Bwhere.&journal=J.+Neurosci.&volume=29&pages=9918-9929)
	- [View reference in article](#B49a)
- 50
	KropffE.CarmichaelJ. E.MoserM.-B.MoserE. I. (2015). Speed cells in the medial entorhinal cortex.**Nature** 523419–424. 10.1038/nature14622
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/26176924)
	- [CrossRef](https://doi.org/10.1038/nature14622)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=E..%2BKropff&author=J.%2BE..%2BCarmichael&author=M.-B..%2BMoser&author=E.%2BI..%2BMoser&publication_year=2015&title=Speed%2Bcells%2Bin%2Bthe%2Bmedial%2Bentorhinal%2Bcortex.&journal=Nature&volume=523&pages=419-424)
	- [View reference in article](#B50a)
- 51
	LashleyK. S. (1951). “The problem of serial order in behavior.” in **Cerebral Mechanisms in Behavior; the Hixon Symposium**, ed.JeffresL. A. (New York, NY: Wiley), 112–131.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=K.%2BS..%2BLashley&publication_year=1951&title=The%2Bproblem%2Bof%2Bserial%2Border%2Bin%2Bbehavior.&journal=Cerebral+Mechanisms+in+Behavior%3B+the+Hixon+Symposium&pages=112-131)
	- [View reference in article](#B51a)
- 52
	LeCunY.BengioY.HintonG. (2015). Deep learning.**Nature** 521436–444. 10.1038/nature14539
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/26017442)
	- [CrossRef](https://doi.org/10.1038/nature14539)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=Y..%2BLeCun&author=Y..%2BBengio&author=G..%2BHinton&publication_year=2015&title=Deep%2Blearning.&journal=Nature&volume=521&pages=436-444)
	- [View reference in article](#B52a)
- 53
	LeinweberM.WardD. R.SobczakJ. M.AttingerA.KellerG. B. (2017). A sensorimotor circuit in mouse cortex for visual flow predictions.**Neuron** 951420–1432.e5. 10.1016/j.neuron.2017.08.036
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/28910624)
	- [CrossRef](https://doi.org/10.1016/j.neuron.2017.08.036)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M..%2BLeinweber&author=D.%2BR..%2BWard&author=J.%2BM..%2BSobczak&author=A..%2BAttinger&author=G.%2BB..%2BKeller&publication_year=2017&title=A%2Bsensorimotor%2Bcircuit%2Bin%2Bmouse%2Bcortex%2Bfor%2Bvisual%2Bflow%2Bpredictions.&journal=Neuron&volume=95&pages=1420-1432.e5)
	- [View reference in article](#B53a)
- 54
	LeverC.BurtonS.JeewajeeA.O’KeefeJ.BurgessN. (2009). Boundary vector cells in the subiculum of the hippocampal formation.**J. Neurosci.**299771–9777. 10.1523/JNEUROSCI.1319-09.2009
	- [CrossRef](https://doi.org/10.1523/JNEUROSCI.1319-09.2009)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=C..%2BLever&author=S..%2BBurton&author=A..%2BJeewajee&author=J..%2BO%E2%80%99Keefe&author=N..%2BBurgess&publication_year=2009&title=Boundary%2Bvector%2Bcells%2Bin%2Bthe%2Bsubiculum%2Bof%2Bthe%2Bhippocampal%2Bformation.&journal=J.+Neurosci.&volume=29&pages=9771-9777)
	- [View reference in article](#B54a)
- 55
	LewisM.PurdyS.AhmadS.HawkinsJ. (2018). Locations in the neocortex: a theory of sensorimotor object recognition using cortical grid cells.**bioRxiv** \[Preprint\]. 10.1101/436352
	- [CrossRef](https://doi.org/10.1101/436352)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M..%2BLewis&author=S..%2BPurdy&author=S..%2BAhmad&author=J..%2BHawkins&publication_year=2018&title=Locations%2Bin%2Bthe%2Bneocortex%3A%2Ba%2Btheory%2Bof%2Bsensorimotor%2Bobject%2Brecognition%2Busing%2Bcortical%2Bgrid%2Bcells.&journal=bioRxiv)
	- [View reference in article](#B55a)
- 56
	LongX.ZhangS.-J. (2018). A novel somatosensory spatial navigation system outside the hippocampal formation.**bioRxiv** \[Preprint\]. 10.1101/473090
	- [CrossRef](https://doi.org/10.1101/473090)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=X..%2BLong&author=S.-J..%2BZhang&publication_year=2018&title=A%2Bnovel%2Bsomatosensory%2Bspatial%2Bnavigation%2Bsystem%2Boutside%2Bthe%2Bhippocampal%2Bformation.&journal=bioRxiv)
	- [View reference in article](#B56a)
- 57
	LotterW.KreimanG.CoxD. (2018). A neural network trained to predict future video frames mimics critical properties of biological neuronal responses and perception.**arXiv** \[Preprint\]. arXiv:1805.10734
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=W..%2BLotter&author=G..%2BKreiman&author=D..%2BCox&publication_year=2018&title=A%2Bneural%2Bnetwork%2Btrained%2Bto%2Bpredict%2Bfuture%2Bvideo%2Bframes%2Bmimics%2Bcritical%2Bproperties%2Bof%2Bbiological%2Bneuronal%2Bresponses%2Band%2Bperception.&journal=arXiv)
	- [View reference in article](#B57a)
- 58
	MarkovN. T.VezoliJ.ChameauP.FalchierA.QuilodranR.HuissoudC.et al (2014). Anatomy of hierarchy: feedforward and feedback pathways in macaque visual cortex.**J. Comp. Neurol.**522225–259. 10.1002/cne.23458
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/23983048)
	- [CrossRef](https://doi.org/10.1002/cne.23458)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=N.%2BT..%2BMarkov&author=J..%2BVezoli&author=P..%2BChameau&author=A..%2BFalchier&author=R..%2BQuilodran&author=C..%2BHuissoud&publication_year=2014&title=Anatomy%2Bof%2Bhierarchy%3A%2Bfeedforward%2Band%2Bfeedback%2Bpathways%2Bin%2Bmacaque%2Bvisual%2Bcortex.&journal=J.+Comp.+Neurol.&volume=522&pages=225-259)
	- [View reference in article](#B58a)
- 59
	MarkramH.MullerE.RamaswamyS.ReimannM. W.AbdellahM.SanchezC. A.et al (2015). Reconstruction and simulation of neocortical microcircuitry.**Cell** 163456–492. 10.1016/j.cell.2015.09.029
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/26451489)
	- [CrossRef](https://doi.org/10.1016/j.cell.2015.09.029)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=H..%2BMarkram&author=E..%2BMuller&author=S..%2BRamaswamy&author=M.%2BW..%2BReimann&author=M..%2BAbdellah&author=C.%2BA..%2BSanchez&publication_year=2015&title=Reconstruction%2Band%2Bsimulation%2Bof%2Bneocortical%2Bmicrocircuitry.&journal=Cell&volume=163&pages=456-492)
	- [View reference in article](#B59a)
- 60
	MarozziE.GinzbergL. L.AlendaA.JefferyK. J. (2015). Purely translational realignment in grid cell firing patterns following nonmetric context change.**Cereb. Cortex** 254619–4627. 10.1093/cercor/bhv120
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/26048956)
	- [CrossRef](https://doi.org/10.1093/cercor/bhv120)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=E..%2BMarozzi&author=L.%2BL..%2BGinzberg&author=A..%2BAlenda&author=K.%2BJ..%2BJeffery&publication_year=2015&title=Purely%2Btranslational%2Brealignment%2Bin%2Bgrid%2Bcell%2Bfiring%2Bpatterns%2Bfollowing%2Bnonmetric%2Bcontext%2Bchange.&journal=Cereb.+Cortex&volume=25&pages=4619-4627)
	- [View reference in article](#B60a)
- 61
	McAlonanK.CavanaughJ.WurtzR. H. (2006). Attentional modulation of thalamic reticular neurons.**J. Neurosci.**264444–4450. 10.1523/JNEUROSCI.5602-05.2006
	- [CrossRef](https://doi.org/10.1523/JNEUROSCI.5602-05.2006)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=K..%2BMcAlonan&author=J..%2BCavanaugh&author=R.%2BH..%2BWurtz&publication_year=2006&title=Attentional%2Bmodulation%2Bof%2Bthalamic%2Breticular%2Bneurons.&journal=J.+Neurosci.&volume=26&pages=4444-4450)
	- [View reference in article](#B61a)
- 62
	McGuireB. A.HornungJ. P.GilbertC. D.WieselT. N. (1984). Patterns of synaptic input to layer 4 of cat striate cortex.**J. Neurosci.**43021–3033. 10.1523/JNEUROSCI.04-12-03021.1984
	- [CrossRef](https://doi.org/10.1523/JNEUROSCI.04-12-03021.1984)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=B.%2BA..%2BMcGuire&author=J.%2BP..%2BHornung&author=C.%2BD..%2BGilbert&author=T.%2BN..%2BWiesel&publication_year=1984&title=Patterns%2Bof%2Bsynaptic%2Binput%2Bto%2Blayer%2B4%2Bof%2Bcat%2Bstriate%2Bcortex.&journal=J.+Neurosci.&volume=4&pages=3021-3033)
	- [View reference in article](#B62a)
- 63
	McNaughtonB. L.BattagliaF. P.JensenO.MoserE. I.MoserM.-B. (2006). Path integration and the neural basis of the “cognitive map”.**Nat. Rev. Neurosci.**7663–678. 10.1038/nrn1932
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/16858394)
	- [CrossRef](https://doi.org/10.1038/nrn1932)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=B.%2BL..%2BMcNaughton&author=F.%2BP..%2BBattaglia&author=O..%2BJensen&author=E.%2BI..%2BMoser&author=M.-B..%2BMoser&publication_year=2006&title=Path%2Bintegration%2Band%2Bthe%2Bneural%2Bbasis%2Bof%2Bthe%2B%E2%80%9Ccognitive%2Bmap%E2%80%9D.&journal=Nat.+Rev.+Neurosci.&volume=7&pages=663-678)
	- [View reference in article](#B63a)
- 64
	MoserE. I.KropffE.MoserM.-B. (2008). Place cells, grid cells, and the brain’s spatial representation system.**Annu. Rev. Neurosci.**3169–89. 10.1146/annurev.neuro.31.061307.090723
	- [CrossRef](https://doi.org/10.1146/annurev.neuro.31.061307.090723)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=E.%2BI..%2BMoser&author=E..%2BKropff&author=M.-B..%2BMoser&publication_year=2008&title=Place%2Bcells%2C%2Bgrid%2Bcells%2C%2Band%2Bthe%2Bbrain%E2%80%99s%2Bspatial%2Brepresentation%2Bsystem.&journal=Annu.+Rev.+Neurosci.&volume=31&pages=69-89)
	- [View reference in article](#B64a)
- 65
	MountcastleV. (1978). “An organizing principle for cerebral function: the unit model and the distributed system,” in **The Mindful Brain**, edsEdelmanG.MountcastleV. (Cambridge, MA: MIT Press), 7–50.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=V..%2BMountcastle&publication_year=1978&title=%E2%80%9CAn%2Borganizing%2Bprinciple%2Bfor%2Bcerebral%2Bfunction%3A%2Bthe%2Bunit%2Bmodel%2Band%2Bthe%2Bdistributed%2Bsystem%2C%E2%80%9D%2Bin&journal=The+Mindful+Brain&pages=7-50)
	- [View reference in article](#B65a)
- 66
	NelsonA.SchneiderD. M.TakatohJ.SakuraiK.WangF.MooneyR. (2013). A circuit for motor cortical modulation of auditory cortical activity.**J. Neurosci.**3314342–14353. 10.1523/JNEUROSCI.2275-13.2013
	- [CrossRef](https://doi.org/10.1523/JNEUROSCI.2275-13.2013)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A..%2BNelson&author=D.%2BM..%2BSchneider&author=J..%2BTakatoh&author=K..%2BSakurai&author=F..%2BWang&author=R..%2BMooney&publication_year=2013&title=A%2Bcircuit%2Bfor%2Bmotor%2Bcortical%2Bmodulation%2Bof%2Bauditory%2Bcortical%2Bactivity.&journal=J.+Neurosci.&volume=33&pages=14342-14353)
	- [View reference in article](#B66a)
- 67
	O’KeefeJ.BurgessN. (2005). Dual phase and rate coding in hippocampal place cells: theoretical significance and relationship to entorhinal grid cells.**Hippocampus** 15853–866. 10.1002/hipo.20115
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/16145693)
	- [CrossRef](https://doi.org/10.1002/hipo.20115)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J..%2BO%E2%80%99Keefe&author=N..%2BBurgess&publication_year=2005&title=Dual%2Bphase%2Band%2Brate%2Bcoding%2Bin%2Bhippocampal%2Bplace%2Bcells%3A%2Btheoretical%2Bsignificance%2Band%2Brelationship%2Bto%2Bentorhinal%2Bgrid%2Bcells.&journal=Hippocampus&volume=15&pages=853-866)
	- [View reference in article](#B67a)
- 68
	O’KeefeJ.DostrovskyJ. (1971). The hippocampus as a spatial map. Preliminary evidence from unit activity in the freely-moving rat.**Brain Res.**34171–175. 10.1016/0006-8993(71)90358-1
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/5124915)
	- [CrossRef](https://doi.org/10.1016/0006-8993\(71\)90358-1)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J..%2BO%E2%80%99Keefe&author=J..%2BDostrovsky&publication_year=1971&title=The%2Bhippocampus%2Bas%2Ba%2Bspatial%2Bmap.%2BPreliminary%2Bevidence%2Bfrom%2Bunit%2Bactivity%2Bin%2Bthe%2Bfreely-moving%2Brat.&journal=Brain+Res.&volume=34&pages=171-175)
	- [View reference in article](#B68a)
- 69
	O’KeefeJ.NadelL. (1978). **The Hippocampus as a Cognitive Map.**Oxford: Oxford University Press. 10.1017/CBO9781107415324.004
	- [CrossRef](https://doi.org/10.1017/CBO9781107415324.004)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J..%2BO%E2%80%99Keefe&author=L..%2BNadel&publication_year=1978&journal=The+Hippocampus+as+a+Cognitive+Map.)
	- [View reference in article](#B69a)
- 70
	PruszynskiJ. A.JohanssonR. S. (2014). Edge-orientation processing in first-order tactile neurons.**Nat. Neurosci.**171404–1409. 10.1038/nn.3804
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/25174006)
	- [CrossRef](https://doi.org/10.1038/nn.3804)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J.%2BA..%2BPruszynski&author=R.%2BS..%2BJohansson&publication_year=2014&title=Edge-orientation%2Bprocessing%2Bin%2Bfirst-order%2Btactile%2Bneurons.&journal=Nat.+Neurosci.&volume=17&pages=1404-1409)
	- [View reference in article](#B70a)
- 71
	RaoR. P. N.BallardD. H. (1999). Predictive coding in the visual cortex: a functional interpretation of some extra-classical receptive-field effects.**Nat. Neurosci.**279–87. 10.1038/4580
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/10195184)
	- [CrossRef](https://doi.org/10.1038/4580)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=R.%2BP.%2BN..%2BRao&author=D.%2BH..%2BBallard&publication_year=1999&title=Predictive%2Bcoding%2Bin%2Bthe%2Bvisual%2Bcortex%3A%2Ba%2Bfunctional%2Binterpretation%2Bof%2Bsome%2Bextra-classical%2Breceptive-field%2Beffects.&journal=Nat.+Neurosci.&volume=2&pages=79-87)
	- [View reference in article](#B71a)
- 72
	RaudiesF.HinmanJ. R.HasselmoM. E. (2016). Modelling effects on grid cells of sensory input during self-motion.**J. Physiol.**5946513–6526. 10.1113/JP270649
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/27094096)
	- [CrossRef](https://doi.org/10.1113/JP270649)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=F..%2BRaudies&author=J.%2BR..%2BHinman&author=M.%2BE..%2BHasselmo&publication_year=2016&title=Modelling%2Beffects%2Bon%2Bgrid%2Bcells%2Bof%2Bsensory%2Binput%2Bduring%2Bself-motion.&journal=J.+Physiol.&volume=594&pages=6513-6526)
	- [View reference in article](#B72a)
- 73
	RauscheckerJ. P. (2015). Auditory and visual cortex of primates: a comparison of two sensory systems.**Eur. J. Neurosci.**41579–585. 10.1111/ejn.12844
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/25728177)
	- [CrossRef](https://doi.org/10.1111/ejn.12844)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J.%2BP..%2BRauschecker&publication_year=2015&title=Auditory%2Band%2Bvisual%2Bcortex%2Bof%2Bprimates%3A%2Ba%2Bcomparison%2Bof%2Btwo%2Bsensory%2Bsystems.&journal=Eur.+J.+Neurosci.&volume=41&pages=579-585)
	- [View reference in article](#B73a)
- 74
	RiesenhuberM.PoggioT. (1999). Hierarchical models of object recognition in cortex.**Nat. Neurosci.**21019–1025. 10.1038/14819
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/10526343)
	- [CrossRef](https://doi.org/10.1038/14819)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M..%2BRiesenhuber&author=T..%2BPoggio&publication_year=1999&title=Hierarchical%2Bmodels%2Bof%2Bobject%2Brecognition%2Bin%2Bcortex.&journal=Nat.+Neurosci.&volume=2&pages=1019-1025)
	- [View reference in article](#B74a)
- 75
	RowlandD. C.MoserM. B. (2014). From cortical modules to memories.**Curr. Opin. Neurobiol.**2422–27. 10.1016/j.conb.2013.08.012
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/24492074)
	- [CrossRef](https://doi.org/10.1016/j.conb.2013.08.012)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=D.%2BC..%2BRowland&author=M.%2BB..%2BMoser&publication_year=2014&title=From%2Bcortical%2Bmodules%2Bto%2Bmemories.&journal=Curr.+Opin.+Neurobiol.&volume=24&pages=22-27)
	- [View reference in article](#B75a)
- 76
	RowlandD. C.RoudiY.MoserM.-B.MoserE. I. (2016). Ten years of grid cells.**Annu. Rev. Neurosci.**3919–40. 10.1146/annurev-neuro-070815-013824
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/27023731)
	- [CrossRef](https://doi.org/10.1146/annurev-neuro-070815-013824)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=D.%2BC..%2BRowland&author=Y..%2BRoudi&author=M.-B..%2BMoser&author=E.%2BI..%2BMoser&publication_year=2016&title=Ten%2Byears%2Bof%2Bgrid%2Bcells.&journal=Annu.+Rev.+Neurosci.&volume=39&pages=19-40)
	- [View reference in article](#B76a)
- 77
	RowlandD. C.WeibleA. P.WickershamI. R.WuH.MayfordM.WitterM. P.et al (2013). Transgenically targeted rabies virus demonstrates a major monosynaptic projection from hippocampal area CA2 to medial entorhinal layer II neurons.**J. Neurosci.**3314889–14898. 10.1523/JNEUROSCI.1046-13.2013
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/24027288)
	- [CrossRef](https://doi.org/10.1523/JNEUROSCI.1046-13.2013)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=D.%2BC..%2BRowland&author=A.%2BP..%2BWeible&author=I.%2BR..%2BWickersham&author=H..%2BWu&author=M..%2BMayford&author=M.%2BP..%2BWitter&publication_year=2013&title=Transgenically%2Btargeted%2Brabies%2Bvirus%2Bdemonstrates%2Ba%2Bmajor%2Bmonosynaptic%2Bprojection%2Bfrom%2Bhippocampal%2Barea%2BCA2%2Bto%2Bmedial%2Bentorhinal%2Blayer%2BII%2Bneurons.&journal=J.+Neurosci.&volume=33&pages=14889-14898)
	- [View reference in article](#B77a)
- 78
	SargoliniF.FyhnM.HaftingT.McNaughtonB. L.WitterM. P.MoserM. B.et al (2006). Conjunctive representation of position, direction, and velocity in entorhinal cortex.**Science** 312758–762. 10.1126/science.1125572
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/16675704)
	- [CrossRef](https://doi.org/10.1126/science.1125572)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=F..%2BSargolini&author=M..%2BFyhn&author=T..%2BHafting&author=B.%2BL..%2BMcNaughton&author=M.%2BP..%2BWitter&author=M.%2BB..%2BMoser&publication_year=2006&title=Conjunctive%2Brepresentation%2Bof%2Bposition%2C%2Bdirection%2C%2Band%2Bvelocity%2Bin%2Bentorhinal%2Bcortex.&journal=Science&volume=312&pages=758-762)
	- [View reference in article](#B78a)
- 79
	Schmidt-HieberC.ToleikyteG.AitchisonL.RothA.ClarkB. A.BrancoT.et al (2017). Active dendritic integration as a mechanism for robust and precise grid cell firing.**Nat. Neurosci.**201114–1121. 10.1038/nn.4582
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/28628104)
	- [CrossRef](https://doi.org/10.1038/nn.4582)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=C..%2BSchmidt-Hieber&author=G..%2BToleikyte&author=L..%2BAitchison&author=A..%2BRoth&author=B.%2BA..%2BClark&author=T..%2BBranco&publication_year=2017&title=Active%2Bdendritic%2Bintegration%2Bas%2Ba%2Bmechanism%2Bfor%2Brobust%2Band%2Bprecise%2Bgrid%2Bcell%2Bfiring.&journal=Nat.+Neurosci.&volume=20&pages=1114-1121)
	- [View reference in article](#B79a)
- 80
	SchroederC. E.FoxeJ. (2005). Multisensory contributions to low-level, “unisensory” processing.**Curr. Opin. Neurobiol.**15454–458. 10.1016/j.conb.2005.06.008
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/16019202)
	- [CrossRef](https://doi.org/10.1016/j.conb.2005.06.008)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=C.%2BE..%2BSchroeder&author=J..%2BFoxe&publication_year=2005&title=Multisensory%2Bcontributions%2Bto%2Blow-level%2C%2B%E2%80%9Cunisensory%E2%80%9D%2Bprocessing.&journal=Curr.+Opin.+Neurobiol.&volume=15&pages=454-458)
	- [View reference in article](#B80a)
- 81
	ShermanS.GuilleryR. (2013). **Thalamocortical Processing: Understanding the Messages that Link the Cortex to the World.**Cambridge, MA: MIT Press.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=S..%2BSherman&author=R..%2BGuillery&publication_year=2013&journal=Thalamocortical+Processing%3A+Understanding+the+Messages+that+Link+the+Cortex+to+the+World.)
	- [View reference in article](#B81a)
- 82
	ShermanS. M.GuilleryR. W. (2011). Distinct functions for direct and transthalamic corticocortical connections.**J. Neurophysiol.**1061068–1077. 10.1152/jn.00429.2011
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/21676936)
	- [CrossRef](https://doi.org/10.1152/jn.00429.2011)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=S.%2BM..%2BSherman&author=R.%2BW..%2BGuillery&publication_year=2011&title=Distinct%2Bfunctions%2Bfor%2Bdirect%2Band%2Btransthalamic%2Bcorticocortical%2Bconnections.&journal=J.+Neurophysiol.&volume=106&pages=1068-1077)
	- [View reference in article](#B82a)
- 83
	SreenivasanS.FieteI. (2011). Grid cells generate an analog error-correcting code for singularly precise neural computation.**Nat. Neurosci.**141330–1337. 10.1038/nn.2901
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/21909090)
	- [CrossRef](https://doi.org/10.1038/nn.2901)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=S..%2BSreenivasan&author=I..%2BFiete&publication_year=2011&title=Grid%2Bcells%2Bgenerate%2Ban%2Banalog%2Berror-correcting%2Bcode%2Bfor%2Bsingularly%2Bprecise%2Bneural%2Bcomputation.&journal=Nat.+Neurosci.&volume=14&pages=1330-1337)
	- [View reference in article](#B83a)
- 84
	StensolaH.StensolaT.SolstadT.FrølandK.MoserM. B.MoserE. I. (2012). The entorhinal grid map is discretized.**Nature** 49272–78. 10.1038/nature11649
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/23222610)
	- [CrossRef](https://doi.org/10.1038/nature11649)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=H..%2BStensola&author=T..%2BStensola&author=T..%2BSolstad&author=K..%2BFr%C3%B8land&author=M.%2BB..%2BMoser&author=E.%2BI..%2BMoser&publication_year=2012&title=The%2Bentorhinal%2Bgrid%2Bmap%2Bis%2Bdiscretized.&journal=Nature&volume=492&pages=72-78)
	- [View reference in article](#B84a)
- 85
	SuterB. A.ShepherdG. M. G. (2015). Reciprocal interareal connections to corticospinal neurons in mouse M1 and S2.**J. Neurosci.**352959–2974. 10.1523/JNEUROSCI.4287-14.2015
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/25698734)
	- [CrossRef](https://doi.org/10.1523/JNEUROSCI.4287-14.2015)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=B.%2BA..%2BSuter&author=G.%2BM.%2BG..%2BShepherd&publication_year=2015&title=Reciprocal%2Binterareal%2Bconnections%2Bto%2Bcorticospinal%2Bneurons%2Bin%2Bmouse%2BM1%2Band%2BS2.&journal=J.+Neurosci.&volume=35&pages=2959-2974)
	- [View reference in article](#B85a)
- 86
	TaubeJ. S.MullerR. U.RanckJ. B. (1990). Head-direction cells recorded from the postsubiculum in freely moving rats. I. Description and quantitative analysis.**J. Neurosci.**10420–435. 10.1212/01.wnl.0000299117.48935.2e
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/18250290)
	- [CrossRef](https://doi.org/10.1212/01.wnl.0000299117.48935.2e)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J.%2BS..%2BTaube&author=R.%2BU..%2BMuller&author=J.%2BB..%2BRanck&publication_year=1990&title=Head-direction%2Bcells%2Brecorded%2Bfrom%2Bthe%2Bpostsubiculum%2Bin%2Bfreely%2Bmoving%2Brats.%2BI.%2BDescription%2Band%2Bquantitative%2Banalysis.&journal=J.+Neurosci.&volume=10&pages=420-435)
	- [View reference in article](#B86a)
- 87
	ThomsonA. M. (2010). Neocortical layer 6, a review.**Front. Neuroanat.**4:13. 10.3389/fnana.2010.00013
	- [CrossRef](https://doi.org/10.3389/fnana.2010.00013)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A.%2BM..%2BThomson&publication_year=2010&title=Neocortical%2Blayer%2B6%2C%2Ba%2Breview.&journal=Front.+Neuroanat.&volume=4)
	- [View reference in article](#B87a)
- 88
	UngerleiderL. G.HaxbyJ. V. (1994). “What” and “where” in the human brain.**Curr. Opin. Neurobiol.**4157–165. 10.1016/0959-4388(94)90066-3
	- [CrossRef](https://doi.org/10.1016/0959-4388\(94\)90066-3)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=L.%2BG..%2BUngerleider&author=J.%2BV..%2BHaxby&publication_year=1994&title=%E2%80%9CWhat%E2%80%9D%2Band%2B%E2%80%9Cwhere%E2%80%9D%2Bin%2Bthe%2Bhuman%2Bbrain.&journal=Curr.+Opin.+Neurobiol.&volume=4&pages=157-165)
	- [View reference in article](#B88a)
- 89
	WinterS. S.ClarkB. J.TaubeJ. S. (2015). Disruption of the head direction cell network impairs the parahippocampal grid cell signal.**Science** 347870–874. 10.1126/science.1259591
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/25700518)
	- [CrossRef](https://doi.org/10.1126/science.1259591)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=S.%2BS..%2BWinter&author=B.%2BJ..%2BClark&author=J.%2BS..%2BTaube&publication_year=2015&title=Disruption%2Bof%2Bthe%2Bhead%2Bdirection%2Bcell%2Bnetwork%2Bimpairs%2Bthe%2Bparahippocampal%2Bgrid%2Bcell%2Bsignal.&journal=Science&volume=347&pages=870-874)
	- [View reference in article](#B89a)
- 90
	ZhangS.-J.YeJ.MiaoC.TsaoA.CerniauskasI.LedergerberD.et al (2013). Optogenetic dissection of entorhinal-hippocampal functional connectivity.**Science** 340:1232627. 10.1126/science.1232627
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/23559255)
	- [CrossRef](https://doi.org/10.1126/science.1232627)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=S.-J..%2BZhang&author=J..%2BYe&author=C..%2BMiao&author=A..%2BTsao&author=I..%2BCerniauskas&author=D..%2BLedergerber&publication_year=2013&title=Optogenetic%2Bdissection%2Bof%2Bentorhinal-hippocampal%2Bfunctional%2Bconnectivity.&journal=Science&volume=340)
	- [View reference in article](#B90a)

## Summary

Keywords

neocortex, grid cell, neocortical theory, hierarchy, object recognition, cortical column

Citation

Hawkins J, Lewis M, Klukas M, Purdy S and Ahmad S (2019) A Framework for Intelligence and Cortical Function Based on Grid Cells in the Neocortex. *Front. Neural Circuits* 12:121. doi: [10.3389/fncir.2018.00121](http://dx.doi.org/10.3389/fncir.2018.00121)

Received

20 October 2018

Accepted

24 December 2018

Published

11 January 2019

Volume

12 - 2018

Edited by

Robert C. Froemke, New York University, United States

Reviewed by

Michael E. Hasselmo, Boston University, United States; Srikanth Ramaswamy, École Polytechnique Fédérale de Lausanne, Switzerland

Updates

Copyright

[^1]: FIGURE 1 

![](https://www.frontiersin.org/api/ipx/w=340&f=webp/https://www.frontiersin.org/files/Articles/431889/xml-images/fncir-12-00121-g001.webp)

Due to tiling, a single grid cell module cannot represent a unique location. To form a representation of a unique location requires looking at the active cells in multiple grid cell modules where each grid cell module differs in its tile spacing and/or orientation relative to the environment, Figures. For example, if a single grid cell module can represent twenty different locations before repeating, then 10 grid cell modules can represent approximately 20 <sup>10</sup> different locations before repeating (Fiete et al., 2008). This method of representing location has several desirable properties:

- **(1)**
	Large representational capacity:

The number of locations that can be represented by a set of grid cell modules is large as it scales exponentially with the number of modules.

- **(2)**
	Path integration works from any location:

No matter what location the network starts with, path integration will work. This is a form of generalization. The path integration properties have to be learned once for each grid cell module, but then apply to all locations, even those the animal has never been in before.

- **(3)**
	Locations are unique to each environment:

Every learned environment is associated with a set of unique locations. Experimental recordings suggest that upon entering a learned environment, entorhinal grid cell modules “anchor” differently (Rowland and Moser, 2014; Marozzi et al., 2015). (The term “anchor” refers to selecting which grid cells in each module should be active at the current location.) This suggests that the current location and all the locations that the animal can move to in that environment will, with high certainty, have representations that are unique to that environment (Fiete et al., 2008; Sreenivasan and Fiete, 2011).

Combining these properties, we can now broadly describe how grid cells represent an environment such as a room, Figure. An environment consists of a set of location representations that are related to each other via path integration (i.e., the animal can move between these location representations). Each location representation in the set is unique to that environment and will not appear in any other environment. An environment consists of all the locations that the animal can move among, including locations that have not been visited, but could be visited. Associated with some of the location representations are observable landmarks.

[^2]: FIGURE 3 

![](https://www.frontiersin.org/api/ipx/w=340&f=webp/https://www.frontiersin.org/files/Articles/431889/xml-images/fncir-12-00121-g003.webp)

We have proposed that each object is associated with a set of locations which are unique to the object and comprise a space around the object. If a finger is touching the coffee cup with the logo, then the cortical grid cells representing the location of the finger can at one moment represent the location of the finger in the space of the coffee cup and at another moment, after re-anchoring, represent the location of the finger in the space of the logo. If the logo is attached to the cup, then there is a fixed, one-to-one, relationship between any point in the space of the logo and the equivalent point in the space of the cup, Figure. The task of representing the logo on the cup can be achieved by creating a “displacement” vector that converts any point in cup space to the equivalent point in logo space.

Determining the displacement between two objects is similar to a previously-studied navigation problem, specifically, how an animal knows how to get from point **a** to point **b** within an environment, Figure. Mechanisms that solve the navigation problem (determining the displacement between two points in the same space) can also solve the object composition problem (determining the displacement between two points in two different spaces).

### Displacement Cells

Several solutions have been proposed for solving the point-to-point navigation problem using grid cells. One class of solutions detects the difference between two sets of active grid cells across multiple grid cell modules (Bush et al., 2015) and another uses linear look-ahead probes using grid cells for planning and computing trajectories (Erdem and Hasselmo, 2014). We suggest an alternate but related solution. Our proposal also relies on detecting differences between two sets of active grid cells, however, we propose this is done on a grid cell module by grid cell module basis. We refer to these cells as “displacement cells” (see for a more thorough description). Displacement cells are similar to grid cells in that they can’t on their own represent a unique displacement. (In the example, a displacement cell that represents a displacement of “two to the right and one up,” would also be active for “five over and four up.”) However, the cell activity in multiple displacement cell modules represents a unique displacement in much the same way as the cell activity in multiple grid cell modules represents a unique location, Figure. Hence, a single displacement vector can represent the logo on the coffee cup at a specific relative position. Note, a displacement vector not only represents the relative position of two objects, it also is unique to the two objects. Complex objects can be represented by a set of displacement vectors which define the components of an object and how they are arranged relative to each other. This is a highly efficient means of representing and storing the structure of objects.

This method of representing objects allows for hierarchical composition. For example, the logo on the cup is also composed of sub-objects, such as letters and a graphic. A displacement vector placing the logo on the cup implicitly carries with it all the sub-objects of the logo. The method also allows for recursive structures. For example, the logo could contain a picture of a coffee cup with a logo. Hierarchical and recursive composition are fundamental elements of not only physical objects but language, mathematics, and other manifestations of intelligent thought. The key idea is that the identity and relative position of two previously-learned objects, even complex objects, can be represented efficiently by a single displacement vector.

### Grid Cells and Displacement Cells Perform Complementary Operations

Grid cells and displacement cells perform complementary operations. Grid cells determine a new location based on a current location and a displacement vector (i.e., movement). Displacement cells determine what displacement is required to reach a new location from a current location.

Grid cells: (Location1+Displacement=>Location2) $Grid cells : (Location1+Displacement=>Location2)$

Displacement cells: (Location2−Location1=>Displacement) $Displacement cells : (Location2−Location1=>Displacement)$

If the two locations are in the same space, then grid cells and displacement cells are useful for navigation. In this case, grid cells predict a new location based on a starting location and a given movement. Displacement cells would represent what movement is needed to get from Location1 to Location2.

If the two locations are in different spaces (that is the same physical location relative to two different objects) then grid cells and displacement cells are useful for representing the relative position of two objects. Grid cells convert a location in one object space to the equivalent location in a second object space based on a given displacement. In this case, displacement cells represent the relative position of two objects.

We propose that grid cells and displacement cells exist in all cortical columns. They perform two fundamental and complementary operations in a location-based framework of cortical processing. By alternating between representations of locations in a single object space and representations of locations in two different object spaces, the neocortex can use grid cells and displacement cells to learn both the structure of objects and generate behaviors to manipulate those objects.

The existence of grid cells in the entorhinal cortex is well-documented. We propose they also exist in all regions of the neocortex. The existence of displacement cells is a prediction introduced in this paper. We propose displacement cells are also present in all regions of the neocortex. Given their complementary role to grid cells, it is possible that displacement cells are also present in the hippocampal complex.

### Object Behaviors

Objects may exhibit behaviors. For example, consider the stapler in Figure. The top of the stapler can be lifted and rotated. This action changes the stapler’s morphology but not its identity. We don’t perceive the open and closed stapler as two different objects even though the overall shape has changed. The movement of a part of an object relative to other parts of an object is a “behavior” of the object. The behaviors of an object can be learned, and therefore they must be represented in the neural tissue of cortical columns. We can represent behaviors in a location-based framework, again using displacement vectors. The top half and bottom half of the stapler are two components of the stapler. The relative position of the top and bottom is represented by a displacement vector in the same way as the relative position of the logo and the coffee cup. However, unlike the logo on the coffee cup, the two halves of the stapler can move relative to each other. As the stapler top rotates upward, the displacement of the stapler top to bottom changes. Thus, the rotation of the stapler top is represented by a sequence of displacement vectors. By learning this sequence, the system will have learned this behavior of the object.

[^3]: FIGURE 4 

![](https://www.frontiersin.org/api/ipx/w=340&f=webp/https://www.frontiersin.org/files/Articles/431889/xml-images/fncir-12-00121-g004.webp)

Opening and closing the stapler are different behaviors yet they are composed of the same displacement elements, just in reverse order. These are sometimes referred to as “high-order” sequences. Previously we described a neural mechanism for learning high-order sequences in a layer of neurons (Hawkins and Ahmad, 2016). This mechanism, if applied to the displacement modules, would allow the learning, inference, and recall of complex behavioral sequences of objects.

### “What” and “Where” Processing

Sensory processing occurs in two parallel sets of neocortical regions, often referred to as “what” and “where” pathways. In vision, damage to the “what,” or ventral, pathway is associated with the loss of ability to visually recognize objects whereas damage to the “where,” or dorsal, pathway is associated with the loss of ability to reach for an object even if it has been visually identified. Equivalent “what” and “where” pathways have been observed in other sensory modalities, thus it appears to be general principle of cortical organization (Goodale and Milner, 1992; Ungerleider and Haxby, 1994; Rauschecker, 2015). “What” and “where” cortical regions have similar anatomy and therefore we can assume they operate on similar principles.

A location-based framework for cortical function is applicable to both “what” and “where” processing. Briefly, we propose that the primary difference between “what” regions and “where” regions is that in “what” regions cortical grid cells represent locations that are allocentric, in the location space of objects, and in “where” regions cortical grid cells represent locations that are egocentric, in the location space of the body. Figure shows how a displacement vector representing movement could be generated in “what” and “where” regions. The basic operation, common to all, is that a region first attends to one location and then to a second location. The displacement cells will determine the movement vector needed to move from the first location to the second location. In a “what” region, Figure, the two locations are in the space of an object, therefore, the displacement vector will represent the movement needed to move the finger from the first location on the object to the second location on the object. In this example, the “what” region needs to know where the finger is relative to the cup, but it does not need to know where the cup or finger is relative to the body. In a “where” region, Figure, the two locations are in the space of the body, therefore, the displacement vector will represent how to move from one egocentric location to a second egocentric location. The “where” region can perform this calculation not knowing what object may or may not be at the second location. A more detailed discussion of processing in “where” regions is beyond the scope of this paper. We only want to point out that it is possible to understand both “what” and “where” processing using similar mechanisms by assuming different location spaces.

[^4]: FIGURE 5 

![](https://www.frontiersin.org/api/ipx/w=340&f=webp/https://www.frontiersin.org/files/Articles/431889/xml-images/fncir-12-00121-g005.webp)

### Rethinking Hierarchy, the Thousand Brains Theory of Intelligence

Regions of the neocortex are organized in a hierarchy (Felleman and Van Essen, 1991; Riesenhuber and Poggio, 1999; Markov et al., 2014). It is commonly believed that when sensory input enters the neocortex the first region detects simple features. The output of this region is passed to a second region that combines simple features into more complex features. This process is repeated until, several levels up in the hierarchy, cells respond to complete objects (Figure ). This view of the neocortex as a hierarchy of feature extractors also underlies many artificial neural networks (LeCun et al., 2015).

[^5]: FIGURE 6 

![](https://www.frontiersin.org/api/ipx/w=340&f=webp/https://www.frontiersin.org/files/Articles/431889/xml-images/fncir-12-00121-g006.webp)

We propose that cortical columns are more powerful than currently believed. Every cortical column learns models of complete objects. They achieve this by combining input with a grid cell-derived location, and then integrating over movements (see Hawkins et al., 2017; Lewis et al., 2018 for details). This suggests a modified interpretation of the cortical hierarchy, where complete models of objects are learned at every hierarchical level, and every region contains multiple models of objects (Figure ).

Feedforward and feedback projections between regions typically connect to multiple levels of the hierarchy (only one level of connection is shown in Figure ). For example, the retina projects to thalamic relay cells in LGN, which then project to cortical regions V1, V2, and V4, not just V1. This form of “level skipping” is the rule, not the exception. Therefore, V1 and V2 are both, to some extent, operating on retinal input. The connections from LGN to V2 are more divergent suggesting that V2 is learning models at a different spatial scale than V1. We predict that the spatial scale of cortical grid cells in V2 will similarly be larger than those in V1. The level of convergence of input to a region, paired with the spatial scale of its grid cells, determines the range of object sizes the region can learn. For example, imagine recognizing printed letters of the alphabet. Letters at the smallest discernable size will be recognized in V1 and only V1. The direct input to V2 will lack the feature resolution needed. However, larger printed letters would be recognized in both V1 and V2, and even larger letters may be too large for V1 but recognizable in V2. Hierarchical processing still occurs. All we are proposing is that when a region such as V1 passes information to another region such as V2, it is not passing representations of unclassified features but, if it can, it passes representations of complete objects. This would be difficult to observe empirically if objects are represented by population codes as proposed in Hawkins et al. (2017). Individual neurons would participate in many different object representations and if observed in isolation will appear to represent sensory features, not objects. The number of objects that a cortical column can learn is large but limited (Hawkins et al., 2017). Not every column can learn every object. Analysis of system capacity requires a more thorough understanding of hierarchical flow and is beyond the scope of this paper.

There are many cortical-cortical projections that are inconsistent with pure hierarchical processing (Figure, green arrows). For example, there are long range projections between regions in the left and right hemispheres (Clarke and Zaidel, 1994), and there are numerous connections between regions in different sensory modalities, even at the lowest levels of the hierarchy (Schroeder and Foxe, 2005; Driver and Noesselt, 2008; Suter and Shepherd, 2015). These connections may not be hierarchical as their axons terminate on cells located outside of cellular layers associated with feedforward or feedback input. It has been estimated that 40% of all possible region-to-region connections actually exist which is much larger than a pure hierarchy would suggest (Felleman and Van Essen, 1991). What is the purpose of these long-range non-hierarchical connections? In Hawkins et al. (2017) we proposed that cell activity in some layers (e.g., L4 and L6) of a column changes with each new sensation, whereas, cell activity in other layers (e.g., L2/3), representing the observed “object,” are stable over changing input. We showed how long-range associative connections in the “object” layer allow multiple columns to vote on what object they are currently observing. For example, if we see and touch a coffee cup there will be many columns simultaneously observing different parts of the cup. These columns will be in multiple levels of both the visual and somatosensory hierarchies. Every one of these columns has a unique sensory input and a unique location, and therefore, long-range connections between the cells representing location and input do not make sense. However, if the columns are observing the same object, then connections between cells in the object layer allow the columns to rapidly settle on the correct object. Thus, non-hierarchical connections between any two regions, even primary and secondary sensory regions in different sensory modalities, make sense if the two regions often observe the same object at the same time (see Hawkins et al., 2017 for details).

One of the classic questions about perception is how does the neocortex fuse different sensory inputs into a unified model of a perceived object. We propose that the neocortex implements a decentralized model of sensor fusion. For example, there is no single model of a coffee cup that includes what a cup feels like and looks like. Instead there are 100s of models of a cup. Each model is based on a unique subset of sensory input within different sensory modalities. There will be multiple models based on visual input and multiple models based on somatosensory input. Each model can infer the cup on its own by observing input over movements of its associated sensors. However, long-range non-hierarchical connections allow the models to rapidly reach a consensus of the identity of the underlying object, often in a single sensation.

Just because each region learns complete models of objects does not preclude hierarchical flow. The main idea is that the neocortex has 100s, likely 1000s, of models of each object in the world. The integration of observed features does not just occur at the top of the hierarchy, it occurs in every column at all levels of the hierarchy. We call this “The Thousand Brains Theory of Intelligence.”

[^6]: FIGURE 7 

![](https://www.frontiersin.org/api/ipx/w=340&f=webp/https://www.frontiersin.org/files/Articles/431889/xml-images/fncir-12-00121-g007.webp)

One piece of evidence suggesting cortical grid cells are in L6 is the unusual connectivity between L4 and L6. L4 is the primary input layer. However, feed forward input forms less than 10% of the synapses on L4 cells (Ahmed et al., 1994, 1997; Sherman and Guillery, 2013), whereas approximately 45% of the synapses on L4 cells come from L6a cortical-cortical neurons (Ahmed et al., 1994; Binzegger et al., 2004). Similarly, L4 cells make large numbers of synapses onto those same L6 cells (McGuire et al., 1984; Binzegger et al., 2004; Kim et al., 2014). Also, the connections between L6 and L4 are relatively narrow in spread (Binzegger et al., 2004). The narrow connectivity between L6 and L4 is reminiscent of the topologically-aligned bidirectional connectivity between grid cells in MEC and place cells in hippocampus (Rowland et al., 2013; Zhang et al., 2013). We previously showed how the reciprocal connections between L6 and L4 can learn the structure of objects by movement of sensors if L6 represents a location in the space of the object (Lewis et al., 2018). For a column to learn the structure of objects in this fashion requires bidirectional connections between cells receiving sensory input and cells representing location. L6a is the only known set of cells that meet this requirement. Also, grid cells use motor input to update their representations for path integration. Experiments show significant motor projections to L6 (Nelson et al., 2013; Leinweber et al., 2017). The current experimental evidence for the presence of grid cells in the neocortex is unfortunately mute on what cortical layers contain grid cells. It should be possible to experimentally determine this in the near future. Our prediction is they will be in L6.

The main evidence for displacement cells being in L5 is again connectivity. A subset of L5 cells (known as “L5 thick-tufted cells”) that, as far as we know exists in all cortical regions, projects sub-cortically to brain regions involved with motor behavior. (For example, L5 cells in the visual cortex project to the superior colliculus which controls eye movements.) These L5 cells are the motor output cells of the neocortex. However, the same L5 cells send a branch of their axon to thalamic relay nuclei, which then project to hierarchically higher cortical regions (Douglas and Martin, 2004; Guillery and Sherman, 2011; Sherman and Guillery, 2011). It is difficult to understand how the same L5 cells can be both the motor output and the feedforward input to other regions. One interpretation put forth by Guillery and Sherman is that L5 cells represent a motor command and that the feedforward L5 projection can be interpreted as an efference copy of the motor command (Guillery and Sherman, 2002, 2011).

We offer a possible alternate interpretation. The L5 cells in question are displacement cells and they alternately represent movements (sent sub-cortically) and then represent compositional objects (sent to higher regions via thalamic relay cells). As described above, displacement cells will represent a movement vector when comparing two locations in the same space and will represent composite objects when comparing two locations in two different spaces. These two rapidly-changing representations could be disambiguated at their destination either by phase of an oscillatory cycle or by physiological firing patterns (Burgess et al., 2007; Hasselmo, 2008; Hasselmo and Brandon, 2012). Although we are far from having a complete understanding of what the different cellular layers do and how they work together, a location-based framework offers the opportunity of looking anew at the vast body of literature on cortical anatomy and physiology and making progress on this problem.

### Location-Based Framework for High-Level Thought and Intelligence

We have described our location-based framework using examples from sensory inference. Given that the anatomy in all cortical regions is remarkably similar, it is highly likely that everything the neocortex does, including language and other forms of high-level thought, will be built upon the same location-based framework. In support of this idea, the current empirical evidence that grid cells exist in the neocortex was collected from humans performing what might be called “cognitive tasks,” and it was detected in cortical regions that are far from direct sensory input (Doeller et al., 2010; Jacobs et al., 2013; Constantinescu et al., 2016).

The location-based framework can be applied to physical structures, such as a cup, and to abstract concepts, such as mathematics and language. A cortical column is fundamentally a system for learning predictive models. The models are learned from inputs and movements that lead to changes in the input. Successful models are ones that can predict the next input given the current state and an anticipated movement. However, the “inputs” and “movements” of a cortical column do not have to correspond to physical entities. The “input” to a column can originate from the retina or it can originate from other regions of the neocortex that have already recognized a visual object such as a word or a mathematical expression. A “movement” can represent the movement of the eyes or it can represent an abstract movement, such as a verb or a mathematical operator.

Success in learning a predictive model requires discovering the correct dimensionality of the space of the object, learning how movements update locations in that space, and associating input features with specific locations in the space of the object. These attributes apply to both sensory perception and high-level thought. Imagine a column trying to learn a model of a cup using visual input from the retina and movement input from a finger. This would fail, as the location spaced traversed by the finger would not map onto the feature space of the object as evidenced by the changing inputs from the eyes. Similarly, when trying to understand a mathematical problem you might fail when using one operator to manipulate an equation but succeed by switching to a different operator.

Grid cells in the neocortex suggests that all knowledge is learned and stored in the context of locations and location spaces and that “thinking” is movement through those location spaces. We have a long way to go before we understand the details of how the neocortex performs cognitive functions, however, we believe that the location-based framework will not only be at the core of the solutions to these problems, but will suggest solutions.