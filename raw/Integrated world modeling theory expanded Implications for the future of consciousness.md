---
title: "Integrated world modeling theory expanded: Implications for the future of consciousness"
source: "https://www.frontiersin.org/journals/computational-neuroscience/articles/10.3389/fncom.2022.642397/full"
author:
  - "[[Adam Safron]]"
published: 2022-11-24
created: 2026-06-23
description: "Integrated World Modeling Theory (IWMT) is a synthetic theory of consciousness that uses the Free Energy Principle and Active Inference (FEP-AI) framework to..."
tags:
  - "clippings"
---
- [
	Adam Safron <sup>1,2,3</sup> <sup>*</sup>
	](https://loop.frontiersin.org/people/72565)

- 1\. Department of Psychiatry and Behavioral Sciences, Johns Hopkins University School of Medicine, Center for Psychedelic and Consciousness Research, Baltimore, MD, United States
- 2\. Cognitive Science Program, Indiana University, Bloomington, IN, United States
- 3\. Institute for Advanced Consciousness Studies (IACS), Santa Monica, CA, United States

Article metrics

[View details](#metrics)

27

Citations

17,8k

Views

2,9k

Downloads

## Abstract

Integrated world modeling theory (IWMT) is a synthetic theory of consciousness that uses the free energy principle and active inference (FEP-AI) framework to combine insights from integrated information theory (IIT) and global neuronal workspace theory (GNWT). Here, I first review philosophical principles and neural systems contributing to IWMT’s integrative perspective. I then go on to describe predictive processing models of brains and their connections to machine learning architectures, with particular emphasis on autoencoders (perceptual and active inference), turbo-codes (establishment of shared latent spaces for multi-modal integration and inferential synergy), and graph neural networks (spatial and somatic modeling and control). Future directions for IIT and GNWT are considered by exploring ways in which modules and workspaces may be evaluated as both complexes of integrated information and arenas for iterated Bayesian model selection. Based on these considerations, I suggest novel ways in which integrated information might be estimated using concepts from probabilistic graphical models, flow networks, and game theory. Mechanistic and computational principles are also considered with respect to the ongoing debate between IIT and GNWT regarding the physical substrates of different kinds of conscious and unconscious phenomena. I further explore how these ideas might relate to the “Bayesian blur problem,” or how it is that a seemingly discrete experience can be generated from probabilistic modeling, with some consideration of analogies from quantum mechanics as potentially revealing different varieties of inferential dynamics. I go on to describe potential means of addressing critiques of causal structure theories based on network unfolding, and the seeming absurdity of conscious expander graphs (without cybernetic symbol grounding). Finally, I discuss future directions for work centered on attentional selection and the evolutionary origins of consciousness as facilitated “unlimited associative learning.” While not quite solving the Hard problem, this article expands on IWMT as a unifying model of consciousness and the potential future evolution of minds.

## Facing up to the enduring problems of consciousness with integrated world modeling theory

The Hard problem of consciousness asks, how can it be that there is “something that it is like” to be a physical system (; )? The “meta-problem” of consciousness refers to the (potentially more tractable) challenge of addressing why it is that opinions and intuitions vary greatly with respect to what it would take to meaningfully answer this question (). The “real problem” of consciousness refers to the further challenge of addressing why it is that different biophysical and computational phenomena correspond to different qualities of experience ().

Integrated world modeling theory (IWMT) attempts to address these unsolved problems about the nature(s) of consciousness by combining Integrated Information Theory (IIT) and Global Neuronal Workspace Theory (GNWT) with the Free Energy Principle and Active Inference framework (FEP-AI). IIT speaks to the Hard problem by beginning from phenomenological axioms, and then goes on to postulate mechanisms that could realize such properties, ultimately coming to the conclusion that consciousness is “what physics feels like from the inside” (). GNWT speaks to the real problem by focusing on the properties of computational systems that could realize the functions of consciousness as a means of globally integrating and broadcasting information from mental systems. FEP-AI has been used to address all these problems in a variety of ways, with IWMT representing one such attempt. For a detailed exploration of potential inter-relations between FEP-AI, IIT, and GNWT, please see the original publication of IWMT; for a high-level summary, please see.

In attempting to explain how there could be “something that it *is like* ” to be a physical system, it is worth noting that this question is often phrased as “something that it *feels like.*” The nature of embodied perception and affective states lie at the heart of what it would take to provide a satisfying solution to the Hard problem. Further, the Hard problem could be viewed as containing an implicit question: “something that it *feels like, for whom*?” While some may want to separate consciousness from sensations or selfhood (), it may also be the case that addressing the Hard problem requires understanding the nature of selves, and as has argued, “free will.” Along these lines, IWMT specifically places somatic experiences and agentic selfhood at the core of consciousness, and consciousness at the core of agency ().

Integrated world modeling theory specifically argues that integrated information and global workspaces only entail consciousness when applied to systems capable of functioning as Bayesian belief networks and cybernetic controllers for embodied agents (;, ). That is, IWMT agrees with IIT and GNWT with respect to the integration and widespread availability of information as necessary preconditions for consciousness, but disagrees that these are sufficient enabling conditions for subjective experience. \[Note: GNWT’s more specific claim is that workspaces help to select particular interpretations of events, which is highly compatible with IWMT, especially with more recent Bayesian interpretations of workspace dynamics (;; ).\] Rather, IWMT argues that *phenomenal consciousness is what integrated world-modeling is like, when generative processes are capable of jointly integrating information into models with coherence with respect to space (i.e., relative degrees of locality), time (i.e., relative changes within space), and cause (i.e., regularities with respect to these changes, potentially requiring some basic form of self/other-modeling) for systems and their relationships with their environments*. These coherence-making properties are stipulated to be required for situating modeled entities relative to each other with specific features, without which there would be no means of generating an experienceable world. Consciousness-entailing nervous systems (functioning as generative models) are stipulated to provide these sources of coherence via particular organizational features, as well as by having actual semantic content by virtue of evolving through interactions with a coherently structured (and so semi-predictable) world. IWMT further introduces a mechanism for generating complexes of integrated information and global workspaces via *self-organizing harmonic modes (SOHMs)*, wherein synchrony both emerges from and facilitates “communication-through-coherence” (;;; ). SOHMs are proposed to both require and allow for high degrees of meaningful integrated information, where meaning is understood as differences that make a difference to the ability of systems to pursue their goals, including the goal of modeling the world for the sake of prediction and control.

Integrated world modeling theory focuses on the neural and computational bases of ‘basic’ phenomenal consciousness, but also has relevance for theories focused on “conscious access” and “higher order” knowledge, where some of these implications have been explored elsewhere with respect to goal-oriented behavior and cognition/affect (). However, while experience itself is proposed to be a unitary (and discrete) phenomenon, more abstract capacities for various forms of conscious access and self-awareness are considered to be more multifarious in their manifestations. These distinctions will be important for subsequent discussions in which we will consider the physical and computational substrates of consciousness adduced by various theories, where IWMT claims that multiple points of view may be valid with respect to issues as to whether experience is primarily realized by the frontal lobes or a “posterior hot zone” (). Strangely, IWMT suggests that both these perspectives are likely accurate, but with respect to different explananda. That is, IWMT agrees with IIT that posterior cortices (and perhaps specific subnetworks thereof) provide necessary and sufficient conditions for realizing a consciousness-entailing generative (self-world) model over the sensorium of an embodied-embedded agent. Yet IWMT also agrees with GNWT that the frontal lobes are likely required for accessing such experiences in terms of being able to manipulate, reflect, and report on their contents (and contexts). However, IWMT also suggests that notions of conscious access may be insufficiently precise for progressive research and theory construction, in that by the time we are considering the processes contributing to such high-level functions, we may be forced to also consider ways in which cognition extends beyond brains and into bodies and extended embodiments/phenotypes, so cautioning against overly simple mappings between modeling and mechanisms. In what follows, we will explore the nature of these claims in greater depth than in the original publication, as well as additional considerations and future directions for understanding the nature of experience in biological and potentially artificial systems.

## Preconditions for experience: Space, time, cause, self, agency

By emphasizing the properties by which coherent world-modeling is made possible, the philosophical foundations of IWMT can be most strongly tied to the thought of Kant and Helmholtz. The core claims of the theory are particularly informed by Kant’s stipulation of synthetic *a priori* categories (i.e., complex concepts possessed in advance of experience) as preconditions for judgment. IWMT further argues that these preconditions for coherent knowledge are also preconditions for coherent experience, and focuses on the categories of space (i.e., relative localization of entities), time (i.e., relative transformations of entities in space), and cause (i.e., regularity with respect to transformations). Without spatial, temporal, and causal coherence, there can be no means of situating entities relative to each other with specific properties, and so there would be no means of generating an experienceable world. This position is consistent with both the axioms of IIT (e.g., composition), the kind of informational synergy emphasized by GNWT, and also the constructive epistemology of FEP-AI (). IWMT goes further in emphasizing the importance of selfhood, consistent with Kant’s notion of the transcendental unity of apperception in which spatiotemporal and causal information are bound together into a unified manifold via a unified experiencing subject (). While the stipulation of these properties of experience may help to address the question of why there may be “something that it feels like” to be some kinds of systems, a key question remains unanswered: to what degrees must these forms of coherence be present in which ways to enable different forms of consciousness? While this issue will not be definitively resolved here, we will consider neurophysiological and informational principles that may be illuminating.

Helmholtz extended Kant’s project in a more empirical direction, arguing that the experience of selfhood and freedom in willing are preconditions for deriving conceptions of space, time, and cause (). According to Helmholtz, a self/world distinction and sense of agency are both required for making sense of sensory observations, including with respect to constructing these categories of experience. This more empirically focused perspective is contrasted with Liebnizian () notions of “pre-established harmony” as an explanation for how minds come to be equipped with precisely the intuitions required for making sense of the world. In this way, Helmholtz rejected the *a priori* status of Kantian categories as part of his general project of deflating mysticism, which elsewhere involved critiquing the vitalist posit of a supernatural force animating living things (i.e., *élan vital*). IWMT was developed in the same spirit as Helmholtz’s naturalization of mind and nature, although with somewhat greater sympathies to notions of pre-established harmonies, since evolution by natural selection represents a means by which mental systems could come to non-mystically resonate with essential properties of the world (;; ).

Helmholtz’s argument for selfhood and agency as foundational cognitive capacities is fully compatible with IWMT and FEP-AI. The necessity of autonomy for coherent modeling is emphasized in FEP-AI, in which expected free energy (i.e., precision-weighted cumulative prediction errors with respect to preferred states) is minimized via action/policy selection over predictive models for future (counterfactual) goal realization (; ). In these ways, IWMT supports both Kantian and Helmholtzian views on the preconditions and origins of mind. IWMT also agrees with Kant’s view in that the process of bootstrapping minds (;; ) likely requires some pre-established modes of cognitive organization (). For example the place/grid cells of the hippocampal/entorhinal system could contribute initial structuring of experience according to space and time (; )—although these response-properties may substantially depend on experience for their emergence (; )—with a general capacity for tracking time-varying sequences being a potentially ubiquitous feature of cortex (). Implicit objective functions from innate salience mechanisms—e.g., maximizing information gain and empowerment (; )—and neuroplasticity rules such as spike-timing dependent plasticity (; ) could both be thought of as “evolutionary priors” that further help to organize experience according to likely patterns of causal influence (e.g., causes ought to precede effects). However, Helmholtz’s criticism of Kant’s intuitions may also highlight important differences between initial inductive biases and later constructive modeling of space (), time (; ), and cause (). It may be misleading to refer to largely innate mechanisms for structuring experience as “intuitions,” as these capacities may lack experiential content by not (yet) affording sufficient coherence for the generation of an experienceable world. Finally, agency-related knowledge may be particularly complex, diverse in its forms, and dependent upon experience for its development (;; ).

Hence, while IWMT suggests that quasi-Kantian categories may represent essential “core knowledge” for bringing forth a world with particular properties (such that they may be experienced), many questions remain unanswered. To what extent are our intuitions of space and time elaborated by our intuitions regarding causal unfolding that depend on the agentic self as a point of view on the world (; )? If coherence-making is bidirectional in this way, would this imply a kind of mutual bootstrapping in learning of self, agency, and space/time/cause over the course of development? If sense-making involves this kind of bidirectionally, or capacity for inferential positive feedback, could the mutual dependency of subjective categories of experience partially explain non-linear shifts in psychological development ()? Do different categories and intuitions asymmetrically drive different parts of development at different points in time? While these questions will not be definitively answered here, they may point the way to helping to identify which systems possess which forms of consciousness.

## Neural systems for coherent world modeling

As hopefully is made clear by the preceding discussion, philosophical considerations may be invaluable for helping to identify fundamental properties enabling conscious experience. Whether considered as synthetic *a priori* categories or experience-dependent constructed intuitions, the foundations of mind suggest that a primary task for cognitive science should be characterizing these properties on functional, algorithmic, and implementational levels of description. While such an analysis is beyond the scope of a single article, here I suggest neural systems that could contribute to some of these foundational capacities.

Integrated world modeling theory identifies two main sources of consciousness for space: (1) a sense of locality based on body-centric coordinates (), and (2) introspectable 2D maps () organized according to quasi-Cartesian coordinates with irregular spacing biased by salience and ‘navigation’ potential. Body-centric spatial senses would likely primarily be found in superior and inferior parietal cortices based on convergence of the dorsal visual stream and upper levels of the somatosensory hierarchy. 2D spatial maps can be found throughout the brain, but consciously accessible mappings are likely primarily localized to the precuneus at the brain’s posterior midline. These precuneus-based maps may couple with the more well-known spatial maps of the hippocampal/entorhinal system (; ), so allowing for ‘navigating’ () through visualized domains. IWMT suggests that hippocampal representations of spatiotemporal trajectories are unlikely to be directly introspectable, as deep spatiotemporal hierarchies and grounding within sensory modalities are likely required for coherent conscious experience. Precuneus-based maps may also be aligned with dynamics in the dorsomedial prefrontal cortex (another midline structure) (;; ), which may potentially be interpreted as sources of “attention schemas” (), upper levels of action hierarchies, and—perhaps most saliently with respect to conscious awareness—as an additional level of hierarchical control over the pre-supplementary eye fields (). With precise sequencing shaped by striatal-thalamic-cerebellar loops (), these frontal representations may provide a source of coherent vectors for directing the “mind’s eye,” so influencing what is likely to be ‘projected’ onto the precuneus as a kind of inner ‘theater’ (). Mechanistically, these action-oriented influences on perception may further depend on pulvinar-mediated synchrony for their realization (; ).

FIGURE 1

Integrated world modeling theory suggests that we ought to expect all phenomenal content to involve spatial aspects, potentially requiring multi-level processes of spatialization. Indeed, we may parse complex features by performing a kind of multidimensional scaling () in which features are mapped onto 2D spaces. The hippocampal/entorhinal system may be particularly important for establishing these mappings (,; ), and potentially for establishing the routes by which we are able to make sense of these complex domains by performing (generalized) ‘navigation’ through their spatialized representations (). For example, it has recently been demonstrated that entorhinal grid cells are used to spatially organize reward-related representations in the ventromedial prefrontal cortex (another midline region), with spatialization of task structure having behavioral significance for reinforcement learning problems ().

The nature of time perception may be somewhat more complicated compared to space, and may even be conceptually derived from initially spatial understanding (; ). While the entire brain (or at least much of the neocortex) may be sensitive to temporally varying sequences (), there seems to be no singular clock for time perception. One candidate clock-like mechanism potentially includes the formation of “global emotional moments” via the insular salience hierarchy (), with a greater density of salient events corresponding to relatively slower experienced (but not necessarily remembered) temporal unfolding. Speculatively, dopaminergic influences on time perception (; ) may suggest that the ability to both track and simulate (and track via simulations) causal sequences via actions may provide another factor influencing time perception, with a greater frequency of actions corresponding to elongated subjective timelines. Non-mutually exclusively, relationships between dopamine and time perception could be mediated by the hippocampal/entorhinal system (; ). These influences could include multiple factors, such as the frequency with which events are encoded as new memories, or through the mapping of timelines onto (2D) spatial trajectories with place/grid cells. Indeed, abilities to construct maps and routes for navigation (broadly construed) may be primary means by which space and time come together in brain and mind. Such simultaneous localization and mapping mechanisms may provide a basis for both the spatialization of time as well as the temporalization of space, as these two modes of quantization are fundamentally linked (and mutually defined) in terms of velocity, which may be physiologically linked via locomotion-dependent cholinergic midbrain nuclei (). Velocity estimation both requires and enables the ability to track changing relative spatial locations, with speed being time-varying displacement within space. Speculatively, similar relationships between time and space might also be mediated by mapping events onto body maps, both in terms of using bodily representations as a kind of space (within which things can change at varying speeds), as well as via potential magnitude estimation via the intensity of proprioceptive and interoceptive sensations. Finally, for linguistic beings such as humans, it may be difficult to overstate the importance of analogical/metaphorical construction processes for tying together and expanding these fundamental categories (;; ).

Causal understandings may be more difficult to map unto neural systems than time and space. As previously mentioned, some proto-causal understanding may derive from mechanisms such as the ability of spike-timing dependent plasticity to arrange events into likely time-varying sequences (; )—wherein causes can be expected to precede events—or via salience mechanisms such as modulation of midbrain dopamine by whether events are likely to have been internally or externally generated (; ). However, understanding causation requires more than these proto-intuitions, and in particular the ability to generate counterfactual scenarios involving simulated interventions, potentially providing an implementation of the “do-operator” introduced by Judea Pearl for causal inference with graphical models (). While it is unclear whether anything like the graphical representations underlying Pearlean analysis are used by brains and minds, the ability to simulate a variety of actions/interventions could provide a basis for similar kinds of causal reasoning. However, this ability to generate counterfactual scenarios likely required the advent of internal dynamics that can be decoupled from immediate engagement with the environment. Intriguingly, such adaptations may have arisen relatively straightforwardly with increasing degrees of cortical expansion, some of which may have provided a difference in kind with respect to expanded association cortices and a more freely operating default mode network (; ).

Finally, while the potential complexities of selfhood are inexhaustible, a very minimal sense of self and agency could potentially be derived from the reliable ability of embodied brains to learn that bodies depend on particular sensors by which they can perceive and effectors by which they can act. Since sensors and effectors are located on and in the body—and not elsewhere—the fact that bodily states are uniquely perceivable and controllable may provide a relatively straightforward means of construing models in which an agentic self exists as a separate entity from the rest of the (less immediately perceivable/controllable) world. While a broad range of neural systems may contribute to self-consciousness in diverse ways, IWMT focuses on body maps and visuospatial models for scaffolding inferences about selves and the (life)worlds in which they find themselves embedded.

## Machine learning architectures and predictive processing models of brain and mind

Integrated world modeling theory suggests that many of the processes and systems underlying consciousness may also be describable in terms of computational principles from machine learning. It may seem rather implausible that present technologies could reveal deep principles about the nature of mind, with potentially cautionary tales to be found in previous metaphorizations based on the technology of the day. Is this just another case of naïve arrogance of overgeneralizing from the familiar and fashionable, akin to previous claims that minds could be understood in terms of the accumulation and release of pressures, or when nervous systems were suggested to function according to the logical operations found in computers ()? Metaphors in which brains are understood as computers and even steam engines are both consistent with IWMT and the Free Energy Principle and Active Inference (FEP-AI) framework. Not only is there necessarily a sense in which brains compute information, but the serial operation of conscious access may even be thought of as a kind of (neural) Turing machine (; ). Even more, if neural systems minimize \[informational (and possibly thermodynamic)\] free energy (), then this may not only provide computational justification for pressure-based analogies (), but potentially even models inspired by the causal powers of engines as systems that perform thermodynamic work cycles (,). Thus, these previous attempts to analogize the nature of mind with existing technologies may have been surprisingly prescient.

Considering that FEP-AI has foundations in the free-energy objective functions used to train Helmholtz machines and autoencoders (), the rise of deep learning may have afforded conceptual progress for understanding not just minds, but all dynamical systems (viewed as generative models). The idea that deep learning could potentially inform neuroscience ought to be relatively unsurprising (; ), in that artificial neural networks were designed to try to capture relevant aspects of nervous systems (; ), albeit with limited physiological detail and some biologically implausible functionalities (e.g., training by backpropagation). IWMT goes further in arguing that not only can useful computational principles be derived from machine learning, but some architectures may have close correspondences with the neural processes contributing to consciousness via coherent world modeling. Below I will review a few of these relevant technologies and the ways functionally equivalent processes might be realized in biological systems (). (For more detailed illustrations of these putative functional mappings, please see, ). I will then go on to consider the implications of these suggested computational mappings for informing IWMT and associated theories.

FIGURE 2

### Cortex as folded disentangled variational autoencoder heterarchy

A predictive coding model of cortex may be approximated by folding a disentangled variational autoencoder over at the low-dimensional bottleneck such that levels align in encoders and generative decoders (please see, “Autoencoders,” as well as ), respectively implemented via hierarchies of superficial and deep pyramidal neurons. To implement predictive coding, descending messages from generative decoder networks would continuously suppress (or “explain away”) ascending messages from encoders. In this coding scheme, only failed predictions from generative decoders get passed upwards through encoders, with these prediction errors continuing to rise up hierarchical levels until they can be successfully suppressed by the descending stream. These descending predictions are generated on multiple levels, both locally via recurrent dynamics, as well as on a more global basis, potentially accompanied by unique architectural features and discrete updating of integrative models (; ). Viewed as folded autoencoders, these higher-level predictions would constitute a parameterization of generative decoder networks by samples from reduced-dimensionality latent feature spaces. As training proceeds, such an architecture should form increasingly predictive and sparse representations, so maximizing inferential power, while also minimizing the number of messages that need to be passed. This training for prediction and sparsification would correspond to the development of models of increasing accuracy, efficiency, and robust generalizability (; ).

A predictive coding model of cortex would correspond to not just a single (folded) autoencoder hierarchy, but a heterarchy composed of multiple intersecting hierarchies, so enabling cortical learning systems to obtain inferential synergy through multi-modal sensory integration (; ). In terms of machine learning principles, high-bandwidth connections between association cortices could correspond to the chaining of low-dimensionality bottlenecks from multiple autoencoders, so forming an auto-associative network capable of supporting loopy belief propagation (the potential functional significance of which will be explored below). Neuroanatomically speaking, these highly connected areas would correspond to the brain’s “rich club” networks (), including the 2D grid structures described above (), which could contribute to spatiotemporal modeling () in both concrete physical and abstract (via spatialization) domains.

Theoretically, these subnetworks (entailing shared latent space) may be well-modeled as graph neural networks (GNNs) (;,), which are gaining increasing popularity as a means of efficiently modeling a broad range of processes. From this perspective, experience-dependent plasticity may be understood as implementing a kind of implicit neural architecture search, which may potentially produce GNN-like representational structures as means of ensuring sufficiently rapid inference that estimates of system-world configurations are capable of both informing and being informed by action-perception cycles for embodied-embedded agents. Yet it remains unclear whether inferences from these subnetworks would themselves represent the physical/computational substrates of consciousness, or whether they would rather be necessary (but not sufficient) conditions for realizing phenomenality (). While this is not a necessary entailment of IWMT (and hence not a condition for falsification), if deep association cortices were found to operate according to principles of geometric deep learning, then it would provide strong support for the ideas presented here.

Finally, the regulation of neuronal dynamics by diffuse neuromodulator systems could be computationally understood as parameterizing inference and learning with respect to the formation of partially disentangled features in perception, as well as through the selecting and sculpting of particular policies for enaction (e.g., dopamine as precision weighting, or Kalman gain) (). To the degree diffuse neuromodulator systems both influence and are influenced by overall levels of message passing, these chemicals could be used to adaptively optimize generative models with context sensitivity. Such alterations of cognition and consciousness may be especially powerful with respect to the kinds of serotonergic signaling involved with psychedelic compounds, which is an area of active investigation for further developing IWMT (; ).

### The conscious turbo-code

Turbo-codes are used for reliably sending data over noisy channels (; ), with efficiency approaching the Shannon limit, suggesting near optimality. These codes were independently discovered by the cryptography community and as methods for approximate Bayesian inference via loopy belief propagation (). This method of extracting information from noisy signals has found a wide range of uses, including with respect to wireless communication standards. Perhaps these codes were also discovered by natural selection?

Integrated world modeling theory proposes that turbo-coding may be implemented by reciprocal effective connectivity between auto-associated cortical hierarchies, entailing shared reduced-dimensionality latent feature spaces among coupled autoencoders (). Mechanistically, this would be realized by the formation of large-scale synchronous complexes as self-organizing harmonic modes (SOHMs) over connectivity backbones, some of which may entail action-oriented body maps (i.e., lateral parietal cortices) and visuospatial modeling (i.e., posterior medial cortices). Algorithmically, this would correspond to the calculation of approximate joint posteriors—and maximally likely (MAP) estimates derived thereof—via loopy belief propagation. Functionally, this would correspond to a series of estimated world states of sufficient reliability to form bases for action selection (). Experientially, this would correspond to the stream of consciousness. (Note: While all synchronous complexes could potentially be interpreted as engaging in turbo-coding on some level of abstraction, IWMT suggests that only turbo-codes spanning multiple modalities are likely to be capable of generating conscious experiences).

The high-bandwidth message passing required for conscious turbo-coding may be enabled by the brain’s rich-club, which consumes up to 50% of cortical metabolism (). Theoretically, this metabolic expense may be (evolutionarily) justified by reducing the overall number of (noisy) neuronal signal transactions required to achieve adequately reliable perceptual inference, so increasing overall efficiency, and perhaps more importantly, decreasing latencies with respect to action selection. Perhaps even more importantly, turbo-coding over frontal-parietal networks may enable the inferential synergy required for consciously accessible experiences, and potentially the imagination of counterfactual scenarios (;; ), so facilitating (a) causal reasoning, (b) planning, and (c) ‘offline’ learning (e.g., self-supervised training via imaginative self-play).

Different rhythmic frequency bands may entail different kinds of information with respect to conscious turbo-codes. When beta complexes are cross-frequency phase coupled within alpha rhythms in posterior cortices, this may correspond to cross-modal message passing across the entire sensorium of the organism, organized within egocentric spatial reference frames, entailing consciousness (i.e., an experienced world) (). When these alpha and beta complexes are further orchestrated by theta rhythms from the hippocampal/entorhinal system and its “big loop recurrence” with frontal cortices (), this may correspond to action-driven perception (including simulated actions), and reflective access via comparisons amongst conscious states (; ).

Thus, turbo-coding may help to explain the functional significances of some of the mechanisms enabling consciousness. However, these modeling efforts may themselves have a further (circular) causal significance in that they may help to facilitate the conditions that enable them. Under normal circumstances, only coherent and well-evidenced world models are likely to enable loopy message passing to efficiently converge upon (approximate) posteriors, which in turn allow consciously experienced world models to arise. Perhaps similarly to the development of mutually related capacities for spatiotemporally and causally coherent world modeling, this kind of circular bootstrapping suggests that inferential and learning capacities may increase non-linearly, potentially resulting in relatively abrupt (or punctuated) phase transitions for the evolution of consciousness ().

In this view, consciousness emerges from an auto-associative network of coupled generative decoders, connected together to constitute a turbo-code. When message passing is forced to converge via synchrony—and where synchrony emerges from convergent message passing—this may entail maximal *a posteriori* estimates as coherent/discrete vectors with maximal control in governing overall system evolution, sampled from probabilistic spatial-temporal-causal world models. Thus, consciousness (as turbo-code) may not only govern perception as Bayesian model selection, but also action selection (broadly construed to include thought as covert ‘behavior’).

## Future directions for integrated information theory and global neuronal workspace theory?

Integrated world modeling theory proposes that FEP-AI can be used as a framework for synergistically combining leading theories of consciousness, specifically focusing on IIT and GNWT. Below we will discuss some of the ways in which our understandings of the physical and computational bases of consciousness may be advanced through this synthesis, and then move on to discuss how these principles may also lead to potential advances in artificial intelligence.

### Modules and workspaces as complexes of integrated information; potential physical substrates of consciousness

Global neuronal workspace theory describes how global workspaces allow otherwise isolated specialist modules to exchange information. However, the dynamics by which local modules and global workspaces interact remain poorly understood. IIT describes how complexes of effective connectivity can have varying degrees of cause-effect power upon themselves. (For further details, please see, “A review of IIT terminology”). However, the functional relationships between complexes of integrated information remain poorly understood. With FEP-AI as an integrative framework, it may be possible to combine GNWT’s emphasis on function and IIT’s emphasis on dynamics in mutually informative ways. A potentially promising avenue is to apply IIT’s analytic approaches to modules and workspaces as complexes with varying degrees of irreducible self-cause-effect power, including with respect to the ways integrated information varies over the course of cognitive cycles. (For further details, please see, “Evaluating GNWT’s local modules and global workspaces in terms of the axioms of IIT”).

Both local modules and global workspaces can be viewed as constituting complexes of integrated information with varying amounts of irreducible self-cause-effect power (phi). The extent to which modules have more or less phi would specifically depend on the phase of cognitive cycles. Specifically, if “ignition” events correspond to the breakdown of local modularity via the formation of larger complexes of effective connectivity, then we would expect the relative phi for local modules and global workspaces to vary in an inverse fashion. IIT might view this changing modularity as trading off consciousness level between modules and workspaces, with separate modules entailing consciousness when they represent phi maxima, but with these consciousnesses being replaced with a single consciousness when workspace dynamics are present. IWMT and GNWT, in contrast, would only view large-scale workspaces as being capable of supporting conscious experiences.

Integrated information theory, in contrast to GNWT, does not view consciousness as corresponding to a global workspace, but only a posterior “hot zone” as constituting a phi maximum (). The involvement of frontal cortices may be important for instantiating workspace dynamics of a more global nature in terms of widespread availability of information, but according to IIT, these systems would not themselves represent physical substrates of consciousness. IWMT agrees with IIT that basic phenomenality likely centers on posterior cortices, and also agrees with GNWT that frontal cortices are likely crucial for enabling conscious access and autonoetic awareness.

However, IWMT disagrees with IIT that a given module would necessarily be conscious if it constitutes a complex that maximize integrated information (Phi). Rather, modules may be conscious only if they entail integrated models with spatial, temporal, and causal coherence for embodied systems and their relationships to environments in which they are embedded. Given the previously discussed properties of posterior medial cortices, synchronous activity within posterior hot zones could represent an instance of a (large) module being conscious when not participating in global workspace dynamics via the frontal lobes. However, this could also be viewed as a primarily semantic argument, as complexes capable of synergistically integrating information across occipital, temporal, and parietal cortices could reasonably be said to be functioning as ‘global’ workspaces. Perhaps some disputes between GNWT and IIT may be partially resolved by attempting to be more precise about how widespread integration must be to ‘count’ as global.

### Cognitive cycles and fluctuating substrates of consciousness?

In mammals, “posterior hot zones” () may be both necessary and sufficient for generating consciousness (as integrated world modeling process), and these (both competitive and cooperative) attractor-formation processes may tend to be strictly dominated by dynamics within posterior association cortices. However, by coupling with posterior areas, frontal cortices could help influence the specific compositions of maximal complexes on their timescales of formation. Frontal cortices may be able to influence posterior attracting networks before maximal coherence/integration is achieved, so defining spatial and temporal grains for qualia generation, enabling intentional control of attention, working memory, and action selection. When this effective coupling involves driving of frontal cortices by posterior complexes, this information may also be made more globally available for the sake of higher-order modeling. In these ways, IWMT is also in agreement with GNWT regarding the importance of frontal network hubs, although this may be the case for conscious access, rather than the more posterior-located processes that may be responsible for generating coherent streams of experience.

These hypotheses could potentially be tested via transcranial magnetic stimulation applied at different phases of cognitive cycles (; ) in which (possibly theta-coupled) alpha rhythms may alternate across frontal and posterior cortices, assessing whether intervention influences different kinds of either implicit \[e.g., via perturbation complexity index (PCI) methods\] or explicit modeling (). Alternatively, evoked complexity could be time-stamped to endogenous potentials as a measure of different kinds of integrative complexity. While PCI measures can potentially be explained without appealing to IIT, they can nonetheless be used as proxies for integrated information. If GNWT and IIT are compatible in the ways suggested by IWMT, then PCI should be higher during periods where workspace dynamics are present. This could potentially be tested by timing the TMS pulse to coincide with ignition events during which large scale integration occurs, or evaluating Lempel-Ziv complexity after putative ignition events such as the p300 (; ). If integrative complexity measures were not found to be higher accompanying workspace dynamics, this could potentially falsify IWMT.

Perhaps relatedly, an unresolved issue within IWMT is whether consciousness (as experience) corresponds to a series of discrete “snapshots” (;; ), like a flipbook or sequential frames in a cartoon/comic (). Alternatively, such discretization could reflect a process of consciously accessing—or sampling from, as in inference via Markov chain Monte Carlo (; )—an otherwise continuous stream of experience. IWMT’s account of synchronous complexes as entailing turbo-coding between coupled autoencoders suggests that consciousness could either be understood as flows of inference via traveling waves on a fine-grained level, or as self-organizing harmonic modes (SOHMs) when coarse-grained according to the scales at which various forms of functional closure are achieved (; ), including those which would allow for the kinds of higher-order cognition involved in conscious access, self-awareness, forms of meta-awareness, acting with awareness, and planning. In terms of the machine learning models described above, ignition events could potentially be viewed as semi-stochastic sampling from latent spaces, used by variational auto-encoders to parameterize generative models in creating novel combinations of features. If these samples are biased according to histories of reward learning, then these events/samples could correspond to neural dynamics (including those entailing consciousness) being driven in directions that are most likely to realize organismic value, given the data of experience. In this way, it could be the case that ignition events themselves generate consciousness as a series of “snapshots,” or maximal *a posteriori* (MAP) estimates from nervous systems viewed as generative models. Alternatively, it could be the case that ignition events correspond to a source of vectors that parameterize generative models that evolve through more continuous updating.

The seemingly continuous nature of the stream of experience could be illusory, actually corresponding to a series of MAP estimates realized by the turbo coding of ignition events, corresponding to a parameterization of sampling operations, with cortical hierarchies functionally understood as coupled variational autoencoders. Or, iteratively forming these largescale attracting-states may instead be a highly efficient (and potentially optimal) means of realizing globally coherent/integrated inference, where organizing behavior based on a series of estimates has been demonstrated to also be highly efficient from a decision-theoretic perspective (). All these perspectives may be accurate, except with respect to different aspects of experience unfolding on different scales. While frontal-mediated conscious access may be discrete, posterior-generated basic phenomenal consciousness may truly be more like a continuous stream of entangled inferences, whose—potentially shockingly limited ()—richness overflows awareness.

Integrated world modeling theory currently does not have a definitive prediction as to whether the prefrontal cortices (PFCs) ever represent a physical substrate for consciousness as suggested by GNWT. While a “posterior hot zone” may provide both necessary and sufficient conditions for generating experience as suggested by IIT, it is unclear that frontal cortices ought to be considered as separate from these generative processes, particularly during ignition events in which large-scale frontoparietal complexes are observed. Alternatively, it may be the case that frontal cortices are incapable of significantly driving the heavily entangled internal dynamics of posterior cortices on the timescales at which integration occurs, where posterior-centered inter-relations may have enough causal density to establish functional closure with respect to the processes generating coherent (and so experienceable) world models. Considerations of developmental necessity may also be relevant to debates between IIT and GNWT regarding the neural substrates of consciousness. Frontal cortices may potentially be necessary for the initial development of basic phenomenal consciousness, but not for its continued realization after sufficient experience. That is, frontal cortices may be essential for bootstrapping phenomenal consciousness via the construction of coherent world models, but once developed, these experience-generating capacities—but probably not conscious access, contrary evidence notwithstanding ()—may be preserved even with complete disruption of these initially necessary enabling conditions.

Yet another possibility is that frontal cortices may themselves have enough integrative capacity over requisite sources of information that they represent sufficient substrates of consciousness on their own, potentially offering a source of predictions for what posterior cortices are likely to experience in the future (;; ). This hypothesis of forward-looking PFCs would be consistent with their roles in action selection and motor control through predicting the sensory consequences of movement (). However, for frontal cortices to generate experience on their own, IWMT would require sufficiency with respect to establishing perspectival reference frames with spatiotemporal and causal coherence. Regardless of whether or not frontal cortices are considered to be directly part of subnetworks generating consciousness, the nature of subjective experience will likely heavily depend on their involvement as emphasized by GNWT and higher order theories (; ). While (very difficult to test) dissociations may be expected with respect to phenomenal consciousness being possible without conscious access, the qualities of experience will depend on their multi-scale interactions with higher order cognitive processes. For example, the act of introspecting will substantially change the nature of what is (a)perceived (e.g., attention; Sperling phenomena) ().

### Bayesian blur problems and solutions; quasi-quantum consciousness?

While the brain probably does not support the kinds of large-scale coherence required for quantum computation (; ), it may nonetheless be the case that neuronal dynamics can be viewed as emulating quantum-like computations (e.g., annealing) by classical means (;; ). Machine learning algorithms play a central role in IWMT, and quantum implementations of autoencoders (e.g., as used in error-correcting codes) may be relevant for making further advances in developing functional analogs for the computational properties of brains. Very speculatively, it may even be the case that dynamic reconfigurations of neuronal microtubules could emulate quantum-like computation in orchestrating signaling (e.g., via transportation rates for neurotransmitter containing vesicles) and memory (via synaptic modifications and synaptogenesis), while not themselves involving sustained quantum coherence (cf. Orch OR theories) ().

Indeed, quantum mechanics inspired models could have potential relevance to solving the “Bayesian blur problem” (). That is, how can a probabilistic model generate seemingly unified experience (cf. the intuition underlying the exclusion axiom from IIT) composed of discrete perceptual experiences, rather than a superposition of possibilities? Functionally speaking, it may be desirable for the brain to provide discrete estimates of—or highly precise distributions over—world states for the sake coherent action selection. However, a “Bayesian blur solution” could also be proposed, in that it may also be desirable to maintain full probability distributions with multiple possibilities kept in play for the sake of adaptation and exploration. In considering workspace dynamics as implementing Bayesian model selection, it may be the case that brains obtain the best of both discrete and probabilistic modeling by “dividing and conquering” across different phases of cognitive cycles, or possibly across brain areas (; ). Alternating workspace modes—potentially reflected by the formation/dissolution of mesoscale connectomic modularity (; )—could allow periods where multiple competing and cooperating hypotheses can remain in play, followed by winner-take-all dynamics when this information is integrated into larger scale networks and models (), and then “broadcasted” back to modules as they re-form.

Stanislas Dehaene intriguingly (2014) suggested that the formation of workspaces via ignition events could be understood as a kind of phase change akin to those observed in physical systems. He goes onto propose that a potentially productive analogy could be found in models of wave function collapse in quantum physics, where a superposition of possibilities is reduced to a determinate classical world, which IWMT considers to be a promising avenue for future investigation. It may be similarly productive to explore whether multiple interpretations of quantum mechanics apply to varying degrees as abstract descriptions of varying informational modes within minds, understood in terms of varieties of Bayesian model selection and inferential dynamics. That is, conceptualizations from multiple quantum interpretations (;; ) could potentially apply to different aspects of integrated world modeling. Could entanglement be used to model changes in the precision of probabilistic densities as a function of coupling sub-systems? Could more precise distributions (or estimates derived thereof) due to re-entrant signaling from PFCs be used to implement a kind of Copenhagen-style observer-dependent selection of classical phenomena? Could marginalization via self-organizing synchronous complexes be modeled in a similar manner to spontaneous wave function collapse (and quantum Darwinian interpretations)? Could periods of high modularity/segregation for functional connectomes be productively analogized with branching many worlds? Could relationships between fine-grained neuronal message passing and standing wave descriptions exhibit abstract similarities with Bohmian pilot waves (e.g., chained gamma complexes as quantized prediction errors and solutions)? To be clear, these are all (very) highly speculative analogies for information dynamics, and quantum physical phenomena are likely not directly relevant to the brain’s computational abilities in any meaningful sense, given the hot and crowded nature of biological systems (). Nonetheless, such metaphors/models may potentially afford insights into the nature of neuronal information processing and its connections to different aspects of consciousness.

Regarding “consciousness as collapsing agent” theories (to continue with the analogical extension of quantum mechanics described above): If PFC involvement is important for establishing synchronous coherence in posterior cortices, then this process of dimensionality reduction over dynamics may potentially be likened to wave function collapse by a (potentially unconscious) PFC ‘observer.’ That is, the operation/action of conscious access via PFC re-entry may be required for transforming a continuous sea of probabilities into a discrete stream of experience—as the iterated generation of particular qualia. If the “Bayesian blur” problem is overcome in this manner, then experience may not be solely generated by posterior cortices as described above, potentially favoring GNWT’s suggestion that frontal lobes are part of the physical substrates of consciousness. However, this functionality could potentially be achieved at different stages of cognitive cycles, so excluding PFCs from stages where consciousness is generated (cf. dual phase evolution) (). Another possibility would involve basic phenomenal consciousness being more diffuse/probabilistic without PFC-involvement, but where conscious access is more particular/discrete. But if this kind of PFC-independent modeling lacks sufficient organization with respect to space, time, and cause, then there may be insufficient coherence to result in the appearance of an experienced world. If this were the case, then it would challenge the distinction between phenomenal consciousness and conscious access, and may potentially support some theories emphasizing higher order cognition (). The evolving adversarial collaboration between IIT and GNWT theorists may potentially provide evidence that could disambiguate some of these matters.

### Mechanisms for integration and workspace dynamics

Integrated world modeling theory views ignition events in terms of the formation of self-organizing harmonic modes (SOHMs), entailing message passing in nervous systems understood as Bayesian belief networks. In this way, the formation of any meta-stable synchronous complex is viewed as both an ignition event and establishment of a kind of workspace, regardless of whether involvement of frontal lobes and ‘global’ ‘access’ are achieved. In all cases, SOHMs are hypothesized to entail loopy belief propagation and marginalization over effectively connected subnetworks. (For more detail, please see, “Micro-dynamics of SOHM-formation via generalized synchrony”). In the case of small ensembles synchronized at fast gamma frequencies, SOHMs may contribute to the communication of prediction errors up cortical hierarchies (; ) via quantized packets of information (as sufficient/summary statistics), so establishing marginal message passing regimes (). In the case of large ensembles synchronized at beta, alpha, and theta frequencies, SOHMs may allow for large-scale updating of beliefs and sources of integrative predictions from deeper portions of generative models.

In terms of mesoscale and macroscale neuronal dynamics, we might expect large-scale SOHMs to be particularly likely to form in proximity to rich-club hubs of the brain with their high degrees of reciprocal connectivity. These core networks have been found to provide backbones of effective connectivity and robust sources of synchronizing dynamics (). Within these highly interconnected systems, signals may be particularly likely to undergo positive feedback amplification, where this explosive signal transduction may be able to temporarily form synchronous complexes capable of integrating information from across the brain and then propagating (or “broadcasting”) this information to the rest of the network as Bayesian beliefs (or priors in predictive coding).

In terms of generalized synchrony, direction of entraining influence may potentially switch between peripheral and core networks before and after critical ignition events (). Theoretically, peripheral sensory hierarchies may asymmetrically entrain deeper levels with core connectivity, seeding them with ascending prediction errors, communicated via driving inputs at gamma frequencies. In this way, Bayesian model selection would be driven via a process of differential seeding of core states via competition (and cooperation) amongst neuronal coalitions entailing hypotheses regarding latent causes of sensory observations. These discretely updated core states from deep in the heterarchy could then be used to asymmetrically drive peripheral networks. According to IWMT, these core inferences would be communicated at beta frequencies for specific predictions, alpha frequencies for predictions integrated within egocentric reference frames, and theta frequencies for predictions shaped by particular actions (broadly construed to include mental acts such as attentional fixations;; ). Thus, SOHMs and the processes by which they form may function as complexes of integrated information and sources of workspace dynamics, so implementing Bayesian model selection on multiple levels. This multi-level selection—which may also be understood in terms of neural Darwinism and dual-phase evolution ()—may proceed simultaneously over multiple scales, with both global serial and local parallel integration being implemented by SOHMs of varying spatial (and temporal) extents.

It is worth noting that this proposal does not depend on any given account of predictive processing being accurate. For example, it may be the case that descending modulatory inputs at slower frequencies do not necessarily involve predictive explaining away, but could instead be used to allow sensory observations to ascend with more feedforward driving (; )— which would not be incompatible with an interpretation of attending based on precision weighting (i.e., Kalman gain)—as may be the case with respect to theta-gamma cross-frequency phase coupling (; ). It may be the case that slower frequencies could be used to either inhibit or promote the relative contributions of different sensory observations—communicated at faster gamma frequencies—to iterative rounds of Bayesian model selection. This kind of adaptive enhancement of prediction errors may help to reconcile predictive processing with findings that consciousness level and phenomenal binding have been associated with increases in gamma power and inter-electrode gamma coherence (, ), potentially realized by mechanisms involving zero-lag phase synchronization (). Alternatively, it may merely be the case that more precise predictions tend to be accompanied by increased prediction errors, without observations being specifically enhanced through attentional selection mechanisms. In either case, predictive processing diverges with some more well-known ideas in suggesting that gamma-band activity may not itself generate consciousness, but may instead indirectly modulate belief updating at slower frequencies.

### Beyond integrated information?

Integrated information theory has evolved as a theory over two decades of concerted effort, and further refinements and elaborations of the theory are currently being developed. This ongoing evolution has caused some people to question whether IIT’s postulated mechanisms are truly grounded in axiomatic principles of phenomenology (), and whether its methods may contain questionable modeling assumptions. Indeed, many of the most practically useful (and highly face valid) phi estimation techniques rely on previous versions of the theory, such as estimating integrated information based on causal density (; ). (For a more detailed discussion, please see: “Toward new methods of estimating integrated information”).

Much skepticism regarding IIT has resulted from demonstrations of high phi values being associated with systems for which there are strong *a priori* reasons to suspect a lack of consciousness, such as the kinds of 2D grids used in expander graphs (). Yet such objections to IIT’s validity can be readily handled by considering integrated information to be necessary, but not sufficient for consciousness without the cybernetic grounding suggested by IWMT. However, the potential modeling capacity of even a single 2D grid should not be underestimated (). With respect to the particular example of the dubious consciousness of expander graphs, it should be noted that such systems have many of the properties which may contribute to the computational power of brains, including small-world connectivity (), sparseness (), and ability to support error-correcting codes (). Theoretically, an arrangement of hierarchically organized expander graphs could be used to implement predictive processing and may be functionally equivalent to the kinds of turbo coding adduced by IWMT. Nonetheless IWMT states that such systems will not be conscious unless their functionality enables coherently integrated world modeling, which may be afforded in mammalian brains by posterior medial cortices () with respect to visual phenomenology and a sense of quasi-Cartesian space ().

Others have questioned the merit of emphasizing a single measure for the informational dynamics of complex systems (). This work has challenged the assumption of pairwise causal interactions in networks, instead focusing on dynamical complexity in terms of the decomposition of integrated information into potentially coexisting modes of informational flows. These novel measures reveal that integration processes can be understood as aggregates of multiple heterogeneous phenomena such as informational storage, copy, transfer, erasure, downward causation, and upward causation. Promisingly, these decomposed measures of integrated information could allow for the creation of novel methods for assessing informational dynamics, which may be superior in some use cases.

Integrated world modeling theory agrees with that integrated information is not the only valuable way to look at consciousness or complex systems more generally. Nonetheless, aggregations of heterogeneous phenomena can produce wholes that are greater than the sum of their parts. Mind and life are two such phenomena, and this kind of functional synergy may also apply to informational constructs (including mind and life). If integrated information corresponds to self-model-evidence as described by FEP-AI, then this would be a very special measure of dynamical complexity, potentially indicating the ability of whole systems to be both stable, adaptive, and even autonomous (). Indeed, connections between integrated information and self-organized criticality further suggests that we may be dealing with a measure that applies to all systems capable of not just persisting, but evolving (;;;; ).

### Recurrent networks, universal computation, generalized predictive coding, unfolding, and (potentially conscious) self-world modeling

There may be a kind of generalized predictive coding and implicit intelligence at play across all persisting dynamical systems (;;;;; ). However, according to IWMT, consciousness will only be associated with systems capable of coherently modeling themselves and their interactions with the world, likely requiring architectures capable of supporting recurrent processing. This is not to say that recurrence is necessarily required for the functionalities associated with consciousness (), but recurrent neural networks (RNNs) may be a practical requirement, as supra-astronomical resources may be necessary for unrolling an RNN into a functionally equivalent feedforward neural network (FNN) for a system the size of the human brain across even the 100s of milliseconds over which workspace dynamics unfold. Further, the supposed equivalence of feedforward and feedback processes are only demonstrated when unrolled systems are returned to initial conditions and allowed to evolve under identical circumstances (). These feedforward “zombie” systems tend to diverge from the functionalities of their recurrent counterparts when intervened upon and will be unable to repair their structure when modified. This lack of robustness and context-sensitivity means that unrolling loses one of the primary advantages of consciousness as dynamic core and temporally extended adaptive (modeling) process, where such (integrated world) models allow organisms to flexibly handle novel situations. Further, while workspace-like processing may be achievable by feedforward systems, largescale neuronal workspaces heavily depend on recurrent dynamics unfolding over multiple scales. Perhaps we could model a single inversion of a generative model corresponding to one quale state, given a sufficiently large computational device (even if this structure might not fit within the observable universe). However, such computations would lack functional closure across moments of experience (; ), which would prevent consciousness from being able to evolve as a temporally extended process of iterative Bayesian model selection.

Perhaps more fundamentally, one of the primary functions of workspaces and their realization by dynamic cores of effective connectivity may be the ability to flexibly bind information in different combinations in order to realize functional synergies (;;; ). While an FNN could theoretically achieve adaptive binding with respect to a single state estimate, this would divorce the integrating processes from its environmental couplings and historicity as an iterative process of generating inferences regarding the contents of experience, comparing these predictions against sense data, and then updating these prior expectations into posterior beliefs as priors for subsequent rounds of predictive modeling. Further, the unfolding argument does not address the issue of how it is that a network may come to be perfectly configured to reflect the temporally extended search process by which recurrent systems come to encode (or resonate with) symmetries/harmonies of the world. Such objections notwithstanding, the issue remains unresolved as to whether an FNN-based generative model could generate experience when inverted.

This issue also speaks to the ontological status of “self-organizing harmonic modes” (SOHMs), which IWMT claims provide a functional bridge between biophysics and phenomenology. Harmonic functions are places where solutions to the Laplacian are 0, indicating no net flux, which could be defined intrinsically with respect to the temporal and spatial scales over which dynamics achieve functional closure in forming self-generating resonant modes (). \[Note: These autopoietic self-resonating/forming attractors are more commonly referred to as “non-equilibrium steady state distributions” in the FEP literature (), which are derived using different—but possibly related ()—maths.\] However, such recursively self-interacting processes would not evolve in isolation, but would rather be influenced by other proto-system dynamics, coarse-graining themselves and each other as they form renormalization groups in negotiating the course of overall evolution within and without. Are SOHM-like standing wave descriptions ‘real,’ or is everything just a swirling flux of traveling waves? Or, are traveling waves real, or is there ‘really’ just an evolving set of differential equations over a vector field description for the underlying particles? Or are underlying particles real, or are there only the coherent eigenmodes of an underlying topology? Even if such an eliminative reductionism bottoms out with some true atomism, from an outside point of view we could still operate according to a form of subjective realism (), in that once we identify phenomena of interest, then maximally efficient/explanatory partitioning into kinds might be identifiable (;; ). Yet even then, different phenomena will be of differential ‘interest’ to other phenomena in different contexts evolving over different timescales.

While the preceding discussion may seem needlessly abstract, it speaks to the question as to whether we may be begging fundamental questions in trying to identify sufficient physical substrates of consciousness, and also speaks to the boundary problem of which systems can and cannot be considered to entail subjective experience. More concretely, do unrolled SOHMs also entail joint marginals over synchronized subnetworks, some of which IWMT claims to be the computational substrate of consciousness? Based on the inter-translatability of RNNs and FNNs, this question appears to be necessarily answered in the affirmative. However, if the forms of functional closure underlying these synchronization manifolds require temporally extended processes that recursively alter themselves (; ), then it may be the case that this kind of autopoietic ouroboros cannot be represented via geometries lacking such entanglement. Highly speculatively (and well-beyond the technical expertise of this author), SOHMs might necessarily represent kinds of “time crystals” (;; ) whose symmetry-breaking might provide a principled reason to privilege recurrent systems as physical and computational substrates for consciousness. If this were found to be the case, then we may find yet another reason to describe consciousness as a kind of “strange loop” (,; ), above and beyond the seeming and actual paradoxes involved in explicit self-reference.

This kind of self-entanglement would render SOHMs opaque to external systems lacking the cipher of the self-generative processes realizing those particular topologies (). Hence, we may have another way of understanding marginalization/renormalization with respect to inter-SOHM information flows as they exchange messages in the form of sufficient statistics (), while also maintaining degrees of independent evolution (cf. mean field approximation) over the course of cognitive cycles (). These self-generating entanglements could further speak to interpretations of IIT in which quale states correspond to maximal compressions of experience (). In evaluating the integrated information of systems according to past and future combinatorics entailed by minimally impactful graph cuts (), we may be describing systems capable of encoding data with maximal efficiency (), in terms of possessing maximum capacities for information-processing via supporting “differences that make a difference.” A system experiencing maximal alterations in the face of minimal perturbations would have maximal impenetrability when observed from without, yet accompanied by maximal informational sensitivity when viewed from within.

If we think of minds as systems of interacting SOHMs, then this lack of epistemic penetration could potentially be related to notions phenomenal transparency (via opacity) (; ), and perhaps “user interface” theories of consciousness (). Intriguingly, maximal compressions have also been used as conceptualizations of the event horizons of black holes, for which corresponding holographic principles have been adduced in terms of internal information being projected onto 2D topologies. With respect to the FEP, it is also notable that singularities and Markov blankets have been interpreted as both points of epistemic boundaries as well as maximal thermal reservoirs (). Even more speculatively, such holography could even help explain how 3D perception could be derived from 2D sensory arrays, and perhaps also experienced this way in the form of the precuneus acting as a basis for visuospatial awareness and kind of “Cartesian theater” (;;; ). As described above, this structure may constitute a kind of GNN, utilizing the locality of recurrent message passing over grid-like representational geometries for generating sufficiently informative projections on timescales proportional to the closure of action-perception cycles (). And when coupled with lateral parietal cortices (as upper levels of body map hierarchies), these cortical hubs may theoretically (and potentially exclusively) constitute the physical and computational bases of phenomenal consciousness ().

## Conclusion

In attempting to expand on the questions raised by IWMT, opinions will surely vary as to whether we have made substantial progress on contributing to a satisfying solution to the Hard problem of consciousness, or the meta-issue as to whether this is even a real problem (). Several open questions remain, which are currently being explored in the context of models of self-consciousness and agentic control (), the hippocampal/entorhinal system as a basis for episodic memory/imagination and high-level cognition (), cognitive/affective development (; ), and the computational neurophenomenology of psychedelics (; ).

Directions for future study are numerous and varied, but some particularly promising avenues would likely include focusing on the relationships between consciousness and other closely related constructs such as attention and working memory (;; ). That is, different forms of consciousness constitute potentially powerful (and flexible) mechanisms for top-down attentional selection, and bottom-up attentional selection mechanisms help to influence which patterns are likely to enter into fields of consciousness. If neural ensembles are capable of ‘resonating’ with dynamic cores (entailing self-world models) by having compatibly aligned activity, then we may expect deeper processing of these consistent (or consonant) patterns. However, we may also have attentional selection via various kinds of “mental actions” (; ), potentially with qualitatively distinct mechanisms such as theta-gamma cross-frequency phase coupling as mediated by hippocampal and frontal brain systems ().

It has also been suggested that there may be correspondences between IWMT and higher order theories such as Attention Schema Theory (; ), with workspace-supporting networks of structural (and effective) connectivity potentially being understood as supporting both attention and action-oriented body schemas. If this were found to be the case, then it may have relevance for explaining how biological systems handle the “frame problem” of determining the scope of relevance for any given situation. That is, if consciousness is so deeply embodied that it is inherently structures all percepts via their affordance relations, then enactive minds may handle the frame/relevance problem nearly automatically. Regardless of whether such speculations are supported, investigating relationships between attentional selection and consciousness is of crucial importance, as it may provide one of the strongest means of determining the extent to which intelligence may be facilitated by different forms of conscious processing, potentially revealing the adaptive significance(s) that drove their evolution, and possibly suggesting future directions for developing artificial general intelligence.

Perhaps the Hard problem will only be definitively solved when we can settle when different forms of consciousness first evolved. This is an extremely difficult question, as mental states do not leave fossils, but must be inferred from combining assumptions regarding the functional capacities of different information processing systems and their likely behavioral consequences. A broad range of selective pressures may have contributed to the advent of consciousness and further elaborations in conscious cognition as major transitions in evolution:

- **1.**
	Cognitive arms races between predators and prey (), where the evolution of jaws in fish may have been a particularly important milestone ().
- **2.**
	The transition of aquatic animals to land resulting in increased capacity for long-distance vision approximately 380 million years ago, and so increased adaptive significance for being able to plan ahead (; ).
- **3.**
	Selection for precise visualization associated with reaching and grasping of food by prosimians with capable hands ().
- **4.**
	Selection for cognition and visualization abilities to facilitate the coordination required for highly social animals (), and perhaps especially pack-hunting species.
- **5.**
	Selection for planning when standing afforded increased abilities to see ahead (). Further selection for visualization may have occurred due to the challenges associated with bipedal running.
- **6.**
	Increased selection for precise visualizations with tool-use, including with respect to thrown projectiles during hunting. While such abilities are often considered to be separate from explicit cognition, there is also evidence that counterfactual imaginings are important for guiding implicit learning processes for complex motor sequences (; ).

However, while would all represent situations in which expanding the capacities of conscious processing may have undergone selection, it is unlikely that any of these scenarios adequately addresses the first origins of the evolution of consciousness (as integrated world modeling). For further speculations on this matter, see, “A tentative timeline for the evolution-development of consciousness according to IWMT”.

have suggested a promising approach based on identifying “evolutionary transition markers,” or adaptations which likely require consciousness for their functioning. Capacities for “unlimited associative learning” are proposed to be the clearest candidate for identifying conscious systems, and are suggested to have arisen around the Cambrian explosion among a wide variety of animals, including arthropods. While consciousness would be very likely to increase the flexibility and cumulative nature of learning processes, IWMT currently does not have a clear position as to whether such processing is necessarily conscious. Indeed, the hippocampal/entorhinal system may be the clearest example of a set of adaptations for flexible learning (), yet many of these functionalities could potentially be realized unconsciously. In brief, IWMT suggests that consciousness first evolved as a means of generating estimates of likely system-world states, conditioned on a causal world model trained via histories of experience with environmental interactions (including vicarious observations of the actions of others). Such a predictive nexus of integrated information (or “dynamic core”) and workspace could potentially help to realize much of unlimited associative learning, but its initial functionality may have primarily been constituted as a “data fusion” mechanism that structures experience for the sake of more adaptive action selection and credit assignment (). That is, it could be highly adaptive to be able to identify particular situations with coherent spatiotemporal organization of features with respect to self and world, with unlimited associative learning potentially constituting a secondary functionality. Future work will explore this issue in greater depth.

Integrated world modeling theory was originally developed based on three observations:

- **1.**
	A substantial degree of convergence across theories of consciousness, but with differences being emphasized over similarities (cf. adversarial collaborations).
- **2.**
	A substantial degree of convergence between principles of machine learning and computational models of brain functioning.
- **3.**
	A surprising lack of consideration for the nature of embodiment in attempting to explain how subjective experience could arise from physical systems.

From this perspective, the most promising way forward for consciousness studies would be for different theorists to more deeply engage with opposing points of view and search for opportunities for synergistic explanations. Further, computational principles from machine learning may not only provide a basis for adjudicating between competing claims, but may provide a powerful algorithmic basis for bridging functional and implementational levels of analysis (). This approach of “computational neurophenomenology” involves connecting a multi-level understanding of mind to core aspects of experience (), for which IWMT and compatible theories suggest that the core explananda are likely the generation of a coherent egocentric perspective with a “lived body” at its center (; ). Toward this end, if a sufficiently detailed account of the brain as a kind of hybrid machine learning architecture could be obtained, and if this description was consistent with other models on functional, algorithmic, implementational, and phenomenal levels of analysis, then many might finally consider the Hard problem to be solved. I suggest that such an understanding would provide an invaluable reference point for understanding numerous aspects of minds, providing new means for intervention and control, and perhaps even a basis for the greatest project of all: attempting to create conscious artificial intelligence as potentially world-changing technologies, and possibly as ends in themselves.

## Statements

### Author contributions

The author confirms being the sole contributor of this work and has approved it for publication.

### Acknowledgments

I would like to extend my sincerest thanks to all the people who have helped me to develop these ideas over the years, and particular thanks to Karl Friston for his guidance and inspiration; to Giulio Tononi, Bernard Baars, and Stanislas Dehaene for their work on the theories I have attempted to combine; and to Jürgen Schmidhuber for his pioneering work and invaluable feedback on a previous version of this manuscript. I would also like to thank Matthew Johnson and the Center for Psychedelic and Consciousness Research at the Johns Hopkins University School of Medicine for supporting me in pursuing this work.

### Conflict of interest

The author declares that the research was conducted in the absence of any commercial or financial relationships that could be construed as a potential conflict of interest.

### Publisher’s note

All claims expressed in this article are solely those of the authors and do not necessarily represent those of their affiliated organizations, or those of the publisher, the editors and the reviewers. Any product that may be evaluated in this article, or claim that may be made by its manufacturer, is not guaranteed or endorsed by the publisher.

### Supplementary material

The Supplementary Material for this article can be found online at: [https://www.frontiersin.org/articles/10.3389/fncom.2022.642397/full#supplementary-material](#supplementary-material)

## References

- 1
	AaronsonS. (2014). Shtetl-Optimized » Blog Archive » Why I Am Not An Integrated Information Theorist (or, The Unconscious Expander). Available online at: [https://www.scottaaronson.com/blog/?p=1799](https://www.scottaaronson.com/blog/?p=1799) (accessed December 15, 2020).
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=S..%2BAaronson&publication_year=2014&title=Shtetl-Optimized%2B%C2%BB%2BBlog%2BArchive%2B%C2%BB%2BWhy%2BI%2BAm%2BNot%2BAn%2BIntegrated%2BInformation%2BTheorist%2B%28or%2C%2BThe%2BUnconscious%2BExpander%29)
- 2
	AdamsR.ShippS.FristonK. J. (2013). Predictions not commands: Active inference in the motor system.**Brain Struct. Funct.**218611–643. 10.1007/s00429-012-0475-5
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/23129312)
	- [CrossRef](https://doi.org/10.1007/s00429-012-0475-5)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=R..%2BAdams&author=S..%2BShipp&author=K.%2BJ..%2BFriston&publication_year=2013&title=Predictions%2Bnot%2Bcommands%3A%2BActive%2Binference%2Bin%2Bthe%2Bmotor%2Bsystem.&journal=Brain+Struct.+Funct.&volume=218&pages=611-643)
- 3
	AhmadS.ScheinkmanL. (2019). How Can We Be So Dense? The Benefits of Using Highly Sparse Representations.**Arxiv** \[Preprint\]. 10.48550/arXiv.1903.11257
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/35895330)
	- [CrossRef](https://doi.org/10.48550/arXiv.1903.11257)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=S..%2BAhmad&author=L..%2BScheinkman&publication_year=2019&title=How%2BCan%2BWe%2BBe%2BSo%2BDense%3F%2BThe%2BBenefits%2Bof%2BUsing%2BHighly%2BSparse%2BRepresentations.&journal=Arxiv)
- 4
	AlbantakisL. (2017). A Tale of Two Animats: What does it take to have goals?.**Arxiv** \[Preprint\]. 10.48550/arXiv.1705.10854
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/35895330)
	- [CrossRef](https://doi.org/10.48550/arXiv.1705.10854)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=L..%2BAlbantakis&publication_year=2017&title=A%2BTale%2Bof%2BTwo%2BAnimats%3A%2BWhat%2Bdoes%2Bit%2Btake%2Bto%2Bhave%2Bgoals%3F.&journal=Arxiv)
- 5
	AlbantakisL.MarshallW.HoelE.TononiG. (2017). What caused what? A quantitative account of actual causation using dynamical causal networks.**Arxiv** \[Preprint\]. 10.48550/arXiv.1708.06716
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/35895330)
	- [CrossRef](https://doi.org/10.48550/arXiv.1708.06716)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=L..%2BAlbantakis&author=W..%2BMarshall&author=E..%2BHoel&author=G..%2BTononi&publication_year=2017&title=What%2Bcaused%2Bwhat%3F%2BA%2Bquantitative%2Baccount%2Bof%2Bactual%2Bcausation%2Busing%2Bdynamical%2Bcausal%2Bnetworks.&journal=Arxiv)
- 6
	ArsiwallaX. D.MedianoP. A. M.VerschureP. F. M. J. (2017). Spectral Modes of Network Dynamics Reveal Increased Informational Complexity Near Criticality.**Arxiv** \[Preprint\]. 10.48550/arXiv.1707.01446
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/35895330)
	- [CrossRef](https://doi.org/10.48550/arXiv.1707.01446)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=X.%2BD..%2BArsiwalla&author=P.%2BA.%2BM..%2BMediano&author=P.%2BF.%2BM.%2BJ..%2BVerschure&publication_year=2017&title=Spectral%2BModes%2Bof%2BNetwork%2BDynamics%2BReveal%2BIncreased%2BInformational%2BComplexity%2BNear%2BCriticality.&journal=Arxiv)
- 7
	ArsiwallaX. D.VerschureP. F. M. J. (2016). “High Integrated Information in Complex Networks Near Criticality,” in **Artificial Neural Networks and Machine Learning – ICANN 2016**, edsVillaA. E. P.MasulliP.Pons RiveroA. J. (New York, NY: Springer International Publishing), 184–191.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=X.%2BD..%2BArsiwalla&author=P.%2BF.%2BM.%2BJ..%2BVerschure&publication_year=2016&title=High%2BIntegrated%2BInformation%2Bin%2BComplex%2BNetworks%2BNear%2BCriticality&journal=Artificial+Neural+Networks+and+Machine+Learning+%E2%80%93+ICANN+2016&pages=184-191)
- 8
	AtasoyS.DecoG.KringelbachM. L.PearsonJ. (2018). Harmonic Brain Modes: A Unifying Framework for Linking Space and Time in Brain Dynamics.**Neuroscientist** 24277–293. 10.1177/1073858417728032
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/28863720)
	- [CrossRef](https://doi.org/10.1177/1073858417728032)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=S..%2BAtasoy&author=G..%2BDeco&author=M.%2BL..%2BKringelbach&author=J..%2BPearson&publication_year=2018&title=Harmonic%2BBrain%2BModes%3A%2BA%2BUnifying%2BFramework%2Bfor%2BLinking%2BSpace%2Band%2BTime%2Bin%2BBrain%2BDynamics.&journal=Neuroscientist&volume=24&pages=277-293)
- 9
	AtasoyS.DonnellyI.PearsonJ. (2016). Human brain networks function in connectome-specific harmonic waves.**Nat. Commun.**7:10340. 10.1038/ncomms10340
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/26792267)
	- [CrossRef](https://doi.org/10.1038/ncomms10340)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=S..%2BAtasoy&author=I..%2BDonnelly&author=J..%2BPearson&publication_year=2016&title=Human%2Bbrain%2Bnetworks%2Bfunction%2Bin%2Bconnectome-specific%2Bharmonic%2Bwaves.&journal=Nat.+Commun.&volume=7)
- 10
	BaarsB. J.FranklinS.RamsoyT. Z. (2013). Global Workspace Dynamics: Cortical “Binding and Propagation” Enables Conscious Contents.**Front. Psychol.**4:200. 10.3389/fpsyg.2013.00200
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/23974723)
	- [CrossRef](https://doi.org/10.3389/fpsyg.2013.00200)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=B.%2BJ..%2BBaars&author=S..%2BFranklin&author=T.%2BZ..%2BRamsoy&publication_year=2013&title=Global%2BWorkspace%2BDynamics%3A%2BCortical%2B%E2%80%9CBinding%2Band%2BPropagation%E2%80%9D%2BEnables%2BConscious%2BContents.&journal=Front.+Psychol.&volume=4)
- 11
	BadcockP. B.FristonK. J.RamsteadM. J. D. (2019). The hierarchically mechanistic mind: A free-energy formulation of the human psyche.**Phys. Life Rev.**31104–121. 10.1016/j.plrev.2018.10.002
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/30704846)
	- [CrossRef](https://doi.org/10.1016/j.plrev.2018.10.002)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=P.%2BB..%2BBadcock&author=K.%2BJ..%2BFriston&author=M.%2BJ.%2BD..%2BRamstead&publication_year=2019&title=The%2Bhierarchically%2Bmechanistic%2Bmind%3A%2BA%2Bfree-energy%2Bformulation%2Bof%2Bthe%2Bhuman%2Bpsyche.&journal=Phys.+Life+Rev.&volume=31&pages=104-121)
- 12
	BapstV.KeckT.Grabska-BarwińskaA.DonnerC.CubukE. D.SchoenholzS. S.et al (2020). Unveiling the predictive power of static structure in glassy systems.**Nat. Phys.**16448–454. 10.1038/s41567-020-0842-8
	- [CrossRef](https://doi.org/10.1038/s41567-020-0842-8)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=V..%2BBapst&author=T..%2BKeck&author=A..%2BGrabska-Barwi%C5%84ska&author=C..%2BDonner&author=E.%2BD..%2BCubuk&author=S.%2BS..%2BSchoenholz&publication_year=2020&title=Unveiling%2Bthe%2Bpredictive%2Bpower%2Bof%2Bstatic%2Bstructure%2Bin%2Bglassy%2Bsystems.&journal=Nat.+Phys.&volume=16&pages=448-454)
- 13
	BaramA. B.MullerT. H.NiliH.GarvertM.BehrensT. E. J. (2019). Entorhinal and ventromedial prefrontal cortices abstract and generalise the structure of reinforcement learning problems.**Biorxiv** \[Preprint\]. 10.1101/827253
	- [CrossRef](https://doi.org/10.1101/827253)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A.%2BB..%2BBaram&author=T.%2BH..%2BMuller&author=H..%2BNili&author=M..%2BGarvert&author=T.%2BE.%2BJ..%2BBehrens&publication_year=2019&title=Entorhinal%2Band%2Bventromedial%2Bprefrontal%2Bcortices%2Babstract%2Band%2Bgeneralise%2Bthe%2Bstructure%2Bof%2Breinforcement%2Blearning%2Bproblems.&journal=Biorxiv)
- 14
	BarrettA. B.SethA. K. (2011). Practical Measures of Integrated Information for Time-Series Data.**PLoS Comput. Biol.**7:e1001052. 10.1371/journal.pcbi.1001052
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/21283779)
	- [CrossRef](https://doi.org/10.1371/journal.pcbi.1001052)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A.%2BB..%2BBarrett&author=A.%2BK..%2BSeth&publication_year=2011&title=Practical%2BMeasures%2Bof%2BIntegrated%2BInformation%2Bfor%2BTime-Series%2BData.&journal=PLoS+Comput.+Biol.&volume=7)
- 15
	BarsalouL. W. (2010). Grounded cognition: Past, present, and future.**Top. Cogn. Sci.**2716–724. 10.1111/j.1756-8765.2010.01115.x
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/25164052)
	- [CrossRef](https://doi.org/10.1111/j.1756-8765.2010.01115.x)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=L.%2BW..%2BBarsalou&publication_year=2010&title=Grounded%2Bcognition%3A%2BPast%2C%2Bpresent%2C%2Band%2Bfuture.&journal=Top.+Cogn.+Sci.&volume=2&pages=716-724)
- 16
	BastosA. M.UsreyW. M.AdamsR. A.MangunG. R.FriesP.FristonK. J. (2012). Canonical microcircuits for predictive coding.**Neuron** 76695–711. 10.1016/j.neuron.2012.10.038
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/23177956)
	- [CrossRef](https://doi.org/10.1016/j.neuron.2012.10.038)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A.%2BM..%2BBastos&author=W.%2BM..%2BUsrey&author=R.%2BA..%2BAdams&author=G.%2BR..%2BMangun&author=P..%2BFries&author=K.%2BJ..%2BFriston&publication_year=2012&title=Canonical%2Bmicrocircuits%2Bfor%2Bpredictive%2Bcoding.&journal=Neuron&volume=76&pages=695-711)
- 17
	BattagliaP. W.HamrickJ. B.BapstV.Sanchez-GonzalezA.ZambaldiV.MalinowskiM. (2018). Relational inductive biases, deep learning, and graph networks.**Arxiv** \[Preprint\]. 10.48550/arXiv1806.01261
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/35895330)
	- [CrossRef](https://doi.org/10.48550/arXiv1806.01261)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=P.%2BW..%2BBattaglia&author=J.%2BB..%2BHamrick&author=V..%2BBapst&author=A..%2BSanchez-Gonzalez&author=V..%2BZambaldi&author=M..%2BMalinowski&publication_year=2018&title=Relational%2Binductive%2Bbiases%2C%2Bdeep%2Blearning%2C%2Band%2Bgraph%2Bnetworks.&journal=Arxiv)
- 18
	BayneT. (2018). On the axiomatic foundations of the integrated information theory of consciousness.**Neurosci. Conscious.**2018:niy007. 10.1093/nc/niy007
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/30042860)
	- [CrossRef](https://doi.org/10.1093/nc/niy007)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=T..%2BBayne&publication_year=2018&title=On%2Bthe%2Baxiomatic%2Bfoundations%2Bof%2Bthe%2Bintegrated%2Binformation%2Btheory%2Bof%2Bconsciousness.&journal=Neurosci.+Conscious.&volume=2018)
- 19
	BellmundJ. L.DeukerL.Navarro SchröderT.DoellerC. F. (2016). Grid-cell representations in mental simulation.**Elife** 5:e17089. 10.7554/eLife.17089
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/27572056)
	- [CrossRef](https://doi.org/10.7554/eLife.17089)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J.%2BL..%2BBellmund&author=L..%2BDeuker&author=T..%2BNavarro%2BSchr%C3%B6der&author=C.%2BF..%2BDoeller&publication_year=2016&title=Grid-cell%2Brepresentations%2Bin%2Bmental%2Bsimulation.&journal=Elife&volume=5)
- 20
	BellmundJ. L. S.GärdenforsP.MoserE. I.DoellerC. F. (2018). Navigating cognition: Spatial codes for human thinking.**Science** 362:eaat6766. 10.1126/science.aat6766
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/30409861)
	- [CrossRef](https://doi.org/10.1126/science.aat6766)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J.%2BL.%2BS..%2BBellmund&author=P..%2BG%C3%A4rdenfors&author=E.%2BI..%2BMoser&author=C.%2BF..%2BDoeller&publication_year=2018&title=Navigating%2Bcognition%3A%2BSpatial%2Bcodes%2Bfor%2Bhuman%2Bthinking.&journal=Science&volume=362)
- 21
	BengioY. (2017). The Consciousness Prior.**Arxiv** \[Preprint\]. 10.48550/arXiv.1709.08568
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/35895330)
	- [CrossRef](https://doi.org/10.48550/arXiv.1709.08568)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=Y..%2BBengio&publication_year=2017&title=The%2BConsciousness%2BPrior.&journal=Arxiv)
- 22
	BerrouC.GlavieuxA. (1996). Near optimum error correcting coding and decoding: Turbo-codes.**IEEE Trans. Commun.**441261–1271. 10.1109/26.539767
	- [CrossRef](https://doi.org/10.1109/26.539767)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=C..%2BBerrou&author=A..%2BGlavieux&publication_year=1996&title=Near%2Boptimum%2Berror%2Bcorrecting%2Bcoding%2Band%2Bdecoding%3A%2BTurbo-codes.&journal=IEEE+Trans.+Commun.&volume=44&pages=1261-1271)
- 23
	BerrouC.GlavieuxA.ThitimajshimaP. (1993). “Near Shannon limit error-correcting coding and decoding: Turbo-codes. 1,” in **Proceedings of ICC ’93 - IEEE International Conference on Communications**, (Geneva: IEEE), 1064–1070. 10.1109/ICC.1993.397441
	- [CrossRef](https://doi.org/10.1109/ICC.1993.397441)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=C..%2BBerrou&author=A..%2BGlavieux&author=P..%2BThitimajshima&publication_year=1993&title=Near%2BShannon%2Blimit%2Berror-correcting%2Bcoding%2Band%2Bdecoding%3A%2BTurbo-codes.%2B1&journal=Proceedings+of+ICC+%E2%80%9993+-+IEEE+International+Conference+on+Communications&pages=1064-1070)
- 24
	BetzelR. F.FukushimaM.HeY.ZuoX.-N.SpornsO. (2016). Dynamic fluctuations coincide with periods of high and low modularity in resting-state functional brain networks.**NeuroImage** 127287–297. 10.1016/j.neuroimage.2015.12.001
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/26687667)
	- [CrossRef](https://doi.org/10.1016/j.neuroimage.2015.12.001)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=R.%2BF..%2BBetzel&author=M..%2BFukushima&author=Y..%2BHe&author=X.-N..%2BZuo&author=O..%2BSporns&publication_year=2016&title=Dynamic%2Bfluctuations%2Bcoincide%2Bwith%2Bperiods%2Bof%2Bhigh%2Band%2Blow%2Bmodularity%2Bin%2Bresting-state%2Bfunctional%2Bbrain%2Bnetworks.&journal=NeuroImage&volume=127&pages=287-297)
- 25
	BolyM.MassiminiM.TsuchiyaN.PostleB. R.KochC.TononiG. (2017). Are the Neural Correlates of Consciousness in the Front or in the Back of the Cerebral Cortex? Clinical and Neuroimaging Evidence.**J. Neurosci.**379603–9613. 10.1523/JNEUROSCI.3218-16.2017
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/28978697)
	- [CrossRef](https://doi.org/10.1523/JNEUROSCI.3218-16.2017)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M..%2BBoly&author=M..%2BMassimini&author=N..%2BTsuchiya&author=B.%2BR..%2BPostle&author=C..%2BKoch&author=G..%2BTononi&publication_year=2017&title=Are%2Bthe%2BNeural%2BCorrelates%2Bof%2BConsciousness%2Bin%2Bthe%2BFront%2Bor%2Bin%2Bthe%2BBack%2Bof%2Bthe%2BCerebral%2BCortex%3F%2BClinical%2Band%2BNeuroimaging%2BEvidence.&journal=J.+Neurosci.&volume=37&pages=9603-9613)
- 26
	BorD.SchwartzmanD. J.BarrettA. B.SethA. K. (2017). Theta-burst transcranial magnetic stimulation to the prefrontal or parietal cortex does not impair metacognitive visual awareness.**PLoS One** 12:e0171793. 10.1371/journal.pone.0171793
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/28192502)
	- [CrossRef](https://doi.org/10.1371/journal.pone.0171793)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=D..%2BBor&author=D.%2BJ..%2BSchwartzman&author=A.%2BB..%2BBarrett&author=A.%2BK..%2BSeth&publication_year=2017&title=Theta-burst%2Btranscranial%2Bmagnetic%2Bstimulation%2Bto%2Bthe%2Bprefrontal%2Bor%2Bparietal%2Bcortex%2Bdoes%2Bnot%2Bimpair%2Bmetacognitive%2Bvisual%2Bawareness.&journal=PLoS+One&volume=12)
- 27
	BordersW. A.PervaizA. Z.FukamiS.CamsariK. Y.OhnoH.DattaS. (2019). Integer factorization using stochastic magnetic tunnel junctions.**Nature** 573390–393. 10.1038/s41586-019-1557-9
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/31534247)
	- [CrossRef](https://doi.org/10.1038/s41586-019-1557-9)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=W.%2BA..%2BBorders&author=A.%2BZ..%2BPervaiz&author=S..%2BFukami&author=K.%2BY..%2BCamsari&author=H..%2BOhno&author=S..%2BDatta&publication_year=2019&title=Integer%2Bfactorization%2Busing%2Bstochastic%2Bmagnetic%2Btunnel%2Bjunctions.&journal=Nature&volume=573&pages=390-393)
- 28
	BrownR.LauH.LeDouxJ. E. (2019). Understanding the Higher-Order Approach to Consciousness.**Trends Cogn. Sci.**23754–768. 10.1016/j.tics.2019.06.009
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/31375408)
	- [CrossRef](https://doi.org/10.1016/j.tics.2019.06.009)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=R..%2BBrown&author=H..%2BLau&author=J.%2BE..%2BLeDoux&publication_year=2019&title=Understanding%2Bthe%2BHigher-Order%2BApproach%2Bto%2BConsciousness.&journal=Trends+Cogn.+Sci.&volume=23&pages=754-768)
- 29
	BuchsbaumD.BridgersS.Skolnick WeisbergD.GopnikA. (2012). The power of possibility: Causal learning, counterfactual reasoning, and pretend play.**Philos. Trans. R. Soc. B Biol. Sci.**3672202–2212. 10.1098/rstb.2012.0122
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/22734063)
	- [CrossRef](https://doi.org/10.1098/rstb.2012.0122)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=D..%2BBuchsbaum&author=S..%2BBridgers&author=D..%2BSkolnick%2BWeisberg&author=A..%2BGopnik&publication_year=2012&title=The%2Bpower%2Bof%2Bpossibility%3A%2BCausal%2Blearning%2C%2Bcounterfactual%2Breasoning%2C%2Band%2Bpretend%2Bplay.&journal=Philos.+Trans.+R.+Soc.+B+Biol.+Sci.&volume=367&pages=2202-2212)
- 30
	BucknerR. L.KrienenF. M. (2013). The evolution of distributed association networks in the human brain.**Trends Cogn. Sci.**17648–665. 10.1016/j.tics.2013.09.017
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/24210963)
	- [CrossRef](https://doi.org/10.1016/j.tics.2013.09.017)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=R.%2BL..%2BBuckner&author=F.%2BM..%2BKrienen&publication_year=2013&title=The%2Bevolution%2Bof%2Bdistributed%2Bassociation%2Bnetworks%2Bin%2Bthe%2Bhuman%2Bbrain.&journal=Trends+Cogn.+Sci.&volume=17&pages=648-665)
- 31
	BuonomanoD. (2017). **Your Brain Is a Time Machine: The Neuroscience and Physics of Time.**New York, NY: W. W. Norton & Company.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=D..%2BBuonomano&publication_year=2017&journal=Your+Brain+Is+a+Time+Machine%3A+The+Neuroscience+and+Physics+of+Time.)
- 32
	BuzsákiG.TingleyD. (2018). Space and Time: The Hippocampus as a Sequence Generator.**Trends Cogn. Sci.**22853–869. 10.1016/j.tics.2018.07.006
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/30266146)
	- [CrossRef](https://doi.org/10.1016/j.tics.2018.07.006)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=G..%2BBuzs%C3%A1ki&author=D..%2BTingley&publication_year=2018&title=Space%2Band%2BTime%3A%2BThe%2BHippocampus%2Bas%2Ba%2BSequence%2BGenerator.&journal=Trends+Cogn.+Sci.&volume=22&pages=853-869)
- 33
	BuzsákiG.WatsonB. O. (2012). Brain rhythms and neural syntax: Implications for efficient coding of cognitive content and neuropsychiatric disease.**Dialog. Clin. Neurosci.**14345–367. 10.31887/DCNS.2012.14.4/gbuzsaki
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/23393413)
	- [CrossRef](https://doi.org/10.31887/DCNS.2012.14.4/gbuzsaki)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=G..%2BBuzs%C3%A1ki&author=B.%2BO..%2BWatson&publication_year=2012&title=Brain%2Brhythms%2Band%2Bneural%2Bsyntax%3A%2BImplications%2Bfor%2Befficient%2Bcoding%2Bof%2Bcognitive%2Bcontent%2Band%2Bneuropsychiatric%2Bdisease.&journal=Dialog.+Clin.+Neurosci.&volume=14&pages=345-367)
- 34
	CanoltyR. T.GangulyK.KennerleyS. W.CadieuC. F.KoepsellK.WallisJ. D.et al (2010). Oscillatory phase coupling coordinates anatomically dispersed functional cell assemblies.**Proc. Natl. Acad. Sci. U. S. A.**10717356–17361. 10.1073/pnas.1008306107
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/20855620)
	- [CrossRef](https://doi.org/10.1073/pnas.1008306107)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=R.%2BT..%2BCanolty&author=K..%2BGanguly&author=S.%2BW..%2BKennerley&author=C.%2BF..%2BCadieu&author=K..%2BKoepsell&author=J.%2BD..%2BWallis&publication_year=2010&title=Oscillatory%2Bphase%2Bcoupling%2Bcoordinates%2Banatomically%2Bdispersed%2Bfunctional%2Bcell%2Bassemblies.&journal=Proc.+Natl.+Acad.+Sci.+U.+S.+A.&volume=107&pages=17356-17361)
- 35
	Carhart-HarrisR. L.FristonK. J. (2010). The default-mode, ego-functions and free-energy: A neurobiological account of Freudian ideas.**Brain** 1331265–1283. 10.1093/brain/awq010
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/20194141)
	- [CrossRef](https://doi.org/10.1093/brain/awq010)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=R.%2BL..%2BCarhart-Harris&author=K.%2BJ..%2BFriston&publication_year=2010&title=The%2Bdefault-mode%2C%2Bego-functions%2Band%2Bfree-energy%3A%2BA%2Bneurobiological%2Baccount%2Bof%2BFreudian%2Bideas.&journal=Brain&volume=133&pages=1265-1283)
- 36
	CarrollS. (2016). **The Big Picture: On the Origins of Life, Meaning, and the Universe Itself.**London: Penguin Books.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=S..%2BCarroll&publication_year=2016&journal=The+Big+Picture%3A+On+the+Origins+of+Life%2C+Meaning%2C+and+the+Universe+Itself.)
- 37
	CastroS.El-DeredyW.BattagliaD.OrioP. (2020). Cortical ignition dynamics is tightly linked to the core organisation of the human connectome.**PLoS Comput. Biol.**16:e1007686. 10.1371/journal.pcbi.1007686
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/32735580)
	- [CrossRef](https://doi.org/10.1371/journal.pcbi.1007686)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=S..%2BCastro&author=W..%2BEl-Deredy&author=D..%2BBattaglia&author=P..%2BOrio&publication_year=2020&title=Cortical%2Bignition%2Bdynamics%2Bis%2Btightly%2Blinked%2Bto%2Bthe%2Bcore%2Borganisation%2Bof%2Bthe%2Bhuman%2Bconnectome.&journal=PLoS+Comput.+Biol.&volume=16)
- 38
	ÇatalO.VerbelenT.Van de MaeleT.DhoedtB.SafronA. (2021). Robot navigation as hierarchical active inference.**Neural Netw.**142192–204. 10.1016/j.neunet.2021.05.010
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/34022669)
	- [CrossRef](https://doi.org/10.1016/j.neunet.2021.05.010)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=O..%2B%C3%87atal&author=T..%2BVerbelen&author=T..%2BVan%2Bde%2BMaele&author=B..%2BDhoedt&author=A..%2BSafron&publication_year=2021&title=Robot%2Bnavigation%2Bas%2Bhierarchical%2Bactive%2Binference.&journal=Neural+Netw.&volume=142&pages=192-204)
- 39
	ChalmersD. J. (1995). Facing Up to the Problem of Consciousness.**J. Conscious. Stud.**2200–219.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=D.%2BJ..%2BChalmers&publication_year=1995&title=Facing%2BUp%2Bto%2Bthe%2BProblem%2Bof%2BConsciousness.&journal=J.+Conscious.+Stud.&volume=2&pages=200-219)
- 40
	ChalmersD. J. (2018). The Meta-Problem of Consciousness.**J. Conscious. Stud.**256–61.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=D.%2BJ..%2BChalmers&publication_year=2018&title=The%2BMeta-Problem%2Bof%2BConsciousness.&journal=J.+Conscious.+Stud.&volume=25&pages=6-61)
- 41
	ChangA. Y. C.BiehlM.YuY.KanaiR. (2019). Information Closure Theory of Consciousness.**Arxiv** \[Preprint\]. 10.48550/arXiv.1909.13045
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/35895330)
	- [CrossRef](https://doi.org/10.48550/arXiv.1909.13045)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A.%2BY.%2BC..%2BChang&author=M..%2BBiehl&author=Y..%2BYu&author=R..%2BKanai&publication_year=2019&title=Information%2BClosure%2BTheory%2Bof%2BConsciousness.&journal=Arxiv)
- 42
	ChaterN. (2018). **Mind Is Flat: The Remarkable Shallowness of the Improvising Brain.**New Haven: Yale University Press.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=N..%2BChater&publication_year=2018&journal=Mind+Is+Flat%3A+The+Remarkable+Shallowness+of+the+Improvising+Brain.)
- 43
	ChenT.GouW.XieD.XiaoT.YiW.JingJ.et al (2020). Quantum Zeno effects across a parity-time symmetry breaking transition in atomic momentum space.**Arxiv** \[Preprint\]. 10.48550/arXiv.2009.01419
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/35895330)
	- [CrossRef](https://doi.org/10.48550/arXiv.2009.01419)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=T..%2BChen&author=W..%2BGou&author=D..%2BXie&author=T..%2BXiao&author=W..%2BYi&author=J..%2BJing&publication_year=2020&title=Quantum%2BZeno%2Beffects%2Bacross%2Ba%2Bparity-time%2Bsymmetry%2Bbreaking%2Btransition%2Bin%2Batomic%2Bmomentum%2Bspace.&journal=Arxiv)
- 44
	ChernyakN.KangC.KushnirT. (2019). The cultural roots of free will beliefs: How Singaporean and U.S. Children judge and explain possibilities for action in interpersonal contexts.**Dev. Psychol.**55866–876. 10.1037/dev0000670
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/30652885)
	- [CrossRef](https://doi.org/10.1037/dev0000670)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=N..%2BChernyak&author=C..%2BKang&author=T..%2BKushnir&publication_year=2019&title=The%2Bcultural%2Broots%2Bof%2Bfree%2Bwill%2Bbeliefs%3A%2BHow%2BSingaporean%2Band%2BU.S.%2BChildren%2Bjudge%2Band%2Bexplain%2Bpossibilities%2Bfor%2Baction%2Bin%2Binterpersonal%2Bcontexts.&journal=Dev.+Psychol.&volume=55&pages=866-876)
- 45
	CheungB.TerekhovA.ChenY.AgrawalP.OlshausenB. (2019). Superposition of many models into one.**Arxiv** \[Preprint\]. 10.48550/arXiv.1902.05522
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/35895330)
	- [CrossRef](https://doi.org/10.48550/arXiv.1902.05522)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=B..%2BCheung&author=A..%2BTerekhov&author=Y..%2BChen&author=P..%2BAgrawal&author=B..%2BOlshausen&publication_year=2019&title=Superposition%2Bof%2Bmany%2Bmodels%2Binto%2Bone.&journal=Arxiv)
- 46
	CiaunicaA.SafronA.Delafield-ButtJ. (2021). Back to Square One: From Embodied Experiences in Utero to Theories of Consciousness.**Psyarxiv** \[Preprint\]. 10.31234/osf.io/zspm2
	- [CrossRef](https://doi.org/10.31234/osf.io/zspm2)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A..%2BCiaunica&author=A..%2BSafron&author=J..%2BDelafield-Butt&publication_year=2021&title=Back%2Bto%2BSquare%2BOne%3A%2BFrom%2BEmbodied%2BExperiences%2Bin%2BUtero%2Bto%2BTheories%2Bof%2BConsciousness.&journal=Psyarxiv)
- 47
	CisekP. (2007). Cortical mechanisms of action selection: The affordance competition hypothesis.**Philos. Trans. R. Soc. B Biol. Sci.**3621585–1599. 10.1098/rstb.2007.2054
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/17428779)
	- [CrossRef](https://doi.org/10.1098/rstb.2007.2054)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=P..%2BCisek&publication_year=2007&title=Cortical%2Bmechanisms%2Bof%2Baction%2Bselection%3A%2BThe%2Baffordance%2Bcompetition%2Bhypothesis.&journal=Philos.+Trans.+R.+Soc.+B+Biol.+Sci.&volume=362&pages=1585-1599)
- 48
	ClarkA. (2018). Beyond the “Bayesian Blur”: Predictive Processing and the Nature of Subjective Experience.**J. Consciousness Stud.**2571–87.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A..%2BClark&publication_year=2018&title=Beyond%2Bthe%2B%E2%80%9CBayesian%2BBlur%E2%80%9D%3A%2BPredictive%2BProcessing%2Band%2Bthe%2BNature%2Bof%2BSubjective%2BExperience.&journal=J.+Consciousness+Stud.&volume=25&pages=71-87)
- 49
	CoyleB.MillsD.DanosV.KashefiE. (2019). The Born Supremacy: Quantum Advantage and Training of an Ising Born Machine.**Arxiv** \[Preprint\]. 10.48550/arXiv.1904.02214
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/35895330)
	- [CrossRef](https://doi.org/10.48550/arXiv.1904.02214)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=B..%2BCoyle&author=D..%2BMills&author=V..%2BDanos&author=E..%2BKashefi&publication_year=2019&title=The%2BBorn%2BSupremacy%3A%2BQuantum%2BAdvantage%2Band%2BTraining%2Bof%2Ban%2BIsing%2BBorn%2BMachine.&journal=Arxiv)
- 50
	CraigA. D. (2009). Emotional moments across time: A possible neural basis for time perception in the anterior insula.**Philos. Trans. R. Soc. B Biol. Sci.**3641933–1942. 10.1098/rstb.2009.0008
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/19487195)
	- [CrossRef](https://doi.org/10.1098/rstb.2009.0008)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A.%2BD..%2BCraig&publication_year=2009&title=Emotional%2Bmoments%2Bacross%2Btime%3A%2BA%2Bpossible%2Bneural%2Bbasis%2Bfor%2Btime%2Bperception%2Bin%2Bthe%2Banterior%2Binsula.&journal=Philos.+Trans.+R.+Soc.+B+Biol.+Sci.&volume=364&pages=1933-1942)
- 51
	CranmerM.Sanchez-GonzalezA.BattagliaP.XuR.CranmerK.SpergelD.et al (2020). Discovering Symbolic Models from Deep Learning with Inductive Biases.**Arxiv** \[Preprint\]. 10.48550/arXiv.2006.11287
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/35895330)
	- [CrossRef](https://doi.org/10.48550/arXiv.2006.11287)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M..%2BCranmer&author=A..%2BSanchez-Gonzalez&author=P..%2BBattaglia&author=R..%2BXu&author=K..%2BCranmer&author=D..%2BSpergel&publication_year=2020&title=Discovering%2BSymbolic%2BModels%2Bfrom%2BDeep%2BLearning%2Bwith%2BInductive%2BBiases.&journal=Arxiv)
- 52
	CrickF.KochC. (2003). A framework for consciousness.**Nat. Neurosci.**6119–126. 10.1038/nn0203-119
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/12555104)
	- [CrossRef](https://doi.org/10.1038/nn0203-119)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=F..%2BCrick&author=C..%2BKoch&publication_year=2003&title=A%2Bframework%2Bfor%2Bconsciousness.&journal=Nat.+Neurosci.&volume=6&pages=119-126)
- 53
	DabneyW.Kurth-NelsonZ.UchidaN.StarkweatherC. K.HassabisD.MunosR.et al (2020). A distributional code for value in dopamine-based reinforcement learning.**Nature** 577671–675. 10.1038/s41586-019-1924-6
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/31942076)
	- [CrossRef](https://doi.org/10.1038/s41586-019-1924-6)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=W..%2BDabney&author=Z..%2BKurth-Nelson&author=N..%2BUchida&author=C.%2BK..%2BStarkweather&author=D..%2BHassabis&author=R..%2BMunos&publication_year=2020&title=A%2Bdistributional%2Bcode%2Bfor%2Bvalue%2Bin%2Bdopamine-based%2Breinforcement%2Blearning.&journal=Nature&volume=577&pages=671-675)
- 54
	DayanP.HintonG. E.NealR. M.ZemelR. S. (1995). The Helmholtz machine.**Neural Comput.**7889–904.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=P..%2BDayan&author=G.%2BE..%2BHinton&author=R.%2BM..%2BNeal&author=R.%2BS..%2BZemel&publication_year=1995&title=The%2BHelmholtz%2Bmachine.&journal=Neural+Comput.&volume=7&pages=889-904)
