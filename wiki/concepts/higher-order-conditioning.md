# Higher-Order Conditioning — What a Manufactured Subgoal Inherits, and What It Loses

**Chain a cue onto a cue instead of onto a reward and the new link does not carry a copy of the old one. First-order conditioning writes `S1 → US(specific)`: devalue the outcome and the response drops. Second-order conditioning — `S2 → S1`, never paired with the outcome — writes `S2 → central motivational state`: devalue the outcome, or extinguish `S1`, and `S2` is untouched. Sensory preconditioning, the same pairing run *before* the outcome exists, writes `S2 → S1` as a bare identity link with no valence. Three procedures, three different things stored, separately lesionable and separately drugged. The manufactured subgoal therefore inherits the *sign and magnitude* of what it was built from and not its *identity* — and the same trials that build it simultaneously train its own inhibitor.**

> **Provenance.** Gewirtz & Davis 2000, *Using Pavlovian higher-order conditioning paradigms to investigate the neural substrates of emotional learning and memory*, Learning & Memory 7(5):257–266 (`raw/gewirtz-2000-pavlovian-higher-order-conditioning-paradigms.md`). A review; the authors' own contribution is the second-order fear-potentiated-startle work and the insertion-point model. **The clipped HTML stripped every in-text citation**, so originals are named below only where the running prose names them; everything else is attributed to the review. Results reachable through other wiki pages are cited to their own source there.

Why this earns a page. [[wiki/concepts/conditioned-reinforcement.md]] establishes *that* a predictor becomes a reinforcer and measures what it is worth. It does not say **what the new link points at**, and that is the question a builder stacking subgoals actually needs answered: whether level `n+1` can still name the outcome level `n` was about. This source answers it — no — and supplies the only mechanistic definition of "type of association" in the wiki that is not psychological: an association type is a **topological insertion point in a signal-flow graph** (`T395`, `G126`).

---

## The three paradigms

| Paradigm | Phase 1 | Phase 2 | Test | What `S2` acquires |
|---|---|---|---|---|
| **First-order** | `S1 → US` | — | `S1` | `S1 → US(specific)` |
| **Second-order** | `S1 → US` | `S2 → S1`, **no US** | `S2` | `S2 → central motivational state` ("fear"; appetitively, "hope") |
| **Sensory preconditioning** | `S2 → S1`, no US present | `S1 → US` | `S2` | `S2 → S1` (bare S–S; no valence existed during phase 1) |

The cardinal property of both higher-order paradigms: **`S2` acquires associative strength though it is never paired with a US.** Sensory preconditioning is the cleanest case of S–S learning obtainable, because no conditioned response to `S1` yet exists when the pairing is made.

**The S–S link is written by an error, not by co-occurrence.** Sharpe et al. 2017 ([[wiki/concepts/state-prediction-error.md]]) run blocking *inside* the preconditioning phase: after `A→X` is established, a novel `C` compounded into `AC→X` fails to acquire the link, while a novel compound `EF→X` acquires it normally. Since no reward exists in the phase, the error driving the write cannot be a value error — and an optogenetic dopamine transient timed to `X`'s onset reinstates the blocked link, while suppressing the transient across an ordinary `B→Y` transition abolishes it. So the "bare identity link with no valence" in the table above has both a learning rule (error-gated) and an identified teaching signal (the same projection that carries the reward error), and the link written under artificial dopamine is devaluation-sensitive — identity-bearing, not cached value.

**Controls the source insists on.** `S2`–`S1` explicitly *unpaired* is the minimum control — stimulus generalisation is the most likely artefact. Both higher-order forms are intrinsically weaker than first-order and are strengthened by a high-intensity US, by `S1`/`S2` spatial proximity, by shared sensory modality, and (sensory preconditioning specifically) by **simultaneous** rather than serial presentation.

---

## The post-training manipulations that assign the association

The method throughout: train, then change something about `S1` or the US, then read `S2`.

| Manipulation | Effect on `S1` | Effect on `S2` (second-order) | Effect on `S2` (sensory preconditioning) | Conclusion |
|---|---|---|---|---|
| Extinguish `S1` (repeated non-reinforcement) | abolished | **spared** | **abolished** | second-order is not `S2→S1`; sensory preconditioning is |
| Devalue / inflate the US | tracks the change | **unaffected** | — | second-order is not `S2→US` |
| Keypeck topography (pigeons, food vs water US) | force differs by US identity | **does not differ by US identity** | — | `S2` carries no US identity at all |
| Different `S1`/`S2` modalities | light→food gives rearing | tone→light gives a brief startle-like response, **no rearing** | — | second-order is not `S2→R` either — the CR forms differ |
| Second-order **fear-potentiated startle** | `S1` potentiates startle | `S2` potentiates startle, **though startle was never elicited during `S2` training** | — | the behaviour used to read the association was absent from the procedure that created it |

