# h-DQN — Hierarchical Deep Q-Network: a Meta-Controller That Selects Object-Relational Subgoals

**Two deep Q-networks on two clocks. A meta-controller `Q₂(s,g)` picks a goal from a designer-given set and is trained on the environment's reward. A controller `Q₁(s,a;g)` is trained *only* on an internal critic's binary "goal reached" reward. Goals are stated as `⟨entity₁, relation, entity₂⟩` over detected objects. This is the one architecture in the wiki that explicitly **selects a subgoal sequence** at run time, and it can do so only because the subgoal vocabulary is handed to it.**

> **Provenance.** Kulkarni, Narasimhan, Saeedi & Tenenbaum 2016, *Hierarchical Deep Reinforcement Learning: Integrating Temporal Abstraction and Intrinsic Motivation*, NIPS 2016 / arXiv:1604.06057 (`raw/kulkarni-2016-hierarchical-deep-reinforcement-learning-temporal-abstraction-intrinsic-motivation.md`). Two experiments: a tabular 6-state stochastic chain (no deep networks) and Montezuma's Revenge (first room). Figures are described in prose only; curve values below come from the text. Everything below is from that source unless marked.

The wiki already cited it second-hand as the "hand-crafted subgoals" reference point on [[wiki/entities/feudal-networks.md]] and [[wiki/concepts/compositionality.md]].

---

## Architecture

| Component | Spec | Note |
|---|---|---|
| **Meta-controller** | `Q₂(s,g;θ₂)`, a policy over goals `g ∈ G`; SMDP target `Q₂*(s,g) = max E[Σ_{t'=t}^{t+N} f_{t'} + γ max_{g'} Q₂*(s_{t+N},g')]` | Trained on the **extrinsic** reward `f` only. One transition per option, `(s_t, g_t, F, s_{t+N})` |
| **Controller** | `Q₁(s,a;θ₁,g)`, goal given as an input (universal-value-function style, Schaul et al. 2015, not ingested) | Trained on the **intrinsic** reward `r(g)` only. **It never sees `f`** |
| **Internal critic** | Binary: `r = 1` iff the goal relation holds | Hand-coded. Montezuma: "agent entity reaches entity₂" |
| **Goal set `G`** | Chain: every state is a goal. Montezuma: objects from a **custom object detector** (doors, ladders, key) | The whole subgoal vocabulary comes from the designer |
| **Goal encoding** | A binary mask of the goal's image location, appended to the 4 stacked 84×84 frames | Goal enters the controller as an extra input channel |
| **Termination** | Goal reached, or episode ends | No interruption. The paper names "intermittently terminate ongoing options" as missing |
| **Replay** | Disjoint stores: `D₁` (10⁶, controller) and `D₂` (5·10⁴, meta-controller) | The two levels share no transitions and no gradient. Both networks are convolutional; feature sharing is permitted but not enforced |
| **Exploration** | `ε₂` annealed 1 → 0.1; **`ε₁,g` annealed per goal from that goal's empirical success rate** | Controller exploration is competence-indexed per goal |

**Training schedule (Montezuma).** Phase 1 fixes `ε₂ = 1`, so goals are drawn uniformly at random, and trains only the controller for ~2.3M steps. Phase 2 trains both levels jointly for ~2M more steps. So the controller learns under a random-goal curriculum *before* the extrinsic channel has any consumer. That is temporal severance first, then simultaneous operation.

---

## Results

| Domain | Result |
|---|---|
| **6-state stochastic chain.** Start `s₂`, terminal `s₁`. `right` succeeds only 50% of the time. Reward 1 at `s₁` if `s₆` was visited first, 0.01 otherwise | Q-learning converges to the 0.01 policy within 200 epochs. h-DQN (tabular) learns to pick goals `s₄`/`s₅`/`s₆` and reaches **~0.13** average reward. Visits to `s₃`–`s₆` rise over training. Mean of 10 runs |
| **Montezuma's Revenge, room 1** | ~**+400** per episode (key +100, door +300) after joint training. The paper's own comparisons: DQN 0, Gorila 4.16 |
| **Goal ordering** | Easy goals (right door, middle ladder) are mastered first; the key and bottom ladders come later. By the end the meta-controller picks key, bottom-left ladder and bottom-right ladder more and more often. An **easy-to-hard ordering emerges from the meta-controller's value estimates**, with no designed curriculum |
| **Sample trajectory** | key (dies at skull) → bottom-right ladder → key → top-right door. The meta-controller sequences subgoals and recovers after a failed attempt |

