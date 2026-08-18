# Index — Entities

Models, frameworks, benchmarks, and biological systems. One page per artefact. No researcher pages. Updated whenever an entity page is created.

## Models and frameworks

| Page | What it is | Load-bearing for |
|---|---|---|
| [[wiki/entities/aixi.md]] | Sequential decision theory (expectimax) with the unknown environment prior replaced by the universal semimeasure `ξ`; uncomputable, plus the `AIXItl` reduction that is computable at `t̃·2^l̃` per cycle | The wiki's formal ceiling — the only system covering all six hardness sources; the separability vocabulary; self-certified value as a policy-selection criterion |
| [[wiki/entities/bayesian-program-learning.md]] | Concepts as simple stochastic programs over a shared library of pen primitives, sub-parts, parts and relations; inference recovers the program from one example | The wiki's only architectural (not emergent) `g`/`x` factorization; human-level one-shot classification and a passed visual Turing test; the causal end of the generative spectrum |
| [[wiki/entities/spiking-neural-networks.md]] | Networks whose units communicate by binary, time-located spikes; leaky integrate-and-fire dynamics, STDP-native, run on neuromorphic hardware (Loihi, TrueNorth, SpiNNaker) | The test case for the implementation-level exclusion ([[wiki/empirical-tensions.md]] T1); a substrate-level primitive for *directed* edges; why local learning stops being optional |

## Benchmarks and datasets

| Page | What it is | Load-bearing for |
|---|---|---|
| [[wiki/entities/arc-agi.md]] | ~1,000 hand-authored grid transformation tasks, ~3 example pairs each, evaluation tasks unknown to the developer, priors enumerated as Spelke's four core systems | The wiki's first benchmark page and its only instrument for developer-aware generalization; the pure edge-label-latent case with a co-latent vocabulary |

## Biological systems

*(none yet)*

---

## Referenced but not yet paged

Artefacts named on existing pages that have no page of their own. Listed so the reference is not lost; each gets a page when its source is ingested.

