# Counterfactual Probing

**Extract structure from a trained generative model by intervening on its *input* and clustering the *distribution* of responses — not by fitting a decoder to its activations, and not by acting in the world.**

The move: a world model that has learned "what happens next" has, implicitly, learned "what depends on what". Intervening at one location and marginalising over the model's own imagined outcomes converts that implicit dependency structure into an explicit partition — of pixels into objects, and in principle of any domain's variables into causally bound groups. The structure that comes out was never labelled, which is what separates this from [[wiki/concepts/representation-probing.md]].

> **Provenance.** Venkatesh et al. 2025 (`raw/venkatesh-2025-spelke-segments.md`) supplies the worked method (*statistical counterfactual probing*) and every number; see [[wiki/entities/spelkenet.md]]. Its deterministic predecessor is CWM (Counterfactual World Models, Bear et al.), reported and beaten there.

---

## The procedure

Let `Ψ` be a generative model of a scene's response, `x` an observation, `k` a location, `f` an intervention applied at `k`.

| Step | Operation | Why it is there |
|---|---|---|
| **1. Find intervenable sites** | Query the model with no intervention; sum the probability mass on outcome tokens denoting change: `p_move[k] = Σ_{j : ‖v_j‖ > τ} D[k, j]` | Not every site responds to a force. A *movability prior*, read out of the model's marginals with no extra machinery |
| **2. Neutralise confounding causes** | Condition on the nuisance cause being absent — for video, a zero camera-pose token | Otherwise the model is free to explain the injected motion by ego-motion rather than by the applied force, and the response is not attributable |
| **3. Intervene** | Append `(pointer, content)` for the intervention: `z_f = x ⊕ [c=0] ⊕ [(i_k, f_k)]` | Must be *sparse and localised*. This is a constraint on the architecture, not on the method — see below |
| **4. Marginalise** | Sample `R` intervention directions × `T` rollouts; take the expected displacement `E_disp[u] = Σ_j D[u,j]·v_j` per rollout | A deterministic prediction averages over multi-modal outcomes and blurs; sampling keeps them apart |
| **5. Score co-response** | `dot[u] = (1/R) Σ_r ⟨f^(r), E_disp^(r)[u]⟩`, threshold (Otsu) | Response *aligned with* the intervention, averaged over directions. Motion that appears regardless of the poke direction cancels; motion bound to the poke survives |
| **6. Recover the whole graph** | Motion descriptor `φ[u]` = the concatenation of all rollouts' flow at `u`; affinity `A[u,v] = φ[u]ᵀφ[v]`; cluster | Steps 1–5 give one group; this gives the **pairwise causal-binding matrix over all sites**, from which the full partition is clustered |

Steps 4 and 6 are what "statistical" means: the object is a property of the *ensemble* of imagined futures, not of any one of them.

### The step this procedure omits

The probabilistic-programming statement of counterfactual evaluation has **three** steps, and step 1 has no counterpart above (Goodman, Gerstenberg & Tenenbaum 2024, following Pearl 2000):

1. **Condition every random choice in the program on what actually happened** — recover the execution trace of the actual world.
2. **Intervene** mid-execution, breaking the normal control flow by setting a function's input to the counterfactual value.
3. **Re-evaluate everything downstream** of the intervention point.

Steps 2–3 are this page's steps 3–4. Step 1 is missing, and the difference is not cosmetic: **conditioning on the trace asks "what would have happened *in this world*", while clamping an unconditioned model asks "what happens in a typical world where the clamp holds".** The first is a counterfactual, the second is an interventional marginal. For segmentation the gap is small because the observation is fully given and the nuisance cause is neutralised by hand (step 2 of the table); for any domain with unobserved latents that persist — an agent's disposition, a hidden state, an object property already sampled — they come apart, and the probe answers the wrong question.

The precondition step 1 imposes is an **execution trace**, not merely a distribution: a monolithic `p(x)` records no steps, so there is nothing to condition and nothing to intervene on. That is a second, sharper argument for the generative-program form than compositionality — and it is the same requirement as this page's "addressable at a point", arrived at from the semantics rather than from the architecture.

---

## Three requirements, each with a measured failure when it is missed