- 55
	de AbrilI. M.KanaiR. (2018). A unified strategy for implementing curiosity and empowerment driven reinforcement learning.**Arxiv** \[Preprint\]. 10.48550/arXiv.1806.06505
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/35895330)
	- [CrossRef](https://doi.org/10.48550/arXiv.1806.06505)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=I.%2BM..%2Bde%2BAbril&author=R..%2BKanai&publication_year=2018&title=A%2Bunified%2Bstrategy%2Bfor%2Bimplementing%2Bcuriosity%2Band%2Bempowerment%2Bdriven%2Breinforcement%2Blearning.&journal=Arxiv)
- 56
	De KockL. (2016). Helmholtz’s Kant revisited (Once more). The all-pervasive nature of Helmholtz’s struggle with Kant’s Anschauung.**Stud. History Philos. Sci.**5620–32. 10.1016/j.shpsa.2015.10.009
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/27083081)
	- [CrossRef](https://doi.org/10.1016/j.shpsa.2015.10.009)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=L..%2BDe%2BKock&publication_year=2016&title=Helmholtz%E2%80%99s%2BKant%2Brevisited%2B%28Once%2Bmore%29.%2BThe%2Ball-pervasive%2Bnature%2Bof%2BHelmholtz%E2%80%99s%2Bstruggle%2Bwith%2BKant%E2%80%99s%2BAnschauung.&journal=Stud.+History+Philos.+Sci.&volume=56&pages=20-32)
- 57
	DecoG.KringelbachM. L. (2016). Metastability and Coherence: Extending the Communication through Coherence Hypothesis Using A Whole-Brain Computational Perspective.**Trends Neurosci.**39125–135. 10.1016/j.tins.2016.01.001
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/26833259)
	- [CrossRef](https://doi.org/10.1016/j.tins.2016.01.001)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=G..%2BDeco&author=M.%2BL..%2BKringelbach&publication_year=2016&title=Metastability%2Band%2BCoherence%3A%2BExtending%2Bthe%2BCommunication%2Bthrough%2BCoherence%2BHypothesis%2BUsing%2BA%2BWhole-Brain%2BComputational%2BPerspective.&journal=Trends+Neurosci.&volume=39&pages=125-135)
- 58
	DehaeneS. (2014). **Consciousness and the Brain: Deciphering How the Brain Codes Our Thoughts.**New York, NY: Viking.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=S..%2BDehaene&publication_year=2014&journal=Consciousness+and+the+Brain%3A+Deciphering+How+the+Brain+Codes+Our+Thoughts.)
