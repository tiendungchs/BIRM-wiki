# Salience Network — the Candidate Arbitrator Between the Internal and External Modes

**A third large-scale system — anterior insula plus dorsal anterior cingulate cortex, with subcortical nodes in affect and reward regions — proposed to *switch* the other two: on detection of a behaviourally salient event it disengages the default mode network and engages the lateral frontoparietal network, so the internal/external mode assignment is made by a dedicated detector rather than by local competition between the two competing systems. This is the "triple-network model", and it is the first candidate the wiki has for the arbitrator [[wiki/architectural-gaps.md]] `G90` says is missing.**

> **Provenance.** Menon 2023, *20 years of the default mode network: A review and synthesis*, Neuron 111(16), doi:10.1016/j.neuron.2023.04.023 (`raw/menon-2023-default-mode-network-20-years.md`). A Perspective by one of the two authors who named the default mode network, not a primary study; the switching claim aggregates dynamic causal modelling across multiple tasks, information-theoretic analysis of intracranial EEG, and — the only causal-grade evidence — optogenetic stimulation with fibre photometry in rodents. No effect size or `N` is reported for any of it in the review, which is the main reason to read this page as a hypothesis with an anatomy rather than as a measurement.

---

## The three networks

| Network | Anchors | Job in the model | Direction of the mode variable |
|---|---|---|---|
| **Salience** | Anterior insula (AI), dorsal anterior cingulate cortex (dACC); subcortical affect/reward nodes | Bottom-up detection of behaviourally relevant events; **switching** between the other two | Sets it |
| **Frontoparietal** | Dorsolateral prefrontal cortex, posterior parietal cortex | Attention, response inhibition, working memory — the externally directed mode | Engaged by the switch |
| **Default mode** | See [[wiki/entities/default-mode-network.md]] | Internally generated construction | Disengaged by the switch |

**The claim that makes it an arbitrator and not just a third network:** suppression of the default network and engagement of the control networks are asserted to be *one* mechanism with a common cause, not two effects that happen to co-occur. Dynamic causal modelling across a range of tasks places the causal **outflow hub** in the salience network, with the anterior insula specifically as the node whose signal precedes both the frontoparietal engagement and the default disengagement.

---

## What is actually established, in descending order of evidential grade

| Claim | Method | Grade |
|---|---|---|
| Default-mode deactivation is **neuronal**, not a vascular/threshold artefact of the baseline contrast | Intracranial EEG in 3 patients with intractable epilepsy: selective high-gamma (**76–200 Hz**) power increase in medial prefrontal cortex and posterior cingulate/precuneus at rest relative to finger movement, vision and speech tasks; transient high-gamma *suppression* in the same nodes during spatial attention and word reading, and in posterior cingulate and retrosplenial cortex during mental arithmetic | **Direct electrophysiology**, tiny `N`, replicated across labs and tasks by 2011 |
| The switch can be driven causally | Optogenetic stimulation with fibre photometry in rodent brain, reproducing the network-switching signature | **Causal**, but in a species whose default-mode homology the review itself calls incompletely understood |
| The anterior insula is the outflow hub | Dynamic causal modelling and directed-information analyses over fMRI and intracranial EEG | **Model-dependent** — the direction is an inference from a fitted state-space model, not an intervention |
| Weak switching produces attention lapses | Trial-by-trial coupling of slow responses with *reduced* default deactivation (posterior cingulate, precuneus, angular gyrus), reduced stimulus-evoked sensory activity, and frontoparietal hyperactivity | Correlational, replicated |

The lapse row is the load-bearing behavioural evidence: it is what converts "the network deactivates" into "the deactivation is *necessary* for adaptive disengagement", and it is the reason failure of switching, rather than the default network's content, is the review's account of the network's *indirect* role in cognition.

---

## The counter-current the same review reports and does not reconcile

Against a picture in which the salience network commands and the default network is commanded, Menon reports the opposite gradient in the very same section:

- Dynamic causal modelling of resting fMRI: posterior cingulate and medial prefrontal cortex exert **greater causal influence on lateral frontoparietal networks than the reverse**.
- Information-theoretic analysis of intracranial EEG across distributed depth electrodes: the default network has significantly **greater net causal outflow** to other networks — including sensory and motor networks — than inflow, both at rest and during episodic memory formation, with the interaction strength *higher* during memory formation than at rest.

