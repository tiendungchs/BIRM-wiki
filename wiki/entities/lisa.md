# LISA (Learning and Inference with Schemas and Analogies)

**A symbolic-connectionist model of analogy in which role-filler bindings are carried by *neural synchrony*, so working memory has a capacity *bound* that comes from the code, not from a slot count: only as many bindings can be live as can be kept mutually out of phase under noise. The bound's *value* (5–6 bindings) is chosen by the modellers (see "From the primary" below). Every other component of analogy — retrieval, mapping, inference, schema induction — is then made to run inside that budget.**

> **Provenance.** Described in Holyoak, K. J. (2012), *Analogy and relational reasoning*, in Holyoak & Morrison (eds.), *The Oxford Handbook of Thinking and Reasoning*, ch. 13 (`raw/holyoak-2012-analogy-relational-reasoning.md`), which reviews the model rather than presenting it. The "neural realization" section is from **Knowlton, Hummel & Holyoak 2012** (two of the model's three authors), which is the wiki's one first-party statement of what LISA claims about tissue. **Primary now read (fourth source on this page):** Hummel, J. E. & Holyoak, K. J. (2003), *A symbolic-connectionist theory of relational inference and generalization*, Psychological Review 110(2):220–264 (`raw/hummel-2003-symbolic-connectionist-theory-relational-inference.md`). It gives inference, schema induction and the full equations, and it is the source for the "From the primary" section. Hummel & Holyoak 1997 (retrieval and mapping) and Doumas, Hummel & Sandhofer 2008 (DORA) are still **not read**.

The wiki reaches LISA from [[wiki/concepts/analogical-mapping.md]], where it already occupies one row of the model-landscape table as the model whose vector similarity measures "do not apply". This page states what it buys in exchange.

---

## Architecture

| Layer | Units | What it holds |
|---|---|---|
| Semantic | **distributed** micro-features | Concept meaning — shared across analogs, the only place semantic similarity lives |
| Object / Predicate-role | localist | The two things a binding binds |
| Sub-proposition (SP) | localist | One role bound to one filler |
| Proposition (P) | localist | A whole relation; can itself fill a role in a higher-order proposition (nesting) |

Two memories: a **long-term store** of propositions and concept meanings, and a **limited-capacity working memory**. One analog at a time is the **driver**; the others are **recipients**.

| Operation | Mechanism |
|---|---|
| **Binding** (WM) | **Synchrony**: a role and its filler fire in phase; different bindings occupy different phases |
| **Capacity** | A finite number of bindings can be simultaneously active and mutually *out* of phase. Reviewed estimate: **2–3 propositions** live in the driver. *Corrected from the primary:* the existence of the bound comes from the code; its value, **5–6 SPs** (subproposition units), is set by a chosen decay constant (see below) |
| **Retrieval** | Guided pattern matching: driver propositions drive synchronized activation on the *semantic* units, which activates propositions in recipients residing in long-term memory |
| **Mapping** | **Mapping connections** between same-type units (object↔object, predicate↔predicate) in separate analogs, grown by simultaneous activity — a Hebbian correspondence learned during co-activation, not a search over match hypotheses |
| **Inference** | Self-supervised learning: run the *source* as driver, and the structure it induces in the recipient that the recipient lacks is the analogical inference (copy-with-substitution-and-generation, [[wiki/concepts/analogical-mapping.md]]) |
| **Schema induction** | Intersection discovery over the mapped pair — what the two analogs share becomes a new, more abstract proposition set |

**The single design commitment.** Correspondence is *learned from co-activation* rather than *scored over a hypothesis space*. ACME pays `O(n⁴)` for relaxation over one node per candidate match; SME pays up to `O(n!)` for merging local matches. LISA pays instead in **serialisation**: only 2–3 propositions can be in phase at once, so a complex mapping must be built over several load cycles.

---

## What the serialisation predicts, and what was found

| Prediction from the capacity bound | Evidence |
|---|---|
| Complex analogies are mapped **incrementally**, early mappings constraining later ones | Order effects in human mapping (cf. Keane 1997) |
| Success depends on **which** propositions are co-loaded — coherent, causally interlinked sets disambiguate better | Kubose, Holyoak & Hummel 2002: driver coherence affects mapping accuracy |
| The **better-understood analog should be the driver** | Mapping the solved "general" story onto the unsolved tumour problem is more accurate than the reverse (Gick & Holyoak 1980) |
| Degrading working memory should shift responses from relational to similarity-based | Dual task and induced anxiety both do exactly this in healthy adults (Waltz et al. 2000; Tohill & Holyoak 2000) |
| Losing prefrontal inhibitory control should selectively cost the case where a similar distractor competes | Frontal patients impaired on negative-semantic-facilitation analogies; frontotemporal degeneration abolishes relation-based mapping (Morrison et al. 2004; Waltz et al. 1999) |

The same architecture is reported to simulate similarity judgments (Taylor & Hummel 2009), the developmental relational shift (Doumas et al. 2008; Morrison, Doumas & Richland 2011), relational decline in older adults (Viskontas et al. 2004), and frontal vs temporal lesion profiles (Morrison et al. 2004) — **one model, four populations, one manipulated quantity** (how much can be held in phase, and how well competitors are inhibited).

The scene-analogy case is the sharpest: for a reasoner to map the *chasing cat* in the source onto the *chasing boy* in the target, the units representing `chases(boy, girl)` must **inhibit** the units of the featurally similar `sits-on(cat, ground)` distractor. Mapping is therefore a competition, and its failure mode is a perceptually-driven answer, not a missing one.

---

## Where it sits among the wiki's binding schemes

| | LISA | HRR / VSA ([[wiki/concepts/vector-symbolic-binding.md]]) | CDT code-vectors ([[wiki/concepts/analogical-mapping.md]]) |
|---|---|---|---|
| Binding carrier | **Time** (phase) | Algebraic operator (`⊛`) on a fixed-width vector | Thinned OR over sparse binary vectors |
| Capacity limit | Number of resolvable phases — a *hard* structural bound | Graceful degradation with superposition; set by dimension `N` | Set by code density and `N` |
| Structural similarity | Not readable by a dot product at all — a synchrony code has no fixed vector to compare | `sim` of contextualized codes ranks analogs directly | `sim` of re-represented codes ranks *and* aligns |
| Correspondence | Learned Hebbian mapping connections | Never computed, only scored | `argmax` of a dot product |
| Cost of a mapping | Several serial load cycles | One pass | `O(n·n′)` dot products |
| Scaling | **Does not scale to large analogs** (stated) | Fails only through dimension | `O(n²)` argued, not measured |

**The trade is legible.** Synchrony buys a *psychologically correct* capacity limit and a natural home for inhibitory control, at the cost of every similarity operation the rest of the wiki's memory machinery is built on. A phase-coded binding cannot be stored in an attractor, indexed by a dot product, or fed to a nearest-neighbour retrieval — which is precisely why LISA needs a *separate* semantic-unit pathway to do retrieval, and why the distributed vector models (which have no capacity limit) have to import one.

---

## What Penn, Holyoak & Povinelli 2008 read off this model

> `raw/penn-2008-darwins-mistake-discontinuity.md` — the same laboratory's comparative argument, which uses LISA as its existence proof and takes three claims out of it that the review above does not state.

| Claim | Statement |
|---|---|
| **The architecture is a *graft*, not a design** | LISA implements the higher-order relational capabilities "via an additional representational system that has been grafted onto a simpler system of conjunctive representations used for long-term storage." That simpler system is functionally but **not concatenatively** compositional — which the authors argue is exactly the representational level of nonhuman cognition ([[wiki/concepts/relational-reinterpretation.md]]) |
| **What the graft buys is one property** | Not capacity, not depth: **role-filler independence maintained *while* the role and filler are dynamically bound**. Synchrony is the only mechanism in the wiki that delivers both at once, because two units in phase are simultaneously and separably active |
| **The local-minimum argument** | Because it is hard to get P5–P8 into a network and easy to get P1–P4, "there is no simple next step that will transform a clever PDP model into a full-fledged PSS complete with dynamic role-filler binding." Nonhuman architectures are therefore read as local minima whose exit cost was paid by one lineage |

Two consequences for a builder, and the second is the uncomfortable one:

- **The claim is falsifiable at the neural level and stated as such.** If LISA is right, the human/nonhuman difference is *synchronised activity among prefrontal populations* supporting dynamic binding, and among frontal–posterior populations — neural synchrony being used by many species for contextual association, with the human innovation being its **co-option for role-based coding** rather than its existence ([[wiki/concepts/inter-areal-synchrony.md]]). The authors concede this "requires much further empirical support before it can be deemed anything more than a plausible possibility."
- **The wiki's other binding schemes are, on this reading, below the line.** A compressed conjunctive code (HRR) is precisely the *long-term store* half of LISA's two-system architecture — the half the graft was needed on top of. Whether a scheduled unbinding operator substitutes for the graft is unresolved and is logged as [[wiki/empirical-tensions.md]] T293.

The authors' own verdict on the model is worth keeping beside the limitations below: "LISA is the worst model of higher-order reasoning currently on offer, except for all the others."

---

## The neural realization, stated by the model's own authors

> Knowlton, B. J., Morrison, R. G., Hummel, J. E. & Holyoak, K. J. (2012), *A neurocomputational system for relational reasoning*, **Trends in Cognitive Sciences** (`raw/knowlton-2012-neurocomputational-relational-reasoning.md`). An Opinion piece that takes each LISA construct and names the neural mechanism that would have to carry it. Everything here is a *hypothesis with converging evidence*, not a measurement of LISA in a brain: the authors state outright that "no direct evidence yet connects such activity to the coding of propositions."

### The capacity number is derived, not fitted

The table above records 2–3 propositions as a reviewed estimate. Here it is an arithmetic consequence of the carrier:

```
max phase set = (period of the carrier oscillation) / (duration of one phase)
```

| Term | Value assumed |
|---|---|
| Carrier | gamma, > 30 Hz — one spike or burst per population every ≈ **25 ms** |
| One phase | one role binding (an RB unit and its constituents) — the smallest unit of working memory |
| Phase duration | set by population burst width and/or single-spike temporal precision |
| → phase set | **4–6 role bindings ≈ 2–3 propositions** |

Two consequences no other capacity account in the wiki carries. **The limit is a ratio of two time constants**, so it moves with either — a slower carrier or a sharper temporal precision raises capacity, which is a manipulable prediction rather than a fitted slot count. And **it is not prefrontal-specific**: the same arithmetic runs wherever populations bind by synchrony, which is the authors' proposed reason a ~4 limit recurs in low-level posterior tasks. Set against [[wiki/concepts/working-memory.md]], where Rolls derives `7 ± 2` from noise-driven attractor transitions with no clock at all — the two derivations are the two positions of [[wiki/empirical-tensions.md]] T32.

**A third derivation lands on the same number with the nesting turned over** (Roux & Uhlhaas 2014, `raw/roux-2014-wm-oscillations-alpha-gamma-theta-gamma.md`): one **gamma cycle is one slot** and a slower rhythm supplies the frame, so the phase set is `frame period / gamma period` — ≈5–6 slots inside a 7 Hz theta cycle, ≈4 inside a 10 Hz alpha cycle. It is the same ratio-of-two-clocks argument reading the same 4–6 off the opposite assignment, and the disagreement is empirical rather than notational: LISA raises capacity by slowing gamma or sharpening burst precision, the duty-cycle account raises it by choosing a slower **frame**, and only the latter predicts that capacity differs between sequentially and simultaneously presented material — which is the reported psychological finding. It also puts LISA's cross-frequency coupling to a second use it does not claim: there theta phase merely *schedules* the gamma bursts carrying semantics inward, here the theta period *is* the budget.

### One band per LISA operation

| LISA requirement | Proposed carrier | Evidence offered |
|---|---|---|
| Keep distinct role bindings **mutually out of phase** inside prefrontal cortex | Local gamma, separation maintained by local inhibition | Monkey prefrontal single units + local field potential: spikes to a given stimulus land at a characteristic point of a **32 Hz** cycle, and with two items held the second item's spikes occupy a *different* point of the wave |
| **Bind** role to filler | Within-phase synchrony | Human priming evidence for synchrony in perceptual relations; fronto-parietal phase synchrony binds object properties in working memory (EEG); task-dependent synchronous pairs in monkey prefrontal cortex that reconfigure with working-memory content |
| Move **semantics** (posterior cortex) into prefrontal RB units | Long-range **theta** | Low-band coherence is detectable between sites several mm apart; prefrontal cortex also shows ≈3 Hz spike synchronization alongside the 32 Hz structure |
| Couple the two | **Cross-frequency coupling** — theta phase modulates gamma amplitude, so the slow long-range wave sets *when* local gamma bursts occur | Standard phase–amplitude coupling; the authors' proposal is that posterior semantic activity thereby schedules prefrontal binding |
| Grow **M units** and **proxy units** within a trial | **STDP** riding the same gamma | At high gamma, inputs arrive just before the postsynaptic cell is depolarized → potentiation; hippocampal LTP is induced preferentially at theta peaks and blocked when theta is blocked; monkey prefrontal single units learn new connections rapidly |
| **Unbind** — return a proxy unit to the free pool | LTD, from a millisecond shift of the *same* spike timing | The potentiation → depression sign flip occurs over a few ms of relative timing |

**The design claim worth extracting.** One physical variable — spike timing — is asked to do four jobs at once: *represent* a binding (phase), *separate* bindings (anti-phase), *route* between areas (cross-frequency coupling), and *write* the binding into weights (STDP). That is unusually parsimonious and correspondingly brittle: any jitter large enough to cost the code its phase separation is also large enough to flip the sign of the learning rule, so representation and learning fail together rather than independently. **(brainstorm)** No model in the wiki shares one timing variable between its binding code and its plasticity rule — and the cheap test is to add jitter to a synchrony-binding model and check whether the two failures are correlated, which is the signature this architecture predicts and a separated architecture forbids.

### Proxy units have a candidate cell type

Proxy units are LISA's transient prefrontal copies of long-term structure units — recruited per problem, released afterwards. What the monkey lateral prefrontal literature offers:

| Property a proxy unit needs | Observation |
|---|---|
| Codes an **abstract** category, not features | ≈ **⅓** of lateral prefrontal neurons are category-selective on *conceptual* grounds; they respect sharp category boundaries and respond alike to typical and atypical members — unlike inferotemporal neurons, whose firing is graded by visual form |
| Codes a **rule or relation**, not the stimuli | Cromer et al.: **41%** of recorded prefrontal neurons — the most common type — track the current rule (match vs. non-match) irrespective of which stimuli are present; found throughout prefrontal cortex, majority lateral |
| Is **re-assignable** between problems | The same neuron responds to different categories under different tasks, trial by trial — the opposite of the static inferotemporal profile |

**This is the same population [[wiki/concepts/population-geometry.md]] reads as mixed selectivity, and the two readings are not the same claim.** A random-mixing account calls the heterogeneity a *high-dimensional basis* that a linear readout exploits and that is therefore permanent; LISA calls it a *pool of unassigned units awaiting recruitment*, in which case the tuning of a given cell should turn over between problems and the dimensionality is a by-product. **(brainstorm)** The two are separated by a turnover measurement nobody has run: re-record the same cells across two structurally distinct analogies and ask whether selectivity is re-drawn or merely re-weighted.

### The rostro-caudal abstraction gradient is the model's own hierarchy

Badre & D'Esposito's caudal → rostral ordering (specific stimulus–response actions → actions based on integrated abstract goals) is read here as the anatomy of LISA's layering, with **M units at the rostral end**: mapping units encode shared relational roles across two analogs and are the most abstract objects in the model, matching RLPFC's selective engagement by abstract concepts (Christoff et al.). The constraint this puts on a builder is real: mapping units are not a data structure stored beside the propositions, they are a *level* with its own tissue and its own abstraction rank. The direction of the arrow along that gradient is itself contested — [[wiki/empirical-tensions.md]] T332.

### Inhibition has a location, and it is not the integrator

LISA requires **top-down inhibition of propositions tagged low in goal-relevance**, so they never enter the phase set at all; this raises the signal-to-noise ratio favouring goal-relevant matches, and is separate from the circuit-level inhibition that keeps admitted bindings out of phase with each other.

| Function | Region | Evidence |
|---|---|---|
| Suppress interfering relations during analogy | **right inferior frontal gyrus** | Cho et al. 2010: activity rises with the amount of interfering information. Sweis et al. 2012 (scalp EEG): right prefrontal cortex modulated at *late* stages of processing when a distracting relation must be ignored, and the degree of modulation **interacts with the reasoner's working-memory capacity** |
| Suppress a prepotent response | right inferior prefrontal cortex | Lesion → failure to inhibit prepotent responses |
| Social and emotional inhibition | orbitofrontal cortex | Lesion → social/emotional disinhibition |

So "dynamic filtering of posterior activation" is **domain-split by subregion**, and the analogy channel is a *late*, capacity-dependent one. That timing is the awkward part for the model: LISA's filter is supposed to act *before* admission to the phase set, and a late modulation looks instead like eviction of something already loaded.

### Where the authors put LISA among neural models of thinking

| Model | Binding scheme | Relation to LISA |
|---|---|---|
| **SMRITI** | synchrony, localist, mapped onto known hippocampal architecture | **Complementary, not rival** — same coding scheme, episodic encoding/retrieval rather than reflective reasoning |
| **STAR-2** | tensor products | **Tensor rank = relational complexity**, so task difficulty is read directly off the representation ([[wiki/concepts/tensor-product-representation.md]]) — the one rival that predicts the same behavioural variable from a different code |
| **ACT-R** with neural modules | production system + modules mapped to brain areas, with a per-module activation time course | Not a rival: the *control structure* within which LISA's reasoning would run |
| **SAL** (ACT-R + Leabra) | symbolic control over point-neuron subsymbolic layers | Same role, with the subsymbolic layer supplied |

### What the authors concede is unmeasured

- **No direct evidence** that oscillatory activity codes propositions in human prefrontal cortex — the load-bearing claim of the whole account.
- No oscillatory model predicts the measured network dynamics of relational reasoning.
- The several kinds of inhibition the model needs — circuit-level phase separation vs. goal-relevance filtering — have not been separated in time or anatomy.
- **The relation between prefrontal dynamic role binding and hippocampal/medial-temporal binding is unspecified**, though both are synchrony claims in this wiki ([[wiki/entities/hippocampal-prefrontal-channel.md]]).
- **Where the semantic units come from.** No learning process is offered for the pools that carry object and relation meaning — the same hand-coding objection the Limitations section below records, now stated by the authors.
- Fronto-striatal circuits are guessed as the maintainer of M units over intervals when attention is elsewhere; untested.
- Neuromodulation is absent from the model entirely. Dopamine, noradrenaline and serotonin are proposed as the route to individual differences (receptor-gene polymorphisms) and to psychiatric reasoning deficits, with anterior cingulate → locus coeruleus as one concrete loop ([[wiki/concepts/neuromodulatory-metaparameters.md]]).

### The conflict this section creates with the wiki's own band rule

LISA needs long-range **theta** to be the channel that carries posterior semantic content into prefrontal binding units. The wiki's band rule, derived from cut-the-wire experiments, says the opposite about what theta coherence indexes: silencing the direct projection **abolishes gamma coupling and leaves theta coupling untouched**, so theta coherence is the signature of a common relay rather than of drive along the link ([[wiki/concepts/inter-areal-synchrony.md]]). If that generalizes to the fronto-temporal semantic link, LISA's content channel runs in the band that is *least* diagnostic of a direct pathway, and the model silently requires a third structure it does not have. Logged as [[wiki/empirical-tensions.md]] T333.

---

## From the primary (Hummel & Holyoak 2003)

> Everything in this section is first-hand from the 2003 paper. Simulations use hand-coded toy analogs (≤ 27 propositions), with importance and support values set by hand for each simulation; human data are reproduced qualitatively, not fitted.

### The five requirements the architecture is derived from

| # | Requirement | What it forces |
|---|---|---|
| 1 | Bind fillers to roles | Explicit binding tag |
| 2 | Filler identity survives across roles, and role identity across fillers | Role and filler represented **independently** of each other, so a conjunctive unit (`Bill-as-lover`) is ruled out |
| 3 | Map by role, not by filler similarity | Sally → Bill despite Sally ≈ Mary in features |
| 4 | Inference extends the mapping | A correspondence must be stored somewhere it can be reused |
| 5 | Symbols have semantic content | Distributed features underneath the localist tokens |

1–4 make it a symbol system; 5 makes the symbols distributed. The claim: synchrony is the one neurally plausible binding tag that meets 1–2 at once. They cite Hummel, Devnich & Stevens 2003 (a manuscript in preparation, not read) as proving that "synchrony of firing is unique in its capacity to represent bindings both explicitly and independently of the bound entities" (`T293` Position A).

### Why the tokens are localist (`L2`)

- **A correspondence lives on a token, not on a feature pattern.** If Sally were a distributed code over object units, a mapping learned for Sally would "generalize automatically to any other objects sharing object units with Sally". Generalization is a strength of distributed codes, and here it would be a liability: Sally → Bill does not imply that everyone similar to Sally maps to Bill.
- **Types vs tokens.** Each analog has its own token for each entity (one token per entity per analog, however often it is mentioned). All tokens of a type connect to the same semantic units, plus a unique feature (`Bill#47`). The **semantic units are types and the only channel between analogs**. Two same-type entities stay distinct by construction (cf. `G69`'s harder statement), but every token is created by hand at encoding.
- **The proposition is stored by the same units in WM and LTM (long-term memory).** The only difference: synchrony binds in WM, and the localist SP units hold the binding in LTM. This is the "graft onto a conjunctive store" that Penn et al. read off the model (above).

### Memory hierarchy, with time constants

| Level | Content | Capacity | Duration |
|---|---|---|---|
| LTM | All analogs | Unbounded | Lifetime |
| Active memory (Cowan; long-term WM) | Driver, recipient, **mapping weights** | No firm limit; time-limited | Decays ≈ **20 s** unless re-attended |
| WM = phase set | Mutually desynchronized role bindings; **mapping hypotheses** | **5–6 SPs** ≈ 2–3 propositions | ≈ 0.5 s to a few s |
| One phase | One role binding | 1 | A few ms per peak |

**Mapping hypotheses (`h`) and mapping weights (`w`) sit at different levels.** `h` can be updated only while its driver unit is active, so it lives in WM, and WM capacity therefore caps the number of correspondences under evaluation at once. `w` lives in active memory and carries across phase sets. The authors' neural guess is prefrontal neurons with rapidly modifiable synapses whose activity *gates* communication between the units they map. They do not propose it as a literal weight.

### Signal flow inside one phase set (`L2`)

| Signal | Rule | Why |
|---|---|---|
| Attention | External input 1.0 to each SP in the phase set, not to the P (proposition) unit | Lets the SPs of several co-loaded propositions time-share |
| Driver SP oscillation | Each SP has a yoked inhibitor; strong SP–SP inhibition | Bound units fire together; different bindings fire apart |
| Driver → recipient | Only through shared semantic units at first; later through mapping weights too | Communication between analogs is by type |
| Recipient top-down feedback and out-of-proposition inhibition | **Suspended until every driver SP in the phase set has fired once** | Stops the recipient committing to the best match for the first SP that fires |
| Global inhibitor | Turns on (value 10) whenever no driver SP is ≥ 0.7, and clears all non-driver analogs | Refresh between phases |
| Mapping-based global inhibition | A driver unit inhibits all recipient units in proportion to `max w` out of it and `max w` into them, and a matching mapping weight exactly cancels it (`3w − max − max = w`) | Replaces inhibitory mapping connections: same effect, no all-to-all wiring |
| **Co-loaded propositions** | When > 1 proposition is in the phase set, **object semantics are ignored** | Puts all the emphasis on relations (Medin, Goldstone & Gentner 1994: features early, relations late). The user, not the model, decides when to co-load |

### Equations worth keeping

```
Firing choice (Luce):   p_i = c_i / Σ_j c_j ,   c_i = r_i (s_i + m_i)
  s_i = support from recently fired propositions (decays ×0.5 per step; reset on firing)
  m_i = pragmatic importance (user-set);  r_i = readiness, grows +0.1 per step, halves on firing
Token activation:       Δa_i = γ n_i (1 − a_i) − δ a_i        (γ = .3, δ = .1)
Mapping hypothesis:     Δh_ij = a_i a_j                        (Hebbian, within a phase set)
Mapping weight:         h ← h / max(row, col);  h ← h − max_other(row, col);
                        Δw_ij = η (1.1 − w_ij) h_ij , clipped to [0, 1]   (η = .9)
Semantic unit:          a_i = n_i / max(max_j |n_j|, 1)        (divisive normalization; negative = negation)
Inferred unit → semantics: Δw_ij = 0.2 (a_j − w_ij)
```

Row/column competition in the `w` update is the **soft one-to-one constraint**. The asymptote of 1.1 with clipping at 1 keeps a weight of 1.0 revisable.

### Capacity is a noise limit on time-sharing, and its value is chosen

*Corrected from the primary.* The 25 ms / 5 ms = 5 arithmetic (Singer & Gray 1995) is the *motivation*. The *implemented* limit is a time-sharing algorithm:

- After an SP fires, its sensitivity to inhibition from other SPs jumps to MaxS = 6 and decays by `δ_s` toward MinS = 3. The SP that fired least recently wins the next phase.
- If `s` returns to its minimum in the time `N` SPs take to fire, then **`N + 1` SPs time-share reliably**.
- A smaller `δ_s` buys slots in principle, but it shrinks the differences between the `s_j(t)`. Under nonzero noise those differences stop being discriminable, so there is an optimal `δ_s` and capacity falls on either side of it.
- "There is currently no basis for estimating the amount of noise" — the authors **chose** `δ_s` (= .0015) to give 5–6 SPs.

So LISA's capacity bound is a *signal-to-noise* bound on a decay constant, which is closer to Rolls's noise-driven `7 ± 2` ([[wiki/concepts/working-memory.md]]) than the clock-ratio framing (Knowlton et al. 2012, above) suggests. For `T32`, the phase position therefore does not escape a noise parameter either.

### Inference: absence of a match is itself a signal (`L2`)

| Step | Mechanism |
|---|---|
| **License** | Inference is attempted only if ≥ **70%** of the recipient's importance-weighted units (`Σ q_i j_i / Σ q_i`) map to the driver. The rule is deterministic and checks the whole analog, not subsets; both are named simplifications |
| **Detect a missing correspondent** | An unmapped driver unit `k` sends mapping-based global inhibition to every mapped recipient unit and excites none. **Inhibition without excitation** is the cue that nothing in the recipient corresponds to `k` |
| **Mint** | The recipient creates a new token of the same type (P, SP, predicate or object). The authors do not claim new neurons; they claim the same process that creates tokens at encoding |
| **Wire** | The new unit learns Hebbian connections to whatever is co-active: a new P to active SPs, a new SP to active predicates/objects, new predicates/objects to active semantics. Mapped fillers arrive in synchrony over their mapping weights, so `jealous(Bill, Sam)` yields `*jealous(Sally, Cathy)` |

The authors call this **self-supervised**: no teacher, and not driven by input statistics alone; the system's own mapping decides whether to infer and what. Because inference runs through the mapping, LISA **cannot make an inference inconsistent with the mapping it found** (Spellman & Holyoak below).

**(brainstorm)** The trigger is a generic `L2` primitive the wiki lacks: *a broadcast that every matched unit is entitled to cancel, so a residual uncancelled inhibition flags "no correspondent here"*. It costs one global signal per driver unit, needs no enumeration of candidates, and doubles as the minting trigger for `G69` and as a novelty signal.

### Schema induction: intersection by normalized feedback

- The schema starts as an **empty analog** and is filled by the same minting rule: every driver token that fires for the first time gets a schema token.
- Recipient units feed back to the semantic units, so semantics shared by driver and recipient get ≈ **2×** the input of unshared ones. After divisive normalization, schema tokens learn **stronger weights to shared features**.
- **Propositions never fired never enter the schema.** Firing order and importance therefore filter trivial details out of both inference and abstraction, with no explicit filter.
- **Iterated, it is graded, not binary.** Unique features are down-weighted, never deleted, so weights converge on each feature's frequency across examples: 8 of 10 love triangles with a female in the central role give a central-role token biased toward `female`.

### Results

| Simulation | Runs | Result |
|---|---|---|
| Airport/beach (St. John 1992) | many | **Always** infers `drive-to(John, Civic, airport)` from **one** example, and also from a schema. The Story Gestalt model fails after **10⁶** training stories |
| Lassaline 1996 — strong (causal link, 3 extra shared properties) | 50 | Both inferences 35 · effect only 2 · link only 9 · neither 4 |
| — medium (`precedes`, 2 extra) | 50 | 15 · 11 · 13 · 11 |
| — weak (no link, 0 extra) | 50 | effect 14 · neither 36 |
| Spellman & Holyoak 1996, two four-way-ambiguous plots | 48 per condition | High pragmatic focus → mappings goal-consistent and independent of the irrelevant `cheats` relation; low focus → `cheats` influences them. **Every inference consistent with the run's mapping.** LISA under-produces humans' "other" responses |
| Bassok, Wu & Olseth 1995, source OP (objects assigned to people) | ≥ 20 per condition | Reproduces 89% (OP target) vs 0% (PO target) **deterministically**: the `get` schema first augments the target with `get(secretaries, computers)` whichever way the assignment was stated, then mapping to the source sends computers to `n` |
| Identity function, one example `input(one), output(one)` | — | Infers `output(two)`, and `output(Mary)`, `output(flower)` with **zero** semantic overlap with `one`. Transfer rides only on the overlap between the roles `input`/`input` |
| Incremental schema, identity function | — | Object weights: `number`, `unit` **.98** after one pair, **.44** after adding `flower`; `one`/`two` .45–.53 → .20–.24. Progressively universal `f(x) = x` |
| Fortress → radiation, good firing order | — | Correct convergence schema induced |
| Radiation → fortress, poor firing order | — | No useful schema. It infers `if–then(P16, destroyed(tumor))` with **P16 a P unit with no roles or fillers**: "there is some solution", content unknown |

The last row is a minted variable with structure and no content. It is the only place in the wiki where a placeholder for an unknown is created as a side effect of mapping (`G69`).

### Two unifications the paper states

- **Retrieval = mapping minus learning mapping connections.** During access the driver activates recipients through the semantics, but no `h`/`w` is kept: there are too many LTM candidates to hold hypotheses for. The authors report that Hummel & Holyoak 1997 (not read) reproduces, from this single difference, the human dissociation between surface-sensitive access and structure-sensitive mapping (Ross 1989). That is a candidate for the second branch of `T330`'s `Closes when`.
- **Reflexive : reflective = retrieval : mapping.** Automatic inferences (sold → owns) use existing LTM connections only. Effortful ones can use correspondences written during the trial. Hummel & Choplin 2000 implement the reflexive half by feedback from dormant LTM analogs to the semantic units, which also gives context-dependent predicate meaning (`loves` a person vs a food).

### Limitations the authors state

- **Hand-coded representations**: "the most serious limitation". That includes where one analog ends and the next begins.
- **Predicates are formal**: `cause` is a predicate like `loves`, with no link to causal-induction machinery. The one exception is the Metric Array Module (MAM; Hummel & Holyoak 2001) for transitive inference. MAM relies on LISA's ability to map an `n`-place predicate onto an `m`-place one (`n ≠ m`), which most analogy models forbid.
- **No ontological status**: a proposition cannot be marked as fact, conjecture, wish, *inference* or falsehood. Higher-order `not(·)`/`wishes(·)` "seems to miss something fundamental". Inferred units are starred only in the paper's notation, not in the model (`G71`).
- **No goals, no metacognition**: LISA cannot judge whether a mapping is good, decide when to stop, or problem-solve. The 70% gate is its only self-assessment (`G89`).
- **The user decides when to co-load propositions**, though LISA picks which ones.
- **Schema proliferation is unaddressed**: whether induced schemas are kept, merged or forgotten "lie[s] beyond the scope".
- Explanation-based learning (EBL) is argued to be structure mapping between an instance and loose background schemas, not a separate mechanism (Ahn et al. 1992: EBL from one instance needs background knowledge plus an instruction to use it, and improves with a second example).

---

## Limitations

- **Does not scale.** Reviewed as failing on large analogs; the demonstrations are laboratory-scale propositions.
- **Representations are hand-coded.** Holyoak's own verdict on the whole field: "modelers have allowed themselves an indefinite number of free parameters to facilitate data-fitting." The DORA extension (Doumas et al. 2008) learns relations from non-relational inputs — but *those* inputs are hand-coded too.
- **Synchrony is untested at the level LISA needs.** Testing gamma-band dynamic binding and rapid cortical learning of mapping connections requires simultaneous fine temporal *and* spatial resolution, which the review states is not available. The section above raises the indirect evidence considerably — item-specific gamma phase in monkey prefrontal cortex, rule-selective and re-assignable lateral prefrontal cells, an inhibitory locus for the goal-relevance filter — without touching the claim itself: no recording anywhere shows a *proposition* carried by a phase (Knowlton et al. 2012).
- **No re-representation.** LISA cannot see that `lift(John, hammer)` and `cause(John, rise(hammer))` are the same structure; the review lists flexible re-representation as an unsolved prerequisite for any analogy model.
- **No integration with problem solving.** Sequencing operators, establishing subgoals, and combining rules across non-isomorphic problems are "beyond the capabilities of current computational models of analogy," LISA included.
- **Perception is absent.** Isomorphic problems differ enormously in difficulty with perceptual encoding (Tower-of-Hanoi isomorphs); no analogy model accounts for it.

---

- **`G104` — the one gap this model closes and nothing else does.** Role-filler independence *during* binding: a role and its filler fire in phase, simultaneously and separably active, so both stay addressable while bound. The cost is the capacity ceiling below, which is why the gap stays `OPEN` despite having a worked instance.
- **`G69` — a connectionist partial.** A token is minted when an unmapped driver unit fires, persists in its analog, and caches its properties as weights to the semantic units. Localist tokens keep two same-type entities distinct. Short of `Closes when`: minting is triggered by *inference*, not by first mention. Tokens for observed entities are hand-coded, and the type of a minted unit is copied from the driver.
- **`G71` — conceded, not solved.** Inferred units are written into the target in the same format as stated ones, and the authors list "no ontological status" as an open limitation.
- **`G89` — the 70% licensing gate is the model's only self-assessment**, and the authors say LISA "cannot decide for itself whether a mapping is good or bad".

## Connections

- **[[wiki/concepts/population-geometry.md]]** — the same lateral prefrontal cells, claimed for a different construct: what that page reads as a standing high-dimensional mixed-selectivity basis is read here as a recruitable pool of proxy units written and erased within a trial by spike-timing-dependent plasticity, and the two are separated by whether selectivity turns over between problems.
- **[[wiki/concepts/tensor-product-representation.md]]** — the rival code that predicts the same behavioural curve: STAR-2 makes tensor **rank** the measure of relational complexity where this model makes it the number of bindings that fit in a phase set, so difficulty is derived from the representation in both cases and no experiment separates the two quantities.
- **[[wiki/concepts/neuromodulatory-metaparameters.md]]** — the dimension the model has none of, by its authors' own admission: monoamine modulation of prefrontal transmission is proposed as the route to individual differences in reasoning (receptor-gene polymorphisms) and to psychiatric reasoning deficits, with anterior cingulate → locus coeruleus as one concrete loop, and nothing in the phase-set architecture has a gain parameter for it to act on.
- **[[wiki/entities/hippocampal-prefrontal-channel.md]]** — the unspecified junction the authors flag: prefrontal dynamic role binding and hippocampal/medial-temporal binding are both synchrony claims in this wiki, on a wire whose theta and gamma channels are dissociable, and no account says whether a role binding is ever transferred between them or only re-derived.
- **[[wiki/concepts/analogical-mapping.md]]** — the operation this model exists to perform, and the alternative cost model: mapping by Hebbian growth of correspondence links under a phase-capacity bound, against mapping by `argmax` of a similarity between re-represented codes.
- **[[wiki/concepts/temporal-coding.md]]** — the mechanism claim in its home page's vocabulary: LISA is the wiki's only *cognitive-level* consumer of phase as a variable-binding carrier, and it converts a spike-timing scheme directly into a behavioural capacity limit.
- **[[wiki/concepts/working-memory.md]]** — where the capacity limit is derived rather than assumed: the number of simultaneously maintainable role-filler bindings is the number of resolvable phases, which makes relational complexity (how many relations must be integrated) the load variable rather than item count. The primary's implementation sets that number by a decay constant bounded by noise, which puts it closer to the noise-driven attractor account on that page than the clock-ratio arithmetic suggests.
- **[[wiki/concepts/vector-symbolic-binding.md]]** — the rival binding carrier: an algebraic operator on fixed-width vectors keeps structure comparable by dot product and loses the hard capacity bound, where synchrony keeps the bound and loses comparability.
- **[[wiki/concepts/cognitive-control.md]]** — supplies the second prefrontal function the model needs: mapping against a featurally similar distractor requires the correct proposition's units to inhibit the competitor's, so relational responding is an inhibition outcome and its failure mode is a confident perceptual answer.
- **[[wiki/concepts/inter-areal-synchrony.md]]** — the same coding assumption at the systems scale: if bindings are phases, then routing a binding between areas is a phase-alignment problem, and the wiki's synchrony-as-communication evidence is what LISA's implementation claim would have to rest on.
- **[[wiki/concepts/schema-assimilation.md]]** — the terminal step of the pipeline: intersection discovery over a completed mapping is the model's mechanism for turning two analogs into a schema, which is the abstraction operation the schema literature assumes and does not implement. Shared semantic features get twice the feedback, and divisive normalization turns that into stronger schema weights. The same machinery run *forwards*, a stored `get` schema augmenting a target before mapping, reproduces Bassok et al.'s 89% → 0% transfer collapse.
- **[[wiki/concepts/relational-reinterpretation.md]]** — the comparative argument this model is the existence proof for: it is the wiki's only architecture that holds role-filler independence *during* binding, which is the one property the whole human/nonhuman decomposition turns on, and its non-scaling is read there as the reason the exit from the PDP local minimum was paid only once.
- **[[wiki/entities/macfac.md]]** — the rival division of labour for the same pipeline: both run retrieval on a non-structural pathway and mapping on a structural one, but LISA's limit on what reaches mapping is derived from the phase code's capacity while MAC/FAC's is a fitted 10% band around the best score.
- **[[wiki/entities/resonator-network.md]]** — the same binding problem solved without expanding the representation: synchrony adds a temporal dimension to keep role and filler separately addressable and caps at 2–3 propositions, whereas a Hadamard-bound compound stays the width of an atom and moves the entire cost into a factorization step that searches all candidate fillers in superposition (`G104`, `T293`).
- **[[wiki/entities/sme.md]]** — the enumerating rival for the same operation: it constructs *every* structurally consistent interpretation and ranks them, where a synchrony code can hold only 2–3 propositions in phase and must serialise — and its cost blows up on flat descriptions exactly where LISA's phase budget does not care.
- **[[wiki/entities/esbn.md]]** — the same property — constituents preserved while bound — obtained without a phase code: two aligned memory columns give role-filler independence at one row per timestep instead of 2–3 propositions, and leave a dot-product read available on the value column, which is exactly what synchrony forfeits.
- **[[wiki/entities/lateral-frontoparietal-network.md]]** — the anatomy of the box this model fills: a frontopolar integrator selectively engaged by relations-between-relations and not by difficulty, fed by a parietal store of first-order relations. Synchrony at 2–3 propositions is what a fixed-depth second-order comparator would look like — and the anatomy is silent on depth, since nothing in that literature tests beyond second order.
- **[[wiki/entities/pam.md]]** — the same laboratory's later mapper, with the opposite trade: no capacity limit and no propositions, relation codes computed from word embeddings rather than hand-coded semantic units, and roles extracted *from* learned relations — the reverse of DORA's roles-first order. Both reproduce the goal-driven mapping shifts of Spellman & Holyoak 1996, PAM via attention weights on goal-relevant edges and LISA via pragmatic importance.
- **[[wiki/concepts/relational-bottleneck.md]]** — a switched version of the same denial: when more than one proposition is co-loaded, LISA ignores the semantics of the objects and maps on relations alone. So the bottleneck is on only under relational load, and the user, not the model, throws the switch. The graded dial that page lists as unimplemented is what the authors also say would be more realistic and did not build.