The last row is the source's own strongest argument and it is worth restating as a design constraint: an `S2` trained with a measurement channel that was *never active during training* nevertheless controls that channel at test. What transferred cannot be a stored response.

**S–R by default is what remained after devaluation and inflation ruled the rest out** — and the last two rows kill it directly. The interpretation that survives is that `S2` is associated with a **central motivational state**, i.e. a US-general affective register, not a specific outcome and not an overt behaviour.

**Two documented exceptions**, both procedural rather than species-specific:
- Autoshaping in pigeons: `S1` extinction *does* reduce responding to `S2`, so the link there is `S2→S1`.
- Rodents get `S2→S1` second-order conditioning under the two conditions that normally favour sensory preconditioning — **simultaneous** `S2`/`S1` presentation and **very few** `S1→US` trials. Neither stimulus is experienced without the other, and the source's reading is that this builds a **unitary representation** of the pair rather than a link between two.

So *which* association a chaining procedure writes is set by the statistics of stimulus co-occurrence, not by the chaining itself. An agent that always presents subgoal and goal-cue together, and rarely runs the goal-cue alone, gets an identity-preserving link; one that interleaves them gets a valence-only link.

---

## The insertion-point model: association type as graph topology

The source's reformulation, and the part with the most transfer. Pathways carrying `S2`, `S1` and US information converge; the first-order plasticity site is where `S1` and US information meet. Then:

| Association | Defined as | Where `S2`'s pathway joins the first-order pathway |
|---|---|---|
| `S2 → S1` | before the `S1`/US convergence point | upstream of the first-order plasticity site |
| `S2 → US` | at the convergence point | the same site |
| `S2 → affect` | after convergence, **before** response-system divergence | downstream of plasticity, upstream of the output fan-out |
| `S2 → R` | after response-system divergence | on one output branch only |

**This is the wiki's only definition of an association's *type* that is checkable without a behavioural assay.** The psychological labels S–S, S–US, S–R become statements about *where a new edge attaches in an existing circuit*, and every behavioural dissociation above becomes a prediction about what is reachable from that attachment point. In particular the `S2→affect` position is the unique one that is downstream of the outcome-identity site (so devaluation cannot reach it, and `S1` extinction cannot reach it) and upstream of the response fan-out (so it can drive a response channel that was never trained, which is the fear-potentiated-startle result).

**(brainstorm)** A hierarchical learner has the same topology available for free and nobody uses it. Attach the option-level critic's input *after* the outcome-identity representation and before the policy head and you reproduce the whole profile: subgoal value immune to goal revaluation, subgoal value unable to name the goal, subgoal value able to drive any downstream action head. Attach it before and you get a subgoal that tracks goal revaluation and cannot generalise across response channels. The choice is a wiring decision, it is one line in any implementation, and its behavioural consequences are fully specified in the table above. Nothing in the wiki treats "which association was learned" as a placement question (`T395`).

---

## The subgoal trains its own inhibitor

The second-order training procedure is `S1 → US` on every trial **except** those where `S2` accompanies `S1`, which end without the US. That is a **feature-negative discrimination** — the standard recipe for manufacturing a conditioned inhibitor. So the same trials that build `S2`'s pull build `S2`'s suppression, and the source's model is that observed behaviour is their **sum**:

- Second-order excitation grows **fast**; conditioned inhibition grows **slower but stronger**.
- Net response to `S2` is therefore an **inverted U in number of training trials** — second-order conditioning reliably reaches asymptote after few trials and then declines.
- Confound with teeth: a lesion, drug or knockout that *reduces* measured second-order conditioning may have **enhanced** inhibition. A treatment that improved learning overall can read as an impairment.

Two escapes, both copyable:

| Escape | Mechanism | Result |
|---|---|---|
| **Partial reinforcement during first-order training** (mix `S1+` and `S1−` trials) | `S1` is already unreliable, so `S2`'s presence is not the feature that predicts omission | damages conditioned inhibition badly, leaves second-order conditioning robust |
| **Move the read-out window** (fear-potentiated startle, probe timed relative to `S2` onset/offset) | excitation and inhibition occupy different intervals of the same trial | probe **during** `S2`: second-order fear grows **monotonically** with training, no inverted U at all. Probe **after** `S2` offset: conditioned inhibition of startle. Same animals, same training, opposite sign |

A third partial escape is refresher `S1→US` trials interleaved during second-order training, which prevent `S1`'s extinction — but they also reintroduce the US, so they are unavailable when the point of the design is that no US is delivered.

The read-out-window result is the sharper one for the wiki. **The measured value of a manufactured subgoal has a sign that depends on when in the trial you look**, and every intrinsic-reward and subgoal-value measurement in the wiki reads a single window (`G126`, and the assay-validity family `G116`/`G121`). A trial-averaged read of a quantity whose excitatory and inhibitory components are temporally segregated returns their sum and is not a read of either.

---

## Substrate

| Result | Locus | Reading |
|---|---|---|
| `S1`/US convergence for first-order fear conditioning | lateral nucleus of the basolateral amygdala — CS and US inputs converge on the same cells; lesions and NMDA/non-NMDA antagonists block acquisition | the first-order plasticity site |
| Second-order fear conditioning is NMDA-dependent in the basolateral amygdala | proposed **basal** nucleus (receives heavy lateral-nucleus *and* perirhinal projections, both activated by `S1`) | second-order plasticity **downstream** of first-order plasticity, inside the same complex |
| Lesions of the basal nucleus stop a fearful CS supporting instrumental escape learning but spare freezing to that CS; lateral-nucleus lesions block both | basal vs lateral | dissociates the *secondary-reinforcing* function from the *conditioned-response* function — or the basal nucleus is only a conduit for escape behaviour; the source states both readings |
| Storage of the US representation for first-order retrieval | posterior insular cortex below the rhinal sulcus — **post**-training lesions block expression, **pre**-training lesions do not | a cortical outcome-identity store orchestrated by the amygdala, degraded by late lesions and substitutable when lesioned early |
| Excitotoxic basolateral lesions block acquisition of second-order **appetitive** conditioned approach, sparing the same response to a first-order CS | basolateral amygdala | not a performance deficit |
| Central-nucleus lesions block first- **and** second-order conditioned **orienting**, sparing conditioned approach to food | central nucleus | "regulates attentional processing of cues during conditioning" vs the basolateral nucleus giving CSs "access to the motivational value of their associated USs" |
| Basolateral lesions block the effect of US devaluation, and block detection of a reward-magnitude decrease (Crespi / negative contrast) | basolateral amygdala | proposed mechanism for the second-order block: loss of access to the reinforcer's *current* value stored in posterior insular cortex |
| Basolateral lesions cut a sex-CS's ability to support instrumental lever acquisition, sparing responding to the primary reinforcer | basolateral amygdala | appetitive secondary reinforcement, same profile |
| Intra-amygdala AP5 blocks acquisition of taste-potentiated odour aversion, sparing first-order taste aversion | basolateral amygdala | the pattern generalises past second-order conditioning proper |

**First-order appetitive conditioning survives the lesions that block second-order appetitive conditioning**, so the reinforcer's *original* value is stored outside this amygdalo-cortical network. Two value stores for one outcome, one of which the chaining operation requires and the other of which it does not — see [[wiki/concepts/valuation-system-decomposition.md]].

---

## Second-order conditioning as an instrument: separating retrieval from performance

The methodological payload, and reusable in machines. A treatment that blocks *expression* of first-order conditioning when given before test, but not *acquisition* when given before training, is ambiguous: it may block memory retrieval or it may block the motor output. Because second-order conditioning requires retrieval of the first-order memory as its reinforcement signal, and requires **no** overt first-order response (the `S2→affect` result above), testing acquisition of second-order conditioning under the drug disambiguates them.

| Case | Finding | Inference licensed |
|---|---|---|
| D2 agonist **quinpirole**, systemic | blocks acquisition of second-order conditioning; **spares** sensory preconditioning | not a general block on plasticity or on CS transmission — D2 stimulation (probably in the ventral tegmental area) blocks retrieval of a central fear state, not the performance of freezing |
| Opiate antagonist **naloxone**, before second-order training only | **enhances** second-order conditioning; no shocks given after administration | cannot be a change in shock sensitivity — an effect on associative learning proper |
| **AP5** into the amygdala, before second-order sessions, no refresher first-order pairings | completely blocks acquisition of second-order conditioning; the **same dose enhances expression of first-order conditioning** | the block is not from disrupting transmission of the reinforcement signal, because that signal was demonstrably stronger |

