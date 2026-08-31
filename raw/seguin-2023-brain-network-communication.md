---
title: "Brain network communication: concepts, models and applications - Nature Reviews Neuroscience"
source: "https://www.nature.com/articles/s41583-023-00718-5"
author:
  - "[[Caio Seguin]]"
  - "[[Olaf Sporns]]"
  - "[[Andrew Zalesky]]"
published: 2023-07-12
created: 2026-08-31
description: "Understanding communication and information processing in nervous systems is a central goal of neuroscience. Over the past two decades, advances in connectomics and network neuroscience have opened new avenues for investigating polysynaptic communication in complex brain networks. Recent work has brought into question the mainstay assumption that connectome signalling occurs exclusively via shortest paths, resulting in a sprawling constellation of alternative network communication models. This Review surveys the latest developments in models of brain network communication. We begin by drawing a conceptual link between the mathematics of graph theory and biological aspects of neural signalling such as transmission delays and metabolic cost. We organize key network communication models and measures into a taxonomy, aimed at helping researchers navigate the growing number of concepts and methods in the literature. The taxonomy highlights the pros, cons and interpretations of different conceptualizations of connectome signalling. We showcase the utility of network communication models as a flexible, interpretable and tractable framework to study brain function by reviewing prominent applications in basic, cognitive and clinical neurosciences. Finally, we provide recommendations to guide the future development, application and validation of network communication models. Developments in connectomics and network neuroscience over the past 20 years have led to new ways of investigating communication in complex brain networks. In this Review, Seguin, Sporns and Zalesky discuss the current landscape of models of brain network communication."
tags:
  - "clippings"
---
## Abstract

Understanding communication and information processing in nervous systems is a central goal of neuroscience. Over the past two decades, advances in connectomics and network neuroscience have opened new avenues for investigating polysynaptic communication in complex brain networks. Recent work has brought into question the mainstay assumption that connectome signalling occurs exclusively via shortest paths, resulting in a sprawling constellation of alternative network communication models. This Review surveys the latest developments in models of brain network communication. We begin by drawing a conceptual link between the mathematics of graph theory and biological aspects of neural signalling such as transmission delays and metabolic cost. We organize key network communication models and measures into a taxonomy, aimed at helping researchers navigate the growing number of concepts and methods in the literature. The taxonomy highlights the pros, cons and interpretations of different conceptualizations of connectome signalling. We showcase the utility of network communication models as a flexible, interpretable and tractable framework to study brain function by reviewing prominent applications in basic, cognitive and clinical neurosciences. Finally, we provide recommendations to guide the future development, application and validation of network communication models.

## Introduction

