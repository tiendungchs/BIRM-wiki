# Amygdala — Two Nuclei Split by Representational Format, Not by Valence

**The basolateral amygdala (BLA) and the central nucleus (CeA) are doubly dissociable, and the axis that separates them is *what kind of representation is stored*, not *whether the outcome is good or bad*. The BLA lets a cue retrieve the current motivational value of the **specific** outcome it predicts — which is what second-order conditioning, conditioned reinforcement, devaluation sensitivity and outcome-specific choice modulation all require. The CeA holds outcome-blind cue→response links and is the controller of the brainstem and of every diffuse ascending modulatory nucleus — which is what freezing, conditioned orienting, Pavlovian–instrumental transfer and up-regulated associability all require. Both nuclei carry appetitive **and** aversive conditioning. One nucleus down, that stops being true: inside the basolateral amygdala, the neurons projecting to the nucleus accumbens and those projecting to the medial central nucleus undergo **opposite-signed** plasticity after the same conditioning episode and drive opposite reinforcement — a valence axis addressed by projection target, intermingled in the tissue and invisible to any method without projection identity (`T368`).**

> **Provenance.** Cardinal, Parkinson, Hall & Everitt 2002, *Emotion and motivation: the role of the amygdala, ventral striatum, and prefrontal cortex*, Neuroscience & Biobehavioral Reviews 26(3):321–352 (`raw/cardinal-2002-emotion-motivation-amygdala-ventral-striatum-pfc.md`). Review; rat, with monkey and human lesion data where cited. Primary dissociations credited to Killcross, Robbins & Everitt (conditioned suppression versus instrumental avoidance), Hatfield et al. and Gallagher et al. (second-order conditioning versus conditioned orienting), Hitchcott & Phillips (intra-nucleus dopamine agonist), Setlow et al. (BLA–accumbens disconnection).

Why this earns a page. The wiki names the amygdala on rows about aversive channels, memory gating and valence ([[wiki/entities/hippocampal-prefrontal-channel.md]], `G52`, `G93`, `T355`) with no page stating what it computes. The result that matters for those rows is negative: **the amygdala's internal split is not a valence split**, so an architecture that puts "the aversive channel" in the amygdala has mislocated the axis.

---

## Anatomy and connectivity

| | **Basolateral amygdala (BLA)** | **Central nucleus (CeA)** |
|---|---|---|
| Composition | lateral, basal, accessory basal nuclei | — |
| Cytoarchitecture | peri-isocortical (cortex-like) | striatal |
| Phylogeny | old, but recently expanded | old, phylogenetically simpler function |
| Afferents | polysensory neocortex and frontal lobes (reciprocal); sensory thalamus; hippocampus | direct sensory input from thalamus and cortex — **parallel**, not only via BLA |
| Efferents | ventral striatum, prefrontal cortex, CeA | periaqueductal grey (freezing), lateral hypothalamus (sympathetic), caudal pontine reticular nucleus (startle potentiation); ventral tegmental area and substantia nigra pars compacta (dopamine), locus coeruleus (noradrenaline), raphé (serotonin), nucleus basalis magnocellularis (acetylcholine) |
| To accumbens | strong, core **and** shell | **none direct** — influence is via the ventral tegmental area |

The CeA is therefore both a motor-output port and the amygdala's write-access to **every diffuse neuromodulatory system in the forebrain** ([[wiki/concepts/neuromodulatory-metaparameters.md]]): one nucleus sets the arousal, the learning-rate and the attentional gain of the rest of the brain.

---

## The double dissociations

| Task | BLA lesion | CeA lesion | What the pair shows |
|---|---|---|---|
| Conditioned suppression (mild 0.2 mA shock, no freezing) | **spared** | **impaired** | aversive PIT is an outcome-blind response |
| Instrumental avoidance in the same task | **impaired** | spared | choosing away from a punished lever needs the specific-outcome value |
| Second-order conditioning | **impaired** | spared | a CS can only train a second CS if it retrieves a value |
| Conditioned orienting | spared | **impaired** | CeA → substantia nigra → dorsolateral striatum |
| Autoshaping (conditioned locomotor approach) | spared | **impaired** | approach is driven by the CeA→VTA→accumbens-core gain, not by outcome value |
| Conditioned reinforcement | **impaired** | spared | |
| Amphetamine potentiation of conditioned reinforcement | specificity lost | **abolished** | content from BLA, gain via CeA |
| Pavlovian–instrumental transfer | general form spared, **specificity lost** | **abolished** | |
| Reinforcer devaluation after first-order conditioning | **impaired** (CR unchanged) | spared, and the CRs it does acquire remain devaluation-sensitive | the defining BLA assay |
| Intra-nucleus D2/D3 agonist (Hitchcott & Phillips) | affects instrumental responding for a conditioned reinforcer | affects Pavlovian conditioned approach | the dissociation holds pharmacologically, not just by lesion |
| Conditioned freezing, fear-potentiated startle, conditioned bradycardia | impaired | impaired | **serial** — BLA reaches the motor nuclei only through the CeA |
| Sensory preconditioning | **spared** | — | the BLA's US representation is *affective*, not sensory |

