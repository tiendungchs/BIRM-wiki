# Cross-Embodiment Transfer

**A policy or vocabulary transfers across bodies to the degree that what is carried over is invariant to the effector — so the design question is not "which network" but *at which level of body-independence the shared representation is cut, and how small the body-specific decoder below it can be made*.**

> **Provenance.** Kawaharazuka, Oh, Yamada, Posner & Zhu 2025, *Vision-Language-Action Models for Robotics: A Review Towards Real-World Applications*, arXiv:2510.07077 (`raw/kawaharazuka-2025-vision-language-action-robotics.md`). A **survey**: every result below is reported there, not reproduced there, and is attributed to its own source. Scope declared there: a Vision-Language-Action (VLA) model takes visual observations and natural-language instructions and emits control commands *directly*; systems whose vision-language stage only picks an index from a fixed skill library are excluded.

This is the `g`/`x` factorisation of [[wiki/concepts/latent-graph-discovery.md]] with `x` set to **the body**. Every other instance in the wiki factorises across *tasks* or *environments*; this is the only one where the held-out variable is the actuator, and it is the only place where an abstraction claim is checked by running the representation on hardware with a different number of joints.

---

## The problem, as the field states it

| Source of mismatch | Why it defeats naive weight sharing |
|---|---|
| Degrees of freedom, joint configuration, link lengths | Action vectors are not commensurable dimension-by-dimension |
| Sensor type and placement | Proprioceptive observation spaces differ in size and meaning |
| Morphology class — arm / wheeled base / legs / humanoid | Not a re-parameterisation: a quadruped has no gripper axis to align |
| **Human demonstration data has no action labels at all** | The cheapest and largest data source is action-free by construction, and inferred human actions differ from robot actions "in both form and semantics" |

---

## The five families, ordered by where the shared level is cut

The unifying reading the survey does not state: **all five push the shared representation up to a body-independent level and push the body into a small decoder below it.** They differ only in how high the cut is.

| Family | Shared object | Body-specific part | Instances | Cost |
|---|---|---|---|---|
| **Normalise to a common action format** | One camera + language + **7-DoF** action (position, orientation, gripper) in a single schema | none — every robot is coerced into the schema | Open X-Embodiment (OXE, 22 robots, 1.4M episodes, RLDS); a variant normalising heterogeneous observations into a shared first-person view | Works only where a 7-DoF end-effector is a meaningful description; "struggles to uniformly handle manipulators, mobile robots and legged robots" |
| **Shared trunk, per-embodiment heads** | Modality-specific tokenizers → one unified token sequence (missing modalities masked) → one decoder-only transformer → readout tokens | Action heads per robot class: single-arm, bimanual, navigation, quadruped | CrossFormer | The head is where all the incompatibility was moved; nothing transfers *between* heads |
| **Universal discrete action codebook** | A Universal Action Space: one shared discrete codebook, tokens predicted by the transformer | Per-embodiment decoders from code → continuous action | UniAct | The atomic action set is a design choice made once, in advance, for all bodies |
| **Embodiment-agnostic intermediates** | Optical flow, arbitrary feature-point trajectories, keyframe object displacements — geometry of the *scene*, not of the robot | A per-robot policy or an optimisation that turns tracks into `SE(3)` transforms | ATM, Track2Act, LangToMo, AVDC, PPI (Pointflow) | The intermediate says what should move, never who moves it — the mapping to joints is a second, unshared problem |
| **Latent actions induced from video** | A discrete or continuous code per frame pair, learned by reconstructing `x_{t+H}` from `x_t` and the code, then used as a surrogate action target for pretraining | An MLP or head replaced after pretraining and fine-tuned to emit real commands | LAPA (VQ-VAE over a spatio-temporal difference), Moto, UniVLA (DINOv2 latent augmented with language, two stages disentangling task-independent from task-dependent codes), UniSkill, and LAPA as the pretraining stage of GR00T N1 and DreamGen | The code has no units and is never validated against a real action; see [[wiki/entities/adaworld.md]] for the same object studied on its own terms |

**The empirical claim the field rests on**, from Open X-Embodiment: training on data pooled from many robots yields a policy that beats one trained on any single embodiment's data. The survey reports this as the project's "key insight". It is also the only claim here with a control — every other row is evaluated on whether the transfer *works*, not against the same architecture trained without the other bodies.

---

## The ladder: body-independence and executability trade off monotonically

**(brainstorm)** Reading the five families as one axis gives an ordering the wiki does not have anywhere else, and it is a definition of abstraction that is neither temporal ([[wiki/concepts/temporal-abstraction-options.md]]) nor policy-order ([[wiki/concepts/policy-abstraction-hierarchy.md]]):

```
language subtask  >  future video  >  optical flow / point tracks  >  latent action code
   >  normalised 7-DoF end-effector delta  >  joint angles / torques
```

Each step down is *more executable and less shareable*. Two consequences worth testing:

- The level at which a system predicts is a claim about which population of bodies it means to serve, and it is currently chosen by convenience rather than measured. Nobody reports the accuracy-vs-transfer curve along this ladder for one architecture.
- The ladder gives **abstraction-as-invariance a hardware-checkable operationalisation**: an intermediate representation is more abstract exactly when the set of embodiments that can consume it is larger. Unlike every abstraction score in the wiki, that set is enumerable.

---

## What this contests

