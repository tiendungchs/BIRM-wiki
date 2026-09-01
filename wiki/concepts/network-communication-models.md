# Network Communication Models — Routing Is Not Free, and the Wiki Has Been Pricing Only Two of Its Three Costs

**A structural graph does not say how signals travel over it. Choosing *how* is choosing a communication model, and every model pays in three currencies at once: `delay` (how many hops), `energy` (how many retransmissions) and — the one the wiki has never priced — `information` (how much of the global topology a node must already know to make its next forwarding decision). Shortest-path routing buys minimal delay and minimal energy by assuming every node holds a map of the entire network; unbiased random walks assume nothing and are slow and expensive. Neither extreme is what wins empirically. The measures that actually predict resting functional connectivity, causal stimulation spread and behaviour — search information, communicability, navigation — all sit in the middle, and the middle is reachable by a single tunable parameter.**

> **Provenance.** Seguin, Sporns & Zalesky 2023, *Brain network communication: concepts, models and applications*, Nat Rev Neurosci 24:557–574, doi:10.1038/s41583-023-00718-5 (`raw/seguin-2023-brain-network-communication.md`). A review, not a result paper: it contributes a taxonomy, a cost framework and a synthesis of others' comparative evidence. **The clipped text does not include Boxes 1–3**, so the review's own equations for the individual measures are absent; formulas below marked `†` are the standard definitions from the surrounding literature, not quotations from this source. The empirical rows are the review's citations, attributed inline.

The wiki has six pages that compute a graph statistic and read it as a claim about signalling — betweenness in [[wiki/concepts/connectome-hubs-and-cores.md]], `L` in [[wiki/concepts/small-world-topology.md]], global efficiency in [[wiki/gaps/g085.md]], communicability in [[wiki/concepts/successor-representation.md]], indirect two-step paths in [[wiki/concepts/function-to-structure-inference.md]], instrength gradients in [[wiki/concepts/cortical-traveling-waves.md]]. Each of those statistics is *defined relative to an assumed communication model*, and none of the pages says which one. This page is that missing declaration.

---

## The three cost dimensions

| Cost | What it measures | Who pays it |
|---|---|---|
| **Delay** | Topological efficiency — number of hops, hence latency and synaptic crossings | Any model; minimised by shortest paths |
| **Energetic** | Metabolic expenditure — total number of signal retransmissions across the whole network per source→target delivery | Broadcast and diffusion models, heavily |
| **Informational** | *How much knowledge of network topology an individual node must possess to make its forwarding decision* | Routing protocols, heavily |

The informational axis is the review's load-bearing contribution and the wiki's blind spot. The argument is structural rather than empirical: computing the shortest path between one pair of nodes requires knowing the connectivity between *all* pairs. That is affordable in an engineered network with a central controller holding a bird's-eye view; a brain is a **decentralised system**, where each element plausibly knows only its own edges and perhaps a local scalar. So a measure that presupposes global knowledge is a description of the graph, not a hypothesis about its traffic.

**(brainstorm) The transfer is uncomfortable and immediate.** Every routing mechanism in this wiki is a *centralised* protocol in this taxonomy. A mixture-of-experts gate ([[wiki/concepts/sparse-expert-routing.md]]) computes `softmax(W_r x)` over **all** `E` experts before selecting `k` — a global view, materialised, at every layer, for every token. Attention ([[wiki/concepts/attention.md]]) scores the query against **every** key before normalising. Both are the shortest-path corner: minimal delay (one hop), and an informational cost the biology is argued to be unable to pay. Nothing in the wiki has ever counted that cost, because with `L = 1` and dense scoring there is no path to be found — which is exactly why the dimension went unnoticed rather than why it is absent.

---

## The taxonomy

Three families, distinguished by *how the next recipient is chosen*.

| Family | Selection rule | Delay | Energy | Information |
|---|---|---|---|---|
| **Routing protocols** | One next node, chosen by a policy | low | low | medium–high |
| **Diffusion processes** | One next node chosen at random, or all neighbours at once | high (walks) / low (broadcast) | high | low |
| **Parametric models** | A tunable knob interpolating between the two | tunable | tunable | tunable |

### Routing protocols

| Model | Rule | Cost profile | The catch |
|---|---|---|---|
| **Shortest path routing** | Signal follows the single minimum-length path | delay **low**, energy **low**, information **very high** | Requires each node to know the entire topology. The review: "difficult to implement in decentralised nervous systems". Measures that assume it: characteristic path length, global efficiency, betweenness centrality |
| **Navigation** (greedy routing) | Each node forwards to whichever *neighbour* is closest to the target under a distance metric `d` | delay **low**, energy **low**, information **medium** | Needs only `d(neighbour, target)` — local. **It can fail**: greedy routing can loop between intermediaries and never arrive |

