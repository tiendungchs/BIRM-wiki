---
title: "Episodic and associative memory from spatial scaffolds in the hippocampus"
source: "https://www.nature.com/articles/s41586-024-08392-y"
author:
  - "[[Sarthak Chandra]]"
  - "[[Sugandha Sharma]]"
  - "[[Rishidev Chaudhuri]]"
  - "[[Ila Fiete]]"
published: 2025-01-15
created: 2026-09-08
description: "Hippocampal circuits in the brain enable two distinct cognitive functions: the construction of spatial maps for navigation, and the storage of sequential episodic memories1–5. Although there have been advances in modelling spatial representations in the hippocampus6–10, we lack good models of its role in episodic memory. Here we present a neocortical–entorhinal–hippocampal network model that implements a high-capacity general associative memory, spatial memory and episodic memory. By factoring content storage from the dynamics of generating error-correcting stable states, the circuit (which we call vector hippocampal scaffolded heteroassociative memory (Vector-HaSH)) avoids the memory cliff of prior memory models11,12, and instead exhibits a graceful trade-off between number of stored items and recall detail. A pre-structured internal scaffold based on grid cell states is essential for constructing even non-spatial episodic memory: it enables high-capacity sequence memorization by abstracting the chaining problem into one of learning low-dimensional transitions. Vector-HaSH reproduces several hippocampal experiments on spatial mapping and context-based representations, and provides a circuit model of the ‘memory palaces’ used by memory athletes13. Thus, this work provides a unified understanding of the spatial mapping and associative and episodic memory roles of the hippocampus. A neocortical–entorhinal–hippocampal network model based on grid cell states recapitulates experimental results and reconciles the spatial, associative and episodic memory roles of the hippocampus."
tags:
  - "clippings"
---
## Abstract

Hippocampal circuits in the brain enable two distinct cognitive functions: the construction of spatial maps for navigation, and the storage of sequential episodic memories [^1] [^2] [^3] [^4] [^5]. Although there have been advances in modelling spatial representations in the hippocampus [^6] [^7] [^8] [^9] [^10], we lack good models of its role in episodic memory. Here we present a neocortical–entorhinal–hippocampal network model that implements a high-capacity general associative memory, spatial memory and episodic memory. By factoring content storage from the dynamics of generating error-correcting stable states, the circuit (which we call vector hippocampal scaffolded heteroassociative memory (Vector-HaSH)) avoids the memory cliff of prior memory models [^11] [^12], and instead exhibits a graceful trade-off between number of stored items and recall detail. A pre-structured internal scaffold based on grid cell states is essential for constructing even non-spatial episodic memory: it enables high-capacity sequence memorization by abstracting the chaining problem into one of learning low-dimensional transitions. Vector-HaSH reproduces several hippocampal experiments on spatial mapping and context-based representations, and provides a circuit model of the ‘memory palaces’ used by memory athletes [^13]. Thus, this work provides a unified understanding of the spatial mapping and associative and episodic memory roles of the hippocampus.

## Main

As we navigate through life, the hippocampus weaves threads of experience into a fabric of memory cross-linked by context. Thus, we can revisit scenes and events from only a few cues, as with Proust’s famous madeleine [^14]. Such memories enable inferences in the present and planning for the future. The hippocampal complex is responsible for this functionality [^1] [^15] [^16] [^17] [^18], but it is unclear exactly how the architecture and representations of the hippocampus and adjoining cortical regions enable it.

Substructures of the hippocampal complex have been studied extensively [^2] [^3] [^4] [^5] [^19] [^20] [^21] [^22] [^23] [^24], and experimental findings combined with modelling have led to marked progress in understanding local circuit mechanisms [^8] [^9] [^10] [^25] [^26] [^27] [^28] [^29] [^30] [^31] [^32] [^33] [^34] [^35] [^36] [^37] [^38] [^39] [^40] [^41] [^42] [^43] [^44] [^45]. These works put us in an excellent position to build our understanding of how the combined system subserves memory storage and recall. A central question involves the dual role of this structure. The ability to form episodic memories, our catalogue of autobiographical experiences, is compromised by damage to the hippocampal complex [^1]. Spatial memory—remembering the layout of our physical environment and our updated position within it as we move about—also centrally involves the hippocampus. Place cells fire at specific locations and environments [^2], and entorhinal grid cells represent spatial displacements in the form of triangular grid firing patterns that repeat across environments [^3]. It remains unknown why these two forms of memory are co-localized.

One hypothesis is that the circuit prioritizes spatial memory, such as where certain foods and dangers were found. In this view, episodic memory is an augmentation of the spatial memory system and representations are optimal for spatial, not episodic, memory. The second hypothesis is that the circuit is optimal for episodic memory, with spatial coordinates represented primarily as a stable and useful index for episodic memory [^46]. The third hypothesis is that the circuit does not simply store spatial and episodic information side by side or with one in the service of the other, but that its highly structured architectures, representations and dynamics are equally optimal for both functions, even when the memory in question does not involve space. Thus, the low-dimensional states in the circuit that are interpreted as spatial may serve as equally critical scaffolds for linking together (potentially entirely non-spatial) elements of an episodic memory [^18] [^45] [^46] [^47] [^48] [^49] [^50].

