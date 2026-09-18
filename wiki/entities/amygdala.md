# Amygdala — Two Nuclei Split by Representational Format, Not by Valence

**The basolateral amygdala (BLA) and the central nucleus (CeA) are doubly dissociable, and the axis that separates them is *what kind of representation is stored*, not *whether the outcome is good or bad*. The BLA lets a cue retrieve the current motivational value of the **specific** outcome it predicts — which is what second-order conditioning, conditioned reinforcement, devaluation sensitivity and outcome-specific choice modulation all require. The CeA holds outcome-blind cue→response links and is the controller of the brainstem and of every diffuse ascending modulatory nucleus — which is what freezing, conditioned orienting, Pavlovian–instrumental transfer and up-regulated associability all require. Both nuclei carry appetitive **and** aversive conditioning.**

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

## Limitations

- **Review, not primary data**; several dissociations rest on a single lab's lesion studies, and lesion specificity within the amygdala is the chronic methodological risk.
- **No direct evidence the CeA is itself a site of association.** The source concedes it may receive an already-associated input; its afferents would support learning but the demonstration is absent, and a predicted experiment — temporary CeA inactivation during fear conditioning, which should spare later freezing — had not been run.
- **The CeA's purview is not a clean psychological category.** Eyeblink conditioning is a CS→UR association that is cerebellar, not amygdalar; the best available statement is pragmatic — the CeA subserves cue→response links when the response is organized by a hypothalamic or brainstem nucleus it controls.
- **BLA involvement may be training-dependent**: overtraining mitigates BLA-lesion deficits in contextual freezing, suggesting the affective contribution matters most early. Undertested.
- **Whether BLA-lesioned animals lack affective states or merely cannot retrieve them via a cue is undetermined**; food preferences are unaffected, which favours the retrieval reading.
- **Contribution to core instrumental learning is unknown** — whether the BLA is needed for contingency perception or for assigning instrumental incentive value was untested, though amygdala–orbitofrontal disconnection does impair devaluation-driven choice in monkeys.

---

## Connections

- **[[wiki/concepts/valuation-system-decomposition.md]]** — this page is the anatomy under that page's assay-level split: the basolateral nucleus holds the `CS → US(motivational)` valuation and the central nucleus the `CS → UR` link, and the double dissociations are what make the two separately ablatable rather than two readings of one store.
- **[[wiki/concepts/incentive-salience.md]]** — supplies the source of the motivational gain that page's multiplier needs and denies it a valence: the central nucleus is required for Pavlovian–instrumental transfer, conditioned approach and amphetamine potentiation of conditioned reinforcement, and reaches the accumbens only through the ventral tegmental area — so 'wanting' is gated by a nucleus that equally gates conditioned suppression to shock.
- **[[wiki/entities/ventral-tegmental-area.md]]** — the amygdala's only route to the accumbens: the central nucleus has no direct accumbens projection, so every claim here about amygdalar control of striatal dopamine is a claim about an afferent to that structure's cell groups, and the valence-selectivity that page reports for its lines is not inherited from this one.
- **[[wiki/concepts/affective-opponency.md]]** — populates that page's conflict quadrants from the substrate: basolateral damage removes `punishment × Go` (instrumental avoidance) while sparing `punishment × No-Go` (conditioned suppression), and the central nucleus does the reverse — a lesion-side partial four-cell design bearing on `G116`.
- **[[wiki/concepts/neuromodulatory-metaparameters.md]]** — the single structure that writes those metaparameters: the central nucleus projects to the dopaminergic, noradrenergic, serotonergic and cholinergic source nuclei, and its associability function is a per-stimulus learning rate raised by unsigned surprise — a written `α`, which that page's metaparameters otherwise lack an author for.
- **[[wiki/concepts/attention.md]]** — the same central-nucleus output read as attention: its nucleus basalis projection supports visuospatial attention in continuous-performance tasks and is proposed to expand a cue's cortical receptive field, so the attentional gain and the learning-rate gain here are one signal with two consumers.
- **[[wiki/entities/hippocampal-prefrontal-channel.md]]** — the other place this structure appears in the wiki, as a lock on another edge's writability; this page gives the locking structure its own computation, and distinguishes the two nuclei that edge's account does not.
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — the cortical partner in the same conditioning circuit: basolateral→medial-prefrontal connectivity is what lets conditioned punishment modulate instrumental choice, and the anterior cingulate supplies the accumbens core with the cue-disambiguating content that this structure does not.
- **[[wiki/entities/basal-ganglia.md]]** — the target of both nuclei's influence, by different routes: the basolateral nucleus projects glutamatergically to accumbens core and shell (content), the central nucleus reaches the same target only as a dopaminergic gain via the midbrain — content and gain entering one striatal node on separate wires.
- **[[wiki/entities/lateral-habenula.md]]** — a parallel aversive write-port, and an unresolved duplication: the central nucleus projects to the habenula *and*, independently, to the brainstem and to every ascending modulatory nucleus the habenula suppresses — so the wiki now has two structures claiming to be the aversive system's route to the neuromodulators, with no experiment separating parallel specification of different stress components from serial intensification of one.
