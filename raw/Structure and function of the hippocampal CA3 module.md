---
title: "Structure and function of the hippocampal CA3 module"
source: "https://www.pnas.org/doi/10.1073/pnas.2312281120"
author:
  - "[[Rosanna P. Sammons]]"
  - "[[Mourat Vezir]]"
  - "[[Laura Moreno-Velasquez]]"
  - "[[Gaspar Cano]]"
  - "[[Marta Orlando]]"
  - "[[Meike Sievers]]"
  - "[[Eleonora Grasso]]"
  - "[[Verjinia D. Metodieva]]"
  - "[[Richard Kempter]]"
  - "[[Helene Schmidt]]"
  - "[[Dietmar Schmitz]]"
published: 2023-07-18
created: 2026-06-19
description: "The hippocampal formation is crucial for learning and memory, with submodule CA3 thought to be the substrate of pattern completion. However, the underlying synaptic and computational mechanisms of ..."
tags:
  - "clippings"
---
## Significance

The hippocampus is essential for learning and memory. Over the last decades, predictions have been developed for how the CA3 module could execute such processes. However, at the synaptic level, evidence to support these theories is incomplete. A recent study appeared to question the long-held assumption that the CA3 was a highly recurrent network, reporting a pyramidal-to-pyramidal connectivity rate of less than 1%. Here, we provide functional and anatomical evidence demonstrating that these cells connect at a rate about ten times higher, thus, supporting the notion that this network is highly connected. Through modeling, we show that this level of connectivity is sufficient to support pattern completion, a conjunct of memory retrieval.

## Abstract

The hippocampal formation is crucial for learning and memory, with submodule CA3 thought to be the substrate of pattern completion. However, the underlying synaptic and computational mechanisms of this network are not well understood. Here, we perform circuit reconstruction of a CA3 module using three dimensional (3D) electron microscopy data and combine this with functional connectivity recordings and computational simulations to determine possible CA3 network mechanisms. Direct measurements of connectivity schemes with both physiological measurements and structural 3D EM revealed a high connectivity rate, multi-fold higher than previously assumed. Mathematical modelling indicated that such CA3 networks can robustly generate pattern completion and replay memory sequences. In conclusion, our data demonstrate that the connectivity scheme of the hippocampal submodule is well suited for efficient memory storage and retrieval.

Despite the well-known role of the hippocampus in learning and memory, the underlying mechanisms of how these functions are executed remain unclear. Theoretical work has long hypothesised that the pyramidal cells in the hippocampal CA3 region possess strong recurrent connectivity and, thus, could form an autoassociative network capable of pattern completion, and thereby, memory recall ([^1] – [^13]); see also ref. [^14]. Anatomical evidence for intrinsic CA3 connections has been described as far back as the seminal work from Ramón y Cajal ([^15]) and Lorente de Nó’s detailed depictions of the cerebral cortex ([^16]). Since these early descriptions, a number of studies have found strong recurrent connectivity in CA3 in both rats ([^17] – [^22]) and macaque ([^23]). Together, this large body of experimental and theoretical studies strongly suggest that the CA3 hippocampal region plays a key role in memory recall.

A recent functional study brought into question much of what had previously been assumed with regard to the CA3 network: Guzman et al. ([^24]) found a very low rate of connectivity among CA3 pyramidal neurons. These sparse connections were often embedded in richly interconnected subnetworks exhibiting an overrepresentation of disynaptic motifs. A computational model of a full-sized CA3 network showed that, despite this low connectivity, pattern completion could be achieved thanks to the underlying non-randomness and enrichment of disynaptic motifs. These findings highlight how, in order to understand the specific functions of a brain region, it is first essential to know how its individual components fit together. However, the reproducibility of findings is also key to prevent future hypotheses from being overly dependent on a single body of experimental evidence. Thus, we sought to readdress the question of how the CA3 pyramidal network is organized using a dual experimental technique approach.

Since the first full reconstruction of an entire nervous system in the *C. elegans* ([^25]), numerous technological advances have led to improved methods for studying the precise wiring of neuronal networks, allowing the investigation of larger connectomes ([^26]). For structural anatomy, electron microscopy (EM) remains the gold standard for observing synaptic contacts between neurons; meanwhile, paired patch-clamp recordings provide the functional counterpart for evidence of synaptic coupling. Here, we combine two state-of-the-art versions of these technologies—multi-beam scanning three dimensional (3D) EM and multipatch electrophysiology recordings—to perform a large-scale connectivity analysis of the CA3. We then apply our experimental findings to a computational model to determine how the network properties we describe may facilitate pattern completion and memory replay.

## Results

### 3D Electron Microscopy of CA3 Pyramidal Networks.

