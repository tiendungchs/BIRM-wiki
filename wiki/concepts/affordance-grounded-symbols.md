# Affordance-Grounded Symbols

**A discrete symbol is an equivalence class of situations that produce the same *effect* under the agent's own actions — so the discretisation of a continuous sensorimotor stream is supervised by action consequences rather than by perceptual similarity.**

> Primary framing source: `raw/taniguchi-2023-world-models-predictive-coding-robotics.md` — Taniguchi, Murata, Suzuki, Ognibene, Lanillos, Ugur, Jamone, Nakamura, Ciria, Lara, *Advanced Robotics* 37(13):780–806, 2023. A **survey**: every result below is reported there, not reproduced there, and is attributed to its own source.

**And it is the discrete horn of a live disagreement.** A continuous alternative now exists at a scale none of the systems below approach: an information bottleneck over consecutive video frames induces a continuous *action* alphabet from 2000M unlabeled frames, and the Genie-style discrete (VQ-8) variant of the same method transfers barely better than no action condition at all ([[wiki/entities/adaworld.md]], tension **T148**). The two are not direct competitors — that method carves transitions and this one carves states, and it needs no agent where this one needs a repertoire — but they answer the same question about what a discovered vocabulary is made of, and they answer it differently.

This is the wiki's third candidate answer to gap G27 (*nothing supplies the discretisation the graph formalisation assumes*), and the only one whose carving criterion comes from **outside** the observation stream. Event segmentation carves on predictive failure; contextual inference carves on novel-context responsibility; both read a signal the sensory stream already contains. Effect-equivalence carves on what the agent's actions *do*, which no passive observer can compute.

**A fifth family takes the criterion and drops the agent.** [[wiki/entities/spelkenet.md]] groups by response to intervention exactly as this page does, but the intervention is *imagined* — appended to the input sequence of a generative video model and marginalised over its sampled outcomes ([[wiki/concepts/counterfactual-probing.md]]). It therefore recovers distinctions no repertoire of this agent's actions makes, escaping the repertoire limit below, and it scales to internet video where every system in the table needs a robot. It pays for both with the one thing effect-equivalence has and it does not: **nothing ever checks the counterfactual against the world**, so the symbol's applicability mask is guaranteed only relative to the model's beliefs. The two are complements rather than rivals — an executed poke is a validation signal for an imagined one, and no system in the wiki runs the pair.

**And the agent-relative half of it is now contested by practice.** The criterion below quantifies over *this* agent's repertoire `A`, which makes a vocabulary non-transferable across bodies in principle. The robot-policy field builds the opposite: one action interface fitted above 22 robot types and reported to beat single-embodiment training on each (Open X-Embodiment), one shared discrete codebook above manipulators and quadrupeds with per-body decoders (UniAct), and latent action alphabets extracted from *human* video and used to pretrain robot policies (LAPA → GR00T N1) — all as reported in Kawaharazuka et al. 2025 ([[wiki/concepts/cross-embodiment-transfer.md]], tension **T172**). The reconciliation on offer is that in every one of those designs a body-specific decoder survives underneath the shared level, so the repertoire-relative part has been relocated rather than removed; what nobody reports is which distinctions the shared interface *cannot* make for any of its member bodies, which is precisely the shortfall this page's own open problems say goes unaudited.

---

## The criterion

Let `x` be an observation of an entity, `a` an action from the agent's repertoire `A`, and `e = effect(x,a)` the observed change. The symbol map `b: x → {0,1}^k` is defined implicitly by

```
b(x₁) = b(x₂)   ⟺   ∀a ∈ A:  effect(x₁,a) ≈ effect(x₂,a)
```

and learned by putting a **binary bottleneck inside an effect predictor**:

```
b = round(σ(f_enc(x)))  ∈ {0,1}^k          # the symbol
ê = g_dec(b, a)                             # predicted effect
L = ‖ê − effect(x,a)‖²
```