So the circuit is **serial and parallel at once**: serial where the BLA needs the CeA's brainstem targets, parallel where the CeA learns or expresses on its own sensory input. Note the diagnostic asymmetry — a CeA-lesioned rat still acquires first-order appetitive CRs, and those CRs are devaluation-sensitive, so the value representation is demonstrably intact without the output nucleus.

---

## What each nucleus computes

**BLA** — `CS → value(current, specific US)`. Its lesion leaves conditioned responding intact but makes it a **Pavlovian S–R reflex**: acquired normally, insensitive to what the outcome is now worth, unable to support second-order conditioning or conditioned reinforcement, and unable to modulate instrumental choice selectively. Holland's *mediated performance* — responding on the basis of a cue-activated representation of the outcome — is the capacity that is lost. What survives shows what the representation is **not**: BLA-lesioned animals still perceive tastes, still learn stimulus discriminations, and still show sensory preconditioning, so the missing representation is the affective one, and the sensory one it can still activate is valence-free.

**CeA** — `CS → UR`, plus two global control functions:

| Function | Evidence | Read as |
|---|---|---|
| Brainstem response selection | lesion abolishes freezing, startle potentiation, bradycardia; targets are PAG, lateral hypothalamus, PnC | an outcome-blind sensorimotor policy over innate response programs |
| Motivational gain on the striatum | autoshaping, PIT and amphetamine potentiation of CRf all require CeA; CeA → VTA → accumbens | it sets the gain on a channel whose content is supplied by others |
| **Associability up-regulation** | CeA lesion (and its nucleus basalis cholinergic projection) removes the Pearce–Hall increase in a cue's associability after a surprising omission; candidate cellular form is muscarinic-dependent expansion of the cue's auditory-cortical receptive field | a learning-rate controller, written by surprise, addressed **per stimulus** |

The associability function is the one with no machine counterpart. Pearce–Hall says a reliably-predicted cue is *worth responding to but not worth learning about*; the up-regulation direction — raise the rate on a cue whose consequences just became uncertain — is a per-item learning rate driven by unsigned surprise, and it is lesionable independently of every value representation above.

---

## Mapping to model components

| Biological element | Model component | Where the mapping breaks |
|---|---|---|
| BLA store | a `cue → outcome-identity` table whose entries are re-scored at retrieval by the current motivational state | no wiki model re-scores at retrieval; values are stored already-scored |
| CeA store | a small policy over fixed response primitives, keyed by cue, no outcome term | the response primitives are innate and unlearned — nothing in the wiki has an innate action library |
| CeA → neuromodulators | one module writing the global learning rate, arousal and attentional gain | [[wiki/concepts/neuromodulatory-metaparameters.md]] has the metaparameters, no source writes them |
| CeA associability | per-stimulus learning rate `α(cue)` raised by unsigned surprise | standard `α` is global and hand-set |
| BLA → accumbens / BLA → orbitofrontal | content lines into a gated interface ([[wiki/concepts/valuation-system-decomposition.md]]) | |

**(brainstorm) The split is a claim about what is worth separating, and it is not the split a designer would pick.** The engineering instinct is to divide by valence (a reward head and a punishment head) or by modality. Biology divides by **whether the representation carries outcome identity**: one nucleus holds identity-bearing, state-re-scorable values usable for chaining and for choice, the other holds identity-free reflex links and the global gains. That partition predicts which capabilities co-fail — chaining, devaluation sensitivity and selective choice go together and are separable as a block from arousal, orienting and non-selective invigoration — and it is directly testable in an artificial agent by ablating an outcome-identity slot rather than a valence head. Nothing in the wiki does it either way.

