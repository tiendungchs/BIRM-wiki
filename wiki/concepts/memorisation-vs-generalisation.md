# Memorisation vs Generalisation — The Task Property That Decides Whether a Circuit Exists

**A task is *pure memorisation* when knowledge of the training pairs confers no advantage on unseen entities beyond the output base rates. Such a task has, by definition, no *macrofeatures* — no input property both shared across examples and predictive of the label — so every intermediate state of any network that solves it is either an irrelevant macrofeature or an arbitrary weighted sum of per-example microfeatures. There is nothing for a circuit-style decomposition to name, and the failure to find one is a property of the task, not of the interpreter.**

> **Provenance.** Rajamanoharan, Nanda, Kramár & Shah 2023, *Fact Finding: How to Think About Interpreting Memorisation* (post 4, `raw/rajamanoharan-2023-fact-finding-4-memorisation.md`) supplies the argument; Nanda, Rajamanoharan, Kramár & Shah 2023, *Trying to Mechanistically Understand Early MLPs* (post 3, `raw/nanda-2023-fact-finding-3-early-mlps.md`) supplies the worked attempt that provoked it. Both are Google DeepMind mechanistic-interpretability team write-ups on Pythia 2.8B. Post 1, the sequence's main body, is ingested at [[wiki/concepts/multi-token-embedding.md]]; post 2, the circuit analysis that isolates the subnetwork these two probe, is not — every claim here about *how the subnetwork was extracted* is carried second-hand from the other posts' recaps.

This page is the third member of the wiki's evaluation-epistemology set. [[wiki/concepts/certification-instruments.md]] asks whether a system found the intended structure; [[wiki/concepts/predictive-adequacy.md]] asks whether our *description* of a system is right; this page asks whether a correct description of the kind we want **exists**.

---

## The formalism

A fact-lookup function maps entities to tuples of attributes:

```
sports_facts : Entity → Sport × Team × ...
```

| Feature type | Definition | Example | Use for generalisation |
|---|---|---|---|
| **Microfeature** | Describes one input in maximally specific terms | `is_Michael_Jordan` | None — one example each |
| **Macrofeature** | Describes an input in terms shared with other inputs | `first_name_is_George`, `is_in_cluster_3`, "has a vertical edge on the left" | Only if *task-relevant* |

The authors' own analogy is statistical mechanics: microfeatures are the microstate, macrofeatures the macrostate. A macroscopic problem has a solution in macroscopic variables alone; **a memorisation problem is precisely a question that can only be answered from the microstate.**

**The derivation, in three lines.**

1. A pure memorisation task has no task-relevant macrofeatures — if it had one, that feature would license better-than-base-rate inference on unseen entities, and the task would not be pure memorisation.
2. Every intermediate state of a network solving it must therefore be (a) a macrofeature that is *irrelevant* — and residual-stream connections guarantee these survive to the output, e.g. `first_name_is_george` — or (b) an arbitrary function of microfeatures.
3. Case (b) always admits an exact reading as a lookup table: a neuron that outputs 3 on LeBron James and 1 on Aaron Judge *is* `3·is_LeBron_James + 1·is_Aaron_Judge + …`, each MLP layer is a sum of such tables, and so is the network. Training solved a constraint-satisfaction problem over table entries.

The lookup-table reading is available for **any** network over a finite input set, generalising ones included. The difference is that a generalising task also admits a *second*, shorter reading in macrofeatures ("this neuron detects a left vertical edge"), and a pure memorisation task does not. Circuits-style interpretability is the search for that second reading.

---

## The spectrum, and where real tasks sit

| Regime | Structure | Interpretability consequence |
|---|---|---|
| **Generalisation** | Task-relevant macrofeatures suffice | Circuit decomposition is well-posed; intermediate states have names |
| **Memorisation with rules of thumb** | Macrofeatures get you most of the way; exceptions must be stored. English noun plurals (`+s`, minus `child`); or two facts that are individually arbitrary but *correlated* with each other (blue⇒circle), so storing them jointly is cheaper than storing them twice | The rule-of-thumb part is interpretable; the exception table is not. Expect a partial circuit with an opaque residue |
| **Pure memorisation** | No task-relevant macrofeatures at all | Only the lookup-table reading exists |

