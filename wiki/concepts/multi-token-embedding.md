# Multi-Token Embedding — Minting an Entity From the Last Few Tokens

**The proposed job of the first 10–20% of a transformer's layers: recognise that the last few raw tokens name a *unit of analysis* (`| Michael| Jordan`), and write into the residual stream at the final token of that unit a representation of the **entity**, from which known attributes are recoverable as linear projections. It is a token embedding whose input is a short token *string* rather than a single token — the same object (a lookup table with structured outputs and no interpretable interior), one level up the compositional ladder.**

> **Provenance.** Nanda, Rajamanoharan, Kramár & Shah 2023, *Fact Finding: Attempting to Reverse-Engineer Factual Recall on the Neuron Level* (post 1, `raw/nanda-2023-fact-finding-1-factual-recall.md`) — the "main body" of the Google DeepMind mechanistic-interpretability team's five-post sequence, of which posts 3–5 are already ingested on [[wiki/concepts/memorisation-vs-generalisation.md]]. All measurements are Pythia 2.8B on one-shot prompts `"Fact: Michael Jordan plays the sport of"` over ~1,500 athletes in {baseball, basketball, (American) football}, filtered to those the model already answers with >50% probability. **Post 2** (Rajamanoharan, Nanda, Kramár & Shah 2023, `raw/rajamanoharan-2023-fact-finding-2-circuit.md`) is the causal derivation of the stage boundaries this page asserts — path patching, mean ablation and a stepwise simplification ladder with faithfulness measured at every rung — and supplies the sections below marked to it.

---

## The three stages

| Stage | Site (Pythia 2.8B, 32 layers) | Operation | Load-bearing property |
|---|---|---|---|
| **Token concatenation** | Attention layers 0–1 | Copy the previous token's embedding onto the current token and **add** it — for a two-token name, the input to the next stage is literally `emb(" Michael") + emb(" Jordan")` | A sum, so it carries no conjunction: `Michael + Jordan` and `Michael + Smith` share half their content |
| **Fact lookup** | MLPs 2–6, on the final name token | Map the summed tokens to the multi-token embedding, in which sport is linearly recoverable | A Boolean AND must happen here, and nowhere else. **Depends only on the name, not on the prior context** |
| **Attribute extraction** | A sparse set of mid-to-late heads (L16H20 the largest) | Attend from `" of"` to `" Jordan"`, project out the sport subspace, write it to the output logits | Sparse and legible — standard circuit analysis works here |

Everything else in the effective model can be ablated: attention layers 2 onward, and MLP 1. The "end" of the model reduces to a 3-way logistic regression on the residual stream, at 86% accuracy — and the directions L16H20 maps to the three sport logits work as that classifier nearly as well as directions fitted by regression, so the model's own read-out and the experimenter's probe agree.

**The asymmetry that organises the whole result:** stage 1 is a sum, stage 3 is a sparse head, and both are readable in an afternoon. Stage 2 is ~50,000 neurons across five layers and resisted 6–7 full-time-equivalent months. The interpretable parts are the ones that move a representation; the opaque part is the one that *creates* it.

### What post 2 establishes about each boundary

| Boundary | Evidence (all causal, all Pythia 2.8B) |
|---|---|
| **Stages are sequential, not interleaved** | The two candidate pictures — attention pulling in name tokens *as the lookup needs them*, versus all mixing finishing first — are separated by mean-ablating attention output from layer 2 onward. Cost: slight. Total-effect patching agrees: many more heads matter at layers 0–1 than after. So `lookup` is a **pure MLP stack with skip connections**, and token mixing is finished before feature computation starts |
| **Stage 1 is two embeddings plus movement, nothing else** | MLP 1 at the final name token is ablatable (low total effect on logit difference, little accuracy cost). Pythia uses **parallel attention**, which makes MLP 0 effectively a *second* token-embedding table. What remains is: embed twice, run attention layers 0 and 1, read the final name token |
| **For two-token names, stage 1 is literally a sum of position-tagged embeddings** | Freeze every attention pattern at its dataset average (and block layer-1 self-attention at the last name token) and `concatenate_tokens` collapses to `embed_first(t₁) + embed_last(t₂) + bias`, where the bias comes from `<bos>`. `embed_first` and `embed_last` are lookup tables over the whole vocabulary with **disjoint ranges** — that disjointness is the only thing distinguishing "Duncan" the given name from "Duncan" the surname. Freezing costs little beyond the MLP-1 ablation already taken |
| **The lookup is context-free** | Feeding `"<bos> <first> <last>"` with no one-shot prefix and no sentence around it costs only a little accuracy. The prefix's job is stage 3's (tell the model the answer is a sport), not stage 2's |
| **Lookup is essentially done by layer 6** | The same probe applied at every layer: ~90% by layer 6, plateau by ~8, and MLPs 8/11/13 have high path-specific effect on L16H20's value input while adding no probe accuracy — they **boost an existing direction** rather than compute one |
| **Stage 3 is a linear map, because the attention pattern is input-independent** | The high-effect heads attend from the final token to the final name token (or fall back to `<bos>`/`"\n"` resting positions) regardless of which athlete. A head whose pattern does not vary is just its OV matrix |

