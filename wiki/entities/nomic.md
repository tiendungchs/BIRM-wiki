# Nomic — the game whose rules for changing the rules are themselves a move

**A playable two-tier rule system in which every rule, including the rules that govern amendment, the conflict-precedence rule, the win condition and the rule that says players must obey the rules, is reachable by the amendment power — with mutability carried as a per-rule toggle rather than as a tower of levels, and with undecidability made a terminal, *winning* state rather than a failure.**

> **Provenance.** Peter Suber 1990, *Nomic: A Game of Self-Amendment*, Appendix 3 to *The Paradox of Self-Amendment* (`raw/suber-1990-nomic-self-amendment.md`). Earlier version in Hofstadter's *Scientific American* "Metamagical Themas", June 1982. A philosophy-of-law text plus a 29-rule initial set; **no measurements of any kind**, so every performance claim below is absent rather than weak.

**Why it matters here.** Both of the wiki's rule-rewriting domains name this game as the tier they do not reach. [[wiki/entities/baba-is-ai.md]] fixes the activation predicate (three tiles aligned) and lets only the solver rewrite; [[wiki/entities/fluxx.md]] adds exogenous rewrites and a replaceable goal but never lets a card edit the recency-override rule or the turn machinery. Nomic is gap **G9**'s missing specification: the rewrite machinery is inside the rewritable set. It arrives with a design that is more useful than the paradox — **the infinite tower of meta-levels is collapsed into two tiers plus a per-rule mutability bit**, and the residual problems (conflict precedence, arbitration, liveness, termination) are each answered by a named, implementable rule.

---

## The initial set as a specification

29 rules: **101–116 immutable**, **201–213 mutable**. What matters is not the list but which slots are filled.

| Slot | Rule | Content |
|---|---|---|
| Mutability as an attribute | 102, 103, 109 | Immutable/mutable is a **toggle on each rule**, not a rule's address. "Transmutation" flips it; transmutation requires **unanimity** and must be stated explicitly (never implied). Numbers 100s/200s are the *initial* assignment only |
| Amendment = 2 steps | 103, 109 | Amending an immutable rule is `transmute; amend` — one procedure for all rules, some needing a prior toggle. No graded difficulty ladder |
| Precedence | 110, 211 | Immutable **strictly dominates** mutable, and a conflicting mutable rule is *entirely void*. Within a tier: **lowest ordinal number wins**; a rule's own explicit self-declared deference/precedence supersedes the numeric method; **mutual** claims fall back to numeric. Fully decidable |
| Self-reference licence | 115 | "Even rule-changes that amend or repeal their own authority are permissible. No rule-change is impermissible **solely** on account of self-reference or self-application" |
| Liveness invariant | 114 | "There must always be at least one mutable rule. The adoption of rule-changes must never become completely impermissible" |
| Asymmetric default | 116 | Object level is **open-world** (whatever is not prohibited is permitted); the *rule-changing* power is **closed-world** — permitted only where a rule explicitly or implicitly permits it. Amendment power is never inferred from silence |
| No retroactivity | 107 | "No rule-change may take effect earlier than the moment of the completion of the vote that adopted it, **even if its wording explicitly states otherwise**" |
| Objective entrenchment | 112 | The *form* of winning — "achieving *n* points" — may not be altered. **`n` and the means of earning points may be** |
| Arbitration | 212 | Judgment is a rotating role (the player preceding the mover), invocable by any player's insistence, overruled only by unanimity of the others before the next turn, escalating backwards through the turn order. Explicit fallback chain: **rules → game-custom → spirit of the game → other standards**. No *stare decisis* (record-keeping cost), though it may be imposed or may emerge |
| Termination on undecidability | 213 | "If the rules are changed so that further play is impossible, or if the legality of a move cannot be determined with finality, or if a move appears **equally legal and illegal**, then the first player unable to complete a turn is the **winner**." Takes precedence over every other winning rule |
| Rule-config cap | 209 | At most **25 mutable rules** concurrently |
| Exit guarantee | 113 | A player may always forfeit rather than incur a penalty; no penalty worse than losing, **in the judgment of the player incurring it** |
| Scoring | 202, 208 | Mutable: die roll (face-to-face) or `(proposal_number − 291) × favourable_vote_fraction` (by mail), first to 100/200 points |
| Ratification | 104, 203–207 | Propose → debate → vote. Unanimity initially, **auto-degrading to simple majority** after the second complete circuit if not amended |

