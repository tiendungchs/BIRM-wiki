# Active Vision and Deictic Codes — Looking as Variable Binding, Priced in Actions

**A fixation is a pointer. Orienting the body at a point in the world binds the neurons downstream of the fovea to whatever is there, so a cognitive program can hold a variable by *keeping the eye on it* instead of by copying its properties into a store. The consequence is an architecture in which almost no scene representation is built: information is left in the world and fetched just before it is used, the number of simultaneously bound variables is 2–3, and the observed human strategy is the *slowest* one available because carrying a value is more expensive than looking again.**

> **Provenance.** Ballard, Hayhoe, Pook & Rao 1997, *Deictic codes for the embodiment of cognition*, Behav. Brain Sci. 20(4):723–767 (`raw/ballard-1997-deictic-codes-for-embodiment-of-cognition.md`). A *Behavioral and Brain Sciences* target article: a computational framework plus original eye-tracking experiments (block copying, seven subjects, replicated with real blocks in ~20), plus robot and reinforcement-learning simulations. The file carries the peer commentary and the authors' response; material drawn from the response is marked as such. **Conversion is `LOSSY`** (`pdf2md` over the open author copy) — every number below is one the prose repeats or that appears in a table; the figures are unrecoverable.

This page is the *overt* half of [[wiki/concepts/visual-routines.md]]. That page's routines are internal shifts measured under presentations too brief for saccades, and it states its own boundary: how routines schedule actual fixations is the deictic question. This is it, and it arrives with a currency attached.

---

## The embodiment level — why `1/3` second is a level and not a duration

Newell's hierarchy, with the authors' experimental corrections. Each level composes ~10 operations of the level below, so abstraction and slowness rise together at geometric rates.

| Level | Scale | Primitive | Example |
|---|---|---|---|
| Cognitive | 2–3 s | Unit task | Dialling a phone number |
| **Embodiment** | **0.3 s** | **Physical act** | **An eye movement, a hand movement, a spoken word** |
| Attentive | 50 ms | Deliberate act | Noticing a stimulus, a pattern classification, an attentional shift |
| Neural circuit | 10 ms | — | Lateral inhibition |
| Neuron | 1 ms | Spike | — |

**The level's defence, from the authors' response, is the part worth keeping.** Below ~0.3 s there is no time to communicate with the world except by reflex, so the computation is necessarily internal. Above ~10 s there is time to run internal simulations, so the computation is internal again for the opposite reason. **0.3–1 s is the only band in which behaviour and world interact** — "just enough time to look up what to do next, before one has to do it." Everything on this page is a claim about that band; commentators (Feldman, Fuster, Wilson) rejected the specificity and the authors did not concede it.

---

## Pointers versus copying — the computational argument

The silicon analogy the paper argues from: a symbol `the-bee-chasing-me` whose properties live at some address. Re-referring it from beeA to beeB costs **one cell write** under a pointer discipline and a full copy of every property under a contiguous-storage discipline.

| | Copy the properties | Bind a pointer |
|---|---|---|
| Change of referent | copy `k` values | write one address |
| Cost in cortex | most cortical neurons are **place-coded** and cannot be rewritten at all | move the eye, or move a neural focus |
| Scaling with task size | grows with the scene | **flat** — tower-copying needs 3 pointers for a tower of any height |

**The counted alternative, from the paper's own footnote.** A nondeictic solution to the block-copying task catalogues each block with a unique identifier and searches the space of relations among coded items. For all configurations of just **20 blocks that is 43 billion relationships**. This is the wiki's cheapest statement of why a full scene description is not a design option, and it is a *combinatorial* argument rather than a capacity one.

**Two pointing devices, both deictic.** *Mechanical* — fixation, grasp, head orientation, a hand preshape: physical orientation does the referring. *Neural* — covert attention, which creates the same momentary reference without moving anything. The paper treats them as one mechanism at two costs, and the response adds that a neural pointer is recruited exactly when the required region is **not currently foveated** (with the hippocampus nominated, on no direct evidence, as the structure that reactivates what physical pointing activated — `L4`, treat as speculation).

**Why the minimum number.** If a solution is searched for sequentially, the cost scales as **`(MV)^s`** — `M` pointers, `V` visual/manual routines, `s` program steps. Adding a pointer multiplies the search space at every step, so there is optimisation pressure toward the fewest-variable program, not merely tolerance of a limit. A second reason is sufficiency: McCallum's history-tree learner needs **2–14** short-term features for simulated highway driving.

---

## The block-copying experiment — the page's empirical core

