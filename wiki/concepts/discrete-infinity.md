# Discrete Infinity

**A finite element set plus one recursive combinatory operation yields an unbounded set of discrete structured expressions — and the claim that this operation is a *separable component*, factorable out of the interfaces that consume its output, evolvable independently of them, and possibly not evolved for the domain it is famous in.**

> **Provenance.** Hauser, Chomsky & Fitch 2002, *Science* 298:1569–1579 (`raw/hauser-2002-faculty-of-language.md`). A review, not a primary report; its empirical rows are citations to others' work and its central hypothesis is stated by the authors as "tentative, testable". One primary result is the authors' own (Fitch & Hauser 2002, tamarin grammar learning). The wiki takes this source for its **factorisation** and its **comparative subtraction method**, not as evidence about language.

The wiki already had the machine-side hole (`G70`: no induced program extrapolates a count) and the bet that a symbolic slice may lie outside the navigation framing (`G11`). This page is the biological statement of the same boundary, plus an evolutionary hypothesis about where the missing operator came from — which, if right, closes `G11` in the framing's favour rather than against it.

---

## The factorisation

| Layer | Content | Comparative status (Hauser et al. 2002) | Machine slot |
|---|---|---|---|
| **FLB** (faculty of language, broad) | Sensory-motor system + conceptual-intentional system + the computational core | Almost all shared with other vertebrates, "differences of quantity rather than kind" | The encoder/decoder and the concept store — the parts the wiki has |
| **FLN** (faculty of language, narrow) | Narrow syntax alone: recursion, plus the two mappings onto the FLB interfaces | Hypothesised uniquely human; no analog found in animal communication *or, so far, elsewhere* | The missing operator (`G70`, `G69`) |
| **Outside both** | Memory, respiration, lung capacity, motor speed | Necessary for use, not part of the faculty | Resource limits — which the wiki repeatedly mistakes for priors (T161) |

**Three hypotheses the source lays out, and what each would mean for a builder:**