**No real task is verified pure, including the one this argument was built on.** The athlete→sport task was chosen because name tokens seem uninformative about sport — but a probe on the summed name-token embeddings alone reaches ~50% against a 33% base rate, so some sport information is in the tokens, and the authors concede that name provenance may correlate with sport. The classification of a task as "pure" is an assumption on the same footing as the interpretability hypotheses it is used to license.

---

## The worked attempt: two hypotheses about 5 MLP layers

Setting: Pythia 2.8B, an **effective model** of MLPs 2–6 (~50,000 neurons) extracted from the pretrained network — not trained from scratch — that recalls the sport of ~1,500 two-token athlete names at 86% on a filtered dataset. Input: surname embedding (embed + MLP0) plus first-name embedding (layer 0–1 heads attending to the previous token), **summed**. Output: a 3-dimensional linear representation of {football, baseball, basketball}, read by attribute-extracting head L16H20.

The computation is a Boolean AND over the raw tokens — the model must know Michael Jordan and Tim Duncan play basketball without inferring it of Michael Duncan — so a nonlinearity must be involved somewhere.

| Hypothesis | Mechanism | Strong prediction |
|---|---|---|
| **Single-step detokenization** | Many neurons each implement one AND with their GELU (`ReLU(is_michael + is_jordan − 1)` generalised), each firing for a set of athletes, constructively interfering on the right fact and washing out as noise elsewhere. Superposition by neuron-sharing | No inter-MLP composition (one layer would suffice); the *same* neurons matter for *every* fact about an entity; neurons with direct effect on the output compute the AND themselves |
| **Hash and lookup** | Early layers **hash** — produce a representation near-orthogonal to every other name, deliberately destroying the linear sum structure of the tokens; later layers **look up** the hash and emit the attribute | Hashing is data-independent (works identically on unknown names); no sport information before the lookup stage; a sharp hash→lookup transition; different facts use different lookup neurons |

The hash hypothesis exists because a summed-token input is actively misleading — Michael Jordan and Michael Smith share a first name and nothing else — and because basis-aligned lookup on *unhashed* sums is provably leaky: a "baseball neuron" whose input weights are the sum of all baseball players' token representations, firing on both Michael Jordan and Tim Duncan, must also fire on Tim Jordan or Michael Duncan. Hashing first removes that constraint.

### Results

| Test | Prediction of | Result | Verdict |
|---|---|---|---|
| Mean-ablate the path between each pair of MLPs 2–6 | detokenization: no effect | Large drops, worst for paths out of MLP2; loss and KL move far more than accuracy | **Against** detokenization — but consistent with MLP2 applying a *fixed* transform later layers expect |
| Ablate each neuron in MLPs 2–6 on the surname token; correlate its effect across 9 known facts about Michael Jordan | detokenization: high correlation | Near-zero for every pair except NBA draft year (1984) vs Olympics year (1992) | **Against** — detokenization neurons, if any, emit a *subset* of an entity's facts |
| **Non-linear excess** across the GELU, weighted by direct effect on L16H20 | detokenization: ratio ≈ 1 | Median **23%** | **Against** — most of the AND arriving at the output head was computed by *earlier* MLPs |
| Linear sport probe on the residual after each layer | hash: chance until a sharp jump | Smooth rise; 50% from the summed tokens alone; a real but not sharp step between layers 4 and 5 | **Against pure** hashing; consistent with partial |
| MLP output norm, known vs unknown names | hash: indistinguishable | Known names higher — already at **MLP1**, which is not even in the effective model | **Against pure** hashing |
| Linearity test: is `MLP(A)+MLP(B) = MLP(C)+MLP(D)` for name-swapped pairs? | hash: fully broken | MLP outputs **60–70%** of the way to fully broken; **randomly shuffled weights only 20–40%**; residual stream 30% after layer 2 → 50% after layer 6 | **For** hashing — and the shuffled-weight control is what makes it a finding rather than a tautology |
| Baseball neuron applied to each athlete residual projected orthogonal to all other athlete residuals | lookup: idiosyncratic per-entity information survives | ROC AUC 60% | **Retracted by the authors** — projecting out 1,500 noisy samples does not remove a shared direction, so the test does not separate the hypotheses |