Nervous systems are communication networks [^1] [^2]. Signalling and information transfer between [neural elements](https://www.nature.com/articles/s41583-023-00718-5#Glos1) permeate every facet and spatial scale of brain function — from neuron-to-neuron synaptic transmission [^3], to interactions between neuronal populations [^4], to whole-brain patterns of regional co-activation [^5]. Understanding the mechanisms that govern the flexible regulation of neural signalling is one of the enduring challenges of modern neuroscience. Efforts to address this question span multiple directions of investigation, including, to name a few examples, research on neural coding [^6], synchrony and coherence of neural oscillations [^7] [^8], interareal communication subspaces [^9] [^10], and computational models of neural dynamics [^11] [^12]. The topic of communication is therefore as broad as it is central to neuroscientific inquiry.

In the past two decades, connectomics and network neuroscience have emerged as prominent fields concerned with the structure and function of nervous systems [^13] [^14] [^15]. Network neuroscience provides a framework to investigate how the complex connectivity of brain networks facilitates and constrains neural information transfer [^1]. This approach — bolstered by comprehensive maps of brain connectivity and the mathematics of graph theory — stands in important contrast to other researches on neural communication, which is typically focused on signalling between small numbers of physically connected neurons or regions [^10] [^16]. Instead, network neuroscience aims to understand polysynaptic signalling through [complex networks](https://www.nature.com/articles/s41583-023-00718-5#Glos2) of anatomical connections, and how neural communication ultimately gives rise to the rich functional dynamics observed in nervous systems [^17] [^18].

Structural brain networks — [connectomes](https://www.nature.com/articles/s41583-023-00718-5#Glos3) [^19] — are organized according to a host of complex topological properties, including a core of densely interconnected hubs [^20], modular and hierarchical structure [^21], and small-world architecture [^22]. Universally found across species and spatial scales [^23], these principles of brain organization are conjectured to result from evolutionary pressures for efficient neural communication [^24] [^25]. Interareal signalling is thought to enable distant regions to orchestrate their activity in response to changing cognitive and behavioural demands [^26] [^27], whereas impairments to neural communication may be involved in the aetiology and symptomatology of diverse neuropsychiatric conditions [^28] [^29] [^30]. Therefore, elucidating the mechanisms governing connectome communication is crucial to the advancement of basic, cognitive and clinical brain sciences.

One of the earliest and most influential discoveries in network neuroscience was that connectomes are small-world networks [^22] [^31]. Similar to many other complex networks [^32], the brain combines high clustering — neural elements tend to form tight-knit groups — and short characteristic path length — distant element pairs are, on average, separated by a small number of intermediate connections. This finding provided a graph-theoretical basis for the conceptualization of the brain as a network that balances functional segregation and integration, equipped both with modules for localized information processing and efficient routes for long-range signalling [^24] [^33] [^34].

Beyond characterizing connectome organization, the popularity of the small-world phenomenon in early network neuroscience crystallized assumptions about connectome communication [^15] [^35]. The characteristic path length quantifies network integration by taking into account only the paths that minimize the number of steps between network nodes. The same holds for other graph measures that are widely adopted to study brain connectivity, such as global efficiency and betweenness centrality [^36]. Commonly interpreted in the context of connectome communication and signal transmission [^25] [^33] [^37] [^38], analyses based on these measures assume — often tacitly — that neural signalling is routed exclusively via shortest paths.

In recent years, a growing number of studies have questioned the shortest path assumption [^39] [^40] [^41]. As we elaborate subsequently, a central argument in this direction is that the computation of shortest paths presupposes global knowledge of [network topology](https://www.nature.com/articles/s41583-023-00718-5#Glos5) [^42] [^43]. This means that identifying the shortest path linking a single pair of nodes mandates information about the connectivity between all other nodes in the network. Although this requirement may be reasonable for engineered systems — in which a central controller often has access to a bird’s eye view of the entire network — brain networks are [decentralized systems](https://www.nature.com/articles/s41583-023-00718-5#Glos6), in which individual elements are unlikely to possess complete information about the network in which they are embedded [^1] [^15] [^35] [^44].

In the light of this point, a large number of alternative brain [network communication models](https://www.nature.com/articles/s41583-023-00718-5#Glos7) have been proposed [^1]. Inspired by other scientific domains predicated on decentralized network communication — from social sciences [^45] to internet engineering [^46] — these models seek to understand how information can be transmitted through neural connectivity in an efficient yet biologically plausible manner. An emerging body of evidence indicates that measures of connectome communication stemming from these models are associated with a range of physiological [^47] [^48], behavioural [^49] [^50] and clinical variables [^51] [^52] [^53].

In this Review, we summarize the latest developments in models of brain network communication. We focus on models that leverage concepts from graph theory and network science to describe and quantify information transfer in structural connectomes. Our primary goal is to help researchers to navigate, apply and interpret the growing number of methods in the literature. The remainder of this Review is organized into four parts. First, we introduce the basic concepts and terminology used throughout the paper. We draw a link between mathematical concepts of graph theory and biological aspects of neural signalling. Second, we organize prominent network communication models and measures into a taxonomy of signalling conceptualizations that provides an overview of the literature. We also provide a qualitative assessment of the biological plausibility of network communication models. Third, we survey current and emerging applications of these models in the key areas of fundamental, cognitive and clinical brain sciences. We showcase network communication as a versatile framework to study brain function and discuss the present empirical evidence in favour of different signalling conceptualizations. Finally, we provide a future outlook by suggesting recommendations to guide the development, application and validation of network communication models.

## From graph theory to brain network communication

From neurons to brain regions, it is well established that structural connections facilitate direct communication between physically linked neural elements [^3] [^54]. Observations of signalling between physically unconnected elements are, however, less well understood. For instance, the complete connectomes of the nematode *Caenorhabditis elegans* and the *Drosophila melanogaster* fruitfly larva are characterized by polysynaptic streams of information flow between sensory and motor neurons [^55] [^56]. At the macroscale of human brain imaging, patterns of strong functional co-activation between structurally unconnected grey matter regions have been extensively reported [^57] [^58]. Relatedly, electrophysiological recordings acquired during focal brain stimulation show consistent evoked responses in downstream regions that were not intersected by white matter projections from the stimulated site [^59] [^60]. These examples illustrate that neural dynamics is supported not only by interactions between directly connected elements but also by [polysynaptic communication](https://www.nature.com/articles/s41583-023-00718-5#Glos8) involving distant and anatomically unconnected neurons or regions. Moreover, these reports demonstrate the many ways in which information transfer can be operationalized and studied in brain networks — from microscopic synaptic transmissions, to intrinsic functional synchrony expressed at multiple spatiotemporal resolutions, to the global spread of local exogenous perturbations.

Graph theory and network science provide a mathematical basis for understanding polysynaptic communication in complex brain networks [^13] [^14] [^15]. By abstracting biological neural signalling to network communication dynamics, this theoretical framework offers a flexible approach to model interactions between interconnected neural elements.

Consider, for example, the macroscale human connectome in Fig. [1a](https://www.nature.com/articles/s41583-023-00718-5#Fig1). Nodes $i$ and $j$ represent a pair of brain regions that are not directly connected via an axonal fibre bundle. How is communication established between $i$ and $j$? As they are anatomically unconnected, signalling must be mediated by a sequence of intermediary regions and connections. The complex topology of the connectome offers an astounding number of possible routes to travel between $i$ and $j$. Brain network communication models describe strategies to communicate signals through the connectome.

![Fig. 1: Core concepts in brain network communication models.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41583-023-00718-5/MediaObjects/41583_2023_718_Fig1_HTML.png?as=webp)

Fig. 1: Core concepts in brain network communication models.

Here, we outline three main families of brain network communication models [^44]. [Routing protocols](https://www.nature.com/articles/s41583-023-00718-5#Glos9) propose that signalling takes place via a small number of efficient, selectively accessed paths. [Diffusion processes](https://www.nature.com/articles/s41583-023-00718-5#Glos10), by contrast, propose that signals diffuse through the connectome, potentially spreading simultaneously along multiple network fronts or following random walk dynamics. [Parametric models](https://www.nature.com/articles/s41583-023-00718-5#Glos4) combine elements of routing and diffusion, contributing hybrid strategies that tend towards communication via efficient paths or random walks, depending on how the parameters of the model are tuned. Each of these broad categories comprises a range of specific models.

A network communication model formalizes a conceptualization of neural signalling — for example, via routing or diffusion — into a well-defined algorithm to guide signals across the connectome. For instance, a model might describe a procedure to identify efficient paths between pairs of nodes. In turn, a [network communication measure](https://www.nature.com/articles/s41583-023-00718-5#Glos12) quantifies a property of signal transfer under a given model, for example, the cost of sending signals along a path delineated by a model. Communication measures can capture cost, efficiency, resilience or other aspects of signalling. Computed on a connectome, a network communication measure yields a communication matrix, which quantifies putative properties of signalling between every pair of nodes — anatomically connected or unconnected — under a model of network communication (Fig. [1b](https://www.nature.com/articles/s41583-023-00718-5#Fig1)).

The paths and walks in Fig. [1a](https://www.nature.com/articles/s41583-023-00718-5#Fig1) vary in their suitability as inter-regional communication channels. Intuitively, ‘short’ paths, comprising few connections, are more favourable than ‘long’ paths through many intermediate regions. Here, the terms short and long characterize the cost associated with propagating signals along a path, known as the path length. Of all the possible ways to travel between $i$ and $j$, the shortest path is the most efficient. By minimizing the number of steps between two nodes, the shortest path minimizes both the delay in signal transmission and the metabolic expenditure of crossing synapses and propelling signals along axons [^15] [^61]. However, routing signals via shortest paths requires knowledge about the entire network topology [^62]; as such, identifying the set of connections comprising the shortest path between $i$ and $j$ mandates strong assumptions about the amount of topological information available to individual network elements.

The previous paragraph introduces three [dimensions of network communication cost](https://www.nature.com/articles/s41583-023-00718-5#Glos16): delay, information and energy. The [delay cost](https://www.nature.com/articles/s41583-023-00718-5#Glos15) refers to the topological efficiency (or speed) of signal transmission; the [informational cost](https://www.nature.com/articles/s41583-023-00718-5#Glos14) refers to the amount of knowledge of network properties required to guide signal propagation; and the [energetic cost](https://www.nature.com/articles/s41583-023-00718-5#Glos13) refers to the amount of metabolic resources necessary for signalling. These cost dimensions are putative evolutionary drivers that shaped connectome organization and signalling mechanisms to promote fast and frugal integration of information in the brain [^61] [^63] [^64]. They also offer conceptual guidelines to assess the biological plausibility of candidate models of brain network communication [^62]. The ideal model would achieve fast communication and economic signal transmission, and rely on knowledge assumptions befitting decentralized systems — that is, low delay, energetic and informational costs, respectively. In practice, however, as exemplified by the case of shortest path routing, reconciling these factors is difficult, and communication models typically strike trade-offs between these three dimensions. As we discuss in the coming sections, certain conceptualizations of signalling achieve well-balanced compromises between factors, potentially constituting more biologically plausible strategies of neural communication.

## A taxonomy of brain network communication models and measures

In this section, we organize families, models and measures of network communication into a tree taxonomy (Fig. [2](https://www.nature.com/articles/s41583-023-00718-5#Fig2)). We focus on describing key conceptual features of different models, with an emphasis on qualitative evaluations of their pros and cons along dimensions of communication cost. Prominent network communication measures stemming from the routing protocols, diffusion processes and parametric models families are presented in Boxes [1](https://www.nature.com/articles/s41583-023-00718-5#Sec4) – [3](https://www.nature.com/articles/s41583-023-00718-5#Sec6).

![Fig. 2: A taxonomy of brain network communication models and measures.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41583-023-00718-5/MediaObjects/41583_2023_718_Fig2_HTML.png?as=webp)

Fig. 2: A taxonomy of brain network communication models and measures.

### Routing protocols

This family of network communication models proposes that signals are routed through the connectome along single, selectively accessed paths. Akin to transmission processes in engineered networks, routing protocols aim to identify paths comprising a small number of strong and reliable connections, so that signals are communicated efficiently and faithfully. In the context of the connectome, this focus on speed and fidelity means that routing models are characterized by low delay and energetic costs [^24]. By contrast, the identification of efficient paths typically depends on strong assumptions about the knowledge available to individual network elements [^44] and therefore routing protocols are usually associated with medium to high informational costs.

#### Shortest path routing

Shortest path routing is the most widely used communication model to characterize information integration in brain networks [^14] [^36]. This model proposes that signalling between a pair of regions takes place along the most efficient path linking them. Therefore, by definition, shortest path routing achieves optimal signalling delay. The selective character of this model — communication unfolds exclusively via shortest paths — also means that signalling is optimally frugal in terms of metabolic expenses. However, the key disadvantage of the model lies in the strategy used to identify optimal communication routes, an algorithmic procedure that requires each individual network element to have knowledge about the entire network [^42] [^43] [^45]. Shortest path routing therefore entails an exceedingly high informational cost, indicating that this strategy would be difficult to implement in decentralized nervous systems [^1] [^15] [^35] [^44]. Although it is conceivable that information about network topology could be dynamically encoded by neural activity, evidence for such centralized descriptions of global connectivity is currently lacking. Signalling under the shortest path routing model can be quantified by several network communication measures (Box [1](https://www.nature.com/articles/s41583-023-00718-5#Sec4)).

#### Navigation

Navigation is a decentralized routing protocol that does not mandate individual nodes to possess global knowledge of network topology [^42] [^45]. It proposes a strategy to identify communication paths on the basis of local knowledge of a node distance metric [^65]. Routing from source to target nodes follows a simple strategy: starting from the source, each node forwards the signal to its neighbour that is closest in distance to the target. Navigation is also commonly referred to as ‘greedy routing’, as each step of the communication process seeks to minimize the distance to the target. This heuristic is not guaranteed to identify efficient paths between nodes. In fact, unlike most network communication models, signalling under navigation can fail — greedy routing can become trapped in a loop between intermediary nodes and never reach the intended target. Nonetheless, complex networks are known to be highly navigable [^43] [^66]. This means that navigation can successfully propagate signals between nodes and do so by identifying paths with efficiency comparable to that of shortest paths (Box [1](https://www.nature.com/articles/s41583-023-00718-5#Sec4)).

Successful network navigation must be guided by a distance metric that reflects the probability of node pairs forming connections [^43] [^67]. A simple approach to navigate macroscale brain networks is to consider the Euclidean distance between nodes. This choice is motivated by the natural embedding of the brain in 3D space and the strong relationship between structural connectivity strength and Euclidean distance [^68] [^69]. Remarkably, greedy routing in Euclidean space identified paths with 70–100% of optimal signalling efficiency (that is, compared with shortest paths) in human, mouse and macaque connectomes [^41]. Recent work has shown that human connectome navigation can also be guided by cortical hierarchies, wherein navigation paths are identified on the basis of inter-regional distances along the unimodal to transmodal functional axis [^70]. An alternative line of research in the field of network geometry [^71] proposes that brain networks are embedded in hyperbolic spaces, an abstract geometry that combines spatial and topological network features [^72] [^73].

The main disadvantage of navigation is its informational cost. Signal propagation presupposes that regions know the distance between their neighbours and a desired target region. Although there is evidence that this requirement could be met in some biological systems [^74], it is unclear how this knowledge would be available to individual neural elements comprising brain networks. Importantly, the informational cost of navigation remains considerably lower than that of shortest path routing. Navigation unfolds in a decentralized iterative manner, in which each node along the path needs only local knowledge about the spatial positioning of their neighbours in relation to the target, as opposed to global knowledge of the entire network. Despite this decentralized character, navigation achieves delays comparable to that of shortest paths [^41]. In addition, as signals are modelled to unfold exclusively along navigation paths, this strategy also entails low energetic costs. Therefore, navigation balances a medium informational cost with low delay and energetic costs, potentially constituting a more biologically realistic routing strategy than shortest paths.

### Diffusion processes

Diffusion processes propose a dispersive conceptualization of neural communication, in which signals are broadcast along multiple network fronts or propagated via random walk dynamics. In contrast to routing protocols, diffusion processes do not require individual neural elements to possess knowledge about the connectome beyond their immediate vicinity. However, this type of propagation requires many more signal retransmissions to establish communication between nodes. Therefore, models in this family typically benefit from low informational costs but suffer from elevated signalling delays and energetic costs.

#### Random walks

Random walks are the most popular model of diffusion processes on networks, being used to study the dynamics of complex systems from a broad range of scientific domains (see ref. [^75] for a comprehensive review). Here, we focus on unbiased random walks, the simplest form of network diffusion, and one that has received considerable attention as a brain network communication model.

In a random walk, a signal starting from a source node is transmitted to a randomly chosen neighbour with probability proportional to their connection weight. This rule is followed for each new node until, eventually, a desired target node is reached. This process is called ‘unbiased’ because the decision of which node to visit next is based solely on local connectivity, with no other factor influencing signal propagation. To implement this strategy, a node is only required to be aware of its own connectivity, an assumption that can be conceivably met by individual neural elements. The low informational cost of random walks comes at the detriment of elevated delay and energetic costs. Intuitively, random signal propagation results in walks that are markedly longer than shortest paths. Signal retransmission across many synaptic junctions and axonal projections renders inter-regional communication slow and metabolically expensive.

In line with this conceptual evaluation, empirical studies have found that random walks result in poor signalling efficiency in the human connectome [^44] [^63]. This was assessed using the mean first passage time [^76], a measure that quantifies the average number of steps necessary for a random walk to first visit a desired target after starting from a given source node. The diffusion efficiency [^44] is defined as the reciprocal of the mean first passage time. These measures can be interpreted as the expected walk length and walk efficiency from source to target regions, a concept analogous to the measures of routing protocols. More interestingly, beyond signalling efficiency per se, a host of useful diffusion-based measures quantify the interplay between brain network topology and random walk dynamics (Box [2](https://www.nature.com/articles/s41583-023-00718-5#Sec5)).

#### Broadcasting (communicability)

Broadcasting is a diffusion process in which signals are simultaneously propagated along multiple fronts of the network. So far, we have explored communication models that identify — either by routing protocol or by random selection — a single node to which the signal should be sent next. Instead, at each step of broadcasting, a signal is simultaneously propagated to many nodes. Here, we focus on communicability [^77] [^78], a specific broadcasting model that has been extensively explored in brain networks.

Communicability considers that signalling unfolds along all walks in the network. To understand this, consider a simple broadcasting strategy: starting from a source, regions always propagate the signal to all of their neighbours. Initially, the source sends the signal to regions it is directly connected to. The first step delineates all walks of unitary length from the source. Next, all regions that received the signal propagate it to all of their neighbours, delineating all possible walks of length 2 starting from the source. Importantly, this process is indifferent to whether a region has already received the signal — the set of all walks of length 2 includes the ones that backtrack to the source and those that re-communicate the signal among the neighbours of the source (in the case of a connection between them). The *n* th broadcasting step delineates the set of all walks of length $n$ from the source. Ultimately, signalling from the source to a target node is shaped by all walks of length $n=1,...,\infty$ between them.

The communicability between two nodes is analytically computed as a weighted sum of the total number of walks linking them (Box [2](https://www.nature.com/articles/s41583-023-00718-5#Sec5)). Crucially, the contribution of each walk is weighted according to $1/n!$, thus ensuring that short walks are assigned greater importance than long ones. As a result, communication takes place predominantly along short walks, with the overall contribution of inefficient walks quickly vanishing as they become longer.

The set of all possible walks between two nodes includes their shortest path. Because signals simultaneously diffuse along all walks, the delay between a signal first leaving the source and first arriving at the target under broadcasting is the same as the delay under shortest path routing. Intuitively, however, this strategy entails exceedingly high metabolic expenditure. Although this shortcoming is lessened by the discounting of long walks (as the contributions of long walks decrease with length, it can be assumed that their energetic burden is similarly discounted), it remains that communicability entails a large number of signal retransmissions. In summary, communicability’s formalization of broadcasting achieves low delay and informational costs, at the detriment of high energetic cost.

### Parametric models

The defining characteristic of models in this family is that their behaviour is controlled by a tunable parameter, which is defined along a continuum of possible values. At either end of this spectrum, parameter values typically approximate communication via routing or diffusion, whereas intermediate values implement hybrid strategies. Careful parameter tuning can result in composite policies that strike advantageous trade-offs among delay, informational and energetic costs that are not accessible from the opposite standpoints of routing and diffusion.

#### Linear threshold model

The linear threshold model aims to describe how perturbations to individual nodes propagate across the network [^79] [^80]. Closely related to broadcasting, this model proposes that local perturbations trigger communication cascades that spread along multiple network fronts. At any given point in time, nodes are modelled to be in either ‘active’ or ‘inactive’ states, with the first representing network elements to which the perturbation has been propagated. Transmission to a node occurs on the basis of the state of its neighbours — a node becomes active if a large enough proportion of its neighbourhood is active. This proportion is encoded by the threshold parameter of the model $\theta \in [\mathrm{0,1}]$, a value that controls the speed and size of cascades (Box [3](https://www.nature.com/articles/s41583-023-00718-5#Sec6)).

Setting $\theta =0$ implements a broadcasting process in which signals are always propagated to all neighbours of active nodes. In this scenario, perturbation of any node results in activation quickly spreading to encompass the entire network, referred to as a complete cascade. As $\theta$ increases, larger active proportions of a node’s neighbourhood are required for propagation, and cascades become slower and smaller. The critical value $\theta \,={\theta }_{{\rm{c}}}$ is the maximum threshold for which any perturbation to a single node results in a complete cascade. Beyond this point, signalling becomes increasingly restricted to the vicinity of sources.

To date, applications of the linear threshold model to brain networks have considered $\theta \,={\theta }_{{\rm{c}}}$ (refs. [^81] [^82] [^83]). These studies report that the trajectory of complete cascades is considerably shaped by efficient communication paths [^81]. Importantly, cascade spread is determined by local knowledge of node activation — a node becomes active based solely on the status of their immediate neighbours. Therefore, the interaction between connectome topology and the linear threshold model results in good signalling efficiency at a low informational cost. As with broadcasting, these benefits come at the price of high energetic cost owing to multiple signal transmissions. Importantly, however, contrary to communicability, the linear threshold model does not consider multiple retransmissions to nodes that are already active. Therefore, in terms of energy cost, the linear threshold model can be considered to have a moderate energetic cost and occupy a middle ground between diffusion and routing models.

#### Biased random walks

In unbiased random walks, signals are propagated using only local topological knowledge, that is, for a current node $i$, the walk transitions to a node $j$ with probability proportional to the $ij$ connection weight. By contrast, biased random walks use additional factors to influence (bias) transition probabilities [^84] [^85]. In domain-specific applications, bias factors can represent intrinsic properties of network elements (for example, the status of a person in a social network), which influence walks towards certain nodes or along gradients extending through the network [^86]. Alternatively, random walks can also be biased by topological attributes, such as node centrality [^87] [^88].

We focus on a parametrized formulation of biased random walks that has been recently applied to investigate communication in brain networks [^62]. In this model, a parameter $\lambda$ controls the amount of global topological information available to individual nodes. For $\lambda =0$, no bias is introduced and nodes only have access to their own connection weights; as such, communication takes place via unbiased random walks. Increasing $\lambda$ progressively steers walks along efficient routes. This is achieved by endowing nodes with information on which of their neighbours is more likely to be on the shortest path to a desired target and biasing transition probabilities towards the selection of this neighbour. At the limit $\lambda \to \infty$, the biased random walk converges to shortest path routing, with the probability of transitioning to any node outside the shortest path to a target vanishing to zero.

Biased random walks span a continuous spectrum of communication strategies ranging from unbiased random walks to shortest path routing. As such, the performance of this model in the dimensions of communication cost is entirely dependent on the value of $\lambda$. More importantly, this model offers a flexible approach to explore communication dynamics in brain networks, in which systematic variation of $\lambda$ allows for quantitative analyses of the trade-off between delay and informational costs (Box [3](https://www.nature.com/articles/s41583-023-00718-5#Sec6)).

#### Shortest path ensembles

The shortest path ensembles model proposes that signals travel between two nodes via ensembles comprising the *k* most efficient paths linking them [^40]. Traditional shortest path routing corresponds to the particular case *k*  = 1, for which signals utilize only the single most efficient path between nodes. Shortest path ensembles highlight that, although high efficiency is adaptive, there is no principled rationale as to why neural communication would take place exclusively via optimally short paths [^15]. Indeed, empirical analyses show that only a small proportion of connections are used by the shortest paths between all pairs of nodes in the connectome [^40] [^41]. As such, under a regime of strictly optimal routing, the vast majority of axonal projections in the brain would have no role in supporting global signal traffic. Parametrizing the number of paths involved in neural communication enables a systematic relaxation of this assumption (Box [3](https://www.nature.com/articles/s41583-023-00718-5#Sec6)).

As opposed to other models of multiple-path signalling, shortest path ensembles consider only the top- *k* most efficient routes between nodes and thus remain selective of which paths support communication. For small values of *k*, identifying the *k* most efficient paths between node pairs remains heavily dependent on global topological knowledge. However, path ensembles become large and inclusive for *k* » 1, and their construction entails a lower informational cost. Similarly, the energetic cost required for signal transmission along multiple paths is proportional to the choice of *k*. Taking into account the full spectrum of possible *k*, the shortest path ensembles model is characterized by low transmission delays in combination with, on average, moderate informational and energetic costs.

## Current and emerging applications

In this section, we review prominent examples of how brain network communication models have been used to investigate a range of fundamental, cognitive and clinical neuroscience questions (Fig. [3](https://www.nature.com/articles/s41583-023-00718-5#Fig3)). Through these examples, we showcase how these models offer a versatile, interpretable and computationally tractable framework to study brain function in health and disease. Importantly, practical applications also offer crucial opportunities for model validation. While in the previous section we considered qualitative assessments of biological plausibility, here, we compare models on the basis of their explanatory power of varied empirical phenomena.

![Fig. 3: Current and emerging applications of communication matrices.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41583-023-00718-5/MediaObjects/41583_2023_718_Fig3_HTML.png?as=webp)

Fig. 3: Current and emerging applications of communication matrices.

### Linking brain structure and function

Functional connectivity describes the synchronization of neural activity over time. As opposed to structural connectivity, which is grounded in anatomy and typically static over short intervals, functional connectivity varies over multiple spatial and temporal scales, giving rise to the rich dynamic repertoire of the brain [^17] [^89]. Critically, the orchestration of neural activity is underpinned by signalling through anatomical connections. Communication processes therefore provide a bridge between the structure and function of the nervous systems [^1] [^18]. Hence, it is unsurprising that some of the earliest applications of brain network communication models were the study of the relationship between structural and functional connectivity (Fig. [3a](https://www.nature.com/articles/s41583-023-00718-5#Fig3)).

Early reports established a robust correlation between structural and functional connections in the human brain: the stronger the white matter tract linking two grey matter regions — as inferred by diffusion MRI and tractography — the more tightly coupled their activity time courses tend to be [^19] [^54]. However, this association was limited to anatomically connected regions and therefore could not explain the converse observations of strong functional connectivity between regions that are not directly connected via white matter [^18] [^57] [^58].

To investigate this question, in 2014, Goñi et al.[^39] computed a number of network communication measures in the human connectome and used them to predict functional connectivity inferred from resting-state functional MRI (fMRI). The authors found that region pairs linked by strong and accessible communication channels — as quantified by measures of polysynaptic network communication — displayed higher functional connectivity. Interestingly, the diffusion-based measures of search information and path transitivity (Box [2](https://www.nature.com/articles/s41583-023-00718-5#Sec5)) were more predictive than the shortest path length, suggesting that diffusion dynamics may facilitate interareal communication. In a contemporary paper, Abdelnour et al.[^90] obtained similar results using an alternative model of network diffusion. Together, these studies provided the earliest demonstrations of network communication models as a framework to investigate brain function, and initial empirical evidence that connectome communication is not shaped exclusively by shortest paths.

Following these foundational papers, the strength of associations to functional connectivity — typically inferred from resting-state fMRI — has become one of the most utilized measures to validate and compare network communication models (see Fig. [3a](https://www.nature.com/articles/s41583-023-00718-5#Fig3) for additional examples of studies in this direction). Although this approach has been fruitful, it has important shortcomings. For instance, resting-state data may offer limited insight into communication processes related to specific behavioural or cognitive demands, which could be better explored using task-based paradigms [^91]. Similarly, functional data acquired under interventional manipulations of brain activity may provide more powerful experimental setups to validate and compare communication models [^92]. Examples along these lines include modelling the propagation of brain stimulation and investigating changes in functional connectivity owing to brain lesions or pathology. In the coming sections, we review papers focused on some of these emerging applications of brain network communication models.

### Interindividual variance in cognitive and clinical phenotypes

Human cognition and behaviour depend on the concerted activity of multiple brain regions. A central research direction in modern neuroscience aims to map associations between signatures of functional connectivity and cognitive phenotypes [^93] [^94]. Network communication models can be used to investigate signalling processes related to distinct cognitive demands, and how differences in connectome communication may contribute to interindividual variation in cognition and behaviour (Fig. [3b](https://www.nature.com/articles/s41583-023-00718-5#Fig3)). In a similar vein, while interareal coordination is paramount for healthy brain functioning, abnormalities in connectome communication have been implicated in the aetiology and symptomatology of multiple brain disorders [^28] [^29] [^30]. On the basis of these observations, authors have proposed that connectome dysconnectivity — a failure to properly integrate information between brain regions — might be an underlying dimension of pathology shared across psychiatric and neurological conditions [^28] [^51]. Network communication models provide tools to operationalize connectome dysconnectivity and quantify breakdown in functional integration, thereby establishing a platform to relate the structural and physiological alterations characteristic of brain disease states.

To date, studies in these directions have been mostly based on measures stemming from the shortest path routing model [^36] [^38] [^95]. This narrow focus may provide an incomplete account of connectome communication and functional integration, potentially failing to uncover brain–behaviour relationships of interest. Indeed, initial comparative studies have found that alternative models were often more explanatory of cognitive and clinical variables than shortest path measures. Examples include applications of navigation, communicability and other diffusion-based measures to investigate information processing speed [^50] and general intelligence [^96] in healthy individuals, as well as disrupted cognition and neural communication in patients with schizophrenia [^97], Alzheimer disease [^52], stroke [^53] and traumatic brain injury [^98] [^99] [^100] [^101]. Recent works on systematic comparisons of different measures using machine learning have started to untangle which models hold higher behavioural and clinical predictive utility [^49], and this remains an important direction for future research.

### Modelling lesion impact and pathological spread

In networked systems, disruptions to local elements — such as the injury, atrophy or malfunction of grey and white matter loci — can precipitate knock-on effects that cascade through the network, potentially impacting the functioning of the system as a whole [^102]. Network communication can be used to investigate and predict how brain function is impacted by structural lesions, disconnection and pathology (Fig. [3c](https://www.nature.com/articles/s41583-023-00718-5#Fig3)).

In a 2016 paper, Grayson et al.[^47] used a pharmacogenetic intervention to temporarily deactivate the amygdala of rhesus monkeys. The authors found that changes in interareal functional connectivity following the targeted deactivation were not restricted to regions sharing a direct structural connection to the amygdala. This indicated that localized activity suppression resulted in disruptions to polysynaptic signalling that were manifested in patterns of global functional connectivity reconfiguration. To further explore this, the authors used the communicability model to quantify communication in the rhesus monkey structural connectome. The pharmacogenetic deactivation was simulated in silico by removing the amygdala from the connectome, effectively impeding communicability to utilize the region as a mediator of signal traffic. This yielded a measure of disrupted structural network communication that, remarkably, was strongly associated with the observed changes in functional connectivity. This work provided experimental evidence that network communication models can predict the functional consequences of empirical and interventional disruption of grey matter structures. In humans, this area of inquiry has implications for our understanding of impaired brain function and cognitive outcomes following lesions. Recent studies have applied diffusion-based measures to investigate signal rerouting and neuroplasticity following traumatic brain injury, providing insight into how communication may bypass damaged areas to restore brain function and facilitate patient recovery [^100] [^101].

In a related line of research, network communication models have also been used to describe the gradual spread of pathological agents and neurodegeneration through the brain. The progression of many neurological disorders is thought to be facilitated by trans-synaptic propagation of pathogens (for example, misfolded proteins in Alzheimer disease) and therefore shaped by structural connectivity [^29] [^30] [^103]. In an influential 2012 study, Raj et al.[^104] showed that the spatial distribution of grey matter atrophy in dementia could be recapitulated by a diffusion model of pathogen transmission through the human connectome. Subsequent studies have used various models of diffusion and epidemiological spread (conceptually similar to the linear threshold model) to investigate the progression of neurodegeneration in amyotrophic lateral sclerosis [^105], Alzheimer disease [^106] and Parkinson disease [^107]. More recently, evidence for the trans-synaptic propagation of cortical atrophy has also been reported in schizophrenia [^108] [^109], although applications of network communication models to the progression of psychiatric conditions remain unexplored.

These two lines of research hold promise in deepening our understanding of how brain injury and pathology relate to clinical outcomes in patients. Moving beyond diagnostic biomarkers or between-group differences, the applications mentioned earlier promote a focus on prognostic insight. The ability to predict clinical outcomes at disease or injury onset — by taking into account an individual’s own connectivity and loci of damage — may help explain heterogeneous patient trajectories and long-term outcomes [^29] [^99]. Future work is needed to translate these predictive models to clinical settings and establish their utility in patient treatment. Efforts in this direction may benefit from the availability of population-scale, longitudinal datasets such as the UK Biobank [^110] [^111]. By tracking health outcomes of tens of thousands of participants over the coming decades, these resources will provide access to the connectome of a patient before disease or lesion onset, as well as regular imaging follow-ups in the event of clinical diagnoses. This will enable longitudinal studies of long-term functional reorganization and signalling rerouting in varied presentations of brain injury or pathology [^100] [^101]. Determining which network communication models offer higher clinical utility in these scenarios will provide an important avenue to model validation.

### Modelling the propagation of brain stimulation

The ability to stimulate neural elements — from single neurons via optogenetic techniques [^16] to large brain structures using direct electrical pulses [^59] [^112] — enables the investigation of the causal effects of targeted perturbations. Evidence from both microscale and macroscale studies has established that the effects of focal stimulation are not confined to initial perturbation sites, but instead spread via interelement connectivity [^60] [^113] [^114] [^115]. Modelling the effects of brain stimulation is therefore a quintessential network communication problem (Fig. [3d](https://www.nature.com/articles/s41583-023-00718-5#Fig3)).

In a recent paper [^116], our team of authors used a large dataset of direct electrical stimulation to study empirical signal transmission in the human brain. Intracranial electroencephalography recordings were acquired following focal single-pulse stimulations in 550 patients with epilepsy. Leveraging interpatient and intrapatient variability in electrode placement, the authors derived whole-brain maps of causal interareal stimulus propagation, inferred empirically and at the millisecond timescales inherent to neural signalling. A suite of network communication measures was computed on the human connectome to quantify transmission between regions, with a particular focus on anatomically unconnected and spatially distant pairs of regions — cases in which polysynaptic communication is most relevant. We found that communication measures were capable of accurate and robust predictions of signalling through white matter connectivity. Importantly, comparison of the explanatory power of different predictors revealed that search information and communicability outperform alternative communication measures, a finding that contributed insight into how the complex topology white matter connectivity shapes the global effects of local brain stimulation (Fig. [4](https://www.nature.com/articles/s41583-023-00718-5#Fig4)).

![Fig. 4: Interpretable insight from network communication models: a brain stimulation case study.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41583-023-00718-5/MediaObjects/41583_2023_718_Fig4_HTML.png?as=webp)

Fig. 4: Interpretable insight from network communication models: a brain stimulation case study.

This work suggests the potential of network communication models to inform clinical brain stimulation [^117] [^118]. Numerous studies have reported that the connectivity profile of stimulation sites is associated with patient outcomes [^119] [^120] [^121], indicating that treatment efficacy is related to distributed changes in brain activity following stimulation. However, the current focus on maps of connectivity does not explicitly consider polysynaptic transmission through the connectome. Network communication models provide an avenue to address this challenge, and determining whether they can contribute to improving the efficacy of therapeutic brain stimulation — in the context of different stimulation methods and clinical cohorts — is an important direction of future work.

### The role of simple models: leveraging interpretability and tractability

Brain network communication models are simplified conceptualizations of neural signalling. Despite the conceptual links to transmission delay and metabolic expenditure, the models reviewed here are not explicitly grounded to aspects of neuronal physiology. Instead, in the tradition of minimalist descriptions of complex systems [^122] [^123], these simple models deliberately abstract microscopic aspects of neuronal signalling in favour of capturing emergent and system-wide properties of neural dynamics [^62] [^81]. As we have seen, this abstraction provides a common mathematical basis to describe and quantify a wide range of empirical phenomena. Along these lines, this section further explores two key advantages of network communication models: (i) the ability to generate interpretable insight into how connectome organization shapes patterns of network communication and (ii) computational tractability.

The interpretation of network communication models depends on the insight that each model and measure interacts with, and relies on, distinct features of the underlying structural connectivity. To exemplify this point, let us consider the models of routing via shortest paths and broadcasting under communicability. Routing depends exclusively on efficient paths comprising a small number of select connections. Network elements that fall outside these paths are therefore irrelevant to routing models and, by extension, to any prediction or statistical explanation on the basis of routing measures. By contrast, communicability posits that all walks in the network contribute to signalling. The communicability measure is therefore shaped by the broader network topology, such that, for example, the presence of multiple alternative routes between two nodes facilitates their communication. Equipped with measures stemming from these two models, researchers can then determine whether routing or broadcasting is more explanatory of an empirical observation of interest. This can shed light on what properties of anatomical connectivity — the length of shortest paths or the presence of multiple communication routes, in this example — are more relevant to the neurobiological processes underpinning empirical phenomena (Fig. [4](https://www.nature.com/articles/s41583-023-00718-5#Fig4)).

The communication measures surveyed here are extremely efficient to compute. In most cases, they constitute analytical transformations of the structural connectivity matrix, which can be performed on the order of seconds for matrices comprising thousands of nodes [^36]. This practical benefit facilitates systematic and tractable explorations of empirical data, such as predictions of electrical signal propagation from hundreds of stimulation sites [^116] and analyses of personalized connectomes for thousands of subjects [^111]. Furthermore, the computational tractability of this framework also buttresses its interpretability and capacity to generate insight, as it enables the time-efficient testing of competing hypotheses and statistical explanations stemming from different models [^124] [^125] [^126].

Importantly, despite the benefits of interpretability and tractability, the simplicity of the present models poses certain barriers to the investigation of the biological mechanisms regulating flexible neural signalling. That is, although network communication models can quantify signalling paths through complex connectivity, they provide limited insight into how neuronal activity contributes to channelling transmission via one path versus another. Multiple mechanistic hypotheses have been proposed to explain selective information transfer on the basis of the synchrony and coherence of neuronal activity [^4] [^7] [^8] [^10] [^12], but they typically consider communication in small motifs of physically connected neural elements. Building bridges between the present models — focused, instead, on polysynaptic signalling in large complex brain networks — and broader research on mechanistic neural communication is a crucial direction of future work.

## Outlook and recommendations

### A synthesis of the present evidence in support of competing brain network communication models

We have reviewed network communication models from the complementary perspectives of (i) qualitative performance in delay, energetic and informational costs and (ii) empirical evidence of their explanatory power. On the basis of these criteria, what can we conclude about the present support in favour of different conceptualizations of connectome communication?

From a conceptual standpoint, we have seen that models can be organized along a spectrum from centralized — efficient but reliant on strong knowledge assumptions — to decentralized — weak assumptions but inefficient — communication policies. We speculate that strategies positioned at either extreme of this spectrum — that is, shortest path routing and unbiased random walks — are unlikely to reflect underlying mechanisms of neural signalling. Instead, we conjecture that models and measures predicated on balanced trade-offs between competing evolutionary drives may provide more biologically realistic descriptions of connectome communication. This notion is supported by the current empirical evidence from a range of neuroscience domains. Comparative studies have found that measures such as search information, communicability and navigation typically yield the most robust explanations of empirical phenomena. Although each of these measures falls into the remit of communication via diffusion or routing, they are not based purely on shortest paths or unbiased random walks. For example, navigation seeks to identify short — but not necessarily the shortest — paths using a decentralized strategy. Similarly, search information and communicability describe diffusive processes that, although influenced by shortest paths, are also markedly shaped by additional topological features.

These points underscore that despite the limitations of shortest path routing as a communication model, the shortest path structure of connectome probably has an important role in shaping neural signalling. As we have explored, broadcasting-like strategies such as communicability and the linear threshold model can access shortest paths without centralized knowledge of the network [^81]. Relatedly, shortest path measures still provide useful descriptions of the properties of a network, and can therefore be used to characterize connectome organization without necessarily making claims about neural communication.

It is important to reiterate that, to date, systematic efforts to test and validate network communication models have been few and limited in scope [^39] [^49] [^116] [^124]. As such, there remain many open questions about the best practices to compare competing models. Of note, it is currently unclear whether patterns of biological signalling vary depending on the particular communication processes of interest. For example, are the signalling mechanisms underlying intrinsic functional synchronization the same as the ones shaping the propagation of exogenous brain stimulation [^92]? Similarly, would the utility of different models vary depending on the clinical traits of individuals, such as states of impaired cognition, neuropathology, or post-injury compensation and rehabilitation [^29]? These knowledge gaps underscore that the present synthesis should be verified by future studies across a wide range of neuroscience domains. Subsequently, we close our review by discussing future opportunities and practical recommendations to guide the principled development, application and validation of network communication models.

### Current limitations and future opportunities

In this section, we discuss limitations of brain network communication models and of the present effort in reviewing them. First, we note that the proposed taxonomy of brain network communication is only one possible way to organize concepts in the literature. It is meant as a first attempt — instead of the final word — at mapping the relationships between different models and measures. Furthermore, the conceptual dimensions of communication cost considered here (delay, information and energy) are an oversimplification that most likely overlooks important aspects of neural signalling. To name one example, they do not take into account the problem of signalling fidelity, that is, the propensity for loss of signal integrity during re-transmissions [^127] [^128].

Network communication models presuppose that signalling processes have well-defined sources and targets. Although this assumption is well suited for certain applications (for example, modelling the propagation of exogenous perturbations from stimulating to recording electrodes), it remains a simplification of intrinsic neural dynamics that warrants future investigation. Similarly, current models assume that communication between all node pairs is equally important. With the exception of navigation, for which paths can fail, other models permit interactions between all pairs of nodes. However, it is likely that certain brain regions are not meant to communicate under certain contexts, such that signalling between them could contribute to maladaptive over-integration [^129].

In a similar vein, the majority of work to date has assumed that all nodes in a brain network communicate using the same strategy. Connectomes, however, are embedded in topological and 3D spaces that could engender preferences in the strategies of certain regions. For instance, signal exchange within versus between structural and functional modules might transpire according to different strategies [^130], as may communication involving unimodal versus multimodal cortical areas [^70] [^131]. Recent work has started to explore this issue by implementing composite models that allow brain regions to communicate using different policies [^132]. Relatedly, work on communication strategies that directly model computation internal to individual neural elements — such as queueing and collision models — is an important direction of future research [^128] [^133].

Current instantiations of network communication models do not promote an explicit focus on time-resolved dynamics. Communication matrices are static estimates of neural signalling that do not provide means to generate time series of neural activity. Nonetheless, as we have seen, communication measures can be used to study processes unfolding over different timescales, such as the millisecond-resolution propagation of electrical stimulation [^116], fluctuations in time-varying functional connectivity [^134] [^135] and the spread of neuropathology over time [^104] [^106]. Extending the models reviewed here to more directly incorporate time-resolved communication dynamics is a promising direction of future research.

The present effort is far from an exhaustive survey of all brain network communication models and measures in the literature. We focused on minimalistic models, which are based primarily on how network topology shapes information flow and do not require extensive — if any — parameter fitting. Many alternatives to the models considered have been applied to brain networks and warrant further research. Examples, to cite a few, include several spectral [^136] [^137] [^138] [^139] [^140], epidemiological [^106] [^107] [^141], information-theoretic [^127] [^142], queueing [^133] and packet-switching [^143] models.

More broadly, work on network communication complements research on other models of brain function, such as network control theory [^144] and biophysical models of neural dynamics [^11]. Many of the applications reviewed earlier have also been investigated using these approaches, including structure–function coupling [^145] [^146], brain stimulation [^147] [^148] [^149] and lesion impact [^150]. Each modelling class provides a complementary avenue to probe these problems, as they strike different balances among interpretability, computational efficiency and neurobiological fidelity. Importantly, studies have started to investigate hybrid approaches that integrate aspects of these modelling domains [^151] [^152]. For example, a recently developed computational model proposed a dynamic mechanism for the selective usage of structural connections [^153]. This paves the way for the implementation of the present communication strategies in the context of simulations of neural activity that are explicitly grounded in biophysical aspects of nervous systems. Research in this direction holds promise to development and validation of mechanistic, interpretable and tractable models of brain function.

### Recommendations for the application and validation of brain network communication models

Network communication models have found utility in varied avenues of neuroscience inquiry. However, to date, it remains unclear which communication policies most faithfully describe biological neural signalling. As a result, in the past decade, the growing interest in quantifying connectome communication has contributed to an ever-expanding array of network measures. On the one hand, this inflation has allowed theoreticians to characterize various properties of brain organization and communication. On the other hand, it can be daunting and counter-productive for practitioners interested in network measures as a research tool. We argue that theoretical and computational advances in network neuroscience must be closely accompanied by empirical efforts in biological validation. We propose that this goal can be achieved by considering the principled application and the biological validation of network communication models as two sides of the same coin, and we provide two recommendations for future efforts in these directions.

First, we advocate for studies considering multiple conceptualizations of neural signalling, to explicitly compare the explanatory power of communication matrices stemming from different models and measures. Importantly, beyond engaging in a computational exercise, practitioners stand to benefit from this recommendation. As we have seen, different communication strategies are predicated on specific hypotheses about how structural connectivity mediates functional interactions between neural elements. Therefore, determining which network measures provide the most accurate and parsimonious explanations of empirical observations may shed light onto the neurobiological processes underpinning phenomena of interest.

Second, we contend that the biological validation of network models ultimately relies on empirical data from interventional or longitudinal experimental designs. Examples include recordings of the causal effects of brain stimulation, longitudinal imaging of the progression of neurodegeneration, and assessments of structural and functional reconfigurations following brain lesions or disconnectivity. These phenomena provide an opportunity to shift focus away from descriptions of brain networks and towards models that are mechanistic and prognostic. Progress in modelling many of these topics is already under way, and future work should carry it forward by comparing the predictive utility of different signalling conceptualizations. As research in multiple areas of neuroscience advances, the evidence for particular communication strategies may become more compelling than it is today, thus narrowing down the scope of useful models and measures.

These recommendations envision a positive feedback loop between methodological and applied branches of network neuroscience, in which modelling advancements enable practitioners to more faithfully characterize brain function, whereas applied research guides the validation and refinement of new methods. Ultimately, this synergy aims to deliver models of brain network communication that provide mechanistic insight and clinical utility. We hope this Review will contribute towards this goal.

## References

## Acknowledgements

C.S. acknowledges support from the Australian Research Council (grant number DP170101815). O.S. acknowledges support from the National Institute of Health (R01 122957). A.Z. acknowledges support from the National Health and Medical Research Council of Australia (APP1118153).

## Ethics declarations

### Competing interests

The authors declare no competing interests.

## Peer review

### Peer review information

*Nature Reviews Neuroscience* thanks M. Cole; A. Kuceyeski; and J. Medaglia, who co-reviewed with H. Stoll, for their contribution to the peer review of this work.

## Additional information

**Publisher’s note** Springer Nature remains neutral with regard to jurisdictional claims in published maps and institutional affiliations.

## Glossary

Complex networks

Networks with non-trivial topology, with features such as modular structure, hub nodes or small-world architecture.

Connectomes

Networks of structural connections between neural elements. Connections may vary from single synapses to large-scale white matter tracts, depending on the spatial scale of neural elements.

Decentralized systems

Systems in which individual elements possess only local knowledge of network organization. They stand in contrast to centralized systems, in which elements or a global controller has access to a bird’s eye view of the network.

Delay cost

Efficiency of signal transmission through the network.

Diffusion processes

Network communication via broadcasting or random walks dynamics.

Dimensions of network communication cost

Putative evolutionary pressures that may have shaped connectome architecture and neural signalling mechanisms.

Energetic cost

Metabolic expenditure from signal transmission through the network.

Informational cost

Amount of knowledge about network topology required to communicate signals.

Network communication measure

A measure that quantifies specific properties of communication under a given model.

Network communication models

Signalling conceptualizations or propagation algorithms to guide communication between nodes.

Network topology

The organizational features of a network of interconnected elements.

Neural elements

A neural element could be a neuron, neuronal population or macroscale brain region and is represented by a node in a neural network.

Parametric models

Network communication via hybrid strategies that combine routing and diffusion.

Polysynaptic communication

A communication process mediated by one or more intermediate neural elements.

Routing protocols

Network communication via selective and efficient paths.

## Rights and permissions

Springer Nature or its licensor (e.g. a society or other partner) holds exclusive rights to this article under a publishing agreement with the author(s) or other rightsholder(s); author self-archiving of the accepted manuscript version of this article is solely governed by the terms of such publishing agreement and applicable law.

[^1]: Avena-Koenigsberger, A., Misic, B. & Sporns, O. Communication dynamics in complex brain networks. *Nat. Rev. Neurosci.* **19**, 17–33 (2018). **This Review was one of the first proposals of network communication as a conceptual framework to bridge the gap between brain structure and function.**

[Article](https://doi.org/10.1038%2Fnrn.2017.149) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2sXhvFOht7zL) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Communication%20dynamics%20in%20complex%20brain%20networks&journal=Nat.%20Rev.%20Neurosci.&doi=10.1038%2Fnrn.2017.149&volume=19&pages=17-33&publication_year=2018&author=Avena-Koenigsberger%2CA&author=Misic%2CB&author=Sporns%2CO)

[^2]: Laughlin, S. B. & Sejnowski, T. J. Communication in neuronal networks. *Science* **301**, 1870–1874 (2003).

[Article](https://doi.org/10.1126%2Fscience.1089662) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD3sXnsFSgt7k%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=14512617) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2930149) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Communication%20in%20neuronal%20networks&journal=Science&doi=10.1126%2Fscience.1089662&volume=301&pages=1870-1874&publication_year=2003&author=Laughlin%2CSB&author=Sejnowski%2CTJ)

[^3]: Debanne, D., Bialowas, A. & Rama, S. What are the mechanisms for analogue and digital signalling in the brain? *Nat. Rev. Neurosci.* **14**, 63–69 (2013).

[Article](https://doi.org/10.1038%2Fnrn3361) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC38XhslarsL7P) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=23187813) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=What%20are%20the%20mechanisms%20for%20analogue%20and%20digital%20signalling%20in%20the%20brain%3F&journal=Nat.%20Rev.%20Neurosci.&doi=10.1038%2Fnrn3361&volume=14&pages=63-69&publication_year=2013&author=Debanne%2CD&author=Bialowas%2CA&author=Rama%2CS)

[^4]: Hahn, G., Ponce-Alvarez, A., Deco, G., Aertsen, A. & Kumar, A. Portraits of communication in neuronal networks. *Nat. Rev. Neurosci.* **20**, 117–127 (2019). **This paper reviews putative mechanisms of communication in small networks of neuronal populations.**

[Article](https://doi.org/10.1038%2Fs41583-018-0094-0) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1cXisFegsbzL) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=30552403) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Portraits%20of%20communication%20in%20neuronal%20networks&journal=Nat.%20Rev.%20Neurosci.&doi=10.1038%2Fs41583-018-0094-0&volume=20&pages=117-127&publication_year=2019&author=Hahn%2CG&author=Ponce-Alvarez%2CA&author=Deco%2CG&author=Aertsen%2CA&author=Kumar%2CA)

[^5]: Yeo, B. T. T. et al. The organization of the human cerebral cortex estimated by intrinsic functional connectivity. *J. Neurophysiol.* **106**, 1125–1165 (2011).

[Article](https://doi.org/10.1152%2Fjn.00338.2011) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=21653723) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20organization%20of%20the%20human%20cerebral%20cortex%20estimated%20by%20intrinsic%20functional%20connectivity&journal=J.%20Neurophysiol.&doi=10.1152%2Fjn.00338.2011&volume=106&pages=1125-1165&publication_year=2011&author=Yeo%2CBTT)

[^6]: Kumar, A., Rotter, S. & Aertsen, A. Spiking activity propagation in neuronal networks: reconciling different perspectives on neural coding. *Nat. Rev. Neurosci.* **11**, 615–627 (2010).

[Article](https://doi.org/10.1038%2Fnrn2886) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC3cXhtVCmur%2FI) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=20725095) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Spiking%20activity%20propagation%20in%20neuronal%20networks%3A%20reconciling%20different%20perspectives%20on%20neural%20coding&journal=Nat.%20Rev.%20Neurosci.&doi=10.1038%2Fnrn2886&volume=11&pages=615-627&publication_year=2010&author=Kumar%2CA&author=Rotter%2CS&author=Aertsen%2CA)

[^7]: Buzsáki, G. & Wang, X.-J. Mechanisms of gamma oscillations. *Annu. Rev. Neurosci.* **35**, 203–225 (2012).

[Article](https://doi.org/10.1146%2Fannurev-neuro-062111-150444) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=22443509) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4049541) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Mechanisms%20of%20gamma%20oscillations&journal=Annu.%20Rev.%20Neurosci.&doi=10.1146%2Fannurev-neuro-062111-150444&volume=35&pages=203-225&publication_year=2012&author=Buzs%C3%A1ki%2CG&author=Wang%2CX-J)

[^8]: Fries, P. Rhythms for cognition: communication through coherence. *Neuron* **88**, 220–235 (2015).

[Article](https://doi.org/10.1016%2Fj.neuron.2015.09.034) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2MXhs1ers7fO) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=26447583) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4605134) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Rhythms%20for%20cognition%3A%20communication%20through%20coherence&journal=Neuron&doi=10.1016%2Fj.neuron.2015.09.034&volume=88&pages=220-235&publication_year=2015&author=Fries%2CP)

[^9]: Kaufman, M. T., Churchland, M. M., Ryu, S. I. & Shenoy, K. V. Cortical activity in the null space: permitting preparation without movement. *Nat. Neurosci.* **17**, 440–448 (2014).

[Article](https://doi.org/10.1038%2Fnn.3643) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2cXhs1Sgtrk%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=24487233) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3955357) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Cortical%20activity%20in%20the%20null%20space%3A%20permitting%20preparation%20without%20movement&journal=Nat.%20Neurosci.&doi=10.1038%2Fnn.3643&volume=17&pages=440-448&publication_year=2014&author=Kaufman%2CMT&author=Churchland%2CMM&author=Ryu%2CSI&author=Shenoy%2CKV)

[^10]: Semedo, J. D., Zandvakili, A., Machens, C. K., Yu, B. M. & Kohn, A. Cortical areas interact through a communication subspace. *Neuron* **102**, 249–259.e4 (2019).

[Article](https://doi.org/10.1016%2Fj.neuron.2019.01.026) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1MXivFSlt74%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=30770252) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6449210) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Cortical%20areas%20interact%20through%20a%20communication%20subspace&journal=Neuron&doi=10.1016%2Fj.neuron.2019.01.026&volume=102&pages=249-259.e4&publication_year=2019&author=Semedo%2CJD&author=Zandvakili%2CA&author=Machens%2CCK&author=Yu%2CBM&author=Kohn%2CA)

[^11]: Deco, G., Jirsa, V. K., Robinson, P. A., Breakspear, M. & Friston, K. The dynamic brain: from spiking neurons to neural masses and cortical fields. *PLoS Comput. Biol.* **4**, e1000092 (2008).

[Article](https://doi.org/10.1371%2Fjournal.pcbi.1000092) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=18769680) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2519166) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20dynamic%20brain%3A%20from%20spiking%20neurons%20to%20neural%20masses%20and%20cortical%20fields&journal=PLoS%20Comput.%20Biol.&doi=10.1371%2Fjournal.pcbi.1000092&volume=4&publication_year=2008&author=Deco%2CG&author=Jirsa%2CVK&author=Robinson%2CPA&author=Breakspear%2CM&author=Friston%2CK)

[^12]: Palmigiano, A., Geisel, T., Wolf, F. & Battaglia, D. Flexible information routing by transient synchrony. *Nat. Neurosci.* **20**, 1014–1022 (2017).

[Article](https://doi.org/10.1038%2Fnn.4569) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2sXotVOlt7Y%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=28530664) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Flexible%20information%20routing%20by%20transient%20synchrony&journal=Nat.%20Neurosci.&doi=10.1038%2Fnn.4569&volume=20&pages=1014-1022&publication_year=2017&author=Palmigiano%2CA&author=Geisel%2CT&author=Wolf%2CF&author=Battaglia%2CD)

[^13]: Bassett, D. S. & Sporns, O. Network neuroscience. *Nat. Neurosci.* **20**, 353–364 (2017).

[Article](https://doi.org/10.1038%2Fnn.4502) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2sXjsVSmsrY%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=28230844) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5485642) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Network%20neuroscience&journal=Nat.%20Neurosci.&doi=10.1038%2Fnn.4502&volume=20&pages=353-364&publication_year=2017&author=Bassett%2CDS&author=Sporns%2CO)

[^14]: Bullmore, E. & Sporns, O. Complex brain networks: graph theoretical analysis of structural and functional systems. *Nat. Rev. Neurosci.* **10**, 186–198 (2009).

[Article](https://doi.org/10.1038%2Fnrn2575) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD1MXhtlygtrg%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=19190637) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Complex%20brain%20networks%3A%20graph%20theoretical%20analysis%20of%20structural%20and%20functional%20systems&journal=Nat.%20Rev.%20Neurosci.&doi=10.1038%2Fnrn2575&volume=10&pages=186-198&publication_year=2009&author=Bullmore%2CE&author=Sporns%2CO)

[^15]: Fornito, A., Zalesky, A. & Bullmore, E. T. *Fundamentals of Brain Network Analysis* (Academic, 2016). **This book provides a comprehensive introduction to network neuroscience and connectomics.**

[^16]: Javadzadeh, M. & Hofer, S. B. Dynamic causal communication channels between neocortical areas. *Neuron* **110**, 2470–2483.e7 (2022).

[Article](https://doi.org/10.1016%2Fj.neuron.2022.05.011) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB38XhsFWgsLrJ) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=35690063) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC9616801) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Dynamic%20causal%20communication%20channels%20between%20neocortical%20areas&journal=Neuron&doi=10.1016%2Fj.neuron.2022.05.011&volume=110&pages=2470-2483.e7&publication_year=2022&author=Javadzadeh%2CM&author=Hofer%2CSB)

[^17]: Park, H.-J. & Friston, K. Structural and functional brain networks: from connections to cognition. *Science* **342**, 1238411 (2013).

[Article](https://doi.org/10.1126%2Fscience.1238411) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=24179229) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Structural%20and%20functional%20brain%20networks%3A%20from%20connections%20to%20cognition&journal=Science&doi=10.1126%2Fscience.1238411&volume=342&publication_year=2013&author=Park%2CH-J&author=Friston%2CK)

[^18]: Suárez, L. E., Markello, R. D., Betzel, R. F. & Misic, B. Linking structure and function in macroscale brain networks. *Trends Cogn. Sci.* **24**, 302–315 (2020).

[Article](https://doi.org/10.1016%2Fj.tics.2020.01.008) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=32160567) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Linking%20structure%20and%20function%20in%20macroscale%20brain%20networks&journal=Trends%20Cogn.%20Sci.&doi=10.1016%2Fj.tics.2020.01.008&volume=24&pages=302-315&publication_year=2020&author=Su%C3%A1rez%2CLE&author=Markello%2CRD&author=Betzel%2CRF&author=Misic%2CB)

[^19]: Hagmann, P. et al. Mapping the structural core of human cerebral cortex. *PLoS Biol.* **6**, e159 (2008).

[Article](https://doi.org/10.1371%2Fjournal.pbio.0060159) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=18597554) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2443193) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Mapping%20the%20structural%20core%20of%20human%20cerebral%20cortex&journal=PLoS%20Biol.&doi=10.1371%2Fjournal.pbio.0060159&volume=6&publication_year=2008&author=Hagmann%2CP)

[^20]: van den Heuvel, M. P. & Sporns, O. Rich-club organization of the human connectome. *J. Neurosci.* **31**, 15775–15786 (2011).

[Article](https://doi.org/10.1523%2FJNEUROSCI.3539-11.2011) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=22049421) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6623027) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Rich-club%20organization%20of%20the%20human%20connectome&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.3539-11.2011&volume=31&pages=15775-15786&publication_year=2011&author=Heuvel%2CMP&author=Sporns%2CO)

[^21]: Meunier, D., Lambiotte, R. & Bullmore, E. T. Modular and hierarchically modular organization of brain networks. *Front. Neurosci.* **4**, 200 (2010).

[Article](https://doi.org/10.3389%2Ffnins.2010.00200) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=21151783) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3000003) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Modular%20and%20hierarchically%20modular%20organization%20of%20brain%20networks&journal=Front.%20Neurosci.&doi=10.3389%2Ffnins.2010.00200&volume=4&publication_year=2010&author=Meunier%2CD&author=Lambiotte%2CR&author=Bullmore%2CET)

[^22]: Bassett, D. S. & Bullmore, E. Small-world brain networks. *Neuroscientist* **12**, 512–523 (2006).

[Article](https://doi.org/10.1177%2F1073858406293182) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=17079517) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Small-world%20brain%20networks&journal=Neuroscientist&doi=10.1177%2F1073858406293182&volume=12&pages=512-523&publication_year=2006&author=Bassett%2CDS&author=Bullmore%2CE)

[^23]: van den Heuvel, M. P., Bullmore, E. T. & Sporns, O. Comparative connectomics. *Trends Cogn. Sci.* **20**, 345–361 (2016).

[Article](https://doi.org/10.1016%2Fj.tics.2016.03.001) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=27026480) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Comparative%20connectomics&journal=Trends%20Cogn.%20Sci.&doi=10.1016%2Fj.tics.2016.03.001&volume=20&pages=345-361&publication_year=2016&author=Heuvel%2CMP&author=Bullmore%2CET&author=Sporns%2CO)

[^24]: Bullmore, E. & Sporns, O. The economy of brain network organization. *Nat. Rev. Neurosci.* **13**, 336–349 (2012).

[Article](https://doi.org/10.1038%2Fnrn3214) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC38XlsFSqt7w%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=22498897) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20economy%20of%20brain%20network%20organization&journal=Nat.%20Rev.%20Neurosci.&doi=10.1038%2Fnrn3214&volume=13&pages=336-349&publication_year=2012&author=Bullmore%2CE&author=Sporns%2CO)

[^25]: van den Heuvel, M. P., Kahn, R. S., Goñi, J. & Sporns, O. High-cost, high-capacity backbone for global brain communication. *Proc. Natl Acad. Sci. USA* **109**, 11372–11377 (2012).

[Article](https://doi.org/10.1073%2Fpnas.1203593109) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=22711833) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3396547) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=High-cost%2C%20high-capacity%20backbone%20for%20global%20brain%20communication&journal=Proc.%20Natl%20Acad.%20Sci.%20USA&doi=10.1073%2Fpnas.1203593109&volume=109&pages=11372-11377&publication_year=2012&author=Heuvel%2CMP&author=Kahn%2CRS&author=Go%C3%B1i%2CJ&author=Sporns%2CO)

[^26]: Cole, M. W., Ito, T., Bassett, D. S. & Schultz, D. H. Activity flow over resting-state networks shapes cognitive task activations. *Nat. Neurosci.* **19**, 1718–1726 (2016).

[Article](https://doi.org/10.1038%2Fnn.4406) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC28Xhs1ektrnK) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=27723746) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5127712) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Activity%20flow%20over%20resting-state%20networks%20shapes%20cognitive%20task%20activations&journal=Nat.%20Neurosci.&doi=10.1038%2Fnn.4406&volume=19&pages=1718-1726&publication_year=2016&author=Cole%2CMW&author=Ito%2CT&author=Bassett%2CDS&author=Schultz%2CDH)

[^27]: Shine, J. M. et al. Human cognition involves the dynamic integration of neural activity and neuromodulatory systems. *Nat. Neurosci.* **22**, 289–296 (2019).

[Article](https://doi.org/10.1038%2Fs41593-018-0312-0) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1MXmtF2jtbY%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=30664771) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Human%20cognition%20involves%20the%20dynamic%20integration%20of%20neural%20activity%20and%20neuromodulatory%20systems&journal=Nat.%20Neurosci.&doi=10.1038%2Fs41593-018-0312-0&volume=22&pages=289-296&publication_year=2019&author=Shine%2CJM)

[^28]: van den Heuvel, M. P. & Sporns, O. A cross-disorder connectome landscape of brain dysconnectivity. *Nat. Rev. Neurosci.* **20**, 435–446 (2019).

[Article](https://doi.org/10.1038%2Fs41583-019-0177-6) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=31127193) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC8864539) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20cross-disorder%20connectome%20landscape%20of%20brain%20dysconnectivity&journal=Nat.%20Rev.%20Neurosci.&doi=10.1038%2Fs41583-019-0177-6&volume=20&pages=435-446&publication_year=2019&author=Heuvel%2CMP&author=Sporns%2CO)

[^29]: Fornito, A., Zalesky, A. & Breakspear, M. The connectomics of brain disorders. *Nat. Rev. Neurosci.* **16**, 159–172 (2015).

[Article](https://doi.org/10.1038%2Fnrn3901) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2MXjtVylsLw%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=25697159) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20connectomics%20of%20brain%20disorders&journal=Nat.%20Rev.%20Neurosci.&doi=10.1038%2Fnrn3901&volume=16&pages=159-172&publication_year=2015&author=Fornito%2CA&author=Zalesky%2CA&author=Breakspear%2CM)

[^30]: Stam, C. J. Modern network science of neurological disorders. *Nat. Rev. Neurosci.* **15**, 683–695 (2014).

[Article](https://doi.org/10.1038%2Fnrn3801) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2cXhsVyhurzM) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=25186238) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Modern%20network%20science%20of%20neurological%20disorders&journal=Nat.%20Rev.%20Neurosci.&doi=10.1038%2Fnrn3801&volume=15&pages=683-695&publication_year=2014&author=Stam%2CCJ)

[^31]: Achard, S., Salvador, R., Whitcher, B., Suckling, J. & Bullmore, E. A resilient, low-frequency, small-world human brain functional network with highly connected association cortical hubs. *J. Neurosci.* **26**, 63–72 (2006).

[Article](https://doi.org/10.1523%2FJNEUROSCI.3874-05.2006) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD28XmtV2gtQ%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=16399673) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6674299) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20resilient%2C%20low-frequency%2C%20small-world%20human%20brain%20functional%20network%20with%20highly%20connected%20association%20cortical%20hubs&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.3874-05.2006&volume=26&pages=63-72&publication_year=2006&author=Achard%2CS&author=Salvador%2CR&author=Whitcher%2CB&author=Suckling%2CJ&author=Bullmore%2CE)

[^32]: Watts, D. J. & Strogatz, S. H. Collective dynamics of ‘small-world’ networks. *Nature* **393**, 440–442 (1998).

[Article](https://doi.org/10.1038%2F30918) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DyaK1cXjs1Khsrk%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=9623998) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Collective%20dynamics%20of%20%E2%80%98small-world%E2%80%99%20networks&journal=Nature&doi=10.1038%2F30918&volume=393&pages=440-442&publication_year=1998&author=Watts%2CDJ&author=Strogatz%2CSH)

[^33]: Kaiser, M. & Hilgetag, C. C. Nonoptimal component placement, but short processing paths, due to long-distance projections in neural systems. *PLoS Comput. Biol.* **2**, e95 (2006).

[Article](https://doi.org/10.1371%2Fjournal.pcbi.0020095) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=16848638) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC1513269) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Nonoptimal%20component%20placement%2C%20but%20short%20processing%20paths%2C%20due%20to%20long-distance%20projections%20in%20neural%20systems&journal=PLoS%20Comput.%20Biol.&doi=10.1371%2Fjournal.pcbi.0020095&volume=2&publication_year=2006&author=Kaiser%2CM&author=Hilgetag%2CCC)

[^34]: Zamora-López, G., Zhou, C. & Kurths, J. Cortical hubs form a module for multisensory integration on top of the hierarchy of cortical networks. *Front. Neuroinform.* **4**, 1 (2010).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=20428515) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2859882) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Cortical%20hubs%20form%20a%20module%20for%20multisensory%20integration%20on%20top%20of%20the%20hierarchy%20of%20cortical%20networks&journal=Front.%20Neuroinform.&volume=4&publication_year=2010&author=Zamora-L%C3%B3pez%2CG&author=Zhou%2CC&author=Kurths%2CJ)

[^35]: Papo, D., Zanin, M., Martínez, J. H. & Buldú, J. M. Beware of the small-world neuroscientist! *Front. Hum. Neurosci.* **10**, 96 (2016).

[Article](https://doi.org/10.3389%2Ffnhum.2016.00096) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=27014027) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4781830) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Beware%20of%20the%20small-world%20neuroscientist%21&journal=Front.%20Hum.%20Neurosci.&doi=10.3389%2Ffnhum.2016.00096&volume=10&publication_year=2016&author=Papo%2CD&author=Zanin%2CM&author=Mart%C3%ADnez%2CJH&author=Buld%C3%BA%2CJM)

[^36]: Rubinov, M. & Sporns, O. Complex network measures of brain connectivity: uses and interpretations. *NeuroImage* **52**, 1059–1069 (2010).

[Article](https://doi.org/10.1016%2Fj.neuroimage.2009.10.003) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=19819337) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Complex%20network%20measures%20of%20brain%20connectivity%3A%20uses%20and%20interpretations&journal=NeuroImage&doi=10.1016%2Fj.neuroimage.2009.10.003&volume=52&pages=1059-1069&publication_year=2010&author=Rubinov%2CM&author=Sporns%2CO)

[^37]: Varshney, L. R., Chen, B. L., Paniagua, E., Hall, D. H. & Chklovskii, D. B. Structural properties of the *Caenorhabditis elegans* neuronal network. *PLoS Comput. Biol.* **7**, e1001066 (2011).

[Article](https://doi.org/10.1371%2Fjournal.pcbi.1001066) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC3MXitV2rsbY%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=21304930) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3033362) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Structural%20properties%20of%20the%20Caenorhabditis%20elegans%20neuronal%20network&journal=PLoS%20Comput.%20Biol.&doi=10.1371%2Fjournal.pcbi.1001066&volume=7&publication_year=2011&author=Varshney%2CLR&author=Chen%2CBL&author=Paniagua%2CE&author=Hall%2CDH&author=Chklovskii%2CDB)

[^38]: Griffa, A., Baumann, P. S., Thiran, J.-P. & Hagmann, P. Structural connectomics in brain diseases. *NeuroImage* **80**, 515–526 (2013).

[Article](https://doi.org/10.1016%2Fj.neuroimage.2013.04.056) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=23623973) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Structural%20connectomics%20in%20brain%20diseases&journal=NeuroImage&doi=10.1016%2Fj.neuroimage.2013.04.056&volume=80&pages=515-526&publication_year=2013&author=Griffa%2CA&author=Baumann%2CPS&author=Thiran%2CJ-P&author=Hagmann%2CP)

[^39]: Goñi, J. et al. Resting-brain functional connectivity predicted by analytic measures of network communication. *Proc. Natl Acad. Sci. USA* **111**, 833–838 (2014). **This work was one of the first empirical demonstrations that network communication models can be used to infer functional connectivity from brain network structure.**

[Article](https://doi.org/10.1073%2Fpnas.1315529111) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=24379387) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Resting-brain%20functional%20connectivity%20predicted%20by%20analytic%20measures%20of%20network%20communication&journal=Proc.%20Natl%20Acad.%20Sci.%20USA&doi=10.1073%2Fpnas.1315529111&volume=111&pages=833-838&publication_year=2014&author=Go%C3%B1i%2CJ)

[^40]: Avena-Koenigsberger, A. et al. Path ensembles and a tradeoff between communication efficiency and resilience in the human connectome. *Brain Struct. Funct*. **222**, 603–618 (2016).

[Article](https://link.springer.com/doi/10.1007/s00429-016-1238-5) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=27334341) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Path%20ensembles%20and%20a%20tradeoff%20between%20communication%20efficiency%20and%20resilience%20in%20the%20human%20connectome&journal=Brain%20Struct.%20Funct.&doi=10.1007%2Fs00429-016-1238-5&volume=222&pages=603-618&publication_year=2016&author=Avena-Koenigsberger%2CA)

[^41]: Seguin, C., van den Heuvel, M. P. & Zalesky, A. Navigation of brain networks. *Proc. Natl Acad. Sci. USA* **115**, 6297–6302 (2018). **This study was the first comprehensive exploration of the network navigation model in neuroscience.**

[Article](https://doi.org/10.1073%2Fpnas.1801351115) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1cXitlWru7jO) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=29848631) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6004443) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Navigation%20of%20brain%20networks&journal=Proc.%20Natl%20Acad.%20Sci.%20USA&doi=10.1073%2Fpnas.1801351115&volume=115&pages=6297-6302&publication_year=2018&author=Seguin%2CC&author=Heuvel%2CMP&author=Zalesky%2CA)

[^42]: Kleinberg, J. M. Navigation in a small world. *Nature* **406**, 845 (2000).

[Article](https://doi.org/10.1038%2F35022643) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD3cXmsVCkuro%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=10972276) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Navigation%20in%20a%20small%20world&journal=Nature&doi=10.1038%2F35022643&volume=406&publication_year=2000&author=Kleinberg%2CJM)

[^43]: Boguna, M., Krioukov, D. & Claffy, K. C. Navigability of complex networks. *Nat. Phys.* **5**, 74–80 (2009).

[Article](https://doi.org/10.1038%2Fnphys1130) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD1MXptFyi) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Navigability%20of%20complex%20networks&journal=Nat.%20Phys.&doi=10.1038%2Fnphys1130&volume=5&pages=74-80&publication_year=2009&author=Boguna%2CM&author=Krioukov%2CD&author=Claffy%2CKC)

[^44]: Goñi, J. et al. Exploring the morphospace of communication efficiency in complex networks. *PLoS One* **8**, e58070 (2013).

[Article](https://doi.org/10.1371%2Fjournal.pone.0058070) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=23505455) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3591454) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Exploring%20the%20morphospace%20of%20communication%20efficiency%20in%20complex%20networks&journal=PLoS%20One&doi=10.1371%2Fjournal.pone.0058070&volume=8&publication_year=2013&author=Go%C3%B1i%2CJ)

[^45]: Travers, J. & Milgram, S. An experimental study of the small world problem. *Sociometry* **32**, 425–443 (1969). **A prescient and highly influential account of decentralized communication in complex networks.**

[Article](https://doi.org/10.2307%2F2786545) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=An%20experimental%20study%20of%20the%20small%20world%20problem&journal=Sociometry&doi=10.2307%2F2786545&volume=32&pages=425-443&publication_year=1969&author=Travers%2CJ&author=Milgram%2CS)

[^46]: Boguñá, M., Papadopoulos, F. & Krioukov, D. Sustaining the Internet with hyperbolic mapping. *Nat. Commun.* **1**, 62 (2010).

[Article](https://doi.org/10.1038%2Fncomms1063) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=20842196) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Sustaining%20the%20Internet%20with%20hyperbolic%20mapping&journal=Nat.%20Commun.&doi=10.1038%2Fncomms1063&volume=1&publication_year=2010&author=Bogu%C3%B1%C3%A1%2CM&author=Papadopoulos%2CF&author=Krioukov%2CD)

[^47]: Grayson, D. S. et al. The rhesus monkey connectome predicts disrupted functional networks resulting from pharmacogenetic inactivation of the amygdala. *Neuron* **91**, 453–466 (2016). **This paper shows that network communication models can predict global changes in functional connectivity resulting from the deactivation of targeted regions.**

[Article](https://doi.org/10.1016%2Fj.neuron.2016.06.005) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC28Xht1Clur%2FF) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=27477019) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5233431) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20rhesus%20monkey%20connectome%20predicts%20disrupted%20functional%20networks%20resulting%20from%20pharmacogenetic%20inactivation%20of%20the%20amygdala&journal=Neuron&doi=10.1016%2Fj.neuron.2016.06.005&volume=91&pages=453-466&publication_year=2016&author=Grayson%2CDS)

[^48]: Betzel, R. F. et al. Structural, geometric and genetic factors predict interregional brain connectivity patterns probed by electrocorticography. *Nat. Biomed. Eng.* **3**, 902–916 (2019).

[Article](https://doi.org/10.1038%2Fs41551-019-0404-5) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=31133741) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Structural%2C%20geometric%20and%20genetic%20factors%20predict%20interregional%20brain%20connectivity%20patterns%20probed%20by%20electrocorticography&journal=Nat.%20Biomed.%20Eng.&doi=10.1038%2Fs41551-019-0404-5&volume=3&pages=902-916&publication_year=2019&author=Betzel%2CRF)

[^49]: Seguin, C., Tian, Y. & Zalesky, A. Network communication models improve the behavioral and functional predictive utility of the human structural connectome. *Netw. Neurosci.* **4**, 980–1006 (2020).

[Article](https://doi.org/10.1162%2Fnetn_a_00161) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=33195945) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC7655041) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Network%20communication%20models%20improve%20the%20behavioral%20and%20functional%20predictive%20utility%20of%20the%20human%20structural%20connectome&journal=Netw.%20Neurosci.&doi=10.1162%2Fnetn_a_00161&volume=4&pages=980-1006&publication_year=2020&author=Seguin%2CC&author=Tian%2CY&author=Zalesky%2CA)

[^50]: Imms, P. et al. Navigating the link between processing speed and network communication in the human brain. *Brain Struct. Funct.* **226**, 1281–1302 (2021).

[Article](https://link.springer.com/doi/10.1007/s00429-021-02241-8) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=33704578) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Navigating%20the%20link%20between%20processing%20speed%20and%20network%20communication%20in%20the%20human%20brain&journal=Brain%20Struct.%20Funct.&doi=10.1007%2Fs00429-021-02241-8&volume=226&pages=1281-1302&publication_year=2021&author=Imms%2CP)

[^51]: de Lange, S. C. et al. Shared vulnerability for connectome alterations across psychiatric and neurological brain disorders. *Nat. Hum. Behav.* **3**, 988–998 (2019). **This paper uses a large sample of patients to identify a cross-disorder basis for disrupted brain network communication in neuropsychiatric conditions.**

[Article](https://doi.org/10.1038%2Fs41562-019-0659-6) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=31384023) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Shared%20vulnerability%20for%20connectome%20alterations%20across%20psychiatric%20and%20neurological%20brain%20disorders&journal=Nat.%20Hum.%20Behav.&doi=10.1038%2Fs41562-019-0659-6&volume=3&pages=988-998&publication_year=2019&author=Lange%2CSC)

[^52]: Lella, E. & Estrada, E. Communicability distance reveals hidden patterns of Alzheimer’s disease. *Netw. Neurosci.* **4**, 1007–1029 (2020).

[Article](https://doi.org/10.1162%2Fnetn_a_00143) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=33195946) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC7655045) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Communicability%20distance%20reveals%20hidden%20patterns%20of%20Alzheimer%E2%80%99s%20disease&journal=Netw.%20Neurosci.&doi=10.1162%2Fnetn_a_00143&volume=4&pages=1007-1029&publication_year=2020&author=Lella%2CE&author=Estrada%2CE)

[^53]: Wang, X. et al. Synchronization lag in post stroke: relation to motor function and structural connectivity. *Netw. Neurosci.* **3**, 1121–1140 (2019).

[Article](https://doi.org/10.1162%2Fnetn_a_00105) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=31637341) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6777982) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Synchronization%20lag%20in%20post%20stroke%3A%20relation%20to%20motor%20function%20and%20structural%20connectivity&journal=Netw.%20Neurosci.&doi=10.1162%2Fnetn_a_00105&volume=3&pages=1121-1140&publication_year=2019&author=Wang%2CX)

[^54]: Hermundstad, A. M. et al. Structural foundations of resting-state and task-based functional connectivity in the human brain. *Proc. Natl Acad. Sci. USA* **110**, 6169–6174 (2013).

[Article](https://doi.org/10.1073%2Fpnas.1219562110) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=23530246) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3625268) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Structural%20foundations%20of%20resting-state%20and%20task-based%20functional%20connectivity%20in%20the%20human%20brain&journal=Proc.%20Natl%20Acad.%20Sci.%20USA&doi=10.1073%2Fpnas.1219562110&volume=110&pages=6169-6174&publication_year=2013&author=Hermundstad%2CAM)

[^55]: Cook, S. J. et al. Whole-animal connectomes of both *Caenorhabditis elegans* sexes. *Nature* **571**, 63–71 (2019).

[Article](https://doi.org/10.1038%2Fs41586-019-1352-7) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1MXhtlamurvM) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=31270481) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6889226) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Whole-animal%20connectomes%20of%20both%20Caenorhabditis%20elegans%20sexes&journal=Nature&doi=10.1038%2Fs41586-019-1352-7&volume=571&pages=63-71&publication_year=2019&author=Cook%2CSJ)

[^56]: Winding, M. et al. The connectome of an insect brain. *Science* **379**, eadd9330 (2023). **This recent paper was the first to investigate polysynaptic streams of information flow in a complete insect connectome.**

[Article](https://doi.org/10.1126%2Fscience.add9330) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB3sXkvFWgsrg%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=36893230) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC7614541) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20connectome%20of%20an%20insect%20brain&journal=Science&doi=10.1126%2Fscience.add9330&volume=379&publication_year=2023&author=Winding%2CM)

[^57]: Alves, P. N. et al. An improved neuroanatomical model of the default-mode network reconciles previous neuroimaging and neuropathological findings. *Commun. Biol.* **2**, 370 (2019).

[Article](https://doi.org/10.1038%2Fs42003-019-0611-3) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=31633061) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6787009) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=An%20improved%20neuroanatomical%20model%20of%20the%20default-mode%20network%20reconciles%20previous%20neuroimaging%20and%20neuropathological%20findings&journal=Commun.%20Biol.&doi=10.1038%2Fs42003-019-0611-3&volume=2&publication_year=2019&author=Alves%2CPN)

[^58]: Uddin, L. Q. et al. Residual functional connectivity in the split-brain revealed with resting-state functional MRI. *Neuroreport* **19**, 703–709 (2008).

[Article](https://doi.org/10.1097%2FWNR.0b013e3282fb8203) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=18418243) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3640406) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Residual%20functional%20connectivity%20in%20the%20split-brain%20revealed%20with%20resting-state%20functional%20MRI&journal=Neuroreport&doi=10.1097%2FWNR.0b013e3282fb8203&volume=19&pages=703-709&publication_year=2008&author=Uddin%2CLQ)

[^59]: Trebaul, L. et al. Probabilistic functional tractography of the human cortex revisited. *Neuroimage* **181**, 414–429 (2018).

[Article](https://doi.org/10.1016%2Fj.neuroimage.2018.07.039) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=30025851) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Probabilistic%20functional%20tractography%20of%20the%20human%20cortex%20revisited&journal=Neuroimage&doi=10.1016%2Fj.neuroimage.2018.07.039&volume=181&pages=414-429&publication_year=2018&author=Trebaul%2CL)

[^60]: Momi, D., Wang, Z. & Griffiths, J. D. TMS-evoked responses are driven by recurrent large-scale network dynamics. *eLife* **12**, e83232 (2023).

[Article](https://doi.org/10.7554%2FeLife.83232) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=37083491) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC10121222) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=TMS-evoked%20responses%20are%20driven%20by%20recurrent%20large-scale%20network%20dynamics&journal=eLife&doi=10.7554%2FeLife.83232&volume=12&publication_year=2023&author=Momi%2CD&author=Wang%2CZ&author=Griffiths%2CJD)

[^61]: Laughlin, S. B., de Ruyter van Steveninck, R. R. & Anderson, J. C. The metabolic cost of neural information. *Nat. Neurosci.* **1**, 36–41 (1998).

[Article](https://doi.org/10.1038%2F236) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DyaK1MXitVCnt70%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=10195106) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20metabolic%20cost%20of%20neural%20information&journal=Nat.%20Neurosci.&doi=10.1038%2F236&volume=1&pages=36-41&publication_year=1998&author=Laughlin%2CSB&author=Steveninck%2CRR&author=Anderson%2CJC)

[^62]: Avena-Koenigsberger, A. et al. A spectrum of routing strategies for brain networks. *PLoS Comput. Biol.* **15**, e1006833 (2019). **This work presents one of the first applications of the biased random walk model in network neuroscience.**

[Article](https://doi.org/10.1371%2Fjournal.pcbi.1006833) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=30849087) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6426276) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20spectrum%20of%20routing%20strategies%20for%20brain%20networks&journal=PLoS%20Comput.%20Biol.&doi=10.1371%2Fjournal.pcbi.1006833&volume=15&publication_year=2019&author=Avena-Koenigsberger%2CA)

[^63]: Avena-Koenigsberger, A. et al. Using Pareto optimality to explore the topology and dynamics of the human connectome. *Philos. Trans. R. Soc. Lond. B Biol. Sci*. **369**, 20130530 (2014).

[Article](https://doi.org/10.1098%2Frstb.2013.0530) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=25180308) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4150305) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Using%20Pareto%20optimality%20to%20explore%20the%20topology%20and%20dynamics%20of%20the%20human%20connectome&journal=Philos.%20Trans.%20R.%20Soc.%20Lond.%20B%20Biol.%20Sci.&doi=10.1098%2Frstb.2013.0530&volume=369&publication_year=2014&author=Avena-Koenigsberger%2CA)

[^64]: Avena-Koenigsberger, A., Goñi, J., Solé, R. & Sporns, O. Network morphospace. *J. R. Soc. Interface* **12**, 20140881 (2015).

[Article](https://doi.org/10.1098%2Frsif.2014.0881) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=25540237) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4305402) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Network%20morphospace&journal=J.%20R.%20Soc.%20Interface&doi=10.1098%2Frsif.2014.0881&volume=12&publication_year=2015&author=Avena-Koenigsberger%2CA&author=Go%C3%B1i%2CJ&author=Sol%C3%A9%2CR&author=Sporns%2CO)

[^65]: Serrano, M. A., Krioukov, D. & Boguñá, M. Self-similarity of complex networks and hidden metric spaces. *Phys. Rev. Lett.* **100**, 078701 (2008).

[Article](https://doi.org/10.1103%2FPhysRevLett.100.078701) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=18352602) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Self-similarity%20of%20complex%20networks%20and%20hidden%20metric%20spaces&journal=Phys.%20Rev.%20Lett.&doi=10.1103%2FPhysRevLett.100.078701&volume=100&publication_year=2008&author=Serrano%2CMA&author=Krioukov%2CD&author=Bogu%C3%B1%C3%A1%2CM)

[^66]: Kleinberg, J. Complex networks and decentralized search algorithms. *Proc. Int. Congr. Math.* **3**, 1019–1044 (2006).

[Google Scholar](http://scholar.google.com/scholar_lookup?&title=Complex%20networks%20and%20decentralized%20search%20algorithms&journal=Proc.%20Int.%20Congr.%20Math.&volume=3&pages=1019-1044&publication_year=2006&author=Kleinberg%2CJ)

[^67]: Cannistraci, C. V. & Muscoloni, A. Geometrical congruence, greedy navigability and myopic transfer in complex networks and brain connectomes. *Nat. Commun.* **13**, 7308 (2022).

[Article](https://doi.org/10.1038%2Fs41467-022-34634-6) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB38XjtVeiur7P) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=36437254) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC9701786) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Geometrical%20congruence%2C%20greedy%20navigability%20and%20myopic%20transfer%20in%20complex%20networks%20and%20brain%20connectomes&journal=Nat.%20Commun.&doi=10.1038%2Fs41467-022-34634-6&volume=13&publication_year=2022&author=Cannistraci%2CCV&author=Muscoloni%2CA)

[^68]: Roberts, J. A. et al. The contribution of geometry to the human connectome. *NeuroImage* **124**, 379–393 (2016).

[Article](https://doi.org/10.1016%2Fj.neuroimage.2015.09.009) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=26364864) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20contribution%20of%20geometry%20to%20the%20human%20connectome&journal=NeuroImage&doi=10.1016%2Fj.neuroimage.2015.09.009&volume=124&pages=379-393&publication_year=2016&author=Roberts%2CJA)

[^69]: Stiso, J. & Bassett, D. S. Spatial embedding imposes constraints on neuronal network architectures. *Trends Cogn. Sci.* **22**, 1127–1142 (2018).

[Article](https://doi.org/10.1016%2Fj.tics.2018.09.007) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=30449318) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Spatial%20embedding%20imposes%20constraints%20on%20neuronal%20network%20architectures&journal=Trends%20Cogn.%20Sci.&doi=10.1016%2Fj.tics.2018.09.007&volume=22&pages=1127-1142&publication_year=2018&author=Stiso%2CJ&author=Bassett%2CDS)

[^70]: Vézquez-Rodríguez, B., Liu, Z.-Q., Hagmann, P. & Misic, B. Signal propagation via cortical hierarchies. *Netw. Neurosci.* **4**, 1072–1090 (2020).

[Article](https://doi.org/10.1162%2Fnetn_a_00153) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=33195949) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC7657265) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Signal%20propagation%20via%20cortical%20hierarchies&journal=Netw.%20Neurosci.&doi=10.1162%2Fnetn_a_00153&volume=4&pages=1072-1090&publication_year=2020&author=V%C3%A9zquez-Rodr%C3%ADguez%2CB&author=Liu%2CZ-Q&author=Hagmann%2CP&author=Misic%2CB)

[^71]: Boguñá, M. et al. Network geometry. *Nat. Rev. Phys.* **3**, 114–135 (2021).

[Article](https://doi.org/10.1038%2Fs42254-020-00264-4) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Network%20geometry&journal=Nat.%20Rev.%20Phys.&doi=10.1038%2Fs42254-020-00264-4&volume=3&pages=114-135&publication_year=2021&author=Bogu%C3%B1%C3%A1%2CM)

[^72]: Zheng, M., Allard, A., Hagmann, P., Alemán-Gómez, Y. & Serrano, M. Á. Geometric renormalization unravels self-similarity of the multiscale human connectome. *Proc. Natl Acad. Sci. USA* **117**, 20244–20253 (2020).

[Article](https://doi.org/10.1073%2Fpnas.1922248117) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB3cXhs1ehtLfM) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=32759211) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC7443937) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Geometric%20renormalization%20unravels%20self-similarity%20of%20the%20multiscale%20human%20connectome&journal=Proc.%20Natl%20Acad.%20Sci.%20USA&doi=10.1073%2Fpnas.1922248117&volume=117&pages=20244-20253&publication_year=2020&author=Zheng%2CM&author=Allard%2CA&author=Hagmann%2CP&author=Alem%C3%A1n-G%C3%B3mez%2CY&author=Serrano%2CM%C3%81)

[^73]: Allard, A. & Serrano, M. Á. Navigable maps of structural brain networks across species. *PLoS Comput. Biol.* **16**, e1007584 (2020).

[Article](https://doi.org/10.1371%2Fjournal.pcbi.1007584) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB3cXptVSrsL4%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=32012151) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC7018228) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Navigable%20maps%20of%20structural%20brain%20networks%20across%20species&journal=PLoS%20Comput.%20Biol.&doi=10.1371%2Fjournal.pcbi.1007584&volume=16&publication_year=2020&author=Allard%2CA&author=Serrano%2CM%C3%81)

[^74]: Duran-Nebreda, S., Johnston, I. G. & Bassel, G. W. Efficient vasculature investment in tissues can be determined without global information. *J. R. Soc. Interface* **17**, 20200137 (2020).

[Article](https://doi.org/10.1098%2Frsif.2020.0137) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=32316879) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC7211487) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Efficient%20vasculature%20investment%20in%20tissues%20can%20be%20determined%20without%20global%20information&journal=J.%20R.%20Soc.%20Interface&doi=10.1098%2Frsif.2020.0137&volume=17&publication_year=2020&author=Duran-Nebreda%2CS&author=Johnston%2CIG&author=Bassel%2CGW)

[^75]: Masuda, N., Porter, M. A. & Lambiotte, R. Random walks and diffusion on networks. *Phys. Rep.* **716**, 1–58 (2017). **This study is a** **comprehensive review on random walks dynamics in complex networks.**

[Article](https://doi.org/10.1016%2Fj.physrep.2017.07.007) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Random%20walks%20and%20diffusion%20on%20networks&journal=Phys.%20Rep.&doi=10.1016%2Fj.physrep.2017.07.007&volume=716&pages=1-58&publication_year=2017&author=Masuda%2CN&author=Porter%2CMA&author=Lambiotte%2CR)

[^76]: Noh, J. D. & Rieger, H. Random walks on complex networks. *Phys. Rev. Lett.* **92**, 118701 (2004).

[Article](https://doi.org/10.1103%2FPhysRevLett.92.118701) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=15089179) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Random%20walks%20on%20complex%20networks&journal=Phys.%20Rev.%20Lett.&doi=10.1103%2FPhysRevLett.92.118701&volume=92&publication_year=2004&author=Noh%2CJD&author=Rieger%2CH)

[^77]: Estrada, E. & Hatano, N. Communicability in complex networks. *Phys. Rev. E Stat. Nonlin. Soft Matter Phys.* **77**, 036111 (2008). **This seminal work introduced the concept of communicability in complex networks.**

[Article](https://doi.org/10.1103%2FPhysRevE.77.036111) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=18517465) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Communicability%20in%20complex%20networks&journal=Phys.%20Rev.%20E%20Stat.%20Nonlin.%20Soft%20Matter%20Phys.&doi=10.1103%2FPhysRevE.77.036111&volume=77&publication_year=2008&author=Estrada%2CE&author=Hatano%2CN)

[^78]: Estrada, E., Hatano, N. & Benzi, M. The physics of communicability in complex networks. *Phys. Rep.* **514**, 89–119 (2012).

[Article](https://doi.org/10.1016%2Fj.physrep.2012.01.006) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20physics%20of%20communicability%20in%20complex%20networks&journal=Phys.%20Rep.&doi=10.1016%2Fj.physrep.2012.01.006&volume=514&pages=89-119&publication_year=2012&author=Estrada%2CE&author=Hatano%2CN&author=Benzi%2CM)

[^79]: Granovetter, M. Threshold models of collective behavior. *Am. J. Sociol.* **83**, 1420–1443 (1978).

[Article](https://doi.org/10.1086%2F226707) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Threshold%20models%20of%20collective%20behavior&journal=Am.%20J.%20Sociol.&doi=10.1086%2F226707&volume=83&pages=1420-1443&publication_year=1978&author=Granovetter%2CM)

[^80]: Nematzadeh, A., Ferrara, E., Flammini, A. & Ahn, Y.-Y. Optimal network modularity for information diffusion. *Phys. Rev. Lett.* **113**, 088701 (2014).

[Article](https://doi.org/10.1103%2FPhysRevLett.113.088701) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=25192129) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Optimal%20network%20modularity%20for%20information%20diffusion&journal=Phys.%20Rev.%20Lett.&doi=10.1103%2FPhysRevLett.113.088701&volume=113&publication_year=2014&author=Nematzadeh%2CA&author=Ferrara%2CE&author=Flammini%2CA&author=Ahn%2CY-Y)

[^81]: Mišić, B. et al. Cooperative and competitive spreading dynamics on the human connectome. *Neuron* **86**, 1518–1529 (2015).

[Article](https://doi.org/10.1016%2Fj.neuron.2015.05.035) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=26087168) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Cooperative%20and%20competitive%20spreading%20dynamics%20on%20the%20human%20connectome&journal=Neuron&doi=10.1016%2Fj.neuron.2015.05.035&volume=86&pages=1518-1529&publication_year=2015&author=Mi%C5%A1i%C4%87%2CB)

[^82]: Worrell, J. C., Rumschlag, J., Betzel, R. F., Sporns, O. & Mišić, B. Optimized connectome architecture for sensory-motor integration. *Netw. Neurosci.* **1**, 415–430 (2018).

[Article](https://doi.org/10.1162%2FNETN_a_00022) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=30090872) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Optimized%20connectome%20architecture%20for%20sensory-motor%20integration&journal=Netw.%20Neurosci.&doi=10.1162%2FNETN_a_00022&volume=1&pages=415-430&publication_year=2018&author=Worrell%2CJC&author=Rumschlag%2CJ&author=Betzel%2CRF&author=Sporns%2CO&author=Mi%C5%A1i%C4%87%2CB)

[^83]: Shadi, K., Dyer, E. & Dovrolis, C. Multisensory integration in the mouse cortical connectome using a network diffusion model. *Netw. Neurosci.* **4**, 1030–1054 (2020).

[Article](https://doi.org/10.1162%2Fnetn_a_00164) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=33195947) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC7655044) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Multisensory%20integration%20in%20the%20mouse%20cortical%20connectome%20using%20a%20network%20diffusion%20model&journal=Netw.%20Neurosci.&doi=10.1162%2Fnetn_a_00164&volume=4&pages=1030-1054&publication_year=2020&author=Shadi%2CK&author=Dyer%2CE&author=Dovrolis%2CC)

[^84]: Gómez-Gardeñes, J. & Latora, V. Entropy rate of diffusion processes on complex networks. *Phys. Rev. E Stat. Nonlin. Soft Matter Phys.* **78**, 065102 (2008).

[Article](https://doi.org/10.1103%2FPhysRevE.78.065102) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=19256892) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Entropy%20rate%20of%20diffusion%20processes%20on%20complex%20networks&journal=Phys.%20Rev.%20E%20Stat.%20Nonlin.%20Soft%20Matter%20Phys.&doi=10.1103%2FPhysRevE.78.065102&volume=78&publication_year=2008&author=G%C3%B3mez-Garde%C3%B1es%2CJ&author=Latora%2CV)

[^85]: Lambiotte, R. et al. Flow graphs: interweaving dynamics and structure. *Phys. Rev. E Stat. Nonlin. Soft Matter Phys.* **84**, 017102 (2011).

[Article](https://doi.org/10.1103%2FPhysRevE.84.017102) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DC%2BC3MjovVOktA%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=21867345) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Flow%20graphs%3A%20interweaving%20dynamics%20and%20structure&journal=Phys.%20Rev.%20E%20Stat.%20Nonlin.%20Soft%20Matter%20Phys.&doi=10.1103%2FPhysRevE.84.017102&volume=84&publication_year=2011&author=Lambiotte%2CR)

[^86]: Benigni, B., Gallotti, R. & De Domenico, M. Potential-driven random walks on interconnected systems. *Phys. Rev. E* **104**, 024120 (2021).

[Article](https://doi.org/10.1103%2FPhysRevE.104.024120) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB3MXitVeqs7fI) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=34525567) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Potential-driven%20random%20walks%20on%20interconnected%20systems&journal=Phys.%20Rev.%20E&doi=10.1103%2FPhysRevE.104.024120&volume=104&publication_year=2021&author=Benigni%2CB&author=Gallotti%2CR&author=Domenico%2CM)

[^87]: Yin, C.-Y., Wang, B.-H., Wang, W.-X., Zhou, T. & Yang, H.-J. Efficient routing on scale-free networks based on local information. *Phys. Lett. A* **351**, 220–224 (2006).

[Article](https://doi.org/10.1016%2Fj.physleta.2005.10.104) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD28XhsFyisL4%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Efficient%20routing%20on%20scale-free%20networks%20based%20on%20local%20information&journal=Phys.%20Lett.%20A&doi=10.1016%2Fj.physleta.2005.10.104&volume=351&pages=220-224&publication_year=2006&author=Yin%2CC-Y&author=Wang%2CB-H&author=Wang%2CW-X&author=Zhou%2CT&author=Yang%2CH-J)

[^88]: Csoma, A. et al. Routes obey hierarchy in complex networks. *Sci. Rep.* **7**, 7243 (2017).

[Article](https://doi.org/10.1038%2Fs41598-017-07412-4) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=28775278) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5543142) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Routes%20obey%20hierarchy%20in%20complex%20networks&journal=Sci.%20Rep.&doi=10.1038%2Fs41598-017-07412-4&volume=7&publication_year=2017&author=Csoma%2CA)

[^89]: Deco, G., Jirsa, V. K. & McIntosh, A. R. Emerging concepts for the dynamical organization of resting-state activity in the brain. *Nat. Rev. Neurosci.* **12**, 43–56 (2011).

[Article](https://doi.org/10.1038%2Fnrn2961) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC3cXhsFyisLnF) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=21170073) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Emerging%20concepts%20for%20the%20dynamical%20organization%20of%20resting-state%20activity%20in%20the%20brain&journal=Nat.%20Rev.%20Neurosci.&doi=10.1038%2Fnrn2961&volume=12&pages=43-56&publication_year=2011&author=Deco%2CG&author=Jirsa%2CVK&author=McIntosh%2CAR)

[^90]: Abdelnour, F., Voss, H. U. & Raj, A. Network diffusion accurately models the relationship between structural and functional brain connectivity networks. *NeuroImage* **90**, 335–347 (2014).

[Article](https://doi.org/10.1016%2Fj.neuroimage.2013.12.039) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=24384152) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Network%20diffusion%20accurately%20models%20the%20relationship%20between%20structural%20and%20functional%20brain%20connectivity%20networks&journal=NeuroImage&doi=10.1016%2Fj.neuroimage.2013.12.039&volume=90&pages=335-347&publication_year=2014&author=Abdelnour%2CF&author=Voss%2CHU&author=Raj%2CA)

[^91]: Cole, M. W., Bassett, D. S., Power, J. D., Braver, T. S. & Petersen, S. E. Intrinsic and task-evoked network architectures of the human brain. *Neuron* **83**, 238–251 (2014).

[Article](https://doi.org/10.1016%2Fj.neuron.2014.05.014) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2cXhtFWgt7bL) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=24991964) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4082806) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Intrinsic%20and%20task-evoked%20network%20architectures%20of%20the%20human%20brain&journal=Neuron&doi=10.1016%2Fj.neuron.2014.05.014&volume=83&pages=238-251&publication_year=2014&author=Cole%2CMW&author=Bassett%2CDS&author=Power%2CJD&author=Braver%2CTS&author=Petersen%2CSE)

[^92]: Siddiqi, S. H., Kording, K. P., Parvizi, J. & Fox, M. D. Causal mapping of human brain function. *Nat. Rev. Neurosci.* **23**, 361–375 (2022). **This recent review discusses current efforts and future directions to map causal interactions in the human brain. Concepts outlined in this work may provide avenues for the testing and validation of network communication models.**

[Article](https://doi.org/10.1038%2Fs41583-022-00583-8) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB38XhtVGnsLbO) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=35444305) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC9387758) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Causal%20mapping%20of%20human%20brain%20function&journal=Nat.%20Rev.%20Neurosci.&doi=10.1038%2Fs41583-022-00583-8&volume=23&pages=361-375&publication_year=2022&author=Siddiqi%2CSH&author=Kording%2CKP&author=Parvizi%2CJ&author=Fox%2CMD)

[^93]: Medaglia, J. D., Lynall, M.-E. & Bassett, D. S. Cognitive network neuroscience. *J. Cogn. Neurosci.* **27**, 1471–1491 (2015).

[Article](https://doi.org/10.1162%2Fjocn_a_00810) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=25803596) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4854276) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Cognitive%20network%20neuroscience&journal=J.%20Cogn.%20Neurosci.&doi=10.1162%2Fjocn_a_00810&volume=27&pages=1471-1491&publication_year=2015&author=Medaglia%2CJD&author=Lynall%2CM-E&author=Bassett%2CDS)

[^94]: Smith, S. M. et al. A positive–negative mode of population covariation links brain connectivity, demographics and behavior. *Nat. Neurosci.* **18**, 1565–1567 (2015).

[Article](https://doi.org/10.1038%2Fnn.4125) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2MXhsFKqu7vN) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=26414616) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4625579) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20positive%E2%80%93negative%20mode%20of%20population%20covariation%20links%20brain%20connectivity%2C%20demographics%20and%20behavior&journal=Nat.%20Neurosci.&doi=10.1038%2Fnn.4125&volume=18&pages=1565-1567&publication_year=2015&author=Smith%2CSM)

[^95]: Fornito, A., Zalesky, A. & Breakspear, M. Graph analysis of the human connectome: promise, progress, and pitfalls. *NeuroImage* **80**, 426–444 (2013).

[Article](https://doi.org/10.1016%2Fj.neuroimage.2013.04.087) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=23643999) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Graph%20analysis%20of%20the%20human%20connectome%3A%20promise%2C%20progress%2C%20and%20pitfalls&journal=NeuroImage&doi=10.1016%2Fj.neuroimage.2013.04.087&volume=80&pages=426-444&publication_year=2013&author=Fornito%2CA&author=Zalesky%2CA&author=Breakspear%2CM)

[^96]: Popp, J. L. et al. Structural–functional brain network coupling predicts human cognitive ability. Preprint at *bioRxiv* [https://doi.org/10.1101/2023.02.09.527639](https://doi.org/10.1101/2023.02.09.527639) (2023).

[^97]: Zorlu, N. et al. Abnormal structural network communication reflects cognitive deficits in schizophrenia. *Brain Topogr.* **36**, 294–304 (2023).

[Article](https://link.springer.com/doi/10.1007/s10548-023-00954-z) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=36971857) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Abnormal%20structural%20network%20communication%20reflects%20cognitive%20deficits%20in%20schizophrenia&journal=Brain%20Topogr.&doi=10.1007%2Fs10548-023-00954-z&volume=36&pages=294-304&publication_year=2023&author=Zorlu%2CN)

[^98]: Imms, P. et al. The structural connectome in traumatic brain injury: a meta-analysis of graph metrics. *Neurosci. Biobehav. Rev.* **99**, 128–137 (2019).

[Article](https://doi.org/10.1016%2Fj.neubiorev.2019.01.002) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=30615935) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20structural%20connectome%20in%20traumatic%20brain%20injury%3A%20a%20meta-analysis%20of%20graph%20metrics&journal=Neurosci.%20Biobehav.%20Rev.&doi=10.1016%2Fj.neubiorev.2019.01.002&volume=99&pages=128-137&publication_year=2019&author=Imms%2CP)

[^99]: Imms, P. et al. Exploring personalized structural connectomics for moderate to severe traumatic brain injury. *Netw. Neurosci.* **7**, 160–183 (2023).

[Article](https://doi.org/10.1162%2Fnetn_a_00277) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=37334004) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC10270710) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Exploring%20personalized%20structural%20connectomics%20for%20moderate%20to%20severe%20traumatic%20brain%20injury&journal=Netw.%20Neurosci.&doi=10.1162%2Fnetn_a_00277&volume=7&pages=160-183&publication_year=2023&author=Imms%2CP)

[^100]: Kuceyeski, A. et al. The application of a mathematical model linking structural and functional connectomes in severe brain injury. *NeuroImage Clin.* **11**, 635–647 (2016).

[Article](https://doi.org/10.1016%2Fj.nicl.2016.04.006) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DC%2BC2s%2FhsFGrsg%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=27200264) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4864323) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20application%20of%20a%20mathematical%20model%20linking%20structural%20and%20functional%20connectomes%20in%20severe%20brain%20injury&journal=NeuroImage%20Clin.&doi=10.1016%2Fj.nicl.2016.04.006&volume=11&pages=635-647&publication_year=2016&author=Kuceyeski%2CA)

[^101]: Kuceyeski, A. F., Jamison, K. W., Owen, J. P., Raj, A. & Mukherjee, P. Longitudinal increases in structural connectome segregation and functional connectome integration are associated with better recovery after mild TBI. *Hum. Brain Mapp.* **40**, 4441–4456 (2019).

[Article](https://doi.org/10.1002%2Fhbm.24713) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=31294921) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6865536) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Longitudinal%20increases%20in%20structural%20connectome%20segregation%20and%20functional%20connectome%20integration%20are%20associated%20with%20better%20recovery%20after%20mild%20TBI&journal=Hum.%20Brain%20Mapp.&doi=10.1002%2Fhbm.24713&volume=40&pages=4441-4456&publication_year=2019&author=Kuceyeski%2CAF&author=Jamison%2CKW&author=Owen%2CJP&author=Raj%2CA&author=Mukherjee%2CP)

[^102]: Albert, R., Jeong, H. & Barabasi, A. L. Error and attack tolerance of complex networks. *Nature* **406**, 378–382 (2000).

[Article](https://doi.org/10.1038%2F35019019) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD3cXlslKgtLk%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=10935628) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Error%20and%20attack%20tolerance%20of%20complex%20networks&journal=Nature&doi=10.1038%2F35019019&volume=406&pages=378-382&publication_year=2000&author=Albert%2CR&author=Jeong%2CH&author=Barabasi%2CAL)

[^103]: Palop, J. J. & Mucke, L. Amyloid-beta-induced neuronal dysfunction in Alzheimer’s disease: from synapses toward neural networks. *Nat. Neurosci.* **13**, 812–818 (2010).

[Article](https://doi.org/10.1038%2Fnn.2583) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC3cXnvFSgtr0%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=20581818) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3072750) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Amyloid-beta-induced%20neuronal%20dysfunction%20in%20Alzheimer%E2%80%99s%20disease%3A%20from%20synapses%20toward%20neural%20networks&journal=Nat.%20Neurosci.&doi=10.1038%2Fnn.2583&volume=13&pages=812-818&publication_year=2010&author=Palop%2CJJ&author=Mucke%2CL)

[^104]: Raj, A., Kuceyeski, A. & Weiner, M. A network diffusion model of disease progression in dementia. *Neuron* **73**, 1204–1215 (2012).

[Article](https://doi.org/10.1016%2Fj.neuron.2011.12.040) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC38XktlKqt78%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=22445347) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3623298) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20network%20diffusion%20model%20of%20disease%20progression%20in%20dementia&journal=Neuron&doi=10.1016%2Fj.neuron.2011.12.040&volume=73&pages=1204-1215&publication_year=2012&author=Raj%2CA&author=Kuceyeski%2CA&author=Weiner%2CM)

[^105]: Meier, J. M. et al. Connectome-based propagation model in amyotrophic lateral sclerosis. *Ann. Neurol.* **87**, 725–738 (2020).

[Article](https://doi.org/10.1002%2Fana.25706) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=32072667) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC7186838) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Connectome-based%20propagation%20model%20in%20amyotrophic%20lateral%20sclerosis&journal=Ann.%20Neurol.&doi=10.1002%2Fana.25706&volume=87&pages=725-738&publication_year=2020&author=Meier%2CJM)

[^106]: Vogel, J. W. et al. Spread of pathological tau proteins through communicating neurons in human Alzheimer’s disease. *Nat. Commun.* **11**, 2612 (2020).

[Article](https://doi.org/10.1038%2Fs41467-020-15701-2) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB3cXhtVCmtb7E) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=32457389) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC7251068) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Spread%20of%20pathological%20tau%20proteins%20through%20communicating%20neurons%20in%20human%20Alzheimer%E2%80%99s%20disease&journal=Nat.%20Commun.&doi=10.1038%2Fs41467-020-15701-2&volume=11&publication_year=2020&author=Vogel%2CJW)

[^107]: Zheng, Y.-Q. et al. Local vulnerability and global connectivity jointly shape neurodegenerative disease propagation. *PLoS Biol.* **17**, e3000495 (2019).

[Article](https://doi.org/10.1371%2Fjournal.pbio.3000495) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB3cXhsVWjs70%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=31751329) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6894889) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Local%20vulnerability%20and%20global%20connectivity%20jointly%20shape%20neurodegenerative%20disease%20propagation&journal=PLoS%20Biol.&doi=10.1371%2Fjournal.pbio.3000495&volume=17&publication_year=2019&author=Zheng%2CY-Q)

[^108]: Wannan, C. M. J. et al. Evidence for network-based cortical thickness reductions in schizophrenia. *Am. J. Psychiatry* **176**, 552–563 (2019).

[Article](https://doi.org/10.1176%2Fappi.ajp.2019.18040380) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=31164006) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Evidence%20for%20network-based%20cortical%20thickness%20reductions%20in%20schizophrenia&journal=Am.%20J.%20Psychiatry&doi=10.1176%2Fappi.ajp.2019.18040380&volume=176&pages=552-563&publication_year=2019&author=Wannan%2CCMJ)

[^109]: Shafiei, G. et al. Spatial patterning of tissue volume loss in schizophrenia reflects brain network architecture. *Biol. Psychiatry* **87**, 727–735 (2020).

[Article](https://doi.org/10.1016%2Fj.biopsych.2019.09.031) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1MXitl2gtbfE) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=31837746) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Spatial%20patterning%20of%20tissue%20volume%20loss%20in%20schizophrenia%20reflects%20brain%20network%20architecture&journal=Biol.%20Psychiatry&doi=10.1016%2Fj.biopsych.2019.09.031&volume=87&pages=727-735&publication_year=2020&author=Shafiei%2CG)

[^110]: Miller, K. L. et al. Multimodal population brain imaging in the UK Biobank prospective epidemiological study. *Nat. Neurosci.* **19**, 1523–1536 (2016).

[Article](https://doi.org/10.1038%2Fnn.4393) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC28XhsFenu7nE) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=27643430) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5086094) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Multimodal%20population%20brain%20imaging%20in%20the%20UK%20Biobank%20prospective%20epidemiological%20study&journal=Nat.%20Neurosci.&doi=10.1038%2Fnn.4393&volume=19&pages=1523-1536&publication_year=2016&author=Miller%2CKL)

[^111]: Sina Mansour, L., Di Biase, M. A., Smith, R. E., Zalesky, A. & Seguin, C. Connectomes for 40,000 UK Biobank participants: a multi-modal, multi-scale brain network resource. Preprint at *bioRxiv* [https://doi.org/10.1101/2023.03.10.532036](https://doi.org/10.1101/2023.03.10.532036) (2023).

[^112]: Keller, C. J. et al. Mapping human brain networks with cortico-cortical evoked potentials. *Philos. Trans. R. Soc. Lond. B Biol. Sci.* **369**, 20130528 (2014).

[Article](https://doi.org/10.1098%2Frstb.2013.0528) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=25180306) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4150303) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Mapping%20human%20brain%20networks%20with%20cortico-cortical%20evoked%20potentials&journal=Philos.%20Trans.%20R.%20Soc.%20Lond.%20B%20Biol.%20Sci.&doi=10.1098%2Frstb.2013.0528&volume=369&publication_year=2014&author=Keller%2CCJ)

[^113]: Sydnor, V. J. et al. Cortical–subcortical structural connections support transcranial magnetic stimulation engagement of the amygdala. *Sci. Adv.* **8**, eabn5803 (2022).

[Article](https://doi.org/10.1126%2Fsciadv.abn5803) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB38XhvVegsL7L) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=35731882) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC9217085) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Cortical%E2%80%93subcortical%20structural%20connections%20support%20transcranial%20magnetic%20stimulation%20engagement%20of%20the%20amygdala&journal=Sci.%20Adv.&doi=10.1126%2Fsciadv.abn5803&volume=8&publication_year=2022&author=Sydnor%2CVJ)

[^114]: Ozdemir, R. A. et al. Individualized perturbation of the human connectome reveals reproducible biomarkers of network dynamics relevant to cognition. *Proc. Natl Acad. Sci. USA* **117**, 8115–8125 (2020).

[Article](https://doi.org/10.1073%2Fpnas.1911240117) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB3cXms1yhuro%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=32193345) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC7149310) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Individualized%20perturbation%20of%20the%20human%20connectome%20reveals%20reproducible%20biomarkers%20of%20network%20dynamics%20relevant%20to%20cognition&journal=Proc.%20Natl%20Acad.%20Sci.%20USA&doi=10.1073%2Fpnas.1911240117&volume=117&pages=8115-8125&publication_year=2020&author=Ozdemir%2CRA)

[^115]: Veit, M. J. et al. Temporal order of signal propagation within and across intrinsic brain networks. *Proc. Natl Acad. Sci. USA* **118**, e2105031118 (2021).

[Article](https://doi.org/10.1073%2Fpnas.2105031118) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB38Xhs1Kksrk%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=34819365) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC8640784) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Temporal%20order%20of%20signal%20propagation%20within%20and%20across%20intrinsic%20brain%20networks&journal=Proc.%20Natl%20Acad.%20Sci.%20USA&doi=10.1073%2Fpnas.2105031118&volume=118&publication_year=2021&author=Veit%2CMJ)

[^116]: Seguin, C. et al. Communication dynamics in the human connectome shape the cortex-wide propagation of direct electrical stimulation. *Neuron* **111**, 1391–1401.e5 (2023). **The first paper to show that network communication models can predict the propagation of direct electrical stimulation through the human brain.**

[Article](https://doi.org/10.1016%2Fj.neuron.2023.01.027) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB3sXks1Gjsrc%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=36889313) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Communication%20dynamics%20in%20the%20human%20connectome%20shape%20the%20cortex-wide%20propagation%20of%20direct%20electrical%20stimulation&journal=Neuron&doi=10.1016%2Fj.neuron.2023.01.027&volume=111&pages=1391-1401.e5&publication_year=2023&author=Seguin%2CC)

[^117]: Siddiqi, S. H., Taylor, J. J., Horn, A. & Fox, M. D. Bringing human brain connectomics to clinical practice in psychiatry. *Biol. Psychiatry* **93**, 386–387 (2023).

[Article](https://doi.org/10.1016%2Fj.biopsych.2022.05.026) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=35868885) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Bringing%20human%20brain%20connectomics%20to%20clinical%20practice%20in%20psychiatry&journal=Biol.%20Psychiatry&doi=10.1016%2Fj.biopsych.2022.05.026&volume=93&pages=386-387&publication_year=2023&author=Siddiqi%2CSH&author=Taylor%2CJJ&author=Horn%2CA&author=Fox%2CMD)

[^118]: Horn, A. & Fox, M. D. Opportunities of connectomic neuromodulation. *NeuroImage* **221**, 117180 (2020).

[Article](https://doi.org/10.1016%2Fj.neuroimage.2020.117180) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=32702488) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Opportunities%20of%20connectomic%20neuromodulation&journal=NeuroImage&doi=10.1016%2Fj.neuroimage.2020.117180&volume=221&publication_year=2020&author=Horn%2CA&author=Fox%2CMD)

[^119]: Horn, A. et al. Connectivity predicts deep brain stimulation outcome in Parkinson disease. *Ann. Neurol.* **82**, 67–78 (2017).

[Article](https://doi.org/10.1002%2Fana.24974) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=28586141) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5880678) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Connectivity%20predicts%20deep%20brain%20stimulation%20outcome%20in%20Parkinson%20disease&journal=Ann.%20Neurol.&doi=10.1002%2Fana.24974&volume=82&pages=67-78&publication_year=2017&author=Horn%2CA)

[^120]: Cash, R. F. H. et al. Subgenual functional connectivity predicts antidepressant treatment response to transcranial magnetic stimulation: independent validation and evaluation of personalization. *Biol. Psychiatry* **86**, e5–e7 (2019).

[Article](https://doi.org/10.1016%2Fj.biopsych.2018.12.002) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=30670304) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Subgenual%20functional%20connectivity%20predicts%20antidepressant%20treatment%20response%20to%20transcranial%20magnetic%20stimulation%3A%20independent%20validation%20and%20evaluation%20of%20personalization&journal=Biol.%20Psychiatry&doi=10.1016%2Fj.biopsych.2018.12.002&volume=86&pages=e5-e7&publication_year=2019&author=Cash%2CRFH)

[^121]: Fox, M. D., Buckner, R. L., White, M. P., Greicius, M. D. & Pascual-Leone, A. Efficacy of transcranial magnetic stimulation targets for depression is related to intrinsic functional connectivity with the subgenual cingulate. *Biol. Psychiatry* **72**, 595–603 (2012).

[Article](https://doi.org/10.1016%2Fj.biopsych.2012.04.028) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=22658708) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4120275) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Efficacy%20of%20transcranial%20magnetic%20stimulation%20targets%20for%20depression%20is%20related%20to%20intrinsic%20functional%20connectivity%20with%20the%20subgenual%20cingulate&journal=Biol.%20Psychiatry&doi=10.1016%2Fj.biopsych.2012.04.028&volume=72&pages=595-603&publication_year=2012&author=Fox%2CMD&author=Buckner%2CRL&author=White%2CMP&author=Greicius%2CMD&author=Pascual-Leone%2CA)

[^122]: Schelling, T. C. Dynamic models of segregation. *J. Math. Sociol.* **1**, 143–186 (1971).

[Article](https://doi.org/10.1080%2F0022250X.1971.9989794) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Dynamic%20models%20of%20segregation&journal=J.%20Math.%20Sociol.&doi=10.1080%2F0022250X.1971.9989794&volume=1&pages=143-186&publication_year=1971&author=Schelling%2CTC)

[^123]: Helbing, D., Farkas, I. & Vicsek, T. Simulating dynamical features of escape panic. *Nature* **407**, 487–490 (2000).

[Article](https://doi.org/10.1038%2F35035023) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD3cXntlSmuro%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=11028994) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Simulating%20dynamical%20features%20of%20escape%20panic&journal=Nature&doi=10.1038%2F35035023&volume=407&pages=487-490&publication_year=2000&author=Helbing%2CD&author=Farkas%2CI&author=Vicsek%2CT)

[^124]: Zamani Esfahlani, F., Faskowitz, J., Slack, J., Mišić, B. & Betzel, R. F. Local structure–function relationships in human brain networks across the lifespan. *Nat. Commun.* **13**, 2053 (2022). **This paper carries out a comprehensive comparison of the extent to which different network communication models can explain patterns of functional connectivity.**

[Article](https://doi.org/10.1038%2Fs41467-022-29770-y) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB38XhtVGht77J) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=35440659) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC9018911) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Local%20structure%E2%80%93function%20relationships%20in%20human%20brain%20networks%20across%20the%20lifespan&journal=Nat.%20Commun.&doi=10.1038%2Fs41467-022-29770-y&volume=13&publication_year=2022&author=Zamani%20Esfahlani%2CF&author=Faskowitz%2CJ&author=Slack%2CJ&author=Mi%C5%A1i%C4%87%2CB&author=Betzel%2CRF)

[^125]: Mišic, B. et al. Network-based asymmetry of the human auditory system. *Cereb. Cortex* **28**, 2655–2664 (2018).

[Article](https://doi.org/10.1093%2Fcercor%2Fbhy101) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=29722805) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5998951) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Network-based%20asymmetry%20of%20the%20human%20auditory%20system&journal=Cereb.%20Cortex&doi=10.1093%2Fcercor%2Fbhy101&volume=28&pages=2655-2664&publication_year=2018&author=Mi%C5%A1ic%2CB)

[^126]: Seguin, C., Mansour, C. S., Sporns, O., Zalesky, A. & Calamante, F. Network communication models narrow the gap between the modular organization of structural and functional brain networks. *NeuroImage* **257**, 119323 (2022).

[Article](https://doi.org/10.1016%2Fj.neuroimage.2022.119323) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=35605765) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Network%20communication%20models%20narrow%20the%20gap%20between%20the%20modular%20organization%20of%20structural%20and%20functional%20brain%20networks&journal=NeuroImage&doi=10.1016%2Fj.neuroimage.2022.119323&volume=257&publication_year=2022&author=Seguin%2CC&author=Mansour%2CCS&author=Sporns%2CO&author=Zalesky%2CA&author=Calamante%2CF)

[^127]: Amico, E. et al. Toward an information theoretical description of communication in brain networks. *Netw. Neurosci.* **5**, 646–665 (2021).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=34746621) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC8567835) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Toward%20an%20information%20theoretical%20description%20of%20communication%20in%20brain%20networks&journal=Netw.%20Neurosci.&volume=5&pages=646-665&publication_year=2021&author=Amico%2CE)

[^128]: Hao, Y. & Graham, D. Creative destruction: sparse activity emerges on the mammal connectome under a simulated communication strategy with collisions and redundancy. *Netw. Neurosci.* **4**, 1055–1071 (2020).

[Article](https://doi.org/10.1162%2Fnetn_a_00165) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=33195948) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC7655042) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Creative%20destruction%3A%20sparse%20activity%20emerges%20on%20the%20mammal%20connectome%20under%20a%20simulated%20communication%20strategy%20with%20collisions%20and%20redundancy&journal=Netw.%20Neurosci.&doi=10.1162%2Fnetn_a_00165&volume=4&pages=1055-1071&publication_year=2020&author=Hao%2CY&author=Graham%2CD)

[^129]: Hillary, F. G. & Grafman, J. H. Injured brains and adaptive networks: the benefits and costs of hyperconnectivity. *Trends Cogn. Sci.* **21**, 385–401 (2017).

[Article](https://doi.org/10.1016%2Fj.tics.2017.03.003) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=28372878) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6664441) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Injured%20brains%20and%20adaptive%20networks%3A%20the%20benefits%20and%20costs%20of%20hyperconnectivity&journal=Trends%20Cogn.%20Sci.&doi=10.1016%2Fj.tics.2017.03.003&volume=21&pages=385-401&publication_year=2017&author=Hillary%2CFG&author=Grafman%2CJH)

[^130]: Park, B.-Y. et al. Signal diffusion along connectome gradients and inter-hub routing differentially contribute to dynamic human brain function. *NeuroImage* **224**, 117429 (2021).

[Article](https://doi.org/10.1016%2Fj.neuroimage.2020.117429) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=33038538) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Signal%20diffusion%20along%20connectome%20gradients%20and%20inter-hub%20routing%20differentially%20contribute%20to%20dynamic%20human%20brain%20function&journal=NeuroImage&doi=10.1016%2Fj.neuroimage.2020.117429&volume=224&publication_year=2021&author=Park%2CB-Y)

[^131]: Bazinet, V., Vos de Wael, R., Hagmann, P., Bernhardt, B. C. & Misic, B. Multiscale communication in cortico-cortical networks. *NeuroImage* **243**, 118546 (2021).

[Article](https://doi.org/10.1016%2Fj.neuroimage.2021.118546) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=34478823) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Multiscale%20communication%20in%20cortico-cortical%20networks&journal=NeuroImage&doi=10.1016%2Fj.neuroimage.2021.118546&volume=243&publication_year=2021&author=Bazinet%2CV&author=Vos%20de%20Wael%2CR&author=Hagmann%2CP&author=Bernhardt%2CBC&author=Misic%2CB)

[^132]: Betzel, R. F., Faskowitz, J., Mišić, B., Sporns, O. & Seguin, C. Multi-policy models of interregional communication in the human connectome. Preprint at *bioRxiv* [https://doi.org/10.1101/2022.05.08.490752](https://doi.org/10.1101/2022.05.08.490752) (2022).

[^133]: Mišić, B., Sporns, O. & McIntosh, A. R. Communication efficiency and congestion of signal traffic in large-scale brain networks. *PLoS Comput. Biol.* **10**, e1003427 (2014).

[Article](https://doi.org/10.1371%2Fjournal.pcbi.1003427) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=24415931) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3886893) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Communication%20efficiency%20and%20congestion%20of%20signal%20traffic%20in%20large-scale%20brain%20networks&journal=PLoS%20Comput.%20Biol.&doi=10.1371%2Fjournal.pcbi.1003427&volume=10&publication_year=2014&author=Mi%C5%A1i%C4%87%2CB&author=Sporns%2CO&author=McIntosh%2CAR)

[^134]: Griffa, A. et al. Transient networks of spatio-temporal connectivity map communication pathways in brain functional systems. *NeuroImage* **155**, 490–502 (2017). **This work uses an innovative multilayer framework to track the time-resolved propagation of functional activity and relates it to communication via structural connectivity.**

[Article](https://doi.org/10.1016%2Fj.neuroimage.2017.04.015) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=28412440) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Transient%20networks%20of%20spatio-temporal%20connectivity%20map%20communication%20pathways%20in%20brain%20functional%20systems&journal=NeuroImage&doi=10.1016%2Fj.neuroimage.2017.04.015&volume=155&pages=490-502&publication_year=2017&author=Griffa%2CA)

[^135]: Liu, Z.-Q. et al. Time-resolved structure–function coupling in brain networks. *Commun. Biol.* **5**, 532 (2022).

[Article](https://doi.org/10.1038%2Fs42003-022-03466-x) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=35654886) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC9163085) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Time-resolved%20structure%E2%80%93function%20coupling%20in%20brain%20networks&journal=Commun.%20Biol.&doi=10.1038%2Fs42003-022-03466-x&volume=5&publication_year=2022&author=Liu%2CZ-Q)

[^136]: de Lange, S. C., de Reus, M. A. & van den Heuvel, M. P. The Laplacian spectrum of neural networks. *Front. Comput. Neurosci.* **7**, 189 (2014).

[Article](https://doi.org/10.3389%2Ffncom.2013.00189) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=24454286) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3888935) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20Laplacian%20spectrum%20of%20neural%20networks&journal=Front.%20Comput.%20Neurosci.&doi=10.3389%2Ffncom.2013.00189&volume=7&publication_year=2014&author=Lange%2CSC&author=Reus%2CMA&author=Heuvel%2CMP)

[^137]: Becker, C. O. et al. Spectral mapping of brain functional connectivity from diffusion imaging. *Sci. Rep.* **8**, 1411 (2018).

[Article](https://doi.org/10.1038%2Fs41598-017-18769-x) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=29362436) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5780460) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Spectral%20mapping%20of%20brain%20functional%20connectivity%20from%20diffusion%20imaging&journal=Sci.%20Rep.&doi=10.1038%2Fs41598-017-18769-x&volume=8&publication_year=2018&author=Becker%2CCO)

[^138]: Abdelnour, F., Dayan, M., Devinsky, O., Thesen, T. & Raj, A. Functional brain connectivity is predictable from anatomic network’s Laplacian eigen-structure. *NeuroImage* **172**, 728–739 (2018).

[Article](https://doi.org/10.1016%2Fj.neuroimage.2018.02.016) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=29454104) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Functional%20brain%20connectivity%20is%20predictable%20from%20anatomic%20network%E2%80%99s%20Laplacian%20eigen-structure&journal=NeuroImage&doi=10.1016%2Fj.neuroimage.2018.02.016&volume=172&pages=728-739&publication_year=2018&author=Abdelnour%2CF&author=Dayan%2CM&author=Devinsky%2CO&author=Thesen%2CT&author=Raj%2CA)

[^139]: Deslauriers-Gauthier, S., Zucchelli, M., Frigo, M. & Deriche, R. A unified framework for multimodal structure–function mapping based on eigenmodes. *Med. Image Anal.* **66**, 101799 (2020).

[Article](https://doi.org/10.1016%2Fj.media.2020.101799) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=32889301) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20unified%20framework%20for%20multimodal%20structure%E2%80%93function%20mapping%20based%20on%20eigenmodes&journal=Med.%20Image%20Anal.&doi=10.1016%2Fj.media.2020.101799&volume=66&publication_year=2020&author=Deslauriers-Gauthier%2CS&author=Zucchelli%2CM&author=Frigo%2CM&author=Deriche%2CR)

[^140]: Tewarie, P. et al. Mapping functional brain networks from the structural connectome: relating the series expansion and eigenmode approaches. *NeuroImage* **216**, 116805 (2020).

[Article](https://doi.org/10.1016%2Fj.neuroimage.2020.116805) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=32335264) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Mapping%20functional%20brain%20networks%20from%20the%20structural%20connectome%3A%20relating%20the%20series%20expansion%20and%20eigenmode%20approaches&journal=NeuroImage&doi=10.1016%2Fj.neuroimage.2020.116805&volume=216&publication_year=2020&author=Tewarie%2CP)

[^141]: Meier, J. et al. The epidemic spreading model and the direction of information flow in brain networks. *NeuroImage* **152**, 639–646 (2017).

[Article](https://doi.org/10.1016%2Fj.neuroimage.2017.02.007) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DC%2BC1c3kvFSkuw%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=28179163) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20epidemic%20spreading%20model%20and%20the%20direction%20of%20information%20flow%20in%20brain%20networks&journal=NeuroImage&doi=10.1016%2Fj.neuroimage.2017.02.007&volume=152&pages=639-646&publication_year=2017&author=Meier%2CJ)

[^142]: Benigni, B., Ghavasieh, A., Corso, A., d’Andrea, V. & De Domenico, M. Persistence of information flow: a multiscale characterization of human brain. *Netw. Neurosci.* **5**, 831–850 (2021).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=34746629) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC8567833) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Persistence%20of%20information%20flow%3A%20a%20multiscale%20characterization%20of%20human%20brain&journal=Netw.%20Neurosci.&volume=5&pages=831-850&publication_year=2021&author=Benigni%2CB&author=Ghavasieh%2CA&author=Corso%2CA&author=d%E2%80%99Andrea%2CV&author=Domenico%2CM)

[^143]: Graham, D. & Rockmore, D. The packet switching brain. *J. Cogn. Neurosci.* **23**, 267–276 (2011).

[Article](https://doi.org/10.1162%2Fjocn.2010.21477) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=20350173) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20packet%20switching%20brain&journal=J.%20Cogn.%20Neurosci.&doi=10.1162%2Fjocn.2010.21477&volume=23&pages=267-276&publication_year=2011&author=Graham%2CD&author=Rockmore%2CD)

[^144]: Betzel, R. F., Gu, S., Medaglia, J. D., Pasqualetti, F. & Bassett, D. S. Optimally controlling the human connectome: the role of network topology. *Sci. Rep.* **6**, 30770 (2016).

[Article](https://doi.org/10.1038%2Fsrep30770) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC28Xht1KrsbnE) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=27468904) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4965758) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Optimally%20controlling%20the%20human%20connectome%3A%20the%20role%20of%20network%20topology&journal=Sci.%20Rep.&doi=10.1038%2Fsrep30770&volume=6&publication_year=2016&author=Betzel%2CRF&author=Gu%2CS&author=Medaglia%2CJD&author=Pasqualetti%2CF&author=Bassett%2CDS)

[^145]: Deco, G. et al. Resting-state functional connectivity emerges from structurally and dynamically shaped slow linear fluctuations. *J. Neurosci.* **33**, 11239–11252 (2013).

[Article](https://doi.org/10.1523%2FJNEUROSCI.1091-13.2013) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC3sXhtFWjtrfK) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=23825427) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3718368) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Resting-state%20functional%20connectivity%20emerges%20from%20structurally%20and%20dynamically%20shaped%20slow%20linear%20fluctuations&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.1091-13.2013&volume=33&pages=11239-11252&publication_year=2013&author=Deco%2CG)

[^146]: Honey, C. J. et al. Predicting human resting-state functional connectivity from structural connectivity. *Proc. Natl Acad. Sci. USA* **106**, 2035–2040 (2009).

[Article](https://doi.org/10.1073%2Fpnas.0811168106) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD1MXitVKktbY%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=19188601) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2634800) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Predicting%20human%20resting-state%20functional%20connectivity%20from%20structural%20connectivity&journal=Proc.%20Natl%20Acad.%20Sci.%20USA&doi=10.1073%2Fpnas.0811168106&volume=106&pages=2035-2040&publication_year=2009&author=Honey%2CCJ)

[^147]: Muldoon, S. F. et al. Stimulation-based control of dynamic brain networks. *PLoS Comput. Biol.* **12**, e1005076 (2016).

[Article](https://doi.org/10.1371%2Fjournal.pcbi.1005076) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=27611328) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5017638) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Stimulation-based%20control%20of%20dynamic%20brain%20networks&journal=PLoS%20Comput.%20Biol.&doi=10.1371%2Fjournal.pcbi.1005076&volume=12&publication_year=2016&author=Muldoon%2CSF)

[^148]: Gollo, L. L., Roberts, J. A. & Cocchi, L. Mapping how local perturbations influence systems-level brain dynamics. *NeuroImage* **160**, 97–112 (2017).

[Article](https://doi.org/10.1016%2Fj.neuroimage.2017.01.057) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=28126550) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Mapping%20how%20local%20perturbations%20influence%20systems-level%20brain%20dynamics&journal=NeuroImage&doi=10.1016%2Fj.neuroimage.2017.01.057&volume=160&pages=97-112&publication_year=2017&author=Gollo%2CLL&author=Roberts%2CJA&author=Cocchi%2CL)

[^149]: Stiso, J. et al. White matter network architecture guides direct electrical stimulation through optimal state transitions. *2018 Conference on Cognitive Computational Neuroscience*. [https://doi.org/10.32470/ccn.2018.1028-0](https://doi.org/10.32470/ccn.2018.1028-0) (2018).

[^150]: Aerts, H., Fias, W., Caeyenberghs, K. & Marinazzo, D. Brain networks under attack: robustness properties and the impact of lesions. *Brain* **139**, 3063–3083 (2016).

[Article](https://doi.org/10.1093%2Fbrain%2Faww194) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=27497487) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Brain%20networks%20under%20attack%3A%20robustness%20properties%20and%20the%20impact%20of%20lesions&journal=Brain&doi=10.1093%2Fbrain%2Faww194&volume=139&pages=3063-3083&publication_year=2016&author=Aerts%2CH&author=Fias%2CW&author=Caeyenberghs%2CK&author=Marinazzo%2CD)

[^151]: Srivastava, P. et al. Models of communication and control for brain networks: distinctions, convergence, and future outlook. *Netw. Neurosci.* **4**, 1122–1159 (2020). **A recent review highlighting opportunities for synergy between different computational avenues to model brain function, including network communication, dynamical systems and control theory.**

[Article](https://doi.org/10.1162%2Fnetn_a_00158) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=33195951) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC7655113) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Models%20of%20communication%20and%20control%20for%20brain%20networks%3A%20distinctions%2C%20convergence%2C%20and%20future%20outlook&journal=Netw.%20Neurosci.&doi=10.1162%2Fnetn_a_00158&volume=4&pages=1122-1159&publication_year=2020&author=Srivastava%2CP)

[^152]: Finger, H., Gast, R., Gerloff, C., Engel, A. K. & König, P. Probing neural networks for dynamic switches of communication pathways. *PLOS Comput. Biol.* **15**, e1007551 (2019).

[Article](https://doi.org/10.1371%2Fjournal.pcbi.1007551) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB3cXktFOisLs%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=31841504) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6936858) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Probing%20neural%20networks%20for%20dynamic%20switches%20of%20communication%20pathways&journal=PLOS%20Comput.%20Biol.&doi=10.1371%2Fjournal.pcbi.1007551&volume=15&publication_year=2019&author=Finger%2CH&author=Gast%2CR&author=Gerloff%2CC&author=Engel%2CAK&author=K%C3%B6nig%2CP)

[^153]: Pope, M., Seguin, C., Varley, T. F., Faskowitz, J. & Sporns, O. Co-evolving dynamics and topology in a coupled oscillator model of resting brain function. Preprint at *bioRxiv* [https://doi.org/10.1101/2023.01.31.526514](https://doi.org/10.1101/2023.01.31.526514) (2023).

[^154]: Osmanlıoğlu, Y. et al. System-level matching of structural and functional connectomes in the human brain. *Neuroimage* **199**, 93–104 (2019).

[Article](https://doi.org/10.1016%2Fj.neuroimage.2019.05.064) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=31141738) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=System-level%20matching%20of%20structural%20and%20functional%20connectomes%20in%20the%20human%20brain&journal=Neuroimage&doi=10.1016%2Fj.neuroimage.2019.05.064&volume=199&pages=93-104&publication_year=2019&author=Osmanl%C4%B1o%C4%9Flu%2CY)

[^155]: Seguin, C., Razi, A. & Zalesky, A. Inferring neural signalling directionality from undirected structural connectomes. *Nat. Commun.* **10**, 4289 (2019).

[Article](https://doi.org/10.1038%2Fs41467-019-12201-w) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=31537787) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6753104) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Inferring%20neural%20signalling%20directionality%20from%20undirected%20structural%20connectomes&journal=Nat.%20Commun.&doi=10.1038%2Fs41467-019-12201-w&volume=10&publication_year=2019&author=Seguin%2CC&author=Razi%2CA&author=Zalesky%2CA)

[^156]: Vázquez-Rodríguez, B. et al. Gradients of structure–function tethering across neocortex. *Proc. Natl Acad. Sci. USA* **116**, 21219–21227 (2019).

[Article](https://doi.org/10.1073%2Fpnas.1903403116) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=31570622) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6800358) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Gradients%20of%20structure%E2%80%93function%20tethering%20across%20neocortex&journal=Proc.%20Natl%20Acad.%20Sci.%20USA&doi=10.1073%2Fpnas.1903403116&volume=116&pages=21219-21227&publication_year=2019&author=V%C3%A1zquez-Rodr%C3%ADguez%2CB)

[^157]: Tewarie, P. et al. Predicting time‐resolved electrophysiological brain networks from structural eigenmodes. *Hum. Brain Mapp.* **43**, 4475–4491 (2022).

[Article](https://doi.org/10.1002%2Fhbm.25967) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=35642600) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC9435022) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Predicting%20time%E2%80%90resolved%20electrophysiological%20brain%20networks%20from%20structural%20eigenmodes&journal=Hum.%20Brain%20Mapp.&doi=10.1002%2Fhbm.25967&volume=43&pages=4475-4491&publication_year=2022&author=Tewarie%2CP)

[^158]: Nakuci, J., McGuire, M., Schweser, F., Poulsen, D. & Muldoon, S. F. Differential patterns of change in brain connectivity resulting from severe traumatic brain injury. *Brain Connect.* **12**, 799–811 (2022).

[Article](https://doi.org/10.1089%2Fbrain.2021.0168) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=35302399) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Differential%20patterns%20of%20change%20in%20brain%20connectivity%20resulting%20from%20severe%20traumatic%20brain%20injury&journal=Brain%20Connect.&doi=10.1089%2Fbrain.2021.0168&volume=12&pages=799-811&publication_year=2022&author=Nakuci%2CJ&author=McGuire%2CM&author=Schweser%2CF&author=Poulsen%2CD&author=Muldoon%2CSF)

[^159]: Li, Y. et al. Diffusion tensor imaging based network analysis detects alterations of neuroconnectivity in patients with clinically early relapsing-remitting multiple sclerosis. *Hum. Brain Mapp.* **34**, 3376–3391 (2013).

[Article](https://doi.org/10.1002%2Fhbm.22158) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=22987661) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Diffusion%20tensor%20imaging%20based%20network%20analysis%20detects%20alterations%20of%20neuroconnectivity%20in%20patients%20with%20clinically%20early%20relapsing-remitting%20multiple%20sclerosis&journal=Hum.%20Brain%20Mapp.&doi=10.1002%2Fhbm.22158&volume=34&pages=3376-3391&publication_year=2013&author=Li%2CY)

[^160]: Crofts, J. J. et al. Network analysis detects changes in the contralesional hemisphere following stroke. *NeuroImage* **54**, 161–169 (2011).

[Article](https://doi.org/10.1016%2Fj.neuroimage.2010.08.032) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DC%2BC3cbhtFaktA%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=20728543) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Network%20analysis%20detects%20changes%20in%20the%20contralesional%20hemisphere%20following%20stroke&journal=NeuroImage&doi=10.1016%2Fj.neuroimage.2010.08.032&volume=54&pages=161-169&publication_year=2011&author=Crofts%2CJJ)

[^161]: Andreotti, J. et al. Validation of network communicability metrics for the analysis of brain structural networks. *PLoS One* **9**, e115503 (2014).

[Article](https://doi.org/10.1371%2Fjournal.pone.0115503) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=25549088) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4280193) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Validation%20of%20network%20communicability%20metrics%20for%20the%20analysis%20of%20brain%20structural%20networks&journal=PLoS%20One&doi=10.1371%2Fjournal.pone.0115503&volume=9&publication_year=2014&author=Andreotti%2CJ)

[^162]: Latora, V. & Marchiori, M. Efficient behavior of small-world networks. *Phys. Rev. Lett.* **87**, 198701 (2001).

[Article](https://doi.org/10.1103%2FPhysRevLett.87.198701) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DC%2BD3MnktFWrtQ%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=11690461) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Efficient%20behavior%20of%20small-world%20networks&journal=Phys.%20Rev.%20Lett.&doi=10.1103%2FPhysRevLett.87.198701&volume=87&publication_year=2001&author=Latora%2CV&author=Marchiori%2CM)

[^163]: Muscoloni, A., Thomas, J. M., Ciucci, S., Bianconi, G. & Cannistraci, C. V. Machine learning meets complex networks via coalescent embedding in the hyperbolic space. *Nat. Commun.* **8**, 1615 (2017).

[Article](https://doi.org/10.1038%2Fs41467-017-01825-5) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=29151574) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5694768) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Machine%20learning%20meets%20complex%20networks%20via%20coalescent%20embedding%20in%20the%20hyperbolic%20space&journal=Nat.%20Commun.&doi=10.1038%2Fs41467-017-01825-5&volume=8&publication_year=2017&author=Muscoloni%2CA&author=Thomas%2CJM&author=Ciucci%2CS&author=Bianconi%2CG&author=Cannistraci%2CCV)

[^164]: Rosvall, M., Grönlund, A., Minnhagen, P. & Sneppen, K. Searchability of networks. *Phys. Rev. E Stat. Nonlin. Soft Matter Phys.* **72**, 046117 (2005). **This paper first proposed the concept of search information and applied it to complex networks.**

[Article](https://doi.org/10.1103%2FPhysRevE.72.046117) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DC%2BD28%2FgtVKktw%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=16383478) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Searchability%20of%20networks&journal=Phys.%20Rev.%20E%20Stat.%20Nonlin.%20Soft%20Matter%20Phys.&doi=10.1103%2FPhysRevE.72.046117&volume=72&publication_year=2005&author=Rosvall%2CM&author=Gr%C3%B6nlund%2CA&author=Minnhagen%2CP&author=Sneppen%2CK)

[^165]: Sneppen, K., Trusina, A. & Rosvall, M. Hide-and-seek on complex networks. *Europhys. Lett.* **69**, 853–859 (2005).

[Article](https://doi.org/10.1209%2Fepl%2Fi2004-10422-0) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD2MXis1WnsL0%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Hide-and-seek%20on%20complex%20networks&journal=Europhys.%20Lett.&doi=10.1209%2Fepl%2Fi2004-10422-0&volume=69&pages=853-859&publication_year=2005&author=Sneppen%2CK&author=Trusina%2CA&author=Rosvall%2CM)

[^166]: Kaiser, M., Görner, M. & Hilgetag, C. C. Criticality of spreading dynamics in hierarchical cluster networks without inhibition. *N. J. Phys.* **9**, 110 (2007).

[Article](https://doi.org/10.1088%2F1367-2630%2F9%2F5%2F110) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Criticality%20of%20spreading%20dynamics%20in%20hierarchical%20cluster%20networks%20without%20inhibition&journal=N.%20J.%20Phys.&doi=10.1088%2F1367-2630%2F9%2F5%2F110&volume=9&publication_year=2007&author=Kaiser%2CM&author=G%C3%B6rner%2CM&author=Hilgetag%2CCC)

[^167]: Pei, S. & Makse, H. A. Spreading dynamics in complex networks. *J. Stat. Mech. Theory Exp.* **2013**, P12002 (2013).

[Article](https://doi.org/10.1088%2F1742-5468%2F2013%2F12%2FP12002) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Spreading%20dynamics%20in%20complex%20networks&journal=J.%20Stat.%20Mech.%20Theory%20Exp.&doi=10.1088%2F1742-5468%2F2013%2F12%2FP12002&volume=2013&publication_year=2013&author=Pei%2CS&author=Makse%2CHA)

[^168]: Wook Yoo, S. et al. A network flow-based analysis of cognitive reserve in normal ageing and Alzheimer’s disease. *Sci. Rep.* **5**, 10057 (2015).

[Article](https://doi.org/10.1038%2Fsrep10057) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=25992968) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4438712) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20network%20flow-based%20analysis%20of%20cognitive%20reserve%20in%20normal%20ageing%20and%20Alzheimer%E2%80%99s%20disease&journal=Sci.%20Rep.&doi=10.1038%2Fsrep10057&volume=5&publication_year=2015&author=Wook%20Yoo%2CS)

[^169]: Kaiser, M., Martin, R., Andras, P. & Young, M. P. Simulation of robustness against lesions of cortical networks. *Eur. J. Neurosci.* **25**, 3185–3192 (2007).

[Article](https://doi.org/10.1111%2Fj.1460-9568.2007.05574.x) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=17561832) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Simulation%20of%20robustness%20against%20lesions%20of%20cortical%20networks&journal=Eur.%20J.%20Neurosci.&doi=10.1111%2Fj.1460-9568.2007.05574.x&volume=25&pages=3185-3192&publication_year=2007&author=Kaiser%2CM&author=Martin%2CR&author=Andras%2CP&author=Young%2CMP)