- 59
	DennettD. (1992). **Consciousness Explained**, 1st Edn. New York, NY: Back Bay Books.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=D..%2BDennett&publication_year=1992&journal=Consciousness+Explained)
- 60
	DennettD. C. (2018). Facing up to the hard question of consciousness.**Philos. Trans. R. Soc. B Biol. Sci.**373:20170342. 10.1098/rstb.2017.0342
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/30061456)
	- [CrossRef](https://doi.org/10.1098/rstb.2017.0342)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=D.%2BC..%2BDennett&publication_year=2018&title=Facing%2Bup%2Bto%2Bthe%2Bhard%2Bquestion%2Bof%2Bconsciousness.&journal=Philos.+Trans.+R.+Soc.+B+Biol.+Sci.&volume=373)
- 61
	DoerigA.SchurgerA.HessK.HerzogM. H. (2019). The unfolding argument: Why IIT and other causal structure theories cannot explain consciousness.**Conscious. Cogn.**7249–59. 10.1016/j.concog.2019.04.002
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/31078047)
	- [CrossRef](https://doi.org/10.1016/j.concog.2019.04.002)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A..%2BDoerig&author=A..%2BSchurger&author=K..%2BHess&author=M.%2BH..%2BHerzog&publication_year=2019&title=The%2Bunfolding%2Bargument%3A%2BWhy%2BIIT%2Band%2Bother%2Bcausal%2Bstructure%2Btheories%2Bcannot%2Bexplain%2Bconsciousness.&journal=Conscious.+Cogn.&volume=72&pages=49-59)
- 62
	DohmatobE.DumasG.BzdokD. (2020). Dark control: The default mode network as a reinforcement learning agent.**Hum. Brain Mapp.**413318–3341. 10.1002/hbm.25019
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/32500968)
	- [CrossRef](https://doi.org/10.1002/hbm.25019)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=E..%2BDohmatob&author=G..%2BDumas&author=D..%2BBzdok&publication_year=2020&title=Dark%2Bcontrol%3A%2BThe%2Bdefault%2Bmode%2Bnetwork%2Bas%2Ba%2Breinforcement%2Blearning%2Bagent.&journal=Hum.+Brain+Mapp.&volume=41&pages=3318-3341)
- 63
	EguchiA.HoriiT.NagaiT.KanaiR.OizumiM. (2020). An Information Theoretic Approach to Reveal the Formation of Shared Representations.**Front. Comput. Neurosci.**14:1. 10.3389/fncom.2020.00001
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/32082133)
	- [CrossRef](https://doi.org/10.3389/fncom.2020.00001)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A..%2BEguchi&author=T..%2BHorii&author=T..%2BNagai&author=R..%2BKanai&author=M..%2BOizumi&publication_year=2020&title=An%2BInformation%2BTheoretic%2BApproach%2Bto%2BReveal%2Bthe%2BFormation%2Bof%2BShared%2BRepresentations.&journal=Front.+Comput.+Neurosci.&volume=14)
- 64
	EverhardtA. S.DamerioS.ZornJ. A.ZhouS.DomingoN.CatalanG.et al (2019). Periodicity-Doubling Cascades: Direct Observation in Ferroelastic Materials.**Phys. Rev. Lett.**123:087603. 10.1103/PhysRevLett.123.087603
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/31491229)
	- [CrossRef](https://doi.org/10.1103/PhysRevLett.123.087603)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A.%2BS..%2BEverhardt&author=S..%2BDamerio&author=J.%2BA..%2BZorn&author=S..%2BZhou&author=N..%2BDomingo&author=G..%2BCatalan&publication_year=2019&title=Periodicity-Doubling%2BCascades%3A%2BDirect%2BObservation%2Bin%2BFerroelastic%2BMaterials.&journal=Phys.+Rev.+Lett.&volume=123)
- 65
	FaulL.St. JacquesP. L.DeRosaJ. T.ParikhN.De BrigardF. (2020). Differential contribution of anterior and posterior midline regions during mental simulation of counterfactual and perspective shifts in autobiographical memories.**NeuroImage** 215:116843. 10.1016/j.neuroimage.2020.116843
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/32289455)
	- [CrossRef](https://doi.org/10.1016/j.neuroimage.2020.116843)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=L..%2BFaul&author=P.%2BL..%2BSt.%2BJacques&author=J.%2BT..%2BDeRosa&author=N..%2BParikh&author=F..%2BDe%2BBrigard&publication_year=2020&title=Differential%2Bcontribution%2Bof%2Banterior%2Band%2Bposterior%2Bmidline%2Bregions%2Bduring%2Bmental%2Bsimulation%2Bof%2Bcounterfactual%2Band%2Bperspective%2Bshifts%2Bin%2Bautobiographical%2Bmemories.&journal=NeuroImage&volume=215)
- 66
	FriesP. (2015). Rhythms For Cognition: Communication Through Coherence.**Neuron** 88220–235. 10.1016/j.neuron.2015.09.034
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/26447583)
	- [CrossRef](https://doi.org/10.1016/j.neuron.2015.09.034)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=P..%2BFries&publication_year=2015&title=Rhythms%2BFor%2BCognition%3A%2BCommunication%2BThrough%2BCoherence.&journal=Neuron&volume=88&pages=220-235)
- 67
	FristonK. J. (2018). Am I Self-Conscious? (Or Does Self-Organization Entail Self-Consciousness?).**Front. Psychol.**9:579. 10.3389/fpsyg.2018.00579
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/29740369)
	- [CrossRef](https://doi.org/10.3389/fpsyg.2018.00579)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=K.%2BJ..%2BFriston&publication_year=2018&title=Am%2BI%2BSelf-Conscious%3F%2B%28Or%2BDoes%2BSelf-Organization%2BEntail%2BSelf-Consciousness%3F%29.&journal=Front.+Psychol.&volume=9)
- 68
	FristonK. J. (2019). A free energy principle for a particular physics.**Arxiv** \[Preprint\]. 10.48550/arXiv.1906.10184
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/35895330)
	- [CrossRef](https://doi.org/10.48550/arXiv.1906.10184)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=K.%2BJ..%2BFriston&publication_year=2019&title=A%2Bfree%2Benergy%2Bprinciple%2Bfor%2Ba%2Bparticular%2Bphysics.&journal=Arxiv)
- 69
	FristonK. J.FitzGeraldT.RigoliF.SchwartenbeckP.PezzuloG. (2017a). Active Inference: A Process Theory.**Neural Comput.**291–49. 10.1162/NECO\_a\_00912
	- [CrossRef](https://doi.org/10.1162/NECO_a_00912)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=K.%2BJ..%2BFriston&author=T..%2BFitzGerald&author=F..%2BRigoli&author=P..%2BSchwartenbeck&author=G..%2BPezzulo&publication_year=2017a&title=Active%2BInference%3A%2BA%2BProcess%2BTheory.&journal=Neural+Comput.&volume=29&pages=1-49)
- 70
	FristonK. J.ParrT.de VriesB. (2017b). The graphical brain: Belief propagation and active inference.**Netw. Neurosci.**1381–414. 10.1162/NETN\_a\_00018
	- [CrossRef](https://doi.org/10.1162/NETN_a_00018)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=K.%2BJ..%2BFriston&author=T..%2BParr&author=B..%2Bde%2BVries&publication_year=2017b&title=The%2Bgraphical%2Bbrain%3A%2BBelief%2Bpropagation%2Band%2Bactive%2Binference.&journal=Netw.+Neurosci.&volume=1&pages=381-414)
- 71
	FristonK. J.WieseW.HobsonJ. A. (2020). Sentience and the Origins of Consciousness: From Cartesian Duality to Markovian Monism.**Entropy** 22:516. 10.3390/e22050516
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/33286288)
	- [CrossRef](https://doi.org/10.3390/e22050516)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=K.%2BJ..%2BFriston&author=W..%2BWiese&author=J.%2BA..%2BHobson&publication_year=2020&title=Sentience%2Band%2Bthe%2BOrigins%2Bof%2BConsciousness%3A%2BFrom%2BCartesian%2BDuality%2Bto%2BMarkovian%2BMonism.&journal=Entropy&volume=22)
- 72
	FruchartM.HanaiR.LittlewoodP. B.VitelliV. (2021). Non-reciprocal phase transitions.**Nature** 592363–369. 10.1038/s41586-021-03375-9
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/33854249)
	- [CrossRef](https://doi.org/10.1038/s41586-021-03375-9)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M..%2BFruchart&author=R..%2BHanai&author=P.%2BB..%2BLittlewood&author=V..%2BVitelli&publication_year=2021&title=Non-reciprocal%2Bphase%2Btransitions.&journal=Nature&volume=592&pages=363-369)
- 73
	GaoZ.DavisC.ThomasA. M.EconomoM. N.AbregoA. M.SvobodaK.et al (2018). A cortico-cerebellar loop for motor planning.**Nature** 563113–116. 10.1038/s41586-018-0633-x
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/30333626)
	- [CrossRef](https://doi.org/10.1038/s41586-018-0633-x)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=Z..%2BGao&author=C..%2BDavis&author=A.%2BM..%2BThomas&author=M.%2BN..%2BEconomo&author=A.%2BM..%2BAbrego&author=K..%2BSvoboda&publication_year=2018&title=A%2Bcortico-cerebellar%2Bloop%2Bfor%2Bmotor%2Bplanning.&journal=Nature&volume=563&pages=113-116)
- 74
	GazzanigaM. S. (2018). **The Consciousness Instinct: Unraveling the Mystery of How the Brain Makes the Mind.**New York, NY: Farrar, Straus and Giroux.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M.%2BS..%2BGazzaniga&publication_year=2018&journal=The+Consciousness+Instinct%3A+Unraveling+the+Mystery+of+How+the+Brain+Makes+the+Mind.)
- 75
	GentnerD. (2010). Bootstrapping the Mind: Analogical Processes and Symbol Systems.**Cogn. Sci.**34752–775. 10.1111/j.1551-6709.2010.01114.x
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/21564235)
	- [CrossRef](https://doi.org/10.1111/j.1551-6709.2010.01114.x)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=D..%2BGentner&publication_year=2010&title=Bootstrapping%2Bthe%2BMind%3A%2BAnalogical%2BProcesses%2Band%2BSymbol%2BSystems.&journal=Cogn.+Sci.&volume=34&pages=752-775)
- 76
	GeorgeD.Lázaro-GredillaM.LehrachW.DedieuA.ZhouG. (2020). A detailed mathematical theory of thalamic and cortical microcircuits based on inference in a generative vision model.**Biorxiv** \[Preprint\]. 10.1101/2020.09.09.290601
	- [CrossRef](https://doi.org/10.1101/2020.09.09.290601)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=D..%2BGeorge&author=M..%2BL%C3%A1zaro-Gredilla&author=W..%2BLehrach&author=A..%2BDedieu&author=G..%2BZhou&publication_year=2020&title=A%2Bdetailed%2Bmathematical%2Btheory%2Bof%2Bthalamic%2Band%2Bcortical%2Bmicrocircuits%2Bbased%2Bon%2Binference%2Bin%2Ba%2Bgenerative%2Bvision%2Bmodel.&journal=Biorxiv)
- 77
	GershmanS. J. (2019). The Generative Adversarial Brain.**Front. Art. Intell.**2:18. 10.3389/frai.2019.00018
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/33733107)
	- [CrossRef](https://doi.org/10.3389/frai.2019.00018)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=S.%2BJ..%2BGershman&publication_year=2019&title=The%2BGenerative%2BAdversarial%2BBrain.&journal=Front.+Art.+Intell.&volume=2)
- 78
	GinsburgS.JablonkaE. (2019). **The Evolution of the Sensitive Soul: Learning and the Origins of Consciousness.**Cambridge, MA: MIT Press.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=S..%2BGinsburg&author=E..%2BJablonka&publication_year=2019&journal=The+Evolution+of+the+Sensitive+Soul%3A+Learning+and+the+Origins+of+Consciousness.)
- 79
	Godfrey-SmithP. (2016). **Other Minds: The Octopus, the Sea, and the Deep Origins of Consciousness.**New York, NY: Farrar, Straus and Giroux.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=P..%2BGodfrey-Smith&publication_year=2016&journal=Other+Minds%3A+The+Octopus%2C+the+Sea%2C+and+the+Deep+Origins+of+Consciousness.)
- 80
	GolloL. L.MirassoC.SpornsO.BreakspearM. (2014). Mechanisms of zero-lag synchronization in cortical motifs.**PLoS Comput. Biol.**10:e1003548. 10.1371/journal.pcbi.1003548
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/24763382)
	- [CrossRef](https://doi.org/10.1371/journal.pcbi.1003548)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=L.%2BL..%2BGollo&author=C..%2BMirasso&author=O..%2BSporns&author=M..%2BBreakspear&publication_year=2014&title=Mechanisms%2Bof%2Bzero-lag%2Bsynchronization%2Bin%2Bcortical%2Bmotifs.&journal=PLoS+Comput.+Biol.&volume=10)
- 81
	GravesA.WayneG.DanihelkaI. (2014). Neural turing machines.**Arxiv** \[Preprint\]. 10.48550/arXiv.1410.5401
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/35895330)
	- [CrossRef](https://doi.org/10.48550/arXiv.1410.5401)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A..%2BGraves&author=G..%2BWayne&author=I..%2BDanihelka&publication_year=2014&title=Neural%2Bturing%2Bmachines.&journal=Arxiv)
- 82
	GrazianoM. S. A. (2018). The temporoparietal junction and awareness.**Neurosci. Conscious.**2018:niy005. 10.1093/nc/niy005
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/30042858)
	- [CrossRef](https://doi.org/10.1093/nc/niy005)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M.%2BS.%2BA..%2BGraziano&publication_year=2018&title=The%2Btemporoparietal%2Bjunction%2Band%2Bawareness.&journal=Neurosci.+Conscious.&volume=2018)
- 83
	GrazianoM. S. A. (2019). **Rethinking consciousness: A scientific theory of subjective experience**, 1st Edn. New York, NY: W W Norton & Company.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M.%2BS.%2BA..%2BGraziano&publication_year=2019&journal=Rethinking+consciousness%3A+A+scientific+theory+of+subjective+experience)