**Non-linear excess** is the reusable instrument. For binary input features `A` (prev token = Michael) and `B` (curr token = Jordan), define

```
NLE = E[a | A ∧ B] − E[a | ¬A ∧ B] − E[a | A ∧ ¬B] + E[a | ¬A ∧ ¬B]
```

which is `0` for any function linear in the two features, `+1` for an AND and `−1` for an OR, with the last term subtracting the activation's non-zero mean. Taking the *change* in `NLE` across the GELU separates a unit that **computes** a conjunction from one that **signal-boosts** a conjunction computed upstream — the distinction on which the whole falsification turns, and one no other instrument in the wiki makes. Its cost is honesty about complexity: it is a difference of differences of differences, with subjective choices at the filtering step (neurons whose pre-GELU excess is negative are clamped to zero), and the authors decline to lean on it alone.

### The counterexample: L5N6045, the baseball neuron

Inside a subnetwork declared diffuse and superposed, one neuron is a legible macrofeature.

| Property | Value |
|---|---|
| Binary probe, baseball vs not | **89.3% ROC AUC** |
| Causal | Mean-ablation raises loss on baseball players 0.167 → 0.284 (zero-ablation 0.559); composes with L16H20 to boost baseball and suppress football |
| Partly a signal booster | cos(input weights, output weights) = 0.456; cos with the baseball-logit direction via L16H20 = 0.22; with the baseball-relative-to-other-sports direction = 0.184 |
| **Not only** a signal booster | Project the input weights orthogonal to those three directions and the neuron still reaches 83% ROC AUC |
| Not monosemantic | Fires in baseball-like contexts on news text (and somewhat on cricket), but also on `External` in "External Links" and the ` goal` in "football\| goal\|keeping" on Wikipedia |

The neuron is what the impossibility argument permits and does not predict: `plays_baseball` is a macrofeature of the *output*, so a unit that pools hashed baseball players and writes the baseball direction is nameable even though the map from names to sports is not. **The argument forbids interpretable intermediate states on the input side of the lookup; it says nothing about the output side.** That asymmetry is the practical form of the result — reverse-engineering a lookup should be expected to succeed downstream of the table and fail upstream of it.

---

## Why the search does not terminate

The authors' second complaint is procedural, and it is the one with teeth beyond this task. Falsifying single-step detokenization did not narrow the space: each falsified hypothesis has neighbours that survive the same evidence (MLP2 as a *fixed* transform rather than a composing one; *partial* rather than pure hash-and-lookup) and the neighbours are systematically **harder** to falsify than what they replace. Partial hash-and-lookup, the surviving hypothesis, is compatible with essentially every result above and the authors say plainly that they do not know how to falsify it.

Two directions they name for when circuits run out:

- **Organisational rather than featural explanation.** Give up on intermediate states meaning anything and ask about the *shape* of the computation — e.g. whether the trained network resembles **bagging**, with each neuron an uncorrelated weak classifier and the output their sum. The obstacle is that nobody knows how to search this hypothesis space efficiently, and the authors question what such an answer would be *for*.
- **Why rather than how.** Explain a behaviour by its training data — influence functions — instead of by its weights. Uninteresting for a network explicitly trained to memorise a table; potentially informative for a language model that memorised facts incidentally while optimising a generalisation objective.

---

## Applying it to build a reasoning model