**One head, two jobs — worth generalising.** L16H20 dominates stage 3 through two mechanisms that a single ablation would conflate: (i) attending from the final token back to the final name token, moving the sport into the output stream via OV ∘ unembed; and (ii) attending from the final name token **to itself**, producing an output that feeds the *value inputs* of the next five most important heads by V-composition. Its own value input comes mostly from the MLPs below it at that position. So the sparse extraction stage is not five parallel readers — it is one reader plus four amplifiers of it.

`(brainstorm)` Stage 3 is also **per-value specialised**, which the "one linear classifier" summary hides: L19H24 is consistently important only for baseball athletes, L22H17 only for basketball and some baseball. A three-class read-out implemented as class-specific heads is a different object from a three-column weight matrix — it predicts that a new attribute value needs a new head rather than a new column, and nobody has tested what happens when one is required.

---

## The effective model: a simplification ladder with faithfulness measured at every rung

Post 2's transferable product is not the circuit but the **method of arriving at one**: replace a component with the simplest thing that could stand in for it, re-run the task end to end, and report the accuracy you paid. The final object — the *effective model* — is what survives.

| Rung | What is replaced | Task accuracy |
|---|---|---|
| 0 | Nothing (the filtered dataset is chosen so the model is right) | 100% |
| 1 | Everything from layer 16 at the final name token onward → a 3-class **mechanistic probe** (OV of L16H20 ∘ unembed of `" baseball"/" basketball"/" football"`, mean-centred input) | **98%** |
| 2 | + read the probe at layer 6 instead of 16, full prompt intact | ~90% |
| 3 | + delete all context before the name, + mean-ablate attention from layer 2 on, deep `lookup` | **94%** |
| 4 | + stop `lookup` at layer 6 | 85% |
| 5 | (two-token names) + ablate MLP 1, + freeze all attention patterns at their dataset means → stage 1 is a literal sum of two lookup tables | small further cost |

Three properties of this ladder are worth copying:

- **Accuracy, not loss, is the reported metric — deliberately.** Loss-recovered is the field's default and would have credited the signal-boosting heads of layers 17+ with work they do not do: boosting improves loss without changing the argmax. When the question is "how is the *answer* produced", the argmax metric is the one that isolates it.
- **The rungs compose sub-additively but are reported jointly.** Each approximation is cheap alone; the combined cost (rung 3 vs the two halves) is measured rather than assumed, which is the step most ablation studies skip.
- **The ladder terminates in an object you can hold.** Two lookup tables → a sum → a 5-layer MLP → a linear classifier. Everything the model does on this task other than the middle box is now written down; the residue is exactly the part the sequence's later posts prove is not writable ([[wiki/concepts/memorisation-vs-generalisation.md]]).

---

## What the hypothesis claims, and how strongly

| Claim | Status in the source |
|---|---|
| Early layers assemble a representation of a multi-token entity at its last token | **Asserted with the athlete circuit as evidence**, plus prior work (Geva et al. 2023, Meng et al. 2022) |
| Attributes of that entity are **linear subspaces** of it | Measured for sport; probes for other Michael Jordan facts also succeed |
| The entity representation contains *every* fact the model knows about the entity, written at once | Weakened by post 3: ablating a neuron affects one fact and not another (near-zero cross-fact correlation), so a given neuron emits a **subset** of an entity's facts |
| The internal mechanism has no more interpretable structure to find | **Best guess, explicitly not ruled out.** The team stopped; they estimate remaining structure is unlikely, not absent |
| The pattern extends beyond simple attribute recall | **Explicitly disclaimed.** Multi-hop reasoning and hierarchically structured facts are predicted *not* to look like this, and were not tested |

