# Multi-Token Embedding — Minting an Entity From the Last Few Tokens

**The proposed job of the first 10–20% of a transformer's layers: recognise that the last few raw tokens name a *unit of analysis* (`| Michael| Jordan`), and write into the residual stream at the final token of that unit a representation of the **entity**, from which known attributes are recoverable as linear projections. It is a token embedding whose input is a short token *string* rather than a single token — the same object (a lookup table with structured outputs and no interpretable interior), one level up the compositional ladder.**

> **Provenance.** Nanda, Rajamanoharan, Kramár & Shah 2023, *Fact Finding: Attempting to Reverse-Engineer Factual Recall on the Neuron Level* (post 1, `raw/nanda-2023-fact-finding-1-factual-recall.md`) — the "main body" of the Google DeepMind mechanistic-interpretability team's five-post sequence, of which posts 3–5 are already ingested on [[wiki/concepts/memorisation-vs-generalisation.md]]. All measurements are Pythia 2.8B on one-shot prompts `"Fact: Michael Jordan plays the sport of"` over ~1,500 athletes in {baseball, basketball, (American) football}. Post 2, the detailed circuit analysis this page's stage table recaps, is not yet ingested; the stage boundaries here are carried second-hand from post 1's own summary.

---

## The three stages

| Stage | Site (Pythia 2.8B, 32 layers) | Operation | Load-bearing property |
|---|---|---|---|
| **Token concatenation** | Attention layers 0–1 | Copy the previous token's embedding onto the current token and **add** it — for a two-token name, the input to the next stage is literally `emb(" Michael") + emb(" Jordan")` | A sum, so it carries no conjunction: `Michael + Jordan` and `Michael + Smith` share half their content |
| **Fact lookup** | MLPs 2–6, on the final name token | Map the summed tokens to the multi-token embedding, in which sport is linearly recoverable | A Boolean AND must happen here, and nowhere else. **Depends only on the name, not on the prior context** |
| **Attribute extraction** | A sparse set of mid-to-late heads (L16H20 the largest) | Attend from `" of"` to `" Jordan"`, project out the sport subspace, write it to the output logits | Sparse and legible — standard circuit analysis works here |

Everything else in the effective model can be ablated: attention layers 2 onward, and MLP 1. The "end" of the model reduces to a 3-way logistic regression on the residual stream, at 86% accuracy — and the directions L16H20 maps to the three sport logits work as that classifier nearly as well as directions fitted by regression, so the model's own read-out and the experimenter's probe agree.

**The asymmetry that organises the whole result:** stage 1 is a sum, stage 3 is a sparse head, and both are readable in an afternoon. Stage 2 is ~50,000 neurons across five layers and resisted 6–7 full-time-equivalent months. The interpretable parts are the ones that move a representation; the opaque part is the one that *creates* it.

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
| **Superpose what is never co-active** | The interference argument above is a design rule for any shared substrate, and it is checkable before training from the task's co-activation statistics alone |

---

## Open problems

- **One task, one model, one attribute type.** Everything rests on athlete→sport in Pythia 2.8B. The generalisation to "recognise an entity and recall an attribute" is the authors' extrapolation, and the interesting cases (multi-hop, hierarchical, relational facts) are excluded by their own prediction.
- **Where the unit boundary comes from is untouched.** The circuit assembles the last two tokens because the name is two tokens. Nothing identifies *how many* recent tokens constitute the unit, or what happens at a three-token name, an ambiguous boundary, or a nested entity.
- **"No more structure to find" is unfalsifiable in the form given.** It is a stopping decision after 6–7 FTE months, and the authors say so.
- **The linear-attribute claim has no capacity statement.** If every attribute of every entity is a subspace of one residual stream, how many attributes fit before the projections stop separating? [[wiki/concepts/retrieval-capacity.md]] has the bound for explicit stores and nobody has computed it for this.
- **No causal test that the model *reads* the attribute subspace as such.** The probe direction and L16H20's logit direction agree, which is strong, but the reading site is not localised — the same limitation as every entry on [[wiki/concepts/linear-representation-hypothesis.md]].

---

## Connections

- **[[wiki/concepts/memorisation-vs-generalisation.md]]** — the same investigation's negative half, and the reason this page's stage 2 is a black box: the name→sport map has no macrofeatures, so no circuit description of the lookup exists to be found, and what remains sayable about those layers is exactly the input/output contract this page states.
- **[[wiki/concepts/node-definition-problem.md]]** — the standing complaint this circuit answers on the language side: a trained transformer decides what counts as one unit and emits its vector, so the vertex set is *learned from the token stream* rather than imposed by an atlas — and it inherits the same defect, since the unit boundary is discovered with nothing checking that it is the right one.
- **[[wiki/concepts/latent-graph-discovery.md]]** — supplies the missing first step for the symbolic slice: entity = node, attribute subspace = typed edge to a value, both produced by a feedforward pass over the last few tokens with no traversal and no transition data.
- **[[wiki/concepts/linear-representation-hypothesis.md]]** — the assumption this page's stage 3 depends on and stage 2 attacks: attributes are recovered by projection (linear), but the layers that produce them are the ones measured to destroy the residual stream's additive structure fastest.
- **[[wiki/concepts/representation-probing.md]]** — the instrument that carries the whole positive claim: "the sport is linearly represented after layer 6" *is* a probe result, and its smoothness across layers is what forecloses locating the lookup by probing.
- **[[wiki/concepts/vector-symbolic-binding.md]]** — the designed alternative, and the contrast is sharp: binding produces a compound that can be *unbound* back to its fillers, while this circuit deliberately destroys the recoverability of `Michael` and `Jordan` from `Michael Jordan` so that `Michael Duncan` inherits nothing (T287).
- **[[wiki/concepts/pattern-separation-completion.md]]** — the mechanism stage 2 is a machine instance of: the summed token embedding is a similarity-preserving input that must be scattered before it can be used as an address, which is hash-on-write with the measurement supplied on the memorisation page.
- **[[wiki/entities/transformer.md]]** — the substrate, and the source of the depth/locality gradient that makes "the first 10–20% of layers" a usable address for this stage at all.
- **[[wiki/concepts/retrieval-capacity.md]]** — the unasked question about this scheme: attributes-as-subspaces of one stream is a superposition with an interference budget, and the argument that facts are cheap to pack (never co-active) is a capacity claim with no number attached.
- **[[wiki/entities/vector-hash.md]]** — the same address-then-look-up factorisation built deliberately, with the capacity derived and the write available at inference; this page is what gradient descent produced when nobody specified either.
- **[[wiki/concepts/certification-instruments.md]]** — the methodological sibling: this page's central claim ("early MLPs produce multi-token embeddings") is offered by its own authors for red-teaming, and no instrument in the wiki currently scores whether a network has formed an entity representation as opposed to memorising a co-occurrence.
- **[[wiki/concepts/engram.md]]** — the biological read of the same operation: a sparse set of cells is recruited to stand for an episode and its attributes are recovered by reactivating them, which is entity-minting with allocation done by excitability rather than by a learned map.