- 84
	GreffK.van SteenkisteS.SchmidhuberJ. (2020). On the Binding Problem in Artificial Neural Networks.**Arxiv** \[Preprint\]. 10.48550/arXiv.2012.05208
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/35895330)
	- [CrossRef](https://doi.org/10.48550/arXiv.2012.05208)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=K..%2BGreff&author=S..%2Bvan%2BSteenkiste&author=J..%2BSchmidhuber&publication_year=2020&title=On%2Bthe%2BBinding%2BProblem%2Bin%2BArtificial%2BNeural%2BNetworks.&journal=Arxiv)
- 85
	GuilletS.RogetM.ArrighiP.MolfettaG. D. (2019). The Grover search as a naturally occurring phenomenon.**Arxiv** \[Preprint\]. 10.48550/arXiv.1908.11213
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/35895330)
	- [CrossRef](https://doi.org/10.48550/arXiv.1908.11213)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=S..%2BGuillet&author=M..%2BRoget&author=P..%2BArrighi&author=G.%2BD..%2BMolfetta&publication_year=2019&title=The%2BGrover%2Bsearch%2Bas%2Ba%2Bnaturally%2Boccurring%2Bphenomenon.&journal=Arxiv)
- 86
	HaD.SchmidhuberJ. (2018). World Models.**Arxiv** \[Preprint\]. 10.48550/ArXiv:1803.10122
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/35895330)
	- [CrossRef](https://doi.org/10.48550/ArXiv:1803.10122)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=D..%2BHa&author=J..%2BSchmidhuber&publication_year=2018&title=World%2BModels.&journal=Arxiv)
- 87
	HaladjianH. H.MontemayorC. (2016). Artificial consciousness and the consciousness-attention dissociation.**Conscious. Cogn.**45210–225. 10.1016/j.concog.2016.08.011
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/27656787)
	- [CrossRef](https://doi.org/10.1016/j.concog.2016.08.011)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=H.%2BH..%2BHaladjian&author=C..%2BMontemayor&publication_year=2016&title=Artificial%2Bconsciousness%2Band%2Bthe%2Bconsciousness-attention%2Bdissociation.&journal=Conscious.+Cogn.&volume=45&pages=210-225)
- 88
	HassabisD.KumaranD.SummerfieldC.BotvinickM. (2017). Neuroscience-Inspired Artificial Intelligence.**Neuron** 95245–258. 10.1016/j.neuron.2017.06.011
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/28728020)
	- [CrossRef](https://doi.org/10.1016/j.neuron.2017.06.011)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=D..%2BHassabis&author=D..%2BKumaran&author=C..%2BSummerfield&author=M..%2BBotvinick&publication_year=2017&title=Neuroscience-Inspired%2BArtificial%2BIntelligence.&journal=Neuron&volume=95&pages=245-258)
- 89
	HassabisD.SprengR. N.RusuA. A.RobbinsC. A.MarR. A.SchacterD. L. (2014). Imagine All the People: How the Brain Creates and Uses Personality Models to Predict Behavior.**Cerebr. Cortex** 241979–1987. 10.1093/cercor/bht042
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/23463340)
	- [CrossRef](https://doi.org/10.1093/cercor/bht042)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=D..%2BHassabis&author=R.%2BN..%2BSpreng&author=A.%2BA..%2BRusu&author=C.%2BA..%2BRobbins&author=R.%2BA..%2BMar&author=D.%2BL..%2BSchacter&publication_year=2014&title=Imagine%2BAll%2Bthe%2BPeople%3A%2BHow%2Bthe%2BBrain%2BCreates%2Band%2BUses%2BPersonality%2BModels%2Bto%2BPredict%2BBehavior.&journal=Cerebr.+Cortex&volume=24&pages=1979-1987)
- 90
	HaunA. (2020). What is visible across the visual field?**Psyarxiv** \[Preprint\]. 10.31234/osf.io/wdpu7
	- [CrossRef](https://doi.org/10.31234/osf.io/wdpu7)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A..%2BHaun&publication_year=2020&title=What%2Bis%2Bvisible%2Bacross%2Bthe%2Bvisual%2Bfield%3F&journal=Psyarxiv)
- 91
	HaunA.TononiG. (2019). Why Does Space Feel the Way it Does? Towards a Principled Account of Spatial Experience.**Entropy** 21:1160. 10.3390/e21121160
	- [CrossRef](https://doi.org/10.3390/e21121160)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A..%2BHaun&author=G..%2BTononi&publication_year=2019&title=Why%2BDoes%2BSpace%2BFeel%2Bthe%2BWay%2Bit%2BDoes%3F%2BTowards%2Ba%2BPrincipled%2BAccount%2Bof%2BSpatial%2BExperience.&journal=Entropy&volume=21)
- 92
	HawkinsJ.BlakesleeS. (2004). **On Intelligence* (Adapted)*. New York, NY: Times Books.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J..%2BHawkins&author=S..%2BBlakeslee&publication_year=2004&journal=On+Intelligence+%28Adapted%29)
- 93
	HayekF. A. (1952). **The Sensory Order: An Inquiry into the Foundations of Theoretical Psychology.**Chicago, IL: University Of Chicago Press.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=F.%2BA..%2BHayek&publication_year=1952&journal=The+Sensory+Order%3A+An+Inquiry+into+the+Foundations+of+Theoretical+Psychology.)
- 94
	HeegerD. J. (2017). Theory of cortical function.**Proc. Natl. Acad. Sci. U. S. A.**1141773–1782. 10.1073/pnas.1619788114
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/28167793)
	- [CrossRef](https://doi.org/10.1073/pnas.1619788114)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=D.%2BJ..%2BHeeger&publication_year=2017&title=Theory%2Bof%2Bcortical%2Bfunction.&journal=Proc.+Natl.+Acad.+Sci.+U.+S.+A.&volume=114&pages=1773-1782)
- 95
	HerzogM. H.KammerT.ScharnowskiF. (2016). Time Slices: What Is the Duration of a Percept?**PLoS Biol.**14:e1002433. 10.1371/journal.pbio.1002433
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/27070777)
	- [CrossRef](https://doi.org/10.1371/journal.pbio.1002433)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M.%2BH..%2BHerzog&author=T..%2BKammer&author=F..%2BScharnowski&publication_year=2016&title=Time%2BSlices%3A%2BWhat%2BIs%2Bthe%2BDuration%2Bof%2Ba%2BPercept%3F&journal=PLoS+Biol.&volume=14)
- 96
	HeuvelM. P.van den KahnR. S.GoñiJ.SpornsO. (2012). High-cost, high-capacity backbone for global brain communication.**Proc. Natl. Acad. Sci. U. S. A.**10911372–11377. 10.1073/pnas.1203593109
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/22711833)
	- [CrossRef](https://doi.org/10.1073/pnas.1203593109)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M.%2BP..%2BHeuvel&author=R.%2BS..%2Bvan%2Bden%2BKahn&author=J..%2BGo%C3%B1i&author=O..%2BSporns&publication_year=2012&title=High-cost%2C%2Bhigh-capacity%2Bbackbone%2Bfor%2Bglobal%2Bbrain%2Bcommunication.&journal=Proc.+Natl.+Acad.+Sci.+U.+S.+A.&volume=109&pages=11372-11377)
- 97
	HillsT. T.ToddP. M.GoldstoneR. L. (2010). The Central Executive as a Search Process: Priming Exploration and Exploitation across Domains.**J. Exp. Psychol. Gen.**139590–609. 10.1037/a0020666
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/21038983)
	- [CrossRef](https://doi.org/10.1037/a0020666)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=T.%2BT..%2BHills&author=P.%2BM..%2BTodd&author=R.%2BL..%2BGoldstone&publication_year=2010&title=The%2BCentral%2BExecutive%2Bas%2Ba%2BSearch%2BProcess%3A%2BPriming%2BExploration%2Band%2BExploitation%2Bacross%2BDomains.&journal=J.+Exp.+Psychol.+Gen.&volume=139&pages=590-609)
- 98
	HoelE. P. (2017). When the map is better than the territory.**Entropy** 19:188. 10.3390/e19050188
	- [CrossRef](https://doi.org/10.3390/e19050188)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=E.%2BP..%2BHoel&publication_year=2017&title=When%2Bthe%2Bmap%2Bis%2Bbetter%2Bthan%2Bthe%2Bterritory.&journal=Entropy&volume=19)
- 99
	HoelE. P.AlbantakisL.MarshallW.TononiG. (2016). Can the macro beat the micro? Integrated information across spatiotemporal scales.**Neurosci. Conscious.**2016:niw012. 10.1093/nc/niw012
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/30788150)
	- [CrossRef](https://doi.org/10.1093/nc/niw012)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=E.%2BP..%2BHoel&author=L..%2BAlbantakis&author=W..%2BMarshall&author=G..%2BTononi&publication_year=2016&title=Can%2Bthe%2Bmacro%2Bbeat%2Bthe%2Bmicro%3F%2BIntegrated%2Binformation%2Bacross%2Bspatiotemporal%2Bscales.&journal=Neurosci.+Conscious.&volume=2016)
- 100
	HoffmanD. D.PrakashC. (2014). Objects of consciousness.**Front. Psychol.**5:577. 10.3389/fpsyg.2014.00577
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/24987382)
	- [CrossRef](https://doi.org/10.3389/fpsyg.2014.00577)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=D.%2BD..%2BHoffman&author=C..%2BPrakash&publication_year=2014&title=Objects%2Bof%2Bconsciousness.&journal=Front.+Psychol.&volume=5)
- 101
	HoffmannH.PaytonD. W. (2018). Optimization by Self-Organized Criticality.**Sci. Rep.**8:2358. 10.1038/s41598-018-20275-7
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/29402956)
	- [CrossRef](https://doi.org/10.1038/s41598-018-20275-7)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=H..%2BHoffmann&author=D.%2BW..%2BPayton&publication_year=2018&title=Optimization%2Bby%2BSelf-Organized%2BCriticality.&journal=Sci.+Rep.&volume=8)
- 102
	HofstadterD. R. (1979). **Gödel, Escher, Bach: An Eternal Golden Braid* (20 Anv)*. New York, NY: Basic Books.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=D.%2BR..%2BHofstadter&publication_year=1979&journal=G%C3%B6del%2C+Escher%2C+Bach%3A+An+Eternal+Golden+Braid+%2820+Anv%29)
- 103
	HofstadterD. R. (2007). **I Am a Strange Loop.**New York, NY: Basic Books.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=D.%2BR..%2BHofstadter&publication_year=2007&journal=I+Am+a+Strange+Loop.)
