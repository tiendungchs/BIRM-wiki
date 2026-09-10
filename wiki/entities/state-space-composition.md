# State-Space Composition (Bakermans et al. 2025)

> **Provenance.** `raw/bakermans-2025-hippocampal-composition-and-replay.md` — Bakermans, Warren, Whittington & Behrens, *Nat. Neurosci.* 2025, "Constructing future behavior in the hippocampal formation through composition and replay". Preregistered on bioRxiv 2023; the neural tests below were added at review. Code: `github.com/jbakermans/state-space-composition`.

**A hippocampal state space is not learned from transitions — it is *assembled* at entry from cortical building blocks whose dynamics are already known, so a novel configuration of walls, objects and rewards comes with its policy already attached; replay is the operation that writes the assembly to every location without going there.**

This is the model behind the "bases that come pre-credit-assigned" claim on [[wiki/concepts/compositionality.md]], which until now existed in the wiki only as a paragraph of the Whittington et al. 2022 review. It supplies the formalism, a zero-shot behavioural result, a theoretical separation from Dyna-style replay, and the wiki's first *measurement* of replay writing structural content into remote place fields.

---

## The formal claim

| Element | Statement |
|---|---|
| **Decomposability** | The world model splits into sub-blocks `z = (z¹, z², z³, …)` |
| **Independent dynamics** | Each block advances under its own action-driven update, `z_t^i = g(z_{t-1}^i)` — no cross-block term |
| **Consequence** | Any *new configuration* of blocks has predictable dynamics with **no extra learning**. Transitions are inferred, not observed |
| **Hippocampal role** | A hippocampal cell is the **conjunction** (outer product `c = a ⊗ b`) of the blocks active now — it *specifies which combination this situation is*, and stores it in recurrent weights |
| **Cortical role** | The blocks themselves. Biology supplies them ready-made: grid cells (space), border-vector, object-vector and reward-vector cells ([[wiki/entities/entorhinal-cortex.md]]) — each a map centred on its referent, each path-integrable, each already generalising across environments |

**Why vector cells are the right primitive.** A population of object-vector cells is a *complete map* in the object's own frame, updatable by self-motion exactly as a grid code is. So it can be carried to a location the animal has never occupied by path integration alone — which is what makes offline construction possible at all ([[wiki/concepts/path-integration.md]]).

**Encoding used (discrete case).** Vector to object `o` from location `x` = `concat(onehot(d_N), onehot(d_E), onehot(d_S), onehot(d_W))`, with `−1` entered for actions pointing away. Four cells active per population per location. A wall is *two* vector populations, one centred on each end. Continuous case: 2-D Gaussian firing fields on a square grid centred on the object.

---

## The distinction that is new: structural–structural conjunction

The wiki already had two conjunctive-hippocampus models. The axis that separates them is *what gets conjoined*, and it sets what generalises.

| Model | Conjunction | Generalises | Zero-shot output |
|---|---|---|---|
| REMERGE | sensory ⊗ sensory | Within one environment (transitive inference) — never across, since no abstract structure is in the representation | — |
| [[wiki/entities/tolman-eichenbaum-machine.md]] | **structural ⊗ sensory** (grid ⊗ lateral-entorhinal code) | Sensory inference across environments | **what you will see** |
| **This model** | **structural ⊗ structural** (grid ⊗ object-/border-/reward-vector) | *Behaviour* across environments | **what you will do** |

The consequence the authors press: predicting an action requires *global* relational knowledge (a wall to the east, a reward to the south) to be present in the *local* representation at the current state. TEM's conjunction carries local sensory identity; it cannot say what to do. Getting global knowledge into every local representation is the job the paper assigns to replay.

---

## Results

### 1. Compositional state spaces give zero-shot policies

Setup: a feedforward policy map `f(s) = a`, three ReLU hidden layers (1,000/750/500 discrete; 3,000/2,000/1,000 continuous), trained by **supervised learning on ground-truth optimal actions** — not RL. Two state representations compared.

