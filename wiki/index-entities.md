# Index — Entities

Models, frameworks, benchmarks, and biological systems. One page per artefact. No researcher pages. Updated whenever an entity page is created.

## Models and frameworks

| Page | What it is | Load-bearing for |
|---|---|---|
| [[wiki/entities/spiking-neural-networks.md]] | Networks whose units communicate by binary, time-located spikes; leaky integrate-and-fire dynamics, STDP-native, run on neuromorphic hardware (Loihi, TrueNorth, SpiNNaker) | The test case for the implementation-level exclusion ([[wiki/empirical-tensions.md]] T1); a substrate-level primitive for *directed* edges; why local learning stops being optional |

## Benchmarks and datasets

*(none yet)*

## Biological systems

*(none yet)*

---

## Referenced but not yet paged

Artefacts named on existing pages that have no page of their own. Listed so the reference is not lost; each gets a page when its source is ingested.

| Artefact | Referenced from | Queued source |
|---|---|---|
| AIXI | [[wiki/concepts/latent-graph-discovery.md]] | `raw/hutter-2000-universal-ai-algorithmic-complexity.md` |
| Hippocampus / medial temporal lobe | [[wiki/concepts/complementary-learning-systems.md]], [[wiki/concepts/simulation-based-planning.md]] | `raw/liao-2024-single-shot-many-shot-hippocampus.md`, `raw/yassa-2011-pattern-separation-hippocampus.md` |
| Prefrontal cortex | [[wiki/concepts/working-memory.md]], [[wiki/concepts/meta-learning.md]] | `raw/wang-2018-pfc-meta-rl-system.md`, `raw/friedman-2021-prefrontal-cognitive-control.md` |
| Entorhinal grid cells | [[wiki/concepts/abstract-structural-codes.md]] | `raw/constantinescu-2016-gridlike-code-concepts.md` |
| Differentiable neural computer | [[wiki/concepts/working-memory.md]] | `raw/graves-2016-differentiable-neural-computer.md` |
| Deep Q-network / experience replay | [[wiki/concepts/complementary-learning-systems.md]] | *(no source in `raw/` — acquisition task P3)* |
| Elastic weight consolidation | [[wiki/concepts/continual-learning.md]] | *(no source in `raw/` — acquisition task P3)* |
| Progressive networks | [[wiki/concepts/meta-learning.md]], [[wiki/concepts/continual-learning.md]] | *(no source in `raw/` — acquisition task P3)* |
| Episodic control | [[wiki/concepts/complementary-learning-systems.md]] | *(no source in `raw/` — acquisition task P3)* |
| Monte Carlo tree search / expert Go play | [[wiki/concepts/simulation-based-planning.md]] | *(no source in `raw/` — acquisition task P3)* |
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