- 104
	HonkanenA.AddenA.FreitasJ.daS.HeinzeS. (2019). The insect central complex and the neural basis of navigational strategies.**J. Exp. Biol.**222:jeb188854. 10.1242/jeb.188854
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/30728235)
	- [CrossRef](https://doi.org/10.1242/jeb.188854)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A..%2BHonkanen&author=A..%2BAdden&author=J..%2BFreitas&author=S..%2Bda&author=S..%2BHeinze&publication_year=2019&title=The%2Binsect%2Bcentral%2Bcomplex%2Band%2Bthe%2Bneural%2Bbasis%2Bof%2Bnavigational%2Bstrategies.&journal=J.+Exp.+Biol.&volume=222)
- 105
	HoukJ. C.BastianenC.FanslerD.FishbachA.FraserD.ReberP. J.et al (2007). Action selection and refinement in subcortical loops through basal ganglia and cerebellum.**Philos. Trans. R. Soc. Lond. Series B Biol. Sci.**3621573–1583. 10.1098/rstb.2007.2063
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/17428771)
	- [CrossRef](https://doi.org/10.1098/rstb.2007.2063)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J.%2BC..%2BHouk&author=C..%2BBastianen&author=D..%2BFansler&author=A..%2BFishbach&author=D..%2BFraser&author=P.%2BJ..%2BReber&publication_year=2007&title=Action%2Bselection%2Band%2Brefinement%2Bin%2Bsubcortical%2Bloops%2Bthrough%2Bbasal%2Bganglia%2Band%2Bcerebellum.&journal=Philos.+Trans.+R.+Soc.+Lond.+Series+B+Biol.+Sci.&volume=362&pages=1573-1583)
- 106
	HoutM. C.PapeshM. H.GoldingerS. D. (2013). Multidimensional scaling. Wiley Interdisciplinary Reviews.**Cogn. Sci.**493–103. 10.1002/wcs.1203
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/23359318)
	- [CrossRef](https://doi.org/10.1002/wcs.1203)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M.%2BC..%2BHout&author=M.%2BH..%2BPapesh&author=S.%2BD..%2BGoldinger&publication_year=2013&title=Multidimensional%2Bscaling.%2BWiley%2BInterdisciplinary%2BReviews.&journal=Cogn.+Sci.&volume=4&pages=93-103)
- 107
	HuF.KamigakiT.ZhangZ.ZhangS.DanU.DanY. (2019). Prefrontal Corticotectal Neurons Enhance Visual Processing through the Superior Colliculus and Pulvinar Thalamus.**Neuron** 1041141–1152.e4. 10.1016/j.neuron.2019.09.019
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/31668485)
	- [CrossRef](https://doi.org/10.1016/j.neuron.2019.09.019)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=F..%2BHu&author=T..%2BKamigaki&author=Z..%2BZhang&author=S..%2BZhang&author=U..%2BDan&author=Y..%2BDan&publication_year=2019&title=Prefrontal%2BCorticotectal%2BNeurons%2BEnhance%2BVisual%2BProcessing%2Bthrough%2Bthe%2BSuperior%2BColliculus%2Band%2BPulvinar%2BThalamus.&journal=Neuron&volume=104&pages=1141-1152.e4)
- 108
	HumphriesM. D.PrescottT. J. (2010). The ventral basal ganglia, a selection mechanism at the crossroads of space, strategy, and reward.**Progress Neurobiol.**90385–417. 10.1016/j.pneurobio.2009.11.003
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/19941931)
	- [CrossRef](https://doi.org/10.1016/j.pneurobio.2009.11.003)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M.%2BD..%2BHumphries&author=T.%2BJ..%2BPrescott&publication_year=2010&title=The%2Bventral%2Bbasal%2Bganglia%2C%2Ba%2Bselection%2Bmechanism%2Bat%2Bthe%2Bcrossroads%2Bof%2Bspace%2C%2Bstrategy%2C%2Band%2Breward.&journal=Progress+Neurobiol.&volume=90&pages=385-417)
- 109
	IslerJ. R.StarkR. I.GrieveP. G.WelchM. G.MyersM. M. (2018). Integrated information in the EEG of preterm infants increases with family nurture intervention, age, and conscious state.**PLoS One** 13:e0206237. 10.1371/journal.pone.0206237
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/30356312)
	- [CrossRef](https://doi.org/10.1371/journal.pone.0206237)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J.%2BR..%2BIsler&author=R.%2BI..%2BStark&author=P.%2BG..%2BGrieve&author=M.%2BG..%2BWelch&author=M.%2BM..%2BMyers&publication_year=2018&title=Integrated%2Binformation%2Bin%2Bthe%2BEEG%2Bof%2Bpreterm%2Binfants%2Bincreases%2Bwith%2Bfamily%2Bnurture%2Bintervention%2C%2Bage%2C%2Band%2Bconscious%2Bstate.&journal=PLoS+One&volume=13)
- 110
	IsmaelJ. (2016). **How Physics Makes Us Free.**Oxford: Oxford University Press.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J..%2BIsmael&publication_year=2016&journal=How+Physics+Makes+Us+Free.)