| Agent | State `s` | Same environment | New reward location | New walls + reward |
|---|---|---|---|---|
| Traditional | absolute location `x` | Learns arbitrarily complex policies | **Fails immediately** | **Fails immediately** |
| Compositional | concatenated vector codes `(w, o, r)` — space deliberately *excluded*, not needed for action selection | ✓ | ✓ (trivially) | ✓ including trajectories that must route around multiple walls |

Holds in discrete grid worlds and in continuous 1 m × 1 m arenas. Training: 25 environments in parallel, 200 (discrete) / 500 (continuous) samples each, ×100 rounds; tested on 25 held-out environments.

**Read as an architecture claim:** if hippocampal cells form the state space a policy is learned over, they must be built on pre-existing relational structure. Credit assignment becomes retrieval-and-compose; the only online work is inferring *which* blocks apply. The paper's phrase is that the state space arrives **"pre-credit-assigned."**

### 2. Latent learning falls out

An agent that path-integrated the wall vector while exploring without reward needs **a single visit** to any state after discovering the reward to have the optimal policy there. An agent without latent learning must rediscover the wall before it can act optimally from states behind it. Measured as policy success by 1st…15th encounter, 25 environments. This is Tolman's latent-learning result derived from composition rather than from value.

### 3. Constructive replay is trajectory-independent — and Bellman backup is not

The sharpest theoretical result, and the one that gives [[wiki/empirical-tensions.md]] T30 an instrument.

| Replay account | What one replay step does | Convergence requirement |
|---|---|---|
| **Bellman backup / Dyna** | Updates a state's value by comparison to its neighbour | Value can only converge in one pass if the replay trajectory *is* the reverse of the new optimal policy — i.e. requires prescience. Random-trajectory replay needs many passes |
| **Compositional memory (this model)** | Path-integrates the vector blocks, binds them to the path-integrated location, writes the conjunction | **One visit per state, whatever the trajectory.** Path integration through a world model is path-independent, so the composed content at each state is identical regardless of the route taken to it |

Simulation confirms the separation under a `γ = 0.7`, `α = 0.8` backward-`Q` control. In a noisy homing task (explore from home, then escape home fast; replay 5× every 4 steps), replay cuts homing error sharply at all noise levels and exploration lengths, and reaches a given error with **fewer replays** than `Q`-update replay — because `Q` backups suffer path-integration noise too, assigning credit to the wrong state.

**Cost of the mechanism:** it is path integration all the way down, so replay writes *noisy but unbiased* memories. Repeated replay averages the noise out — which makes "consolidation by repetition" and "construction" the same operation rather than two, and gives a principled reason for replaying a state more than once.

**Agent update rule** (both online and in replay): the represented vector is a mixture of the path-integrated estimate and what memory returns at the newly observed location, `s ~ w · p_PI + (1 − w) · p_M`. In replay the memory term is dropped and the location key is itself path-integrated, so errors enter both key and value.

### 4. Empirical: replay writes new place fields where the replay spike was

Two rodent datasets, reanalysed.

| Dataset | Measurement | Result | Caveat |
|---|---|---|---|
| Alternating home–away well task (ref. 43) | Sharp-wave-ripple replays decoded **leave-one-neuron-out**, then each spiking neuron's location in the replay interpolated; rate map differenced before vs after | Positive rate-map change concentrated **exactly at the interpolated replay-spike location**, for replays *from the home well* but not for time-matched control replays elsewhere. Survives restricting to replay spikes >50 cm from home | The effect size averaged over the population is small — expected, since only the first replay creates a field from scratch and stable place cells dilute the mean |
| Four-room reconfigurable maze, doors lock mid-session (refs. 44/45) | "Nonlocal door spikes" (a cell firing outside all its fields while the animal sits at a closed door) used as a replay proxy | Cells that "replay" at the door are significantly more likely to acquire new place fields afterwards (linear regression, one-tailed *t*) | **The authors flag this as suggestive only** — no SWR detection, no decoded replay in this dataset. Needs simultaneous recording of enough cells to decode trajectories |
| Home–away task, across days (home well moves) | Correlation between the rate-map change aligned on the *current* home and the change aligned on the *previous* home | Significant **negative** population bias — a cell gains a field at a fixed vector to the new home and loses it at the same vector to the old one, the signature of a landmark cell. The cells showing it are the ones with the **highest replay overlap**, and replay locations correlate with change locations | Cells cannot be tracked across days; the design is a within-day cumulative-change analysis |