| Consequence | Detail |
|---|---|
| **Route memorised content out of the weights** | If a mapping has no task-relevant macrofeatures, weights buy nothing over an explicit table — no compression is available, and the interpretability cost is total. The wiki's explicit-store architectures ([[wiki/entities/differentiable-neural-computer.md]], [[wiki/entities/sparse-distributed-memory.md]], [[wiki/entities/vector-hash.md]], [[wiki/entities/cn-dpm.md]]) pay a parameter bill for a property that is now given a principled justification: what stays in weights should be exactly what has macrofeatures. Nothing decides the split — gap `G98` |
| **The micro/macro test is a cheap pre-registration** | Before attempting to interpret any subnetwork, ask whether the task it solves admits better-than-base-rate inference on held-out entities. If not, budget for a null result. This is the same discipline [[wiki/concepts/predictive-adequacy.md]] imposes on encoding models, applied to circuit-finding |
| **Expect the interpretable part to be output-side** | The baseball neuron is legible because its *output* is a macrofeature. Design a system so that its lookups terminate in a small vocabulary of named attributes, and the last stage stays readable however opaque the addressing is |
| **Hashing is measurable, and gradient descent does it** | The 60–70% vs 20–40% shuffled-weight contrast is the wiki's first evidence that a trained network *deliberately* destroys linear structure in its input, i.e. that [[wiki/concepts/pattern-separation-completion.md]]'s write-side randomisation is something optimisation discovers rather than something biology alone supplies |
| **Non-linear excess as a conjunction detector** | Any wiki claim that a unit implements a binding or a conjunction ([[wiki/concepts/vector-symbolic-binding.md]], [[wiki/concepts/compositionality.md]]) is currently asserted from activation patterns. `NLE` scores it, and its change across the nonlinearity localises *where* the conjunction was formed |
| **Correlated facts are the compressible case** | The blue⇒circle dataset is the interesting middle: two individually arbitrary attributes that are statistically coupled can be memorised jointly for less than the sum of their costs. That is exactly the structure [[wiki/concepts/schema-assimilation.md]] exploits, stated as a coding problem rather than a psychological one |

---

## Open problems

- **No task in the wiki is measured on this axis.** "Pure memorisation" vs "rules of thumb" is a *quantity* — the gap between a model's accuracy and the best achievable from held-out-entity inference — and nobody reports it, including for the athlete task this framework was built on.
- **The impossibility argument has no converse.** It says a pure memorisation task admits no macrofeature decomposition; it does not say a task *with* macrofeatures will yield one. The baseball neuron shows the boundary is porous in the permitted direction; nothing establishes how much of a real subnetwork sits on each side.
- **Partial hash-and-lookup is unfalsifiable as stated.** The surviving hypothesis is compatible with every experiment run against it, by its authors' own admission, and no experiment is proposed that would settle it.
- **Organisational hypotheses have no search procedure.** Bagging-like structure is a testable claim about a fitted network; the space of such claims is not enumerable and nothing prioritises it.
- **What an organisational answer would buy is unstated.** Even a confirmed "this lookup is bagging" leaves no intermediate representation to steer, monitor or edit, which is what mechanistic interpretability is wanted for downstream.

---

- **`T285` — is the floor on mechanistic description a property of the task, or of the interpreter?** This page argues A from the absence of macrofeatures; the wiki's own record argues B, since every previous "not decomposable" verdict here dissolved under a better-chosen frame. Neither side has an operational test for which side a given subnetwork falls on, which is what makes the row `LIVE` rather than settled.

## Connections