We propose a neocortical–entorhinal–hippocampal memory model based on properties of the biological circuit. It excels at item memory, spatial memory and sequential episodic memory with content-addressable recall, avoiding the full erasure (memory cliff) of existing neural memory models when adding inputs beyond a fixed low capacity (Fig. [1a](https://www.nature.com/articles/s41586-024-08392-y#Fig1)). Critically, the memory model: (1) separates dynamical fixed point generation (for pattern completion and error correction) from content encoding, with the former exploiting the structure of grid cell states; and (2) converts the problem of sequence memory into a simple process of low-dimensional transitions on the grid states. Grid cells are thus equally essential for non-spatial memory, supporting the third hypothesis.

![Fig. 1: Biological memory: challenges and proposed architecture.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41586-024-08392-y/MediaObjects/41586_2024_8392_Fig1_HTML.png?as=webp)

Fig. 1: Biological memory: challenges and proposed architecture.

This circuit, which we call Vector-HaSH because it assigns an error-correcting hash code to each input (a hash is a unique label independent of content) and exploits the metric structure of grid cell states to enable sequence storage via low-dimensional vector transitions.

## Factorization of dynamics and content

Hopfield networks are the paradigmatic model of content-addressable neural network memory [^25]. Structured as monolithic recurrent networks, they exhibit a steep memory cliff: in an *N* -neuron network, up to approximately *N* patterns (of *N* bits each) are perfectly recovered, but adding more patterns leads to total loss of even previously memorized patterns (Fig. [1a](https://www.nature.com/articles/s41586-024-08392-y#Fig1)). Variants of Hopfield networks all exhibit a cliff [^11] [^12] [^51].

Vector-HaSH is based on (known and inferred) connectivity of the hippocampus and entorhinal cortex [^8] [^52]. Entorhinal grid cells, which project to hippocampus (Fig. [1b](https://www.nature.com/articles/s41586-024-08392-y#Fig1), orange), consist of multiple modules [^23] with distinct periods *λ*. Each module expresses a set of low-dimensional states that are stabilized by recurrent connections and are invariant to task and behavioural state [^33] [^34] [^36] [^37] [^38]. In non-spatial contexts, these states can be conceptualized as abstract representations that are constrained to lie on a two-dimensional torus. Processed extrahippocampal inputs carrying sensory and internally generated states enter the hippocampus (Fig. [1b](https://www.nature.com/articles/s41586-024-08392-y#Fig1), purple) via non-grid entorhinal neurons and a few other cortical areas (Fig. [1b](https://www.nature.com/articles/s41586-024-08392-y#Fig1), green).

Critically, connections from grid cells to hippocampus are set as random and fixed. Hippocampus projects back to entorhinal cortex; those to grid cells are set once (for example, during pre- or post-natal development) by associative learning, then held fixed. Connections of hippocampus to non-grid cells remain bidirectionally plastic for memory acquisition and are set by associative learning. Activity propagation between regions occurs in sequential order and discrete time, a simplification of the oscillations and synaptic latencies hypothesized to gate this information flow. We refer to the grid–hippocampal subcircuit, with its unchanging weights, as the fixed scaffold of the network. Separately, we refer to the hippocampal–non-grid cortical feedback loop as the heteroassociative part of the circuit. We will see that small variations of this basic circuit enable content-addressable memory in various settings, from spatial to non-spatial memory to sequential episodic memory and memory palaces (Fig. [1c–f](https://www.nature.com/articles/s41586-024-08392-y#Fig1)).

## A vast library of robust fixed points

Grid cells are partitioned into a few (*M*) independent modules: a module (the *i* th module) can occupy one of *K* <sub><i>i</i></sub> states, which lie on a two-dimensional torus. Together, the modules express ∏ <sub><i>i</i></sub> *K* <sub><i>i</i></sub>  ≈ ⟨ *K* ⟩ <sup><i>M</i></sup> many distinct states, growing exponentially with *M*. An across-module grid state, if bidirectionally coupled to a hippocampal cell that couples the modules [^30] [^32], can become a stable fixed point and enable error correction [^32]. Because there are many more grid states than hippocampal neurons [^53], this formulation cannot work for all grid states.

Remarkably, if grid cells project with random weights (a high-rank random projection) to hippocampus, and hippocampal cells (after thresholding their inputs) send return projections that are learned through Hebb-like learning to reinforce the corresponding grid states (Methods), then all grid states become stable fixed points (attractors) of the grid–hippocampal scaffold network (Fig. [2b,c](https://www.nature.com/articles/s41586-024-08392-y#Fig2)), once the hippocampus is above a minimal size (${N}_{{\rm{h}}}^{* }$). We define a state as an attractor if it is restored to its non-noisy value through the scaffold dynamics after injection of noise of norm 0.25 times the average hippocampal state norm.

![Fig. 2: The scaffold generates exponentially many attractors with equally large basins.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41586-024-08392-y/MediaObjects/41586_2024_8392_Fig2_HTML.png?as=webp)

Fig. 2: The scaffold generates exponentially many attractors with equally large basins.

The minimum hippocampal size (${N}_{{\rm{h}}}^{* }$) to convert all grid states to attractors is small (Fig. [2c](https://www.nature.com/articles/s41586-024-08392-y#Fig2))—it scales only linearly with the number of grid modules (Fig. [2d](https://www.nature.com/articles/s41586-024-08392-y#Fig2), left and Supplementary Fig. [1](https://www.nature.com/articles/s41586-024-08392-y#MOESM1); proof in Supplementary Information, section [C.1](https://www.nature.com/articles/s41586-024-08392-y#MOESM1)) and is nearly independent of the scale (periodicity) of the grid modules (Fig. [2d](https://www.nature.com/articles/s41586-024-08392-y#Fig2), right and Extended Data Fig. [1](https://www.nature.com/articles/s41586-024-08392-y#Fig8); proof in Supplementary Information, section [C.1](https://www.nature.com/articles/s41586-024-08392-y#MOESM1)). Thus, the number of attractors (approximately ⟨ *K* ⟩ <sup><i>M</i></sup>) is exponential in the total number of scaffold (grid and hippocampal) neurons (*N* <sub>h</sub>  +  *M* ⟨ *K* ⟩ ≈  *M* (*c*  +  *K*)), where *c* is a constant. For example, *M* = 10, *K*  = 10 <sup>2</sup> (10 grid phases per dimension) would generate ~10 <sup>20</sup> scaffold attractors with only ~10 <sup>3</sup> combined hippocampal and grid cells.

A correspondence between the grid states and grid-driven hippocampal states is critical: if the set of hippocampal states is randomly reassigned to the grid states, with bidirectional learning of grid–hippocampal weights for self-consistent activity reinforcement, the number of attractors collapses (Fig. [2c,d](https://www.nature.com/articles/s41586-024-08392-y#Fig2), light green curves; also see Supplementary Information Fig. [2](https://www.nature.com/articles/s41586-024-08392-y#MOESM1)). A similar collapse occurs if hippocampal-to-grid weights are randomly set while the grid-to-hippocampal weights are associatively learned for self-consistency (Supplementary Fig. [3](https://www.nature.com/articles/s41586-024-08392-y#MOESM1)).

We derive theoretically that the scaffold has no spurious fixed points or attractors, thus the scaffold attractor basins are maximally large (all hippocampal states form the scaffold attractor basins). The basins are also all convex and essentially identical (Supplementary Information, sections [C.2](https://www.nature.com/articles/s41586-024-08392-y#MOESM1) and [C.3](https://www.nature.com/articles/s41586-024-08392-y#MOESM1)). We test these analytical results by numerically computing the probability that a noisy hippocampal state flows to the true attractor (Fig. [2e](https://www.nature.com/articles/s41586-024-08392-y#Fig2)). Injected noise of magnitude several times the hippocampal state norm is reliably corrected, and all basins have identical probability curves.

### Strong generalization property of scaffold

A key property of the scaffold is ‘strong generalization’: associatively learning the hippocampal-to-grid cell weights to stabilize the exponentially many (approximately ${\mathcal{O}}({K}^{M})$) grid states does not require visiting them all. Visiting and performing associative grid–hippocampal learning on a vanishingly small fraction of the states stabilizes them all (Fig. [2f](https://www.nature.com/articles/s41586-024-08392-y#Fig2)). We show that visiting any ${\mathcal{O}}(M{K}_{\max })$ contiguous grid states, where *K* <sub>max</sub> is the number of states in the largest module, is sufficient for stabilizing all (approximately ⟨ *K* ⟩ <sup><i>M</i></sup>) of them as scaffold fixed points (Extended Data Fig. [2](https://www.nature.com/articles/s41586-024-08392-y#Fig9) and Supplementary Information, section [C.4](https://www.nature.com/articles/s41586-024-08392-y#MOESM1)); the results are robust to noise during learning (compare with Supplementary Fig. [5](https://www.nature.com/articles/s41586-024-08392-y#MOESM1)). Replacing grid states with random patterns of matched sparsity (for example, by shuffling within each multi-module grid-coding state), as in memory scaffold with heteroassociation (MESH) [^54], results in near-total generalization loss (proof in Supplementary Information, section [C.4](https://www.nature.com/articles/s41586-024-08392-y#MOESM1)), and visiting grid states in random order decreases the amount of generalization (Fig. [2f](https://www.nature.com/articles/s41586-024-08392-y#Fig2)). Certain special sets of non-contiguous locations can also lead to strong generalization (Supplementary Information, section [C.4](https://www.nature.com/articles/s41586-024-08392-y#MOESM1) and Supplementary Fig. [4](https://www.nature.com/articles/s41586-024-08392-y#MOESM1)). Strong generalization implies that restricted spatial exploration by juveniles in a small environment is sufficient to set up the scaffold for the rest of the lifetime.

## Heteroassociation of inputs onto scaffold

A content-addressable memory should store user-defined inputs and recall them from partial or corrupted inputs. The scaffold states can be used for content-addressable memory via heteroassociation of external cues with the scaffold.

We will refer to inputs to the hippocampus from neocortex and non-grid entorhinal cells (Fig. [3a](https://www.nature.com/articles/s41586-024-08392-y#Fig3), green), as sensory inputs. A sensory input is associated with a randomly selected scaffold fixed point via a Hebb-like online implementation of the pseudoinverse rule between sensory input and the hippocampal state (simple Hebbian learning achieves the same asymptotic capacity with a reduced constant prefactor; Extended Data Fig. [3](https://www.nature.com/articles/s41586-024-08392-y#Fig10) and Supplementary Information, section [D.6](https://www.nature.com/articles/s41586-024-08392-y#MOESM1)). These weights impose self-consistency so that hippocampal drive to the sensory states approximates the sensory activations input to the hippocampus.

![Fig. 3: High-capacity content-addressable item memory via heteroassociation with scaffold.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41586-024-08392-y/MediaObjects/41586_2024_8392_Fig3_HTML.png?as=webp)

Fig. 3: High-capacity content-addressable item memory via heteroassociation with scaffold.

Once acquired, memories can be reconstructed from partial sensory cues: these inputs drive a hippocampal state, which settles towards a scaffold fixed point via hippocampal–grid dynamics; finally, a sensory state is reconstructed by hippocampal-to-sensory weights. Thus, Vector-HaSH behaves as a content-addressable memory network (Fig. [3b](https://www.nature.com/articles/s41586-024-08392-y#Fig3)).

### A graceful item number–information trade-off

Memory recall in Vector-HaSH is perfect up to *N* <sub>h</sub> input patterns (the circuit recovers all *N* <sub>s</sub> bits per pattern correctly, where *N* <sub>s</sub> is the sensory input dimension); after more than *N* <sub>h</sub> patterns are stored, the information recovered for each pattern scales inversely with the number of patterns (Fig. [3c](https://www.nature.com/articles/s41586-024-08392-y#Fig3)). Thus, Vector-HaSH exhibits a graceful trade-off or ‘continuum’ between pattern number and recall richness, rather than a memory cliff, and total information in the network remains parallel to the theoretical upper bound (the square of the number of synapses) out to the number of scaffold fixed points (Fig. [3c](https://www.nature.com/articles/s41586-024-08392-y#Fig3)). Proof in Supplementary Information, section [D](https://www.nature.com/articles/s41586-024-08392-y#MOESM1) shows perfect content-addressable recall for the first *N* <sub>h</sub> states and near-optimal precision–pattern number trade-off beyond if the hippocampal states are a random projection from grid cells, passing through some nonlinear transformation; almost any nonlinear transformation, without fine-tuning, is sufficient (Supplementary Figs. [10](https://www.nature.com/articles/s41586-024-08392-y#MOESM1) and [11](https://www.nature.com/articles/s41586-024-08392-y#MOESM1)).

Increasing the sensory input dimension and thus information per pattern does not reduce the information fraction recovered because although pattern size grows, so do the number of heteroassociative weights (Fig. [3c](https://www.nature.com/articles/s41586-024-08392-y#Fig3), inset; also see Supplementary Fig. [6](https://www.nature.com/articles/s41586-024-08392-y#MOESM1)). The information contributed per synapse approaches a constant non-zero value as the number of stored patterns increases (Fig. [3d](https://www.nature.com/articles/s41586-024-08392-y#Fig3)), in contrast to Hopfield networks, where the value drops to zero [^11] [^12] past the memory cliff (Fig. [3d](https://www.nature.com/articles/s41586-024-08392-y#Fig3)). Other memory models (Supplementary Information, section [D4](https://www.nature.com/articles/s41586-024-08392-y#MOESM1)) exhibit a similar cliff or only store one specific number of patterns for a fixed network architecture [^51].

After most or all scaffold states have been used, there are three possibilities: (1) no further inputs are stored; (2) each new input replaces an existing memory (based on sensory overlap, age or random selection); or (3) all heteroassociative weights slowly decay so that older memories fade and those scaffold states are identified for reuse.

### Comparison with end-to-end trained deep networks

Vector-HaSH can be unfolded for interpretation as an autoencoder [^55] (Fig. [3e](https://www.nature.com/articles/s41586-024-08392-y#Fig3), left, architecture schematic) that has recurrent weights and is highly constrained: encoding and recurrent weights in the bottleneck layer are fixed, as are weights from the encoder to bottleneck and bottleneck to decoder layers. All remaining weights are set through biologically plausible associative learning. For comparison, consider an unconstrained and end-to-end gradient-optimized (via backprop) autoencoder of the same dimensions, with the addition of a tail-biting (output-to-input identity) connection for iterative reconstruction [^55] (Fig. [3e](https://www.nature.com/articles/s41586-024-08392-y#Fig3), left, architecture schematic). Notably, Vector-HaSH substantially outperforms this autoencoder despite the much greater potential flexibility of the autoencoder (Fig. [3e](https://www.nature.com/articles/s41586-024-08392-y#Fig3)), mirroring the results in ref. [^54]. The tail-biting exhibits a memory cliff, seen from curves (Fig. [3e](https://www.nature.com/articles/s41586-024-08392-y#Fig3), left) and reconstructions of a sample pattern (Fig. [3e](https://www.nature.com/articles/s41586-024-08392-y#Fig3), right). Vector-HaSH also outperforms optimized tail-biting and non-iterated autoencoders when cued with noisy sensory cues (Supplementary Fig. [7](https://www.nature.com/articles/s41586-024-08392-y#MOESM1)). Thus, the fixed scaffold provides a key inductive bias for robust high-capacity memory, which gradient optimization on an unconstrained architecture apparently cannot find or achieve.

### Mechanisms of the memory continuum

We probe the circuit to understand its continuum behaviour. As *N* <sub>h</sub> is varied above its threshold value, precision of reconstruction varies across the circuit (Fig. [3f](https://www.nature.com/articles/s41586-024-08392-y#Fig3), left). Grid and hippocampal states are nearly always recalled exactly. The sensory state is recalled approximately, with a continuous dependence on hippocampus size. Even when sensory retrieval is approximate, it falls in the correct basin (within the Voronoi region of the original sensory pattern (Fig. [3f](https://www.nature.com/articles/s41586-024-08392-y#Fig3), left)). The approximate recalled sensory state is identical, whether the cue is the true memory pattern (Fig. [3g](https://www.nature.com/articles/s41586-024-08392-y#Fig3), left) or a highly degraded version of it (Fig. [3f](https://www.nature.com/articles/s41586-024-08392-y#Fig3), right and Supplementary Fig. [8](https://www.nature.com/articles/s41586-024-08392-y#MOESM1)). In other words, although the precision of sensory reconstruction systematically decreases with the number of patterns (the distance of the recalled state within the Voronoi cell from the true sensory pattern increases)—accounting for the memory continuum—the reconstruction is reliable: regardless of the cue (which might be noiseless or corrupted), the reconstructed pattern is the same. This property will be important when modelling memory palaces.

Mechanistically, sensory-to-hippocampal projections partially denoise input cues (the hippocampal state is closer to its fixed point (Fig. [3g](https://www.nature.com/articles/s41586-024-08392-y#Fig3), green to pink) than the cue may have been to the true input). Next, scaffold dynamics recover the exact fixed point (Fig. [3g](https://www.nature.com/articles/s41586-024-08392-y#Fig3), pink to orange to pink) even deep in the memory continuum (analytical proof in Supplementary Information, section [D.1](https://www.nature.com/articles/s41586-024-08392-y#MOESM1)) and for highly corrupted hippocampal states, because of the convex large-basin property of scaffold attractors. Finally, hippocampus-to-sensory projections decode the scaffold state to a reconstructed sensory state. Interference in the heteroassociative weights leads to growing approximation error with pattern number, but it remains continuous rather than cliff-like because decoding happens in a single feedforward pass rather than via iteration (proofs in Supplementary Information, sections [D.2](https://www.nature.com/articles/s41586-024-08392-y#MOESM1) and [D.6](https://www.nature.com/articles/s41586-024-08392-y#MOESM1)). In sum, the factorization of attractor creation from content storage enables both pattern completion (exact recovery via recursion in the scaffold) and graded memory precision behaviour (feedforward decoding) in Vector-HaSH.

Conceptually, conventional autoassociative memory networks perform poorly because the locations, basin widths and depths of their attractors are governed by pattern content, leading to uneven, non-convex, small basins and many spurious minima. In Vector-HaSH, the attractor landscape is set by the regular structure of grid cell states, which produce well-spaced attractors with large basins and no spurious minima. Content is simply hooked onto these pre-structured states, in analogy with a clothesline (the scaffold) to which any clothes (sensory patterns) can be attached (via heteroassociation) (Fig. [3h](https://www.nature.com/articles/s41586-024-08392-y#Fig3)).

## One-shot robust recognition memory

Memorized inputs, because they are associated with scaffold attractors, generate grid-defined hippocampal states that form a narrow distribution with highly similar firing rates. When a novel sensory input drives the hippocampal state, that state, as well as the projection into grid cells and their initial return projection back to hippocampus, form patterns that are far outside the usual distribution for both cell populations (Supplementary Fig. [12](https://www.nature.com/articles/s41586-024-08392-y#MOESM1)). A simple decoder that detects firing rate deviations in either direction from the usual mean in the hippocampal state—implemented with two hidden units and fixed parameters from the time of scaffold formation (independent of the sensory inputs or number of memories stored; Supplementary Information, section [D.7](https://www.nature.com/articles/s41586-024-08392-y#MOESM1))—acts as a reliable familiarity/novelty discriminator (Fig. [3i](https://www.nature.com/articles/s41586-024-08392-y#Fig3)). Such a recognition memory can be used to decide a sensory input should be cleaned up (pattern completed) for recall or trigger new memory creation (association with a fresh scaffold state).

## Spatial inference and memory

When self-motion signals drive transitions between grid cell states (Fig. [4a](https://www.nature.com/articles/s41586-024-08392-y#Fig4)), the architecture and dynamics of Vector-HaSH support spatial memory without catastrophic forgetting and zero-shot spatial inference along novel paths.

![Fig. 4: Memory, inference and lifelong learning in the spatial domain.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41586-024-08392-y/MediaObjects/41586_2024_8392_Fig4_HTML.png?as=webp)

Fig. 4: Memory, inference and lifelong learning in the spatial domain.

At a landmark or corner of a novel room, grid module phases are initialized randomly. Velocity inputs update the grid phases by path integration [^8]. Vector-HaSH learns a map of the room via associations between the grid-driven scaffold states and sensory cues. Its structure permits successful reconstruction from either input (Supplementary Information, section [D](https://www.nature.com/articles/s41586-024-08392-y#MOESM1)), thus grid states can be recalled from sensory cues or vice versa (Fig. [4a](https://www.nature.com/articles/s41586-024-08392-y#Fig4)). If a familiar room is traversed without access to sensory cues (in the dark or in-between landmarks), Vector-HaSH path integrates to update grid (and thus hippocampal) states. At a landmark, the hippocampal state is updated via the sensory-hippocampal weights (Fig. [3a,b](https://www.nature.com/articles/s41586-024-08392-y#Fig3)), resetting any path-integration errors. Thus, without threshold modifications, hippocampal states can be determined by grid inputs alone, sensory inputs alone, or a combination of these. Grid cells and hippocampal cells exhibit realistic spatial tuning, including the localized and usually single-bump tuning typical of place cells (Fig. [4b](https://www.nature.com/articles/s41586-024-08392-y#Fig4) and Supplementary Fig. [13](https://www.nature.com/articles/s41586-024-08392-y#MOESM1)).

After very sparse exploration in a novel room (trajectory of Fig. [4c](https://www.nature.com/articles/s41586-024-08392-y#Fig4), left), Vector-HaSH is able to predict expected sensory observations along an entirely new route through the room (trajectory of Fig. [4c](https://www.nature.com/articles/s41586-024-08392-y#Fig4), right). This zero-shot inference ability arises from the path invariance of velocity integration: velocity updating generates accurate grid states even along novel paths, which then reconstruct (predict) sensory cues associated with those states.

After sequential exposure to a set of rooms (Fig. [4d](https://www.nature.com/articles/s41586-024-08392-y#Fig4)), Vector-HaSH learns distinct spatial maps, assessed for each by testing sensory-cued grid state inference (without path integration) after seeing that room (Fig. [4d,e](https://www.nature.com/articles/s41586-024-08392-y#Fig4)). To examine gradual interference between rooms (catastrophic forgetting), we test Vector-HaSH in all prior rooms right after learning the *i* th room (Fig. [4d,e](https://www.nature.com/articles/s41586-024-08392-y#Fig4)). Recall of hippocampal and grid states from sensory cues remains unchanged for all prior environments after subsequent acquisition of up to 10 rooms, without replay or consolidative rehearsal. This is due to the exponential scaling capacity and architecture of Vector-HaSH, in which random grid phase initializations result in well-separated maps (Fig. [4g](https://www.nature.com/articles/s41586-024-08392-y#Fig4)). Thus the model avoids not only a memory cliff but also catastrophic forgetting in grid and hippocampal recall.

In the ‘dark’ (no visible landmarks), after the initial grid state is specified for each room, the model is able to recall a large amount of sensory information (1 cue per location in every room) over 11 rooms, although the sensory cues in all rooms are recalled less vividly after learning 11 rooms (rightmost part, black curves of Fig. [4f](https://www.nature.com/articles/s41586-024-08392-y#Fig4)) because the circuit is in the memory continuum.

Hippocampal tuning is stable on repeated visits to the same room, with orthogonal representations of different rooms as in experiments (Fig. [4i,j](https://www.nature.com/articles/s41586-024-08392-y#Fig4)). Additional properties, including the distribution of probabilities that a hippocampal cell has a field in multiple rooms, match experimental data (Fig. [4k](https://www.nature.com/articles/s41586-024-08392-y#Fig4)).

In a continuous-activation and continuous-space implementation of Vector-HaSH (Methods), the discrete scaffold attractors form a folded two-dimensional continuous attractor within the *N* <sub>h</sub> -dimensional space of hippocampal states. The basins remain large (*N* <sub>h</sub>  − 2-dimensional instead of *N* <sub>h</sub> -dimensional; Fig. [4l](https://www.nature.com/articles/s41586-024-08392-y#Fig4) illustrates this using a one-dimensional continuous attractor). Vector-HaSH still performs robust associative memory retrieval and inference in the continuous limit (Fig. [4m](https://www.nature.com/articles/s41586-024-08392-y#Fig4)).

## Vector updating of grid states

Episodic memory centrally involves sequences of events in time. Sequence memory can be modelled with asymmetric Hopfield networks [^56] in which the user-defined pattern at one time drives, through learned weights, the next user-defined pattern. These models result in similar or stronger capacity limitations as for item memory [^12] [^55]: such networks quickly fail (within approximately 50 steps) to reconstruct even an approximation of the next pattern (Fig. [5b](https://www.nature.com/articles/s41586-024-08392-y#Fig5)). We will show that, remarkably, Vector-HaSH permits massive sequence memory by factorizing the problem to construct high-capacity abstract sequences (a sequence scaffold) and then affixing content via heteroassociation.

![Fig. 5: Sequence scaffold with low-dimensional grid cell shifts enables high-capacity episodic (sequence) memory.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41586-024-08392-y/MediaObjects/41586_2024_8392_Fig5_HTML.png?as=webp)

Fig. 5: Sequence scaffold with low-dimensional grid cell shifts enables high-capacity episodic (sequence) memory.

First, we hypothesized that modelling hippocampus as an asymmetric Hopfield-like network directly encoding the input patterns, with bidirectionally learned grid cell interactions to help denoise and pattern complete the imperfectly reconstructed next hippocampal state, might support high-capacity sequence reproduction. This roughly doubled the sequence capacity (to approximately 100 steps), but did not fundamentally alter capacity scaling with network size (Fig. [5b](https://www.nature.com/articles/s41586-024-08392-y#Fig5)).

Next, in the full spirit of the scaffold network, we reasoned that learning an abstract sequence of scaffold states rather than user-defined hippocampal states might be the solution. Hippocampal states were given by random grid state projections and hippocampus-to-grid weights were associatively set to be consistent with the next (rather than the current) grid state. Despite the full benefit of the scaffold architecture, sequence capacity remained low (Fig. [5b](https://www.nature.com/articles/s41586-024-08392-y#Fig5), failure within approximately 30 steps). We hypothesized that this happened because even abstract grid states are large and specific activity patterns, for which the previous hippocampal state must provide sufficient information to reconstruct. This hypothesis gave us the critical insight that grid states, which can be specified from a previous one by a two-dimensional velocity input acting on the grid network via a velocity-shift mechanism, could enable efficient sequence specification by memorization of a sequence of two-dimensional (and thus very low-information) velocity vectors.

Consider using the previous hippocampal state to cue the next grid state, but via the drastic dimensionality and complexity reduction of the velocity-shift mechanism: the previous hippocampal state specifies a two-dimensional velocity that signals where to move in the grid-coding space. A small and simple feedforward network (a multi-layer perceptron (MLP)) (Fig. [5a](https://www.nature.com/articles/s41586-024-08392-y#Fig5), top) associated the previous grid state, via the hippocampus, with a two-dimensional velocity vector. This architecture resulted in the accurate reconstruction of abstract scaffold sequences of 1.4 × 10 <sup>4</sup> states, using the same small number of cells in the scaffold network as before (Fig. [5a](https://www.nature.com/articles/s41586-024-08392-y#Fig5), left). Alternatively, recalled sensory states can drive the low-dimensional velocity transitions, without a separate MLP (Supplementary Information, section [D.8](https://www.nature.com/articles/s41586-024-08392-y#MOESM1)).

To quantify sequence scaffold capacity, we statistically assessed how well the circuit could recall random velocity (shift) vectors assigned to each grid state (Fig. [5c](https://www.nature.com/articles/s41586-024-08392-y#Fig5)). The sequence scaffold perfectly recalled approximately 1.5 × 10 <sup>5</sup> state-velocity associations with *N* <sub>h</sub>  = 500 and *N* <sub>g</sub>  = 275 neurons, with grid periods 5, 9 and 13 (totalling approximately 3.4 × 10 <sup>5</sup> grid states). The scaling of scaffold sequence length with the number of hippocampal cells is again sub-logarithmic, similar to scaffold capacity scaling for item memory (Fig. [5d](https://www.nature.com/articles/s41586-024-08392-y#Fig5), left); the number of MLP units needed to learn the hippocampal state-to-velocity mapping is linear with a very small coefficient (approximately 10 <sup>−3</sup>) (Fig. [5d](https://www.nature.com/articles/s41586-024-08392-y#Fig5), right).

Using the sequence scaffold, Vector-HaSH supports high-capacity episodic or sequence memory by hooking external inputs experienced over an episode onto a sequence scaffold (Fig. [5f](https://www.nature.com/articles/s41586-024-08392-y#Fig5)). The abstract sequence scaffold may be formed concurrently with the learning of the heteroassociative weights that link sensory inputs to the scaffold, or inputs could be affixed to a pre-existing sequence scaffold that is learned once. For episodic memories without clear metric variables such as spatial position, the scaffold trajectory can be arbitrarily chosen.

Asymmetric Hopfield networks and tail-biting autoencoders [^55] quickly diverge from the trained state sequence during recall; in a sequential version of the memory cliff, recalled states do not even approximately resemble the trained states (Fig. [5h](https://www.nature.com/articles/s41586-024-08392-y#Fig5)). In Vector-HaSH, internal grid sequences are recalled with essentially perfect fidelity over very long sequences, and sensory states are recalled perfectly in terms of identity but only approximately in content depending on the total length of the memorized sequence (Fig. [5i](https://www.nature.com/articles/s41586-024-08392-y#Fig5)) (the equivalent to the item memory continuum). Because sequence transitions are generated entirely within the scaffold, their continued fidelity does not depend on the fidelity of sensory reconstruction. As for item memory, the quality of sensory recall per state in the sequence (MI per input bit) degrades as the total memorized sequence content grows (Fig. [5i](https://www.nature.com/articles/s41586-024-08392-y#Fig5)), but the information recalled per synapse remains finite and approaches a constant asymptotically (Fig. [5j](https://www.nature.com/articles/s41586-024-08392-y#Fig5)), while it drops to zero for other models. To summarize, while in conventional memory models the current state and its recurrent projections must carry all the information to reconstruct the high-dimensional next state, in Vector-HaSH the current (scaffold) state and its recurrent projections must reconstruct merely the next two-dimensional velocity vector (Fig. [5k](https://www.nature.com/articles/s41586-024-08392-y#Fig5)). The high-dimensional vector is then reconstructed via feedforward decoding in the sensory areas.

Our information-based hypothesis is that failure or success in sequence memory depends on how much information the current state must specify to construct the next state. We test this hypothesis by varying the amount of information that the network must recall at each step, by increasing the range of possible velocities (length of velocity vectors) to be recalled. The recalled sequence fraction decreased systematically with increasing velocity range (Fig. [5e](https://www.nature.com/articles/s41586-024-08392-y#Fig5)), in proportion to the theoretically expected inverse proportionality to the number of information bits required to specify the velocity (blue). In sum, constraining sequence recall dynamics to a low-dimensional manifold where only low-dimensional tangent vectors (velocities) rather than the manifold states themselves must be reconstructed results in vast increases in recalled sequence length. Thus, the path integrability of the grid cell code can not only support spatial inference and mapping, but also serve as a scaffold for episodic and sequence memory even in the absence of any spatial inputs.

## Entorhinal and hippocampal phenomenology

While serving as a general-purpose memory circuit, Vector-HaSH recapitulates many grid cell properties shared with continuous attractor models (which constitute its core), and several hippocampal and full-circuit properties. Immediately in novel environments, Vector-HaSH grid cells exhibit periodic activity bumps (Fig. [6a](https://www.nature.com/articles/s41586-024-08392-y#Fig6), top), which align with the regular pattern seen on further exploration [^57] (Fig. [6a](https://www.nature.com/articles/s41586-024-08392-y#Fig6), bottom). Similar patterns are present during dark exploration (no sensory cues) over short times (Fig. [6b](https://www.nature.com/articles/s41586-024-08392-y#Fig6), left). Alternative models require extensive exploration and sensory cues for grid tuning emergence [^9] [^45]. Vector-HaSH exhibits grid resetting by sensory cues: After dark navigation and phase drift in a familiar environment, a sensory cue (‘lights’ turned on) resets the hippocampal (and then grid) states via the sensory-to-hippocampal in one cycle through the circuit (Fig. [6b](https://www.nature.com/articles/s41586-024-08392-y#Fig6), right), as in refs. [^40] [^57]. Vector-HaSH co-modular grid cells exhibit invariant relationships seen across behavioural states and environments where spatial tuning curves change [^33] [^34] [^36] [^37] [^38] (Fig. [6c](https://www.nature.com/articles/s41586-024-08392-y#Fig6), left) (Supplementary Fig. [18](https://www.nature.com/articles/s41586-024-08392-y#MOESM1) shows relative phase invariance across environments of different dimensions), whereas hippocampal cells in Vector-HaSH and experiments globally remap [^36] (Fig. [6c](https://www.nature.com/articles/s41586-024-08392-y#Fig6), right).

![Fig. 6: Vector-HaSH reproduces multiple aspects of entorhinal and hippocampal phenomenology.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41586-024-08392-y/MediaObjects/41586_2024_8392_Fig6_HTML.png?as=webp)

Fig. 6: Vector-HaSH reproduces multiple aspects of entorhinal and hippocampal phenomenology.

Vector-HaSH recapitulates grid–place cell correlations [^45] [^58]: the fraction of grid cells whose fields overlap with that of a place cell across environments (dashed line; Fig. [6d](https://www.nature.com/articles/s41586-024-08392-y#Fig6)) is significantly larger (*P* value of 0.0) than shuffle controls (place fields randomly reassigned across cells; Fig. [6d](https://www.nature.com/articles/s41586-024-08392-y#Fig6)), consistent with other models where grid cells drive place fields [^10] [^35] [^45].

Grid cells determine hippocampal states in Vector-HaSH, yet there is a strong reverse influence: If the hippocampus is lesioned when grid velocity inputs are noisy, grid cell spatial tuning is destroyed (Fig. [6e](https://www.nature.com/articles/s41586-024-08392-y#Fig6), left), as in ref. [^59]. Nevertheless, grid cells maintain their relative phase relationships (Fig. [6f](https://www.nature.com/articles/s41586-024-08392-y#Fig6); Methods), consistent with ref. [^60]. Thus, place cells are critical for reliable grid spatial tuning. By contrast, with sufficient sensory inputs, hippocampal tuning remains unchanged after grid lesioning [^61] (Fig. [6e](https://www.nature.com/articles/s41586-024-08392-y#Fig6), right). Thus, the circuit exploits all available means to estimate position: velocity (via grid cell integration), external cues (via hippocampus), both, or either. It mechanistically reconciles the question of whether place cells emerge from grid cells or vice versa.

Vector-HaSH generates splitter cells [^62] [^63] [^64], whose spatial tuning depends on context, recent memory and other factors, via the mechanism of grid phase remapping when internally generated context is appended to the hippocampal sensory input. In a spatial T-maze alternation task, context in the central stem is distinct for incoming trajectories from the right or left return tracks. A distinct context appended to the sensory input produces grid phase remapping in Vector-HaSH (differential grid phase shifts across modules; Supplementary Figs. [23](https://www.nature.com/articles/s41586-024-08392-y#MOESM1) and [24](https://www.nature.com/articles/s41586-024-08392-y#MOESM1)), total hippocampal remapping (Fig. [6g](https://www.nature.com/articles/s41586-024-08392-y#Fig6)) and hippocampal cells that are contextually selective. The same process yields directionally selective place cells on linear (Fig. [6i](https://www.nature.com/articles/s41586-024-08392-y#Fig6)) and circular one-dimensional tracks, tree mazes, and radial mazes (Supplementary Figs. [19](https://www.nature.com/articles/s41586-024-08392-y#MOESM1) – [22](https://www.nature.com/articles/s41586-024-08392-y#MOESM1)). The resulting ratios of splitter to non-splitter and direction-dependent to directionally untuned hippocampal cells were similar to values from experiment [^64] (Fig. [6h,j](https://www.nature.com/articles/s41586-024-08392-y#Fig6)) with the predictions that grid cells will possess splitter-like and directional tuning (Supplementary Fig. [24](https://www.nature.com/articles/s41586-024-08392-y#MOESM1)) and that splitter and directionally tuned hippocampal cells are not a separate biophysical type; this contrasts with the possibility that splitter (and direction-dependent) cell tuning is generated within the hippocampus by (possibly) distinct cell types.

An untested prediction is that grid activations should be periodic and hippocampal states that are much lower-dimensional than expected (relative to the dimensionality from randomly shuffling hippocampal fields) when traversing abstract domains and even recalling episodic memories, if the states are plotted as a function of the relevant abstract variable (Fig. [6k](https://www.nature.com/articles/s41586-024-08392-y#Fig6)).

Finally, for hippocampally dependent memories, items that are seen or recalled repeatedly are more resistant to hippocampal damage [^65], a phenomenon known as hippocampal memory consolidation. We exposed Vector-HaSH to several inputs, some of which were presented multiple times, leading to additional increments of the corresponding hippocampus-to-sensory weights (Fig. [6l](https://www.nature.com/articles/s41586-024-08392-y#Fig6)). Memories thus reinforced were remembered with richer detail (Fig. [6m](https://www.nature.com/articles/s41586-024-08392-y#Fig6)), and recall was relatively robust to neuron removal (Fig. [6n](https://www.nature.com/articles/s41586-024-08392-y#Fig6) and Supplementary Fig. [16](https://www.nature.com/articles/s41586-024-08392-y#MOESM1)). Additionally incrementing hippocampus-to-grid and sensory-to-hippocampus weights produced no further consolidation (Fig. [6o](https://www.nature.com/articles/s41586-024-08392-y#Fig6)). The primary role of directed synapses from hippocampus to cortex is consistent with and provides specific predictions about mechanisms for consolidation of hippocampus-dependent memory [^66]. An alternative hypothesis is that repeating inputs form associations with multiple scaffold states. Vector-HaSH simulations (1,000 runs; data not shown) did not support this hypothesis: associating an input with two different scaffold states always (100% of runs) resulted in the activation of a third, unrelated scaffold state when presented with a partial sensory cue.

## Mechanism for the memory palace technique

Vector-HaSH provides the first model to explain the power of the method of loci (memory palaces), a mnemonic technique that has been used for millennia and is currently widely exploited by memory athletes [^13]. Given a randomly ordered deck of playing cards, memory athletes take an imagined walk through a familiar and richly remembered space, and ‘place’ the cards near landmarks they encounter along the way. At recall time, they walk through and ‘collect’ the items they had placed. Counterintuitively, by adding to their memory task the demand of also recollecting the correct item–landmark associations, they are able to perform highly accurate one-shot memorization and recall.

The hippocampus (and Vector-HaSH, via vector-based sequence memorization) already enables rich memory for sequences, as we have seen. However, deep in the continuum, sensory recall is only approximate: a long new sequence of items cannot be exactly memorized using the native mechanism (Fig. [3e](https://www.nature.com/articles/s41586-024-08392-y#Fig3), upper row). However, the whole of Vector-HaSH, working in the regime of recall of a familiar sequence in the memory continuum, can itself be converted into a new scaffold for precise memory, as follows. Suppose Vector-HaSH is initialized to a starting location in a highly familiar environment, and items at locations along the path taken by the memory athlete are recalled. Crucially, even though the recalled sensory states are only an approximation of the actual items, each time they are recalled they are reliably the same (Fig. [3g](https://www.nature.com/articles/s41586-024-08392-y#Fig3), green); thus, even deep in the memory continuum, these recalled sensory states can have the role of perfectly retrievable abstract scaffold states for heteroassociation of the new neocortical inputs (Fig. [7b,c](https://www.nature.com/articles/s41586-024-08392-y#Fig7)). For this new extended scaffold, the heteroassociative linkages are well before its continuum regime, and the inputs can be recalled with high fidelity (Fig. [7d](https://www.nature.com/articles/s41586-024-08392-y#Fig7), blue) even when associated with sensory states that are a poor approximation of the original sensory inputs. Another advantage of using this extended scaffold is that the effective information capacity bottleneck, which was previously the size of the hippocampus, is now the size of the sensory input area and could be much larger, meaning that perfect memorization of a much larger number of inputs is possible (Fig. [7e](https://www.nature.com/articles/s41586-024-08392-y#Fig7)). Memory athletes cycle between using different memory palaces to refresh recently used palaces; in terms of the model, this presumably corresponds to erasure of heteroassociative linkages with the palace and refreshes the ability to reuse that scaffold in a non-continuum regime.

![Fig. 7: Accurate recall of arbitrary inputs by heteroassociation onto landmarks in a memory palace formed by Vector-HaSH.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41586-024-08392-y/MediaObjects/41586_2024_8392_Fig7_HTML.png?as=webp)

Fig. 7: Accurate recall of arbitrary inputs by heteroassociation onto landmarks in a memory palace formed by Vector-HaSH.

A key prediction of Vector-HaSH is that during memory palace use, grid, hippocampal and sensory area cells should be reliably activated in a way that correlates with location in the palace, and the correlation with location should be more faithful than correlation with the neural responses to the actual sensory inputs that were present when experiencing and acquiring memories of the palace. Another is that memory palaces could be built from familiar non-spatial sequences involving rich sensory data.

## Discussion

### Extensions

There are many paths for extending Vector-HaSH, which include modelling the subregions of hippocampus; incorporating hippocampal cells that respond to a simultaneous combination of grid and sensory inputs to model partial remapping; including local field potential oscillations as possible gating processes for the between-region iterations that we have assumed occur in ordered cycles; modelling how the circuit enables goal-directed behaviours; and many others.

### Relationship to anatomy

Anatomically, entorhinal projections to hippocampus derive from superficial layers and return projections arrive at deep layers, whereas Vector-HaSH predicts a tight and fully self-consistent loop from grid cells to hippocampus and back. This can be tested connectomically, and indeed, new discoveries still surprise: deep entorhinal layers send a copy of their outputs back to the hippocampus [^67].

Random fixed grid-to-hippocampal weights are important and sufficient for several properties of Vector-HaSH, and several types of non-random weights are insufficient, but this does not eliminate the possibility of non-random solutions. For instance, expander graphs for error-correcting codes admit non-random solutions in principle, but they have been difficult to find, whereas random connections are sufficient. Of note, ref. [^68] shows that the layer II MEC stellate cell circuit (these comprise most grid cells) is the first to mature, and activity in this network then drives maturation of the hippocampal circuit, followed by entorhinal layer 5, and finally, layer II of LEC. This maturation order is exactly consistent with what our model would predict on the basis of how it must be structured: the scaffold has to be formed first, and within it, the grid cell circuit is formed first, followed by the formation of fixed connections to hippocampus, then the hippocampal circuit, and finally the hippocampal–non-grid entorhinal circuit.

### Experimental tests

We have highlighted a number of model predictions throughout. Central parts of our model could be invalidated if, for instance: grid-to-hippocampal synapses were plastic at a timescale faster than the hippocampal-to-grid synapses; if grid cell lesions did not affect episodic memory; or if, when imagining traversing a childhood home, the grid representations were distinct from those when using the same home as a memory palace when using the method of loci. Finally, because Vector-HaSH is a dynamical neural network, it can be directly queried for experimental predictions about representation, dynamics and learning under a large variety of conditions and perturbations.

### Related models

Together with the bipartite expander network and MESH network models [^44] [^54], Vector-HaSH defines a new class of memory models that we name robust hash-based memory: they create exponentially many fixed points with large basins as abstract error-correcting states for memory. Furthermore, existing models do not implement the low-dimensional shift mechanism of Vector-HaSH for efficient sequence memory.

Vector-HaSH resembles the models in refs. [^7] [^10], which involve pre-structured grid cell representations interacting with hippocampal cells. Learning of grid-to-hippocampus weights prevents these models from having high-capacity, large robust basins and strong generalization, and avoiding the memory cliff and catastrophic forgetting. Vector-HaSH further contrasts with models that learn the structure of the explored space, such as successor representation [^9], principal components analysis [^41] and the Tolman–Eichenbaum machine [^45], because their internal representations derive from the geometries and dimensionality of the environment so can be non-grid-like, and require sensory inputs to form representations in new environments.

Any model of hippocampal memory necessitates compression of cortical inputs. Modelling hippocampus as a bottleneck layer in an cortico-hippocampal autoencoder (Fig. [3](https://www.nature.com/articles/s41586-024-08392-y#Fig3) and refs. [^55] [^69]) is a form of content-based compression. These models lack the capacity, resistance to catastrophic forgetting and sequence memory properties of Vector-HaSH. In Vector-HaSH, the hippocampus is a content-independent pointer or hash for content localized in cortex, related to the models of refs. [^70] [^71]. The circuit performs locality-sensitive hashing for episodic memory, with locality defined in the temporal domain (temporally contiguous inputs map to contiguous grid states).

Nevertheless, commonalities among these models point towards a converging view of the hippocampal complex. The highly performant features of Vector-HaSH suggest a first-draft understanding of the circuit mechanisms of the hippocampal complex as a general memory system.

## Methods

Reference [^55] introduced the MESH associative memory architecture, leveraging a three-layer network to store numerous independent memory states. This architecture allowed a high-capacity memory with a trade-off between the number of stored patterns and the fidelity of their recall. However, MESH did not require specifically grid cell encodings, did not exhibit strong generalization in scaffold learning, and did not exhibit a high sequence capacity.

In Vector-HaSH, the memory scaffold consists of a recurrent circuit incorporating MEC grid cells and a hippocampal layer that may be interpreted as the proximal CA1 and distal CA3 regions of the hippocampal complex. In addition, vVector-HaSH includes a sensory layer that is associatively linked to the hippocampal layer, as we describe in additional detail below. Activity propagation between regions occurs in sequential order and discrete time, a simplification of the oscillations and synaptic latencies that are hypothesized to gate this information flow. Most simulations involve discrete-valued inputs and grid cell activations, which we then later show can generalize to continuous space and activations.

We represent the MEC grid cells as outlined in ref. [^73], where each grid module’s state is expressed using a one-hot encoded vector that represents the module’s phase (and thus the active grid cell group within the module). The states are on a two-dimensional discretized hexagonal lattice with period *λ*. Thus, the state of each grid module is represented by a vector with a dimensionality of *λ* <sup>2</sup>.

*M* such grid modules are concatenated together to form a collective grid state $g\in {\{0,1\}}^{{N}_{{\rm{g}}}}$, where the ${N}_{{\rm{g}}}={\sum }_{M}{\lambda }_{M}^{2}$. The continuous attractor recurrence in the grid layer [^8] is represented by a module-wise winner-take-all dynamics, which we denote as CAN. This ensures that the equilibrium states of *g* always correspond to a valid grid-coding state.

 $g \left(t + 1\right) = C A N \left[g \left(t\right)\right] .$ 
$$
g(t+1)={\rm{CAN}}[g(t)].
$$

(1)

We represent these equilibrium states by ${g}_{\overrightarrow{x}}$, where we index the coding states by the two-dimensional location $\overrightarrow{x}$. For coprime periods *λ* <sub><i>M</i></sub>, the grid states can encode a spatial extent of ${N}_{{\rm{patts}}}={\prod }_{M}{\lambda }_{M}^{2}$ spatial locations.

This layer of grid cells projects randomly onto the hippocampal layer, through a *N* <sub>h</sub>  ×  *N* <sub>g</sub> random matrix *W* <sub>hg</sub>, with each element drawn independently from a Gaussian distribution with a mean of zero and s.d. of *N* (0, 1). This matrix is sparsified such that only a *γ* fraction of connections is retained, leading to a sparse random projection. This projection constructs an *N* <sub>h</sub> -dimensional set of hippocampal sparse states, ${h}_{\overrightarrow{x}}$ defined as

 $h_{\overset{\rightarrow}{x}} = R e L U \left[W_{h g} g_{\overset{\rightarrow}{x}} - \theta\right] .$ 
$$
{h}_{\overrightarrow{x}}={\rm{R}}{\rm{e}}{\rm{L}}{\rm{U}}[{W}_{{\rm{h}}{\rm{g}}}\,{g}_{\overrightarrow{x}}-\theta ].
$$

(2)

The return weights from the hippocampal layer back to the grid cell layer is set up through Hebbian learning between the predetermined set of grid and hippocampal states, ${g}_{\overrightarrow{x}}$ and ${h}_{\overrightarrow{x}}$.

 $W_{g h} = \frac{1}{N_{h}} \underset{\overset{\rightarrow}{x}}{\sum} g_{\overset{\rightarrow}{x}} h_{\overset{\rightarrow}{x}}^{T} .$ 
$$
{W}_{{\rm{gh}}}=\frac{1}{{N}_{{\rm{h}}}}\sum _{\overrightarrow{x}}{g}_{\overrightarrow{x}}{h}_{\overrightarrow{x}}^{T}.
$$

(3)

The dynamics of the hippocampal scaffold is then set up as

 $g \left(t + 1\right) = C A N \left[W_{g h} h \left(t\right)\right]$ 
$$
g(t+1)={\rm{CAN}}[{W}_{{\rm{gh}}}h(t)]
$$

(4)

 $h \left(t + 2\right) = R e L U \left[W_{h g} g \left(t + 1\right) - \theta\right]$ 
$$
h(t+2)={\rm{R}}{\rm{e}}{\rm{L}}{\rm{U}}[{W}_{{\rm{h}}{\rm{g}}}g(t+1)-\theta ]
$$

(5)

These equations maintain each ${g}_{\overrightarrow{x}},{h}_{\overrightarrow{x}}$ state as a fixed point of the recurrent dynamics, as we prove in Supplementary Information, section [C.1](https://www.nature.com/articles/s41586-024-08392-y#MOESM1).

This constructed hippocampal memory scaffold is then used to generate independent memory locations to store information presented through a sensory encoding layer, representing the non-grid cell component of the entorhinal cortex. Information to be stored is presented as a binary encoding of states in the sensory layer, and is ‘tagged’ onto a memory location $\overrightarrow{x}$ of the scaffold through pseudoinverse learned heteroassociative weights.

 $W_{h s} = H S^{+}$ 
$$
{W}_{{\rm{hs}}}=H{S}^{+}
$$

(6)

and

 $W_{s h} = S H^{+} ,$ 
$$
{W}_{{\rm{sh}}}=S{H}^{+},
$$

(7)

where *H* is a *N* <sub>h</sub>  ×  *N* <sub>patts</sub> -dimensional matrix with columns as the predetermined hippocampal states ${h}_{\overrightarrow{x}}$, and *S* is a *N* <sub>s</sub>  ×  *N* <sub>patts</sub> -dimensional matrix with columns as the encoded sensory inputs to be stored at location $\overrightarrow{x}$. As discussed in the main text, the pseuodoinverse computation can be performed through a biologically plausible iterative pseudoinverse learning rule [^74] [^75]. However, to reduce computational time-complexity, we use an exact pseudoinverse rather than an iterative pseudoinverse for calculation of these inter-layer weights, unless otherwise specified.

Given the above equations, we can now perform bidirectional inference of sensory inputs from grid states and vice versa:

 $h \left(t + 1\right) = R e L U \left[W_{h s} s \left(t\right)\right]$ 
$$
h(t+1)={\rm{ReLU}}[{W}_{{\rm{hs}}}s(t)]
$$

(8)

 $g \left(t + 2\right) = C A N \left[W_{g h} h \left(t + 1\right)\right]$ 
$$
g(t+2)={\rm{CAN}}[{W}_{{\rm{gh}}}h(t+1)]
$$

(9)

and

 $h \left(t + 1\right) = R e L U \left[W_{h g} g \left(t\right) - \theta\right]$ 
$$
h(t+1)={\rm{R}}{\rm{e}}{\rm{L}}{\rm{U}}[{W}_{{\rm{h}}{\rm{g}}}g(t)-\theta ]
$$

(10)

 $s \left(t + 2\right) = s g n \left[W_{s h} h \left(t + 1\right)\right]$ 
$$
s(t+2)={\rm{sgn}}[{W}_{{\rm{sh}}}h(t+1)]
$$

(11)

The above two sets of equations can then be combined to use Vector-HaSH as a content-addressable memory to recover stored sensory inputs from corrupted inputs—first the grid states are inferred from the corrupted sensory input, and then the true sensory input is recalled from the inferred grid state.

The above equations have been written considering sensory inputs to be random binary states. In cases in which sensory states are continuous valued (as in Fig. [3b](https://www.nature.com/articles/s41586-024-08392-y#Fig3), for example) the *s* reconstruction equation, equation ([11](https://www.nature.com/articles/s41586-024-08392-y#Equ11)) is replaced with simply *s* (*t*  + 2) =  *W* <sub>sh</sub> *h* (*t* + 2).

Equations ([1](https://www.nature.com/articles/s41586-024-08392-y#Equ1))–([11](https://www.nature.com/articles/s41586-024-08392-y#Equ11)) describe the core working of Vector-HaSH—this core version and its variants can then be used to generate item memory, spatial memory, episodic memory, as well as a wide range of experimental observations, such as those discussed in Fig. [6](https://www.nature.com/articles/s41586-024-08392-y#Fig6). In general, across all models, we assume that the relevant synapses are plastic during input presentation for memory storage, and are frozen during testing of memory retrieval.

### High-capacity pattern reconstruction

For the basic task of pattern storage and reconstruction, we utilize the simplest form of Vector-HaSH without any additional components. To examine reconstruction capacity, *N* <sub>patts</sub> sensory cues are stored in the network via training the *W* <sub>hs</sub> and *W* <sub>sh</sub> weights as described in equations ([6](https://www.nature.com/articles/s41586-024-08392-y#Equ6)) and ([7](https://www.nature.com/articles/s41586-024-08392-y#Equ7)).

The *N* <sub>patts</sub> sensory cues need to be stored corresponding to distinct scaffold states. In our implementation, for simplicity, we selected scaffold states in a ‘hairpin’-like traversal, similar to that shown in Fig. [5a](https://www.nature.com/articles/s41586-024-08392-y#Fig5), right to achieve this.

Then, a clean or corrupted version of a previously stored pattern is presented to the network in the sensory encoding layer, which then propagates through the network via equations ([8](https://www.nature.com/articles/s41586-024-08392-y#Equ8))–([11](https://www.nature.com/articles/s41586-024-08392-y#Equ11)), finally generating the recalled pattern *s*.

In all numerical examples that we consider in the main text we either construct random binary {−1, 1} patterns, or consider images from mini-imagenet ([https://www.kaggle.com/datasets/whitemoon/miniimagenet](https://www.kaggle.com/datasets/whitemoon/miniimagenet)). In particular, we took 3,600 images from the first 6 classes {‘house-finch’, ‘robin’, ‘triceratops’, ‘green-mamba’, ‘harvestman’ and ‘toucan’} and centre-cropped them to consider the middle 60 × 60 image and converted them to greyscale. We refer to this set of greyscale images as bw-mini-imagenet. In all models, the memorized patterns are a noise-free set, then we test memory recall with noise-free, partial or noisy cues.

In Figs. [2](https://www.nature.com/articles/s41586-024-08392-y#Fig2) and [3](https://www.nature.com/articles/s41586-024-08392-y#Fig3), the recall performance and quality was examined in networks with three grid modules, *γ*  = 0.6, and *θ*  = 0.5.

The capacity in Fig. [2c,d](https://www.nature.com/articles/s41586-024-08392-y#Fig2), right was evaluated by injecting a noise into the hippocampal layer of magnitude 20% of the magnitude of the hippocampal state vector, and requiring the iterated dynamics to return the hippocampal state to within 0.6% of the original hippocampal state (here magnitudes and distances were calculated via an *L* <sup>2</sup> metric).

In Fig. [2d](https://www.nature.com/articles/s41586-024-08392-y#Fig2), left and Extended Data Fig. [1](https://www.nature.com/articles/s41586-024-08392-y#Fig8), the critical ${N}_{{\rm{h}}}^{* }$ is estimated as the smallest value of *N* <sub>h</sub> such that all scaffold states have been stabilized as fixed points. The corresponding module periods for data points plotted in Extended Data Fig. [1](https://www.nature.com/articles/s41586-024-08392-y#Fig8) for two and three modules are listed in Table [1](https://www.nature.com/articles/s41586-024-08392-y#Tab1). Similarly, the grid module periods for the data in Fig. [2c](https://www.nature.com/articles/s41586-024-08392-y#Fig2), left are listed in Table [2](https://www.nature.com/articles/s41586-024-08392-y#Tab2).

**Table 1 Grid module periods, number of grid cells and total number of patterns for data in Fig. [2e](https://www.nature.com/articles/s41586-024-08392-y#Fig2)**

**Table 2 Grid module periods, number of grid cells and total number of patterns for data in Fig. [2f](https://www.nature.com/articles/s41586-024-08392-y#Fig2)**

To estimate the basin sizes of the patterns stored in the scaffold, as shown in Fig. [2e](https://www.nature.com/articles/s41586-024-08392-y#Fig2), we compute the probability that a given pattern is perfectly recovered (that is, remains within its correct basin) as we perturb the hippocampal states with a vector of increasing magnitude. We assume that the size of any given basin can be estimated as the typical magnitude of perturbation that keeps the system within the same basin of attraction—this is not generally true for non-convex basins, particularly in high-dimensional spaces. However, this estimate is relevant in the context of testing robustness under corruption with uncorrelated noise. Furthermore, we later demonstrate in Supplementary Information, section [C.3](https://www.nature.com/articles/s41586-024-08392-y#MOESM1) that the basins are indeed convex. Here grid module periods *λ*  = {3, 4, 5}, number of grid cells *N* <sub>g</sub>  = 50, and *N* <sub>h</sub>  = 400 hippocampal cells were used. Probability that a given pattern remains within its correct basin was estimated by computing the fraction of runs in which a given pattern was correctly recovered for a 100 different random realization of the injected noise.

Figure [2f](https://www.nature.com/articles/s41586-024-08392-y#Fig2) examines the learning generalization in Vector-HaSH, that is, the capability of Vector-HaSH to self-generate fixed points corresponding to scaffold grid–hippocampal states despite training on a smaller number of fixed points. For a given number of training patterns, we calculate the number of generated fixed points by counting the number of states that, when initialized at a scaffold state, remain fixed after iteration through equations ([4](https://www.nature.com/articles/s41586-024-08392-y#Equ4)) and ([5](https://www.nature.com/articles/s41586-024-08392-y#Equ5)). As discussed in the main text, when training on a given number of training patterns (that is less than the complete set of all patterns), the ordering of the patterns is crucial in controlling the generalization properties of the model. For Vector-HaSH, we order patterns such that a two-dimensional contiguous region of space is covered (see Supplementary Information, section [C.4](https://www.nature.com/articles/s41586-024-08392-y#MOESM1) for additional details of the ordering and the freedom of possibilities in this ordering), resulting in the strongest generalization (Supplementary Information, section [C.4](https://www.nature.com/articles/s41586-024-08392-y#MOESM1)). For comparison, in Fig. [2f](https://www.nature.com/articles/s41586-024-08392-y#Fig2) we also consider ‘shuffled hippocampal states’, wherein scaffold states are randomized in order before subsets are selected for training. We also consider ‘random hippocampal states’: here we consider each hippocampal state vector and randomize its indices, in effect constructing a new state vector with exactly the same sparsity and statistics, but now uncorrelated to the grid state corresponding to that hippocampal state. Then, we use bidirectional pseudoinverse learning between grid and hippocampal states and construct this as a scaffold. This lack of structured correlations between grid and hippocampal population vectors (PVs) results in catastrophic forgetting, with no observed fixed points remaining once all scaffold states have been used for training.

All curves shown in Fig. [3c–f](https://www.nature.com/articles/s41586-024-08392-y#Fig3) are averaged over five runs with different random initialization of the predefined sparse connectivity matrix *W* <sub>hg</sub>, error bars shown as shaded regions represent standard deviation across runs. In Fig. [3b,e,h](https://www.nature.com/articles/s41586-024-08392-y#Fig3), grid module periods *λ*  = {3, 4, 5}, *N* <sub>g</sub>  = 50, *N* <sub>s</sub>  = 3,600 was used. The total capacity of the network in this case is capped by ${N}_{{\rm{patts}}}={\prod }_{M}{\lambda }_{M}^{2}=\mathrm{3,600}$. For the other associative memory models [^55] [^76] [^77] [^78] [^79] [^80] [^81] used in Fig. [3d](https://www.nature.com/articles/s41586-024-08392-y#Fig3), all shown networks have ~5 × 10 <sup>5</sup> synapses. Number of nodes in these networks are as follows: (1) Hopfield network of size *N*  = 708, synapses =  *N* <sup>2</sup>. (2) Pseudoinverse Hopfield network of size *N*  = 708, synapses =  *N* <sup>2</sup>. (3) Hopfield network with bounded synapses was trained with Hebbian learning on sequentially seen patterns. Size of the network *N*  = 708, synapses =  *N* <sup>2</sup>. (4) Sparse Hopfield network (with sparse inputs) with a network size of *N*  = 708, synapses =  *N* <sup>2</sup>, sparsity = 100(1 −  *p*). (5) Sparse Hopfield network. Size of the network *N*, synapse dilution *κ*, synapses =  *κ*  ×  *N* <sup>2</sup>  = 10 <sup>5</sup>. (6) Tail-biting overparameterized autoencoder with network layer sizes 900, 275, 38, 275, 900. Vector-HaSH uses *λ*  = {2, 3, 5}, and layer sizes: *N* <sub>g</sub>  = 38, *N* <sub>h</sub>  = 275, *N* <sub>s</sub>  = 900.

For stored patterns of size *N*, recall of an independent random vector of size *N* would appear to have a MI of $\sim 1/\sqrt{N}$, which when evaluating the total MI across all ${\mathcal{O}}(N)$ patterns or more would appear to scale as ${\mathcal{O}}(\sqrt{N})$, despite no actual information being recalled. To prevent this apparent information recall, in Fig. [3f](https://www.nature.com/articles/s41586-024-08392-y#Fig3) if the information recall is smaller than $1/\sqrt{N}$ we then set it explicitly to zero.

To examine Vector-HaSH’s performance on patterns with correlations, in Fig. [3e](https://www.nature.com/articles/s41586-024-08392-y#Fig3) we trained it on bw-mini-imagenet images using grid module sizes *λ*  = {3, 4, 5}, and layer sizes: *N* <sub>g</sub>  = 50, *N* <sub>h</sub>  = 400, *N* <sub>s</sub>  = 3,600. The plotted curve shows the mean-subtracted cosine similarity between recovered and stored patterns illustrating that Vector-HaSH shows gradual degradation as the number of stored patterns is increased. The resultant curve is an average over 5 runs with different sparse random projections *W* <sub>hg</sub>.

### Mapping, recall, and zero-shot inference in multiple spatial environments without catastrophic interference

Here we add a path-integration component to Vector-HaSH, that utilizes a velocity input to change the grid cell population activity akin to ref. [^8], such that the phase represented by each module changes in correspondence to the velocity input. Corresponding to the discrete hexagonal lattice space used to represent each grid module, for simplicity the velocity is assumed to have one of six directions, and magnitude is assumed to be fixed at a constant such that the phase of each grid module updates by a single lattice point in a single time-step. This input velocity vector, that we call a velocity-shift operator, $\overrightarrow{v}$, is thus represented by a six-dimensional one-hot encoded vector determining the direction of the shift.

In order to capture the inherent randomness and uncertainty present in real-world scenarios, a small amount of neuronal noise was introduced by adding random perturbations to the activation values of hippocampal cells in Vector-HaSH. This noise, generated from a uniform distribution between 0 and 0.1, mimics the fluctuations and disturbances observed in individual neurons, and corresponds to a noise magnitude of roughly 25% the magnitude of the hippocampal state vectors.

In Fig. [4a,c](https://www.nature.com/articles/s41586-024-08392-y#Fig4) we first demonstrate bidirectional recall of grid states from sensory inputs and vice versa. Here we consider Vector-HaSH with *λ*  = {3, 4, 5}, *N* <sub>g</sub>  = 50, *N* <sub>h</sub>  = 400, *N* <sub>s</sub>  = 3,600. We train the model on a total of 600 sensory inputs taken from bw-mini-imagenet (including the 4 landmarks placed in the room shown in Fig. [4c](https://www.nature.com/articles/s41586-024-08392-y#Fig4)). To demonstrate zero-shot recall in panel c, the model dynamics are simulated on a novel trajectory (right) through the same room with some locations overlapping with the previous trajectory. Note that the reconstructed landmarks do not have perfect recall. Instead, the reconstructions are degraded relative to the originally stored landmarks since the total number of stored landmarks in the model exceeds *N* <sub>h</sub>  = 400 (Fig. [2f](https://www.nature.com/articles/s41586-024-08392-y#Fig2)).

For all other panels of Fig. [4](https://www.nature.com/articles/s41586-024-08392-y#Fig4), we use Vector-HaSH with grid module periods *λ*  = {3, 4, 5, 7}, *N* <sub>g</sub>  = 99, *N* <sub>h</sub>  = 342, *γ*  = 0.1, and *θ*  = 2.5. The total capacity of this grid-coding space is 176,400 ≈ 2 × 10 <sup>5</sup>. Each room is stored by allocating a random 10 × 10 patch of the grid-coding space to it. This is constructed by first choosing any random point in the room to map to a randomly chosen area of the grid-coding space. Then as the model moves in the room, path integration correspondingly updates the grid phases in each grid module. The region of grid-coding space explored as the model physically explores a room is then the patch of grid-coding space storing the particular room.

To each of the 100 locations comprising a room, we simulate an independent sensory landmark as a binary {−1, 1} vectors. At initialization, before observing any room, we begin with a pre-trained memory scaffold, wherein the *W* <sub>hg</sub> and *W* <sub>gh</sub> matrices have already been constructed and trained corresponding to equations ([2](https://www.nature.com/articles/s41586-024-08392-y#Equ2)) and ([3](https://www.nature.com/articles/s41586-024-08392-y#Equ3)).

When first brought to a room, the grid state is initialized to the grid state vector corresponding to the random region of grid-coding space allocated to the room. Then, as path integration updates the grid state after moving around the room, the observed sensory landmark states are associated with the corresponding grid–hippocampal scaffold states through learning the *W* <sub>hs</sub> and *W* <sub>sh</sub> matrices following equations ([6](https://www.nature.com/articles/s41586-024-08392-y#Equ6)) and ([7](https://www.nature.com/articles/s41586-024-08392-y#Equ7)).

In the first two tests of each room (first tested right after each room has been learned, and then tested after all rooms have been learned; shown in Fig. [4d](https://www.nature.com/articles/s41586-024-08392-y#Fig4)) sensory landmark cues can be observed by Vector-HaSH. Using equation ([8](https://www.nature.com/articles/s41586-024-08392-y#Equ8)), the observed sensory landmarks can be used to reconstruct the hippocampal state, resulting in the reliably reconstructed hippocampal tuning curves as seen in Fig. [4e](https://www.nature.com/articles/s41586-024-08392-y#Fig4). For testing stable recall in dark (Fig. [4d,e](https://www.nature.com/articles/s41586-024-08392-y#Fig4)), Vector-HaSH is provided a random single sensory landmark cue from any given room. This landmark is used to ascertain the grid state corresponding to that landmark through equation ([8](https://www.nature.com/articles/s41586-024-08392-y#Equ8)). Thereafter, path integration is used to construct the grid–hippocampal scaffold state as room is explored in the absence of any further sensory cues. As seen in Fig. [4e](https://www.nature.com/articles/s41586-024-08392-y#Fig4), this also reliably reconstructs the hippocampal state at each location in every room.

In Fig. [4f](https://www.nature.com/articles/s41586-024-08392-y#Fig4), we examine the dark recall of 3,600-dimensional sensory landmarks in each room in a continual learning setting. Here we begin again with simply the pre-trained grid–hippocampal scaffold. As the *i* th room is explored, the sensory-hippocampal weight matrices are updated to store the thus far observed landmarks and their locations. At each step of exploration within the *i* th room, vVector-HaSH is queried on the current and all previous rooms as follows: for any completed room *j* (that is, 0 ≤  *j*  <  *i*), Vector-HaSH is dropped randomly anywhere in the room and allowed to observe the sensory landmark solely at that start location and no further sensory landmarks. Then the model moves around the room through path integration, and attempts to predict the sensory landmarks that would be observed at each location. We then compute the average MI recovered for each landmark at each position in the room, which is shown in Fig. [4f](https://www.nature.com/articles/s41586-024-08392-y#Fig4). For the partially completed room *i*, Vector-HaSH is similarly dropped randomly in the room, restricted to the set of previously observed locations within the room. The MI recovered during sensory prediction is similarly only evaluated over the previously observed portion of the room.

For the baseline model shown in Fig. [4f](https://www.nature.com/articles/s41586-024-08392-y#Fig4), we first construct the grid–hippocampal network through random hippocampal states with the same sparsity as those in Vector-HaSH, and bidirectional pseudoinverse learning between grid and hippocampal layers. Thereafter, the sensory landmarks are associated with the hippocampal layer as in Vector-HaSH described above, and this baseline model is subjected to an identical test protocol to examine continual learning. The number of nodes in the baseline model is kept identical to Vector-HaSH.

For Fig. [4h](https://www.nature.com/articles/s41586-024-08392-y#Fig4), we follow the same analysis as in the experiment [^72]. Dot product between PVs across all combinations of the 11 test rooms were computed. To construct the PVs, we record the activations of hippocampal cells for each of the 10 × 10 positions in the simulated room. We stack these into 100 composite PVs, 1 for each position in the room. To compute overlaps between representations, the activation of each hippocampal cell in any particular room was expressed as a ratio of its activation to the maximal activation of that cell across all rooms. The overlap was then calculated as the normalized dot product between the hippocampal cell activation vectors in 2 rooms, that is, the sum of the products of corresponding components divided by the total number of hippocampal cells (*N* <sub>h</sub>  = 342) for a given position/pixel, averaged over 100 positions. The colour-coded matrix in Fig. [4h](https://www.nature.com/articles/s41586-024-08392-y#Fig4) shows the average dot product values for PVs across rooms ($\left(\begin{array}{c}11\\ 2\end{array}\right)=55$ room pairs). Repeated exposures to three familiar rooms were also added to this analysis leading to a total of $\left(\begin{array}{c}14\\ 2\end{array}\right)=91$ room pairs.

For Fig. [4j](https://www.nature.com/articles/s41586-024-08392-y#Fig4), we plot the distribution of PV normalized dot products computed above (for multiple visits to all the rooms) and use this PDF to compute the corresponding cumulative distribution function. Similarly, the cumulative distribution functions for shuffled data are computed through the same procedure, but using shuffled data to compute the PV normalized dot products. Shuffled data are obtained either by random assignment of rate maps across rooms (shuffle room) or by shuffling of cell identities within rooms (shuffle cells) or by a combination of the two procedures (shuffle room and cells). The number of different shuffles generated in each case was 1,000.

### Extension of Vector-HaSH to continuous space

So far we have considered the grid states to be {0,1}-valued discretely varying modular one-hot states. This leads to a finite number of grid phases per module, and hence a finite number of grid PVs that can be exactly enumerated, leading to the wealth of theoretical advancements and results described above. To bring Vector-HaSH closer to biological realism, we constructed continuous-valued grid states (Fig. [4l](https://www.nature.com/articles/s41586-024-08392-y#Fig4)), as a Gaussian bump of activity on a two-dimensional lattice of neurons with periodic boundary conditions, similar to the one-hot states on a periodic lattice considered earlier (compare with Fig. [2b](https://www.nature.com/articles/s41586-024-08392-y#Fig2)). Continuous attractor dynamics were approximated through a circular mean to determine mean activity location, and reinitialization of a Gaussian bump centered at the calculated mean location. Since the number of phases in each module is now infinite (the Gaussian bump need not be centred on a neuron in the lattice) it is computationally challenging to demonstrate memory capacity results similar to our analysis for the discrete model above. As a proof of concept, we demonstrated landmark reconstruction from grid phases and vice versa in Fig. [4m](https://www.nature.com/articles/s41586-024-08392-y#Fig4).

For Fig. [4m](https://www.nature.com/articles/s41586-024-08392-y#Fig4), we used 3 grid modules, consisting of 81, 144 and 225 cells each. The Gaussian bump of activity in each module was constructed to have a standard deviation of 0.5.

We also used this continuous extension of Vector-HaSH in Fig. [6b,e–f](https://www.nature.com/articles/s41586-024-08392-y#Fig6). The results presented in Fig. [6f](https://www.nature.com/articles/s41586-024-08392-y#Fig6) are computed similarly to those in ref. [^60]. We first compute the temporal correlation between every pair of grid cells before and after hippocampal activation. We compute the correlation between these temporal correlations (shown by the vertical red dashed line). We then generate 1,000 random shuffles of the temporal correlations post hippocampal activation, and use these shuffles to generate a control distribution of the correlation between the temporal correlations (shown as the null distribution in black).

### Path learning in the hippocampal scaffold

Here again, we add a path-integration component to Vector-HaSH as described in the section above, such that a velocity-shift operator, $\overrightarrow{v}$, can be used to path integrate and update the grid cell population activity akin to ref. [^8], such that the phase represented by each module changes in correspondence to the input shift.

For learning of trajectories in space, this vector $\overrightarrow{v}$ is either associated with spatial locations and corresponding hippocampal state vectors (as in path learning) or with sensory landmark inputs (as in route learning).

All networks in Fig. [5j](https://www.nature.com/articles/s41586-024-08392-y#Fig5) were constructed to have approximately 5 × 10 <sup>5</sup> synapses, with network parameters identical to those in Fig. [3d](https://www.nature.com/articles/s41586-024-08392-y#Fig3). Figure [5i,j](https://www.nature.com/articles/s41586-024-08392-y#Fig5) considers random binary patterns, and Fig. [5g,h](https://www.nature.com/articles/s41586-024-08392-y#Fig5) considers bw-mini-imagenet images.

#### Path learning

Learning associations from the hippocampal layer directly to the velocity inputs through pseudoinverse learning would result in perfect recall for only *N* <sub>seq</sub>  ≤  *N* <sub>h</sub>, which may be much smaller than the grid-coding space, and would hence result in an incapability to recall very long sequences. To obtain higher capacity, we learn a map from the hippocampal cell state to the corresponding velocity inputs at that spatial location through a multi-layer perceptron, MLP. For all the results shown in Fig. [5c,d](https://www.nature.com/articles/s41586-024-08392-y#Fig5), left, for example, we use a single hidden layer in the MLP with 250 nodes. The dynamics of the network are as follows:

 $\overset{\rightarrow}{v} \left(t\right) = M L P \left[h \left(t\right)\right]$ 
$$
\overrightarrow{v}(t)={\rm{MLP}}[h(t)]
$$

(12)

 $g \left(t + 1\right) = P I \left[g \left(t\right) ; \overset{\rightarrow}{v} \left(t\right)\right]$ 
$$
g(t+1)={\rm{PI}}[\,g(t)\,;\overrightarrow{v}(t)]
$$

(13)

 $h \left(t + 2\right) = R e L U \left[W_{h g} g \left(t + 1\right) - \theta\right]$ 
$$
h(t+2)={\rm{R}}{\rm{e}}{\rm{L}}{\rm{U}}[{W}_{{\rm{h}}{\rm{g}}}\,g(t+1)-\theta ]
$$

(14)

 $s \left(t + 2\right) = s g n \left[W_{s h} h \left(t + 2\right)\right]$ 
$$
s(t+2)={\rm{sgn}}[{W}_{{\rm{sh}}}\,h(t+2)]
$$

(15)

Thus, when cued with a sensory state at the start of an episode, the sensory inputs to hippocampus reconstruct the corresponding hippocampal and grid states. Then, through the MLP, the hippocampal state projects to a low-dimensional velocity vector that is used to update the grid cells via path integration. From this updated grid state, the corresponding hippocampal state is constructed, which then reconstructs the next sensory pattern of the episode. The new hippocampal state also maps to the next velocity vector, that continues the iteration by updating the grid state. In this way, the memory scaffold along with the MLP successively construct grid and hippocampal states, and the heteroassociative weights to the sensory layer successively construct the memorized patterns of the episode.

#### Route learning

Since detailed sensory information cannot be recalled at very high capacities, route learning is performed by learning associations between the recollection of the sensory inputs at a location $\overrightarrow{x}$, and the velocity-shift vector $\overrightarrow{v}$ determining the direction of motion of the trajectory being learned at that location. This association can be learned directly through pseudoinverse learning as

 $W_{v s} = V S_{r}^{+} ,$ 
$$
{W}_{vs}=V{S}_{r}^{+},
$$

(16)

where, *S* <sub><i>r</i></sub> is a *N* <sub>s</sub>  ×  *N* <sub>seq</sub> -dimensional matrix with columns as the recalled sensory inputs ${s}_{\overrightarrow{x}}$, and *V* is a 6 ×  *N* <sub>seq</sub> -dimensional matrix with columns as the corresponding velocities. These associations can then be used to recall long trajectories through

 $\overset{\rightarrow}{v} \left(t\right) = W T A \left[W_{v s} s \left(t\right)\right]$ 
$$
\overrightarrow{v}(t)={\rm{WTA}}[{W}_{vs}\,s(t)]
$$

(17)

 $g \left(t + 1\right) = P I \left[g \left(t\right) ; \overset{\rightarrow}{v} \left(t\right)\right]$ 
$$
g(t+1)={\rm{PI}}[\,g(t)\,;\overrightarrow{v}(t)]
$$

(18)

 $h \left(t + 2\right) = R e L U \left[W_{h g} g \left(t + 1\right) - \theta\right]$ 
$$
h(t+2)={\rm{R}}{\rm{e}}{\rm{L}}{\rm{U}}[{W}_{{\rm{h}}{\rm{g}}}\,g(t+1)-\theta ]
$$

(19)

 $s \left(t + 2\right) = s g n \left[W_{s h} h \left(t + 2\right)\right]$ 
$$
s(t+2)={\rm{s}}{\rm{g}}{\rm{n}}[{W}_{{\rm{s}}{\rm{h}}}\,h(t+2)]
$$

(20)

As argued in Supplementary Information, section [D.9](https://www.nature.com/articles/s41586-024-08392-y#MOESM1), this results in perfect sequence recall for *N* <sub>seq</sub>  ≤  *N* <sub>s</sub>, which can scale as the exponentially large capacity of the grid-coding space. Note that the results in Supplementary Information, section [D.9](https://www.nature.com/articles/s41586-024-08392-y#MOESM1) rely on *S* <sub>r</sub> being a rank-ordered matrix. While this holds for random binary patterns through equation ([20](https://www.nature.com/articles/s41586-024-08392-y#Equ20)) applying a sign nonlinearity, this does not directly hold for continuous-valued sensory states, where no nonlinearity is necessary. In this case, we take the input sensory patterns, and apply an inverse sigmoid function to them before storage in the *W* <sub>sh</sub> matrix. Then, we use equation ([20](https://www.nature.com/articles/s41586-024-08392-y#Equ20)) with the sign nonlinearity replaced with the sigmoid nonlinearity. This application of the inverse sigmoid and then the sigmoid ensures that the final recovered states correspond to the inital patterns, but the sensory states are recovered through a nonlinear readout.

#### Reproducing entorhinal–hippocampal phenomenology

For Fig. [6e,f](https://www.nature.com/articles/s41586-024-08392-y#Fig6) we used the continuous extension of Vector-HaSH (see details in ‘Extension of Vector-HaSH to continuous space’). We describe the methods details for other panels below.

### Grid–hippocampal correlations

We follow in Fig. [6d](https://www.nature.com/articles/s41586-024-08392-y#Fig6) a similar analysis to ref. [^45]. We consider two 10 × 10 rooms. Then, we choose a hippocampal cell that is active in both rooms at some location. Then, we calculate the fraction of grid cells that are active at both of these locations, shown in red. Then, we generate 100 shuffles of all place cell PVs, and generate a control distribution of the fraction of grid cells that are co-active with these shuffled place cells shown as the black histogram.

### Goal and context-based remapping

When initialized in a new environment, we model the grid state population activity to be randomly initialized in the grid-coding space (a mechanistic model for such random initialization will be discussed in future work), that is, the grid state undergoes remapping. This grid-coding state, along with the corresponding hippocampal coding state and sensory observations at that location are then stored in the corresponding weight matrices, that is, *W* <sub>hs</sub> and *W* <sub>sh</sub>, via equations ([6](https://www.nature.com/articles/s41586-024-08392-y#Equ6)) and ([7](https://www.nature.com/articles/s41586-024-08392-y#Equ7)). When brought back to a previously seen environment, these weight matrices in Vector-HaSH use the observed sensory observations to drive the hippocampal cell (and thus grid cell) population activity to the state initialized at the first traversal of that environment.

Similar to new environments, we also model contextual information (such as goals, rewards, start-end location pairs) to be appended to the sensory inputs. We allow new contextual information to also trigger reinitialization of grid state, which then permits storage of multiple paths that involve the same spatial location, provided that they are distinguished by a contextual signal.

We use this set up of manual reinitialization of the grid state to reproduce the experimental observations of splitter cells [^62], route-dependent place cells [^63], directional place fields in one-dimensional environments [^64] and on directed routes in two-dimensional environments [^82] in Fig. [6g–j](https://www.nature.com/articles/s41586-024-08392-y#Fig6) and Supplementary Fig. [19](https://www.nature.com/articles/s41586-024-08392-y#MOESM1); and of directional place fields in a radial eight-arm maze [^82] in Supplementary Fig. [21](https://www.nature.com/articles/s41586-024-08392-y#MOESM1). In all of these cases, we first generate trajectories corresponding to the paths that the animals are constrained to traverse in the given experiment. These trajectories, are then stored in Vector-HaSH at a random location in the grid-coding space through a path learning mechanism. At new contextual cues, the grid state in the model is reinitialized and the agent then continues at a new location in the grid-coding space. This results in different spatial firing fields, irrespective of whether the agent is at the same spatial location as in a different previous context.

For all the simulations in Fig. [6g–j](https://www.nature.com/articles/s41586-024-08392-y#Fig6) and Supplementary Figs. [19](https://www.nature.com/articles/s41586-024-08392-y#MOESM1) and Fig. [21](https://www.nature.com/articles/s41586-024-08392-y#MOESM1), Vector-HaSH with *λ*  = {3, 4, 5, 7}, *N* <sub>h</sub>  = 500, *N* <sub>g</sub>  = 99, *θ*  = 2.5 and *γ*  = 0.10 was used. The total size of the grid-coding space is 420 × 420 ≈ 10 <sup>5</sup>. In order to capture the inherent randomness and uncertainty present in real-world scenarios, a small amount of neuronal noise was introduced by adding random perturbations to the activation values of hippocampal cells in Vector-HaSH. This noise, generated from a uniform distribution between 0 and 0.1, mimics the fluctuations and disturbances observed in individual neurons.

Splitter cells: For Fig. [6h](https://www.nature.com/articles/s41586-024-08392-y#Fig6), we follow an analysis method similar to the analysis done on the experimental data [^62]. The central stem is divided into four equal regions (Supplementary Fig. [22b](https://www.nature.com/articles/s41586-024-08392-y#MOESM1)), and the mean activation of every hippocampal cell is computed in each of the four regions. Supplementary Fig. [22c](https://www.nature.com/articles/s41586-024-08392-y#MOESM1) plots mean activations in each of the four regions, of cells that show different activity patterns as Vector-HaSH traverses the central stem on left-turn and right-turn trials. The ‘activation ratio’ on right-turn trials versus left-turn trials is then calculated for each cell in the region for which the given cell has maximum difference in activations. The distribution of these activation ratios is plotted in Fig. [6h](https://www.nature.com/articles/s41586-024-08392-y#Fig6), that shows the frequency distribution of cells with preferential firing associated with left-turn or right-turn trials. Note that the distribution of cells preferring left-turn and right-turn trials is approximately even. The percentage of hippocampal cells with non-differential firing was found to be ~3.896%, and the percentage of hippocampal cells with differential firing was found to be ~96.103% in Vector-HaSH (using a threshold of 2 on the activation ratio).

Route encoding: In Supplementary Fig. [19a,c](https://www.nature.com/articles/s41586-024-08392-y#MOESM1) we employed an ensemble analysis approach mirroring that used in ref. [^63] to validate if hippocampal cells demonstrate route-dependent activity. Our simulated session comprised 4 blocks, each representing one of 4 routes (0–3), with 11 trials per block. We performed ensemble analysis on the maze region common to all routes.

We compared the PV—activations of all hippocampal cells on an individual trajectory—to the average activation of these cells across all trajectories on each route (route-PV). Specifically, we compared the PVs for each trajectory to the average activation PVs (route-PVs) of all four routes, excluding the trajectory in consideration from its route-PV calculation to avoid bias.

Using cosine similarity, we assessed the likeness between each trajectory PV and each of the four route-PVs. We then calculated the fraction of correct matches (the highest similarity score was with its corresponding route-PV) and incorrect matches (a higher similarity score was with a different route-PV). The comparison results are shown in Supplementary Fig. [20a](https://www.nature.com/articles/s41586-024-08392-y#MOESM1), left.

We repeated the process 10,000 times with randomized data to estimate the chance probability of correct matches. We randomized the session data by shuffling trials across blocks, randomly assigning each trajectory to one of the four routes, thereby disrupting any correlation between the hippocampal cell activations and a specific route. Supplementary Fig. [20a](https://www.nature.com/articles/s41586-024-08392-y#MOESM1),right depicts a typical result from one such shuffle.

For each matrix element (*i*, *j*), we plotted the distribution of data from these 10,000 matrices in Supplementary Fig. [20b](https://www.nature.com/articles/s41586-024-08392-y#MOESM1). We then estimated the PDF from this distribution using a Gaussian kernel (Python’s scipy.stats.gaussian\_kde method). To gauge the chance probability of correct matches in our original, unshuffled analysis, we calculated the percentile position of our observed match proportion, referencing the same matrix element (*i*, *j*) from the unshuffled matrix in Supplementary Fig. [20a](https://www.nature.com/articles/s41586-024-08392-y#MOESM1).

Supplementary Fig. [19c](https://www.nature.com/articles/s41586-024-08392-y#MOESM1) presents the probability of correct matches in the unshuffled analysis based on these distributions from 10,000 shuffles. Low diagonal values indicate that trajectories significantly match only their corresponding route-PVs.

Directional cells: For Fig. [6j](https://www.nature.com/articles/s41586-024-08392-y#Fig6) and Supplementary Figs. [19d](https://www.nature.com/articles/s41586-024-08392-y#MOESM1) and [21](https://www.nature.com/articles/s41586-024-08392-y#MOESM1), the directionality index is defined similar to that defined for the experimental data analysis [^63],[^64]. Given the activation (*A*) of a hippocampal cell in positive and negative running directions (*A* <sub>+</sub> and *A* <sub>−</sub>), we define the directionality index as ∣ *A* <sub>+</sub>  −  *A* <sub>−</sub> ∣/∣ *A* <sub>+</sub>  +  *A* <sub>−</sub> ∣. By this definition, a directionality index of one indicates activity in one direction only, and a directionality index of zero indicates identical activity in both directions.

We use the same definition of directionality index to compute the directionality of the grid cells in Vector-HaSH, shown in Supplementary Fig. [24](https://www.nature.com/articles/s41586-024-08392-y#MOESM1).

### Multiple traces theory

In Fig. [6l–o](https://www.nature.com/articles/s41586-024-08392-y#Fig6), we consider Vector-HaSH with *λ*  = {3, 4, 5}, *N* <sub>g</sub>  = 50, *N* <sub>h</sub>  = 400, *N* <sub>s</sub>  = 3,600, *γ*  = 0.6, and *θ*  = 0.5. We use random binary patterns in Fig. [6n](https://www.nature.com/articles/s41586-024-08392-y#Fig6), right, [o](https://www.nature.com/articles/s41586-024-08392-y#Fig6), and bw-mini-imagenet patterns in Fig. [6m,n](https://www.nature.com/articles/s41586-024-08392-y#Fig6), left. The results are averaged over 20 runs. For sensory inputs presented multiple times, the sensory-hippocampal weights are reinforced multiple times using online pseudoinverse learning rule [^74], and the grid–hippocampal weights are reinforced multiple times using Hebbian learning (Fig. [6l](https://www.nature.com/articles/s41586-024-08392-y#Fig6)). The *W* <sub>hs</sub> weights are invariant to reinforcement due to the iterative pseudoinverse causing perfect hippocampal reconstruction from sensory inputs. Given a particular lesion size, the cells to be lesioned are randomly chosen from the set of all hippocampal cells, and their activation is set to zero. Sensory recovery error is defined as the mean L2-norm between the ground truth image and the image reconstructed by the model. During testing, the model receives the ground truth sensory image as input, and the reconstruction dynamics follow equations ([8](https://www.nature.com/articles/s41586-024-08392-y#Equ8))–([11](https://www.nature.com/articles/s41586-024-08392-y#Equ11)). Additional results from each layer of Vector-HaSH while testing the Multiple-Trace Theory are shown in Supplementary Fig. [16](https://www.nature.com/articles/s41586-024-08392-y#MOESM1), right. Furthermore, Supplementary Fig. [16](https://www.nature.com/articles/s41586-024-08392-y#MOESM1), left shows the results when only *W* <sub>sh</sub> weights are reinforced, assuming pre-trained scaffold weights *W* <sub>gh</sub>. In both case, same parameter settings were used as in Fig. [6n](https://www.nature.com/articles/s41586-024-08392-y#Fig6), right and Fig. [6o](https://www.nature.com/articles/s41586-024-08392-y#Fig6).

#### Parameter values

Figure [2](https://www.nature.com/articles/s41586-024-08392-y#Fig2): across all panels: *γ*  = 0.6, *θ*  = 0.5. Stable states counted if they can correct noise of magnitude 20% of the typical hippocampal state magnitude, and requiring dynamics to return to within 0.6% of the original hippocampal state. Figure [2e,f](https://www.nature.com/articles/s41586-024-08392-y#Fig2) use three modules with *λ*  = {3, 4, 5} and *N* <sub>h</sub>  = 400.

Figure [3](https://www.nature.com/articles/s41586-024-08392-y#Fig3): across all panels: *γ*  = 0.6, *θ*  = 0.5. In Fig. [3b,e,i](https://www.nature.com/articles/s41586-024-08392-y#Fig3), *λ*  = {3, 4, 5}, *N* <sub>g</sub>  = 50, *N* <sub>s</sub>  = 3,600. In Fig. [3c,e,f, right,i](https://www.nature.com/articles/s41586-024-08392-y#Fig3), *N* <sub>h</sub>  = 400. Capacity is computed in Fig. [3f](https://www.nature.com/articles/s41586-024-08392-y#Fig3) through injecting 2.5% noise in the sensory inputs, and demanding perfect (0 error) recall. In Fig. [3d](https://www.nature.com/articles/s41586-024-08392-y#Fig3), all shown networks have ~5 × 10 <sup>5</sup> synapses, with Vector-HaSH module periods *λ*  = {2, 3, 5}, and layer sizes: *N* <sub>g</sub>  = 38, *N* <sub>h</sub>  = 275, *N* <sub>s</sub>  = 900. Number of nodes in other networks are as follows: (1) Hopfield network of size *N* = 708, synapses = *N* <sup>2</sup>. (2) Pseudoinverse Hopfield network of size *N*  = 708, synapses =  *N* <sup>2</sup>. (3) Hopfield network with bounded synapses was trained with Hebbian learning on sequentially seen patterns. Size of the network *N*  = 708, synapses =  *N* <sup>2</sup>. (4) Sparse Hopfield network (with sparse inputs) with a network size of *N*  = 708, synapses =  *N* <sup>2</sup>, sparsity = 100(1 −  *p*). (5) Sparse Hopfield network. Size of the network *N*, synapse dilution *κ*, synapses =  *κ*  ×  *N* <sup>2</sup>  = 10 <sup>5</sup>. (6) Tail-biting overparameterized autoencoder [^55] with network layer sizes 900, 275, 38, 275, 900.

Figure [4](https://www.nature.com/articles/s41586-024-08392-y#Fig4): across all panels: *γ*  = 0.1, *θ*  = 2.5. Figure [4a,c](https://www.nature.com/articles/s41586-024-08392-y#Fig4) used *λ*  = {3, 4, 5}, *N* <sub>h</sub>  = 400 and *N* <sub>s</sub>  = 3,600. In Fig. [4m](https://www.nature.com/articles/s41586-024-08392-y#Fig4), we used 3 grid modules, consisting of 81, 144 and 225 cells each, and *N* <sub>h</sub>  = 1,000. The Gaussian bump of activity had standard deviation of 0.5. All other panels in Fig. [4](https://www.nature.com/articles/s41586-024-08392-y#Fig4) used *λ*  = {3, 4, 5, 7}, *N* <sub>h</sub>  = 342. In Fig. [4c](https://www.nature.com/articles/s41586-024-08392-y#Fig4), we show the model 596 other landmarks before observing the 4 shown landmarks.

Figure [5a, left,b–e](https://www.nature.com/articles/s41586-024-08392-y#Fig5) used *λ*  = {5, 9, 13}, *γ*  = 0.6, *θ*  = 0.5, *N* <sub>h</sub>  = 500. Figure [5a, right,g](https://www.nature.com/articles/s41586-024-08392-y#Fig5) used *λ*  = {3, 4, 5}, *N* <sub>h</sub>  = 400, *N* <sub>s</sub>  = 36,00. Hopfield network in Fig. [5h](https://www.nature.com/articles/s41586-024-08392-y#Fig5) used 3,600 nodes. Figure [5g,h](https://www.nature.com/articles/s41586-024-08392-y#Fig5) stored a sequence of length 1,000. Figure [5i](https://www.nature.com/articles/s41586-024-08392-y#Fig5) also used *N* <sub>h</sub>  = 400. Figure [5a,c,d, left,e](https://www.nature.com/articles/s41586-024-08392-y#Fig5) used 250 MLP nodes. Parameters used in Fig. [5j](https://www.nature.com/articles/s41586-024-08392-y#Fig5) were identical to those used in Fig. [3d](https://www.nature.com/articles/s41586-024-08392-y#Fig3).

Figure [6](https://www.nature.com/articles/s41586-024-08392-y#Fig6): all panels used *γ* = 0.1, *θ* = 2.5. Figure [6b,e,f](https://www.nature.com/articles/s41586-024-08392-y#Fig6) used the continuous version of Vector-HaSH, using the same parameters as Fig. [4k,m](https://www.nature.com/articles/s41586-024-08392-y#Fig4). All other panels in Fig. [6](https://www.nature.com/articles/s41586-024-08392-y#Fig6) used *λ*  = {3, 4, 5}, *N* <sub>h</sub>  = 400, *N* <sub>s</sub>  = 3,600.

Figure [7](https://www.nature.com/articles/s41586-024-08392-y#Fig7): all panels used *λ*  = {4, 5, 7}, *N* <sub>h</sub>  = 400, *γ*  = 0.6, *θ*  = 0.5. The mnemonic input layer had 3,600 nodes.

### Reporting summary

Further information on research design is available in the [Nature Portfolio Reporting Summary](https://www.nature.com/articles/s41586-024-08392-y#MOESM2) linked to this article.

## Data availability

Data were collecting by running the codes available at [https://github.com/FieteLab](https://github.com/FieteLab).

## Code availability

Codes used to run the model and analyse data are available at [https://github.com/FieteLab](https://github.com/FieteLab).

## References

## Acknowledgements

This work was supported by ONR award N00014-19-1-2584, by NSF-CISE award IIS-2151077 under the Robust Intelligence programme, by the ARO-MURI award W911NF-23-1-0277, by the Simons Foundation SCGB programme 1181110, and the K. Lisa Yang ICoN Center.

## Ethics declarations

### Competing interests

The authors declare no competing interests

## Peer review

### Peer review information

*Nature* thanks Dori Derdikman, Christian Machens and Cristina Savin for their contribution to the peer review of this work. Peer review reports are available.

## Additional information

**Publisher’s note** Springer Nature remains neutral with regard to jurisdictional claims in published maps and institutional affiliations.

## Extended data figures and tables

### Extended Data Fig. 1 Critical number of hippocampal cells necessary to support all scaffold fixed points is asymptotically independent of the number of grid cells.

For a given number of modules, the critical number of hippocampal cells, ${N}_{h}^{* }$ increases slowly with the number of grid cells, but then asymptotically approaches a constant, as expected from the theoretical results in Sec. [C.1](https://www.nature.com/articles/s41586-024-08392-y#MOESM1).

### Extended Data Fig. 2 Learning generalization approaches theoretical expectations with increasing Nh.

The number of generated fixed points approaches the maximal scaffold capacity for a very small number of learned patterns (see also Fig. [2f](https://www.nature.com/articles/s41586-024-08392-y#Fig2)). As the number of hippocampal cells increases, the number of learning patterns necessary for complete generalization approaches the theoretical expectation of *M* × *K* <sub><i>m</i> <i>a</i> <i>x</i></sub>, as proved in SI Sec. [C.4](https://www.nature.com/articles/s41586-024-08392-y#MOESM1).

### Extended Data Fig. 3 Hebbian learning between sensory layer and scaffold also produces memory continuum.

A memory continuum is obtained in Vector-HaSH even if the weights between the sensory and hippocampal layers are bi-directionally trained using Hebbian learning (instead of pseudoinverse learning, as in Fig. [3](https://www.nature.com/articles/s41586-024-08392-y#Fig3). This continuum is also asymptotically proportional to the theoretical bound on memory capacity (forest green dashed line indicative of slope of theoretical upper bound, vertical and horizontal position of dashed line is arbitrary). However, the proportionality constant is lower, with the gradual degradation of information recall occurring well before *N* <sub><i>h</i></sub>. Vector-HaSH parameters identical to Fig. [3c](https://www.nature.com/articles/s41586-024-08392-y#Fig3) with *λ* = {3, 4, 5}.

## Rights and permissions

Springer Nature or its licensor (e.g. a society or other partner) holds exclusive rights to this article under a publishing agreement with the author(s) or other rightsholder(s); author self-archiving of the accepted manuscript version of this article is solely governed by the terms of such publishing agreement and applicable law.

[^1]: Scoville, WilliamBeecher & Milner, B. Loss of recent memory after bilateral hippocampal lesions. *J. Neurol. Neurosurg. Psychiatry* **20**, 11 (1957).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=13406589) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC497229) [MATH](http://www.emis.de/MATH-item?1435.00044) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaG2s%2Flt1yksA%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Loss%20of%20recent%20memory%20after%20bilateral%20hippocampal%20lesions&journal=J.%20Neurol.%20Neurosurg.%20Psychiatry&volume=20&publication_year=1957&author=Scoville%2CWilliamBeecher&author=Milner%2CB)

[^2]: O’Keefe, J. & Dostrovsky, J. The hippocampus as a spatial map. preliminary evidence from unit activity in the freely-moving rat. *Brain Res.* **34**, 171–175 (1971).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=5124915) [MATH](http://www.emis.de/MATH-item?1121.92044) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20hippocampus%20as%20a%20spatial%20map.%20preliminary%20evidence%20from%20unit%20activity%20in%20the%20freely-moving%20rat&journal=Brain%20Res.&volume=34&pages=171-175&publication_year=1971&author=O%E2%80%99Keefe%2CJ&author=Dostrovsky%2CJ)

[^3]: Hafting, T., Fyhn, M., Molden, S., Moser, M.-B. & Moser, E. I. Microstructure of a spatial map in the entorhinal cortex. *Nature* **436**, 801–806 (2005).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=15965463) [MATH](http://www.emis.de/MATH-item?1124.53028) [ADS](http://adsabs.harvard.edu/cgi-bin/nph-data_query?link_type=ABSTRACT&bibcode=2005Natur.436..801H) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD2MXnt1Siurk%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Microstructure%20of%20a%20spatial%20map%20in%20the%20entorhinal%20cortex&journal=Nature&volume=436&pages=801-806&publication_year=2005&author=Hafting%2CT&author=Fyhn%2CM&author=Molden%2CS&author=Moser%2CM-B&author=Moser%2CEI)

[^4]: Solstad, T., Boccara, C. N., Kropff, E., Moser, May-Britt & Moser, E. I. Representation of geometric borders in the entorhinal cortex. *Science* **322**, 1865–1868 (2008).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=19095945) [MATH](http://www.emis.de/MATH-item?1262.42002) [ADS](http://adsabs.harvard.edu/cgi-bin/nph-data_query?link_type=ABSTRACT&bibcode=2008Sci...322.1865S) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD1cXhsFSmtrbJ) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Representation%20of%20geometric%20borders%20in%20the%20entorhinal%20cortex&journal=Science&volume=322&pages=1865-1868&publication_year=2008&author=Solstad%2CT&author=Boccara%2CCN&author=Kropff%2CE&author=Moser%2CMay-Britt&author=Moser%2CEI)

[^5]: Lever, C., Burton, S., Jeewajee, A., O’Keefe, J. & Burgess, N. Boundary vector cells in the subiculum of the hippocampal formation. *J. Neurosci.* **29**, 9771–9777 (2009).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=19657030) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2736390) [MATH](http://www.emis.de/MATH-item?1105.92322) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD1MXpvFOmur4%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Boundary%20vector%20cells%20in%20the%20subiculum%20of%20the%20hippocampal%20formation&journal=J.%20Neurosci.&volume=29&pages=9771-9777&publication_year=2009&author=Lever%2CC&author=Burton%2CS&author=Jeewajee%2CA&author=O%E2%80%99Keefe%2CJ&author=Burgess%2CN)

[^6]: Samsonovich, A. & McNaughton, B. L. Path integration and cognitive mapping in a continuous attractor neural network model. *J. Neurosci.* **17**, 5900–5920 (1997).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=9221787) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6573219) [MATH](http://www.emis.de/MATH-item?1530.35085) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DyaK2sXkvFymsr8%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Path%20integration%20and%20cognitive%20mapping%20in%20a%20continuous%20attractor%20neural%20network%20model&journal=J.%20Neurosci.&volume=17&pages=5900-5920&publication_year=1997&author=Samsonovich%2CA&author=McNaughton%2CBL)

[^7]: Hasselmo, M. E. A model of episodic memory: mental time travel along encoded trajectories using grid cells. *Neurobiol. Learn. Mem.* **92**, 559–573 (2009).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=19615456) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2825051) [MATH](http://www.emis.de/MATH-item?1007.68909) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20model%20of%20episodic%20memory%3A%20mental%20time%20travel%20along%20encoded%20trajectories%20using%20grid%20cells&journal=Neurobiol.%20Learn.%20Mem.&volume=92&pages=559-573&publication_year=2009&author=Hasselmo%2CME)

[^8]: Burak, Y. & Fiete, I. R. Accurate path integration in continuous attractor network models of grid cells. *PLoS Comput. Biol.* **5**, e1000291 (2009).

[MathSciNet](http://www.ams.org/mathscinet-getitem?mr=2496586) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=19229307) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2632741) [MATH](http://www.emis.de/MATH-item?1188.90203) [ADS](http://adsabs.harvard.edu/cgi-bin/nph-data_query?link_type=ABSTRACT&bibcode=2009PLSCB...5E0291B) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Accurate%20path%20integration%20in%20continuous%20attractor%20network%20models%20of%20grid%20cells&journal=PLoS%20Comput.%20Biol.&volume=5&publication_year=2009&author=Burak%2CY&author=Fiete%2CIR)

[^9]: Stachenfeld, K. L., Botvinick, M. M. & Gershman, S. J. The hippocampus as a predictive map. *Nat. Neurosci.* **20**, 1643–1653 (2017).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=28967910) [MATH](http://www.emis.de/MATH-item?0616.62073) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2sXhsFylurrF) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20hippocampus%20as%20a%20predictive%20map&journal=Nat.%20Neurosci.&volume=20&pages=1643-1653&publication_year=2017&author=Stachenfeld%2CKL&author=Botvinick%2CMM&author=Gershman%2CSJ)

[^10]: Agmon, H. & Burak, Y. A theory of joint attractor dynamics in the hippocampus and the entorhinal cortex accounts for artificial remapping and grid cell field-to-field variability. *eLife* **9**, e56894 (2020).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=32779570) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC7447444) [MATH](http://www.emis.de/MATH-item?07676734) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB3cXitlOis7%2FO) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20theory%20of%20joint%20attractor%20dynamics%20in%20the%20hippocampus%20and%20the%20entorhinal%20cortex%20accounts%20for%20artificial%20remapping%20and%20grid%20cell%20field-to-field%20variability&journal=eLife&volume=9&publication_year=2020&author=Agmon%2CH&author=Burak%2CY)

[^11]: Abu-Mostafa, Y. S. & St Jacques, J. Information capacity of the hopfield model. *IEEE Trans. Inf. Theory* **31**, 461–464 (1985).

[MATH](http://www.emis.de/MATH-item?0571.94030) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Information%20capacity%20of%20the%20hopfield%20model&journal=IEEE%20Trans.%20Inf.%20Theory&volume=31&pages=461-464&publication_year=1985&author=Abu-Mostafa%2CYS&author=Jacques%2CJ)

[^12]: Gardner, E. The space of interactions in neural network models. *J. Phys. A* **21**, 257–270 (1988).

[MathSciNet](http://www.ams.org/mathscinet-getitem?mr=939730) [MATH](http://www.emis.de/MATH-item?1128.82302) [ADS](http://adsabs.harvard.edu/cgi-bin/nph-data_query?link_type=ABSTRACT&bibcode=1988JPhA...21..257G) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20space%20of%20interactions%20in%20neural%20network%20models&journal=J.%20Phys.%20A&volume=21&pages=257-270&publication_year=1988&author=Gardner%2CE)

[^13]: Yates, F. A. *The Art of Memory* (Routledge & Kegan Paul, 1966).

[^14]: Proust, M. *À la Recherche du Temps Perdu* (Grasset, 1913).

[^15]: Reed, J. M. & Squire, L. R. Impaired recognition memory in patients with lesions limited to the hippocampal formation. *Behav. Neurosci.* **111**, 667 (1997).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=9267644) [MATH](http://www.emis.de/MATH-item?1247.03091) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaK2svhtlSjsw%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Impaired%20recognition%20memory%20in%20patients%20with%20lesions%20limited%20to%20the%20hippocampal%20formation&journal=Behav.%20Neurosci.&volume=111&publication_year=1997&author=Reed%2CJM&author=Squire%2CLR)

[^16]: Zola, S. M. et al. Impaired recognition memory in monkeys after damage limited to the hippocampal region. *J. Neurosci.* **20**, 451–463 (2000).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=10627621) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6774137) [MATH](http://www.emis.de/MATH-item?1046.65501) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD3cXhtF2hs7g%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Impaired%20recognition%20memory%20in%20monkeys%20after%20damage%20limited%20to%20the%20hippocampal%20region&journal=J.%20Neurosci.&volume=20&pages=451-463&publication_year=2000&author=Zola%2CSM)

[^17]: Manns, J. R., Hopkins, R. O., Reed, J. M., Kitchener, E. G. & Squire, L. R. Recognition memory and the human hippocampus. *Neuron* **37**, 171–180 (2003).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=12526782) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD3sXmtFGmug%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Recognition%20memory%20and%20the%20human%20hippocampus&journal=Neuron&volume=37&pages=171-180&publication_year=2003&author=Manns%2CJR&author=Hopkins%2CRO&author=Reed%2CJM&author=Kitchener%2CEG&author=Squire%2CLR)

[^18]: Eichenbaum, H. On the integration of space, time, and memory. *Neuron* **95**, 1007–1018 (2017).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=28858612) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5662113) [MATH](http://www.emis.de/MATH-item?1372.35178) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2sXhsVWmtLjN) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=On%20the%20integration%20of%20space%2C%20time%2C%20and%20memory&journal=Neuron&volume=95&pages=1007-1018&publication_year=2017&author=Eichenbaum%2CH)

[^19]: Taube, J. S., Muller, R. U. & Ranck, J. B. Head-direction cells recorded from the postsubiculum in freely moving rats. i. description and quantitative analysis. *J. Neurosci.* **10**, 420–435 (1990).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=2303851) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6570151) [MATH](http://www.emis.de/MATH-item?0742.51004) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaK3c7lsFCisA%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Head-direction%20cells%20recorded%20from%20the%20postsubiculum%20in%20freely%20moving%20rats.%20i.%20description%20and%20quantitative%20analysis&journal=J.%20Neurosci.&volume=10&pages=420-435&publication_year=1990&author=Taube%2CJS&author=Muller%2CRU&author=Ranck%2CJB)

[^20]: Lee, A. K. & Wilson, M. A. Memory of sequential experience in the hippocampus during slow wave sleep. *Neuron* **36**, 1183–1194 (2002).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=12495631) [MATH](http://www.emis.de/MATH-item?1444.90049) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD3sXhtVOnsw%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Memory%20of%20sequential%20experience%20in%20the%20hippocampus%20during%20slow%20wave%20sleep&journal=Neuron&volume=36&pages=1183-1194&publication_year=2002&author=Lee%2CAK&author=Wilson%2CMA)

[^21]: Fenton, AndréA. et al. Unmasking the CA1 ensemble place code by exposures to small and large environments: more place cells and multiple, irregularly arranged, and expanded place fields in the larger space. *J. Neurosci.* **28**, 11250–11262 (2008).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=18971467) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2695947) [MATH](http://www.emis.de/MATH-item?1491.03043) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD1cXhtlGltrfK) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Unmasking%20the%20CA1%20ensemble%20place%20code%20by%20exposures%20to%20small%20and%20large%20environments%3A%20more%20place%20cells%20and%20multiple%2C%20irregularly%20arranged%2C%20and%20expanded%20place%20fields%20in%20the%20larger%20space&journal=J.%20Neurosci.&volume=28&pages=11250-11262&publication_year=2008&author=Fenton%2CAndr%C3%A9A)

[^22]: Colgin, LauraLee et al. Frequency of gamma oscillations routes flow of information in the hippocampus. *Nature* **462**, 353–357 (2009).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=19924214) [MATH](http://www.emis.de/MATH-item?1156.91351) [ADS](http://adsabs.harvard.edu/cgi-bin/nph-data_query?link_type=ABSTRACT&bibcode=2009Natur.462..353C) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD1MXhsVeqtrfN) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Frequency%20of%20gamma%20oscillations%20routes%20flow%20of%20information%20in%20the%20hippocampus&journal=Nature&volume=462&pages=353-357&publication_year=2009&author=Colgin%2CLauraLee)

[^23]: Stensola, H. et al. The entorhinal grid map is discretized. *Nature* **492**, 72–78 (2012).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=23222610) [ADS](http://adsabs.harvard.edu/cgi-bin/nph-data_query?link_type=ABSTRACT&bibcode=2012Natur.492...72S) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC38XhslyntbvF) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20entorhinal%20grid%20map%20is%20discretized&journal=Nature&volume=492&pages=72-78&publication_year=2012&author=Stensola%2CH)

[^24]: Buzsáki, György & Moser, E. I. Memory, navigation and theta rhythm in the hippocampal–entorhinal system. *Nat. Neurosci.* **16**, 130–138 (2013).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=23354386) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4079500) [MATH](http://www.emis.de/MATH-item?1204.92017) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Memory%2C%20navigation%20and%20theta%20rhythm%20in%20the%20hippocampal%E2%80%93entorhinal%20system&journal=Nat.%20Neurosci.&volume=16&pages=130-138&publication_year=2013&author=Buzs%C3%A1ki%2CGy%C3%B6rgy&author=Moser%2CEI)

[^25]: Hopfield, J. J. Neurons with graded response have collective computational properties like those of two-state neurons. *Proc. Natl Acad. Sci. USA* **81**, 3088–3092 (1984).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=6587342) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC345226) [MATH](http://www.emis.de/MATH-item?1371.92015) [ADS](http://adsabs.harvard.edu/cgi-bin/nph-data_query?link_type=ABSTRACT&bibcode=1984PNAS...81.3088H) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaL2c3itF2jug%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Neurons%20with%20graded%20response%20have%20collective%20computational%20properties%20like%20those%20of%20two-state%20neurons&journal=Proc.%20Natl%20Acad.%20Sci.%20USA&volume=81&pages=3088-3092&publication_year=1984&author=Hopfield%2CJJ)

[^26]: Marr, D., Willshaw, D. & McNaughton, B. *Simple Memory: A Theory for Archicortex* (Springer, 1991).

[^27]: Skaggs, W., Knierim, J., Kudrimoti, H. & McNaughton, B. A model of the neural basis of the rat’s sense of direction. *Adv. Neural Inf. Process. Syst.* **7**, 173–180 (1995).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=11539168) [MATH](http://www.emis.de/MATH-item?0711.35068) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DC%2BD3MnlslOgsw%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20model%20of%20the%20neural%20basis%20of%20the%20rat%E2%80%99s%20sense%20of%20direction&journal=Adv.%20Neural%20Inf.%20Process.%20Syst.&volume=7&pages=173-180&publication_year=1995&author=Skaggs%2CW&author=Knierim%2CJ&author=Kudrimoti%2CH&author=McNaughton%2CB)

[^28]: Burgess, N., Recce, M. & O’Keefe, J. A model of hippocampal function. *Neural Netw.* **7**, 1065–1081 (1994).

[MATH](http://www.emis.de/MATH-item?0825.92052) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20model%20of%20hippocampal%20function&journal=Neural%20Netw.&volume=7&pages=1065-1081&publication_year=1994&author=Burgess%2CN&author=Recce%2CM&author=O%E2%80%99Keefe%2CJ)

[^29]: McClelland, J. L., McNaughton, B. L. & O’Reilly, R. C. Why there are complementary learning systems in the hippocampus and neocortex: insights from the successes and failures of connectionist models of learning and memory. *Psychol. Rev.* **102**, 419 (1995).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=7624455) [MATH](http://www.emis.de/MATH-item?0843.30006) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Why%20there%20are%20complementary%20learning%20systems%20in%20the%20hippocampus%20and%20neocortex%3A%20insights%20from%20the%20successes%20and%20failures%20of%20connectionist%20models%20of%20learning%20and%20memory&journal=Psychol.%20Rev.&volume=102&publication_year=1995&author=McClelland%2CJL&author=McNaughton%2CBL&author=O%E2%80%99Reilly%2CRC)

[^30]: Brun, V. H. et al. Place cells and place recognition maintained by direct entorhinal–hippocampal circuitry. *Science* **296**, 2243–2246 (2002).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=12077421) [MATH](http://www.emis.de/MATH-item?1015.78508) [ADS](http://adsabs.harvard.edu/cgi-bin/nph-data_query?link_type=ABSTRACT&bibcode=2002Sci...296.2243B) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD38XkvFGht7s%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Place%20cells%20and%20place%20recognition%20maintained%20by%20direct%20entorhinal%E2%80%93hippocampal%20circuitry&journal=Science&volume=296&pages=2243-2246&publication_year=2002&author=Brun%2CVH)

[^31]: Hartley, T., Burgess, N., Lever, C., Cacucci, F. & O’keefe, J. Modeling place fields in terms of the cortical inputs to the hippocampus. *Hippocampus* **10**, 369–379 (2000).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=10985276) [MATH](http://www.emis.de/MATH-item?1105.92322) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DC%2BD3M%2FmsFCiuw%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Modeling%20place%20fields%20in%20terms%20of%20the%20cortical%20inputs%20to%20the%20hippocampus&journal=Hippocampus&volume=10&pages=369-379&publication_year=2000&author=Hartley%2CT&author=Burgess%2CN&author=Lever%2CC&author=Cacucci%2CF&author=O%E2%80%99keefe%2CJ)

[^32]: Sreenivasan, S. & Fiete, I. Grid cells generate an analog error-correcting code for singularly precise neural computation. *Nat. Neurosci.* **14**, 1330–1337 (2011).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=21909090) [MATH](http://www.emis.de/MATH-item?1237.05202) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC3MXhtFGnurnE) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Grid%20cells%20generate%20an%20analog%20error-correcting%20code%20for%20singularly%20precise%20neural%20computation&journal=Nat.%20Neurosci.&volume=14&pages=1330-1337&publication_year=2011&author=Sreenivasan%2CS&author=Fiete%2CI)

[^33]: Yoon, Ki. Jung et al. Specific evidence of low-dimensional continuous attractor dynamics in grid cells. *Nat. Neurosci.* **16**, 1077–1084 (2013).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=23852111) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3797513) [MATH](http://www.emis.de/MATH-item?1329.47020) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC3sXhtFShsr%2FI) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Specific%20evidence%20of%20low-dimensional%20continuous%20attractor%20dynamics%20in%20grid%20cells&journal=Nat.%20Neurosci.&volume=16&pages=1077-1084&publication_year=2013&author=Yoon%2CKiJung)

[^34]: Yoon, K., Lewallen, S., Kinkhabwala, A. A., Tank, D. W. & Fiete, I. R. Grid cell responses in 1D environments assessed as slices through a 2D lattice. *Neuron* **89**, 1086–1099 (2016).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=26898777) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5507689) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC28XivVGku7o%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Grid%20cell%20responses%20in%201D%20environments%20assessed%20as%20slices%20through%20a%202D%20lattice&journal=Neuron&volume=89&pages=1086-1099&publication_year=2016&author=Yoon%2CK&author=Lewallen%2CS&author=Kinkhabwala%2CAA&author=Tank%2CDW&author=Fiete%2CIR)

[^35]: Solstad, T., Moser, E. I. & Einevoll, G. T. From grid cells to place cells: a mathematical model. *Hippocampus* **16**, 1026–1031 (2006).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=17094145) [MATH](http://www.emis.de/MATH-item?1436.62139) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=From%20grid%20cells%20to%20place%20cells%3A%20a%20mathematical%20model&journal=Hippocampus&volume=16&pages=1026-1031&publication_year=2006&author=Solstad%2CT&author=Moser%2CEI&author=Einevoll%2CGT)

[^36]: Trettel, S. G., Trimper, J. B., Hwaun, E., Fiete, I. R. & Colgin, L. L. Grid cell co-activity patterns during sleep reflect spatial overlap of grid fields during active behaviors. *Nat. Neurosci.* **22**, 609–617 (2019).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=30911183) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC7412059) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1MXotl2qtbk%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Grid%20cell%20co-activity%20patterns%20during%20sleep%20reflect%20spatial%20overlap%20of%20grid%20fields%20during%20active%20behaviors&journal=Nat.%20Neurosci.&volume=22&pages=609-617&publication_year=2019&author=Trettel%2CSG&author=Trimper%2CJB&author=Hwaun%2CE&author=Fiete%2CIR&author=Colgin%2CLL)

[^37]: Gardner, R. J. et al. Toroidal topology of population activity in grid cells. *Nature* **602**, 123–128 (2022).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=35022611) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC8810387) [MATH](http://www.emis.de/MATH-item?0946.65515) [ADS](http://adsabs.harvard.edu/cgi-bin/nph-data_query?link_type=ABSTRACT&bibcode=2022Natur.602..123G) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB38XhtVOlt7s%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Toroidal%20topology%20of%20population%20activity%20in%20grid%20cells&journal=Nature&volume=602&pages=123-128&publication_year=2022&author=Gardner%2CRJ)

[^38]: Gardner, R. J., Lu, L., Wernle, T., Moser, May-Britt & Moser, E. I. Correlation structure of grid cells is preserved during sleep. *Nat. Neurosci.* **22**, 598–608 (2019).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=30911185) [MATH](http://www.emis.de/MATH-item?1407.49002) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1MXotl2qtbc%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Correlation%20structure%20of%20grid%20cells%20is%20preserved%20during%20sleep&journal=Nat.%20Neurosci.&volume=22&pages=598-608&publication_year=2019&author=Gardner%2CRJ&author=Lu%2CL&author=Wernle%2CT&author=Moser%2CMay-Britt&author=Moser%2CEI)

[^39]: O’Reilly, R. C., Bhattacharyya, R., Howard, M. D. & Ketz, N. Complementary learning systems. *Cogn. Sci.* **38**, 1229–1248 (2014).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=22141588) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Complementary%20learning%20systems&journal=Cogn.%20Sci.&volume=38&pages=1229-1248&publication_year=2014&author=O%E2%80%99Reilly%2CRC&author=Bhattacharyya%2CR&author=Howard%2CMD&author=Ketz%2CN)

[^40]: Hardcastle, K., Ganguli, S. & Giocomo, L. M. Environmental boundaries as an error correction mechanism for grid cells. *Neuron* **86**, 827–839 (2015).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=25892299) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2MXms1ynsLo%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Environmental%20boundaries%20as%20an%20error%20correction%20mechanism%20for%20grid%20cells&journal=Neuron&volume=86&pages=827-839&publication_year=2015&author=Hardcastle%2CK&author=Ganguli%2CS&author=Giocomo%2CLM)

[^41]: Dordek, Y., Soudry, D., Meir, R. & Derdikman, D. Extracting grid cell characteristics from place cell inputs using non-negative principal component analysis. *eLife* **5**, e10094 (2016).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=26952211) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4841785) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Extracting%20grid%20cell%20characteristics%20from%20place%20cell%20inputs%20using%20non-negative%20principal%20component%20analysis&journal=eLife&volume=5&publication_year=2016&author=Dordek%2CY&author=Soudry%2CD&author=Meir%2CR&author=Derdikman%2CD)

[^42]: Keinath, A. T., Epstein, R. A. & Balasubramanian, V. Environmental deformations dynamically shift the grid cell spatial metric. *eLife* **7**, e38169 (2018).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=30346272) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6203432) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Environmental%20deformations%20dynamically%20shift%20the%20grid%20cell%20spatial%20metric&journal=eLife&volume=7&publication_year=2018&author=Keinath%2CAT&author=Epstein%2CRA&author=Balasubramanian%2CV)

[^43]: Ocko, S. A., Hardcastle, K., Giocomo, L. M. & Ganguli, S. Emergent elasticity in the neural code for space. *Proc. Natl Acad. Sci. USA* **115**, E11798–E11806 (2018).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=30482856) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6294895) [ADS](http://adsabs.harvard.edu/cgi-bin/nph-data_query?link_type=ABSTRACT&bibcode=2018PNAS..11511798O) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1cXisVyhu73E) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Emergent%20elasticity%20in%20the%20neural%20code%20for%20space&journal=Proc.%20Natl%20Acad.%20Sci.%20USA&volume=115&pages=E11798-E11806&publication_year=2018&author=Ocko%2CSA&author=Hardcastle%2CK&author=Giocomo%2CLM&author=Ganguli%2CS)

[^44]: Chaudhuri, R. & Fiete, I. Bipartite expander hopfield networks as self-decoding high-capacity error correcting codes. *Adv. Neural Inf. Process. Syst.* **32**, 4175 (2019).

[MATH](http://www.emis.de/MATH-item?1135.16005) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Bipartite%20expander%20hopfield%20networks%20as%20self-decoding%20high-capacity%20error%20correcting%20codes&journal=Adv.%20Neural%20Inf.%20Process.%20Syst.&volume=32&publication_year=2019&author=Chaudhuri%2CR&author=Fiete%2CI)

[^45]: Whittington, James C. R. et al. The Tolman–Eichenbaum machine: unifying space and relational memory through generalization in the hippocampal formation. *Cell* **183**, 1249–1263 (2020).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=33181068) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC7707106) [MATH](http://www.emis.de/MATH-item?1457.32087) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB3cXitlClsLnE) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20Tolman%E2%80%93Eichenbaum%20machine%3A%20unifying%20space%20and%20relational%20memory%20through%20generalization%20in%20the%20hippocampal%20formation&journal=Cell&volume=183&pages=1249-1263&publication_year=2020&author=Whittington%2CJCR)

[^46]: Buzsáki, György & Tingley, D. Space and time: the hippocampus as a sequence generator. *Trends Cogn. Sci.* **22**, 853–869 (2018).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=30266146) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6166479) [MATH](http://www.emis.de/MATH-item?1204.92017) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Space%20and%20time%3A%20the%20hippocampus%20as%20a%20sequence%20generator&journal=Trends%20Cogn.%20Sci.&volume=22&pages=853-869&publication_year=2018&author=Buzs%C3%A1ki%2CGy%C3%B6rgy&author=Tingley%2CD)

[^47]: Aronov, D., Nevers, R. & Tank, D. W. Mapping of a non-spatial dimension by the hippocampal–entorhinal circuit. *Nature* **543**, 719–722 (2017).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=28358077) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5492514) [ADS](http://adsabs.harvard.edu/cgi-bin/nph-data_query?link_type=ABSTRACT&bibcode=2017Natur.543..719A) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2sXltl2iu7g%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Mapping%20of%20a%20non-spatial%20dimension%20by%20the%20hippocampal%E2%80%93entorhinal%20circuit&journal=Nature&volume=543&pages=719-722&publication_year=2017&author=Aronov%2CD&author=Nevers%2CR&author=Tank%2CDW)

[^48]: Killian, N. J., Potter, S. M. & Buffalo, E. A. Saccade direction encoding in the primate entorhinal cortex during visual exploration. *Proc. Natl Acad. Sci. USA* **112**, 15743–15748 (2015).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=26644558) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4697421) [MATH](http://www.emis.de/MATH-item?1401.91163) [ADS](http://adsabs.harvard.edu/cgi-bin/nph-data_query?link_type=ABSTRACT&bibcode=2015PNAS..11215743K) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2MXhvFKqsb3O) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Saccade%20direction%20encoding%20in%20the%20primate%20entorhinal%20cortex%20during%20visual%20exploration&journal=Proc.%20Natl%20Acad.%20Sci.%20USA&volume=112&pages=15743-15748&publication_year=2015&author=Killian%2CNJ&author=Potter%2CSM&author=Buffalo%2CEA)

[^49]: Constantinescu, A. O., O’Reilly, J. X. & Behrens, T. E. J. Organizing conceptual knowledge in humans with a gridlike code. *Science* **352**, 1464–1468 (2016).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=27313047) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5248972) [ADS](http://adsabs.harvard.edu/cgi-bin/nph-data_query?link_type=ABSTRACT&bibcode=2016Sci...352.1464C) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC28XpslOqsLw%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Organizing%20conceptual%20knowledge%20in%20humans%20with%20a%20gridlike%20code&journal=Science&volume=352&pages=1464-1468&publication_year=2016&author=Constantinescu%2CAO&author=O%E2%80%99Reilly%2CJX&author=Behrens%2CTEJ)

[^50]: Neupane, S., Fiete, L. & Jazayeri, M. Mental navigation in the primate entorhinal cortex. *Nature* **630**, 704–711 (2024).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=38867051) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC11224022) [ADS](http://adsabs.harvard.edu/cgi-bin/nph-data_query?link_type=ABSTRACT&bibcode=2024Natur.630..704N) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB2cXhtlWjs7zJ) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Mental%20navigation%20in%20the%20primate%20entorhinal%20cortex&journal=Nature&volume=630&pages=704-711&publication_year=2024&author=Neupane%2CS&author=Fiete%2CL&author=Jazayeri%2CM)

[^51]: Krotov, D. and Hopfield, J. Large associative memory problem in neurobiology and machine learning. Preprint at [https://doi.org/10.48550/arXiv.2008.06996](https://doi.org/10.48550/arXiv.2008.06996) (2020).

[^52]: Witter, M. P., Doan, T. P., Jacobsen, B., Nilssen, E. S. & Ohara, S. Architecture of the entorhinal cortex a review of entorhinal anatomy in rodents with some comparative notes. *Front. Syst. Neurosci.* **11**, 46 (2017).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=28701931) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5488372) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Architecture%20of%20the%20entorhinal%20cortex%20a%20review%20of%20entorhinal%20anatomy%20in%20rodents%20with%20some%20comparative%20notes&journal=Front.%20Syst.%20Neurosci.&volume=11&publication_year=2017&author=Witter%2CMP&author=Doan%2CTP&author=Jacobsen%2CB&author=Nilssen%2CES&author=Ohara%2CS)

[^53]: Fiete, I. R., Burak, Y. & Brookings, T. What grid cells convey about rat location. *J. Neurosci.* **28**, 6858–6871 (2008).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=18596161) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6670990) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD1cXot1Oqt7o%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=What%20grid%20cells%20convey%20about%20rat%20location&journal=J.%20Neurosci.&volume=28&pages=6858-6871&publication_year=2008&author=Fiete%2CIR&author=Burak%2CY&author=Brookings%2CT)

[^54]: Sharma, S., Chandra, S. & Fiete, I. Content addressable memory without catastrophic forgetting by heteroassociation with a fixed scaffold. In *39th International Conference on Machine Learning* 19658–19682 (PMLR, 2022).

[^55]: Radhakrishnan, A., Belkin, M. & Uhler, C. Overparameterized neural networks implement associative memory. *Proc. Natl Acad. Sci. USA* **117**, 27162–27170 (2020).

[MathSciNet](http://www.ams.org/mathscinet-getitem?mr=4255943) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=33067397) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC7959487) [MATH](http://www.emis.de/MATH-item?1485.68236) [ADS](http://adsabs.harvard.edu/cgi-bin/nph-data_query?link_type=ABSTRACT&bibcode=2020PNAS..11727162R) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB3cXit1Ghu7rJ) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Overparameterized%20neural%20networks%20implement%20associative%20memory&journal=Proc.%20Natl%20Acad.%20Sci.%20USA&volume=117&pages=27162-27170&publication_year=2020&author=Radhakrishnan%2CA&author=Belkin%2CM&author=Uhler%2CC)

[^56]: Kleinfeld, D. & Sompolinsky, H. Associative neural network model for the generation of temporal patterns. theory and application to central pattern generators. *Biophys. J.* **54**, 1039–1051 (1988).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=3233265) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC1330416) [MATH](http://www.emis.de/MATH-item?0651.17002) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaL1M7ms1OksQ%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Associative%20neural%20network%20model%20for%20the%20generation%20of%20temporal%20patterns.%20theory%20and%20application%20to%20central%20pattern%20generators&journal=Biophys.%20J.&volume=54&pages=1039-1051&publication_year=1988&author=Kleinfeld%2CD&author=Sompolinsky%2CH)

[^57]: Fyhn, M., Hafting, T., Treves, A., Moser, May-Britt & Moser, E. I. Hippocampal remapping and grid realignment in entorhinal cortex. *Nature* **446**, 190–194 (2007).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=17322902) [MATH](http://www.emis.de/MATH-item?1116.53040) [ADS](http://adsabs.harvard.edu/cgi-bin/nph-data_query?link_type=ABSTRACT&bibcode=2007Natur.446..190F) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD2sXisFygurw%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Hippocampal%20remapping%20and%20grid%20realignment%20in%20entorhinal%20cortex&journal=Nature&volume=446&pages=190-194&publication_year=2007&author=Fyhn%2CM&author=Hafting%2CT&author=Treves%2CA&author=Moser%2CMay-Britt&author=Moser%2CEI)

[^58]: Huszár, R., Zhang, Y., Blockus, H. & Buzsáki, György Preconfigured dynamics in the hippocampus are guided by embryonic birthdate and rate of neurogenesis. *Nat. Neurosci.* **25**, 1201–1212 (2022).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=35995878) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC10807234) [MATH](http://www.emis.de/MATH-item?1512.57029) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Preconfigured%20dynamics%20in%20the%20hippocampus%20are%20guided%20by%20embryonic%20birthdate%20and%20rate%20of%20neurogenesis&journal=Nat.%20Neurosci.&volume=25&pages=1201-1212&publication_year=2022&author=Husz%C3%A1r%2CR&author=Zhang%2CY&author=Blockus%2CH&author=Buzs%C3%A1ki%2CGy%C3%B6rgy)

[^59]: Bonnevie, T. et al. Grid cells require excitatory drive from the hippocampus. *Nat. Neurosci.* **16**, 309–317 (2013).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=23334581) [MATH](http://www.emis.de/MATH-item?1275.11106) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC3sXhtV2qsr0%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Grid%20cells%20require%20excitatory%20drive%20from%20the%20hippocampus&journal=Nat.%20Neurosci.&volume=16&pages=309-317&publication_year=2013&author=Bonnevie%2CT)

[^60]: Almog, N. et al. During hippocampal inactivation, grid cells maintain synchrony, even when the grid pattern is lost. *eLife* **8**, e47147 (2019).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=31621577) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6797478) [MATH](http://www.emis.de/MATH-item?1437.03014) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=During%20hippocampal%20inactivation%2C%20grid%20cells%20maintain%20synchrony%2C%20even%20when%20the%20grid%20pattern%20is%20lost&journal=eLife&volume=8&publication_year=2019&author=Almog%2CN)

[^61]: Hales, J. B. et al. Medial entorhinal cortex lesions only partially disrupt hippocampal place cells and hippocampus-dependent place memory. *Cell Rep.* **9**, 893–901 (2014).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=25437546) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4294707) [MATH](http://www.emis.de/MATH-item?1304.00065) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2cXhvVOnt7%2FL) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Medial%20entorhinal%20cortex%20lesions%20only%20partially%20disrupt%20hippocampal%20place%20cells%20and%20hippocampus-dependent%20place%20memory&journal=Cell%20Rep.&volume=9&pages=893-901&publication_year=2014&author=Hales%2CJB)

[^62]: Wood, E. R., Dudchenko, P. A., Robitsek, R. J. & Eichenbaum, H. Hippocampal neurons encode information about different types of memory episodes occurring in the same location. *Neuron* **27**, 623–633 (2000).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=11055443) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD3cXnt12ntLg%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Hippocampal%20neurons%20encode%20information%20about%20different%20types%20of%20memory%20episodes%20occurring%20in%20the%20same%20location&journal=Neuron&volume=27&pages=623-633&publication_year=2000&author=Wood%2CER&author=Dudchenko%2CPA&author=Robitsek%2CRJ&author=Eichenbaum%2CH)

[^63]: Grieves, R. M., Wood, E. R. & Dudchenko, P. A. Place cells on a maze encode routes rather than destinations. *eLife* **5**, e15986 (2016).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=27282386) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4942257) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Place%20cells%20on%20a%20maze%20encode%20routes%20rather%20than%20destinations&journal=eLife&volume=5&publication_year=2016&author=Grieves%2CRM&author=Wood%2CER&author=Dudchenko%2CPA)

[^64]: Dombeck, D. A., Harvey, C. D., Tian, L., Looger, L. L. & Tank, D. W. Functional imaging of hippocampal place cells at cellular resolution during virtual navigation. *Nat. Neurosci.* **13**, 1433–1440 (2010).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=20890294) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2967725) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC3cXht1elu73L) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Functional%20imaging%20of%20hippocampal%20place%20cells%20at%20cellular%20resolution%20during%20virtual%20navigation&journal=Nat.%20Neurosci.&volume=13&pages=1433-1440&publication_year=2010&author=Dombeck%2CDA&author=Harvey%2CCD&author=Tian%2CL&author=Looger%2CLL&author=Tank%2CDW)

[^65]: Nadel, L. & Moscovitch, M. Memory consolidation, retrograde amnesia and the hippocampal complex. *Curr. Opin. Neurobiol.* **7**, 217–227 (1997).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=9142752) [MATH](http://www.emis.de/MATH-item?63.0481.03) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DyaK2sXjsVOrtb4%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Memory%20consolidation%2C%20retrograde%20amnesia%20and%20the%20hippocampal%20complex&journal=Curr.%20Opin.%20Neurobiol.&volume=7&pages=217-227&publication_year=1997&author=Nadel%2CL&author=Moscovitch%2CM)

[^66]: Yadav, N., Toader, A. & Rajasethupathy, P. Thalamic and prefrontal contributions to an evolving memory. *Neuron* **112**, 1045–1059 (2024).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=38272026) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB2cXhvFCnsLg%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Thalamic%20and%20prefrontal%20contributions%20to%20an%20evolving%20memory&journal=Neuron&volume=112&pages=1045-1059&publication_year=2024&author=Yadav%2CN&author=Toader%2CA&author=Rajasethupathy%2CP)

[^67]: Tsoi, SauYee et al. Telencephalic outputs from the medial entorhinal cortex are copied directly to the hippocampus. *eLife* **11**, e73162 (2022).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=35188100) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC8940174) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB38XhvFyqs7rN) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Telencephalic%20outputs%20from%20the%20medial%20entorhinal%20cortex%20are%20copied%20directly%20to%20the%20hippocampus&journal=eLife&volume=11&publication_year=2022&author=Tsoi%2CSauYee)

[^68]: Donato, F., Jacobsen, R. I., Moser, May-Britt & Moser, E. I. Stellate cells drive maturation of the entorhinal–hippocampal circuit. *Science* **355**, eaai8178 (2017).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=28154241) [MATH](http://www.emis.de/MATH-item?1452.11101) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Stellate%20cells%20drive%20maturation%20of%20the%20entorhinal%E2%80%93hippocampal%20circuit&journal=Science&volume=355&publication_year=2017&author=Donato%2CF&author=Jacobsen%2CRI&author=Moser%2CMay-Britt&author=Moser%2CEI)

[^69]: Benna, M. K. & Fusi, S. Place cells may simply be memory cells: Memory compression leads to spatial tuning and history dependence. *Proc. Natl Acad. Sci. USA* **118**, e2018422118 (2021).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=34916282) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC8713479) [MATH](http://www.emis.de/MATH-item?1493.76040) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB38Xhs1Klt78%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Place%20cells%20may%20simply%20be%20memory%20cells%3A%20Memory%20compression%20leads%20to%20spatial%20tuning%20and%20history%20dependence&journal=Proc.%20Natl%20Acad.%20Sci.%20USA&volume=118&publication_year=2021&author=Benna%2CMK&author=Fusi%2CS)

[^70]: Teyler, T. J. & Rudy, J. W. The hippocampal indexing theory and episodic memory: updating the index. *Hippocampus* **17**, 1158–1169 (2007).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=17696170) [MATH](http://www.emis.de/MATH-item?1273.15017) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20hippocampal%20indexing%20theory%20and%20episodic%20memory%3A%20updating%20the%20index&journal=Hippocampus&volume=17&pages=1158-1169&publication_year=2007&author=Teyler%2CTJ&author=Rudy%2CJW)

[^71]: Treves, A. & Rolls, E. T. Computational analysis of the role of the hippocampus in memory. *Hippocampus* **4**, 374–391 (1994).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=7842058) [MATH](http://www.emis.de/MATH-item?0828.92009) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaK2M7ksValsw%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Computational%20analysis%20of%20the%20role%20of%20the%20hippocampus%20in%20memory&journal=Hippocampus&volume=4&pages=374-391&publication_year=1994&author=Treves%2CA&author=Rolls%2CET)

[^72]: Alme, C. B. et al. Place cells in the hippocampus: eleven maps for eleven rooms. *Proc. Natl Acad. Sci. USA* **111**, 18428–18435 (2014).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=25489089) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4284589) [MATH](http://www.emis.de/MATH-item?0477.76118) [ADS](http://adsabs.harvard.edu/cgi-bin/nph-data_query?link_type=ABSTRACT&bibcode=2014PNAS..11118428A) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2cXitVClu7jK) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Place%20cells%20in%20the%20hippocampus%3A%20eleven%20maps%20for%20eleven%20rooms&journal=Proc.%20Natl%20Acad.%20Sci.%20USA&volume=111&pages=18428-18435&publication_year=2014&author=Alme%2CCB)

[^73]: Yim, ManYi, Sadun, L. A., Fiete, I. R. & Taillefumier, T. Place-cell capacity and volatility with grid-like inputs. *eLife* **10**, e62702 (2021).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=34028354) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC8294848) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB3MXislansbrE) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Place-cell%20capacity%20and%20volatility%20with%20grid-like%20inputs&journal=eLife&volume=10&publication_year=2021&author=Yim%2CManYi&author=Sadun%2CLA&author=Fiete%2CIR&author=Taillefumier%2CT)

[^74]: Tapson, J. & van Schaik, A. Learning the pseudoinverse solution to network weights. *Neural Netw.* **45**, 94–100 (2013).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=23541926) [MATH](http://www.emis.de/MATH-item?1296.68147) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DC%2BC3srgvVamtw%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Learning%20the%20pseudoinverse%20solution%20to%20network%20weights&journal=Neural%20Netw.&volume=45&pages=94-100&publication_year=2013&author=Tapson%2CJ&author=Schaik%2CA)

[^75]: O’Reilly, R. C. Six principles for biologically based computational models of cortical cognition. *Trends Cogn. Sci.* **2**, 455–462 (1998).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=21227277) [MATH](http://www.emis.de/MATH-item?1226.92009) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Six%20principles%20for%20biologically%20based%20computational%20models%20of%20cortical%20cognition&journal=Trends%20Cogn.%20Sci.&volume=2&pages=455-462&publication_year=1998&author=O%E2%80%99Reilly%2CRC)

[^76]: Personnaz, L., Guyon, I. & Dreyfus, G. Information storage and retrieval in spin-glass like neural networks. *J. Physique Lettres* **46**, 359–365 (1985).

[MATH](http://www.emis.de/MATH-item?1356.82028) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Information%20storage%20and%20retrieval%20in%20spin-glass%20like%20neural%20networks&journal=J.%20Physique%20Lettres&volume=46&pages=359-365&publication_year=1985&author=Personnaz%2CL&author=Guyon%2CI&author=Dreyfus%2CG)

[^77]: Personnaz, L., Guyon, I. & Dreyfus, G. Collective computational properties of neural networks: new learning mechanisms. *Phys. Rev. A* **34**, 4217 (1986).

[MathSciNet](http://www.ams.org/mathscinet-getitem?mr=869015) [MATH](http://www.emis.de/MATH-item?1356.82028) [ADS](http://adsabs.harvard.edu/cgi-bin/nph-data_query?link_type=ABSTRACT&bibcode=1986PhRvA..34.4217P) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DC%2BC2sjosFalsw%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Collective%20computational%20properties%20of%20neural%20networks%3A%20new%20learning%20mechanisms&journal=Phys.%20Rev.%20A&volume=34&publication_year=1986&author=Personnaz%2CL&author=Guyon%2CI&author=Dreyfus%2CG)

[^78]: Parisi, G. A memory which forgets. *J. Phys. A* **19**, L617 (1986).

[MathSciNet](http://www.ams.org/mathscinet-getitem?mr=838461) [MATH](http://www.emis.de/MATH-item?1042.82636) [ADS](http://adsabs.harvard.edu/cgi-bin/nph-data_query?link_type=ABSTRACT&bibcode=1986JPhA...19L.617P) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20memory%20which%20forgets&journal=J.%20Phys.%20A&volume=19&publication_year=1986&author=Parisi%2CG)

[^79]: Fusi, S. & Abbott, L. F. Limits on the memory storage capacity of bounded synapses. *Nat. Neurosci.* **10**, 485–493 (2007).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=17351638) [MATH](http://www.emis.de/MATH-item?1111.35132) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD2sXjsVOhs7w%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Limits%20on%20the%20memory%20storage%20capacity%20of%20bounded%20synapses&journal=Nat.%20Neurosci.&volume=10&pages=485-493&publication_year=2007&author=Fusi%2CS&author=Abbott%2CLF)

[^80]: Tsodyks, M. V. & Feigel’man, M. V. The enhanced storage capacity in neural networks with low activity level. *Europhysics Lett.* **6**, 101 (1988).

[MATH](http://www.emis.de/MATH-item?0962.82543) [ADS](http://adsabs.harvard.edu/cgi-bin/nph-data_query?link_type=ABSTRACT&bibcode=1988EL......6..101T) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20enhanced%20storage%20capacity%20in%20neural%20networks%20with%20low%20activity%20level&journal=Europhysics%20Lett.&volume=6&publication_year=1988&author=Tsodyks%2CMV&author=Feigel%E2%80%99man%2CMV)

[^81]: Dominguez, D., Koroutchev, K., Serrano, E. & Rodríguez, F. B. Information and topology in attractor neural networks. *Neural Comput.* **19**, 956–973 (2007).

[MathSciNet](http://www.ams.org/mathscinet-getitem?mr=2303386) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=17348769) [MATH](http://www.emis.de/MATH-item?1118.68116) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DC%2BD2s7kvFOqtw%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Information%20and%20topology%20in%20attractor%20neural%20networks&journal=Neural%20Comput.&volume=19&pages=956-973&publication_year=2007&author=Dominguez%2CD&author=Koroutchev%2CK&author=Serrano%2CE&author=Rodr%C3%ADguez%2CFB)

[^82]: Markus, E. J. et al. Interactions between location and task affect the spatial and directional firing of hippocampal neurons. *J. Neurosci.* **15**, 7079–7094 (1995).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=7472463) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6578055) [MATH](http://www.emis.de/MATH-item?0877.60096) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DyaK2MXptlOnurs%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Interactions%20between%20location%20and%20task%20affect%20the%20spatial%20and%20directional%20firing%20of%20hippocampal%20neurons&journal=J.%20Neurosci.&volume=15&pages=7079-7094&publication_year=1995&author=Markus%2CEJ)