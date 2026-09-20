# Self-Boosting Knowledge Acquisition — the Reward Whose Supply Grows With the Store

**Every intrinsic reward in the wiki is *consumed* by learning: novelty falls as states are visited, prediction error falls as the model fits, progress falls at mastery. This page carries the opposite claim, with a derivation attached — if the reward is emitted at the boundary between what the agent knows and what it does not, then the supply is `αK(N − K)` in the amount `K` already learned, and it *rises* over the whole first half of any domain large enough to matter. The drive is then a recursive function of the agent's own store rather than a decaying function of its experience count, and a want with no primary reward behind it becomes self-sustaining instead of extinguishing.**

> **Provenance.** Murayama 2022, *A reward-learning framework of knowledge acquisition: an integrated account of curiosity, interest, and intrinsic–extrinsic rewards*, Psychological Review 129(1):175–198 (`raw/murayama-2022-reward-learning-framework-of-knowledge-acquisition.md`, **LOSSY** — converted by `pdf2md.sh` from the publisher PDF; Figures 1–5 are absent and their numbers are read from the prose). A **framework**, not a model: the author states explicitly that no computational extension is offered, because the core component — the knowledge representation — is the hard part. Every empirical number below is the review's citation to a primary study. The one piece of original mathematics is the gap-count derivation, with a simulation script deposited at `osf.io/rsxuv`.

Why this earns a page rather than a row on [[wiki/concepts/intrinsic-motivation-typology.md]]: every formula in that typology takes the sensorimotor flow and a model as arguments and returns a scalar. This one takes **the structure of the agent's own knowledge store** as the argument, which is a different input, has a different sign in time, and is the only account in the wiki of where a long-lived want comes from when nothing primary is ever delivered.

---

## The recursion: three write-backs from the store to the decision

The standard reward-learning loop for information seeking is *gap salient → price the missing information → seek → receive → reinforce*. The framework's addition is that the acquired knowledge does not terminate at the reinforcement step; it is written into the store, and the store is an argument of three earlier terms:

| Path | What the store writes to | Direction | Consequence |
|---|---|---|---|
| **A — generation of new questions** | the *set of gaps that are salient at all* | more knowledge → more gaps (up to half-mastery) | the supply of things worth asking is manufactured by learning, not depleted by it |
| **B — valuation** | the reward magnitude assigned to a given piece of missing information | more knowledge → higher value | a new item is worth what it connects to, so value rises with connectable surface |
| **C — increased capability** | perceived competence, which gates whether seeking is initiated | more knowledge → higher competence | the same gap becomes affordable that was previously refused |

**All three are functions of the acquired knowledge itself, which is what makes the system recursive rather than merely reinforced.** A reward-learning system over extrinsic rewards has none of them: food does not change how many food-gaps exist, what food is worth, or the agent's competence to eat. This is the difference the framework says generates every behavioural contrast below.

---

## The gap count, derived

Represent a domain as a network: `N` nodes (pieces of information), each linked to a random `α` fraction of the others. Learned nodes are in the store; unlearned are not. **Define a knowledge gap as an edge from a learned node to an unlearned one** — the frontier of the learned subgraph.

Acquiring the `k`-th piece:

```
opens     α(N − k)        edges to still-unlearned nodes
closes    α(k − 1)        edges to nodes already in the store
net       α(N − 2k + 1)
```

Summing `k = 1…K`:

```
Gaps(K) = α · K · (N − K)
```

| Property | Value | Reading |
|---|---|---|
| Shape | inverted parabola in `K` | the drive is **non-monotone in learning**, not decreasing |
| Peak | `K = N/2` | maximum curiosity at half-mastery, not at ignorance |
| `α` | scaling only | does not change the shape — so connectivity density sets gain, not sign |
| Small `N` | monotone decreasing over the practical range | **a small, self-contained domain gives the classical decaying novelty curve** |
| Large `N` | increasing over the practical range | a real domain (physics, a codebase, a language) never leaves the rising limb |

The random-graph assumption is then dropped: simulating small-world networks (Watts–Strogatz, `N = 100`, neighbourhood `10–25`, rewiring `0.1–0.3`, 100 curves) reproduces the rise whenever acquired knowledge is small relative to `N`. Two independent replications with different gap definitions: Sizemore et al. 2018 (gap = a topological **void**, simulated and empirical knowledge networks) and Christianson et al. 2020 (semantic networks instantiated from college linear-algebra texts).