We investigated the structural connectivity within CA3 of a P31 male mouse. For this, we acquired a 3D-EM dataset using an automated tape-collecting ultramicrotome and multiple-beam scanning EM (ATUM-multiSEM) ([^27] – [^30]). The 3D-EM dataset was $965 \times 808 \times 62 \mu$ m $$ in size at a resolution of $4 \times 4 \times \left(\right. 35 - 40 \left.\right)$ nm $$, spanning all layers of CA3 (containing $n = 986$ neuronal cell bodies, [Fig. 1 *A*](#fig01)). We then identified seven pyramidal neurons with at least two axon collaterals and reconstructed their complete axonal arbours throughout the dataset ([Fig. 1 *B* and *C*](#fig01)). The average reconstructed axonal path length per neuron was 1.7 mm (12 mm total). Along these axons, we identified all outgoing synapses ($n = 1 , 062$) and followed their postsynaptic dendrites either to the soma ($n = 304$ whole cells, 362 synapses, example [Fig. 1 *C*](#fig01)) or until the border of the dataset ($n = 643$ dendrites, 700 synapses). In our dataset, we did not observe any autapses (cells synapsing onto themselves). However, in 10 % (96/947) of all connections, we observed two cells connected by multiple synapses. Next, we classified all postsynaptic neuronal cells based on their somato-dendritic morphology and spininess into excitatory ($n = 795$) and inhibitory ($n = 152$).

![](https://www.pnas.org/cms/10.1073/pnas.2312281120/asset/697260b9-8a58-4718-a26c-712138586199/assets/images/large/pnas.2312281120fig01.jpg)

Structural connectivity analysis of CA3 pyramidal neurons using electron microscopy. ( A ) 3D EM dataset of area CA3 from a P31 mouse acquired using ATUM-multiSEM (dataset available in online viewer webknossos ( 31 ): https://wklink.org/7823 ). ( B ) Dendritic reconstructions of 55 pyramidal cells out of 986 neurons (gray spheres). All excitatory postsynaptic targets of one axon shown (panel C, Left ) Reconstruction of five pyramidal cells (dendrites and complete axons with all 744 outgoing synapses; five of the seven reconstructed neurons are shown for better visibility) and all of their targeted postsynaptic excitatory neurons in the dataset (somata shown as spheres in blue hues); all neurons in the dataset (gray somata). ( Right ) Example excitatory synapse made from presynaptic axon (ax) onto a spine (sp) of a CA3 pyramidal neuron; the black arrow points to location of that synapse. ( D ) Analysis of connection probability based on inter-somatic distance. Histogram of the number of possible connections (Possible conn.) from seven presynaptic pyramidal cells to all neurons in the dataset (top, corrected for prevalence of inhibitory neurons; see Materials and Methods ) and the number of all identified postsynaptic targets (Found conn., Center ). Connection probability ( Bottom ) determined as the ratio of connections found (all postsynaptic excitatory neurons with soma in the dataset) and all possible targets (soma map), plotted versus distance. Note that the proximal EM-based connectivity is more than 10-fold above previous reports for pyramidal cells (purple dashed line) ( 24 ). Gray lines represent individual neurons; the black line shows average of all seven fully reconstructed neurons. Scale bars, 200 μ m ( and Left C ). 1 Right C ).

We then determined the number of synaptically connected postsynaptic CA3 pyramids with their soma in a certain distance range from the presynaptic soma and the total number of all CA3 pyramids in that same distance range. This yielded the CA3 pyramidal connection probability in dependence of inter-somatic distance ([Fig. 1 *D*](#fig01)). We found a local connectivity of 11.2 % $\pm$ 2.7 % within 50 $\mu$ m of the presynaptic soma that dropped within 250 $\mu$ m to 5.5 % $\pm$ 1.9 % (mean $\pm$ s.e.m.). To our surprise, this exceeds the previously reported connectivity by up to an order of magnitude ([^24]). While the reduction of connectivity with larger inter-somatic distance could be partly caused by truncated axons at the border of our thin (62 $\mu$ m) 3D EM dataset, the more than 10-fold higher proximal connectivity would likely further increase with additional axonal path length reconstructed. Thus, our structural data indicate that connectivity within the CA3 module is considerably higher than previously reported.

### Functional Connectivity of CA3 Pyramidal Networks.

In order to test the functional connectivity within CA3, we performed simultaneous whole-cell recordings of up to eight neurons ([Fig. 2 *A* and *B*](#fig02)). Such octuple recordings offer a combinatorial advantage over dual or quadruple recordings in that 56 connections can be tested at once, thereby facilitating connectivity studies in brain areas even where a low rate of connectivity is suspected ([^32]). Synaptic coupling was tested by driving presynaptic action potential firing with somatic current injections leading to excitatory postsynaptic potentials (EPSPs) in the case of coupling ([Fig. 2 *C* and *D*](#fig02)). This technique enabled us to analyse the connection probability and synaptic properties among pyramids within the CA3. Neurons were recorded at depths between 27 and 105 $\mu$ m from the surface of the slice (recording depth 61 $\pm$ 17 $\mu$ m, mean $\pm$ SD) and along the proximal–distal axis of the CA3.

![](https://www.pnas.org/cms/10.1073/pnas.2312281120/asset/c8511b9e-e86e-4f36-b307-c8b5a47c3ae4/assets/images/large/pnas.2312281120fig02.jpg)

Functional connectivity between CA3 pyramidal neurons. ( A ) summary of electrophysiology experiments and schematic demonstrating the combinatorial advantage of octuple recordings. ( Bi ) example recording showing firing patterns of 7 CA3 pyramids, ( Bii ) morphological reconstruction of cells shown in. ( C, Left ) histogram of EPSP amplitudes; inset, histogram of log EPSP amplitudes and gaussian fit; and Right, boxplot of EPSP latencies. ( Di ) representative example of a connectivity screen between 6 highly interconnected CA3 pyramidal neurons. ( Dii ) schematic depicting location and connections between the recorded neurons.

First, we studied the basal connectivity scheme: We identified 103 connections out of a possible 1,172 tested connections between CA3 pyramidal neurons. This high connectivity rate of 8.8% is in line with our EM data, thus, providing functional evidence to support our structural findings of a highly interconnected network. The median EPSP had an amplitude of 0.66 mV \[0.33 to 1.08\] and an onset latency of 1.2 ms \[0.8 to 1.7\] [Fig. 2 *C*](#fig02), median \[IQR\], which strongly suggests mono-synaptic connections ([^24], [^33], [^34]). As seen in other brain regions ([^35] – [^38]), the amplitude of EPSPs followed a log-normal distribution with many small-amplitude connections and a small number of very large-amplitude connections. Furthermore, we assessed the distance dependence of connectivity. In our electrophysiological data, we did not find any distance dependence of connectivity within the range tested ([*SI Appendix*, Fig. S1](https://www.pnas.org/doi/10.1073/pnas.2312281120#supplementary-materials); 0 to 430 $\mu$ m; $P = 0.147$, Cochran-Armitage Trend Test).

Next, we investigated whether specific motifs occur within connected cells or whether connectivity was randomly distributed throughout the network. First, we looked at pairs of neurons ([Fig. 3 *A*](#fig03) *i*); we found that 6 pairs (out of 586 tested pairs) showed reciprocal connections ([Fig. 3 *A*](#fig03) *ii*); this number is not significantly higher ($P = 0.301$) than the expected number of 4.5 pairs given a connectivity rate of 8.8%. We then looked at disynaptic motifs within triads of neurons ([Fig. 3 *B*](#fig03) *i*). In our recordings, we tested 464 neuron triplets. Within these data, we found instances of divergent, convergent, and chain motifs ([Fig. 3 *B*](#fig03) *ii*). However, we did not find that these motifs occurred more frequently than chance, given our basal connectivity rate of 8.8%.

![](https://www.pnas.org/cms/10.1073/pnas.2312281120/asset/286fa9c0-400c-42c3-a4ca-a4ba79a80da3/assets/images/large/pnas.2312281120fig03.jpg)

Connectivity motifs within the CA3 pyramidal network. ( Ai ) observed (Obs) and simulated (Sim) numbers of possible motifs between two pyramidal neurons. The height and error of the simulated bars indicate the mean and SD of the outcome of 10,000 simulations, where neurons randomly connect with a probability of 8.8 %. In each simulation (as in experiments), 586 neuron pairs were sampled. P -values indicate the probability that values as high as those observed would occur in randomly distributed networks. ( Aii, Left ) biocytin labelling of two reciprocally connected pyramidal neurons in CA3, and Right, voltage traces (black and gray colors encode neurons 1 and 2) showing reciprocal connection. ( Bi ) observed and simulated numbers of disynaptic motifs. Simulations as in, with 464 triplets being tested. ( Bii ) biocytin labelling of three neurons connected via a chain motif and,, voltage traces (black, blue, and gray colors for cells 1, 2, and 3, respectively) demonstrating a chain motif; cell 1 is presynaptically connected to cell 2, which is in turn the presynaptic partner of cell 3.

Thus, both our structural and functional data point toward a high rate of interconnectivity within the CA3 pyramidal network. We next looked at how this high connectivity may contribute to the functional role of the CA3.

### Computational Modelling of the CA3 Network.

How do pattern completion and memory replay depend on the recurrent excitatory connectivity within a neuronal module? Previous theoretical work has shown how a network with sufficiently strong recurrent connectivity could allow for pattern completion ([^1] – [^14]). In ref. [^24], a low connection probability among CA3 pyramidal cells was found, and using binary-neuron networks and binary synaptic weights, it was argued that a higher-than-random distribution of disynaptic motifs could be essential for pattern completion. To readdress this question in light of our experimental findings, we performed computational modelling in networks of spiking neurons and realistic distributions of synaptic conductances to study how pattern completion and the successful replay of a stored sequence depend on connectivity and other network parameters.

We simulated spiking networks of $N$ excitatory and $N / 4$ inhibitory integrate-and-fire units. Excitatory cells formed random recurrent connections with probability $c$, and the corresponding synaptic weights were drawn from a log-normal distribution. Within such a network, subgroups of $M$ excitatory neurons ($M \ll N$) were defined as patterns (or assemblies) by increasing the weights of synapses between the neurons within each pattern. Furthermore, a sequence of patterns was embedded in the network by increasing weights between neurons across patterns ([Fig. 4 *A*](#fig04); see *Materials and Methods* for details). This configuration matches the random connectivity distribution found in our experiments, as all neurons in our excitatory network recurrently connect with the same probability $c$, and only a very small fraction of weights are strengthened to embed the sequence. Inhibitory weights were set to balance excitation such that the network exhibits an asynchronous-irregular activity state ([^13], [^39]).

![](https://www.pnas.org/cms/10.1073/pnas.2312281120/asset/0fb8f121-e427-400c-a671-8d8f5d801de4/assets/images/large/pnas.2312281120fig04.jpg)

Connectivity and pattern size determine conditions for successful replay. ( A ) Network model of N / 4 inhibitory cells (“I,” Left ) and excitatory cells (“E,” Right ) with connectivity c and a log-normal distribution of weights ( Bottom ). Spike-timing-dependent plasticity (STDP) in the “I”-to-“E” connections balances the network. Ten patterns of size M are embedded and sequentially connected with enlarged weights as compared to background weights (for simplicity, only four patterns sketched); for details, see Materials and Methods. ( B, Top ) raster plots (red: E cells in patterns, gray: E cells not in patterns, blue: I cells) and,, population rate of the embedded sequence. Horizontal gray lines separate patterns (in sequence order from to ). The first pattern in the sequence is depolarized by a brief current injection (yellow shade and arrow) to a fraction of its cells, eliciting propagation of activity across the sequence. ( ) Activity dies out; replay is unsuccessful. ( ) The sequence is successfully replayed. ( C ) percentage of successful replays (color coded) for two different network sizes, as a function of connectivity and pattern size. For a given, replay requires a minimum, and vice versa. This relation is well fitted by the white dashed line, which indicates · = const. Numbered magenta squares correspond to the examples in D ) percentage of successful replays for connectivity 8 % and sequence weight 50 pS, as a function of pattern size and network size. For larger networks, replay requires slightly higher connectivity. ( E % and network size 50,000. Larger synaptic weights allow for lower pattern size.

To test whether an embedded sequence can be replayed, we perform a brief current injection to half of the neurons of the first pattern. If the resulting activity pulse propagates through the whole sequence without significant attenuation or spread to other neurons, we consider that our “memory” was replayed and pattern completion was successful ([Fig. 4 *B*](#fig04), *Right*). Otherwise, the replay is considered to have failed ([Fig. 4 *B*](#fig04), *Left*).

In numerical simulations, we find that successful replay requires a certain minimum connectivity, $c$, and that this minimum depends primarily on the pattern size $M$, indicating that the parameters $c$ and $M$ are most important ([Fig. 4 *C*](#fig04)). The dependence of replay on network size $N$ is weaker, and larger networks require either a slightly higher connectivity or a slightly larger pattern size ([Fig. 4 *C* and *D*](#fig04)). Finally, larger sequence weights enable a lower pattern size ([Fig. 4 *E*](#fig04)). Thus, our simulations on memory replay predict (for a given connectivity) lower bounds for the sequence synaptic weight and the pattern size $M$. For the experimentally observed high connection probabilities within the CA3 pyramidal network, pattern completion can occur for a wide range of parameters without the need for a non-random distribution of disynaptic motifs.

## Discussion

Resolving local connectivity schemes is essential for addressing the underlying mechanisms of neuronal network processes. However, the gold-standard techniques for studying local connectivity structurally and functionally come with the caveat of slicing artifacts, rendering results likely an underestimation of neuronal connectivity ([^40] – [^42]). Despite this underestimation, we find remarkable corroboration between our structural and functional datasets, observing high rates of connectivity in both our 3D EM and electrophysiology data. These results are in line with the abundance of literature describing the CA3 as a highly recurrent network ([^1], [^8], [^10], [^12], [^43]).

Our results present a stark contrast to those of Guzman et al. ([^24]) who saw a 0.9% connectivity rate between CA3 pyramidal neurons of rats. We believe that this discrepancy is caused by a combination of factors. First, our study is performed in mice rather than rats. Connectivity may be influenced by species. In particular, the gross architecture of the CA3 is different across species, with species such as rabbits displaying a distinct reflected blade within the curve of the dentate gyrus ([^44]). In this respect, mice and rats are similar, both lacking this feature. However, a number of comparative studies and meta-analyses have shown that, in the hippocampus, structural volume, cell number, and cell densities vary considerably not just across species but even across strains within a species ([^43], [^45] – [^47]). Slicing will impact the number of surviving synaptic contacts differently in networks with varying cell densities, which in turn, will impact the measurable connectivity remaining in the slice. A second critical difference between the two studies is the slice storage method. Here, we store slices in an interface chamber which has previously been shown to preserve more network activity than classical beaker storage ([^48]). In contrast, Guzman et al. ([^24]) use classical beaker storage. We, therefore, believe that a combination of the above factors may contribute to the large difference in connectivity rates seen between our study and that of Guzman et al.

We consider our results to provide a more realistic representation of excitatory recurrent connectivity in the CA3 network in behaving animals than previous experimental work: While the preparation of acute slices may induce some processes that alter synaptic connectivity, samples prepared for EM are fixed during perfusion. This immediate fixation preserves the structure as it was in its last in vivo state, and therefore, gives a representation of the network with as close-to-real likeness as possible. Although our EM data come from a single mouse, the results of our multi-beam 3D scanning EM and multi-patch whole cell recordings demonstrate remarkable harmony with one another, thus boosting their validity and serving as a control for each other. In this study, the functional data (from 52 mice) were first collected. Following this, the structural data were collected in a second laboratory, independently from the functional data. The corroboration of high connectivity, therefore, strengthens the results coming from our two-stranded approach. This study further represents the first time such a large-scale high-resolution 3D reconstruction has been performed on the CA3 region of the hippocampus. Our EM and electrophysiological data do show one contrasting result: Our structural data show a distance dependence of connectivity while this relationship is not seen in our functional data. We attribute this disparity to the difference in slice thicknesses used across the two techniques. EM data were acquired from a 62 $\mu$ m sample, over 4 times thinner than slices used for functional recordings. Therefore, it is likely that axons are less preserved across the entire area of the sample in the thinner slices, leading to this apparent connectivity distance dependence. Despite the thin slice section, it is remarkable that such a high level of connectivity was still found. Meanwhile, the lack of distance-dependent functional connectivity we find is consistent with the result of Guzman et al. ([^24]) despite the several-fold higher connectivity that we observe. These data indicate that, within the cross-sectional axis of the CA3, connectivity may be spatially uniform.

By performing computational modeling, we further demonstrate how our experimental findings can underlie the processes of pattern completion and memory retrieval, functions often attributed to the CA3 region. Through this modeling, we are able to confirm that given the basal rate of connectivity between CA3 pyramids seen in our experimental data, pattern completion can be successfully achieved without the need for connectivity to be embedded in rich disynaptic motifs.

In summary, we present a multi-technique portrait of the local excitatory microcircuit within the CA3 region of the hippocampus and embed our experimental findings in a computational model to demonstrate how this network may execute memory functions. We find a high level of connectivity between pyramidal neurons in the CA3, supporting much of the previous literature to suggest that this brain region represents an auto-associative network.

## Materials and Methods

### Electrophysiology.

#### Ethics approval statement.

Animal maintenance and experiments were in accordance with the respective guidelines of local authorities (Berlin state government, T0073/04) and followed the German animal welfare act and the European Council Directive 2010/63/EU on protection of animals used for experimental and other scientific purposes.

#### Slice preparation.

Mice (P25+, average age: P35, both sexes) were decapitated following isoflurane anesthesia. Brains were removed and transferred to ice-cold, sucrose-based artificial cerebrospinal fluid (sACSF) containing (in mM) 50 NaCl, 150 sucrose, 25 NaHCO $$, 2.5 KCl, 1 NaH $$ PO $$, 0.5 CaCl $$, 7.0 MgCl $$, 10 glucose, saturated with 95% O $$, 5% CO $$, pH 7.4. Slices (400 $\mu$ m) were cut in a horizontal plane on a vibratome (VT1200S; Leica) and stored in an interface chamber at 32 to 34 $$ C ([*SI Appendix*, Fig. S2](https://www.pnas.org/doi/10.1073/pnas.2312281120#supplementary-materials)). These storage conditions were chosen since they have been previously shown to preserve network integrity ([^48], [^49]). Slices were perfused at a rate of $sim$ 1 ml/min with artificial cerebrospinal fluid (ACSF) containing (in mM) 119 NaCl, 26 NaHCO $$, 10 glucose, 2.5 KCl, 2.5 CaCl $$, 1.3 MgCl $$, 1 NaH $$ PO $$, and continuously oxygenated with carbogen. Slices were allowed to recover for at least 1 h after preparation before they were transferred into the recording chamber.

#### Connectivity.

Recordings were performed in ACSF at 32 to 34 $$ C in a submerged-type recording chamber. Cells in the CA3 were identified using infrared differential contrast microscopy (BX51WI, Olympus). We performed somatic whole-cell patch-clamp recordings (pipette resistance 2.5 to 4 M $\Omega$) of up to eight cells simultaneously. One cell was stimulated with a train of four action potentials at 20 Hz, elicited by 1 to 2 ms long current injections of 2 to 4 nA. For characterization, increasing steps of current were injected (1 s, increment: 50 pA). In few experiments, hyperpolarizing or depolarizing holding current was applied to keep the membrane potential at $- 60$ mV. The intracellular solution contained (in mM) 135 potassium-gluconate, 6.0 KCl, 2.0 MgCl $$, 0.2 EGTA, 5.0 Na $$ -phosphocreatine, 2.0 Na $$ -ATP, 0.5 Na $$ -GTP, 10 HEPES buffer, and 0.2% biocytin. The pH was adjusted to 7.2 with KOH. Recordings were performed using Multiclamp 700A/B amplifiers (Molecular Devices). Signals were filtered at 6 kHz, sampled at 20 kHz and digitized at 16 bit resolution using the Digidata 1550 and pClamp 10 (Molecular Devices).

#### Data analysis—connectivity.

Cells with a membrane potential less negative than $- 50$ mV and a series resistance higher than 30 M $\Omega$ were discarded. The connectivity screen underwent a quality control step such that only sweeps where presynaptic action potentials reversed above $0$ mV and the membrane potential did not deviate by more then 10% within a sweep or with reference to the first sweep, were kept. Synaptic connections were identified when there was a postsynaptic potential corresponding to the presynaptic stimulation in the averaged trace from 40 to 50 sweeps. A baseline period (2 ms) just prior to the stimulation and the averaged postsynaptic peak during the first action potential was used for the analysis of the EPSP amplitudes and synaptic delays. Only those pairs in which the first postsynaptic peak was clearly discernible were used for analysis. To determine if connectivity was randomly distributed, we analysed the statistical distribution of disynaptic motifs in our recorded data set, which consisted of 586 tested pairs and 464 tested triplets. Given the experimentally determined value of 8.8% for network connectivity, we analytically estimated the random probability that each of the motifs would occur in a sampled neuron pair or triplet. We then performed 10,000 simulations, each of them counting how many motifs occurred in the number of tested pairs and triplets, given random connectivity. $P$ values correspond to the fraction of simulations where the number of counted motifs was at least as high as in the experimental data.

#### Data analysis—immunohistochemistry and neuroanatomy of principal cells.

After recording, slices were transferred into a fixative solution containing 4% paraformaldehyde in 0.1 M phosphate buffer. Biocytin labelling was revealed by incubating slices in streptavidin conjugated to Alexa 488 (diluted 1:500) overnight in a solution of PBS containing 2.5% normal goat serum and 1% Triton. The slices were then mounted in Fluoroshield (Sigma-Aldrich). Image stacks of specimens were imaged on an Olympus BX61 FV1000 confocal microscope (Leica Microsystems). Images were taken using a 30X objective with a pixel size of 0.414 $\mu$ m and a z-step size of 0.69 $\mu$ m. Reconstructions were performed in Neutube ([^50]). The distance between recorded cells was calculated post-hoc as the Euclidean distance between cell soma, measured in images of the biocytin labelling.

### Electron Microscopy.

#### Animal experiments.

All experimental procedures were performed in accordance with the law of animal experimentation issued by the German Federal Government under the supervision of local ethics committees, approved by the Regierungspräsidium Darmstadt, AZ: F126/1028, in compliance with the guidelines of the Max Planck Society.

#### Tissue extraction and staining.

The EM dataset was collected from a single male mouse (C57BL/6J), which was born in-house and kept with littermates (6 males and 5 females in total) until weaning at P20. After weaning, the mouse was kept in a cage with 2 to 5 of its male siblings, until it was perfused. The mice had a red nesting box and nesting material in their cage. The room temperature was 22 $$ C; relative humidity was set to 55% ($\pm$ 10%) and lights were set to a 12-h light–dark cycle. Food and water were provided ad libitum (autoclaved water and Sniff standard mouse breeding or husbandry pellets). The male wild-type mouse used for experiments was perfused at P31. The mouse was injected with general analgesia, anesthetized, and transcardially perfused as described by Karimi et al. ([^51]). The animal was decapitated, and the head was kept overnight in EM fixative composed of 2.5% paraformaldehyde (Sigma), 1.25% glutaraldehyde (Serva), and 2 mM calcium chloride (Sigma) in 80 mM cacodylate buffer adjusted to pH 7.4 with an osmolarity ranging from 700 to 800 mOsmol/kg at 4 $$ C, ([^52]). Next, submerged in cold EM fixative, the right hemisphere was cut into 500- $\mu$ m thick horizontal slices with a vibratome (VT1200S Vibratome, Leica, Germany). Then, samples from the intermediate hippocampus spanning the whole CA3 region (i.e., all CA3 subregions, a, b, and c) were extracted using a 3.5-mm diameter biopsy punch and prepared for electron microscopy using the en-bloc staining method described previously ([^51]). After dehydration, an Epon-based infiltration and embedding procedure was applied as in Loomba et al. ([^27]). In brief, the sample was infiltrated with a 3:1, 1:1, and 1:3 mixture of acetone and resin (Epon hard mixture: 5.9 g Epoxy, 2.25 g DDSA, 3.7 g NMA, 205 $\mu$ l DMP; Sigma-Aldrich, USA) for 4 h, $sim$ 12 h, and 4 h, respectively. The sample was then immersed in pure resin for 24 h, switching to fresh resin three times (after 4 h, $sim$ 12 h at 4 $$ C, and another 4 to 5 h at room temperature). Finally, the sample was embedded in freshly prepared pure resin onto an aluminum pin, and the Epoxy resin was polymerized in a pre-heated oven at 60 $$ C for 2 to 3 d (UN30pa paraffin oven, Memmert, Germany).

#### ATUM-MultiSEM experiment.

The cured sample was trimmed into an elongated hexagon shape (size 3.4-mm by 1.6-mm, Leica EM TRIM2, Leica Microsystems, Wetzlar, Germany). Using a custom ATUM setup, 1702 ultrathin sections were collected onto plasma-treated, carbon-coated Kapton tape (DuPont, coating by Fraunhofer FEP, Dresden, Germany). Cutting was performed with a diamond knife (4-mm ultra 35 $$, DiATOME, Nidau, Switzerland) at a nominal thickness of 35 to 40 nm (corresponding to an extent of 62 $\mu$ m) and a cutting speed of 0.3 mm/s. After section collection, the ATUM tape was mounted onto silicon wafers (p-doped, one side polished; Science Services, Germany) with double-sided adhesive carbon tape (P77819-25, Science Services, Germany). For targeted MultiSEM imaging, light microscopy–based overview images were acquired (Axio Imager.A2 Vario, Carl Zeiss Microscopy GmbH, Oberkochen). Per section, a rectangular field-of-view of size 965 $\mu$ m $\times$ 808 $\mu$ m was imaged in a 61-beam MultiSEM (MultiSEM, 505, Carl Zeiss Microscopy GmbH, Oberkochen) at a pixel size of 4 nm, a dwell time per pixel of 50 ns, and a landing energy of 1.5 kV. Alignment of MultiSEM images into a 3D volume was performed using routines described in Scheffer et al. ([^53]) and [https://github.com/billkarsh/Alignment\_Projects](http://https/://github.com/billkarsh/Alignment_Projects), with custom modifications and MATLAB (Mathworks, USA) based supplements to apply image transformations and splitting the data into cubes sizes 1,024 $\times$ 1,024 $\times$ 1,024 voxel each ([https://github.com/scalableminds/webknossos-wrap](http://https/://github.com/scalableminds/webknossos-wrap)). Five sections were left out due to focus instabilities. These data were then uploaded to the online annotation software webKnossos ([^31]) for in-browser distributed data visualization, neurite skeletonization, and synapse identification. The final sample came from an intermediate section of the hippocampus, and the analyzed region contained CA3a and CA3b subregions.

#### Axon reconstructions and annotation of synapses.

Analyses reported in [Fig. 1](#fig01), were conducted as follows. The axon initial segment of seven pyramidal cells, positioned in CA3a and b, were identified. Then, the trajectories of the axons were followed throughout the whole dataset, and comments were added at outgoing synapses. Synapse identification was performed as described by Loomba et al. ([^27]): First, vesicle clouds in the axon were identified as accumulations of vesicles. Subsequently, the most likely postsynaptic target was identified by the following criteria: direct apposition with vesicle cloud; presence of a darkening and slight broadening of the synaptic membrane; vesicles at close proximity to the plasma membrane at the site of potential synaptic contact. Synapses were marked as uncertain whenever the signs of darkened postsynaptic density could not be clearly identified. All analyses in this study were conducted only on synapses that had been classified as certain. All synapses were annotated by an expert annotator; for unclear cases, these were re-annotated for expert consensus between two or three experts. Presynaptic cells were confirmed as excitatory based on two criteria: 1) Complete dendritic trees were reconstructed to ensure pyramidal morphology, including the identification of a prominent apical dendrite; 2) randomly chosen dendritic segments were exemplarily checked for high density of spines (similar to ref. [^54]).

The post-target of each synapse ($n = 1 , 062$) was reconstructed by an expert annotator by following their trajectory either to the soma ($n = 304$) or the border of the dataset ($n = 643$) as described previously ([^54]). Identified postsynaptic targets were classified as excitatory ($n = 795$) or inhibitory ($n = 152$) based on their somato-dendritic morphology and spininess.

Inter-somatic distance was calculated as the Euclidean distance between two somata. The rate of non-pyramidal neurons was determined by classifying all somata in a bounding box of 50- $\mu$ m width ($n = 52$ somata, spanning all layers of CA3 and the full dimension in z) into pyramidal ($n = 47$) and other ($n = 5$). For connectivity rate computation, the number of all possible connections was corrected for the presence of non-pyramidal neurons.

#### Soma map.

To identify all cell bodies of the CA3 region of the dataset ($n = 986$), one node was placed in each soma using webKnossos by two experts until consensus was reached.

### Computational Modelling.

#### Basic setup.

Using spiking network models, we simulate the activity of a hippocampal module and its ability to replay a stored sequence of patterns. In networks of leaky integrate-and-fire (LIF) neurons that contain both excitatory and inhibitory cells, we embed excitatory assemblies (or patterns)—subgroups of cells whose recurrent connections are distinctly stronger than the average. We also strengthen the feed-forward connections across the embedded assemblies such that they form a sequence. This setup allows us to study the conditions under which that sequence can be replayed. Below, we provide a detailed description on how this structure is created and the tests we have performed on it.

Network simulations and analyses of the spiking network data were performed in Python ([www.python.org](http://http/://www.python.org)), with the neural network being implemented with the package Brian ([^55]).

#### Neuron and synapse model.

To keep our model of the network as simple as possible, neurons are described as conductance-based LIF units. Excitatory (but not inhibitory) neurons receive an additional output-driven adaptation current, to prevent them from excessive bursting when input is too high. The subthreshold membrane potential $V_{j} \left(\right. t \left.\right)$ of excitatory cell $j$ obeys 
$$
C \frac{\text{d} V_{j}}{\text{d} t} = g^{\text{leak}} \left(\right. V^{\text{rest}} - V_{j} \left.\right) + g_{j}^{E} \left(\right. t \left.\right) \left(\right. V^{E} - V_{j} \left.\right) \\ + g_{j}^{I} \left(\right. t \left.\right) \left(\right. V^{I} - V_{j} \left.\right) + I^{\text{BG}} + I_{j} - w_{j} , \\ \tau_{w} \frac{\text{d} w_{j}}{\text{d} t} = - w_{j} ,
$$

\[1\]

where $C$ is the membrane capacitance, $g^{\text{leak}}$ is the leak conductance, $V^{\text{rest}}$ is the resting membrane potential, $V^{E}$ and $V^{I}$ are the reversal potentials of excitation and inhibition, respectively, $I^{\text{BG}}$ and $I_{j}$ are external currents, and $\tau_{w}$ is the time constant of the adaptation current $w_{j}$. Inhibitory cells’ subthreshold membrane potential is described solely by the first equation in Eq. [**1**](#eqn1), but without the adaptation current $w_{j}$. To elicit activity in the network, a constant background current $I^{\text{BG}}$ is injected to all neurons. To test for replay, some excitatory neurons receive additional brief current pulses $I_{j}$. Every time a neuron’s membrane potential reaches the threshold $V^{\text{thr}}$, a spike is emitted and $V_{j}$ is reset to the reset potential (for simplicity, it equals $V^{\text{rest}}$), where it is clamped for a refractory period $\tau_{\text{refr}}$. When an excitatory cell spikes, its adaptation current $w_{j}$ is increased by a constant amount $b$. See [Table 1](#t01) for numerical values of parameters.

Standard parameters for the spiking network

| Parameter | Value | Unit | Definition |
| --- | --- | --- | --- |
| $C$ | 200 | pF | Membrane capacitance |
| $g^{\text{leak}}$ | 10 | nS | Leak conductance |
| $V^{\text{rest}}$ | $- 60$ | mV | Resting potential |
| $V^{\text{thr}}$ | $- 50$ | mV | Voltage threshold |
| $\tau_{\text{refr}}$ | 1 | ms | Refractory period |
| $V^{E}$ | 0 | mV | Excitatory reversal potential |
| $V^{I}$ | $- 80$ | mV | Inhibitory reversal potential |
| $I^{\text{BG}}$ | 200 | pA | Constant background current |
| $\tau^{E}$ | 2 | ms | Excitatory synaptic time constant |
| $\tau^{I}$ | 4 | ms | Inhibitory synaptic time constant |
| $\tau_{l}$ | 1 | ms | Synaptic latency |
| $\tau_{w}$ | 20 | ms | Adaptation time constant |
| $b$ | 100 | pA | Adaptation strength |
| $g_{\text{seq}}^{\mathit{EE}}$ | 50 | pS | Sequence synaptic weight |
| $g^{\mathit{IE}}$ | 50 | pS | $E$ -to- $I$ synaptic weight |
| $g^{\mathit{II}}$ | 200 | pS | $I$ -to- $I$ synaptic weight |
| $g_{0}^{\mathit{EI}}$ | 200 | pS | $I$ -to- $E$ initial synaptic weight |
| $c^{\mathit{IE}}$ | 0.01 |  | $E$ -to- $I$ connection probability |
| $c^{\mathit{II}}$ | 0.04 |  | $I$ -to- $I$ connection probability |
| $c^{\mathit{EI}}$ | 0.04 |  | $I$ -to- $E$ connection probability |
| $\eta$ | 0.01 |  | STDP learning rate |
| τSTDP | 20 | ms | STDP time constant |
| $\rho_{0}$ | 5 | spikes/s | STDP target firing rate |

Values are the same in all simulations, except for synaptic weights $g^{\mathit{JK}}$, which are all scaled in the same proportion for [Fig. 4 *E*](#fig04). The standard value for $g_{\text{seq}}^{\mathit{EE}}$ is chosen so as to allow for replay in a wide range of parameters and network sizes—larger synaptic weights make the network harder to balance ([Fig. 4 *E*](#fig04), *Upper Right*). Connectivities and weights of the synapses to- and from- inhibitory cells are chosen purely for computational efficiency. Thus, values for $c^{\mathit{JK}}$ are chosen to be as low as possible, while still allowing for network balancing, with $g^{\mathit{JK}}$ then adjusted to make the balancing as easy as possible.

The time-dependent variables $g_{j}^{E} \left(\right. t \left.\right)$ and $g_{j}^{I} \left(\right. t \left.\right)$ describe the total synaptic conductances resulting from incoming inputs to neuron $j$. The conductance dynamics are described by 
$$
\begin{matrix}\frac{d g_{j}^{E}}{d t} & = - \frac{g_{j}^{E}}{\tau^{E}} + \underset{k , f}{\sum} g_{\mathit{jk}}^{\mathit{JE}} \delta \left(\right. t - t_{k}^{\left(\right. f \left.\right)} - \tau_{l} \left.\right) , \\ \frac{d g_{j}^{I}}{d t} & = - \frac{g_{j}^{I}}{\tau^{I}} + \underset{k , f}{\sum} g_{\mathit{jk}}^{\mathit{JI}} \delta \left(\right. t - t_{k}^{\left(\right. f \left.\right)} - \tau_{l} \left.\right) , J \in \left{\right. E , I \left.\right} ,\end{matrix}
$$

\[2\]

where $\delta \left(\right. t - t_{k}^{\left(\right. f \left.\right)} - \tau_{l} \left.\right)$ is the contribution of the $f$ -th incoming spike from neuron $k$ at time $t_{k}^{\left(\right. f \left.\right)}$, with $\delta$ being the Dirac delta function and $\tau_{l}$ the latency between a presynaptic spike and the postsynaptic response onset. The quantities $g_{\mathit{jk}}^{\mathit{JK}}$ denote the unitary conductance increase resulting from a single spike in presynaptic neuron $k$ of population $K$ connected to postsynaptic neuron $j$ of population $J$, where $J , K \in \left{\right. E , I \left.\right}$, with $E$ corresponding to the excitatory synapses and $I$ to the inhibitory ones. The conductances decay exponentially with time constants $\tau^{E}$ and $\tau^{I}$.

#### Network and connectivity models.

A network model contains $N$ excitatory cells and $N / 4$ inhibitory cells, each cell a LIF unit, as described above. The network size $N$ is varied to span from in vitro-like ($sim 10^{3}$ to $10^{4}$) to in vivo-like CA3 networks ($sim 10^{6}$). We connect all $N$ excitatory cells with connection probability $c$, creating roughly $c \cdot N^{2}$ excitatory synapses. The $N / 4$ inhibitory cells have recurrent connections with probability $c_{\mathit{II}}$. The excitatory-to-inhibitory connections occur with probability $c_{\mathit{IE}}$, and inhibitory-to-excitatory connections with probability $c_{\mathit{EI}}$.

Synaptic weights in biological neuronal networks follow a log-normal distribution ([^35], [^56]), which has also been observed in recurrent connections among CA3 pyramidal cells in ref. [^57] and in our data. In such a distribution, the vast majority of synaptic weights are very small and potentially negligible, while a minority is much larger and mostly responsible for governing network dynamics. Thus, the values of the unitary conductance increase $g_{\mathit{jk}}^{\mathit{EE}}$ in our computational network model (each corresponding to the strength of the excitatory-to-excitatory $k$ -to- $j$ synapse) are drawn from a log-normal distribution.

To embed in such a homogeneous network assemblies and sequences, the weights of a small fraction (typically $< 1$ %, see below for details) of excitatory synapses are increased. We chose to set these weights to a value corresponding to the 99-th percentile of the log-normal distribution. In that way, the distribution is only marginally changed. A high enough signal-to-noise ratio of the embedded assemblies and sequences requires that the corresponding weights are much larger than the median weight, and thus we assumed that the median is 50 times smaller than the 99-th percentile. These conditions lead to a log-normal distribution whose SD equals 4 times the mean. In experiments, synapses with weights below the noise level cannot be identified. Thus, the reported coefficient of variation (CV) of weights is lower, CV $\approx 1$ in [Fig. 2 *C*](#fig02) and in Ikegaya et al. ([^57]).

To test pattern completion in our model, we embed 10 non-overlapping assemblies in the excitatory population ([^13]). Each assembly is created by picking $M$ excitatory cells and setting the weights of their recurrent synapses to $g_{\text{seq}}^{\mathit{EE}}$, which is larger (99-th percentile) than most synaptic weights in the distribution. Weights of the feed-forward connections across assemblies are set to the same value $g_{\text{seq}}^{\mathit{EE}}$ such that the $M$ neurons of the $i \text{th}$ assembly are strongly connected to the $M$ neurons of the $\left(\right. i + 1 \left.\right) \text{th}$ assembly, thus generating a unidirectional sequence. The total expected number of connections that shape the sequence \[$c \cdot M^{2} \times \left(\right. 10 + 9 \left.\right)$\] is small compared to the total average number of excitatory synapses in the network \[$c \cdot N^{2}$\] if the number of assemblies is small compared to $\left(\left(\right. N / M \left.\right)\right)^{2}$, which is fulfilled in all our simulations. For network size $N > 10^{6}$ in CA3 in vivo and putative assembly sizes in the order of $M = 10^{3}$, thousands of sequences could be embedded; see Leibold and Kempter ([^7]) for estimates of memory capacity.

#### Balancing the network.

Inhibitory neurons are used to stabilize and balance the network activity, i.e., prevent the excitatory network structure described above from generating oscillatory or irregular bursts of activity. Recurrent inhibitory connections are assumed to have the synaptic weight $g^{\mathit{II}}$, and excitatory-to-inhibitory ($E \rightarrow I$) synapses are assumed to have the synaptic weight $g^{\mathit{IE}}$. The inhibitory-to-excitatory weights are subject to a plasticity mechanism that allows for excitatory cells to receive different amounts of inhibition in order to balance the network, allowing it to reach an asynchronous irregular (AI) state.

We balance the network using an inhibitory-plasticity rule ([^39]): All inhibitory-to-excitatory synapses are subject to spike-timing-dependent plasticity (STDP), with near coincident pre- and postsynaptic firing potentiating the synapse and lone presynaptic spikes depressing it. To implement this plasticity rule, we assign a synaptic trace variable $x_{j}$ to every neuron $j$, such that $x_{j}$ is incremented with each spike of that neuron and decays with a time constant τSTDP:
$$
\begin{matrix}x_{j} \rightarrow x_{j} + 1 , & \text{if neuron} j \text{fires} , \\ \tau \text{STDP} \frac{d x_{j}}{d t} = - x_{j} , & \text{otherwise}.\end{matrix}
$$

\[3\]

The synaptic weight $g_{\mathit{jk}}^{\mathit{EI}}$ from inhibitory neuron $k$ to excitatory neuron $j$ is initialized with the same value $g_{0}^{\mathit{EI}}$ for all $I \rightarrow E$ synapses. The conductances are then updated at the times of pre/post-synaptic events in the following manner:
$$
\begin{matrix}g_{\mathit{jk}}^{\mathit{EI}} \rightarrow g_{\mathit{jk}}^{\mathit{EI}} + \eta g_{0}^{\mathit{EI}} \left(\right. x_{j} - \alpha \left.\right) , & \text{for a presynaptic spike} \\ \text{in neuron} k , \\ g_{\mathit{jk}}^{\mathit{EI}} \rightarrow g_{\mathit{jk}}^{\mathit{EI}} + \eta g_{0}^{\mathit{EI}} x_{k} , & \text{for a postsynaptic spike} \\ \text{in neuron} j ,\end{matrix}
$$

\[4\]

where $\eta$ is the learning-rate parameter, and the bias $\alpha = 2 \rho_{0} \tau \text{STDP}$ is determined by the desired firing rate $\rho_{0}$ of the excitatory postsynaptic neurons.

#### Quantifying replay of the embedded sequence.

To test whether a sequence can be replayed, we first initialize the network with all its synaptic connections, including the embedded sequence we wish to replay. We then let the network run with STDP of the $I \rightarrow E$ synapses, in order to balance the activity of the neuronal populations. Once the network reaches an AI state (which typically occurs after 10 s of simulation), the plasticity is turned off. Finally, a brief current is injected (150 pA for 5 ms) to 50% of the neurons of the first assembly in the sequence, which becomes activated. If this activity of the first assembly propagates quickly enough throughout the sequence without considerable attenuation, we consider it a successful replay event. Otherwise, the replay is considered to have failed. For a replay event to be successful, we require that the peak of the population activity of each assembly (with a Gaussian filter with width 1 ms) be within 60 and 360 spikes/s. Furthermore, we require that the peaks of consecutive assemblies must be within 1 and 20 ms of each other.

For each simulated parameter configuration, we perform 5 attempts on 5 different pseudo-random instantiations of the network. The fraction of successful replays (out of 25) gives us a percentage of success for each point in parameter space.

## Data, Materials, and Software Availability

The electron microscopy dataset is publicly available for browsing at [WEBKNOSSOS](https://wklink.org/7823) ([^58]). Sample code to reproduce the results of the computational model is available on [GitHub](https://github.com/gaspar-c/replay-simulations) ([^59]). All other data are included in the article and/or [*SI Appendix*](https://www.pnas.org/doi/10.1073/pnas.2312281120#supplementary-materials).

## Acknowledgments

We thank Susanne Rieckmann, Anke Schönherr, and Smaro Soworka for excellent technical assistance, Anjali Gour and Barabara Imbrosci for assistance with initial electron microscopy data acquisition and analysis, and colleagues of the Research Workshop at the Charité-Universitätsmedizin Berlin for developing and manufacturing our experimental devices and Linda Brenndörfer for help with confocal microscopy and reconstructions. Funding sources: German Research Foundation: project 327654276–SFB 1315 (D.S., R.K.), project 184695641–SFB 958 (D.S.), project 415914819–FOR 3004 (D.S.), project 431572356 (D.S.); Germany’s Excellence Strategy–Exc-2049-390688087 (D.S.); European Research Council Horizon 2020 grant 810580–BrainPlay (D.S.); Federal Ministry of Education and Research project 01GQ1420B–SmartAge (D.S.); Otto-Hahn-Group of Max Planck Society (H.S.).

### Author contributions

R.K., H.S., and D.S. designed research; R.P.S., M.V., L.M.-V., G.C., and V.D.M. performed research; M.S. contributed new reagents/analytic tools; R.P.S., M.V., L.M.-V., G.C., M.O., E.G., and H.S. analyzed data; and R.P.S., M.V., G.C., M.S., R.K., H.S., and D.S. wrote the paper.

### Competing interests

The authors declare no competing interest.

## Supporting Information

Appendix 01 (PDF)

- [Download](https://www.pnas.org/doi/suppl/10.1073/pnas.2312281120/suppl_file/pnas.2312281120.sapp.pdf)
- 2.18 MB

[^1]: B. L. McNaughton, R. G. M. Morris, Hippocampal synaptic enhancement and information storage within a distributed memory system. *Trends Neurosci.* **10**, 408–415 (1987).

[^2]: E. T. Rolls, “Functions of neuronal networks in the hippocampus and cerebral cortex in memory” in *Models of Brain Function*, R. M. J. Cotterill, Ed. (Cambridge University Press, Cambridge, UK, 1989), pp. 15–33.

[^3]: A. Treves, E. T. Rolls, What determines the capacity of autoassociative memories in the brain? *Netw.: Comput. Neur. Syst.* **2**, 371–397 (1991).

[^4]: A. Treves, E. T. Rolls, Computational constraints suggest the need for two distinct input systems to the hippocampal CA3 network. *Hippocampus* **2**, 189–199 (1992).

[^5]: A. Treves, E. T. Rolls, Computational analysis of the role of the hippocampus in memory. *Hippocampus* **4**, 374–391 (1994).

[^6]: M. R. Bennett, W. G. Gibson, J. Robinson, Dynamics of the CA3 pyramidal neuron autoassociative memory network in the hippocampus. *Philos. Trans. R. Soc. London B: Biol. Sci.* **343**, 167–187 (1994).

[^7]: C. Leibold, R. Kempter, Memory capacity for sequences in a recurrent network with biological constraints. *Neural Comput.* **18**, 904–941 (2006).

[^8]: E. T. Rolls, An attractor network in the hippocampus: Theory and neurophysiology. *Learn. Memory* **14**, 714–731 (2007).

[^9]: R. P. Kesner, E. T. Rolls, A computational theory of hippocampal function, and tests of the theory: New developments. *Neurosci. Biobehav. Rev.* **48**, 92–147 (2015).

[^10]: G. Papp, M. P. Witter, A. Treves, The CA3 network as a memory store for spatial representations. *Learn. Memory* **14**, 732–744 (2007).

[^11]: E. T. Rolls, The mechanisms for pattern completion and pattern separation in the hippocampus. *Front. Syst. Neurosci.* **7**, 74 (2013).

[^12]: C. Le Duigou, J. Simonnet, M. Telenczuk, D. Fricker, R. Miles, Recurrent synapses and circuits in the CA3 region of the hippocampus: An associative network. *Front. Cell. Neurosci.* **7**, 262 (2014).

[^13]: N. Chenkov, H. Sprekeler, R. Kempter, Memory replay in balanced recurrent networks. *PLoS Comput. Biol.* **13**, e1005359 (2017).

[^14]: D. Marr, Simple memory: A theory for archicortex. *Philos. Trans. R. Soc. Lond. B Biol. Sci.* **262**, 23–81 (1971).

[^15]: S. Ramon y Cajal, Estructura del asta de Ammon. *Anales Soc. Esp. Hist. Nat.* **22**, 53–114 (1893).

[^16]: R. Lorente De Nó, Studies on the structure of the cerebral cortex. II. Continuation of the study of the ammonic system. *J. Psychol. Neurol.* **46**, 113–177 (1934).

[^17]: L. Wittner, D. A. Henze, L. Záborszky, G. Buzsáki, Three-dimensional reconstruction of the axon arbor of a CA3 pyramidal cell recorded and filled in vivo. *Brain Struct. Funct.* **212**, 75–83 (2007).

[^18]: L. W. Swanson, J. M. Wyss, W. M. Cowan, An autoradiographic study of the organization of intrahippocampal association pathways in the rat. *J. Comp. Neurol.* **181**, 681–715 (1978).

[^19]: L. W. Swanson, P. E. Sawchenko, W. M. Cowan, Evidence that the commissural, associational and septal projections of the regio inferior of the hippocampus arise from the same neurons. *Brain Res.* **197**, 207–212 (1980).

[^20]: N. Ishizuka, J. Weber, D. G. Amaral, Organization of intrahippocampal projections originating from CA $$ pyramidal cells in the rat. *J. Comp. Neurol.* **295**, 580–623 (1990).

[^21]: S. Laurberg, K. E. Sørensen, Associational and commissural collaterals of neurons in the hippocampal formation (Hilus fasciae dentatae and subfield CA $$). *Brain Res.* **212**, 287–300 (1981).

[^22]: N. Tamamaki, Y. Nojyo, Crossing fiber arrays in the rat hippocampus as demonstrated by three-dimensional reconstruction. *J. Comp. Neurol.* **303**, 435–442 (1991).

[^23]: H. Kondo, P. Lavenex, D. G. Amaral, Intrinsic connections of the macaque monkey hippocampal formation: II. CA3 connections. *J. Comp. Neurol.* **515**, 349–377 (2009).

[^24]: S. J. Guzman, A. Schlögl, M. Frotscher, P. Jonas, Synaptic mechanisms of pattern completion in the hippocampal CA $$ network. *Science* **353**, 1117–1123 (2016).

[^25]: J. G. White, E. Southgate, J. N. Thomson, S. Brenner, The structure of the nervous system of the nematode *Caenorhabditis elegans*. *Philos. Trans. R. Soc. London. B Biol. Sci.* **314**, 1–340 (1986).

[^26]: M. Winding *et al*., The connectome of an insect brain (2022). Pages: 2022.11.28.516756 Section: New Results.

[^27]: S. Loomba et al., Connectomic comparison of mouse and human cortex. *Science* **377**, eabo0924 (2022).

[^28]: K. J. Hayworth, N. Kasthuri, R. Schalek, J. W. Lichtman, Automating the collection of ultrathin serial sections for large volume TEM reconstructions. *Micros. Microanal.* **12**, 86–87 (2006).

[^29]: K. J. Hayworth et al., Imaging ATUM ultrathin section libraries with WaferMapper: A multi-scale approach to EM reconstruction of neural circuits. *Front. Neural Circ.* **8**, 68 (2014).

[^30]: A. L. Eberle, O. Selchow, M. Thaler, D. Zeidler, R. Kirmse, Mission (im)possible - mapping the brain becomes a reality. *Micros. (Oxf. Engl.)* **64**, 45–55 (2015).

[^31]: K. M. Boergens et al., webKnossos: Efficient online 3D data annotation for connectomics. *Nat. Methods* **14**, 691–694 (2017).

[^32]: Y. Peng et al., High-throughput microcircuit analysis of individual human brains through next-generation multineuron patch-clamp. *eLife* **8**, e48178 (2019).

[^33]: R. Miles, R. K. Wong, Excitatory synaptic interactions between CA $$ neurones in the guinea-pig hippocampus. *J. Physiol.* **373**, 397–418 (1986).

[^34]: D. Debanne, N. C. Guérineau, B. H. Gähwiler, S. M. Thompson, Physiology and pharmacology of unitary synaptic connections between pairs of cells in areas CA $$ and CA $$ of rat hippocampal slice cultures. *J. Neurophysiol.* **73**, 1282–1294 (1995).

[^35]: S. Song, P. J. Sjöström, M. Reigl, S. Nelson, D. B. Chklovskii, Highly nonrandom features of synaptic connectivity in local cortical circuits. *PLoS Biol.* **3**, e68 (2005).

[^36]: L. Cossell et al., Functional organization of excitatory synaptic strength in primary visual cortex. *Nature* **518**, 399–403 (2015).

[^37]: A. Frick, D. Feldmeyer, M. Helmstaedter, B. Sakmann, Monosynaptic Connections between Pairs of L5A Pyramidal Neurons in Columns of Juvenile Rat Somatosensory Cortex. *Cereb. Cort.* **18**, 397–406 (2008).

[^38]: T. Manabe, P. Renner, R. A. Nicoll, Postsynaptic contribution to long-term potentiation revealed by the analysis of miniature synaptic currents. *Nature* **355**, 50–55 (1992).

[^39]: T. P. Vogels, H. Sprekeler, F. Zenke, C. Clopath, W. Gerstner, Inhibitory plasticity balances excitation and inhibition in sensory pathways and memory networks. *Science* **334**, 1569–1573 (2011).

[^40]: A. L. Barth et al., Comment on principles of connectivity among morphologically defined cell types in adult neocortex. *Science* **353**, 1108 (2016).

[^41]: X. Jiang et al., Principles of connectivity among morphologically defined cell types in adult neocortex. *Science* **350**, aac9462 (2015).

[^42]: X. Jiang et al., Response to comment on principles of connectivity among morphologically defined cell types in adult neocortex. *Science* **353**, 1108 (2016).

[^43]: D. G. Amaral, N. Ishizuka, B. Claiborne, Neurons, numbers and the hippocampal network. *Progress Brain Res.* **83**, 1–11 (1990).

[^44]: J. Maliković et al., Cell numbers in the reflected blade of CA $$ and their relation to other hippocampal principal cell populations across seven species. *Front. Neuroanat.* **16**, 1070035 (2023).

[^45]: B. D. Boss, K. Turlejski, B. B. Stanfield, W. M. Cowan, On the numbers of neurons on fields CA $$ and CA $$ of the hippocampus of Sprague-Dawley and Wistar rats. *Brain Res.* **406**, 280–287 (1987).

[^46]: D. Keller, C. Erö, H. Markram, Cell densities in the mouse brain: A systematic review. *Front. Neuroanat.* **12** (2018).

[^47]: M. J. West, A. H. Andersen, An allometric study of the area dentata in the rat and mouse. *Brain Res. Rev.* **2**, 317–348 (1980).

[^48]: N. Maier, G. Morris, F. W. Johenning, D. Schmitz, An approach for reliably investigating hippocampal sharp wave-ripples in vitro. *PLoS One* **4**, e6925 (2009).

[^49]: N. Maier, V. Nimmrich, A. Draguhn, Cellular and network mechanisms underlying spontaneous sharp wave-ripple complexes in mouse hippocampal slices. *J. Physiol.* **550**, 873–887 (2003).

[^50]: L. Feng, T. Zhao, J. Kim, neuTube 1.0: A new design for efficient neuron reconstruction software based on the SWC format. *eNeuro* **2** (2015).

[^51]: A. Karimi, J. Odenthal, F. Drawitsch, K. M. Boergens, M. Helmstaedter, Cell-type specific innervation of cortical pyramidal cells at their apical dendrites. *eLife* **9**, e46876 (2020).

[^52]: Y. Hua, P. Laserstein, M. Helmstaedter, Large-volume en-bloc staining for electron microscopy-based connectomics. *Nat. Commun.* **6**, 7923 (2015).

[^53]: L. K. Scheffer, B. Karsh, S. Vitaladevun, Automated alignment of imperfect em images for neural reconstruction. arXiv \[Preprint\] (2013). [https://arxiv.org/abs/1304.6034](https://arxiv.org/abs/1304.6034) (Accessed 8 November 2022).

[^54]: H. Schmidt et al., Axonal synapse sorting in medial entorhinal cortex. *Nature* **549**, 469–475 (2017).

[^55]: D. Goodman, R. Brette, The Brian simulator. *Front. Neurosci.* **3** (2009).

[^56]: G. Buzsáki, K. Mizuseki, The log-dynamic brain: How skewed distributions affect network operations. *Nat. Rev. Neurosci.* **15**, 264–278 (2014).

[^57]: Y. Ikegaya et al., Interpyramid spike transmission stabilizes the sparseness of recurrent network activity. *Cereb. Cort.* **23**, 293–304 (2013).

[^58]: M. Vezir, M. Sievers, E. Grasso, H. Schmidt, 3D EM dataset of mouse CA3. www.webknossos.org. [https://wklink.org/7823](https://wklink.org/7823). Deposited 18 September 2022.

[^59]: G. Cano, replay-simulations. GitHub. [https://github.com/gaspar-c/replay-simulations](https://github.com/gaspar-c/replay-simulations). Deposited 28 February 2023.