So the default network is simultaneously (i) the system a salience detector switches off and (ii) the system with the largest net directed outflow in the brain, at rest and during a task. The review's resolution is that these are different regimes — event-driven switching versus sustained broadcast — but nothing in it separates them empirically. Logged as [[wiki/empirical-tensions.md]] T257.

---

## Relevance to a reasoning model

- **An arbitrator is a *detector*, not a scheduler (brainstorm).** The architectural content of the triple-network model is that mode assignment is delegated to a system whose only job is estimating behavioural relevance of the current input — not to a policy, not to a task-set signal, not to competition between the modes. That is cheap to build: one scalar salience estimate with two opposed output gains. Every wiki controller instead selects among *externally directed* tasks ([[wiki/concepts/cognitive-control.md]]'s bias signal) and has nothing to say when there is no task.
- **Bottom-up, therefore interruptible by content the current task does not care about.** The insula's input is stimulus salience, not goal relevance, which is what allows an internal mode to be broken into by an unexpected event — and, symmetrically, is why a purely goal-driven controller cannot implement this switch.
- **The failure mode is graded and two-sided.** Weak switching → lapses and intrusion of internal content; the clinical picture on [[wiki/entities/default-mode-network.md]] (autism under-engagement, schizophrenia over-engagement) is the same variable at its two extremes. A machine analogue therefore needs the switch *threshold* exposed, not just the switch.
- **A rebound is part of the specification.** Menon's summary is explicit that suppression is followed by "a rebound and return to internally focused mental states" once the salient stimulus has been handled — i.e. the default is a state the system *returns to*, not a state it falls into when the queue is empty. Nothing in the wiki has a return-to-default dynamic; idle behaviour is everywhere the absence of a call.

---

## Open problems

| Problem | Why it is open |
|---|---|
| Directed-influence estimates are model-dependent | Dynamic causal modelling and directed information both infer direction from fitted dynamics on observational data; the review reports two mutually opposed gradients (salience→default, default→frontoparietal) from these methods without a design that separates them |
| No human causal manipulation | The only interventional evidence is rodent optogenetics, in a species whose default-mode homology is unsettled and which cannot supply the mind-wandering, language and semantic functions the switch is supposed to be gating |
| What the switch reads | "Salience" is not operationalised in the review; without a definition, the model predicts a switch whenever a switch is observed |
| Is one detector enough | The default network fractionates into subnetworks with distinct couplings to control networks, so a single scalar switch may be the wrong shape — the mode variable could be per-subnetwork |

---

## Connections

- **[[wiki/entities/default-mode-network.md]]** — the system this one is proposed to switch off; that page states the arbitration question (separate controller vs local mutual inhibition) and this page supplies the field's leading answer to it, along with the intracranial-EEG evidence that the deactivation being arbitrated is neuronal.
- **[[wiki/concepts/cognitive-control.md]]** — both describe a control layer that biases rather than routes, but that page's controller selects among externally directed task sets and this one selects *whether the system is externally directed at all*, which is the level above it.
- **[[wiki/concepts/integration-segregation-balance.md]]** — the switch is a concrete driver for the axis that page measures: an event-driven, anatomically localised cause of a segregation/integration change, where that page's driver candidate is diffuse ascending neuromodulatory gain.
- **[[wiki/concepts/priority-map.md]]** — salience detection is the same quantity a priority map computes; this page is the claim that the map's output is also used to assign the internal/external mode, not only to select a target.
- **[[wiki/concepts/dynamic-network-connectivity.md]]** — supplies the mechanism by which a switching signal could change effective network membership within seconds rather than by rewiring.
- **[[wiki/concepts/effective-connectivity.md]]** — every directional claim on this page is an effective-connectivity estimate, and the two opposed gradients here are that page's identifiability problem with real stakes.
- **[[wiki/concepts/event-segmentation.md]]** — a salience-triggered switch is a boundary detector operating on behavioural relevance rather than on predictive-encoding change, and it is the only boundary mechanism in the wiki whose output is a *mode assignment* rather than a segment index.