Row 1 is the load-bearing one: it is the first recording in the wiki where a ripple's *content location* predicts *where that cell's tuning changes*. Row 3 makes the change compositional rather than merely reward-driven — when the landmark moves, replay rebuilds the field at the same relative vector.

**One prior measurement reads as this model's building block seen directly — and as a warning about the allocentric slot.** In a hairpin maze the entorhinal-hippocampal map fragments into a *repeating* per-compartment submap, the same field sequence unfolded in every geometrically identical arm and re-zeroed at each turn (Derdikman et al. 2009, [[wiki/concepts/path-integration.md]]). That is reuse of a structural block across configurations, measured sixteen years before this model proposed it, and it is stronger than the vector-cell case because what repeats is a whole local *state space* rather than one referent's frame. The warning is in the same result: this model's blocks are path-integrated in a **global allocentric frame** supplied by the grid code, and in a partitioned environment that frame is exactly what does not survive — the grid stops being a single chart. Under composition, `x` is a block like any other and its fragmentation is unremarkable; under this model's replay mechanism, the location key that binds every conjunction is the fragmented variable, so a replay crossing a compartment boundary has no continuous address to write to. Nothing in the paper or in the wiki says what happens there ([[wiki/empirical-tensions.md]] `T347`).

---

## Predictions still open

- **Simultaneous grid and object-vector replay in two coordinate systems.** Both populations should replay to the same location, one allocentrically and one object-centrically, since the conjunction is what gets stored. The paper cites one report of coherent entorhinal–hippocampal replay and one of *independent* replay, and does not adjudicate — the prediction is untested either way.
- **Landmark cells should appear in replay before they appear in navigation.** Tested indirectly above; a direct test needs a first-discovery event with decodable replay.
- **A normative theory of prioritised replay from construction utility** — "create memories where they matter most" (Supplementary; not read here). It would be a third derivation alongside `Gain × Need` and recall-gating ([[wiki/concepts/replay-prioritisation.md]], [[wiki/concepts/recall-gated-consolidation.md]]).
- **Two roles for sleep replay**: (i) build *new cortical primitives* where existing blocks modelled experience poorly; (ii) train the policy map `f` on **imagined** environments by sampling random wall/reward vector codes — a Helmholtz-machine-style inverse-model sleep phase that, because the forward model is compositional, can generate configurations never experienced.

---

## Limitations

| Limitation | Detail |
|---|---|
| **Primitives are given, not learned** | Vector cells are handed to the model by biology. Where a block comes from in a non-spatial domain is unaddressed; building new primitives is deferred to sleep replay as a sketch (`G4`, `G22`) |
| **Object identity and slot order are hand-set** | The policy input concatenates object codes "in a consistent order, for example, first the reward and then the two walls" — so the agent is *told* which population is a reward and which is a wall. The binding problem the composition is supposed to solve is partly solved by the input format |
| **The policy is trained by supervision on optimal actions** | Not RL. The zero-shot generalisation result is about representation, and says nothing about whether the policy could be *acquired* from experience in these state spaces |
| **Memory is a Python dictionary** | Key-value store standing in for a Hopfield/attractor conjunctive memory, and a location ID standing in for a grid code. The authors state the abstraction changes no principle and point to [[wiki/entities/vector-hash.md]] for the equivalence, but nothing here runs in the attractor |
| **All demonstrations are spatial** | Nonspatial and hierarchical composition are asserted and relegated to the Supplementary |
| **Independent sub-block dynamics is a strong assumption** | The model is exact only where blocks do not interact. A wall that *moves* a reward, or an object whose affordance depends on another, breaks `z_t^i = g(z_{t-1}^i)` and nothing detects the breakage |
| **The second dataset's replay measure is a proxy** | Stated by the authors (above) |

---

## Comparison