Three areas on a display: **model** (the pattern to copy), **resource** (blocks to draw from), **workspace** (the copy). Colours randomised so blocks cannot be grouped into larger shapes, which separates the perceptual from the motor component. Subjects were told only to go **as fast as possible**.

Coding of one block-move cycle by where the eyes went: `M` = model, `P` = pickup (resource), `D` = drop (workspace).

| Strategy | Time | Items carried in memory | Frequency |
|---|---|---|---|
| **MPMD** | **3.0 s** | **none** | **modal for all seven subjects, by a wide margin** |
| PMD | 2.5 s | colour | — |
| MPD | 2.0 s | offset (location) | — |
| PD | 1.5 s | colour and offset | almost always only the last one or two blocks |

**The result is that the cheapest-memory strategy is the slowest one, and subjects chose it under a speed instruction.** Memorising saves a full second per block and is well inside anyone's capacity — four two-block chunks would need four looks, where subjects made as many as **18** fixations in the model area for one pattern, commonly more than one *per single block*. The inference: **the carrying cost of a working-memory item exceeds the cost of re-acquiring it**, so the eye is used as a fetch instruction rather than as a loader.

Three controls that make it an exchange rate rather than an artefact:

| Manipulation | Effect | What it rules out |
|---|---|---|
| Separate model and workspace by **70°** (raising the price of a look) | fixations per block **1.3 → 1.0**; subjects memorise more | the behaviour is a *trade-off*, not a fixed strategy — looking and remembering are substitutable at a measurable rate |
| **Monochrome** blocks (chunking now possible) | **0.7** vs 1.3 fixations per block; subjects copy whole subpatterns without consulting the model | the extra looks are not idle time while the slower hand catches up |
| Model **occluded** during placement (from the response) | number of looks comparable to the fully visible case | subjects *resist* memorisation rather than defaulting to it |

**The saccade-contingent change experiment — what a pointer's referent actually contains.** The colour of an uncopied model block was changed during the saccade into the model area, on ~25% of fixations:

| When the change was made | Extra fixation time | Reading |
|---|---|---|
| **Before pickup** (subject is about to acquire colour) | **+50 ms** | colour is *not* retained from earlier model fixations, despite several having occurred — the saccade was programmed without it |
| **After pickup** (subject is returning for location; colour now task-relevant and held) | **+129 ms** | the bound value is checked and a mismatch costs a revision of the control program |

Subjects were mostly **unaware** of the change and resolved it by fixating a neighbouring block matching the colour they were holding — i.e. the held variable won against the world. From the authors' response: told afterwards that colours had changed and asked how many, the modal answer was **one**; the modal true number was **seven**. The slow verbal level can report only the current contents of working memory, which is the paper's account of why the world looks stable.

**What survives a saccade is exactly what the current step of the program needs, and nothing else.** That is the finding, and it is the strongest evidence in the wiki for a representation that is *task-indexed* rather than input-indexed.

---

## Identification and location — a decomposition by complexity, not by anatomy

The general vision problem is matching **many** internal models against **many** image parts simultaneously. The claim is that this corner is intractable and that deictic strategies exist to avoid entering it:

| | **One model** | **Many models** |
|---|---|---|
| **One image part** | **I. Deictic access** — identity *and* location known; use the referent as a unit | **II. Identification** — search the model database against the **foveated** patch only |
| **Many image parts** | **III. Location** — search the image for one known model's features; emit a saliency map and a saccade target | **IV. Too difficult** |

Both tractable corners are tractable *because a pointer has already fixed one side of the match*. Fixation is what converts IV into a sequence of IIs and IIIs.

**Consequence for the two-stream question.** The authors read Goodale & Milner's identification/location split as **functional rather than architectural** — both streams participate in both operations. Their proposed division of labour (sharpened in the response): to **identify**, the dorsal stream targets the fovea at a task-relevant location so the ventral stream's object machinery can match a foveal feature vector; to **locate**, a remembered description is propagated *down the ventral feedback pathways*, correlated against bottom-up features at every location and multiple scales, and the resulting **saliency map** lives in the dorsal stream. So the location computation *begins* in the ventral stream and *ends* in the dorsal one — which is not a partition of content by pathway at all. Reported speed-ups on real images for each specialised routine are "dramatic" with no figure given.

---

## What a pointer points at