**The methodological consequence is a direct indictment, and it is the sharpest thing in the source.** Curiosity is studied with trivia questions, blurred images and magic tricks — small, self-contained, low-`N` materials, exactly the regime in which the equation predicts the decaying curve. **The entire laboratory paradigm sits on the one branch of the function where the effect this page is about cannot appear.** The prediction is testable and cheap: the same participants on a large-`N` corpus should show the rising limb, and Fastrich & Murayama 2020's growth curves flatten late precisely because the material was self-contained.

---

## Four features that follow, each with its measurement

| Feature | Mechanism in the framework | Evidence cited |
|---|---|---|
| **Self-boosting** | positive feedback loop A+B+C; engagement needs no external supply once entered | interest (not extrinsic motivation) in Grade 7 predicts 2-year maths-achievement *gains*, Murayama et al. 2013; cadets `N ≈ 10,000` intrinsically motivated at entry leave the military less, extrinsically motivated leave *more*, Wrzesniewski et al. 2014; lab and field replications (Murayama & Elliot 2011; Vansteenkiste et al. 2005) |
| **Selectivity** (Matthew / rich-get-richer) | a positive feedback loop is path-dependent: initial conditions are amplified, so small idiosyncratic differences at entry produce divergent long-run interests | Fastrich & Murayama 2020 — interest rises with facts viewed only for high-initial-interest countries; low-initial-interest participants quit early and the gap widens. Witherby & Carpenter 2021 — prior football knowledge predicts curiosity about football facts predicts learning, and **cooking knowledge does not**, so the effect is domain-indexed. Fastrich et al. 2018 — 244 trivia items × ~2,000 participants, ~**half** the variance in interest ratings is the person × item interaction; no item is unanimously interesting |
| **Vulnerability** | extrinsic rewards are salient and (arguably) evolutionarily prior, so they are prioritised; their presence *prevents* the self-generation of the intrinsic reward rather than adding to it | undermining/overjustification meta-analyses (Deci et al. 1999; Eisenberger et al. 1999); effect is larger when the reward is made **salient** (Amabile et al. 1986; Ross 1975); Murayama et al. 2010 — striatal activation is present during unrewarded play, and is **no longer observed** after performance payment is introduced and then removed; Festinger & Carlsmith 1959 insufficient justification, with a striatal correlate (Izuma et al. 2010) |
| **Under-appreciation** | the value of knowledge is intangible and its self-boosting property is only discoverable *during* learning, so it cannot be priced in advance — the forecast is biased **downward**, the opposite sign to the impact bias for extrinsic rewards | Kuratomi et al. 2018 — predicted engagement in a 30-min flanker task is below actual engagement; **the underestimation disappears when a reward is promised**. Woolley & Fishbach 2015; Ruan et al. 2018. People motivate others with extrinsic rewards even where these are known not to work (Heath 1999; Murayama et al. 2016) |

**Under-appreciation is the one an agent builder cannot wave off.** Any agent that plans over its own future reward with a learned model of that reward has a metamotivational forecast inside it. The measurement says the human forecast is *signed*: too low for self-generated reward, too high for delivered reward, and the bias collapses when a delivered reward is present. An agent with that bias systematically declines to start the tasks whose reward it would have to generate itself — which is the failure mode the selectivity row describes from the outside.

---

## Flow as a product, not a set point

The framework's account of the skill/challenge inverted U is a **composition rule**, which [[wiki/concepts/intrinsic-motivation-typology.md]] lists as a thing the typology cannot supply (it gives a dozen rewards and no way to combine two):

```
engagement ∝ expected knowledge gain (falls with competence)
           × perceived competence    (rises with competence)
```

Low competence: the gain is large and the seeking is never initiated, because comprehension is not expected. High competence: seeking is affordable and there is nothing left to gain. The maximum is interior. **This is a multiplicative gate between a knowledge-family and a competence-family term**, where the typology's families are presented as alternatives and [[wiki/concepts/learning-progress.md]]'s fitted human utility is *additive* (`w_PC·PC + w_LP·LP`, the two weights empirically uncorrelated). Additive and multiplicative compositions are discriminable on one dataset and nobody has run the comparison.