---

## Stimulating the basolateral nucleus manufactures 'wanting', and the target is set by pairing

> **Second source.** Warlow et al. 2020 as reported in Robinson & Berridge 2025 (`raw/robinson-2025-incentive-sensitization-30-years-on.md`); see [[wiki/concepts/incentive-salience.md]].

Optogenetic basolateral-amygdala stimulation, described there as *recruiting mesolimbic incentive-salience circuitry*, paired with a target:

| Paired target | Result |
|---|---|
| Electrified shock rod | the rat returns to it, hovers, touches it repeatedly, climbs a barrier to reach it, seeks out shock-associated cues — while the shocks remain unpleasant and 'liking' is not enhanced |
| Sugar | a sugar-addicted rat that ignores cocaine |
| Cocaine | a cocaine-addicted rat that ignores sugar |

Two additions to this page's account. First, the nucleus that holds `CS → value(specific US)` can, when driven, **write pursuit onto whatever co-occurs with the drive**, including a stimulus whose specific outcome is pain — so the specificity this page attributes to the basolateral nucleus is specificity of *address*, and the address is assigned by coincidence rather than by outcome identity. Second, it is another datum against reading either nucleus as a valence channel: the manipulation is appetitive in its effect and its object here is a punisher (`G116`, `G118`).

Alongside it, a transmitter-level version of the same warning. Corticotropin-releasing factor is released in the central nucleus by **pleasant** food with no distress present (Merali et al. 1998), and stimulating corticotropin-releasing-factor signalling in the amygdala or accumbens raises incentive motivation for food and drug rewards — with animals **seeking out** the stimulation rather than avoiding it (Peciña et al. 2006; Lemos et al. 2012; Baumgartner et al. 2022). A stress transmitter in this structure amplifies pursuit; the sign is not in the chemistry.

---

## Inside the basolateral nucleus, valence is addressed by projection target

> **Second source.** Namburi et al. 2015, *A circuit mechanism for differentiating positive and negative associations*, Nature 520(7549):675–678 (`raw/namburi-2015-amygdala-projection-specific-valence-plasticity.md`). Mouse. Retrobead projection labelling + whole-cell recording after Pavlovian conditioning; retrograde rabies `RV-ChR2–Venus` for sufficiency; retrograde `CAV2-Cre` + `AAV₅-DIO-eNpHR3.0` for necessity; morphological reconstruction; RNA-seq of retrobead-sorted cells.

Two populations of basolateral neurons, defined **only** by where their axons land — nucleus accumbens (`NAc` projectors) or medial central nucleus (`CeM` projectors) — with all afferents stimulated in common at the internal capsule.

| Measure | `NAc` projectors | `CeM` projectors |
|---|---|---|
| `AMPAR/NMDAR` ratio after **fear** conditioning (vs unpaired, tone/shock count matched) | **decrease** | **increase** |
| `AMPAR/NMDAR` ratio after **reward** conditioning (vs unpaired, tone/sucrose volume matched, both food-restricted) | **increase** | **decrease** |
| Paired-pulse ratio | unchanged | unchanged → the locus is **postsynaptic** |
| Photostimulation of cell bodies in the basolateral nucleus | supports intracranial self-stimulation — **positive** reinforcement | robust real-time place **avoidance**; nose-poke responding could not be elicited |
| Photoinhibition during the unconditioned stimulus only | not reported | conditioned freezing **impaired** *and* conditioned reward seeking **enhanced** |

One conditioning episode, one afferent bundle, two signs. The paper's own framing is the paradox this resolves: potentiation onto basolateral neurons had been reported for *both* appetitive and aversive learning, which cannot explain opposite behaviour — the sign is recovered once the recorded cell is sorted by its output.

**How little separates the two populations.** Topographically intermingled, both glutamatergic; no difference in action-potential half-width, spike threshold or intrinsic excitability; the only differences found are action-potential **accommodation** and greater **distal dendritic branching** in `CeM` projectors, with both pyramidal and stellate morphologies present in each. RNA-seq returns few differentially expressed genes — the authors read this as two closely related populations, with the candidate genes proposed to act on developmental wiring and/or on rapid gain modulation of transmission during valence-specific learning, not as a cell-type distinction.