---

## Limitations

| Limitation | Consequence |
|---|---|
| **Goal set and critic are hand-built** (object detector, "reaches" relation) | The decomposition's *vocabulary* is given. Only its *sequencing* is learned. Automatic object discovery is the paper's first missing ingredient |
| **No flat baseline given the same object mask** | DQN and Gorila get neither the detector's output nor the 2.3M pretraining steps. The gain cannot be split between hierarchy and the object prior. This is the confound `T402` asks every hierarchy to remove |
| **Budget not matched, no variance for Montezuma** | Baselines are cited, not re-run. The Montezuma curves have no reported seed count |
| **One room only** | ~400 points, against ~2,600 for [[wiki/entities/feudal-networks.md]] and 1.7M for [[wiki/entities/go-explore.md]] |
| **Relation space is used only as `reaches`** | `⟨entity₁, relation, entity₂⟩` is binary, and `entity₁` is fixed to the agent. So the relational goal language is announced, not exercised. It is also pairwise, so it does not reach `G105`'s `n`-ary case |
| **Controller sees the full frame** | The goal mask is an added channel next to the raw state. Nothing makes the goal non-bypassable (`G59`) |
| **No memory** | Non-Markovian tasks need "a flexible episodic memory module", which the paper names and does not build |
| **Phase schedule not ablated** | No joint-from-start run is reported, so the value of the random-goal pretraining phase is unmeasured |
| **No opponent term on the internal-critic reward** (`G126`) | The controller is paid `r(g) ∈ {0,1}` for every achievement at every training amount; capture is contained only because it never sees what the meta-controller is paid for |

---

## Comparison

| | **h-DQN** | [[wiki/entities/feudal-networks.md]] | [[wiki/entities/option-critic.md]] | [[wiki/entities/diayn.md]] | [[wiki/entities/go-explore.md]] |
|---|---|---|---|---|---|
| Subgoal | detected object (state predicate) | unit direction in a learned latent space | none | discriminator region | archived cell (policy variant) |
| Vocabulary source | **designer** (object detector) | learned | — | learned, before any task | designer cell map `φ` |
| Selects a subgoal *sequence*? | **Yes**, `Q₂` over `G` | re-emits a direction every step | no | meta-controller over frozen skills | reads it off a stored trajectory |
| Lower level sees `r_ext`? | **No** (pure concealment) | yes, `R + αR^I` | only reward there is | no, disjoint phases | clipped env reward + path reward |
| Inter-level gradient | none (disjoint replay) | none | the whole coupling | none | — |
| Termination | goal predicate or episode end | none | learned `β` | fixed `k` | soft window `N_w = 10` |
| Montezuma's Revenge | ~400 (room 1) | ~2,600 | not reported | not reported | 1.7M / 97,728 |

---

## Reading in the core framing

| Element | [[wiki/concepts/latent-graph-discovery.md]] reading |
|---|---|
| Goal set `G` | A **hand-supplied vertex set**. Each goal is an object-anchored node, which is [[wiki/concepts/node-definition-problem.md]] answered by an object detector |
| Meta-controller | A value function over *which node to go to next*: planning on a coarse graph whose nodes are given and whose edges (`Q₂` transitions) are learned |
| Controller | Learns one family of edges into each node, shared across nodes through the goal input |
| Internal critic | The node-membership test. Binary, so an edge counts as traversed or not, with no partial credit |

**(brainstorm)** h-DQN is the mirror image of the discovery families on `G33`. Eigenoptions, DIAYN, option-critic, FeUdal Networks and CSCG each produce a vocabulary and never select a subgoal sequence from it at run time. h-DQN selects a sequence and never produces a vocabulary. Joining the two halves looks mechanical: feed the meta-controller a discovered vocabulary, e.g. CSCG community access points or DIAYN regions as `G`, with the internal critic set to "membership of that region". No source runs it. It is the cheapest test of whether the row's two halves compose.