---

## Two structural claims a builder should hold separately from the framework

- **Goals are part of the knowledge store, not a separate module.** A mastery goal versus a performance goal changes the reward value assigned to the same acquired fact; the framework files goals as prior knowledge exerting top-down modulation on valuation (Path B), consistent with goals-as-cognitive-representations. For an architecture this says the goal and the world model read from one store rather than sitting in separate registers — the opposite of the usual `(goal, state)` factorisation.
- **"Same hardware, different software."** All reward types run through one reward-learning mechanism, but *how* a type behaves in that mechanism is a property of the type (knowledge self-boosts; food satiates; social recognition does neither). The framework refuses both the dichotomy (intrinsic vs extrinsic as distinct systems) and the singularity (one undifferentiated reward). The operational content is thin — no property list is given — but the position is precisely the one a common-currency value head ([[wiki/concepts/subjective-value.md]]) cannot express, since that head receives a scalar with its provenance already discarded.

**The framework also dissolves its own vocabulary.** Neither "curiosity" nor "interest" nor "intrinsic motivation" appears as an element of the framework's own diagram; all three are held to be post-hoc subjective labels for parts of one process. For the wiki this is a licence to stop trying to reconcile the terms and to index the mechanisms instead.

---

## Reading in the core framing

| This page | Latent-graph reading ([[wiki/concepts/latent-graph-discovery.md]]) |
|---|---|
| Knowledge gap | an edge with one endpoint inside the discovered subgraph and one outside — the **frontier**, not an uncertainty over an edge weight |
| `Gaps(K) = αK(N − K)` | the frontier's size as a function of the discovered fraction; a property of the *graph and the store*, computable without any model of the environment's dynamics |
| Self-boosting | the frontier is its own generator: expanding the subgraph expands its boundary until half the graph is inside |
| Path B (valuation) | an unlearned node is worth what it will connect to, i.e. its expected degree into the store — a purely structural priority, no reward channel required |
| Path C (competence) | traversal cost falls as the subgraph grows, so previously unaffordable frontier edges become reachable |
| Selectivity | path dependence of a greedy frontier expansion: which component of a disconnected graph you enter first determines the whole trajectory |
| Small-`N` regime | a closed subgraph, where the frontier collapses — the regime every curiosity experiment in the wiki runs in |

**(brainstorm) The frontier count is the cheapest unimplemented intrinsic reward in the wiki.** It needs no predictor, no ensemble, no episode clock and no achievement measure — only a store with an addressable boundary. For any agent that holds an explicit relational structure (a learned graph, a retrieval index, a key–value memory with a similarity metric) it is one query: count the edges from filled to unfilled. The signature that distinguishes it from every existing bonus is free — **the per-step intrinsic reward should rise over the first half of a large domain**, where novelty, prediction error, learning progress and competence progress all fall monotonically.

---

## Open problems

- **No computational model exists, and the author says why.** The framework is deliberately not formalised because the knowledge representation and the self are unsolved. Every quantity above is therefore a shape, not an implementation: `Gaps(K)` presumes a node set, and what counts as a node is [[wiki/concepts/node-definition-problem.md]].
- **Gap existence ≠ gap awareness.** The derivation counts frontier edges; the framework concedes that awareness of a gap depends on recency and salience, and supplies no retrieval model. An agent that computes the count exactly is not the model of the human data.
- **Acquisition is assumed random.** Real learners choose what to learn next, which is the whole selection problem — and a *chosen* acquisition order changes `Gaps(K)`'s shape by an unmeasured amount.
- **Nothing measures `N`.** The theory's one qualitative prediction (rising vs falling limb) is indexed entirely by domain size relative to knowledge held, and no procedure is given for estimating either in a human or a machine.
- **Vulnerability's mechanism is unspecified.** "Extrinsic rewards are prioritised" is a claim about signal flow with at least three realisations — attentional capture on the salient cue, gain reduction on the intrinsic channel, or a hard gate — which the striatal data do not separate (`T400`).
- **The Matthew effect has no controller.** A positive feedback loop with path dependence is an architecture with no term that prevents premature specialisation; the framework treats selectivity as a *feature*, and the identical dynamic is what [[wiki/concepts/explore-exploit-division-of-labour.md]] calls a learning trap.
- **Reinforcement properties of the knowledge reward are untested.** The source's own closing admission: whether the feeling of curiosity behaves as a reinforcer under extinction or selective devaluation has not been measured, which is precisely what [[wiki/concepts/conditioned-reinforcement.md]] says decides whether a manufactured want survives.