| Finding | Consequence for a builder |
|---|---|
| The **sign of the weight change** for one event is set by the postsynaptic cell's *projection target* | The third factor cannot be a single broadcast scalar reaching a homogeneous sheet: two intermingled cells receiving the same input and the same global signal must receive **opposite-signed** instruction ([[wiki/concepts/synaptic-plasticity.md]]) |
| Separation is by axon, not by cell type, transmitter, topography or transcriptome | Valence separation is cheap — it costs distinct downstream targets and an addressing mechanism, not a new module. Nothing about the population is readable at its soma |
| Inhibiting one channel during the unconditioned stimulus **improves** learning on the other | The two are not merely parallel: suppressing the negative channel's plasticity frees capacity or removes competition on the positive one — a measured interaction the wiki's `head_+`/`head_−` arrangements ([[wiki/concepts/affective-opponency.md]]) do not have |
| The two channels were validated on **different tasks** (self-stimulation versus place avoidance) because one failed the other's assay | The 'positive/negative reinforcement' labels are not read off matched measurements (`G116`) |

**(brainstorm) This is the same trick as the midbrain's, one synapse earlier and expressed in plasticity rather than in firing.** [[wiki/entities/ventral-tegmental-area.md]] has channel identity set by afferent *and* by target in a subcortical nucleus of modulatory cells; here it is set by target alone, in a cortex-like structure of glutamatergic projection neurons, and what differs between channels is the **sign of learning** rather than the sign of a rate. A machine version is a shared trunk with two non-negative heads whose error terms are opposite-signed for the same outcome, the head's identity given by which downstream consumer it writes to — i.e. addressing by *readout*, which is free in any architecture where heads are already separate parameters. No model in the wiki assigns the sign of a teaching signal by the destination of the unit's output.

**The intermingling is an instrument warning with teeth.** Two opposite-signed populations at overlapping locations means every non-projection-identified record of this structure — unit recording, bulk imaging, lesion, local pharmacology — averages over a pair whose contributions cancel. The measured `AMPAR/NMDAR` increase after both fear and reward conditioning that the wiki inherits from earlier work is exactly such an average.

---

## Limitations

- **Review, not primary data**; several dissociations rest on a single lab's lesion studies, and lesion specificity within the amygdala is the chronic methodological risk.
- **No direct evidence the CeA is itself a site of association.** The source concedes it may receive an already-associated input; its afferents would support learning but the demonstration is absent, and a predicted experiment — temporary CeA inactivation during fear conditioning, which should spare later freezing — had not been run.
- **The CeA's purview is not a clean psychological category.** Eyeblink conditioning is a CS→UR association that is cerebellar, not amygdalar; the best available statement is pragmatic — the CeA subserves cue→response links when the response is organized by a hypothalamic or brainstem nucleus it controls.
- **BLA involvement may be training-dependent**: overtraining mitigates BLA-lesion deficits in contextual freezing, suggesting the affective contribution matters most early. Undertested.
- **Whether BLA-lesioned animals lack affective states or merely cannot retrieve them via a cue is undetermined**; food preferences are unaffected, which favours the retrieval reading.
- **Namburi et al. 2015 compares two paradigms, not two valences of one paradigm**: shock versus sucrose-with-food-restriction, run in separate cohorts with separate unpaired controls, so the opposite plasticity signs are opposite across *experiments*. `AMPAR/NMDAR` ratio is a proxy read ~24 h later from bulk internal-capsule stimulation, so which afferent was modified is not identified.
- **Its necessity result exists for one channel only** — photoinhibition of `CeM` projectors during the unconditioned stimulus. The symmetric prediction (inhibiting `NAc` projectors impairs reward learning and enhances fear learning) is untested, and the `Cre-DIO` cohort ran reward then fear conditioning in the same animals 1–4 weeks apart.
- **The transcriptional differences are candidates only** — no gene from the RNA-seq comparison was manipulated, so nothing connects them to the plasticity sign.
- **Contribution to core instrumental learning is unknown** — whether the BLA is needed for contingency perception or for assigning instrumental incentive value was untested, though amygdala–orbitofrontal disconnection does impair devaluation-driven choice in monkeys.

---

## Connections