| Model | Where the state space comes from | Cost of a new environment | What replay does |
|---|---|---|---|
| **State-space composition** | Assembled from cortical blocks at entry | ~Zero for behaviour; one memory write per state | Path-integrates blocks to remote states and binds them |
| [[wiki/concepts/successor-representation.md]] | `S = Σ γⁿ Tⁿ` learned from transitions | Relearn `S` (policy-dependent, brittle to local changes) | Propagate value (Dyna) |
| [[wiki/entities/tolman-eichenbaum-machine.md]] | Structural code `g` reused, sensory binding rewritten | Zero for *prediction*, nothing for *policy* | Train the generative model |
| [[wiki/entities/cscg.md]] | Learned clone transition matrix, per environment | Full relearning | — |
| [[wiki/entities/spacetime-attractor.md]] | Learned transition superset, masked by wall input | Zero (inhibitory gating, no plasticity) | Proposed as the teacher for the superset — **this page is that teacher, now measured** |
| [[wiki/entities/vector-hash.md]] | Grid scaffold + content-free hash | Zero | — |

---

## Connections

- **[[wiki/concepts/compositionality.md]]** — supplies the formalism and the measurement behind that page's "bases that come pre-credit-assigned" section: decomposability plus independent sub-block dynamics is what makes a novel configuration's transitions *inferable*, and the structural–structural conjunction is what upgrades composition from predicting observations to predicting actions.
- **[[wiki/concepts/offline-replay.md]]** — turns that page's "offline state-space construction" job from a prediction into a recording, and adds the property that separates it from every value-propagation job listed there: composition by path integration is **trajectory-independent**, so one replay visit per state suffices whatever route the replay takes.
- **[[wiki/concepts/path-integration.md]]** — the load-bearing dependency, used in a new place: blocks are path-integrated *offline and in parallel* (allocentric and object-centric simultaneously), which is what lets a memory be written at a location the agent has never occupied — at the price that replay-built memories inherit integration noise.
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — the same conjunctive-hippocampus architecture with the other operand swapped: TEM conjoins structure with *sensory* codes and zero-shot predicts what you will see; conjoining structure with *structural* vector codes zero-shot predicts what you will do.
- **[[wiki/concepts/cognitive-map.md]]** — makes element 3 (route planning) a property of the representation rather than a search: a reward-vector code *is* a policy, so the map does not need to be traversed to be used.
- **[[wiki/entities/entorhinal-cortex.md]]** — supplies the building blocks the model consumes: border-, object- and reward-vector cells are reusable because each is a full path-integrable map in its referent's frame, and their generalisation across environments is exactly the reusability the composition requires.
- **[[wiki/concepts/successor-representation.md]]** — the model this one is built against: an SR must be relearned when reward or local transitions change, where a composed state space changes only in which blocks are active, so the "predictive map" and the "pre-credit-assigned basis" are rival answers to the same generalisation demand.
- **[[wiki/entities/spacetime-attractor.md]]** — the consumer this page is the proposed producer for: the STA needs its adjacency superset taught from experience and names hippocampal replay as the only offered route, which is the operation measured here.
- **[[wiki/concepts/replay-prioritisation.md]]** — a third candidate utility for ordering replays, alongside `Gain × Need` and recall-gating: construct memories where a composition is missing, which unlike the value-based criteria has no dependence on reward at all.
- **[[wiki/concepts/event-segmentation.md]]** — supplies the operation this model needs and does not have: composition assembles blocks *within* a state space and says nothing about where one ends, while the measured entorhinal code starts a fresh frame at every geometric partition, so "which blocks apply here" presupposes a segmentation that has to be computed first.
- **[[wiki/concepts/latent-graph-discovery.md]]** — a route to the instance-graph that never estimates edges: the graph's transitions are *inherited* from the blocks' own dynamics, so what is discovered per environment is a small set of block identities and offsets rather than a transition structure.
- **[[wiki/concepts/complementary-learning-systems.md]]** — sharpens the division of labour: the slow store holds the *primitives* and the policy over them, the fast store holds only *which primitives are where*, so what consolidation must extract is a new primitive rather than a new map.
