# Motivation–Representation Synergy

**A capability can be absent for two independent reasons — the machinery is missing, or the machinery is present and nothing deploys it — and the comparative record says the human-specific case is the *product*, not either factor: `expressed competence ≈ representation × motivation`, with the two terms dissociable across taxa, under separate selective drivers, and jointly necessary.**

> **Provenance.** MacLean 2016, *PNAS* 113(23):6348–6354, "Unraveling the evolution of uniquely human cognition" (`raw/maclean-2016-evolution-human-cognition.md`). A review with a thesis; every number below is a citation to a primary study, not new data. Two of the three comparative regressions it leans on are the author's own (MacLean et al. 2014, 2013). The systemizing–empathizing section is explicitly speculative and is marked as such below.

The page exists because the wiki's agents have only the first factor. Every architecture here is scored on whether it *can* solve a task; none has a state in which it can and does not. The comparative record says that state is the modal one — chimpanzees hold most of the representational apparatus and do not use it cooperatively — and that the human change may be located in the second factor rather than the first.

---

## The dissociation, run across taxa

Two components, each independently present or absent, four cells occupied by real clades:

| | **Prosocial / cooperative motivation weak** | **Prosocial / cooperative motivation strong** |
|---|---|---|
| **Perspective-taking representation weak** | Most vertebrates | **Callitrichids** (marmosets, tamarins) — cooperative breeders, top scorers on proactive-prosociality tasks, no human-like shared intentions |
| **Perspective-taking representation present** | **Great apes** — exploit others' perspectives *for their own purposes*; can point imperatively, do not point to inform; fail when a human points cooperatively to hidden food | **Humans** — the only occupied cell, from ~12 months |

**Neither factor alone yields the phenotype.** Callitrichids have the motivational foundation without the representational one; great apes the reverse. The cell that produces cumulative culture is the conjunction, which is why MacLean's central claim is that no single-system change accounts for human cognition and why single-mechanism proposals (a recursion operator, a working-memory increment) are underdetermined by this evidence.

**The strongest supporting datum is subtractive and belongs to Tomasello & Rakoczy:** a human child raised alone to adulthood would have cognitive skills "perhaps a little, but not very much" beyond a great ape's. The uniquely human capability is not in the individual learner at all; it is in the transmission system the two factors jointly enable. Compare [[wiki/concepts/skill-acquisition-efficiency.md]] — priors and experience are separable terms there, and this is the case where nearly all of the measured skill sits in the experience term.

---

## Each factor has a *different* comparative driver

The three phylogenetic regressions in the source are the page's hardest content, because each one dissociates a driver that the standard "social brain" story bundles:

| Study | `n` | Predictor tested | Result |
|---|---|---|---|
| MacLean et al. 2014 (self-control: A-not-B, cylinder task) | **36 vertebrate species** | Absolute brain size, relative brain size, species-typical group size | **Absolute brain size predicts self-control. Relative brain size does not. Group size does not at all** |
| MacLean et al. 2013 (visual perspective taking) | lemurs | Species-typical group size | **Group size predicts perspective taking** |
| Burkart et al. 2014 (proactive prosociality) | **15 primate species** | Range of socioecological predictors | **Allomaternal care is the best predictor** — not group size, not brain size |

Read as three separate scaling laws over one design space:

- **Inhibition scales with absolute size.** Not with size corrected for body mass. If this transfers, the machine analogue is parameter/compute count, not a ratio — and self-control is the one capacity the wiki would get *free* from scale ([[wiki/concepts/cognitive-control.md]], [[wiki/concepts/inhibitory-control-of-coding.md]]).
- **Representation scales with the number of agents to model.** Group size buys perspective taking and buys nothing else measured.
- **Motivation scales with a *care structure*, not with a social statistic.** Allomaternal care — the fact that non-mothers invest in young — is a property of the reward structure of the population, not of its size.