---

## Why "embedding" is the right word, and where the analogy breaks

| | Token embedding | Multi-token embedding |
|---|---|---|
| Input space | `d_vocab` ≈ 50,000 | All token strings — combinatorially larger, and only tractable because attention has already restricted the read to the last few tokens |
| Output | A vector with interpretable structure (`has_space`, sentiment, …) | A vector with interpretable structure (attribute subspaces) |
| Interior | A literal lookup table; nobody asks to interpret it | Five MLP layers that *behave* like a lookup table; the source's argument is that asking to interpret it is the same category error |
| Novel input | Every token in the vocabulary has an entry | The hash works on any token combination; **the lookup does not** — unknown names get a separated representation with nothing behind it |

The last row is the operational content of the analogy. `emb` is total over its domain; the multi-token version is a *partial* function whose domain is the set of entities seen in training, with a well-defined address computed for every input and a value only where one was written.

---

## Circuits vs representations, and the strategic claim

The source's recommendation is a deliberate retreat, and it is the part with consequences beyond factual recall:

- **Features** are properties of the input represented in activations; **circuits** are the algorithms in the weights that compute them. A circuit account is stronger and normally required.
- For factual recall the team recommends **abandoning the circuit account of stage 2** and treating MLPs 2–6 as a black-boxed submodule, on the grounds that (i) the residual stream there is nearly context-independent, so fact injection is the *only* thing those layers can be doing in this setting, and (ii) the interesting downstream computation happens in mid-to-late layers, which consume the representation without caring how it was made.
- Consequence they accept: this is a **downwards update on fully reverse-engineering a model**. Their revised target is "reverse-engineer as much as we can, zoom in on crucial areas, leave many circuits as blackboxed submodules."

**Sparse autoencoders do not close this gap, and the reason is precise.** An SAE decomposes a *representation* into monosemantic features. The circuit question is how the MLP *parameters* implement the map. If the meaningful features are not basis-aligned (pre- and post-nonlinearity), then understanding the layer's function requires understanding **every** neuron in it, because each output feature is a sum over all of them; if a feature is basis-aligned, it is one neuron and one GELU, and the rest of the layer is irrelevant. Superposition is exactly the failure of basis alignment, so an SAE tells you *what is there* while leaving the `O(n_neurons)` bill for *how it got there* untouched. What SAEs could still supply here is negative evidence — a sharp layer at which "sport" first becomes a feature would localise the lookup — but the probe curve is smooth (already ~50% from summed token embeddings alone, rising through MLPs 2–6), so no sharp transition is expected to exist.

---

## Why facts are the maximally superposed case

The task was chosen, not stumbled on, and the selection argument is reusable for anyone deciding what a network will compress:

| Property of factual recall | Consequence |
|---|---|
| There is **always another fact to learn** — unlike an algorithmic task (indirect object identification) which is learned once and finished | Persistent pressure to compress, so superposition is expected rather than incidental |
| Facts about different entities **never need to be active at the same token** — "Michael Jordan plays basketball" and "Babe Ruth plays baseball" are never required jointly | Interference between them is nearly free, which is the precondition for packing many features into few dimensions |
| Names collide across entities (`Adam Smith` / `Adam Driver` / `Will Smith`) | The fact cannot live in the token embeddings; a detokenization step is forced |
| `(brainstorm, the source's own speculation)` A model's fact count plausibly scales **superlinearly** in its neuron count | Superposition may be a large part of *why scaling works*, which would make it a capability mechanism rather than an interpretability nuisance |

The third row is the general principle: **superposition is cheap exactly where features are mutually exclusive in time.** A designer choosing what to pack into a shared substrate should be asking about co-activation, not about count.

---

## Applying it to build a reasoning model