**(brainstorm)** The per-goal `ε₁,g` annealed on success rate is a competence estimate kept *per subgoal*. It is the quantity [[wiki/concepts/intrinsic-motivation-typology.md]]'s competence family would turn into a goal-selection reward (competence progress). Here it modulates only the controller's exploration, never the meta-controller's goal choice. The emergent easy-to-hard ordering comes from `Q₂`'s extrinsic values instead. Routing `Δ` success rate into goal choice would turn the implicit curriculum into a learning-progress curriculum.

---

## Connections

- **[[wiki/concepts/temporal-abstraction-options.md]]** — the deep-network instance of that page's "innate / evolved" family: options whose subgoals are designer-given object predicates, justified by core knowledge, with a learned policy over them. It is the one entry on the discovery table that supplies the *selection* step and none of the discovery step.
- **[[wiki/entities/feudal-networks.md]]** — the successor that learns what this page hand-builds. FuN's Montezuma waypoints land at the locations h-DQN hard-codes. FuN's "purely feudal" ablation (Worker on intrinsic reward alone) is h-DQN's reward arrangement, and it underperforms full FuN (`T401`).
- **[[wiki/entities/option-critic.md]]** — the opposite corner on every design axis: no subgoal, one reward, gradient coupling between levels. h-DQN has a named subgoal, two rewards on two disjoint learners and no gradient between levels, so the pair spans `T367`'s routing space at its extremes.
- **[[wiki/entities/dqn.md]]** — the substrate used twice over. Both levels are DQN (convolutional stack, experience replay, frozen target) with the goal as an extra input channel. DQN's `0` on Montezuma's Revenge is the baseline cited, though it was never re-run with the same object prior.
- **[[wiki/entities/go-explore.md]]** — the null on the same game, and the control this page never ran. Both depend on a designer-given abstraction: an object detector here, a cell map there. Go-Explore's count-based baseline holds the abstraction fixed and changes the consumer. h-DQN has no equivalent control, so its ~400 cannot be credited to hierarchy (`T402`).
- **[[wiki/concepts/pseudo-reward-prediction-error.md]]** — the machine form of that page's signal in its purest arrangement: a binary pseudo-reward on reaching a designer-placed subgoal, trained into a controller that never sees primary reward. So the `r̃` : `r` ratio has no referent here, because the two rewards never meet in one learner.
- **[[wiki/concepts/intrinsic-motivation-typology.md]]** — a competence-family agent with that family's reward replaced by the extrinsic return at the goal-chooser. Goals are self-set episodes on an abstract clock and scored by binary achievement. Competence *progress* is tracked per goal but used only to anneal controller exploration, not to choose goals.
- **[[wiki/concepts/hindsight-goal-relabelling.md]]** — shares the goal-conditioned controller `Q(s,a;g)` and the binary achievement reward, but does not relabel. Every failed attempt at the key is stored under the goal "key" with reward 0, so the controller's pretraining phase is the sparse regime HER was built to escape.
- **[[wiki/concepts/compositionality.md]]** — the "goals" row of that page's table, now primary-sourced: subgoals are relations over detected entities, sequenced into a larger goal. The relation slot is announced as general but only `reaches` is ever used.
- **[[wiki/concepts/core-knowledge.md]]** — the stated justification for the goal space: infants parse scenes into cohesive, continuous entities and set subgoals in that space. h-DQN installs the object system as a detector rather than learning it, which is the nativist move applied to subgoal vocabulary.
- **[[wiki/entities/intrinsic-curiosity-module.md]]** — the same phrase, "intrinsic motivation", naming the other family: here a binary reward for reaching a designer-given goal (competence), there a dense forward-prediction error with no goal (knowledge). That source proposes its learned exploration skill as a low-level primitive for a hierarchy of this kind, and the combination is unbuilt (Pathak et al. 2017).
- **[[wiki/entities/hiro.md]]** — the same two-reward, two-learner arrangement (lower level on intrinsic reward only, disjoint replay, no inter-level gradient) with the object vocabulary replaced by the raw state space and a graded distance reward. It runs the schedule ablation this page lacks on a different architecture: pretraining the lower level on random goals and freezing it loses on the navigation tasks and wins only on the homogeneous one (Nachum et al. 2018).
- **[[wiki/entities/hac.md]]** — the same binary achievement reward on a goal-conditioned executor, with the object vocabulary replaced by raw states and the sparsity fixed by relabelling rather than by random-goal pretraining. All levels train from the start, and three levels are stacked rather than two (Levy et al. 2019).