Three properties fall out, none of which a perceptual autoencoder has:

| Property | Why it holds |
|---|---|
| **Symbols are agent-relative** | `A` is the agent's own repertoire. The same stone is one symbol to an agent that can lift it and another to one that cannot — Gibson's affordance definition made computational, and the *Umwelt* claim (the "world" of a world model is the world under this agent's sensors and effectors, never a bird's-eye map) turned into a training objective |
| **Symbols are typed by consequence, not by appearance** | Two visually dissimilar objects that afford the same effect collapse to one code; two near-identical objects that behave differently separate. Pure-visual neuro-symbolic systems cannot do either, which is the survey's central contrast between visual and robotic symbol discovery |
| **The symbol carries its own precondition** | An effect predictor conditioned on `a` is exactly a `⟨precondition, action, effect⟩` triple, i.e. a typed edge — the object PDDL wants, obtained without writing predicates |

---

## Instantiations (all as reported in Taniguchi et al. 2023)

| System | Discretiser | Supervision | What it plans with | Limitation |
|---|---|---|---|---|
| Konidaris et al. | symbols discovered for a given agent setting, constructed to be usable in a planning-domain description | the agent's own action/option set | discovered symbols used **directly as PDDL predicates** in action descriptions; deterministic and probabilistic plans, simulation and real robot | needs the action/option set (gap G33) handed to it |
| James et al. | same, in the agent's **egocentric** frame | as above | transfers to new settings | egocentric symbols lose allocentric relations |
| Ugur et al. | X-means clustering + SVM over continuous perceptual space | hand-coded perceptual features | PDDL manipulation planning | the features — i.e. the hard half of G27 — are supplied |
| **DeepSym** (Ahmetoglu et al.) | binary bottleneck in an encoder–decoder from *raw pixels + action* to effect in pixel coordinates | effect prediction only | decision tree distils the decoder into probabilistic PDDL rules consumed by an off-the-shelf planner | one object at a time |
| DeepSym + multi-head attention (Ahmetoglu) | as above, attention over object set | effect prediction | symbols encoding affordances of *object relations*, not single objects | relations are attention weights, not typed edges |
| Ahmetoglu et al. (slow feature analysis) | units with the **lowest** eigenvalues | none (slowness) | nothing yet — the units merely *correlate* with high-level features | "precursors of symbols", not symbols |
| **LatPlan** (Asai et al.) | discrete-bottleneck state autoencoder trained first, action preconditions/effects learned second; later work learns both jointly | image reconstruction, then transition | classical planning over discovered propositions, with visualised plan execution | 2-D puzzles; the state encoder is action-blind in the two-stage version |

**The row that matters is DeepSym.** It is the only entry that goes from raw pixels to a plan with no hand-coded feature, no supplied option set and no reconstruction objective — and its symbols group objects by shared affordance *as a consequence of the training target*, because the only thing the code has to preserve is what the object does when acted on.

---

## Why this is a world model, not an adjunct to one