| Consequence | Detail |
|---|---|
| **This is node-minting, performed by a trained network** | [[wiki/concepts/latent-graph-discovery.md]] assumes experience arrives discretised into nodes; [[wiki/concepts/node-definition-problem.md]] is the standing complaint that nothing decides the unit. A transformer solves the language-side instance by learning where the unit boundary is and writing the unit's vector at its last token — and does it locally, before any long-range machinery runs. The entity is the node; the attribute subspaces are its typed outgoing edges |
| **Attributes as subspaces make a lookup addressable without a key vocabulary** | Once `v_sport` exists, any downstream consumer reads one projection. No unbinding operator, no query key, no attention over a store — the read is `O(d)` and is what the mid-to-late heads actually do |
| **Design so that the opaque stage is bounded** | The practical form of the retreat: build architectures where the un-interpretable part is a *named submodule with a typed output*, so that everything upstream and downstream stays analysable. This is the same discipline as [[wiki/concepts/memorisation-vs-generalisation.md]]'s output-side/input-side asymmetry, stated as an architectural constraint instead of an empirical finding |
| **Context-independence is a bug to design out** | "The lookup depends only on the name, not the prior context" is efficient and wrong for a reasoner: `Michael Jordan` the actor, or a name introduced in-context two paragraphs earlier, needs the *same* stage to be context-sensitive. Nothing in this circuit can do that, and post 5's locality measurement says early layers are only *softly* local, so the machinery to fix it is present but unused ([[wiki/entities/transformer.md]]) |
| **Novel entities get an address and no entry** | The hash is total, the table is partial. A system that could **write** at inference into the slot the hash addresses would turn this circuit into an episodic store — which is precisely what the wiki's explicit-memory entities do with a hand-built addressing scheme ([[wiki/entities/vector-hash.md]], [[wiki/entities/sparse-distributed-memory.md]]). Gap `G69` |
| **Bind first, then compute — the schedule is separable** | Post 2's ablation says gathering and lookup are *sequential*: all cross-token movement finishes by layer 2, after which the entity is computed by a feedforward stack that needs no further access to the other tokens. A designer can therefore split the two into distinct modules with a typed interface (`gather → vector`, `vector → entity`) without losing what the transformer achieves, which is what makes the "bounded opaque stage" row above implementable rather than aspirational. The cost is the same context-blindness: whatever the gather stage missed is unrecoverable downstream |
| **Simplify against a measured faithfulness curve, not against intuition** | The ladder above is a reusable acceptance protocol for any claim that a module does job `X`: substitute the simplest object that could do `X`, re-run end to end, report the loss in *task* terms. It is the discipline [[wiki/concepts/representation-probing.md]] says correlational probes lack, applied at module granularity |
| **Superpose what is never co-active** | The interference argument above is a design rule for any shared substrate, and it is checkable before training from the task's co-activation statistics alone |

---

## Open problems

- **One task, one model, one attribute type.** Everything rests on athlete→sport in Pythia 2.8B. The generalisation to "recognise an entity and recall an attribute" is the authors' extrapolation, and the interesting cases (multi-hop, hierarchical, relational facts) are excluded by their own prediction.
- **Where the unit boundary comes from is untouched.** The circuit assembles the last two tokens because the name is two tokens. Nothing identifies *how many* recent tokens constitute the unit, or what happens at a three-token name, an ambiguous boundary, or a nested entity.
- **"No more structure to find" is unfalsifiable in the form given.** It is a stopping decision after 6–7 FTE months, and the authors say so.
- **The linear-attribute claim has no capacity statement.** If every attribute of every entity is a subspace of one residual stream, how many attributes fit before the projections stop separating? [[wiki/concepts/retrieval-capacity.md]] has the bound for explicit stores and nobody has computed it for this.
- **The circuit is derived on a dataset selected for the model being right.** The ~1,500 athletes are those on which Pythia already places >50% probability on the correct sport, filtered down from several thousand. The authors name the bias themselves: athletes the model does not know but guesses correctly are kept. Every faithfulness number on the ladder is therefore conditioned on successful recall, and nothing here describes what the circuit does when the lookup misses.
- **Two accuracies for the same mechanistic probe, 86% and 98%, appear in the same sequence** — post 1's summary gives the L16H20-derived classifier 86%, post 2's rung 1 gives 98% for replacing the model from layer 16 on with it. The setups differ (probe site, mean-centring, which downstream heads remain), and the source does not reconcile them. Anyone reusing the "read a probe off the weights" method should treat the gap as the method's sensitivity to unstated choices rather than as noise.
- **The literal-sum simplification is validated only on two-token names.** For three or more tokens the authors conjecture a similar position-dependent sum and did not test it — and the unit-boundary problem above is precisely what gets harder there.
- **No causal test that the model *reads* the attribute subspace as such.** The probe direction and L16H20's logit direction agree, which is strong, but the reading site is not localised — the same limitation as every entry on [[wiki/concepts/linear-representation-hypothesis.md]].