**The navigation number is the one to remember.** Greedy routing in plain **Euclidean** space achieves **70–100% of shortest-path signalling efficiency** in human, mouse and macaque connectomes (Seguin et al. 2018, the review's ref. 41). Almost all of the benefit of a global map, from a rule that consults only immediate neighbours and one scalar distance to the goal. The metric need not be Euclidean: human connectome navigation also succeeds using position along the **unimodal→transmodal functional axis** (ref. 70), and network-geometry work embeds connectomes in **hyperbolic** space, which mixes spatial and topological structure (refs. 71–73).

The requirement is precise: navigation works when the distance metric *reflects the probability that two nodes are connected* (refs. 43, 67). A metric with that property is exactly a learned latent embedding of the graph — which is the object [[wiki/concepts/latent-graph-discovery.md]] is about recovering, here put to work as a routing table rather than as a representation.

### Diffusion processes

| Model | Rule | Cost profile | Measure |
|---|---|---|---|
| **Unbiased random walk** | Forward to a random neighbour with probability ∝ edge weight | delay **high**, energy **high**, information **minimal** | Mean first passage time; diffusion efficiency = its reciprocal. Empirically **poor** signalling efficiency on the human connectome (refs. 44, 63) |
| **Broadcasting / communicability** | Forward to *all* neighbours, every step, ignoring whether they already received it | delay **low**, energy **high**, information **low** | `C = e^A = Σ_n Aⁿ/n!` † — a sum over **all** walks, each of length `n` discounted by `1/n!` |

**Why broadcast gets shortest-path delay for free.** The set of all walks between two nodes *contains* their shortest path. If signals propagate along all walks simultaneously, the first arrival is via the shortest path — so the delay is identical to optimal routing, obtained **without any node knowing the topology**. The price is paid entirely in energy, in redundant retransmissions. This is the single cleanest statement of the delay↔energy↔information trade in the review, and it explains why communicability keeps winning: it is the only model that is simultaneously optimal in delay and near-free in information.

**Search information** † (`SI(s,t) = −log₂ P(π_st)`, the bits a random walker needs to be handed in order to stay on the shortest path from `s` to `t`) is the hybrid the review's empirical rows keep favouring: it is a *diffusion* quantity that measures how hard the *shortest path* is to find. It is the informational cost of shortest-path routing, made into a number.

### Parametric models

| Model | Parameter | Endpoints | What the knob is |
|---|---|---|---|
| **Linear threshold** | `θ ∈ [0,1]` — fraction of a node's neighbourhood that must be active for it to activate | `θ = 0` → full broadcast, complete cascade from any single perturbation; `θ > θ_c` → activation stays local | A **cascade gate**. Unlike communicability it does not re-transmit to already-active nodes, so its energy cost is *moderate*, not high |
| **Biased random walk** | `λ ≥ 0` — amount of global topological information given to each node | `λ = 0` → unbiased random walk; `λ → ∞` → shortest-path routing | **Literally a dial on informational cost.** Nodes are told which neighbour is more likely to lie on the shortest path to the target, and transition probabilities are biased by `λ` toward it |
| **Shortest path ensembles** | `k` — number of most-efficient paths carrying the signal | `k = 1` → classic shortest-path routing; `k ≫ 1` → inclusive, low information | Relaxes the unargued assumption that traffic uses *only* the optimum |

**The shortest-path-ensembles observation is a weight-pruning argument in disguise.** Only a **small proportion** of connections lie on *any* shortest path between *any* pair of nodes (refs. 40, 41). So under strict optimal routing, the vast majority of the brain's axonal projections play no role in global signal traffic at all — a conclusion so implausible that it functions as a reductio on `k = 1`. **(brainstorm)** Run the same computation on a trained network's weight matrix and the same reductio applies: an importance ranking read off shortest paths will mark most learned weights as traffic-irrelevant, which is not what magnitude-pruning curves show. This is a cheap, unrun consistency check on every graph-theoretic diagnostic the wiki has proposed for trained models.

---

## What the evidence actually favours

| Study | Design | Winner |
|---|---|---|
| Goñi et al. 2014 (ref. 39) | Network communication measures on the human connectome → predict resting-state fMRI functional connectivity | **Search information and path transitivity beat shortest path length** — the first evidence that connectome traffic is not shortest-path-only. Abdelnour et al. (ref. 90) concurred with a different diffusion model |
| Grayson et al. 2016 (ref. 47) | Pharmacogenetic amygdala deactivation in rhesus monkeys; functional connectivity changes measured **causally** | Changes were **not confined to direct structural neighbours**. Deleting the amygdala from the connectome and recomputing **communicability** strongly predicted the observed functional reconfiguration |
| Seguin et al. (ref. 116) | **550 epilepsy patients**, single-pulse direct electrical stimulation + intracranial EEG; whole-brain maps of causal propagation at millisecond resolution; focus on **anatomically unconnected, spatially distant** region pairs | **Search information and communicability outperform all alternatives**, including shortest-path measures |
| Raj et al. 2012 (ref. 104) | Spatial distribution of grey-matter atrophy in dementia | Recapitulated by a **diffusion** model of pathogen spread through the connectome |
| Comparative cognitive/clinical (refs. 49–53, 96–101) | Processing speed, general intelligence, schizophrenia, Alzheimer, stroke, traumatic brain injury | Navigation, communicability and diffusion measures "often more explanatory" than shortest-path measures |

**The review's own synthesis:** both extremes — shortest-path routing and unbiased random walks — are "unlikely to reflect underlying mechanisms". The models that survive are the balanced ones. And a qualification that matters for the wiki's existing pages: *the shortest-path structure of the connectome still shapes signalling*, because broadcast-like strategies **access shortest paths without centralised knowledge**. Shortest-path measures remain valid descriptions of a graph; what they do not license is a claim about traffic. That distinction is the substance of [[wiki/empirical-tensions.md]] T316.

---

## Relevance to a reasoning model

- **`G85` gets a better actuator than the one it currently asks for, and it is one scalar.** That gap wants a system that grades its own routing against demand, and its candidate knob is a broadcast neuromodulatory gain — which [[wiki/concepts/network-control-theory.md]] already showed is the *weak* strategy on a small-world substrate. The biased-random-walk `λ` is the alternative: a single parameter that slides the whole network from unbiased diffusion to selective routing, implemented as a *bias on local transition probabilities* rather than a blanket gain. **(brainstorm)** In a `Transformer`, `λ` is the attention temperature; in a mixture-of-experts, it is the router's logit scale. Both already exist as untuned constants. The unrun experiment is to make one of them a demand-graded control variable — high `λ` (sharp, selective, expensive-to-compute, low-entropy routing) on hard queries, low `λ` (diffuse, cheap, exploratory) on easy ones — and check whether the position on that axis tracks task difficulty the way the participation coefficient does in [[wiki/concepts/integration-segregation-balance.md]].
- **A decentralised router is buildable and would be much cheaper than the ones in the wiki.** Navigation is the recipe: embed the modules in a metric space, give each module only its neighbours' coordinates and the target's, forward greedily. Cost is `O(degree)` per hop instead of `O(E)` per token, no gating network, no load-balancing loss, no all-to-all scoring. The connectome result says the ceiling on this is high — **70–100%** of optimal efficiency. **(brainstorm)** This is the wiki's most concrete answer yet to `G84`'s complaint that architectures wire modules all-to-all: the crossing point need not be a component at all if the *embedding* carries the routing information, which is the same move [[wiki/concepts/successor-representation.md]] makes for planning.
- **Navigation's failure mode is a feature.** It is the only model in the taxonomy where communication can *fail* — greedy routing loops and never arrives. Every other model permits traffic between every pair. A router that can return "no route" is a router with a native abstention signal, which is what selective prediction wants and what a `softmax` over experts structurally cannot produce, since it always outputs a distribution. The review makes the same point from the biology side: some region pairs are probably *not meant* to communicate in a given context, and unrestricted all-pairs signalling is a route to "maladaptive over-integration" (ref. 129).
- **The informational cost of a routing decision belongs in the architecture's budget.** No model in the wiki reports it. It is cheap to define: the number of parameters or activations a routing decision reads that are not local to the node making it. Under that definition a mixture-of-experts gate reads `E×d` global parameters per decision and greedy navigation reads `degree × dim` local ones — a difference of orders of magnitude that no efficiency table in the wiki currently contains.
- **Different regions may use different protocols, and no architecture allows this.** The review flags as an open direction that within-module and between-module signalling may run on different strategies (ref. 130), as may unimodal versus transmodal cortex (refs. 70, 131), with composite models only just appearing (ref. 132). Every routing mechanism in the wiki applies one uniform rule to all units. **(brainstorm)** The natural split maps onto [[wiki/concepts/connectome-hubs-and-cores.md]]'s hub taxonomy: provincial hubs (within-module aggregators) can afford broadcast because their neighbourhood is small; connector hubs, whose neighbourhood spans modules, cannot, and are exactly where a selective protocol pays for itself.

---

## Open problems

- **Fidelity is not in the cost framework.** The review names this as its own first limitation: `delay/energy/information` omits signal degradation across retransmissions (refs. 127, 128). That omission flatters diffusion models specifically — communicability's high energy cost also implies many lossy hops, and nothing in the taxonomy penalises it for that.
- **Sources and targets are assumed to exist.** Every model presupposes a well-defined `(source, target)` pair. That fits stimulation experiments and fits nothing about intrinsic dynamics; it is also the assumption that makes these measures *static* — a communication matrix is a fixed transformation of the adjacency matrix and generates no time series.
- **The comparative evidence is thin and possibly regime-dependent.** The review states plainly that systematic validation efforts are "few and limited in scope" (refs. 39, 49, 116, 124), and asks a question it cannot answer: are the mechanisms behind intrinsic functional synchrony the same as those behind the propagation of exogenous stimulation? If not, the winners table above is a list of answers to different questions.
- **No mechanism selects a path.** The models quantify *which* path traffic would take under an assumed policy; none says how neuronal activity implements the choice. The review names bridging to the mechanistic literature (coherence, communication subspaces, [[wiki/concepts/inter-areal-synchrony.md]]) as the crucial future direction, and notes those accounts cover only small motifs of directly connected elements.
- **Nothing here has been computed on a trained network.** As with [[wiki/concepts/network-control-theory.md]], the formalism is cheap, fully specified, and unapplied. Communicability, search information and navigation efficiency on a thresholded weight matrix are a few lines each, and the wiki records no instance.

---

## Connections

- **[[wiki/concepts/connectome-hubs-and-cores.md]]** — the page whose central statistic this one puts a condition on: betweenness centrality counts shortest paths through a node and is therefore a *routing-protocol* quantity, so reading the medial core as a traffic bottleneck presupposes the model this review argues the substrate cannot afford (T316) — while the blood-flow correlate (`r² = 0.49`) survives, because metabolic cost is model-free.
- **[[wiki/concepts/small-world-topology.md]]** — the same conditionality applied to `L`: characteristic path length and global efficiency are averages over shortest paths, so "short paths at low wiring cost" is a statement about what the graph *permits*, not about what its traffic *does*, and the review's synthesis is that this remains a valid description while ceasing to be a communication claim.
- **[[wiki/concepts/network-control-theory.md]]** — the complementary framework named as such by both sources: control theory asks where to *inject* energy to reach a target state and treats propagation as given by `A`, whereas this page asks how a signal *finds its way* and treats the destination as given — and where they meet, this page's `λ` supplies the demand-graded actuator control theory specifies but does not instantiate.
- **[[wiki/concepts/successor-representation.md]]** — the home taxonomy for the object that page uses as the SR's parameter-free sibling: `e^A` is the *broadcasting* model, and the reason it fits entorhinal adaptation and reaction times is the reason it wins here — it accesses shortest paths without any node holding a global map, so a predictive map that looks like communicability is evidence of a decentralised protocol rather than of an optimiser.
- **[[wiki/concepts/sparse-expert-routing.md]]** — the wiki's routing primitive, re-read as a *centralised shortest-path* protocol: the gate scores all `E` experts globally before selecting `k`, which is the maximum-informational-cost corner of this taxonomy, and navigation is the decentralised alternative with a measured ceiling of 70–100% of optimal efficiency and an `O(degree)` rather than `O(E)` decision.
- **[[wiki/concepts/integration-segregation-balance.md]]** — the measured biological instance of this page's parametric knob: moving along the between-module participation axis under task demand *is* a change of communication regime, and `λ` (biased random walks) is the generative parameter that would produce that movement in a model rather than merely describing it.
- **[[wiki/concepts/latent-graph-discovery.md]]** — where the two halves of that page's problem meet: navigation works only when the distance metric reflects connection probability, so a successfully discovered latent embedding *is* a decentralised routing table, and discovery and navigation stop being two stages.
- **[[wiki/concepts/function-to-structure-inference.md]]** — the same structure→function regression run the other way and with a richer predictor set: that page's two-step indirect path sum (`r = 0.29`) is the crudest member of this page's diffusion family, and Goñi et al. 2014 report that search information and path transitivity outperform shortest-path length on exactly that prediction.
- **[[wiki/concepts/effective-connectivity.md]]** — what a communication matrix is *not*: both produce a region-by-region matrix from a structural prior, but effective connectivity infers directed causal influence by inverting a generative model of dynamics, whereas a communication matrix is an analytical transformation of the anatomical adjacency under an assumed policy, with no dynamics and no time series.
- **[[wiki/concepts/attention.md]]** — the mechanism this page prices for the first time: scoring every key per query is a one-hop, zero-delay, maximum-information protocol, so attention's `L = 1` is not an escape from the communication problem but the corner of it that trades all of the informational budget for delay.
- **[[wiki/concepts/inter-areal-synchrony.md]]** — the mechanistic account this page's models deliberately abstract away: communication models say which polysynaptic path carries a signal but not what gates it, while coherence-based accounts say what gates a link but only for small motifs of directly connected elements — the review names bridging the two as its crucial open direction.