**(brainstorm) Three drivers, three different manipulables, and the wiki has swept only the first.** Scale is the axis every architecture here already varies. "How many other agents must be modelled" is the multi-agent-population axis, unswept. "What does the population's payoff structure reward" is the objective axis, and it is the one [[wiki/concepts/objective-identifiability.md]] says nothing currently selects for. The prediction that falls out is testable in simulation without new mechanism: a population of identical learners under a cooperative-breeding payoff should develop other-modelling that the same learners under a scramble-competition payoff do not, at identical capacity.

---

## Motivation as constraint release, not as capability

The domestication literature is the source's cleanest evidence that changing a temperament parameter *reveals* cognition rather than building it:

| Contrast | Change | Cognitive consequence |
|---|---|---|
| Dogs vs. wolves; experimentally domesticated silver foxes vs. control lineage; domestic vs. wild ferrets | Selection against aggression only | **Increased sensitivity to cooperative communication**, willingness to sustain eye contact — arriving as a *byproduct* of temperament, not selected for |
| Bonobo vs. chimpanzee | Hypothesised self-domestication under lower scramble competition south of the Congo | Tolerant cofeeding, voluntary food sharing including with strangers, ~2× serotonergic innervation of the amygdala, more grey matter in empathy-related regions |
| Chimpanzee cooperation task: reward **dispersed** vs. **clumped/monopolisable** | Nothing cognitive changes between conditions | Success rate changes. Intolerance is a sufficient cause of cooperation failure with the cognition held fixed |
| Chimpanzee model–observer social learning under dyadic intolerance | Nothing cognitive changes | **Social learning is precluded outright** |

**The last two rows are the load-bearing ones for a builder.** They are within-species, within-individual manipulations in which the representational capacity is constant by construction and the measured competence moves anyway. This is a *gate*, and the wiki has no component that implements one: no architecture here can hold a policy it declines to execute because of a scalar state that is not the task reward (`G102`).

Human-side morphological correlates the source offers for the same process, with honest status:
- Reduced sexual dimorphism in body mass and canine size, from ~3 Ma — inferred shift from polygyny with male–male violence toward monogamy/cooperative breeding.
- Craniofacial feminisation (reduced brow-ridge projection, shortened upper face) from the Middle Pleistocene, hypothesised to reflect reduced androgen activity, coinciding with the 20–70 kya proliferation of cultural artefacts (Cieri et al. 2014).
- Both are correlational, inferred from morphology to hormone to temperament to cognition across three unvalidated links.

---

## The measurement lesson: competence is context-gated

The revision of the "no nonhuman theory of mind" consensus in the 2000s came **not from better subjects but from a different paradigm**. Chimpanzees show perspective taking when tested in *competition with conspecifics*, and failed the same underlying question for two decades when tested in *cooperation with humans* (Hare et al. 2000, 2001); several non-ape species have since shown the same profile.

| The failure mode | Statement |
|---|---|
| What the cooperative-paradigm null measured | Absence of a motivation to use the representation in that frame — **not** absence of the representation |
| Why it persisted | The paradigm was the ecologically wrong one for the species, and the null was read as a capability claim |
| Machine analogue | Every benchmark null in the wiki is the same shape. A model that fails a task under one prompt frame and passes under another has had its *deployment* measured, not its competence ([[wiki/concepts/human-baseline.md]], [[wiki/concepts/certification-instruments.md]]) |

**(brainstorm) This licenses a concrete protocol the wiki does not run: the paired-frame null.** Any claimed capability absence should be re-run under at least one frame in which the model's training objective makes deploying the capability *advantageous*, before the absence is recorded. The comparative case says the expected effect size is large enough to invert a twenty-year consensus. It also predicts that the wiki's theory-of-mind entities ([[wiki/entities/autotom.md]], [[wiki/entities/hbtom.md]], [[wiki/entities/agent-benchmark.md]]) are measuring a strictly easier problem than the biological one: they infer over agents whose goals are given as latents to be recovered, with no term for whether the observer is motivated to recover them.