| Element | Content | Status |
|---|---|---|
| **Base representation** | A **81-element spatiochromatic vector per image location**: 3 colour channels (`R+G+B`, `R−G`, `B−Y`) × 3 octave-separated scales × 9 steerable filters (2 first-, 3 second-, 4 third-order Gaussian derivatives) | `L4`. The authors call the exact composition unimportant and, in the response, call the vector itself **"a straw man"** standing in for the products of a learning algorithm |
| **Pointer referent** | That vector at the pointed location — "for all practical purposes unique", so each location gets a distinct descriptor | the pointer is small; **its referent is iconic and large** |
| **What is actually bound** | Almost never the whole referent — in the blocks task, a colour at one moment and a relative offset at another, *from the same fixation location* | the load-bearing claim: **the same image data yields different bound values at different points in one task** |

**Three frames, and the one that does the work** (the paper's Fig. 14): `T_sr` scene→retina, `T_os` object→scene, `T_or` = their composition. The useful case: the **resource area is defined as a template in `T_os`** and mapped into retinal coordinates by `T_sr`, which constrains the saliency search for "a yellow block" to that region regardless of current eye position. A task constraint is stored as a *transformation*, not as a list of candidate locations — and a remembered object out of the current field of view can be reached by composing the two, which is the paper's answer to "people reach for things they cannot see, so they must hold a 3-D model."

**Cortical assignment** (`L3`/`L4`, offered as speculation): cortex is the content-addressable store holding pointer *referents* — retinotopically indexed on the thalamic/visual-cortex side, model-indexed on the inferotemporal side — while the **basal ganglia** hold the *program*: which sensory processing to run, in what order, and **when the bound value is to be used**. The argument's one behavioural hook is that Parkinson's patients show working-memory deficits on a task very like the blocks task; the anatomy (Yeterian & Pandya's extrastriate → caudate/putamen projections, Schultz's reward-prediction units) is connectivity and physiology rather than a test of the assignment.

---

## Who sets the pointer — the paper's own quarrel, logged as `T387`

The authors name their difference with Pylyshyn explicitly and it is the sharpest architectural claim on the page:

> Pylyshyn conceived the pointers as a product of **bottom-up** processing, "and therein lies the crucial difference": deictic pointers are required for variables in a cognitive **top-down** program.

The evidence offered for the top-down side is the one datum that cannot be explained by the display, because the display was identical: the *same* fixated location in the model area yields a **colour** at one point in the task and a **relative offset** at another, and the saccade-contingent change costs +50 ms or +129 ms depending only on which of the two the current step had bound. Against this, [[wiki/concepts/visual-routines.md]]'s **indexing** operation is stimulus-driven by construction — a shift to an odd-man-out on a pre-computed property — so the wiki now holds both positions from two sources that agree about almost everything else. Logged as `T387`; the reconciliation that indexing *proposes* candidates and the program *binds* among them is stated by neither and carries a testable cost (a task-relevant item that is not an odd-man-out should then require a serial scan).

---

## Teleassistance — the control budget, measured

A robot opens a door; a human operator supplies only a three-sign deictic vocabulary and the autonomous routines do the rest.

| Sign | Binds |
|---|---|
| POINT | a **reach axis** relative to the pointing direction, independent of world coordinates |
| PRESHAPE | a **new spatial frame centred on the palm**, inside which flexing the fingers toward the origin plus a force loop suffices to grasp — so the *same* grasp action applies to a spatula, a mug or a doorknob by changing the preshape |
| HALT | punctuation between motor programs |

**Executive control occupies 22% of total task time.** The pointers are needed only to *initiate* the lower-level primitives; the rest runs open-loop against a local frame. This is the page's cleanest quantitative statement of what a deictic interface buys: a 4–5× reduction in how long a controller must be engaged, with the saving coming from binding a frame rather than from issuing trajectories.

---

## Working memory, re-read

The paper's inversion, and it is a position the wiki should carry explicitly:

> Capacity limits are not a constraint on processing. They are **an inevitable consequence of a system that binds deictic variables and holds only what the current step needs**, and "fixation is a choice of an external rather than an internal pointer."

| Standard reading | Deictic reading |
|---|---|
| ~4 slots, a resource to be filled | ~2–3 *simultaneously bound* pointers, used **below** capacity by preference |
| Attention is a limited mental resource | Attention is a **pointer**; its selectivity has a computational rationale (Allport's objection — "limited resource" redescribes the phenomenon without explaining it) |
| Phonological loop / visuospatial sketchpad are architectural modules | They are separable only to the extent the *tasks* are, and to the extent the modalities recruit different cortex — a consequence of use, not a design |
| Capacity is what the task must be fitted into | The program is **structured to minimise instantaneous load**: memorising three blocks at once holds state across the whole sub-pattern; MPMD holds almost none |

**Where this lands in the wiki.** [[wiki/concepts/working-memory.md]] carries several stores and prices maintenance in gains and thresholds; none of its designs predicts that an agent would *decline* to use available capacity at a measured cost in time. Ballard's account is the only one here that makes that prediction and the only one with the measurement.

---

## Reading in the core framing

| Element | [[wiki/concepts/latent-graph-discovery.md]] reading |
|---|---|
| Fixation | An **edge traversal that is also the read**: moving the pointer and fetching the value are one action |
| Pointer referent | The node's content, fetched on demand and never cached whole |
| The 2–3 pointer budget | The traversal frontier: how many nodes may be simultaneously *held* while the walk continues |
| `T_os` / `T_sr` | A task constraint stored as a **coordinate transform over the graph** rather than as a set of admissible nodes |
| Just-in-time binding | The graph is never materialised; only the sub-structure the current step reads exists at any instant |
| The `(MV)^s` scaling | The price of the frontier: each extra held node multiplies the search at every step |

**(brainstorm) The wiki has been costing perception in parameters and passes; this source costs it in actions, and one benchmark already agrees.** [[wiki/entities/arc-agi-3.md]]'s RHAE (relative human action efficiency) divides a human's first-run action count by the agent's — the same currency, against the same reference class, for the same reason. What Ballard supplies that the benchmark does not is the **human-side decomposition**: 1.3 looks per block, 3.0 s per cycle, 22% controller occupancy, an exchange rate between a look and a remembered item that moves when the price of looking moves. An agent scored on actions and never asked how many of its actions were *perceptual* is being scored on a sum whose terms nobody has separated — and the human number for the perceptual term exists.

**(brainstorm) "Do it where I am looking" is a binding mechanism that costs one degree of freedom instead of `D`.** Every binding scheme in the wiki — [[wiki/concepts/tensor-product-representation.md]], [[wiki/concepts/vector-symbolic-binding.md]], synchrony — pays in representational dimensions to keep role and filler separable. Deictic binding pays in **serial time**: one referent at a time is admitted, and the role is "wherever the effector is pointed". That is the same bottleneck-derived binding [[wiki/concepts/visual-routines.md]] derives from a narrow read-out channel, with the channel's aperture now set by a body part and the cost now measurable in milliseconds. Its distinguishing prediction is the one the colour-change experiment reports: **a bound value that the world contradicts is not automatically corrected** — the subject acts on the held colour and does not notice.

---

## Limitations

- **The deictic state representation is hand-designed, which is the gap this page does not close.** The blocks reinforcement learner runs on **16 bits** — 4 global features (`red/green/blue-in-scene`, `object-in-hand`) plus 12 accessed through the two pointers (fixated and attended colour, shape, stack height, table-below, hand, plus two alignment bits) — and a 14-action repertoire. Every one of those features was chosen by the authors. So the paper demonstrates that a *small* task-indexed representation is sufficient and supplies no mechanism that would have produced it (`G73`).
- **Two pointers were needed because one aliases.** With fixation alone, "fixating a blue block" is ambiguous between *pick it up* (top of stack) and *go look at the green one* (on the table). Adding attention as a second pointer disambiguates. This is the deictic representation's known hazard — reduced state buys tractability and buys perceptual aliasing with it — and the paper records the symptom without naming a general remedy.
- **Learning is absent and conceded.** The authors agree with their commentators that learning is "an absent but essential feature of any deictic account" and cite work in progress. Nothing in the target article learns a routine, a pointer schedule, or a feature.
- **The blocks task is special by the authors' own admission** — its scale forces a normally covert strategy to become overt. Whether the same budget governs tasks that fit inside one fixation is inferred from chess, reading and driving eye-movement studies, not measured.
- **The `1/3` second level is contested** by three commentators as either too specific (Feldman) or not fundamental (Fuster, Wilson); the authors defend it and the disagreement is unresolved in the text.
- **The cortical and basal-ganglia assignments are `L4`.** Cortex-as-pointer-store and basal-ganglia-as-sequencer are argued from connectivity and from a single Parkinson's working-memory result; no prediction of the assignment is tested.
- **The base feature vector is disowned by its own authors** ("a straw man"), so the identification and location routines are demonstrated over a representation the paper does not defend.

---

## Open problems

- **Nothing schedules the fixations.** The paper shows *that* humans serialise and *what it costs*; the policy that emits the next look — the assembly problem of [[wiki/concepts/visual-routines.md]] with an effector attached — is not supplied. `G73`, `G75`.
- **The look/remember exchange rate has one data point and no model.** 70° of separation moves 1.3 looks per block to 1.0. Nothing predicts the slope, and no architecture in the wiki has a parameter that would.
- **The perceptual share of an action budget is never reported.** No agent result in the wiki separates actions spent acquiring information from actions spent changing the world, which is the split this source measures in humans (`G74`, [[wiki/entities/arc-agi-3.md]]).
- **Aliasing under a reduced deictic state has no general fix.** Adding a pointer is the paper's repair and it re-enters the `(MV)^s` cost it was avoiding; nothing says how many pointers a task needs before it is run.
- **No machine architecture here declines capacity it has.** The measured human preference for the slowest, lowest-memory strategy is a behaviour no wiki model would produce, and no objective in the wiki penalises carrying a value.

---

## Connections

- **[[wiki/concepts/visual-routines.md]]** — the same programme with the effector added: that page's routines are internal shifts measured under presentations too brief for saccades and explicitly defer overt fixation scheduling to this one, and this page answers its *incremental representation* question in the negative — the goal-dependent store is largely not built, because the world is left in place and re-read, so what persists across a saccade is only the one or two values the current step binds.
- **[[wiki/concepts/working-memory.md]]** — the measurement no store on that page predicts: subjects use working memory **below capacity** at a cost of 1.0–1.5 s per block under a speed instruction, so the carrying price of an item exceeds its re-acquisition price, and capacity limits read as a consequence of deictic binding rather than as a constraint the program must be fitted into.
- **[[wiki/concepts/attention.md]]** — attention re-derived as a pointer rather than as a resource: its selectivity gets a computational rationale (bind one referent so a decision can be made on it) instead of a capacity redescription, and covert and overt selection become one mechanism at two prices, with the neural pointer recruited exactly when the target is not foveated.
- **[[wiki/concepts/information-sampling-vs-search.md]]** — supplies the missing half that page names: a query's price, in the same units as its payoff. Looking is priced against the cost of *carrying* the value rather than against uncertainty, the exchange rate is measurable (1.3 → 1.0 looks per block when the saccade amplitude rises to 70°), and it moves the wrong way for any policy that maximises expected information gain per unit time.
- **[[wiki/concepts/priority-map.md]]** — the map's contents in a task with a stated goal: a remembered feature vector is correlated against every location to produce a saliency map, and the search is restricted to the task-relevant region by a stored `T_os` template mapped through `T_sr` — so a top-down query and a spatial constraint enter the same map by different routes.
- **[[wiki/entities/dorsal-visual-stream.md]]** — the functional reading of the same anatomy: identification and location are complexity corners rather than pathways, with the *location* computation beginning in the ventral stream (a remembered description propagated down feedback connections) and ending as a dorsal saliency map, which cuts across the trifurcation that page draws anatomically.
- **[[wiki/entities/arc-agi-3.md]]** — the same currency, with the human-side decomposition this page adds: RHAE divides human first-run actions by agent actions, and this source is where a human's actions are broken into perceptual and manipulative ones and priced against each other.
- **[[wiki/concepts/problem-framing.md]]** — a framing that is *transient by design*: the representation is rebuilt per step out of two or three bound pointers and discarded, so the framing is never a persistent object that could be wrong — at the price that the feature set from which pointers are read is hand-designed, leaving that page's empty row empty.
- **[[wiki/entities/basal-ganglia.md]]** — the proposed home of the pointer *program* as against the pointer *contents*: sequencing, which sensory processing to run, and when a bound value is to be used, with cortex as the content-addressable store of referents — the division that makes two fixations to the same location serve different purposes.
- **[[wiki/concepts/reference-frame-transformation.md]]** — task constraints stored as transforms rather than as locations: `T_os` holds "the resource area" and `T_sr` positions it retinotopically, and composing them reaches a remembered object outside the current field of view without any 3-D scene model.
- **[[wiki/concepts/core-knowledge.md]]** — the same small integer from the action side: 2–3 simultaneously bound deictic pointers, used below capacity by preference, against the object system's 3–4 trackable entities — and this page's version has a stated cost function (`(MV)^s`) behind the number rather than an observed bound.
- **[[wiki/concepts/event-segmentation.md]]** — the block-move cycle is a task-defined event whose boundaries are read off the *eye*: `MPMD` / `PMD` / `MPD` / `PD` are four segmentations of one behaviour, labelled by which bindings were carried across the cut, so fixation sequence is a boundary detector with the retained state visible in the coding.
- **[[wiki/entities/spelkenet.md]]** — the opposite commitment on what a scene is: an objectness map computed once per input, against a scheme in which no scene representation is built at all and objects exist only as the referents of two or three currently-held pointers.