- **[[wiki/concepts/predictive-adequacy.md]]** — the same question one level down and with the opposite answer: that page finds description quality falling with hierarchical *depth* and diagnoses a wrong unit of description (single neuron vs. population); this page finds a case where no unit of description works at any depth, because the failure is a property of the **task** rather than of the component. Its residual diagnostic (correlated residual = missing term, uncorrelated = missing mechanism) has no analogue here, since a pure lookup has no mechanism to miss.
- **[[wiki/concepts/pattern-separation-completion.md]]** — supplies the mechanism the hash-and-lookup hypothesis is a machine instance of, and receives the wiki's first *measurement* of learned hashing: early MLPs break linear structure 60–70% where shuffled weights break it 20–40%, but they also treat known names differently from unknown ones, so the learned hash is content-dependent in a way mossy-fibre randomisation is not (T286).
- **[[wiki/concepts/linear-representation-hypothesis.md]]** — the destructive complement: that page's whole apparatus rests on the residual stream decomposing linearly, and this one measures how fast MLPs destroy that decomposition with depth (30% → 50% broken from layer 2 to layer 6), which predicts that "feature A **and** feature B" directions accumulate as an artefact of depth rather than as a computation.
- **[[wiki/concepts/representation-probing.md]]** — the instrument used here as a *falsifier* rather than a detector: hash-and-lookup predicted a sharp probe-accuracy transition, the measured curve is smooth, and the hypothesis died of the shape of the curve rather than of its level.
- **[[wiki/concepts/certification-instruments.md]]** — the sibling with the declared ground truth. This page adds a prior step those instruments assume away: whether the intended structure exists to be certified at all, which for a memorised mapping it does not.
- **[[wiki/concepts/retrieval-capacity.md]]** — the same lookup viewed as a budget rather than as an explanation: the interference argument that motivates hashing (a basis-aligned baseball neuron firing on Michael Jordan and Tim Duncan must fire on Tim Jordan or Michael Duncan) is a capacity bound stated combinatorially.
- **[[wiki/entities/transformer.md]]** — the substrate, and the source of this page's locality result: the same investigation's post 5 measures that early layers softly specialise in local processing, which is why a two-token entity's "embedding" can be assembled before any long-range machinery runs.
- **[[wiki/concepts/node-definition-problem.md]]** — the same lesson about categories imposed by the analysis: `is_baseball_player` is a category the experimenter brought, and the neuron that scores 89.3% against it also fires on "External Links".
- **[[wiki/concepts/prediction-compression-equivalence.md]]** — the information-theoretic statement of the split: a macrofeature is exactly a description that shortens the code for many examples at once, so "no macrofeatures" is "incompressible", and a pure lookup table is the incompressible limit where code length equals data length.
- **[[wiki/concepts/intelligence-density.md]]** — the same distinction as a scoring function: *knowing* is `ℐ(n) → ∞` and *memorizing* is `ℐ(n) → 0`, which is this page's spectrum with a number attached; this page adds the interpretability consequence of sitting at the memorizing end.
- **[[wiki/concepts/shortcut-learning.md]]** — the mirror image. A shortcut is an *irrelevant* macrofeature that the model uses; pure memorisation is the regime where no macrofeature is available to be a shortcut, so the two failure modes are mutually exclusive on the same task.
- **[[wiki/concepts/schema-assimilation.md]]** — the constructive reading of "memorisation with rules of thumb": a schema is the macrofeature structure that makes new facts cheap, and the correlated-attributes dataset (blue⇒circle) is the minimal case where storing two facts jointly beats storing them apart.
- **[[wiki/concepts/multi-token-embedding.md]]** — the positive half of the same investigation, and the reason the null result is tolerable: the layers this page finds uninterpretable have a stated input/output contract — summed name tokens in, an entity vector with attributes as linear subspaces out — so they can be black-boxed as a typed submodule rather than merely abandoned.
- **[[wiki/concepts/developmental-heterochrony.md]]** — the developmental form of this page's trade: the human-specific delay lands on synaptic elimination, so what evolution prolonged is the interval *before* capacity is irreversibly spent — not committing early, run on an evolutionary rather than a within-training timescale.
- **[[wiki/concepts/information-bottleneck.md]]** — the same spectrum in information-theoretic units, with a sample-complexity consequence: no macrofeatures means `I(X;X̂)` cannot fall without `I(X̂;Y)` falling with it, so the information curve degenerates to the diagonal and the finite-sample bound (which charges `K ≈ 2^{I(X̂;X)}`) says such a task cannot be generalized from at all — a lookup table is what is left when compression buys no relevance.