---

## Connections

- **[[wiki/concepts/memorisation-vs-generalisation.md]]** — the same investigation's negative half, and the reason this page's stage 2 is a black box: the name→sport map has no macrofeatures, so no circuit description of the lookup exists to be found, and what remains sayable about those layers is exactly the input/output contract this page states.
- **[[wiki/concepts/node-definition-problem.md]]** — the standing complaint this circuit answers on the language side: a trained transformer decides what counts as one unit and emits its vector, so the vertex set is *learned from the token stream* rather than imposed by an atlas — and it inherits the same defect, since the unit boundary is discovered with nothing checking that it is the right one.
- **[[wiki/concepts/latent-graph-discovery.md]]** — supplies the missing first step for the symbolic slice: entity = node, attribute subspace = typed edge to a value, both produced by a feedforward pass over the last few tokens with no traversal and no transition data.
- **[[wiki/concepts/linear-representation-hypothesis.md]]** — the assumption this page's stage 3 depends on and stage 2 attacks: attributes are recovered by projection (linear), but the layers that produce them are the ones measured to destroy the residual stream's additive structure fastest.
- **[[wiki/concepts/representation-probing.md]]** — the instrument that carries the whole positive claim: "the sport is linearly represented after layer 6" *is* a probe result, and its smoothness across layers is what forecloses locating the lookup by probing. Post 2 also contributes two instruments back to that page — the **mechanistic probe** (composed from L16H20's OV matrix and the unembedding, so it is fitted to nothing and cannot overfit) and **path patching along a single OV route**, which is how V-composition between the extraction heads was resolved.
- **[[wiki/entities/transformer.md]]** *(second edge, on the schedule rather than the depth gradient)* — the ablation that says attention output from layer 2 onward is unnecessary for this task turns `lookup` into a pure feedforward stack, so the architecture's all-to-all reach is spent here on a fixed two-layer gather and nothing else.
- **[[wiki/concepts/vector-symbolic-binding.md]]** — the designed alternative, and the contrast is sharp: binding produces a compound that can be *unbound* back to its fillers, while this circuit deliberately destroys the recoverability of `Michael` and `Jordan` from `Michael Jordan` so that `Michael Duncan` inherits nothing (T287).
- **[[wiki/concepts/pattern-separation-completion.md]]** — the mechanism stage 2 is a machine instance of: the summed token embedding is a similarity-preserving input that must be scattered before it can be used as an address, which is hash-on-write with the measurement supplied on the memorisation page.
- **[[wiki/entities/transformer.md]]** — the substrate, and the source of the depth/locality gradient that makes "the first 10–20% of layers" a usable address for this stage at all.
- **[[wiki/concepts/retrieval-capacity.md]]** — the unasked question about this scheme: attributes-as-subspaces of one stream is a superposition with an interference budget, and the argument that facts are cheap to pack (never co-active) is a capacity claim with no number attached.
- **[[wiki/entities/vector-hash.md]]** — the same address-then-look-up factorisation built deliberately, with the capacity derived and the write available at inference; this page is what gradient descent produced when nobody specified either.
- **[[wiki/concepts/certification-instruments.md]]** — the methodological sibling: this page's central claim ("early MLPs produce multi-token embeddings") is offered by its own authors for red-teaming, and no instrument in the wiki currently scores whether a network has formed an entity representation as opposed to memorising a co-occurrence.
- **[[wiki/concepts/engram.md]]** — the biological read of the same operation: a sparse set of cells is recruited to stand for an episode and its attributes are recovered by reactivating them, which is entity-minting with allocation done by excitability rather than by a learned map.