The AP5 case is the template: **an intervention that removes the second-order learning while strictly increasing the first-order signal that feeds it cannot be explained as starving the input.** The corresponding ablation for a hierarchical agent — knock out option-level learning while showing the goal-level value estimate is intact or improved — is not run anywhere in the wiki, and it is the only clean way to show a hierarchy's upper level is doing work rather than inheriting it.

---

## What a builder takes

| Finding | Consequence for an architecture |
|---|---|
| A second-order link carries valence and magnitude but **not** outcome identity | A manufactured subgoal cannot name the goal it was built from. Outcome-specific planning over self-generated subgoals is unavailable by construction, and this is the mechanism behind the per-link value attenuation [[wiki/concepts/conditioned-reinforcement.md]] measures (`T395`) |
| The valence-free link is written **only when the successor was unpredicted** | Structure acquisition inherits blocking: an agent that already predicts `X` refuses to add a second predictor of it. Every world model in the wiki fits both edges, so the biological learner is strictly sparser and the redundancy is priced rather than free (Sharpe et al. 2017, [[wiki/concepts/state-prediction-error.md]]) |
| Sensory preconditioning writes an identity link with **no valence**, before any reward exists | Structure learning and value learning are separable operations over the *same* pairs, run at different times, stored in different places. An agent can build the graph before it has any reason to (`G17`, latent-graph discovery), and then a single `S1→US` episode retro-values the whole chain |
| Association *type* = insertion point in the signal-flow graph | The one non-psychological definition available. Four wiring choices with fully specified behavioural profiles; every hierarchical learner here makes this choice implicitly and none reports it |
| The chaining procedure **is** the feature-negative discrimination | Manufacturing a subgoal simultaneously trains its suppressor, on the same trials, with a slower time constant that eventually dominates (`G126`). No machine subgoal mechanism has an opponent term at all |
| Partial reinforcement of the first-order contingency suppresses the inhibitor and spares the excitation | A deliberate design lever: make the goal-cue *unreliable* on its own so that the subgoal's presence stops being the feature predicting non-reward |
| The sign of measured second-order value flips with the read-out window | Any single-window measurement of a subgoal's value reports the sum of two temporally segregated opposite-signed quantities (`G116`, `G121`) |
| Second-order acquisition probes first-order **retrieval** without requiring the first-order response | A retrieval/performance dissociation that needs no new apparatus — and the AP5 template: block the upper level while *raising* the lower-level signal |
| First-order plasticity and second-order plasticity sit at different, serially arranged sites in one structure | Levels of a hierarchy need not be different modules; they can be different depths in one pathway, which is why one lesion "of the amygdala" hits both and a finer one dissociates them |
| Most ethological reinforcers have **acquired**, not intrinsic, value | The source's closing claim: a monkey must learn the sight of a banana from its odour and taste; little human learning involves direct pairing with unconditioned reinforcers. The innate reward set is small and almost everything an agent wants is built by this chain — which makes the chain's *depth limit* (identity lost at step one) the binding constraint on how far a value system can bootstrap |

---

## Open problems

- **Nothing predicts where in the trial the excitatory and inhibitory components fall**, so the read-out window that separates them is found empirically per preparation.
- **No account of why the inhibitor is ultimately stronger**, or of what sets the two time constants — the inverted U is described, not derived.
- **The `S2→affect` register has an assay and no update rule.** What "a central state of fear/hope" is as a representation, how many of them there are, and how they compose, are all untouched — the same complaint [[wiki/concepts/valuation-system-decomposition.md]] logs against its `CS → affect` row.
- **Whether basal-nucleus lesions abolish second-order plasticity or only its expression route is undetermined** by the escape-learning result; the source offers both readings and no experiment between them.
- **The unitary-representation escape is a label.** Simultaneous presentation plus few first-order trials yields `S2→S1`; "the two stimuli are encoded as one object" is the proposed reason and has no independent test here.
- **Refresher trials cannot be used when the design requires no US**, so the `S1`-extinction confound and the no-US requirement are in direct conflict for any long second-order training run.
- **The clipped source lost its citations**, so every result above is at one remove; the originals have not been checked against.

---

## Connections