- **[[wiki/concepts/valuation-system-decomposition.md]]** — this page is the anatomy under that page's assay-level split: the basolateral nucleus holds the `CS → US(motivational)` valuation and the central nucleus the `CS → UR` link, and the double dissociations are what make the two separately ablatable rather than two readings of one store.
- **[[wiki/concepts/incentive-salience.md]]** — supplies the source of the motivational gain that page's multiplier needs and denies it a valence: the central nucleus is required for Pavlovian–instrumental transfer, conditioned approach and amphetamine potentiation of conditioned reinforcement, and reaches the accumbens only through the ventral tegmental area — so 'wanting' is gated by a nucleus that equally gates conditioned suppression to shock. Driving the basolateral nucleus supplies that page's strongest result in the other direction: pursuit of a purely painful target, with the pursued object fixed by whatever was paired with the stimulation.
- **[[wiki/entities/ventral-tegmental-area.md]]** — the same addressing trick one synapse earlier and in a different quantity: there channel identity is set by afferent and by target among modulatory cells and shows up as the sign of a *rate*, here it is set by target alone among glutamatergic projection neurons and shows up as the sign of *plasticity* — two independent structures both refusing to separate valence by cell type. Also the amygdala's only route to the accumbens: the central nucleus has no direct accumbens projection, so every claim here about amygdalar control of striatal dopamine is a claim about an afferent to that structure's cell groups, and the valence-selectivity that page reports for its lines is not inherited from this one.
- **[[wiki/concepts/affective-opponency.md]]** — a fourth arrangement for that page's opponent pair, built by output address rather than by chemistry: two non-negative glutamatergic channels out of one nucleus whose *learning* is opposite-signed for the same event, with suppression of the negative one **improving** appetitive learning — an interaction term that page's `head_+`/`head_−` algebra does not have. It also populates that page's conflict quadrants from the substrate: basolateral damage removes `punishment × Go` (instrumental avoidance) while sparing `punishment × No-Go` (conditioned suppression), and the central nucleus does the reverse — a lesion-side partial four-cell design bearing on `G116`.
- **[[wiki/concepts/neuromodulatory-metaparameters.md]]** — the single structure that writes those metaparameters: the central nucleus projects to the dopaminergic, noradrenergic, serotonergic and cholinergic source nuclei, and its associability function is a per-stimulus learning rate raised by unsigned surprise — a written `α`, which that page's metaparameters otherwise lack an author for.
- **[[wiki/concepts/attention.md]]** — the same central-nucleus output read as attention: its nucleus basalis projection supports visuospatial attention in continuous-performance tasks and is proposed to expand a cue's cortical receptive field, so the attentional gain and the learning-rate gain here are one signal with two consumers.
- **[[wiki/entities/hippocampal-prefrontal-channel.md]]** — the other place this structure appears in the wiki, as a lock on another edge's writability; this page gives the locking structure its own computation, and distinguishes the two nuclei that edge's account does not.
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — the cortical partner in the same conditioning circuit: basolateral→medial-prefrontal connectivity is what lets conditioned punishment modulate instrumental choice, and the anterior cingulate supplies the accumbens core with the cue-disambiguating content that this structure does not.
- **[[wiki/entities/basal-ganglia.md]]** — the target of both nuclei's influence, by different routes: the basolateral nucleus projects glutamatergically to accumbens core and shell (content), the central nucleus reaches the same target only as a dopaminergic gain via the midbrain — content and gain entering one striatal node on separate wires.
- **[[wiki/entities/lateral-habenula.md]]** — a parallel aversive write-port, and an unresolved duplication: the central nucleus projects to the habenula *and*, independently, to the brainstem and to every ascending modulatory nucleus the habenula suppresses — so the wiki now has two structures claiming to be the aversive system's route to the neuromodulators, with no experiment separating parallel specification of different stress components from serial intensification of one.
- **[[wiki/concepts/synaptic-plasticity.md]]** — the addressing problem this page hands that page's rule family: two intermingled basolateral populations sharing an afferent bundle change weight with **opposite sign** after one conditioning episode, sorted only by projection target, so the third factor cannot be a scalar reaching a homogeneous sheet and must be resolvable per destination (Namburi et al. 2015).
- **[[wiki/concepts/pseudo-reward-prediction-error.md]]** — a response class that strains this page's format axis: right amygdala activates to a prediction error about distance to a self-set intermediate goal that predicts *no* outcome, specific or otherwise (`n` = 30, region of interest, `p` < 0.05, unilateral and unexplained), so either the basolateral outcome-specific reading has to count a subgoal as an outcome or the signal is arriving from elsewhere in the same four-structure set (`T367`, Ribas-Fernandes et al. 2011).