Two rules exist *only so that they can be amended*: **101** (players must obey the rules) and the zero-point start in 201. Suber records rejecting a correspondent's proposal to move 101 into a truly immutable shell — "he missed an essential point of the game. Rule 101 is included precisely so that it can be amended; if players amend or repeal it, they deserve what they get."

---

## What it decides for a builder

**1 · The third tier is a bit, not a level.** G9 asks for "a distinct rewrite-graph level" above the rewrite rules, and the regress is obvious — the rules for changing the rules for changing the rules, without end. Nomic's answer is to refuse the tower: `mutable ∈ {0,1}` is an attribute of every rule-node, and the only meta-operation is `transmute`, which flips it and is itself an ordinary rule-change gated by unanimity.

```
rule_node   = (id: ℕ, body, mutable: bool)
rule_change = enact | repeal | amend | transmute      # 103 — closed, 4 operators
precedence(r₁, r₂) = r₁.mutable < r₂.mutable          # 110: immutable dominates
                     else self_declared(r₁, r₂)       # 211¶2
                     else argmin id                   # 211¶1, total order
```

**(brainstorm)** This is the single most transferable thing in the source. A reified-rule architecture ([[wiki/concepts/latent-graph-discovery.md]]'s G8 reading) gets self-amendment for the price of one extra binary field per rule-node and one gate on the operator that writes it — no second rewrite-graph, no recursion depth, no separate meta-learner. The infinite hierarchy exists *implicitly*, because a rule-change can transmute the transmutation rule; it is never instantiated. Compare [[wiki/concepts/meta-optimized-plasticity.md]]'s self-referential meta-learning, which reaches the same expressiveness by letting the update rule modify all its own parameters and then has to restrict the search space to stay tractable: Nomic restricts by **arity** (four operators over discrete rule-nodes) instead of by search-space truncation.

**2 · Entrenchment is vacuous unless the mutability ordering equals the precedence ordering.** Suber's central argument, and it reads as a design theorem rather than a legal observation:

> "the two-tier system \[must\] also create a logical hierarchy in which the less mutable rules take logical priority over the more mutable rules. Otherwise the more mutable rules could by themselves undo basic patterns."

If rules that are hard to change do *not* win conflicts against rules that are easy to change, an adversary reaches the protected content through the cheap tier and the protection buys nothing. So a builder implementing protected invariants (safety constraints, an entrenched objective, a fixed observation vocabulary) must check **two** properties, not one: the invariant is expensive to edit, *and* it dominates in the conflict-resolution order. The wiki has been treating these as the same property. Rule 110's "entirely void" is the sharp form — a conflicting mutable rule is not overridden in the conflicting part, it is annihilated whole.

**3 · A decidable precedence operator exists, and it is ordinal.** Gap **G8** records that reified rules need a conflict-resolution policy and that the wiki's only worked answer was Fluxx's — recency-override on a *semantic* `contradicts` test its designers could not specify and offloaded to a public ruling database. Nomic supplies the alternative on the other side of the design fork: precedence is **priority by ordinal number**, plus a self-declaration escape hatch, plus a cycle-breaker for mutual claims. This is decidable, total, computed from metadata rather than from content, and it does not require detecting contradiction at all — the rules are *ranked in advance*, so the arbiter only has to notice that two rules bear on the same question, never which one is "more right".

| Conflict policy | Predicate needed | Decidable? | Cost |
|---|---|---|---|
| [[wiki/entities/baba-is-ai.md]] — tile alignment | none (board state *is* rule state; conflict impossible) | yes | rules cannot compose |
| [[wiki/entities/fluxx.md]] — recency override | semantic `contradicts(new, old)` | **no** — external FAQ + email arbiter | unbounded |
| **Nomic — ordinal priority** | `applies_to_same_question(r₁, r₂)`, then `argmin id` | yes, given the applicability test | a total order must be maintained across enactments (108: monotone integers from 301) |

The residue is honest: something still has to notice that two rules *bear on the same question*, which is where Nomic hands off to the Judge. But that predicate is strictly weaker than Fluxx's — "these two rules both speak to X" is a relevance test, not a contradiction test.

**4 · Undecidability needs a defined outcome, and making it terminal is cheaper than preventing it.** Rule 115 licenses self-reference outright; 213 then catches the fallout by declaring that when legality cannot be determined with finality — or a move is *equally legal and illegal* — the first player unable to complete a turn **wins**, and this outranks every other winning condition. Two consequences:

- The system pays for expressiveness with a **halt-and-assign** rule rather than with a syntactic prohibition on self-application. Any self-amending architecture will reach states where the applicable rule set cannot be resolved; the choice is to make that state undefined (crash), prohibited (and lose expressiveness, plus need a decision procedure for the prohibition, which is the same problem), or **terminal with a defined outcome**.
- Suber notes the resulting exploit deliberately: "a wily player \[may\] create a paradox, get it passed (if the rule seems innocent enough to the other players), and thereby win." So a terminal-outcome rule converts undecidability into an *optimisable objective*. **(brainstorm)** For an environment designer this is a feature — it is the only construction in the wiki that rewards an agent for reasoning about the decidability of its own rule set, and it would be a direct instrument for G9 if the reward sign were chosen deliberately rather than inherited.

**5 · Self-amendment breaks the state/reward decomposition, not just the transition function.** Rule 202 (how points are earned) and 208 (the winning threshold) are *mutable rules* — inside `rule_config`. And because a rule can be enacted that penalises "inept" play, Nomic dissolves what Suber calls the distinction between constitutive rules and rules of skill: "between lawful and artful play, between permissible and optimal action." The wiki's lift `s' = (base_state, rule_config)` silently assumes the reward function sits *outside* `rule_config`. Here it does not, and 112's entrenchment of the *form* of winning is precisely the minimum patch that keeps the game a game — the type signature of the objective is immutable while its parameters are not.

**6 · The bounded-hazard objective is the answer G72 was missing.** [[wiki/entities/fluxx.md]] showed that a fully legible objective is unusable when an adversary replaces it, and located the missing quantity as the objective's **hazard rate**. Nomic shows the design that bounds the hazard without freezing the goal: **entrench the objective's form, expose its parameters**. `win ⟺ score ≥ n` is immutable; `n` and the scoring map are mutable. An agent can therefore hold a stable *value template* — accumulate score — while the meaning of "score" drifts underneath it, and never has to re-infer what kind of thing success is. **(brainstorm)** This is a cheap and general recipe for non-stationary objectives that the wiki has nowhere else: make the goal's **type** the entrenched object and its **arguments** the mutable ones. It also composes with point 2 — 112 is immutable *and* dominates, so it is not reachable through the cheap tier.

**7 · A self-amending system needs an explicit liveness invariant.** Rule 114 states one: at least one mutable rule must always exist, and rule-change must never become completely impermissible. Without it, 116's closed-world default over the amendment power makes self-extinguishment reachable — repeal enough of 104/114/202–206 and nothing affirmatively permits amendment any more, so the system freezes into whatever configuration it last held. Suber leaves this as an open question rather than a theorem (below). For a builder: **a self-modifying learner needs a guarded non-extinguishment condition on its own capacity to modify**, and it should be in the dominant tier.

**8 · The asymmetric default is worth copying.** 116 gives the object level an open world (unprohibited ⇒ permitted) and the meta level a closed world (rule-change permitted only where explicitly or implicitly licensed). This is the opposite of how the wiki's environments are built, where the action set is enumerated and closed and rule-editing, when available at all, is just another action. **(brainstorm)** The asymmetry buys a safety property directly: an agent may improvise freely at the object level while every extension of its *own* rewrite power must be affirmatively licensed. That is a rule-level statement of the same intuition behind gating in [[wiki/concepts/cognitive-control.md]], applied to the write port rather than the read port.

**9 · Retroactivity is a design fork, and the two ingested sources take opposite sides.** Nomic bans it outright — 107 voids a rule's own claim to apply retroactively. Fluxx settles rewrites retroactively *inside* the current turn, monotonically (counts are floors already satisfied, never debts). Both are consistent; the fork is between **no re-entry problem at all** (107, at the price of a rule taking effect one step later than its author intends) and **monotone re-entry** (Fluxx, at the price of a reconciliation rule for every macro-step). A planner over a lifted state must pick one and state it; [[wiki/concepts/temporal-abstraction-options.md]] carries the option-interruption version.

**10 · The initial set has a stated design constraint that reads as a curriculum spec.** "Sufficiently short and simple to encourage play, but sufficiently long and complex to cover contingencies likely to arise before the players get around to providing for them" — and "a certain complexity to prevent any single rule-change from disrupting the continuity of the game." The second half is the load-bearing one: **no single rewrite may be able to destroy the episode**, which is a bound on the sensitivity of the environment to one action of the rewrite operator. Rule 209's cap of 25 concurrent mutable rules bounds the other end. Against the [[wiki/entities/fluxx.md]] anecdote of human tracking failing at 10–11 concurrent rules `(tentative)`, a 25-rule ceiling is roughly 2.5× the only human anchor the wiki has.

---

## Against the other two rewriting domains

| Axis | [[wiki/entities/baba-is-ai.md]] | [[wiki/entities/fluxx.md]] | **Nomic** |
|---|---|---|---|
| Who rewrites | solver only | every player | every player, **including the rewrite machinery** |
| Rewrite operators | `push` a tile | play a New Rule card | `enact / repeal / amend / transmute` (103) |
| Rewrite vocabulary | ~15 rules, closed | a fixed deck, closed and countable | **natural language, open** — a proposal is any writable text |
| Activation predicate | tile alignment; fixed | recency + semantic `contradicts`; fixed | ordinal priority + self-declaration; **itself amendable** |
| Meta-stationarity (G7 clause) | holds by construction | holds by construction | **violated by design** |
| Objective | a rule the solver may edit | a card any opponent replaces | mutable *parameters*, immutable **form** (112) |
| Reward inside rule-config | no | no | **yes** (202, 208) |
| Retroactive rewrites | no | yes, monotone | **prohibited** (107) |
| Undecidability | cannot arise | offloaded to an external FAQ/email arbiter | **terminal and winning** (213), plus an internal rotating Judge (212) |
| Concurrent rule cap | 1–4 live | 10–11 observed `(tentative)` | **25** by rule (209) |
| Implementation | yes, with a leaderboard | none | none |
| Measurements | 14.7–20.0% frontier | one anecdote | **none** |

**The clause it breaks.** G7's tractability conditions are *factorised, sparse, legible, bounded, meta-stationary*. Nomic satisfies sparsity (one rule-change per turn), legibility (all rules written, 106), and factorisation (discrete numbered rule-nodes). It **fails boundedness** — proposals are free text — and **fails meta-stationarity by construction**, which is the entire point. So it is the wiki's first domain that is deliberately outside the region where the `(base_state, rule_config)` lift is claimed to work, and the honest reading is that it is a *specification of the hard case*, not a benchmark anyone can run.

---

## The two open problems Suber states

He leaves both to players explicitly, and the wiki should carry them as open rather than resolved:

1. **Can any rule be made truly immutable while preserving some power to amend?** (An entrenchment that survives an amendment power reaching everything else.)
2. **Can the power to amend be completely and irrevocably repealed?** He notes that even after the enabling rules are gone, "a judge (if there were still judges) might find an 'inherent power' to amend before that too is extinguished."

**(brainstorm)** Read as questions about a self-modifying learner these are, respectively, *can a safety invariant be made unreachable by a system that can otherwise rewrite itself* and *can such a system durably disable its own capacity to change* — the two questions any G9 architecture will have to answer, posed here in 1990 with the amendment power made concrete enough to argue about.

---

## Limitations as a wiki source

- **No measurements, no implementation, no baseline.** A philosophy-of-law appendix. There is no simulator, no action API, no score, no human data, and nothing here can be cited as evidence about any system's capability.
- **The rewrite vocabulary is natural language, so there is no generator to learn.** [[wiki/concepts/latent-graph-discovery.md]] argues that a rewrite process with no compressible generator is unsolvable in principle for any learner. Nomic's generator is the players' proposals. Whatever makes real games tractable is not in the rules (see T230).
- **Suber's own warning against implementing it.** "It is very easy inadvertently to give the program decisions to make that are not actually clerical and that belong to the players, that is, to change Nomic without realizing it" — naming renumbering after amendment, computing scores and deciding who plays next as the deceptively simple cases, and concluding that "the programmer usurps the power of the game Judge if she simply chooses a reading of the rule." This generalises past this source: **every formalisation of an under-specified environment is a silent rule choice**, and the wiki's benchmark pages should read it as a caution about all hand-built environment code, not only this one.
- **The legal argument is analogy, not result.** The comparison of statutes/constitution to mutable/immutable tiers motivates the design; it does not license any claim about learning systems.
- **Multi-agent throughout.** Voting (104–105, 203, 207), the anti-collusion rule (210) and the rotating Judge (212) mean the amendment power is a *social* mechanism. A single-agent self-amending system inherits the operator design and none of the ratification apparatus, and what replaces unanimity is not stated anywhere.

---

## Connections

- **[[wiki/entities/baba-is-ai.md]]** — that benchmark's limitations section names this game as the third tier it does not reach: there the activation predicate is fixed and only the solver rewrites, here the predicate, the precedence rule and the amendment rules are all inside the rewritable set, at the cost of every measurement.
- **[[wiki/entities/fluxx.md]]** — the tier immediately below: same exogenous rewriting and replaceable objective, but the override rule and turn machinery are frozen there and amendable here; the two also take **opposite** sides on retroactivity (banned by Rule 107, monotone-retroactive in Fluxx) and on the conflict predicate (decidable ordinal priority vs. a semantic `contradicts` test handed to an external arbiter).
- **[[wiki/concepts/latent-graph-discovery.md]]** — the first domain in the wiki that deliberately violates hardness source 6's meta-stationarity clause, and the specification of what a third tier above the rewrite rules would have to contain — answered by a per-rule mutability bit rather than by an extra graph level.
- **[[wiki/concepts/meta-optimized-plasticity.md]]** — the rival route to the same expressiveness: self-referential meta-learning gets there by letting the update rule modify all its own parameters and must then truncate the search space, where this design restricts by operator arity (four rule-change operators over discrete rule-nodes) and keeps the tower implicit.
- **[[wiki/concepts/certification-instruments.md]]** — supplies **I24**, the transmutation-depth ladder: score a solver on how many tiers of entrenchment it must unwind before a target rule becomes editable `(brainstorm)`.
- **[[wiki/concepts/objective-identifiability.md]]** — the design that bounds an objective's hazard rate without freezing it: entrench the *form* of the win condition (Rule 112) and expose its parameters, so what must be re-inferred each episode is `n` and the scoring map rather than what kind of thing success is.
- **[[wiki/concepts/cognitive-control.md]]** — Rule 116's asymmetric default is gating applied to the write port: the object level is open-world while every extension of the system's own rewrite power must be affirmatively licensed.
- **[[wiki/concepts/temporal-abstraction-options.md]]** — takes the opposite branch from Fluxx on the option-interruption problem: Rule 107 forbids a rewrite from reaching into a partially executed step at all, which removes the re-entry problem instead of solving it monotonically.
- **[[wiki/concepts/contextual-inference.md]]** — the apparatus a player would need and the point at which it breaks: `rule_config` is a context latent with its own dynamics, but here the *transition kernel* of that latent is itself part of the latent, so there is no fixed generator to infer.
- **[[wiki/concepts/problem-framing.md]]** — the limit case of a handed-over frame that will not stay handed over: every rule is written down (Rule 106), and the rule determining which written rule governs is itself editable.
- **[[wiki/concepts/external-verification.md]]** — Rule 212 specifies the arbiter that Fluxx offloads to an email address: a rotating role, unanimity to overrule, and an explicit fallback chain (rules → game-custom → spirit of the game → other standards) for the cases the rules do not decide.
- **[[wiki/concepts/working-memory.md]]** — Rule 209 caps the live rule set at 25, roughly 2.5× the only human tracking anchor in the wiki (10–11 concurrent legible rules, `(tentative)`, from [[wiki/entities/fluxx.md]]).