- 111
	JaynesJ. (1976). **The Origin of Consciousness in the Breakdown of the Bicameral Mind.**Boston: Houghton Mifflin Harcourt.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J..%2BJaynes&publication_year=1976&journal=The+Origin+of+Consciousness+in+the+Breakdown+of+the+Bicameral+Mind.)
- 112
	JoslynC. (2000). Levels of control and closure in complex semiotic systems.**Ann. N. Y. Acad. Sci.**90167–74.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=C..%2BJoslyn&publication_year=2000&title=Levels%2Bof%2Bcontrol%2Band%2Bclosure%2Bin%2Bcomplex%2Bsemiotic%2Bsystems.&journal=Ann.+N.+Y.+Acad.+Sci.&volume=901&pages=67-74)
- 113
	KaplanR.FristonK. J. (2018). Planning and navigation as active inference.**Biol. Cybern.**112323–343. 10.1007/s00422-018-0753-2
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/29572721)
	- [CrossRef](https://doi.org/10.1007/s00422-018-0753-2)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=R..%2BKaplan&author=K.%2BJ..%2BFriston&publication_year=2018&title=Planning%2Band%2Bnavigation%2Bas%2Bactive%2Binference.&journal=Biol.+Cybern.&volume=112&pages=323-343)
- 114
	KieferA. B. (2020). Psychophysical identity and free energy.**J. R. Soc. Interface** 17:20200370. 10.1098/rsif.2020.0370
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/32752995)
	- [CrossRef](https://doi.org/10.1098/rsif.2020.0370)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A.%2BB..%2BKiefer&publication_year=2020&title=Psychophysical%2Bidentity%2Band%2Bfree%2Benergy.&journal=J.+R.+Soc.+Interface&volume=17)
- 115
	KilteniK.AnderssonB. J.HouborgC.EhrssonH. H. (2018). Motor imagery involves predicting the sensory consequences of the imagined movement.**Nat. Commun.**91–9. 10.1038/s41467-018-03989-0
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/29691389)
	- [CrossRef](https://doi.org/10.1038/s41467-018-03989-0)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=K..%2BKilteni&author=B.%2BJ..%2BAndersson&author=C..%2BHouborg&author=H.%2BH..%2BEhrsson&publication_year=2018&title=Motor%2Bimagery%2Binvolves%2Bpredicting%2Bthe%2Bsensory%2Bconsequences%2Bof%2Bthe%2Bimagined%2Bmovement.&journal=Nat.+Commun.&volume=9&pages=1-9)
- 116
	KirchhoffM.ParrT.PalaciosE.FristonK. J.KiversteinJ. (2018). The Markov blankets of life: Autonomy, active inference and the free energy principle.**J. R. Soc. Interface** 15:20170792. 10.1098/rsif.2017.0792
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/29343629)
	- [CrossRef](https://doi.org/10.1098/rsif.2017.0792)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M..%2BKirchhoff&author=T..%2BParr&author=E..%2BPalacios&author=K.%2BJ..%2BFriston&author=J..%2BKiverstein&publication_year=2018&title=The%2BMarkov%2Bblankets%2Bof%2Blife%3A%2BAutonomy%2C%2Bactive%2Binference%2Band%2Bthe%2Bfree%2Benergy%2Bprinciple.&journal=J.+R.+Soc.+Interface&volume=15)
- 117
	KnightR. T.GraboweckyM. (1995). “Escape from linear time: Prefrontal cortex and conscious experience,” in **The cognitive neurosciences**, edsPoeppelD.MangunG. R.GazzanigaM. S. (Cambridge, MA: The MIT Press), 1357–1371.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=R.%2BT..%2BKnight&author=M..%2BGrabowecky&publication_year=1995&title=Escape%2Bfrom%2Blinear%2Btime%3A%2BPrefrontal%2Bcortex%2Band%2Bconscious%2Bexperience&journal=The+cognitive+neurosciences&pages=1357-1371)
- 118
	KochC. (2012). **Consciousness: Confessions of a Romantic Reductionist.**Cambridge, MA: MIT Press.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=C..%2BKoch&publication_year=2012&journal=Consciousness%3A+Confessions+of+a+Romantic+Reductionist.)
- 119
	KosterR.ChadwickM. J.ChenY.BerronD.BaninoA.DüzelE.et al (2018). Big-Loop Recurrence within the Hippocampal System Supports Integration of Information across Episodes.**Neuron** 991342–1354.e6. 10.1016/j.neuron.2018.08.009
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/30236285)
	- [CrossRef](https://doi.org/10.1016/j.neuron.2018.08.009)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=R..%2BKoster&author=M.%2BJ..%2BChadwick&author=Y..%2BChen&author=D..%2BBerron&author=A..%2BBanino&author=E..%2BD%C3%BCzel&publication_year=2018&title=Big-Loop%2BRecurrence%2Bwithin%2Bthe%2BHippocampal%2BSystem%2BSupports%2BIntegration%2Bof%2BInformation%2Bacross%2BEpisodes.&journal=Neuron&volume=99&pages=1342-1354.e6)
- 120
	KropffE.TrevesA. (2008). The emergence of grid cells: Intelligent design or just adaptation?**Hippocampus** 181256–1269. 10.1002/hipo.20520
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/19021261)
	- [CrossRef](https://doi.org/10.1002/hipo.20520)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=E..%2BKropff&author=A..%2BTreves&publication_year=2008&title=The%2Bemergence%2Bof%2Bgrid%2Bcells%3A%2BIntelligent%2Bdesign%2Bor%2Bjust%2Badaptation%3F&journal=Hippocampus&volume=18&pages=1256-1269)
- 121
	KushnirT. (2018). The developmental and cultural psychology of free will.**Philos. Compass** 13:e12529. 10.1111/phc3.12529
	- [CrossRef](https://doi.org/10.1111/phc3.12529)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=T..%2BKushnir&publication_year=2018&title=The%2Bdevelopmental%2Band%2Bcultural%2Bpsychology%2Bof%2Bfree%2Bwill.&journal=Philos.+Compass&volume=13)
- 122
	KushnirT.GopnikA.ChernyakN.SeiverE.WellmanH. M. (2015). Developing intuitions about free will between ages four and six.**Cognition** 13879–101. 10.1016/j.cognition.2015.01.003
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/25721020)
	- [CrossRef](https://doi.org/10.1016/j.cognition.2015.01.003)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=T..%2BKushnir&author=A..%2BGopnik&author=N..%2BChernyak&author=E..%2BSeiver&author=H.%2BM..%2BWellman&publication_year=2015&title=Developing%2Bintuitions%2Babout%2Bfree%2Bwill%2Bbetween%2Bages%2Bfour%2Band%2Bsix.&journal=Cognition&volume=138&pages=79-101)
- 123
	LakoffG.JohnsonM. (1999). **Philosophy in the Flesh: The Embodied Mind and Its Challenge to Western Thought.**New York, NY: Basic Books.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=G..%2BLakoff&author=M..%2BJohnson&publication_year=1999&journal=Philosophy+in+the+Flesh%3A+The+Embodied+Mind+and+Its+Challenge+to+Western+Thought.)
- 124
	LecunY.BottouL.BengioY.HaffnerP. (1998). Gradient-based learning applied to document recognition.**Proc. IEEE** 862278–2324. 10.1109/5.726791
	- [CrossRef](https://doi.org/10.1109/5.726791)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=Y..%2BLecun&author=L..%2BBottou&author=Y..%2BBengio&author=P..%2BHaffner&publication_year=1998&title=Gradient-based%2Blearning%2Bapplied%2Bto%2Bdocument%2Brecognition.&journal=Proc.+IEEE&volume=86&pages=2278-2324)
- 125
	LeDouxJ. E.BrownR. (2017). A higher-order theory of emotional consciousness.**Proc. Natl. Acad. Sci. U. S. A.**114E2016–E2025. 10.1073/pnas.1619316114
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/28202735)
	- [CrossRef](https://doi.org/10.1073/pnas.1619316114)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J.%2BE..%2BLeDoux&author=R..%2BBrown&publication_year=2017&title=A%2Bhigher-order%2Btheory%2Bof%2Bemotional%2Bconsciousness.&journal=Proc.+Natl.+Acad.+Sci.+U.+S.+A.&volume=114&pages=E2016-E2025)
- 126
	LeeA. M.HoyJ. L.BonciA.WilbrechtL.StrykerM. P.NiellC. M. (2014). Identification of a brainstem circuit regulating visual cortical state in parallel with locomotion.**Neuron** 83455–466. 10.1016/j.neuron.2014.06.031
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/25033185)
	- [CrossRef](https://doi.org/10.1016/j.neuron.2014.06.031)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A.%2BM..%2BLee&author=J.%2BL..%2BHoy&author=A..%2BBonci&author=L..%2BWilbrecht&author=M.%2BP..%2BStryker&author=C.%2BM..%2BNiell&publication_year=2014&title=Identification%2Bof%2Ba%2Bbrainstem%2Bcircuit%2Bregulating%2Bvisual%2Bcortical%2Bstate%2Bin%2Bparallel%2Bwith%2Blocomotion.&journal=Neuron&volume=83&pages=455-466)
- 127
	LevinI. (1992). “The Development of the Concept of Time in Children: An Integrative Model,” in **Time, Action and Cognition: Towards Bridging the Gap**, edsMacarF.PouthasV.FriedmanW. J. (Dordrecht: Springer Netherlands), 13–32. 10.1007/978-94-017-3536-0\_3
	- [CrossRef](https://doi.org/10.1007/978-94-017-3536-0_3)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=I..%2BLevin&publication_year=1992&title=The%2BDevelopment%2Bof%2Bthe%2BConcept%2Bof%2BTime%2Bin%2BChildren%3A%2BAn%2BIntegrative%2BModel&journal=Time%2C+Action+and+Cognition%3A+Towards+Bridging+the+Gap&pages=13-32)
- 128
	LevinI.IsraeliE.DaromE. (1978). The Development of Time Concepts in Young Children: The Relations between Duration and Succession.**Child Dev.**49755–764. 10.2307/1128245
	- [CrossRef](https://doi.org/10.2307/1128245)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=I..%2BLevin&author=E..%2BIsraeli&author=E..%2BDarom&publication_year=1978&title=The%2BDevelopment%2Bof%2BTime%2BConcepts%2Bin%2BYoung%2BChildren%3A%2BThe%2BRelations%2Bbetween%2BDuration%2Band%2BSuccession.&journal=Child+Dev.&volume=49&pages=755-764)
- 129
	LiM.WoelferM.ColicL.SafronA.ChangC.HeinzeH. J.et al (2018). Default mode network connectivity change corresponds to ketamine’s delayed glutamatergic effects.**Eur. Arch. Psychiatry Clin. Neurosci.**270207–216. 10.1007/s00406-018-0942-y
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/30353262)
	- [CrossRef](https://doi.org/10.1007/s00406-018-0942-y)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M..%2BLi&author=M..%2BWoelfer&author=L..%2BColic&author=A..%2BSafron&author=C..%2BChang&author=H.%2BJ..%2BHeinze&publication_year=2018&title=Default%2Bmode%2Bnetwork%2Bconnectivity%2Bchange%2Bcorresponds%2Bto%2Bketamine%E2%80%99s%2Bdelayed%2Bglutamatergic%2Beffects.&journal=Eur.+Arch.+Psychiatry+Clin.+Neurosci.&volume=270&pages=207-216)
- 130
	LimanowskiJ.FristonK. J. (2018). Seeing the Dark’: Grounding Phenomenal Transparency and Opacity in Precision Estimation for Active Inference.**Front. Psychol.**9:643. 10.3389/fpsyg.2018.00643
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/29780343)
	- [CrossRef](https://doi.org/10.3389/fpsyg.2018.00643)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J..%2BLimanowski&author=K.%2BJ..%2BFriston&publication_year=2018&title=Seeing%2Bthe%2BDark%E2%80%99%3A%2BGrounding%2BPhenomenal%2BTransparency%2Band%2BOpacity%2Bin%2BPrecision%2BEstimation%2Bfor%2BActive%2BInference.&journal=Front.+Psychol.&volume=9)
- 131
	LiuY. H.PoulinD. (2019). Neural Belief-Propagation Decoders for Quantum Error-Correcting Codes.**Phys. Rev. Lett.**122:200501. 10.1103/PhysRevLett.122.200501
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/31172756)
	- [CrossRef](https://doi.org/10.1103/PhysRevLett.122.200501)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=Y.%2BH..%2BLiu&author=D..%2BPoulin&publication_year=2019&title=Neural%2BBelief-Propagation%2BDecoders%2Bfor%2BQuantum%2BError-Correcting%2BCodes.&journal=Phys.+Rev.+Lett.&volume=122)
- 132
	LloydS. (2012). A Turing test for free will.**Philos. Trans. R. Soc. A Math. Phys. Eng. Sci.**3703597–3610. 10.1098/rsta.2011.0331
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/22711875)
	- [CrossRef](https://doi.org/10.1098/rsta.2011.0331)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=S..%2BLloyd&publication_year=2012&title=A%2BTuring%2Btest%2Bfor%2Bfree%2Bwill.&journal=Philos.+Trans.+R.+Soc.+A+Math.+Phys.+Eng.+Sci.&volume=370&pages=3597-3610)
- 133
	MacIverM. A.SchmitzL.MuganU.MurpheyT. D.MobleyC. D. (2017). Massive increase in visual range preceded the origin of terrestrial vertebrates.**Proc. Natl. Acad. Sci. U. S. A.**114E2375–E2384. 10.1073/pnas.1615563114
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/28270619)
	- [CrossRef](https://doi.org/10.1073/pnas.1615563114)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M.%2BA..%2BMacIver&author=L..%2BSchmitz&author=U..%2BMugan&author=T.%2BD..%2BMurphey&author=C.%2BD..%2BMobley&publication_year=2017&title=Massive%2Bincrease%2Bin%2Bvisual%2Brange%2Bpreceded%2Bthe%2Borigin%2Bof%2Bterrestrial%2Bvertebrates.&journal=Proc.+Natl.+Acad.+Sci.+U.+S.+A.&volume=114&pages=E2375-E2384)
- 134
	MacKayD. G. (2019). **Remembering: What 50 Years of Research with Famous Amnesia Patient H. M. Can Teach Us about Memory and How It Works.**New York, NY: Prometheus Books.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=D.%2BG..%2BMacKay&publication_year=2019&journal=Remembering%3A+What+50+Years+of+Research+with+Famous+Amnesia+Patient+H.+M.+Can+Teach+Us+about+Memory+and+How+It+Works.)
- 135
	MadlT.BaarsB. J.FranklinS. (2011). The timing of the cognitive cycle.**PLoS One** 6:e14803. 10.1371/journal.pone.0014803
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/21541015)
	- [CrossRef](https://doi.org/10.1371/journal.pone.0014803)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=T..%2BMadl&author=B.%2BJ..%2BBaars&author=S..%2BFranklin&publication_year=2011&title=The%2Btiming%2Bof%2Bthe%2Bcognitive%2Bcycle.&journal=PLoS+One&volume=6)
- 136
	MaguireP.MaguireR. (2010). “Consciousness is data compression,” in **Proceedings of the thirty-second conference of the cognitive science society**, 748–753. Available online at: [https://escholarship.org/uc/item/0bc3p5sv#author](https://escholarship.org/uc/item/0bc3p5sv#author)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=P..%2BMaguire&author=R..%2BMaguire&publication_year=2010&title=Consciousness%2Bis%2Bdata%2Bcompression&journal=Proceedings+of+the+thirty-second+conference+of+the+cognitive+science+society&pages=748-753)
- 137
	MaguireP.MoserP.MaguireR. (2016). Understanding Consciousness as Data Compression.**J. Cogn. Sci.**1763–94.
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/28846268)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=P..%2BMaguire&author=P..%2BMoser&author=R..%2BMaguire&publication_year=2016&title=Understanding%2BConsciousness%2Bas%2BData%2BCompression.&journal=J.+Cogn.+Sci.&volume=17&pages=63-94)
- 138
	MannellaF.GurneyK.BaldassarreG. (2013). The nucleus accumbens as a nexus between values and goals in goal-directed behavior: A review and a new hypothesis.**Front. Behav. Neurosci.**7:135. 10.3389/fnbeh.2013.00135
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/24167476)
	- [CrossRef](https://doi.org/10.3389/fnbeh.2013.00135)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=F..%2BMannella&author=K..%2BGurney&author=G..%2BBaldassarre&publication_year=2013&title=The%2Bnucleus%2Baccumbens%2Bas%2Ba%2Bnexus%2Bbetween%2Bvalues%2Band%2Bgoals%2Bin%2Bgoal-directed%2Bbehavior%3A%2BA%2Breview%2Band%2Ba%2Bnew%2Bhypothesis.&journal=Front.+Behav.+Neurosci.&volume=7)
- 139
	ManningJ. R.SperlingM. R.SharanA.RosenbergE. A.KahanaM. J. (2012). Spontaneously Reactivated Patterns in Frontal and Temporal Lobe Predict Semantic Clustering during Memory Search.**J. Neurosci.**328871–8878. 10.1523/JNEUROSCI.5321-11.2012
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/22745488)
	- [CrossRef](https://doi.org/10.1523/JNEUROSCI.5321-11.2012)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J.%2BR..%2BManning&author=M.%2BR..%2BSperling&author=A..%2BSharan&author=E.%2BA..%2BRosenberg&author=M.%2BJ..%2BKahana&publication_year=2012&title=Spontaneously%2BReactivated%2BPatterns%2Bin%2BFrontal%2Band%2BTemporal%2BLobe%2BPredict%2BSemantic%2BClustering%2Bduring%2BMemory%2BSearch.&journal=J.+Neurosci.&volume=32&pages=8871-8878)
- 140
	MarkramH.GerstnerW.SjöströmP. J. (2011). A history of spike-timing-dependent plasticity.**Front. Synapt. Neurosci.**3:4. 10.3389/fnsyn.2011.00004
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/22007168)
	- [CrossRef](https://doi.org/10.3389/fnsyn.2011.00004)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=H..%2BMarkram&author=W..%2BGerstner&author=P.%2BJ..%2BSj%C3%B6str%C3%B6m&publication_year=2011&title=A%2Bhistory%2Bof%2Bspike-timing-dependent%2Bplasticity.&journal=Front.+Synapt.+Neurosci.&volume=3)
- 141
	MarrD. (1983). **Vision: A Computational Investigation into the Human Representation and Processing of Visual Information.**New York, NY: Henry Holt and Company.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=D..%2BMarr&publication_year=1983&journal=Vision%3A+A+Computational+Investigation+into+the+Human+Representation+and+Processing+of+Visual+Information.)
- 142
	MarshallW.KimH.WalkerS. I.TononiG.AlbantakisL. (2017). How causal analysis can reveal autonomy in models of biological systems.**Philos. Trans. R. Soc. A Math. Phys. Eng. Sci.**37520160358\. 10.1098/rsta.2016.0358
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/29133455)
	- [CrossRef](https://doi.org/10.1098/rsta.2016.0358)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=W..%2BMarshall&author=H..%2BKim&author=S.%2BI..%2BWalker&author=G..%2BTononi&author=L..%2BAlbantakis&publication_year=2017&title=How%2Bcausal%2Banalysis%2Bcan%2Breveal%2Bautonomy%2Bin%2Bmodels%2Bof%2Bbiological%2Bsystems.&journal=Philos.+Trans.+R.+Soc.+A+Math.+Phys.+Eng.+Sci.&volume=375)
- 143
	MartikM. L.GandhiS.UyB. R.GillisJ. A.GreenS. A.Simoes-CostaM.et al (2019). Evolution of the new head by gradual acquisition of neural crest regulatory circuits.**Nature** 574675–678. 10.1038/s41586-019-1691-4
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/31645763)
	- [CrossRef](https://doi.org/10.1038/s41586-019-1691-4)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M.%2BL..%2BMartik&author=S..%2BGandhi&author=B.%2BR..%2BUy&author=J.%2BA..%2BGillis&author=S.%2BA..%2BGreen&author=M..%2BSimoes-Costa&publication_year=2019&title=Evolution%2Bof%2Bthe%2Bnew%2Bhead%2Bby%2Bgradual%2Bacquisition%2Bof%2Bneural%2Bcrest%2Bregulatory%2Bcircuits.&journal=Nature&volume=574&pages=675-678)
- 144
	MashourG. A.RoelfsemaP.ChangeuxJ. P.DehaeneS. (2020). Conscious Processing and the Global Neuronal Workspace Hypothesis.**Neuron** 105776–798. 10.1016/j.neuron.2020.01.026
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/32135090)
	- [CrossRef](https://doi.org/10.1016/j.neuron.2020.01.026)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=G.%2BA..%2BMashour&author=P..%2BRoelfsema&author=J.%2BP..%2BChangeux&author=S..%2BDehaene&publication_year=2020&title=Conscious%2BProcessing%2Band%2Bthe%2BGlobal%2BNeuronal%2BWorkspace%2BHypothesis.&journal=Neuron&volume=105&pages=776-798)
- 145
	McCullochW. S.PittsW. (1943). A logical calculus of the ideas immanent in nervous activity.**Bull. Math. Biophys.**5115–133.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=W.%2BS..%2BMcCulloch&author=W..%2BPitts&publication_year=1943&title=A%2Blogical%2Bcalculus%2Bof%2Bthe%2Bideas%2Bimmanent%2Bin%2Bnervous%2Bactivity.&journal=Bull.+Math.+Biophys.&volume=5&pages=115-133)
- 146
	McElieceR. J.MacKayD. J. C.Jung-FuC. (1998). Turbo decoding as an instance of Pearl’s “belief propagation” algorithm.**IEEE J. Select. Areas Commun.**16140–152. 10.1109/49.661103
	- [CrossRef](https://doi.org/10.1109/49.661103)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=R.%2BJ..%2BMcEliece&author=D.%2BJ.%2BC..%2BMacKay&author=C..%2BJung-Fu&publication_year=1998&title=Turbo%2Bdecoding%2Bas%2Ban%2Binstance%2Bof%2BPearl%E2%80%99s%2B%E2%80%9Cbelief%2Bpropagation%E2%80%9D%2Balgorithm.&journal=IEEE+J.+Select.+Areas+Commun.&volume=16&pages=140-152)
- 147
	McGilchristI. (2019). **The Master and His Emissary: The Divided Brain and the Making of the Western World.**New Haven: Yale University Press.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=I..%2BMcGilchrist&publication_year=2019&journal=The+Master+and+His+Emissary%3A+The+Divided+Brain+and+the+Making+of+the+Western+World.)
- 148
	McGurkH.MacDonaldJ. (1976). Hearing lips and seeing voices.**Nature** 264746–748.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=H..%2BMcGurk&author=J..%2BMacDonald&publication_year=1976&title=Hearing%2Blips%2Band%2Bseeing%2Bvoices.&journal=Nature&volume=264&pages=746-748)
- 149
	McKemmishL. K.ReimersJ. R.McKenzieR. H.MarkA. E.HushN. S. (2009). Penrose-Hameroff orchestrated objective-reduction proposal for human consciousness is not biologically feasible.**Phys. Rev. E Statist. Nonlinear Soft Matter Phys.**80:021912. 10.1103/PhysRevE.80.021912
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/19792156)
	- [CrossRef](https://doi.org/10.1103/PhysRevE.80.021912)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=L.%2BK..%2BMcKemmish&author=J.%2BR..%2BReimers&author=R.%2BH..%2BMcKenzie&author=A.%2BE..%2BMark&author=N.%2BS..%2BHush&publication_year=2009&title=Penrose-Hameroff%2Borchestrated%2Bobjective-reduction%2Bproposal%2Bfor%2Bhuman%2Bconsciousness%2Bis%2Bnot%2Bbiologically%2Bfeasible.&journal=Phys.+Rev.+E+Statist.+Nonlinear+Soft+Matter+Phys.&volume=80)
- 150
	McNamaraC. G.DupretD. (2017). Two sources of dopamine for the hippocampus.**Trends Neurosci.**40383–384. 10.1016/j.tins.2017.05.005
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/28511793)
	- [CrossRef](https://doi.org/10.1016/j.tins.2017.05.005)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=C.%2BG..%2BMcNamara&author=D..%2BDupret&publication_year=2017&title=Two%2Bsources%2Bof%2Bdopamine%2Bfor%2Bthe%2Bhippocampus.&journal=Trends+Neurosci.&volume=40&pages=383-384)
- 151
	MedianoP. A. M.RosasF.Carhart-HarrisR. L.SethA. K.BarrettA. B. (2019). Beyond integrated information: A taxonomy of information dynamics phenomena.**Arxiv** \[Preprint\]. 10.48550/arxiv:1909.02297
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/35895330)
	- [CrossRef](https://doi.org/10.48550/arxiv:1909.02297)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=P.%2BA.%2BM..%2BMediano&author=F..%2BRosas&author=R.%2BL..%2BCarhart-Harris&author=A.%2BK..%2BSeth&author=A.%2BB..%2BBarrett&publication_year=2019&title=Beyond%2Bintegrated%2Binformation%3A%2BA%2Btaxonomy%2Bof%2Binformation%2Bdynamics%2Bphenomena.&journal=Arxiv)
- 152
	MetzingerT. (2009). **The Ego Tunnel: The Science of the Mind and the Myth of the Self**, 1 Edn. New York, NY: Basic Books.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=T..%2BMetzinger&publication_year=2009&journal=The+Ego+Tunnel%3A+The+Science+of+the+Mind+and+the+Myth+of+the+Self)