| Requirement | Violated by | Cost |
|---|---|---|
| **The model must be addressable at a point** | Diffusion (dense global conditioning, iterative denoising); vision-language models (text as the control surface) | The counterfactual cannot be *stated*. Not a quality loss — a loss of the query itself |
| **The intervention must be in the right modality** | CWM, which copies an RGB patch to a new location in an otherwise masked target frame | The copied pixels mis-state how the region would look if it had truly moved (lighting, occlusion), so the model is asked an ill-posed question. Specifying the intervention as a *flow* vector says only "this moves this way" and leaves appearance to the model |
| **The response must be a distribution** | CWM again — regression-trained, hence deterministic | Where the true response is multi-modal (poke a hand: the hand moves alone, *or* the body translates), the conditional mean is neither. Measured: AR 0.327 → **0.541**, mIoU 0.481 → **0.681**, same probing logic, generative vs regression backbone |

**(brainstorm) The first row is the general lesson and the wiki has been ignoring it.** Every world model here is specified as (architecture, objective, data) — [[wiki/concepts/learned-world-models.md]] adds the behaviour policy as a fourth. This adds a fifth: the **conditioning interface**, which decides the set of counterfactual queries the model can be asked, independently of how good its predictions are. A model with a global-only interface can be arbitrarily accurate and still support no interventional query. Recorded as [[wiki/empirical-tensions.md]] T152.

---

## What it buys the framing

| Gain | Statement |
|---|---|
| **Discovery without labels** | The partition is a clustering of the model's own responses. Nothing about "object" is supplied — no slot, no count `K`, no mask, no category. This is the wiki's rare instrument that can return a structure the experimenter could not have written down, which is exactly what gap **G17** says probing cannot do |
| **Interventional data with no agent** | [[wiki/concepts/causal-model-building.md]] says causal fidelity is bought with causal data, and [[wiki/concepts/learned-world-models.md]] proves a passive learner identifies only the policy-averaged future. Probing sidesteps the trade: the interventions are performed *on the model*, so a passively-trained model can be asked active-agency questions — at the price that nothing checks the answers against the world |
| **Nodes and relations from one operation** | The same probe that groups pixels into an object returns the **support hierarchy** (poking the base of a stack returns everything it supports) and a **rigidity readout** (uniform `p_move` for rigid bodies, poke-localised for deformable ones). Node discovery and edge discovery are not separate procedures here |
| **The affinity matrix is the graph** | `A[u,v]` is a weighted adjacency over sites in *motion-response* space, and a segment is one thresholded row. [[wiki/concepts/latent-graph-discovery.md]]'s object is computed directly, rather than being estimated by fitting a transition function |

**(brainstorm) The exportable form.** Nothing in steps 1–6 is about vision. The recipe is: (i) train a generative model with a *pointwise addressable* conditioning interface on unlabeled observations of a system; (ii) clamp a variable and sample; (iii) build the pairwise response-correlation matrix; (iv) cluster. That is a causal-discovery algorithm whose interventions cost a forward pass, applicable wherever real intervention is expensive or impossible — the paper nominates time-lapse microscopy (intracellular structures) and galaxy dynamics (gravitationally bound systems), and the wiki should add every domain where its own gap **G45** (nothing can be *told* its latent structure) bites, since here the structure is neither told nor architecturally imposed.

---

## Open problems