- **[[wiki/concepts/conditioned-reinforcement.md]]** — the same chain measured for *worth* rather than for *content*, and the two halves compose: that page finds value attenuates with each added link and reports no theory of why, this page supplies the reason — the second link is not a copy of the first but a different association type, formed at a different insertion point, carrying valence without outcome identity. It also supplies a hazard that page's extinction account is missing: an unbacked delivery does not merely fail to reinforce, it actively trains an inhibitor on the feature-negative contingency the procedure creates (`G126`).
- **[[wiki/concepts/valuation-system-decomposition.md]]** — fills that page's most conspicuous blank and contradicts one of its rows. Its `CS → affect` valuation had an assay (transreinforcer blocking) and no substrate and no update rule; second-order conditioning is a second assay for it, with a candidate substrate (basal nucleus of the basolateral amygdala) and the beginnings of an update rule. But that page lists second-order conditioning as an isolating assay for the *specific-outcome* Pavlovian valuation, which the devaluation, inflation and keypeck-topography results here deny (`T395`).
- **[[wiki/entities/amygdala.md]]** — resolves that page's "second-order conditioning: BLA impaired" row into a depth claim rather than a content claim: the lateral nucleus is the first-order `S1`/US convergence site and the basal nucleus the proposed second-order site, so a basolateral lesion removes second-order conditioning by removing the *stage downstream of* outcome identity — which is why the same lesion spares sensory preconditioning, and why the block does not license reading outcome identity into what `S2` learned. Adds the insular-cortex US store, the pharmacological dissociations (quinpirole, naloxone, AP5) and the basal/lateral escape-learning split.
- **[[wiki/concepts/pseudo-reward-prediction-error.md]]** — the machine subgoal signal this page's constraints apply to: a pseudo-reward has no opponent process, no insertion point, and is assumed to carry the identity of the goal it decomposes — all three of which the biological chain denies (`G126`, `T395`, `T367`).
- **[[wiki/concepts/latent-graph-discovery.md]]** — sensory preconditioning is the clean demonstration that edges can be written before any of them has a value, and then valued wholesale by a single terminal episode. That separates graph *acquisition* from graph *scoring* as distinct operations over the same observations, which is the shape this wiki's core framing asserts and rarely gets an experiment for.
- **[[wiki/concepts/temporal-abstraction-options.md]]** — the insertion-point table read as an option-critic wiring choice: where the option-level value input attaches relative to the outcome-identity representation and the policy fan-out determines whether option value tracks goal revaluation, whether it can name the goal, and whether it generalises across action heads. The formalism leaves this unspecified and the behavioural consequences are fully enumerated here.
- **[[wiki/concepts/optimal-hierarchy-criterion.md]]** — supplies a second unpriced cost beyond that page's missing per-level charge: adding a level does not only attenuate value, it changes the *type* of what is stored, so two decompositions with identical model evidence can differ in whether the upper level retains outcome identity at all.
- **[[wiki/concepts/incentive-salience.md]]** — the same "pull without identity" profile from the neural side; this page gives its associative origin, since a second-order link is constitutively identity-free rather than made so by a gain term applied afterwards.
- **[[wiki/concepts/affective-opponency.md]]** — an opponent pair built by a *training procedure* rather than by chemistry or by projection target: excitation and inhibition to the same stimulus, acquired on the same trials, with different time constants and different temporal positions within the trial, summing at the response.
- **[[wiki/concepts/token-reinforcement.md]]** — the chain priced rather than typed: each token is a pairing-made link, and the controlling variable across the whole chain is the *terminal* link's timing — equalising the delay to exchange reverses choice with the intermediate link untouched — which is the behavioural counterpart of this page's claim that the intermediate link carries sign and magnitude without outcome identity (`T395`).
- **[[wiki/concepts/sign-tracking-and-goal-tracking.md]]** — the same "pull without an outcome behind it" reached by a different route: there the cue's pull lacks outcome identity by *phenotype* rather than by procedure, and the two together say a target that is approached and a goal that is sought are separate products of one pairing, separable by individual and by pharmacology (`T404`).
- **[[wiki/concepts/state-prediction-error.md]]** — the learning rule behind this page's third paradigm: the `S2→S1` link is acquired only when `S1` was unpredicted (blocking of sensory preconditioning), and a ventral tegmental dopamine transient at `S1`'s onset is sufficient and necessary to write it — so the paradigm that carries no valence is nevertheless gated by the projection the wiki reads as the value error.