- 153
	MontemayorC.HaladjianH. H. (2015). **Consciousness, Attention, and Conscious Attention.**Cambidge, MA: MIT Press.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=C..%2BMontemayor&author=H.%2BH..%2BHaladjian&publication_year=2015&journal=Consciousness%2C+Attention%2C+and+Conscious+Attention.)
- 154
	MorrensJ.AydinÇRensburgA. J.RabellJ. E.HaeslerS. (2020). Cue-Evoked Dopamine Promotes Conditioned Responding during Learning.**Neuron** 106142–153. 10.1016/j.neuron.2020.01.012
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/32027824)
	- [CrossRef](https://doi.org/10.1016/j.neuron.2020.01.012)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J..%2BMorrens&author=%C3%87.%2BAydin&author=A.%2BJ..%2BRensburg&author=J.%2BE..%2BRabell&author=S..%2BHaesler&publication_year=2020&title=Cue-Evoked%2BDopamine%2BPromotes%2BConditioned%2BResponding%2Bduring%2BLearning.&journal=Neuron&volume=106&pages=142-153)
- 155
	MoserE. I.KropffE.MoserM. B. (2008). Place cells, grid cells, and the brain’s spatial representation system.**Annu. Rev. Neurosci.**3169–89. 10.1146/annurev.neuro.31.061307.090723
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/18284371)
	- [CrossRef](https://doi.org/10.1146/annurev.neuro.31.061307.090723)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=E.%2BI..%2BMoser&author=E..%2BKropff&author=M.%2BB..%2BMoser&publication_year=2008&title=Place%2Bcells%2C%2Bgrid%2Bcells%2C%2Band%2Bthe%2Bbrain%E2%80%99s%2Bspatial%2Brepresentation%2Bsystem.&journal=Annu.+Rev.+Neurosci.&volume=31&pages=69-89)
- 156
	MuganU.MacIverM. A. (2019). The shift from life in water to life on land advantaged planning in visually-guided behavior.**Biorxiv** \[Preprint\]. 10.1101/585760
	- [CrossRef](https://doi.org/10.1101/585760)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=U..%2BMugan&author=M.%2BA..%2BMacIver&publication_year=2019&title=The%2Bshift%2Bfrom%2Blife%2Bin%2Bwater%2Bto%2Blife%2Bon%2Bland%2Badvantaged%2Bplanning%2Bin%2Bvisually-guided%2Bbehavior.&journal=Biorxiv)
- 157
	NagelT. (1974). What Is It Like to Be a Bat?.**Philos. Rev.**83435–450. 10.2307/2183914
	- [CrossRef](https://doi.org/10.2307/2183914)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=T..%2BNagel&publication_year=1974&title=What%2BIs%2BIt%2BLike%2Bto%2BBe%2Ba%2BBat%3F.&journal=Philos.+Rev.&volume=83&pages=435-450)
- 158
	NauM.SchröderT. N.BellmundJ. L. S.DoellerC. F. (2018). Hexadirectional coding of visual space in human entorhinal cortex.**Nat. Neurosci.**21188–190. 10.1038/s41593-017-0050-8
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/29311746)
	- [CrossRef](https://doi.org/10.1038/s41593-017-0050-8)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M..%2BNau&author=T.%2BN..%2BSchr%C3%B6der&author=J.%2BL.%2BS..%2BBellmund&author=C.%2BF..%2BDoeller&publication_year=2018&title=Hexadirectional%2Bcoding%2Bof%2Bvisual%2Bspace%2Bin%2Bhuman%2Bentorhinal%2Bcortex.&journal=Nat.+Neurosci.&volume=21&pages=188-190)
- 159
	NorthoffG. (2012). Immanuel Kant’s mind and the brain’s resting state.**Trends Cogn. Sci.**16356–359. 10.1016/j.tics.2012.06.001
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/22748399)
	- [CrossRef](https://doi.org/10.1016/j.tics.2012.06.001)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=G..%2BNorthoff&publication_year=2012&title=Immanuel%2BKant%E2%80%99s%2Bmind%2Band%2Bthe%2Bbrain%E2%80%99s%2Bresting%2Bstate.&journal=Trends+Cogn.+Sci.&volume=16&pages=356-359)
- 160
	O’ReillyR. C.WyatteD. R.RohrlichJ. (2017). Deep Predictive Learning: A Comprehensive Model of Three Visual Streams.**Arxiv** \[Preprint\]. 10.48550/arXiv.1709.04654
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/35895330)
	- [CrossRef](https://doi.org/10.48550/arXiv.1709.04654)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=R.%2BC..%2BO%E2%80%99Reilly&author=D.%2BR..%2BWyatte&author=J..%2BRohrlich&publication_year=2017&title=Deep%2BPredictive%2BLearning%3A%2BA%2BComprehensive%2BModel%2Bof%2BThree%2BVisual%2BStreams.&journal=Arxiv)
- 161
	PaperinG.GreenD. G.SadedinS. (2011). Dual-phase evolution in complex adaptive systems.**J. R. Soc. Interface** 8609–629. 10.1098/rsif.2010.0719
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/21247947)
	- [CrossRef](https://doi.org/10.1098/rsif.2010.0719)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=G..%2BPaperin&author=D.%2BG..%2BGreen&author=S..%2BSadedin&publication_year=2011&title=Dual-phase%2Bevolution%2Bin%2Bcomplex%2Badaptive%2Bsystems.&journal=J.+R.+Soc.+Interface&volume=8&pages=609-629)
- 162
	ParrT.MarkovicD.KiebelS. J.FristonK. J. (2019b). Neuronal message passing using Mean-field, Bethe, and Marginal approximations.**Sci. Rep.**9:1889. 10.1038/s41598-018-38246-3
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/30760782)
	- [CrossRef](https://doi.org/10.1038/s41598-018-38246-3)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=T..%2BParr&author=D..%2BMarkovic&author=S.%2BJ..%2BKiebel&author=K.%2BJ..%2BFriston&publication_year=2019b&title=Neuronal%2Bmessage%2Bpassing%2Busing%2BMean-field%2C%2BBethe%2C%2Band%2BMarginal%2Bapproximations.&journal=Sci.+Rep.&volume=9)
- 163
	ParrT.CorcoranA. W.FristonK. J.HohwyJ. (2019a). Perceptual awareness and active inference.**Neurosci. Conscious.**2019:niz012. 10.1093/nc/niz012
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/31528360)
	- [CrossRef](https://doi.org/10.1093/nc/niz012)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=T..%2BParr&author=A.%2BW..%2BCorcoran&author=K.%2BJ..%2BFriston&author=J..%2BHohwy&publication_year=2019a&title=Perceptual%2Bawareness%2Band%2Bactive%2Binference.&journal=Neurosci.+Conscious.&volume=2019)
- 164
	ParrT.RikhyeR. V.HalassaM. M.FristonK. J. (2019c). Prefrontal computation as active inference.**Cerebr. Cortex** 30682–695.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=T..%2BParr&author=R.%2BV..%2BRikhye&author=M.%2BM..%2BHalassa&author=K.%2BJ..%2BFriston&publication_year=2019c&title=Prefrontal%2Bcomputation%2Bas%2Bactive%2Binference.&journal=Cerebr.+Cortex&volume=30&pages=682-695)
- 165
	ParrT.FristonK. J. (2018a). The Anatomy of Inference: Generative Models and Brain Structure.**Front. Comput. Neurosci.**12:90. 10.3389/fncom.2018.00090
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/30483088)
	- [CrossRef](https://doi.org/10.3389/fncom.2018.00090)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=T..%2BParr&author=K.%2BJ..%2BFriston&publication_year=2018a&title=The%2BAnatomy%2Bof%2BInference%3A%2BGenerative%2BModels%2Band%2BBrain%2BStructure.&journal=Front.+Comput.+Neurosci.&volume=12)
- 166
	ParrT.FristonK. J. (2018b). The Discrete and Continuous Brain: From Decisions to Movement-And Back Again.**Neural Comput.**302319–2347. 10.1162/neco\_a\_01102
	- [CrossRef](https://doi.org/10.1162/neco_a_01102)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=T..%2BParr&author=K.%2BJ..%2BFriston&publication_year=2018b&title=The%2BDiscrete%2Band%2BContinuous%2BBrain%3A%2BFrom%2BDecisions%2Bto%2BMovement-And%2BBack%2BAgain.&journal=Neural+Comput.&volume=30&pages=2319-2347)
- 167
	PearlJ. (1982). “Reverend Bayes on inference engines: A distributed hierarchical approach,” in **AAAI’82: Proceedings of the Second AAAI Conference on Artificial Intelligence**, (Palo Alto: AAAI Press), 133–136.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J..%2BPearl&publication_year=1982&title=Reverend%2BBayes%2Bon%2Binference%2Bengines%3A%2BA%2Bdistributed%2Bhierarchical%2Bapproach&journal=AAAI%E2%80%9982%3A+Proceedings+of+the+Second+AAAI+Conference+on+Artificial+Intelligence&pages=133-136)
- 168
	PearlJ.MackenzieD. (2018). **The Book of Why: The New Science of Cause and Effect.**New York, NY: BASIC Books.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J..%2BPearl&author=D..%2BMackenzie&publication_year=2018&journal=The+Book+of+Why%3A+The+New+Science+of+Cause+and+Effect.)
- 169
	PrinzJ. (2017). “The Intermediate Level Theory of Consciousness,” in **The Blackwell Companion to Consciousness**, edsSchneiderS.VelmansM. (Hoboken, NJ: John Wiley & Sons, Ltd), 257–271. 10.1002/9781119132363.ch18
	- [CrossRef](https://doi.org/10.1002/9781119132363.ch18)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J..%2BPrinz&publication_year=2017&title=The%2BIntermediate%2BLevel%2BTheory%2Bof%2BConsciousness&journal=The+Blackwell+Companion+to+Consciousness&pages=257-271)
- 170
	RamsteadM. J. D.BadcockP. B.FristonK. J. (2017). Answering Schrödinger’s question: A free-energy formulation.**Phys. Life Rev.**241–16. 10.1016/j.plrev.2017.09.001
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/29029962)
	- [CrossRef](https://doi.org/10.1016/j.plrev.2017.09.001)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M.%2BJ.%2BD..%2BRamstead&author=P.%2BB..%2BBadcock&author=K.%2BJ..%2BFriston&publication_year=2017&title=Answering%2BSchr%C3%B6dinger%E2%80%99s%2Bquestion%3A%2BA%2Bfree-energy%2Bformulation.&journal=Phys.+Life+Rev.&volume=24&pages=1-16)
- 171
	RamsteadM. J. D.SethA. K.HespC.Sandved-SmithL.MagoJ.LifshitzM.et al (2022). From Generative Models to Generative Passages: A Computational Approach to (Neuro) Phenomenology.**Rev. Philos. Psychol.**10.1007/s13164-021-00604-y
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/35317021)
	- [CrossRef](https://doi.org/10.1007/s13164-021-00604-y)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M.%2BJ.%2BD..%2BRamstead&author=A.%2BK..%2BSeth&author=C..%2BHesp&author=L..%2BSandved-Smith&author=J..%2BMago&author=M..%2BLifshitz&publication_year=2022&title=From%2BGenerative%2BModels%2Bto%2BGenerative%2BPassages%3A%2BA%2BComputational%2BApproach%2Bto%2B%28Neuro%29%2BPhenomenology.&journal=Rev.+Philos.+Psychol.)
- 172
	RedgraveP.GurneyK.ReynoldsJ. (2008). What is reinforced by phasic dopamine signals?.**Brain Res. Rev.**58322–339. 10.1016/j.brainresrev.2007.10.007
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/18055018)
	- [CrossRef](https://doi.org/10.1016/j.brainresrev.2007.10.007)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=P..%2BRedgrave&author=K..%2BGurney&author=J..%2BReynolds&publication_year=2008&title=What%2Bis%2Breinforced%2Bby%2Bphasic%2Bdopamine%2Bsignals%3F.&journal=Brain+Res.+Rev.&volume=58&pages=322-339)
- 173
	RichardsB. A.LillicrapT. P.BeaudoinP.BengioY.BogaczR.ChristensenA.et al (2019). A deep learning framework for neuroscience.**Nat. Neurosci.**221761–1770. 10.1038/s41593-019-0520-2
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/31659335)
	- [CrossRef](https://doi.org/10.1038/s41593-019-0520-2)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=B.%2BA..%2BRichards&author=T.%2BP..%2BLillicrap&author=P..%2BBeaudoin&author=Y..%2BBengio&author=R..%2BBogacz&author=A..%2BChristensen&publication_year=2019&title=A%2Bdeep%2Blearning%2Bframework%2Bfor%2Bneuroscience.&journal=Nat.+Neurosci.&volume=22&pages=1761-1770)
- 174
	RigginsT.ScottL. S. (2020). P300 development from infancy to adolescence.**Psychophysiology** 57:e13346. 10.1111/psyp.13346
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/30793775)
	- [CrossRef](https://doi.org/10.1111/psyp.13346)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=T..%2BRiggins&author=L.%2BS..%2BScott&publication_year=2020&title=P300%2Bdevelopment%2Bfrom%2Binfancy%2Bto%2Badolescence.&journal=Psychophysiology&volume=57)
- 175
	RochaL. M. (2000). Syntactic autonomy. Why there is no autonomy without symbols and how self-organizing systems might evolve them.**Ann. N. Y. Acad. Sci.**901207–223. 10.1111/j.1749-6632.2000.tb06280.x
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/10818572)
	- [CrossRef](https://doi.org/10.1111/j.1749-6632.2000.tb06280.x)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=L.%2BM..%2BRocha&publication_year=2000&title=Syntactic%2Bautonomy.%2BWhy%2Bthere%2Bis%2Bno%2Bautonomy%2Bwithout%2Bsymbols%2Band%2Bhow%2Bself-organizing%2Bsystems%2Bmight%2Bevolve%2Bthem.&journal=Ann.+N.+Y.+Acad.+Sci.&volume=901&pages=207-223)
- 176
	RochatP. (2010). “Emerging Self-Concept,” in **The Wiley-Blackwell Handbook of Infant Development**, edsBremnerJ. G.WachsT. D. (Hoboken, NJ: Wiley-Blackwell), 320–344. 10.1002/9781444327564.ch10
	- [CrossRef](https://doi.org/10.1002/9781444327564.ch10)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=P..%2BRochat&publication_year=2010&title=Emerging%2BSelf-Concept&journal=The+Wiley-Blackwell+Handbook+of+Infant+Development&pages=320-344)
- 177
	RudraufD.BennequinD.GranicI.LandiniG.FristonK. J.WillifordK. (2017). A mathematical model of embodied consciousness.**J. Theor. Biol.**428106–131. 10.1016/j.jtbi.2017.05.032
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/28554611)
	- [CrossRef](https://doi.org/10.1016/j.jtbi.2017.05.032)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=D..%2BRudrauf&author=D..%2BBennequin&author=I..%2BGranic&author=G..%2BLandini&author=K.%2BJ..%2BFriston&author=K..%2BWilliford&publication_year=2017&title=A%2Bmathematical%2Bmodel%2Bof%2Bembodied%2Bconsciousness.&journal=J.+Theor.+Biol.&volume=428&pages=106-131)
- 178
	RudraufD.LutzA.CosmelliD.LachauxJ. P.Le Van QuyenM. (2003). From autopoiesis to neurophenomenology: Francisco Varela’s exploration of the biophysics of being.**Biol. Res.**3627–65. 10.4067/s0716-97602003000100005
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/12795206)
	- [CrossRef](https://doi.org/10.4067/s0716-97602003000100005)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=D..%2BRudrauf&author=A..%2BLutz&author=D..%2BCosmelli&author=J.%2BP..%2BLachaux&author=M..%2BLe%2BVan%2BQuyen&publication_year=2003&title=From%2Bautopoiesis%2Bto%2Bneurophenomenology%3A%2BFrancisco%2BVarela%E2%80%99s%2Bexploration%2Bof%2Bthe%2Bbiophysics%2Bof%2Bbeing.&journal=Biol.+Res.&volume=36&pages=27-65)
- 179
	RussonA. E.BegunD. R. (2007). **The Evolution of Thought: Evolutionary Origins of Great Ape Intelligence.**Cambridge, MA: Cambridge University Press.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A.%2BE..%2BRusson&author=D.%2BR..%2BBegun&publication_year=2007&journal=The+Evolution+of+Thought%3A+Evolutionary+Origins+of+Great+Ape+Intelligence.)
- 180
	SafronA. (2019). Bayesian Analogical Cybernetics.**Arxiv** \[Preprint\]. 10.48550/arXiv.1911.02362
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/35895330)
	- [CrossRef](https://doi.org/10.48550/arXiv.1911.02362)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A..%2BSafron&publication_year=2019&title=Bayesian%2BAnalogical%2BCybernetics.&journal=Arxiv)
- 181
	SafronA. (2020a). An Integrated World Modeling Theory (IWMT) of Consciousness: Combining Integrated Information and Global Neuronal Workspace Theories With the Free Energy Principle and Active Inference Framework; Toward Solving the Hard Problem and Characterizing Agentic Causation.**Front. Art. Intell.**3:30. 10.3389/frai.2020.00030
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/33733149)
	- [CrossRef](https://doi.org/10.3389/frai.2020.00030)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A..%2BSafron&publication_year=2020a&title=An%2BIntegrated%2BWorld%2BModeling%2BTheory%2B%28IWMT%29%2Bof%2BConsciousness%3A%2BCombining%2BIntegrated%2BInformation%2Band%2BGlobal%2BNeuronal%2BWorkspace%2BTheories%2BWith%2Bthe%2BFree%2BEnergy%2BPrinciple%2Band%2BActive%2BInference%2BFramework%3B%2BToward%2BSolving%2Bthe%2BHard%2BProblem%2Band%2BCharacterizing%2BAgentic%2BCausation.&journal=Front.+Art.+Intell.&volume=3)
- 182
	SafronA. (2020b). Integrated World Modeling Theory (IWMT) Implemented: Towards Reverse Engineering Consciousness with the Free Energy Principle and Active Inference.**Psyarxiv** \[Preprint\]. 10.31234/osf.io/paz5j
	- [CrossRef](https://doi.org/10.31234/osf.io/paz5j)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A..%2BSafron&publication_year=2020b&title=Integrated%2BWorld%2BModeling%2BTheory%2B%28IWMT%29%2BImplemented%3A%2BTowards%2BReverse%2BEngineering%2BConsciousness%2Bwith%2Bthe%2BFree%2BEnergy%2BPrinciple%2Band%2BActive%2BInference.&journal=Psyarxiv)
- 183
	SafronA. (2020c). On the Varieties of Conscious Experiences: Altered Beliefs Under Psychedelics (ALBUS).**Psyarxiv** \[Preprint\]. 10.31234/osf.io/zqh4b
	- [CrossRef](https://doi.org/10.31234/osf.io/zqh4b)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A..%2BSafron&publication_year=2020c&title=On%2Bthe%2BVarieties%2Bof%2BConscious%2BExperiences%3A%2BAltered%2BBeliefs%2BUnder%2BPsychedelics%2B%28ALBUS%29.&journal=Psyarxiv)
- 184
	SafronA. (2021b). The Radically Embodied Conscious Cybernetic Bayesian Brain: From Free Energy to Free Will and Back Again.**Entropy** 23:783. 10.3390/e23060783
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/34202965)
	- [CrossRef](https://doi.org/10.3390/e23060783)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A..%2BSafron&publication_year=2021b&title=The%2BRadically%2BEmbodied%2BConscious%2BCybernetic%2BBayesian%2BBrain%3A%2BFrom%2BFree%2BEnergy%2Bto%2BFree%2BWill%2Band%2BBack%2BAgain.&journal=Entropy&volume=23)
- 185
	SafronA. (2021a). World Models and the Physical Substrates of Consciousness: Hidden Sources of the Stream of Experience?.**J. Conscious. Stud.**28210–221.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A..%2BSafron&publication_year=2021a&title=World%2BModels%2Band%2Bthe%2BPhysical%2BSubstrates%2Bof%2BConsciousness%3A%2BHidden%2BSources%2Bof%2Bthe%2BStream%2Bof%2BExperience%3F.&journal=J.+Conscious.+Stud.&volume=28&pages=210-221)
- 186
	SafronA. (2021c). World Modeling, Integrated Information, and the Physical Substrates of Consciousness; Hidden Sources of the Stream of Experience?.**Psyarxiv** \[Preprint\]. 10.31234/osf.io/aud6e
	- [CrossRef](https://doi.org/10.31234/osf.io/aud6e)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A..%2BSafron&publication_year=2021c&title=World%2BModeling%2C%2BIntegrated%2BInformation%2C%2Band%2Bthe%2BPhysical%2BSubstrates%2Bof%2BConsciousness%3B%2BHidden%2BSources%2Bof%2Bthe%2BStream%2Bof%2BExperience%3F.&journal=Psyarxiv)
- 187
	SafronA.ÇatalO.VerbelenT. (2021a). Generalized Simultaneous Localization and Mapping (G-SLAM) as unification framework for natural and artificial intelligences: Towards reverse engineering the hippocampal/entorhinal system and principles of high-level cognition.**Psyarxiv** \[Preprint\]. 10.31234/osf.io/tdw82
	- [CrossRef](https://doi.org/10.31234/osf.io/tdw82)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A..%2BSafron&author=O..%2B%C3%87atal&author=T..%2BVerbelen&publication_year=2021a&title=Generalized%2BSimultaneous%2BLocalization%2Band%2BMapping%2B%28G-SLAM%29%2Bas%2Bunification%2Bframework%2Bfor%2Bnatural%2Band%2Bartificial%2Bintelligences%3A%2BTowards%2Breverse%2Bengineering%2Bthe%2Bhippocampal%2Fentorhinal%2Bsystem%2Band%2Bprinciples%2Bof%2Bhigh-level%2Bcognition.&journal=Psyarxiv)
- 188
	SafronA.KlimajV.HipólitoI. (2021b). On the importance of being flexible: Dynamic brain networks and their potential functional significances.**Psyarxiv** \[Preprint\]. 10.31234/osf.io/x734w
	- [CrossRef](https://doi.org/10.31234/osf.io/x734w)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A..%2BSafron&author=V..%2BKlimaj&author=I..%2BHip%C3%B3lito&publication_year=2021b&title=On%2Bthe%2Bimportance%2Bof%2Bbeing%2Bflexible%3A%2BDynamic%2Bbrain%2Bnetworks%2Band%2Btheir%2Bpotential%2Bfunctional%2Bsignificances.&journal=Psyarxiv)
- 189
	SafronA.SheikhbahaeeZ. (2021). Dream to explore: 5-HT2a as adaptive temperature parameter for sophisticated affective inference.**Psyarxiv** \[Preprint\]. 10.31234/osf.io/zmpaq
	- [CrossRef](https://doi.org/10.31234/osf.io/zmpaq)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A..%2BSafron&author=Z..%2BSheikhbahaee&publication_year=2021&title=Dream%2Bto%2Bexplore%3A%2B5-HT2a%2Bas%2Badaptive%2Btemperature%2Bparameter%2Bfor%2Bsophisticated%2Baffective%2Binference.&journal=Psyarxiv)
- 190
	SaganC. (1977). **The Dragons of Eden: Speculations on the Evolution of Human Intelligence.**New York, NY: Ballantine Books.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=C..%2BSagan&publication_year=1977&journal=The+Dragons+of+Eden%3A+Speculations+on+the+Evolution+of+Human+Intelligence.)
- 191
	Sandved-SmithL.HespC.MattoutJ.FristonK.LutzA.RamsteadM. J. D. (2021). Towards a computational phenomenology of mental action: Modelling meta-awareness and attentional control with deep parametric active inference.**Neurosci. Conscious.**2021:niab018. 10.1093/nc/niab018
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/34457352)
	- [CrossRef](https://doi.org/10.1093/nc/niab018)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=L..%2BSandved-Smith&author=C..%2BHesp&author=J..%2BMattout&author=K..%2BFriston&author=A..%2BLutz&author=M.%2BJ.%2BD..%2BRamstead&publication_year=2021&title=Towards%2Ba%2Bcomputational%2Bphenomenology%2Bof%2Bmental%2Baction%3A%2BModelling%2Bmeta-awareness%2Band%2Battentional%2Bcontrol%2Bwith%2Bdeep%2Bparametric%2Bactive%2Binference.&journal=Neurosci.+Conscious.&volume=2021)
- 192
	SasaiS.BolyM.MensenA.TononiG. (2016). Functional split brain in a driving/listening paradigm.**Proc. Natl. Acad. Sci. U. S. A.**11314444–14449. 10.1073/pnas.1613200113
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/27911805)
	- [CrossRef](https://doi.org/10.1073/pnas.1613200113)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=S..%2BSasai&author=M..%2BBoly&author=A..%2BMensen&author=G..%2BTononi&publication_year=2016&title=Functional%2Bsplit%2Bbrain%2Bin%2Ba%2Bdriving%2Flistening%2Bparadigm.&journal=Proc.+Natl.+Acad.+Sci.+U.+S.+A.&volume=113&pages=14444-14449)
- 193
	SchartnerM. M.Carhart-HarrisR. L.BarrettA. B.SethA. K.MuthukumaraswamyS. D. (2017). Increased spontaneous MEG signal diversity for psychoactive doses of ketamine. LSD and psilocybin.**Sci. Rep.**7:46421. 10.1038/srep46421
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/28422113)
	- [CrossRef](https://doi.org/10.1038/srep46421)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M.%2BM..%2BSchartner&author=R.%2BL..%2BCarhart-Harris&author=A.%2BB..%2BBarrett&author=A.%2BK..%2BSeth&author=S.%2BD..%2BMuthukumaraswamy&publication_year=2017&title=Increased%2Bspontaneous%2BMEG%2Bsignal%2Bdiversity%2Bfor%2Bpsychoactive%2Bdoses%2Bof%2Bketamine.%2BLSD%2Band%2Bpsilocybin.&journal=Sci.+Rep.&volume=7)
- 194
	ScheeringaR.FriesP. (2019). Cortical layers, rhythms and BOLD signals.**NeuroImage** 197689–698. 10.1016/j.neuroimage.2017.11.002
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/29108940)
	- [CrossRef](https://doi.org/10.1016/j.neuroimage.2017.11.002)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=R..%2BScheeringa&author=P..%2BFries&publication_year=2019&title=Cortical%2Blayers%2C%2Brhythms%2Band%2BBOLD%2Bsignals.&journal=NeuroImage&volume=197&pages=689-698)
- 195
	SchmidhuberJ. (2000). Algorithmic Theories of Everything.**Arxiv** \[Preprint\]. 10.48550/arXiv.quant-ph/0011122
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/35895330)
	- [CrossRef](https://doi.org/10.48550/arXiv.quant-ph/0011122)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J..%2BSchmidhuber&publication_year=2000&title=Algorithmic%2BTheories%2Bof%2BEverything.&journal=Arxiv)
- 196
	SchmidhuberJ. (2012). POWERPLAY: Training an Increasingly General Problem Solver by Continually Searching for the Simplest Still Unsolvable Problem.**Arxiv** \[Preprint\]. 10.48550/arXiv/1112.5309
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/35895330)
	- [CrossRef](https://doi.org/10.48550/arXiv/1112.5309)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J..%2BSchmidhuber&publication_year=2012&title=POWERPLAY%3A%2BTraining%2Ban%2BIncreasingly%2BGeneral%2BProblem%2BSolver%2Bby%2BContinually%2BSearching%2Bfor%2Bthe%2BSimplest%2BStill%2BUnsolvable%2BProblem.&journal=Arxiv)
- 197
	SethA. (2021). **Being You: A New Science of Consciousness.**New York, NY: Dutton.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A..%2BSeth&publication_year=2021&journal=Being+You%3A+A+New+Science+of+Consciousness.)
- 198
	SethA. K. (2014). **The Cybernetic Bayesian. Brain. Open MIND.**Frankfurt am Main: MIND Group, 10.15502/9783958570108
	- [CrossRef](https://doi.org/10.15502/9783958570108)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A.%2BK..%2BSeth&publication_year=2014&journal=The+Cybernetic+Bayesian.+Brain.+Open+MIND.)
- 199
	SethA. K. (2016). **The hard problem of consciousness is a distraction from the real one – Anil K Seth | Aeon Essays. Aeon.** Available online at: [https://aeon.co/essays/the-hard-problem-of-consciousness-is-a-distraction-from-the-real-one](https://aeon.co/essays/the-hard-problem-of-consciousness-is-a-distraction-from-the-real-one) (accessed December 15, 2020).
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A.%2BK..%2BSeth&publication_year=2016&journal=The+hard+problem+of+consciousness+is+a+distraction+from+the+real+one+%E2%80%93+Anil+K+Seth+%7C+Aeon+Essays.+Aeon.)
- 200
	SethA. K.BarrettA. B.BarnettL. (2011). Causal density and integrated information as measures of conscious level.**Philos. Trans. Series A Math. Phys. Eng. Sci.**3693748–3767. 10.1098/rsta.2011.0079
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/21893526)
	- [CrossRef](https://doi.org/10.1098/rsta.2011.0079)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A.%2BK..%2BSeth&author=A.%2BB..%2BBarrett&author=L..%2BBarnett&publication_year=2011&title=Causal%2Bdensity%2Band%2Bintegrated%2Binformation%2Bas%2Bmeasures%2Bof%2Bconscious%2Blevel.&journal=Philos.+Trans.+Series+A+Math.+Phys.+Eng.+Sci.&volume=369&pages=3748-3767)
- 201
	SheaN.FrithC. D. (2019). The Global Workspace Needs Metacognition.**Trends Cogn. Sci.**23560–571. 10.1016/j.tics.2019.04.007
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/31153773)
	- [CrossRef](https://doi.org/10.1016/j.tics.2019.04.007)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=N..%2BShea&author=C.%2BD..%2BFrith&publication_year=2019&title=The%2BGlobal%2BWorkspace%2BNeeds%2BMetacognition.&journal=Trends+Cogn.+Sci.&volume=23&pages=560-571)
- 202
	SingerW. (2001). Consciousness and the binding problem.**Ann. N. Y. Acad. Sci.**929123–146.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=W..%2BSinger&publication_year=2001&title=Consciousness%2Band%2Bthe%2Bbinding%2Bproblem.&journal=Ann.+N.+Y.+Acad.+Sci.&volume=929&pages=123-146)
- 203
	SingerW. (2007). Phenomenal Awareness and Consciousness from a Neurobiological Perspective.**NeuroQuantology** 4134–154. 10.14704/nq.2006.4.2.94
	- [CrossRef](https://doi.org/10.14704/nq.2006.4.2.94)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=W..%2BSinger&publication_year=2007&title=Phenomenal%2BAwareness%2Band%2BConsciousness%2Bfrom%2Ba%2BNeurobiological%2BPerspective.&journal=NeuroQuantology&volume=4&pages=134-154)
- 204
	SleighR. (2003). “GW Leibniz, Monadology (1714),” in **The Classics of Western Philosophy: A Reader’s Guide**, edsGraciaJ. J. E.ReichbergG. M.SchumacherB. N. (Oxford: Blackwell), 277.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=R..%2BSleigh&publication_year=2003&title=GW%2BLeibniz%2C%2BMonadology%2B%281714%29&journal=The+Classics+of+Western+Philosophy%3A+A+Reader%E2%80%99s+Guide)
- 205
	SoaresS.AtallahB. V.PatonJ. J. (2016). Midbrain dopamine neurons control judgment of time.**Science** 3541273–1277. 10.1126/science.aah5234
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/27940870)
	- [CrossRef](https://doi.org/10.1126/science.aah5234)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=S..%2BSoares&author=B.%2BV..%2BAtallah&author=J.%2BJ..%2BPaton&publication_year=2016&title=Midbrain%2Bdopamine%2Bneurons%2Bcontrol%2Bjudgment%2Bof%2Btime.&journal=Science&volume=354&pages=1273-1277)
- 206
	SormazM.MurphyC.WangH.HymersM.KarapanagiotidisT.PoerioG.et al (2018). Default mode network can support the level of detail in experience during active task states.**Proc. Natl. Acad. Sci. U. S. A.**1159318–9323. 10.1073/pnas.1721259115
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/30150393)
	- [CrossRef](https://doi.org/10.1073/pnas.1721259115)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M..%2BSormaz&author=C..%2BMurphy&author=H..%2BWang&author=M..%2BHymers&author=T..%2BKarapanagiotidis&author=G..%2BPoerio&publication_year=2018&title=Default%2Bmode%2Bnetwork%2Bcan%2Bsupport%2Bthe%2Blevel%2Bof%2Bdetail%2Bin%2Bexperience%2Bduring%2Bactive%2Btask%2Bstates.&journal=Proc.+Natl.+Acad.+Sci.+U.+S.+A.&volume=115&pages=9318-9323)
- 207
	SpelkeE. S.KinzlerK. D. (2007). Core knowledge.**Dev. Sci.**1089–96. 10.1111/j.1467-7687.2007.00569.x
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/17181705)
	- [CrossRef](https://doi.org/10.1111/j.1467-7687.2007.00569.x)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=E.%2BS..%2BSpelke&author=K.%2BD..%2BKinzler&publication_year=2007&title=Core%2Bknowledge.&journal=Dev.+Sci.&volume=10&pages=89-96)
- 208
	SrivastavaN.HintonG.KrizhevskyA.SutskeverI.SalakhutdinovR. (2014). Dropout: A simple way to prevent neural networks from overfitting.**J. Mach. Learn. Res.**151929–1958. 10.1109/TCYB.2020.3035282
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/33259321)
	- [CrossRef](https://doi.org/10.1109/TCYB.2020.3035282)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=N..%2BSrivastava&author=G..%2BHinton&author=A..%2BKrizhevsky&author=I..%2BSutskever&author=R..%2BSalakhutdinov&publication_year=2014&title=Dropout%3A%2BA%2Bsimple%2Bway%2Bto%2Bprevent%2Bneural%2Bnetworks%2Bfrom%2Boverfitting.&journal=J.+Mach.+Learn.+Res.&volume=15&pages=1929-1958)
- 209
	Stephenson-JonesM.SamuelssonE.EricssonJ.RobertsonB.GrillnerS. (2011). Evolutionary conservation of the basal ganglia as a common vertebrate mechanism for action selection.**Curr. Biol.**211081–1091. 10.1016/j.cub.2011.05.001
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/21700460)
	- [CrossRef](https://doi.org/10.1016/j.cub.2011.05.001)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M..%2BStephenson-Jones&author=E..%2BSamuelsson&author=J..%2BEricsson&author=B..%2BRobertson&author=S..%2BGrillner&publication_year=2011&title=Evolutionary%2Bconservation%2Bof%2Bthe%2Bbasal%2Bganglia%2Bas%2Ba%2Bcommon%2Bvertebrate%2Bmechanism%2Bfor%2Baction%2Bselection.&journal=Curr.+Biol.&volume=21&pages=1081-1091)
- 210
	SuttererD. W.PolynS. M.WoodmanG. F. (2021). α-Band activity tracks a two-dimensional spotlight of attention during spatial working memory maintenance.**J. Neurophysiol.**125957–971. 10.1152/jn.00582.2020
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/33534657)
	- [CrossRef](https://doi.org/10.1152/jn.00582.2020)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=D.%2BW..%2BSutterer&author=S.%2BM..%2BPolyn&author=G.%2BF..%2BWoodman&publication_year=2021&title=%CE%B1-Band%2Bactivity%2Btracks%2Ba%2Btwo-dimensional%2Bspotlight%2Bof%2Battention%2Bduring%2Bspatial%2Bworking%2Bmemory%2Bmaintenance.&journal=J.+Neurophysiol.&volume=125&pages=957-971)
- 211
	SwansonL. R. (2016). The Predictive Processing Paradigm Has Roots in Kant.**Front. Syst. Neurosci.**10:79. 10.3389/fnsys.2016.00079
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/27777555)
	- [CrossRef](https://doi.org/10.3389/fnsys.2016.00079)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=L.%2BR..%2BSwanson&publication_year=2016&title=The%2BPredictive%2BProcessing%2BParadigm%2BHas%2BRoots%2Bin%2BKant.&journal=Front.+Syst.+Neurosci.&volume=10)
- 212
	TakagiK. (2018). Information-Based Principle Induces Small-World Topology and Self-Organized Criticality in a Large Scale Brain Network.**Front. Comput. Neurosci.**12:65. 10.3389/fncom.2018.00065
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/30131688)
	- [CrossRef](https://doi.org/10.3389/fncom.2018.00065)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=K..%2BTakagi&publication_year=2018&title=Information-Based%2BPrinciple%2BInduces%2BSmall-World%2BTopology%2Band%2BSelf-Organized%2BCriticality%2Bin%2Ba%2BLarge%2BScale%2BBrain%2BNetwork.&journal=Front.+Comput.+Neurosci.&volume=12)
- 213
	TaniJ. (2016). **Exploring robotic minds: Actions, symbols, and consciousness as self-organizing dynamic phenomena.**Oxford: Oxford University Press.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J..%2BTani&publication_year=2016&journal=Exploring+robotic+minds%3A+Actions%2C+symbols%2C+and+consciousness+as+self-organizing+dynamic+phenomena.)
- 214
	TegmarkM. (2000). The importance of quantum decoherence in brain processes.**Phys. Rev. E** 614194–4206. 10.1103/PhysRevE.61.4194
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/11088215)
	- [CrossRef](https://doi.org/10.1103/PhysRevE.61.4194)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M..%2BTegmark&publication_year=2000&title=The%2Bimportance%2Bof%2Bquantum%2Bdecoherence%2Bin%2Bbrain%2Bprocesses.&journal=Phys.+Rev.+E&volume=61&pages=4194-4206)
- 215
	TegmarkM. (2014). **Our Mathematical Universe: My Quest for the Ultimate Nature of Reality.**New York, NY: Knopf Doubleday Publishing Group.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M..%2BTegmark&publication_year=2014&journal=Our+Mathematical+Universe%3A+My+Quest+for+the+Ultimate+Nature+of+Reality.)
- 216
	TegmarkM. (2016). Improved Measures of Integrated Information.**PLoS Comput. Biol.**12:e1005123. 10.1371/journal.pcbi.1005123
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/27870846)
	- [CrossRef](https://doi.org/10.1371/journal.pcbi.1005123)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M..%2BTegmark&publication_year=2016&title=Improved%2BMeasures%2Bof%2BIntegrated%2BInformation.&journal=PLoS+Comput.+Biol.&volume=12)
- 217
	TenenbaumJ. B.KempC.GriffithsT. L.GoodmanN. D. (2011). How to Grow a Mind: Statistics. Structure, and Abstraction.**Science** 3311279–1285. 10.1126/science.1192788
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/21393536)
	- [CrossRef](https://doi.org/10.1126/science.1192788)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J.%2BB..%2BTenenbaum&author=C..%2BKemp&author=T.%2BL..%2BGriffiths&author=N.%2BD..%2BGoodman&publication_year=2011&title=How%2Bto%2BGrow%2Ba%2BMind%3A%2BStatistics.%2BStructure%2C%2Band%2BAbstraction.&journal=Science&volume=331&pages=1279-1285)
- 218
	TerekhovA. V.O’ReganJ. K. (2013). Space as an invention of biological organisms.**Arxiv** \[Preprint\]. 10.48550/arXiv.1308.2124
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/35895330)
	- [CrossRef](https://doi.org/10.48550/arXiv.1308.2124)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A.%2BV..%2BTerekhov&author=J.%2BK..%2BO%E2%80%99Regan&publication_year=2013&title=Space%2Bas%2Ban%2Binvention%2Bof%2Bbiological%2Borganisms.&journal=Arxiv)
- 219
	TerekhovA. V.O’ReganJ. K. (2016). Space as an Invention of Active Agents.**Front. Robot. AI** 3:4. 10.3389/frobt.2016.00004
	- [CrossRef](https://doi.org/10.3389/frobt.2016.00004)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A.%2BV..%2BTerekhov&author=J.%2BK..%2BO%E2%80%99Regan&publication_year=2016&title=Space%2Bas%2Ban%2BInvention%2Bof%2BActive%2BAgents.&journal=Front.+Robot.+AI&volume=3)
- 220
	ThomasV.BengioE.FedusW.PondardJ.BeaudoinP.LarochelleH.et al (2018). Disentangling the independently controllable factors of variation by interacting with the world.**Arxiv** \[Preprint\]. 10.48550/arXiv.1802.09484
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/35895330)
	- [CrossRef](https://doi.org/10.48550/arXiv.1802.09484)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=V..%2BThomas&author=E..%2BBengio&author=W..%2BFedus&author=J..%2BPondard&author=P..%2BBeaudoin&author=H..%2BLarochelle&publication_year=2018&title=Disentangling%2Bthe%2Bindependently%2Bcontrollable%2Bfactors%2Bof%2Bvariation%2Bby%2Binteracting%2Bwith%2Bthe%2Bworld.&journal=Arxiv)
- 221
	TomaselloM. (2014). **A Natural History of Human Thinking.**Cambridge, MA: Harvard University Press.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M..%2BTomasello&publication_year=2014&journal=A+Natural+History+of+Human+Thinking.)
- 222
	TononiG.BolyM.MassiminiM.KochC. (2016). Integrated information theory: From consciousness to its physical substrate.**Nat. Rev. Neurosci.**17:450. 10.1038/nrn.2016.44
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/27225071)
	- [CrossRef](https://doi.org/10.1038/nrn.2016.44)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=G..%2BTononi&author=M..%2BBoly&author=M..%2BMassimini&author=C..%2BKoch&publication_year=2016&title=Integrated%2Binformation%2Btheory%3A%2BFrom%2Bconsciousness%2Bto%2Bits%2Bphysical%2Bsubstrate.&journal=Nat.+Rev.+Neurosci.&volume=17)
- 223
	VanchurinV. (2020). The World as a Neural Network.**Entropy** 22:1210. 10.3390/e22111210
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/33286978)
	- [CrossRef](https://doi.org/10.3390/e22111210)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=V..%2BVanchurin&publication_year=2020&title=The%2BWorld%2Bas%2Ba%2BNeural%2BNetwork.&journal=Entropy&volume=22)
- 224
	VarelaF. J.ThompsonE. T.RoschE. (1992). **The Embodied Mind: Cognitive Science and Human Experience* (Revised ed. edition)*. Cambridge, MA: The MIT Press.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=F.%2BJ..%2BVarela&author=E.%2BT..%2BThompson&author=E..%2BRosch&publication_year=1992&journal=The+Embodied+Mind%3A+Cognitive+Science+and+Human+Experience+%28Revised+ed.+edition%29)
- 225
	VulE.GoodmanN.GriffithsT. L.TenenbaumJ. B. (2014). One and done? Optimal decisions from very few samples.**Cogn. Sci.**38599–637. 10.1111/cogs.12101
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/24467492)
	- [CrossRef](https://doi.org/10.1111/cogs.12101)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=E..%2BVul&author=N..%2BGoodman&author=T.%2BL..%2BGriffiths&author=J.%2BB..%2BTenenbaum&publication_year=2014&title=One%2Band%2Bdone%3F%2BOptimal%2Bdecisions%2Bfrom%2Bvery%2Bfew%2Bsamples.&journal=Cogn.+Sci.&volume=38&pages=599-637)
- 226
	WangJ. X.Kurth-NelsonZ.KumaranD.TirumalaD.SoyerH.LeiboJ. Z.et al (2018). Prefrontal cortex as a meta-reinforcement learning system.**Nat. Neurosci.**21:860. 10.1038/s41593-018-0147-8
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/29760527)
	- [CrossRef](https://doi.org/10.1038/s41593-018-0147-8)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J.%2BX..%2BWang&author=Z..%2BKurth-Nelson&author=D..%2BKumaran&author=D..%2BTirumala&author=H..%2BSoyer&author=J.%2BZ..%2BLeibo&publication_year=2018&title=Prefrontal%2Bcortex%2Bas%2Ba%2Bmeta-reinforcement%2Blearning%2Bsystem.&journal=Nat.+Neurosci.&volume=21)
- 227
	WangT.RoychowdhuryJ. (2019). “OIM: Oscillator-based Ising Machines for Solving Combinatorial Optimisation Problems,” in **Unconventional Computation and Natural Computation. UCNC 2019. Lecture Notes in Computer Science**, edsMcQuillanI.SekiS. (Cham: Springer), 232–256.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=T..%2BWang&author=J..%2BRoychowdhury&publication_year=2019&title=OIM%3A%2BOscillator-based%2BIsing%2BMachines%2Bfor%2BSolving%2BCombinatorial%2BOptimisation%2BProblems&journal=Unconventional+Computation+and+Natural+Computation.+UCNC+2019.+Lecture+Notes+in+Computer+Science&pages=232-256)
- 228
	WhyteC. J.SmithR. (2020). The predictive global neuronal workspace: A formal active inference model of visual consciousness.**Progress Neurobiol.**199:101918. 10.1016/j.pneurobio.2020.101918
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/33039416)
	- [CrossRef](https://doi.org/10.1016/j.pneurobio.2020.101918)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=C.%2BJ..%2BWhyte&author=R..%2BSmith&publication_year=2020&title=The%2Bpredictive%2Bglobal%2Bneuronal%2Bworkspace%3A%2BA%2Bformal%2Bactive%2Binference%2Bmodel%2Bof%2Bvisual%2Bconsciousness.&journal=Progress+Neurobiol.&volume=199)
- 229
	WillifordK.BennequinD.FristonK.RudraufD. (2018). The Projective Consciousness Model and Phenomenal Selfhood.**Front. Psychol.**9:2571. 10.3389/fpsyg.2018.02571
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/30618988)
	- [CrossRef](https://doi.org/10.3389/fpsyg.2018.02571)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=K..%2BWilliford&author=D..%2BBennequin&author=K..%2BFriston&author=D..%2BRudrauf&publication_year=2018&title=The%2BProjective%2BConsciousness%2BModel%2Band%2BPhenomenal%2BSelfhood.&journal=Front.+Psychol.&volume=9)
- 230
	WittmannM. (2017). **Felt Time: The Science of How We Experience Time* (Reprint edition)*. Cambridge, MA: The MIT Press.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M..%2BWittmann&publication_year=2017&journal=Felt+Time%3A+The+Science+of+How+We+Experience+Time+%28Reprint+edition%29)