---

## The single-scalar trade-off hypothesis *(tentative — contested theory, offered speculatively in the source)*

Baron-Cohen's systemizing–empathizing account, extended by MacLean from within-species variation to the *Pan* comparison. One parameter — prenatal androgen exposure — proposed to trade off two cognitive axes:

| | Bonobo (lower prenatal androgen signature) | Chimpanzee (higher) |
|---|---|---|
| Theory of mind, cooperation | **Better** | Worse |
| Attention to face and eyes in social images | **Higher** | Lower |
| Adult food sharing, social play | **More** | Less |
| Tool use, **causal reasoning**, **spatial memory** | Worse | **Better** |
| Severe aggression | Less | More |

The wiki should record this as a *shape*, not as a finding: **one scalar hyperparameter anticorrelating a relational/agent-modelling capacity against a physical/spatial/systematising capacity in the same architecture.** If real, it says the two are competing for a shared resource rather than occupying separate modules — which is [[wiki/concepts/emergent-modularity.md]]'s claim (modules as products of a biased exploration policy) with a named biasing variable and a sign. Status: the underlying theory is contested within human psychology, the *Pan* extension is offered as an untested prediction, and the source itself asks whether the effect appears in taxa outside the great apes as the discriminating test.

---

## The outlier test — a reusable method

The source's methodological closing move, and the most portable thing in it. Before treating a human value as *sui generis*, fit the scaling law across the clade and ask whether the human point is off it:

- **Worked case:** the human brain has more neurons than any other primate brain. Fitted against primate cellular scaling rules and brain volume, the human neuron count is **exactly what the regression predicts** (Herculano-Houzel). Extreme but not exceptional — the outlier is the volume, and the volume has its own explanation.
- **Generalisation:** run the same test on cognitive traits, with phylogeny and covarying predictors in the model. A trait that lands on the line has its "how and why" answerable by the comparative method; a trait genuinely off the line means the reconstruction has no leverage and demands caution.
- **Machine use.** Identical in form to the wiki's scaling-law arguments. A model whose capability is "surprising" should first be plotted against the compute/parameter/data regression for its family; if it lands on the line, the interesting question is what moved its *inputs*, not what changed inside it ([[wiki/concepts/skill-acquisition-efficiency.md]], [[wiki/concepts/intelligence-density.md]]).

---

## Reading in the core framing

| This page | Latent-graph reading |
|---|---|
| Representation factor | The capacity to infer another agent's node in the graph — its position, its accessible edges, its target |
| Motivation factor | The **query distribution**, not the map: which inferences get requested at all, and whether the answer is used cooperatively or for private gain |
| Cooperative breeding as prosociality's driver | The payoff structure of the population determines the query distribution, which then determines what map is worth learning — the reverse of the wiki's usual direction |
| Tolerance gate | An edge that exists in the map and is not traversable in the current affective state — traversal cost that is not a property of the edge |
| Cumulative culture | The map is not in any individual; the graph is discovered across generations and transmitted, so the per-lifetime learner solves a much smaller problem than the species does |

---

## Open problems