| Hypothesis | Claim | Builder's reading |
|---|---|---|
| **H1** — FLB is homologous to animal communication throughout | Nothing new; human system is a scaled continuation | Scale the existing stack; no new component |
| **H2** — FLB is a derived adaptation, complex like the vertebrate eye | Many co-adapted parts, each selected | Many new components, each separately engineered |
| **H3** — only FLN is uniquely human (the authors') | One small recently-evolved operator; all the apparent complexity lives in the interfaces and in socio-cultural contingency | **One operator plus rich interfaces.** The cheapest architecture of the three, and the only one that makes the missing piece nameable |

**(brainstorm) H3 is a claim about where complexity is stored, and the wiki has the same argument in a different vocabulary.** The wiki's `p = f(g, x)` puts structure in a small content-blind code and content in a large learned one. H3 says the generator is small enough that the *argument from design* — "only selection builds complexity, therefore selection built this" — no longer licenses treating it as an adaptation at all: a sufficiently small operator can arrive as a by-product of neural reorganisation. Transposed: **if the generative operator is genuinely one operation, no amount of scaling the interfaces will produce it, and no amount of pretraining pressure will select for it.** That is a falsifiable statement about scaling, and it is the sharpest form of the wiki's `G70`.

---

## The comparative subtraction, and its logic

The method is negative and cheap: **a trait present in a nonhuman animal did not evolve specifically for the human function**, however intimately it participates in it. Categorical perception is the worked cautionary case — held up as a human speech adaptation until the same perceptual discontinuities turned up in chinchillas, macaques and birds, converting it into a primitive vertebrate auditory property.

| Capability | Shared? | Evidence cited |
|---|---|---|
| Categorical perception of speech sounds | **Yes** | Chinchillas, macaques, birds |
| Formant-based discrimination; discrimination of two languages by rhythm, untrained | **Yes** | Nonhuman primates |
| Descended larynx | **Yes** | Several mammals with no speech ⇒ non-phonetic function (size exaggeration); classic preadaptation |
| Rich nonlinguistic concepts (tool, colour, geometric relation, food, number) | **Yes** | Mammals and birds |
| **Vocal imitation** | **Patchy** — songbirds, parrots, dolphins, humans; near-absent in monkeys, weak in apes | Trained chimpanzees acquire a few poorly articulated words; parrots acquire large vocal repertoires; no convincing primate vocal dialects |
| **Cross-modal imitation** | Only dolphins and humans | Only humans substitute an entire modality (sign for speech) at full competence |
| Transitional-probability segmentation of a syllable stream | **Yes** | Cotton-top tamarins, same stimuli and method as human infants; in infants also for visual sequences and tonal melodies |
| Algebraic rule learning over consonant-vowel sequences | **Yes** | Cotton-top tamarins |
| **Phrase-structure grammar (`AⁿBⁿ`)** | **No** | Fitch & Hauser 2002: human adults learn it implicitly and fast; tamarins fail in three experiments while readily mastering the finite-state `(AB)ⁿ` variant with identical stimuli |
| Approximate number: magnitude with scalar variability, Weber-limited | **Yes** | Rats, pigeons, primates, human infants and adults |
| Precise small-number tracking, limit < 4 | **Yes** | Object-tracking system, working-memory-limited |
| **Open-ended precise integer list** | **No** | Chimpanzees need thousands of trials and years per numeral up to nine, each costing the same; human children who have 1–3 acquire *all* the rest at ~3.5 years by grasping the successor function |

**Two things this table settles for the wiki.**

1. **The generative boundary is a measurement, not a philosophical position.** The finite-state / phrase-structure separation and the per-numeral / successor-function separation are the same boundary in two domains: below it, each instance costs a constant; above it, one induction covers infinitely many instances. That is precisely the productivity facet the wiki scores at **0.30–0.50** on seq2seq architectures ([[wiki/entities/pcfg-set.md]]) and at **0.000** where the episode sampler did not vary length ([[wiki/entities/mlc.md]]). **Current machine learners sit on the tamarin/chimpanzee side of a boundary that has a comparative-biology coordinate.**
2. **Mirror neurons are necessary-at-most, not sufficient.** Macaques have them and do not imitate, vocally or visually. Any architecture that assumes an action-perception matching substrate delivers imitation has assumed the conclusion — the source flags exactly this in evolutionary models that *start* from an organism already equipped with imitation and intentionality.

**(brainstorm) Two confounds the source itself concedes, and one it does not.** Conceded: (i) the chimpanzee number result may be a *curriculum* artefact — children learn the arbitrary ordered list "1,2,3,4…" first and its meanings later, apes were taught meanings one at a time and never the list, so the successor induction may need a meaningless ordered list to induce *over*; testable by training the list first (`G32` — nothing designs the experience stream). (ii) whether the tamarin limit generalises beyond tamarins, or holds for humans at earlier developmental stages, is unknown. Not conceded: `AⁿBⁿ` is discriminable by *counting* A's and comparing, so the experiment bounds the learnable dependency range and does not by itself demonstrate hierarchy — which makes it a cleaner result for the wiki than for linguistics, since a count-to-`n`-and-match capability is exactly the unbounded-iteration primitive `G70` asks for.

---

## Animal referential signals: five properties, and why none of them is a word

The vervet-alarm-call literature and its successors (macaques, Diana monkeys, meerkats, prairie dogs, chickens) yield a fixed profile:

| Property | Consequence |
|---|---|
| Acoustically distinctive calls for functionally important contexts | A lookup table with arbitrary keys |
| Signal alone suffices for appropriate listener response | Reference, if any, is **in the listener** — the receiver extracts the signaller's context from acoustics |
| Small repertoire, restricted to present objects and events | No displacement; no offline use |
| No creative production of new sounds for new situations | Closed vocabulary — the vocabulary-extension facet, failing |
| Fixed acoustic morphology, appearing early; experience only refines the *eliciting set* | The signal is not learned; only its trigger conditions are |
| No evidence calling takes account of others' beliefs or wants | No theory-of-mind term in the production policy |

**And a mismatch worth carrying:** the same monkeys have rich knowledge of kinship and dominance rank — a relational structure — while their vocalisations express it only coarsely. **The conceptual store is richer than the channel that reads it out.** That is the same asymmetry the wiki logs on the machine side whenever probing recovers structure a model's outputs do not use ([[wiki/concepts/representation-probing.md]]): a readout bottleneck is not an absence of representation, and evidence about the channel is not evidence about the store.

Human words differ in kind on the source's account: not tied to specific functions, linkable to virtually any entertainable concept, detached from the here and now, and with no straightforward word–thing relation in mind-independent terms.

---

## The learnability argument, and where it now bites

The classical argument, attributed via Gold and Nowak et al.: a finite data sample is consistent with infinitely many mutually inconsistent target systems, so **unless the search space is constrained, selection among them is impossible**; "no known general learning mechanism can acquire a natural language solely on the basis of positive or negative evidence".

This is the wiki's `G16` (the intended graph is not identifiable from data alone) stated 20 years earlier and in a different field, with the same conclusion: **identifiability must be bought with bias, and the only question is where the bias is installed** ([[wiki/concepts/shortcut-learning.md]]). What the source adds is a *second* direction to the argument, which the wiki has not carried: constraints on animals must have been **removed** at some point in hominin evolution to permit acquisition of the unlimited class of generative systems. A prior narrow enough to make one language learnable is also narrow enough to make most languages unlearnable — so evolution is described here as *widening* a constraint, not tightening one. For a builder that is an unwelcome result: the bias that buys identifiability and the flexibility that buys coverage are traded against each other, and no principle in the wiki sets the exchange rate (`G40`, `G26`).

**The tension the 2002 claim now faces** is logged at [[wiki/empirical-tensions.md]] T288: large language models trained on positive evidence alone acquire competence on exactly the phrase-structure phenomena the argument said no domain-general learner could reach — with the escape routes being (a) the corpus is orders of magnitude larger than a child's, (b) the transformer's architecture *is* the constraint, so the model is not domain-general in the relevant sense, and (c) competence on the phenomena is not acquisition of the I-language.

---

## The exaptation hypothesis — the part that matters most here

The source's closing proposal, and the reason this page exists rather than a paragraph on [[wiki/concepts/compositionality.md]]:

> Recursion may have evolved **for reasons other than communication** — navigation, number quantification, or social relations — as a **modular, domain-specific and impenetrable** system, and then become **penetrable and domain-general**, at which point it could be applied to other problems. Comparative work looking for recursion only in animal communication has been searching the wrong space.

| Consequence | For the wiki |
|---|---|
| The generative operator's native domain may be **navigation** | The strongest external warrant the wiki has for the navigation framing. [[wiki/concepts/latent-graph-discovery.md]] carries the non-embeddable symbolic slice as an admitted *bet* (`G11`); this hypothesis says the symbolic slice is the navigational operator running on non-navigational arguments — i.e. the bet is not merely a modelling convenience but a phylogenetic claim with a research programme attached |
| [[wiki/concepts/path-integration.md]] already iterates an unbounded number of times | The biological substrate for `G70`'s missing loop is in the navigation system, not the language system. **Machine path integrators inherit the iteration and lose it at the interface**: nothing exposes the update operator to a non-spatial argument |
| The transition is **impenetrable → penetrable**, not absent → present | The architectural event is not the invention of an operator but a **change in who may call it**. Nothing in the wiki models that event (new gap `G99` below) |
| The hexadirectional and grid-like codes found across fourteen non-spatial domains ([[wiki/concepts/nonspatial-maps.md]]) | Would be the *aftermath* of exactly this transition, observed in the one species where it happened. The prediction: in nonhuman animals, map-like codes should be far more domain-restricted than in humans — which is testable and, as far as this page's sources go, untested |
| The number system is the intermediate case | Approximate magnitude and small-`N` tracking are shared; only the open-ended, successor-generated integer list is not. **Number is where the same operator is visible with and without the domain-general call, in one representational family** ([[wiki/concepts/core-knowledge.md]]) |

**(brainstorm) The transition, stated as an implementable change.** A module is impenetrable when its operator is reachable only by inputs typed for its native domain — the entry condition of a core system (`G23`) is exactly such a type test. Penetrability is that test being *relaxed on the operator while retained on the representation*: the recursive combinator accepts arguments of any type, while the geometry prior still refuses to fire on movable objects. That is a strictly weaker change than "make the module general", and it is buildable: expose the update/compose operator of a structural module through an interface that does not check the argument's domain tag, and leave the module's own priors domain-gated. Whether the resulting compositions are *meaningful* is then a downstream problem (`G22`), not a routing one.

---

## Optimality as a design condition on the generator

The source's other transferable proposal: FLN may approximate an **optimal solution** to the problem of linking two given interfaces, satisfying conditions of efficient computation — explicitly **minimal search** and **no backtracking**. If so, many of the phenomena linguistics studies (island constraints, movement, garden-path sentences) are **by-products** generated automatically by the interface structure and by biophysical/developmental constraints, not adaptations.

| Element | Statement | Where it lands |
|---|---|---|
| **The problem** | Construct an infinite array of internal expressions from finite conceptual-intentional resources, and provide the means to externalise and interpret them | The generator's specification, interfaces given |
| **The criteria** | Minimal search; no backtracking | Two *architectural* conditions on a search procedure, stated without a loss function |
| **The payoff** | Explains why languages of a certain class are attainable and others are not learnable or sustainable | A ceiling argument, not a performance argument |
| **The analogy offered** | Optimal foraging — minimal distance, recall of locations searched, kinds of objects retrieved | The same navigation domain the exaptation hypothesis nominates, reached independently |

**(brainstorm) "No backtracking" is the sharpest constraint here and the wiki has nothing like it.** Every search mechanism the wiki holds — beam search, rejection sampling in [[wiki/concepts/language-of-thought.md]], program enumeration in [[wiki/concepts/program-induction.md]], refinement loops ([[wiki/concepts/refinement-loop.md]]) — is a backtracking search whose cost is dominated by rejected attempts, and `G74` records that every one of them assumes a wrong attempt is free. A generator that never backtracks pays for it in expressiveness: it can only build structures whose every local step is committable. **That is a design axis, not a defect** — it says: pick the representation such that greedy composition is correct, and the search cost disappears. The wiki has no page-level account of which representations have that property.

---

## Open problems

- **Nothing distinguishes "the operator is absent" from "the operator exists and is not callable".** The tamarin and chimpanzee results are consistent with both, and the two have opposite implications for what to build. The chimpanzee-number confound (list-before-meaning) is a concrete instance where the curriculum, not the capacity, may be the binding constraint.
- **The optimality claim has no measurement.** "Minimal search, no backtracking" is asserted for narrow syntax, not measured, and no cost model is given for either criterion.
- **The exaptation hypothesis names three candidate native domains** — navigation, number, social relations — and no evidence discriminating them. The source's own prescription (look for recursion in noncommunicative domains in animals) had not been carried out at the time of writing.
- **The widening argument is unaccounted for.** If evolution *removed* constraints to reach the unlimited generative class, then the wiki's standing "buy identifiability with bias" prescription (`G16`) has a countervailing term with no stated magnitude.
- **The FLB/FLN split is stipulated at the boundary that matters.** Whether the sensory-motor and conceptual-intentional systems are inside or outside the narrow faculty is explicitly left open by the authors; competing delineations (Liberman: sensory-motor is inside) are noted and not adjudicated. A builder taking H3 as an architecture is adopting an admittedly under-determined module boundary.

---

## Connections

- **[[wiki/concepts/compositionality.md]]** — the same capacity measured instead of argued: discrete infinity *is* the productivity facet, and the seq2seq scores (0.30–0.50, and 0.000 where the episode sampler did not vary length) place current architectures on the tamarin side of the comparative boundary this page draws.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the exaptation hypothesis is a phylogenetic argument *for* the framing's most contested bet: if the recursive operator's native domain was navigation, the non-embeddable symbolic slice (`G11`) is the navigational operator running on foreign arguments rather than a second mechanism.
- **[[wiki/concepts/path-integration.md]]** — the biological iteration primitive the exaptation hypothesis nominates as recursion's origin: an update rule applied an unbounded number of times, which is exactly the `Do Until` that no induced program in the wiki has (`G70`).
- **[[wiki/concepts/nonspatial-maps.md]]** — the fourteen non-spatial domains showing map-like codes are what "the module became penetrable" predicts as an outcome, and the hypothesis converts them into a comparative prediction: nonhuman map codes should be domain-restricted where human ones are not.
- **[[wiki/concepts/core-knowledge.md]]** — the shared/unique subtraction run on the same primitives: approximate magnitude with scalar variability and small-`N` tracking are shared with animals, the open-ended integer list is not, so number is the one system where the same code is observable with and without the generative operator attached.
- **[[wiki/concepts/program-induction.md]]** — recursion and binding are named there as the slice the navigation framing does not reach; this page supplies the comparative evidence that the slice is real and the hypothesis that it nonetheless came from navigation.
- **[[wiki/concepts/language-of-thought.md]]** — H3 is a third position in T8's innate/acquired dispute: the composer is innate but is *one* operator, domain-general and plausibly not selected for language, which neither of T8's existing positions allows.
- **[[wiki/concepts/shortcut-learning.md]]** — the learnability argument is `G16` reached from linguistics: finite data underdetermines the target, so bias must be paid for; the new term is that evolution is described as *widening* the bias, which the architecture lever has no account of.
- **[[wiki/concepts/representation-probing.md]]** — the primate conceptual/communicative mismatch (rich kinship and rank knowledge, coarse vocal expression) is the biological instance of probe-recoverable structure that behaviour does not use: channel evidence is not store evidence.
- **[[wiki/concepts/refinement-loop.md]]** — the "no backtracking" optimality criterion is the direct negation of every search procedure the wiki holds, and turns `G74`'s cost problem into a representation-design question.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — the per-numeral vs successor-function contrast is a priors-and-experience-to-skill conversion rate measured across species: thousands of trials per integer against one induction covering all of them.
- **[[wiki/concepts/emergent-modularity.md]]** — the direct opponent to H3, and the reason T289 exists: Sherwood et al. 2008 find no new cortical areas, no disproportionate frontal cortex and a volume increase that is neuropil rather than neurons, and derive the same human-unique capacities from afferent diversity into an *old* operator plus a shifted growth schedule — one operator added versus zero operators added, from the same comparative evidence base.
- **[[wiki/concepts/shared-intentionality.md]]** — the third position on the same explanandum, and the one that inverts this page's dependency: Tomasello & Rakoczy 2007 make syntax a historically accumulated *cultural product* whose acquisition presupposes a social-cognitive operation dated to ~1 year, and then give one syntactic construction (sentential complements, `X thinks that p`) a measured causal role in building belief understanding — recursion as a training signal for non-linguistic cognition rather than as the installed uniquely human component.