The wiki's account of grounded vocabulary ([[wiki/concepts/affordance-grounded-symbols.md]]) says symbols are **agent-relative** by construction: `b(x₁) = b(x₂) ⟺ ∀a ∈ A: effect(x₁,a) ≈ effect(x₂,a)`, quantified over *this* agent's repertoire, so an agent whose actions cannot separate two kinds of thing will never form two symbols for them. Every row above asserts the opposite in practice — one interface above 22 robot types, one codebook above manipulators and quadrupeds, one latent action alphabet extracted from *humans* and used to pretrain a robot. New tension **T172**.

The honest resolution the survey itself supplies: in every row the body-specific decoder is still there. What is shared is the perception-and-intent level; the repertoire-relative part has been *relocated*, never removed. So the two positions may be about different halves of the same stack — which is a claim nobody has tested, because no result reports what a shared interface *cannot* express about any of its member bodies.

---

## Open problems

- **No metric of embodiment distance.** Pooling helps (OXE), morphology classes are handled separately (CrossFormer's four heads), and nothing predicts in advance which pairs of robots will transfer. A quantity analogous to `ρ_tr` in [[wiki/concepts/learned-world-models.md]] — computable from the data before training — does not exist for bodies.
- **Nothing separates "more data" from "more bodies".** The OXE result adds embodiments and episode count at once.
- **The shared alphabet is authored in all but one family.** The 7-DoF schema, the universal codebook size and the flow/track representation are all human choices. Only latent-action induction fits the alphabet, and it fits it to whatever varies between frames — including the weather ([[wiki/entities/adaworld.md]]).
- **Human video is the target and the least validated.** Latent actions extracted from egocentric human data (Ego4D, EPIC-KITCHENS, Aria) are used as surrogate targets, and no reported experiment checks that a code extracted from a human hand denotes the same transition when a gripper executes it.
- **Nothing ranks the families, because the field has no comparable evaluation.** The survey states that evaluation metrics "remain poorly defined, particularly in real-world settings", that most comparisons are run in simulation for reproducibility, and — citing Large Behavior Models — that controlled conditions, enough trials and confidence intervals are needed before any architectural difference can be called real. The two mechanisms proposed against this are worth keeping as machinery rather than as benchmarks: **SIMPLER** builds a simulator whose visual and control domain gaps are minimised until simulated and real scores correlate, and **RoboArena** ranks policies by *pairwise* comparisons distributed across robots at seven institutions and aggregated centrally — a ranking protocol with no absolute metric at all, which is the only proposal in the wiki that addresses gap G17 by giving up on scoring a system in isolation.
- **Legs, wheels and arms are still three problems.** Stated in the survey as the standing limitation of the unified-format family and, implicitly, of everything built on it.

---

## Connections

- **[[wiki/concepts/affordance-grounded-symbols.md]]** — the position this page contests: there a symbol is defined by quantifying over *one agent's* repertoire, which makes vocabularies non-transferable across bodies in principle; here one interface is fitted above 22 robot types and the repertoire-relative part is pushed into a per-embodiment decoder ([[wiki/empirical-tensions.md]] T172).
- **[[wiki/entities/adaworld.md]]** — the latent-action row of the family table studied as an object rather than as a pipeline stage: the same induce-a-code-from-a-frame-pair move, with the bottleneck coefficient `β` shown to trade expressiveness against exactly the cross-environment overlap this page's transfer claims depend on.
- **[[wiki/concepts/learned-world-models.md]]** — supplies the mechanism behind the video-prediction row: predict in a body-independent space and let an inverse-dynamics model do the embodiment-specific decoding, which is a world model used as an action *relabeller* rather than as a simulator, dynamics model or reward model.
- **[[wiki/concepts/policy-abstraction-hierarchy.md]]** — the other axis of hierarchy, and the machine mainstream's stack is built on this page's axis rather than that one: a VLA's two levels differ in body-independence and control rate, not in policy order, and both levels see the same observation (gap G59).
- **[[wiki/concepts/latent-graph-discovery.md]]** — the `g`/`x` factorisation with the held-out variable set to the actuator, which is the only instance in the wiki where the invariance claim is checked by running the representation on different hardware rather than on a different task.
- **[[wiki/concepts/temporal-abstraction-options.md]]** — orthogonal and complementary: options abstract over *how long* an action lasts, this page abstracts over *whose body* executes it, and no system in the wiki does both — a shared latent action here is strictly one step long.
- **[[wiki/concepts/cross-modal-grounding.md]]** — the third modality the same stack has to bind: the language instruction is the level of the ladder above video, and it is the only level that is shared across bodies *and* already carries a vocabulary humans agree on.
- **[[wiki/concepts/continual-learning.md]]** — where the shared level is protected in practice: gradient insulation, freezing and Low-Rank Adaptation exist because fine-tuning a per-body head into a pooled backbone destroys the pooling that made it worth having (gap G65).
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — the currency the transfer claims are denominated in: adaptation to a new embodiment is reported in demonstrations or fine-tuning steps, never in what the shared interface gives up to be shareable.
- **[[wiki/concepts/shared-intentionality.md]]** — names the half this page has and the half it lacks for transmitting a convention: a body-specific decoder under a shared latent gives the re-execution step of imitative learning, and the missing step is inverting the demonstration into a goal plus a means chosen under constraints before re-executing — without it, transfer is emulation (learning what the object affords) rather than imitation.