- **The synergy is asserted and never formalised.** "More than the sum of its parts" appears in the conclusion with no functional form. Is the composition multiplicative, thresholded, or a genuine interaction term? Nothing in the source distinguishes them, and the three admit different builds.
- **No measurement separates the two factors within one individual.** Every dissociation in the table is *between* species. A within-subject manipulation of motivation with representation held fixed exists only in the two chimpanzee tolerance experiments, and there the manipulated variable is the environment, not the animal.
- **The causal chain from androgen to cognition has four unvalidated links** (morphology → hormone level → temperament → cognitive profile), is reconstructed from fossil craniofacial shape at two of them, and is offered for a trait — behavioural modernity — dated archaeologically rather than behaviourally.
- **The bonobo may not be the right living model of the last common ancestor** in either direction: cranial development suggests bonobos are the *derived* lineage (neotenic) relative to a conserved gorilla/chimpanzee pattern, which makes every chimpanzee-vs-bonobo contrast on this page a comparison to a moving reference.
- **Nothing states what motivation *is* mechanistically.** The wiki's candidate homes — [[wiki/concepts/subjective-value.md]], [[wiki/concepts/reward-prediction-error.md]], [[wiki/concepts/neuromodulatory-metaparameters.md]] — all model the *magnitude* of a valuation, none models a standing disposition that gates whether a capability is deployed across a whole class of situations.
- **The direction of the coupling is unresolved and matters for the build order.** MacLean's own summary allows that motivational and representational change were *co-caused* by one biological mechanism (androgen reduction), which would mean they cannot be built independently — a strictly harder engineering claim than the dissociation table suggests.

---

## Connections

- **[[wiki/concepts/emergent-modularity.md]]** — the same comparative subtraction from the opposite side: that page locates the human change in a growth schedule acting on domain-general parameters, this one in a motivational parameter acting on already-present representations, and both are re-weighting accounts that reject a new module — together they form the third position on [[wiki/empirical-tensions.md]] `T289`.
- **[[wiki/concepts/objective-identifiability.md]]** — supplies this page's missing factor as a formal problem: the motivational term *is* an objective, the comparative record says it was selected by a population payoff structure (allomaternal care) rather than by task performance, and that is precisely the class of objective no machine training signal currently instantiates.
- **[[wiki/concepts/cognitive-control.md]]** — receives the page's one clean quantitative result: self-control across 36 vertebrate species tracks **absolute** brain size and not relative brain size or group size, making inhibition the one capacity predicted to arrive with scale alone, and the proposed enabler of the tolerance that cooperation requires.
- **[[wiki/concepts/core-knowledge.md]]** — the social-agent core system with its motivational half attached: that page's agent primitive supplies the representation, this page argues the primitive is inert without a disposition to deploy it cooperatively, and the human developmental timeline (gaze following → pointing to inform at ~12 months → belief–desire psychology at ~4 years, same ages cross-culturally) is the joint maturation schedule of the two.
- **[[wiki/entities/autotom.md]]** — the machine theory-of-mind model this page bounds: its Bayes net over state, belief, goal and action recovers *what* another agent wants and has no term for whether the observer is disposed to ask, which is the factor the comparative record says separates great apes from humans.
- **[[wiki/entities/hbtom.md]]** — the same bound on the inverse-planning formulation: a Dirichlet prior over per-agent goal preferences models variation in what agents want, never variation in the observer's own motivation to model them, so the framework can express only the representational column of this page's 2×2.
- **[[wiki/entities/agent-benchmark.md]]** — the evaluation-side consequence of the competitive/cooperative paradigm result: a violation-of-expectation battery presents the agent-modelling problem in exactly one frame, so a null on it measures deployment under that frame rather than capability, and the twenty-year chimpanzee false negative is the precedent for how large that error can be.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — the desert-island argument is that page's decomposition taken to its limit: with priors and architecture held at the great-ape value, nearly all measured human skill sits in the experience term, and the two factors here are what make the experience stream cumulative in the first place.
- **[[wiki/concepts/learned-world-models.md]]** — the complementary comparative boundary: the ghost-condition result says human social learning has the agent token factored out of the transition sequence, and this page says the same species is the one motivated to share the resulting model — the representational and motivational halves of one transmission system.
- **[[wiki/concepts/human-baseline.md]]** — the protocol lesson generalised: a species-level capability null was inverted by changing the paradigm's motivational frame rather than its content, which is the same class of unstated protocol parameter that makes a human baseline unreproducible.
- **[[wiki/concepts/subjective-value.md]]** — the nearest existing machinery and the reason it does not suffice: valuation there is a scalar attached to an option, while the term this page needs is a standing disposition that gates a whole class of inferences before any option is valued.