- 231
	WolframS. (2002). **A New Kind of Science.**Champaign, IL: Wolfram Media.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=S..%2BWolfram&publication_year=2002&journal=A+New+Kind+of+Science.)
- 232
	WuL.ZhangY. (2006). A new topological approach to the L8-uniqueness of operators and the L1-uniqueness of Fokker–Planck equations.**J. Funct. Anal.**241557–610. 10.1016/j.jfa.2006.04.020
	- [CrossRef](https://doi.org/10.1016/j.jfa.2006.04.020)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=L..%2BWu&author=Y..%2BZhang&publication_year=2006&title=A%2Bnew%2Btopological%2Bapproach%2Bto%2Bthe%2BL8-uniqueness%2Bof%2Boperators%2Band%2Bthe%2BL1-uniqueness%2Bof%2BFokker%E2%80%93Planck%2Bequations.&journal=J.+Funct.+Anal.&volume=241&pages=557-610)
- 233
	WyartV.Tallon-BaudryC. (2008). Neural Dissociation between Visual Awareness and Spatial Attention.**J. Neurosci.**282667–2679. 10.1523/JNEUROSCI.4748-07.2008
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/18322110)
	- [CrossRef](https://doi.org/10.1523/JNEUROSCI.4748-07.2008)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=V..%2BWyart&author=C..%2BTallon-Baudry&publication_year=2008&title=Neural%2BDissociation%2Bbetween%2BVisual%2BAwareness%2Band%2BSpatial%2BAttention.&journal=J.+Neurosci.&volume=28&pages=2667-2679)
- 234
	ZadorA. M. (2019). A critique of pure learning and what artificial neural networks can learn from animal brains.**Nat. Commun.**10:3770. 10.1038/s41467-019-11786-6
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/31434893)
	- [CrossRef](https://doi.org/10.1038/s41467-019-11786-6)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A.%2BM..%2BZador&publication_year=2019&title=A%2Bcritique%2Bof%2Bpure%2Blearning%2Band%2Bwhat%2Bartificial%2Bneural%2Bnetworks%2Bcan%2Blearn%2Bfrom%2Banimal%2Bbrains.&journal=Nat.+Commun.&volume=10)
- 235
	ZhouJ.CuiG.ZhangZ.YangC.LiuZ.WangL.et al (2019). Graph Neural Networks: A Review of Methods and Applications.**Arxiv** \[Preprint\]. 10.48550/arXiv.1812.08434
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/35895330)
	- [CrossRef](https://doi.org/10.48550/arXiv.1812.08434)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J..%2BZhou&author=G..%2BCui&author=Z..%2BZhang&author=C..%2BYang&author=Z..%2BLiu&author=L..%2BWang&publication_year=2019&title=Graph%2BNeural%2BNetworks%3A%2BA%2BReview%2Bof%2BMethods%2Band%2BApplications.&journal=Arxiv)

## Summary

Keywords

consciousness, Integrated Information Theory (IIT), Global Neuronal Workspace Theory (GNWT), Free Energy Principle and Active Inference (FEP-AI) Framework, predictive turbo autoencoding, expander graphs, shared latent spaces, Graph Neural Networks (GNNs)

Citation

Safron A (2022) Integrated world modeling theory expanded: Implications for the future of consciousness. *Front. Comput. Neurosci.* 16:642397. doi: [10.3389/fncom.2022.642397](http://dx.doi.org/10.3389/fncom.2022.642397)

Received

16 December 2020

Accepted

24 October 2022

Published

24 November 2022

Volume

16 - 2022

Edited by

Xerxes D. Arsiwalla, Pompeu Fabra University, Spain

Reviewed by

Arthur Juliani, ARAYA Inc., Japan; Carlos Montemayor, San Francisco State University, United States

Updates

Copyright