| Artefact | Referenced from | Queued source |
|---|---|---|
| Hippocampus / medial temporal lobe | [[wiki/concepts/complementary-learning-systems.md]], [[wiki/concepts/simulation-based-planning.md]] | `raw/liao-2024-single-shot-many-shot-hippocampus.md`, `raw/yassa-2011-pattern-separation-hippocampus.md` |
| Prefrontal cortex | [[wiki/concepts/working-memory.md]], [[wiki/concepts/meta-learning.md]] | `raw/wang-2018-pfc-meta-rl-system.md`, `raw/friedman-2021-prefrontal-cognitive-control.md` |
| Entorhinal grid cells | [[wiki/concepts/abstract-structural-codes.md]] | `raw/constantinescu-2016-gridlike-code-concepts.md` |
| Differentiable neural computer | [[wiki/concepts/working-memory.md]] | `raw/graves-2016-differentiable-neural-computer.md` |
| Deep Q-network / experience replay | [[wiki/concepts/complementary-learning-systems.md]], [[wiki/concepts/causal-model-building.md]] | *(no primary source in `raw/`; Lake et al. 2017 supplies the Frostbite sample-efficiency numbers and the re-goaling critique second-hand)* |
| Elastic weight consolidation | [[wiki/concepts/continual-learning.md]] | *(no source in `raw/` — acquisition task P3)* |
| Progressive networks | [[wiki/concepts/meta-learning.md]], [[wiki/concepts/continual-learning.md]] | *(no source in `raw/` — acquisition task P3)* |
| Episodic control | [[wiki/concepts/complementary-learning-systems.md]] | *(no source in `raw/` — acquisition task P3)* |
| Monte Carlo tree search / expert Go play | [[wiki/concepts/simulation-based-planning.md]], [[wiki/concepts/causal-model-building.md]] | *(no primary source in `raw/`; Lake et al. 2017 supplies AlphaGo's training volume — 28.4M expert positions + ~100M self-play games vs. Lee Sedol's ~50,000 — and the Go-variants re-goaling argument)* |
| Intuitive physics engine (Battaglia et al. 2013) / PhysNet (Lerer et al. 2016) | [[wiki/concepts/core-knowledge.md]], [[wiki/concepts/simulation-based-planning.md]] | *(no source in `raw/` — the simulation account of the object system, and the convolutional rival needing 100k–200k scenes for one judgement)* |
| Bayesian inverse planning / naive utility calculus (Baker et al. 2009; Jara-Ettinger et al. 2015) | [[wiki/concepts/core-knowledge.md]], [[wiki/concepts/simulation-based-planning.md]] | *(no source in `raw/` — MDP/POMDP theory-of-mind, the only recursively nestable simulation account in the wiki)* |
| Omniglot / the Characters Challenge | [[wiki/entities/bayesian-program-learning.md]], [[wiki/concepts/meta-learning.md]] | *(no source in `raw/` — the benchmark the one-shot results are measured on; row 2 of the latent-variable table in [[wiki/concepts/latent-graph-discovery.md]])* |
| ImageNet | [[wiki/concepts/shortcut-learning.md]] | *(no source in `raw/` — the canonical "dataset ≠ ability" case: intended object recognition, largely solved by texture)* |
| ImageNet-A / ImageNet-C | [[wiki/concepts/shortcut-learning.md]] | *(no source in `raw/` — natural worst case; 15 corruptions)* |
| ObjectNet | [[wiki/concepts/shortcut-learning.md]] | *(no source in `raw/` — scientific controls over background, rotation, viewpoint)* |
| PACS | [[wiki/concepts/shortcut-learning.md]] | *(no source in `raw/` — domain generalisation by construction)* |
| Shift-MNIST / biased CelebA / unfair dSprites | [[wiki/concepts/shortcut-learning.md]] | *(no source in `raw/` — controlled injected shortcuts; the instrument gap G17 asks for)* |
| Winograd Schema Challenge | [[wiki/concepts/shortcut-learning.md]] | *(no source in `raw/` — benchmark designed to remove shortcuts, later found to contain them)* |
| ARCT (Argument Reasoning Comprehension Task) | [[wiki/concepts/shortcut-learning.md]] | *(no source in `raw/` — shortcut-removed variant)* |
| BERT | [[wiki/concepts/shortcut-learning.md]] | *(no source in `raw/` — cue-word shortcut, above chance from "not" alone)* |
| Predictive-coding networks | [[wiki/concepts/biologically-plausible-credit-assignment.md]] | `raw/whittington-2017-predictive-coding-approximates-backprop.md` |
| Spike-timing-dependent plasticity | [[wiki/concepts/biologically-plausible-credit-assignment.md]], [[wiki/concepts/synaptic-plasticity.md]] | `raw/bi-1998-spike-timing-dependent-plasticity.md` |
| Hopfield network | [[wiki/concepts/synaptic-plasticity.md]], [[wiki/concepts/biologically-plausible-credit-assignment.md]] | *(no source in `raw/` — Hebbian storage of binary patterns in a symmetric recurrent net; the continuous version is an energy-based credit-assignment route)* |
| REINFORCE / node perturbation | [[wiki/concepts/synaptic-plasticity.md]] | *(no source in `raw/` — the policy-gradient estimator a biologically plausible three-factor rule turns out to implement)* |
| Eligibility propagation (e-prop) | [[wiki/concepts/biologically-plausible-credit-assignment.md]], [[wiki/entities/spiking-neural-networks.md]] | *(no source in `raw/` — forward-only local credit assignment for spiking nets)* |
| Feedback alignment / direct feedback alignment / sign-symmetry | [[wiki/concepts/biologically-plausible-credit-assignment.md]] | *(no source in `raw/` — sign-symmetry is the only variant matching backpropagation at ImageNet scale)* |
| Differentiable plasticity | [[wiki/concepts/meta-optimized-plasticity.md]] | *(no source in `raw/` — gradient-optimized plasticity coefficients, incl. neuromodulated variants)* |
| Evolvable Neural Units | [[wiki/concepts/meta-optimized-plasticity.md]] | *(no source in `raw/` — evolved somatic/synaptic compartments that rediscover spiking dynamics and RL-type rules)* |
| Loihi / TrueNorth / SpiNNaker | [[wiki/entities/spiking-neural-networks.md]] | *(no source in `raw/` — neuromorphic platforms; locality is a hardware constraint here, not a preference)* |
| CoinRun / Obstacle Tower | [[wiki/entities/arc-agi.md]] | *(no source in `raw/` — generalization tests whose level generators are public, so they measure local generalization: new samples from a known distribution, not a new task)* |
| Raven's Progressive Matrices | [[wiki/entities/arc-agi.md]] | *(no source in `raw/` — the 1930s IQ format ARC is styled after; item types are public and hard-codable, which is what makes it gameable for machines)* |
| OpenAI Five / DotA2 | [[wiki/concepts/skill-acquisition-efficiency.md]] | *(no source in `raw/` — 45,000 years of self-play, 16 of 100+ characters, reliably beaten by non-champion humans days after public release; the wiki's canonical case of skill bought with unlimited experience)* |
| The C-Test (Hernández-Orallo) | [[wiki/entities/arc-agi.md]] | *(no source in `raw/` — AIT-grounded induction test; programmatically generated from a master program, which is Chollet's stated reason for hand-authoring ARC instead)* |