---

## Connections

- **[[wiki/concepts/intrinsic-motivation-typology.md]]** — the cell this page's reward has no row for: every formula in the three families is a function of the flow and a model, monotonically exhausted by learning, whereas `Gaps(K) = αK(N − K)` reads the *store's structure* and rises over the first half of a large domain — and this page also supplies the composition rule the typology lacks, as a product of a knowledge term and a competence term rather than a weighted sum.
- **[[wiki/concepts/learning-progress.md]]** — the same non-stationarity with the opposite sign and a discriminating experiment attached: learning progress falls to zero at mastery because the activity is exhausted, frontier count peaks at half-mastery because the store manufactures its own boundary, so a large-`N` domain separates them on the first half of the curve — and the additive fitted utility `w_PC·PC + w_LP·LP` is testable against this page's multiplicative Flow gate on the same data.
- **[[wiki/concepts/information-sampling-vs-search.md]]** — supplies the missing size variable for that page's complexity objection: the hypothesis space is not merely uncounted, it *grows with what the agent has learned*, so the search regime is not a transient that sampling eventually replaces — and the review's "memory makes search specific, which is how lifelong interests compound within a domain" is exactly this page's Path A stated without the derivation.
- **[[wiki/concepts/schema-assimilation.md]]** — the motivational reading of the same store: that page shows an item fitting an existing schema is encoded in one trial and that the schema must be the *same* one, and this page says the boundary of that schema is where the intrinsic reward is emitted — so the one-trial encoding advantage and the reward supply are two consequences of a single structural property, overlap with what is already held.
- **[[wiki/concepts/subjective-value.md]]** — the common-currency head this framework both needs and qualifies: all reward types are asserted to run through one valuation mechanism ("same hardware"), while the undermining evidence says a salient extrinsic reward suppresses the generation of the intrinsic one rather than summing with it — a scalar with its provenance discarded cannot express that (`T400`).
- **[[wiki/concepts/learned-industriousness.md]]** — the cost-side twin of this page's benefit-side recursion, and cited by the source as such: there a history in which exertion paid writes down the price of effort, here a history of successful acquisition writes up the supply and value of the reward, so both terms of the subtraction are conditioned by the agent's own past and neither has a write port in any wiki architecture (`G128`, `G129`).
- **[[wiki/concepts/explore-exploit-division-of-labour.md]]** — the opposite reading of one dynamic: a self-boosting loop with path-dependent entry is a *learning trap* seen from that page and a *developed interest* seen from this one, and the two differ only in whether the committed domain was the right one — which is the case for that page's protected, externally subsidised explore phase as the missing controller this framework has none of.
- **[[wiki/concepts/conditioned-reinforcement.md]]** — the unmet audit: a knowledge reward is a want with no primary reinforcer behind it, which on that page's evidence should extinguish on every unbacked delivery, and this framework's answer is that the store regenerates the want faster than delivery consumes it — an empirical race nobody has run, and the source concedes the reinforcement properties of curiosity are untested.
- **[[wiki/concepts/metacognitive-efficiency.md]]** — a second self-model with a *signed* error that no scoring scheme on that page covers: the forecast at issue is of the agent's own future motivational state rather than of its answer's correctness, the measured bias is downward for self-generated reward and upward for delivered reward, and it collapses when a reward is promised — a bias-term result with no sensitivity or efficiency analogue yet defined.
- **[[wiki/concepts/curriculum-learning.md]]** — what this page's frontier would order: the material an agent should take next is the unlearned node with the most edges into the store, which is a curriculum generated from the store's structure with no teacher, no difficulty label and no competence estimate — a third generator alongside learning progress and the 70–80% set-point, and untested against either.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the core framing supplying this page's object: the knowledge gap is defined as an edge crossing the boundary of the discovered subgraph, which makes the intrinsic reward a purely structural query over the store and makes domain size (`N`) the variable that decides whether curiosity grows or dies.