- **Nothing validates the counterfactual.** The probe's output is scored against human segment annotations, i.e. against another observer's intuition about what would move. No intervention is ever executed, so a *systematic* error shared by the model and the annotators is undetectable. The missing experiment is cheap in a robotics lab and nobody ran it: poke the real object, compare the real flow to `E_disp`.
- **Where to intervene is unsolved, and it is the binding constraint.** Given a supplied point prompt the method beats a supervised segmenter; choosing its own prompts from `p_move` it loses (SpelkeBench AR 0.46 vs SAM2's 0.62). Gap **G60** — every architecture derives its query from the goal, none *chooses* it — appears here in a setting with no goal at all, and the selector is a threshold plus random sampling.
- **The cost is unreported and structural.** One segment = `R × T` full autoregressive rollouts of a 7B model; the affinity matrix = `N × R × T`. Whether this is affordable is unknown because no latency number is published, and by the G62 argument on [[wiki/concepts/learned-world-models.md]] an instrument's utility is a function of (accuracy, latency) jointly.
- **Distillation destroys the instrument.** The stated next step is to distil discovered segments into a feedforward segmenter. That buys speed and throws away the query language — the distilled model has one output and cannot be asked a different counterfactual. The general form of this trade is [[wiki/concepts/amortized-inference.md]]'s: compiling an inference procedure into a reactive map fixes which question it answers.
- **Only one intervention type has been tried.** Motion. The formalism admits any clamp the vocabulary can express (a colour, a depth, an occlusion, a removal), and the properties that would fall out of those probes — and whether they cohere into one scene model — is untouched.
- **No arbitration between contradictory probes.** Different poke points on the same scene yield different partitions (the auto-discovery loop resolves this by greedy removal of covered probe centres). Nothing says which partition is *right*, or licenses a hierarchy of nested groupings, which is what a scene with parts actually needs.

---

## Connections

- **[[wiki/concepts/linear-representation-hypothesis.md]]** — the alternative this page is the escape from: activation-side probing needs the feature vocabulary guessed correctly (Othello's 75% → 99.6% swing on relabelling alone), while an input-side intervention needs no vocabulary at all — at the cost of requiring a generative model addressable at a point.

- **[[wiki/entities/spelkenet.md]]** — the only instance, with every number: the architecture that makes step 3 expressible, the generative-vs-deterministic delta that makes step 4 mandatory, and the downstream evidence that the extracted partition is worth more than a supervised one.
- **[[wiki/concepts/representation-probing.md]]** — the complementary instrument and the sharper contrast in the wiki: probes read *activations* and require a named target, this reads the *output distribution* under an input intervention and requires none — so it is the second escape (after sparse dictionary learning) from that page's labels-are-the-answer circularity, and it meets that page's own intervention standard by construction.
- **[[wiki/concepts/causal-model-building.md]]** — the criterion this operationalises: group by response to intervention rather than by appearance. It also supplies a third source of causal data beyond that page's passive- and active-agency modes — interventions run inside the model, free of both an agent and a labelled generative trace.
- **[[wiki/concepts/learned-world-models.md]]** — the object being probed, and a fourth role for it: not a simulator, dynamics model or reward model, but a structure-extraction instrument. It also inherits that page's transition trichotomy — the deterministic/stochastic distinction decides whether the probe returns a sharp segment or a blur.
- **[[wiki/concepts/latent-graph-discovery.md]]** — computes the framing's object directly: the pairwise affinity matrix over probe responses *is* a weighted adjacency, obtained without fitting a transition function or naming a state space.
- **[[wiki/concepts/core-knowledge.md]]** — supplies the entry condition this method computes: cohesion under applied force is exactly the object system's admission test, and it is learned here rather than stipulated (gap G23).
- **[[wiki/concepts/event-segmentation.md]]** — the temporal sibling for gap G27: both carve a continuous signal into discrete units without labels, one by change in the active predictive-encoding set over time, the other by co-response to an imagined intervention across space.
- **[[wiki/concepts/affordance-grounded-symbols.md]]** — the same carving criterion executed in the world instead of imagined: effect-equivalence needs a body and recovers only distinctions the repertoire makes, this needs neither and validates against nothing.
- **[[wiki/concepts/language-of-thought.md]]** — the semantics this procedure is a truncation of: counterfactual evaluation there is abduction over the execution trace, then intervention, then re-execution, and the missing abduction step is what separates a counterfactual from an interventional marginal.
- **[[wiki/concepts/simulation-based-planning.md]]** — the same forward model, queried for structure rather than for value: a rollout scored by *what co-varies* rather than by *where it ends up*, which is a use of imagination the planning literature has no slot for.
- **[[wiki/concepts/amortized-inference.md]]** — names the cost of the proposed fix: distilling the probe's outputs into a feedforward segmenter is Mode-2 → Mode-1 compilation, and it fixes the question the model can answer.
- **[[wiki/concepts/attention.md]]** — supplies a candidate origin for the units attention selects among: object-based attention presupposes objects, and this produces them from a model trained on nothing but video.
- **[[wiki/entities/lewm.md]]** — the contrast that isolates what this method needs: the same family of latent world model, probed by comparing perturbed against unperturbed *real* trajectories rather than by injecting an intervention into the conditioning path, which needs no addressable interface and correspondingly returns a scalar surprise rather than a partition.
- **[[wiki/concepts/default-self-model.md]]** — the missing level as the missing counterfactual: adding a neutral-trait condition is what would identify whether the observed self-description effect is content processing or a valence-symmetric self-esteem bias.
- **[[wiki/entities/integrated-world-modeling-theory.md]]** — the framework that makes this page’s operation a *requirement* rather than an instrument: causal coherence is defined as the ability to run simulated interventions (an action-based implementation of the `do`-operator), so a model that cannot be queried off-policy fails the definition of a world model outright.