The survey's §4.3 argument, which the wiki should adopt: a computational affordance model that includes the action *and* its effect **is** an internal model of how the world behaves for this agent — the same object as `p(z'|z,a)`, written over a discrete state space instead of a continuous one. So the affordance literature and the world-model literature are not neighbours to be reconciled; they are the discrete and continuous readings of one thing, and the techniques used to learn them overlap.

**(brainstorm)** Effect-equivalence is also the cleanest available answer to gap G23 (*machine priors are unconditional; a prior needs an entry test*). A symbol learned this way arrives with its own applicability mask: the set of `x` mapping to code `b` is precisely the set on which `b`'s effect rules hold, and an object outside it is not admitted. Core knowledge stipulates entry conditions (cohesion, continuity); this learns them, at the price of only ever recovering conditions that some action in `A` can distinguish. It predicts the corresponding failure: an agent whose repertoire cannot separate two kinds of thing will never form two symbols for them, however different they look — the sand-vs-solid distinction is learnable by a gripper and invisible to a camera.

**(brainstorm)** It also gives G40 (*when to factorise and when to entangle*) a decision procedure rather than a preference. Factorise iff the effect predictor's loss is unchanged when the code is split and the parts are recombined — i.e. iff effects are separable across the proposed factors. That is a measurable quantity on machinery already trained, and it is not available to any objective scored on reconstruction.

---

## Open problems

- **No symbol has been put inside a state-space world model.** The survey states plainly that methods for integrating symbolic structure into VAE- and SSM-based world models "are still being explored". Every entry above discretises *instead of* running a latent-dynamics model, not *inside* one — so the wiki has no example of a system that plans symbolically at the top and continuously at the bottom on one learned representation.
- **The action repertoire is fixed.** Every criterion above quantifies over `A`, and every system takes `A` as given. If actions are themselves learned (options, G33), symbols and options must be co-discovered — the vocabulary co-discovery problem (G4) with a second circularity: options are defined over states, and the states are defined by what the options do.
- **Effect-equivalence is repertoire-limited, and nothing measures the shortfall.** No system reports which distinctions its action set *cannot* make, so the discretisation's coverage is unaudited.
- **Bottom-up symbols vs. top-down language.** The survey's §5.1 frames the live question as bidirectional: injecting a language model's symbolic knowledge into a robot's world model is the easy direction; the hard one is bottom-up formation of a symbol system that a language could then attach to (symbol emergence in cognitive and developmental systems). Nothing in the wiki does the second.
- **Continuous and discrete costs are not commensurable.** A distilled PDDL rule set is consumed by a classical planner whose plan quality is measured in steps; the underlying effect predictor's error is measured in pixels. No entry above scores a symbolic plan by the continuous cost it will actually incur.

---

## Connections

- **[[wiki/concepts/event-segmentation.md]]** — the sibling answer to gap G27 with the complementary carving criterion: segmentation cuts the stream where *prediction fails*, effect-equivalence cuts it where *actions stop mattering*; an event schema's `⟨precondition, transition, effect⟩` and a distilled PDDL rule are the same object arrived at from opposite ends.
- **[[wiki/concepts/latent-graph-discovery.md]]** — supplies the nodes the framing assumes: a symbol is a node, its precondition mask is the node's entry test, and the distilled action rule is a typed edge, all obtained without a hand-built state space.
- **[[wiki/concepts/simulation-based-planning.md]]** — what the symbols are *for*: distilled probabilistic PDDL rules are handed to an off-the-shelf planner, which makes rollout depth a symbolic search parameter rather than a horizon over a learned latent — the discrete counterpart of that page's model-based branch.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — the same prediction-error objective with the bottleneck moved: predict *effects of actions* rather than *sensations*, and the residual carves categories instead of tracking states; the survey treats effect prediction as predictive coding over object symbols.
- **[[wiki/concepts/causal-model-building.md]]** — an effect predictor is a causal model in the narrow sense that its inputs are interventions, so the symbols it induces are grouped by intervention response — the training signal that page says causal fidelity has to be paid for with.
- **[[wiki/concepts/core-knowledge.md]]** — the learned rival to installed entry conditions: core systems stipulate which entities they admit, effect-equivalence derives an applicability mask from what the agent's actions can distinguish (gap G23).
- **[[wiki/concepts/temporal-abstraction-options.md]]** — the co-discovery circularity: Konidaris-style symbols are constructed against a *given* action/option set, and options are policies over states the symbols are supposed to define, so neither family currently bootstraps the other (G4, G33).
- **[[wiki/concepts/compositionality.md]]** — supplies a compositional vocabulary whose primitives are grounded rather than stipulated, and a test for whether a proposed factorisation is real (does splitting the code leave effect prediction unchanged).
- **[[wiki/entities/h-jepa.md]]** — the continuous rival at the same job: there, high-level actions are *conditions on lower-level states* learned by long-range predictability; here they are discrete codes learned by effect-equivalence, and neither has been run inside the other.
- **[[wiki/concepts/learned-world-models.md]]** — the continuous mainstream this page departs from, and the argument for departing: formal verification that a world model never hallucinates a hazard is named as an open problem for learned latents, and a transition system over a finite symbol set is the only form in the wiki that admits it (Long et al. 2025).
- **[[wiki/entities/kan-ode.md]]** — the mirror-image failure on the same pair of gaps: this page discovers *what the symbols are* from action consequences and then distils its decoder into approximate PDDL rules, while a KAN-ODE recovers an exact closed-form transition law but has to be handed the state variables that define its input and output dimensions. Neither supplies the other's half, and no system in the wiki does both (Koenig et al. 2024).
- **[[wiki/empirical-tensions.md]]** — this page is position A of **T148** (*should a discovered alphabet be discrete or continuous?*) as well as of **T147** (*does making a learned model inspectable require a discrete bottleneck?*); the rival says a continuous transition law can be read out directly if the learnable parameters sit in the functional form rather than in node weights.
- **[[wiki/entities/adaworld.md]]** — the passive, continuous mirror of this page's criterion: latent actions type a *transition* by what an information bottleneck must keep to predict the next frame, needing no agent, no repertoire and no intervention — which is why the method scales to 2000M frames of found video and why it cannot tell an action from the weather, the one distinction effect-equivalence gets for free.
- **[[wiki/entities/spelkenet.md]]** — the same criterion with the intervention imagined instead of executed: no body, no repertoire, no repertoire limit — and no validation, since the counterfactual is scored against human judgement rather than against a real poke.
- **[[wiki/concepts/counterfactual-probing.md]]** — that method in general form, and the reason it complements this page rather than replacing it: an executed action is the only thing that can certify an imagined one, and a repertoire is the only thing that bounds what the imagination is allowed to claim.
- **[[wiki/concepts/program-induction.md]]** — the one route in the wiki where the symbols a program is written over are induced from intervention outcomes rather than authored, which is a partial answer to that family's standing cost (somebody authors the library).
- **[[wiki/entities/neo-neural-theorizer.md]]** — the rival grounding criterion: a symbol means "a situation my action repertoire cannot distinguish from this one" here, and "whatever the one shared executor does with it" there — which drops the repertoire-limited ceiling and the need for an agent, at the cost of any external anchor for what the symbols mean.
- **[[wiki/concepts/cross-embodiment-transfer.md]]** — the standing objection to this page's agent-relativity: five families of shared action interface fitted above heterogeneous bodies, each keeping only a small per-embodiment decoder, which asserts in practice what the effect-equivalence criterion forbids in principle ([[wiki/empirical-tensions.md]] T172).
- **[[wiki/concepts/cross-modal-grounding.md]]** — the same word pointed the other way: there the symbol is supplied by a human corpus and only the mapping is learned, which grounds nouns and fails on relations — the complementary failure to this page's, where the criterion is relational by construction but the vocabulary has no names.
- **[[wiki/entities/baba-is-ai.md]]** — an environment that collapses the object/rule type distinction into one affordance: `push` applies identically to a ball and to the word `is`, so effect-equivalence over this agent's repertoire puts game objects and rule tiles in one symbol class and separates them only by what the push *does* — the sharpest available case for carving by consequence rather than by appearance.
- **[[wiki/concepts/shared-intentionality.md]]** — the counter-case that bounds this page's thesis: status functions (a pencil *counts as* a toothbrush in a shared pretense) are symbols whose content comes from joint declaration and explicitly overrides the object's causal affordances, and children under 24 months almost never produce one they have not first seen an adult produce — so effect-under-my-actions cannot be the general grounding rule for symbols.
