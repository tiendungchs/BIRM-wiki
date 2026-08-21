# Fluxx — the card game where the rule set and the win condition are both plays

**A commercial card game whose entire state is a legible, face-up rule configuration that every player rewrites once per turn — including the goal — so the objective's expected lifetime is shorter than a plan's horizon and the only known general solver (an experienced human) loses track of the combined effect at roughly ten concurrent rules.**

> **Provenance.** Andrew Looney / Looney Labs, *Fluxx* rulebook (`raw/looneylabs-nd-fluxx-rules.md`; game invented 24 July 1996, rules text © 1997–2014). Secondary: Nick Smith 2015, *Review: Batman Fluxx*, ICv2 (`raw/smith-2015-batman-fluxx-review.md`) — a product review, so every observation drawn from it is marked `(tentative)`.

**Why it matters here.** [[wiki/entities/baba-is-ai.md]] put the rules of an environment on the table as editable objects, and its own limitations section names Fluxx and Nomic as the tier it does not reach. Fluxx supplies three things Baba does not: rewrites performed by **other agents**, an **objective that is itself a card**, and a rule-composition operator (`contradicts → discard`) whose predicate the designers could not specify and had to hand to an oracle. It is a game, not a benchmark — the wiki carries it as an **environment specification** for hardness source 6 of [[wiki/concepts/latent-graph-discovery.md]], not as a score.

---

## Mechanics

| Element | Content |
|---|---|
| Initial rules | One `Basic Rules` card, face up, permanent: start with 3 cards, **draw 1, play 1** |
| Card types | **Keeper** (played face up in front of you — the only durable private state) · **Goal** (played to the centre; playing one **discards the previous Goal**) · **New Rule** (played to the centre, effective immediately) · **Action** (execute the text, then discard) |
| Win check | **Continuous.** The instant your Keepers in play match the current Goal you win — *regardless of whose turn it is*. Ties: play continues until one winner emerges |
| Rewrite operator | Playing a New Rule. Rule conflicts resolve by **recency**: "when a New Rule contradicts a card already in play, the old rule is discarded" |
| Retroactivity | A rewrite applies to the **partially executed current turn**: play `Draw 3` after having drawn 1 and you immediately draw 2 more; play `Draw 2` after having drawn 3 and you draw none |
| Indexical scope | `Hand Limit` / `Keeper Limit` rules "only affect you when it's NOT your turn" — the rule's truth is indexed by whose turn it is |
| Forced play | **No voluntary discard.** You may only discard under a Limit. "Yes, this means you could end up being forced to play a card that makes someone else win" |
| Legality | "All cards are always playable, even if they have no effect" — legality is decoupled from utility, so the branching factor is the whole hand at every step |
| Recursion | One play can cascade: `Draw 2 and Use 'Em` → draw 2, play both → one of them is `Draw 3, Play 2 of Them` → … — the whole tree counts as **one** play |
| Card pool | Fixed deck; the discard pile is reshuffled into the draw pile when it empties, so the rewrite distribution is stationary and *countable* |
| Player set | Mutable mid-episode — jump in (deal 3), drop out (discard everything in play) |
| Authoring hooks | `Fluxx Blanxx`: 10 blank cards, including a blank New Rule, written by the players in permanent marker |

**The rule-config as a state vector.** What a New Rule can change is a short list of slots — draw count, play count, hand limit, keeper limit, plus optional free actions — and the Goal is one more slot with its own (larger) domain. So:

```
s' = (keepers_per_player, hand, discard, rule_config, goal)
rule_config ∈ ℤ⁴-ish × {optional bonus rules}        # face up, centre of table
goal        ∈ {goal cards in the deck}               # face up, exactly one live
```

Every clause gap **G7** requires for the lift is satisfied again, and more cheaply than in Baba Is AI: rule-config **factorises** into named slots, a rewrite is **sparse** (≤1 New Rule per play), the rule set is **legible** (face up, in English, in the centre), the vocabulary is **bounded** (the deck), and the machinery is **meta-stationary** (play-a-card, recency-override and the turn sequence are never edited by any card).

---

## What it adds beyond Baba Is AI

| Axis | [[wiki/entities/baba-is-ai.md]] | **Fluxx** |
|---|---|---|
| Who rewrites | The solver, and only the solver | **Every player** — most rewrites are exogenous and adversarial |
| Objective | A rule (`X is win`) the solver may edit; fixed within a level otherwise | **A card any opponent replaces**, with an expected lifetime the rulebook itself calls short |
| Activation predicate | Syntactic — three tiles horizontally aligned; **decidable from the observation** | Semantic — "contradicts a card already in play"; **not decidable from the rules**, adjudicated by an external FAQ database and by email rulings |
| Rewrite timing | Prospective: an edit governs subsequent steps | **Retroactive within the current step** — the transition function changes mid-transition |
| Rule scope | Global | **Indexed** — Limit rules bind only off-turn |
| Episode length | One plan, emitted once, never executed | Full adversarial episode, 5–30 minutes, `(tentative)` |
| No-op available | Yes (a plan may decline to edit) | **No** — forced draw and forced play; stalling is not in the action set |
| Concurrent live rules | 1–4 | **10–11 observed** `(tentative)` |
| Self-amendment | None (predicate fixed) | **None either** — the override rule and the turn machinery are not editable. That tier is [[wiki/entities/nomic.md]]'s, now in the wiki |

---

## The human datum

The only performance evidence in either source is anecdotal and comes from the review `(tentative)`:

- A group of **experienced gamers ended one game with ten rule modifications in play, down from eleven mid-game**, and "it is easy to make the rules in play so complicated that it can be hard to keep track of their combined effects".
- **One rule card, played early, created a victory condition that nobody noticed for several plays of the cards** — a live, face-up, English-language edge that every player looked at and none tracked.
- Themed sets add **blocker** rules: with the Joker in play nobody can win; with Joker *and* Harley Quinn held by one player and the `Mad Love` Goal live, that player wins. So the goal test is a conjunction over *global* board state, not over the winner's Keepers alone.

Read against G7 this is the sharpest available statement of the gap's residue: **legibility does not buy trackability.** Baba Is AI showed that a legible, bounded, meta-stationary rewriting domain defeats frontier models at 14.7–20.0%; Fluxx suggests the same conditions at ~10 concurrent rules defeat the reference system too. The conditions make the lifted space *well-posed*, not *small* — `|rule_config|` grows multiplicatively in the number of live slots whether or not each slot is legible ([[wiki/empirical-tensions.md]] T229).

---

## What it decides for a builder

**1 · Exogenous rewrite converts rule-config from a control variable into a filtering problem — with a countable generator.** When the solver owns every rewrite (Baba), `rule_config` is an action dimension and the task is search. When others rewrite it, `rule_config` is a partially controlled state with dynamics of its own, which is exactly the object [[wiki/concepts/contextual-inference.md]] and [[wiki/entities/coin-model.md]] reify: a context latent with Markov dynamics, inferred online. **(brainstorm)** Fluxx is the cleanest training environment the wiki has for pushing the *rewrite generator* into slow **W**, because the generator is a shuffled fixed deck: `p(next rewrite | cards already seen)` is a multinomial over a known pool with sampling-without-replacement corrections, estimable by counting and refreshed by the reshuffle. Nothing else in the wiki offers a hardness-6 domain whose rewrite distribution is both non-degenerate and exactly knowable.

**2 · A replaceable objective requires a value over goal-distributions, not a plan to a goal.** The rulebook states its own policy, and states the reason: given a Keeper and a Goal requiring it, **play the Keeper**, because "if you play the Goal, it will very likely be replaced by another long before you find the second Keeper". Formally, with `G_t` a Markov chain over goal cards, the value of a Keeper is its expected coverage of the goal distribution rather than its contribution to the current goal —

```
V(keeper k) ≈ E_{G ~ p(G_t+h)} [ 1(k ∈ G) · P(complete G | hand, board) ]
```

— so the correct behaviour is portfolio accumulation of goal-general state, and committing to the live objective is a *mistake* whenever the objective's half-life is shorter than the plan's horizon. That is a concrete, human-authored answer to the half of gap **G72** that survives after the objective is made visible: knowing what currently counts as success is not enough when success is rewritable, and the missing quantity is the objective's **hazard rate**. No architecture in the wiki carries one; every one of them treats the goal as fixed for the episode.

**3 · The conflict-resolution operator is the piece every rule-reification proposal is missing.** Gap **G8** wants rules as first-class nodes. The instant there are two rule-nodes, something must decide which is in force — and Fluxx shows the decision is not free: its answer is recency-override on a **semantic** contradiction test that the designers could not write down, so the game ships with a ruling database (`faq.looneylabs.com`) and an email address as the arbiter of last resort. This is a real design fork for a builder: **either keep the activation predicate syntactic and decidable** — Baba's tile alignment, where the board state *is* the rule state and no conflict can arise — **or accept an external arbiter** and price it. A reified-rule architecture with no override policy is under-specified in the same way.

**4 · Retroactive rewrites break the edit-then-evaluate pipeline.** `s' = (base_state, rule_config)` implicitly assumes a rewrite lands between transitions. Fluxx's rewrites land *inside* one: the turn is a multi-step procedure (draw *n*, play *m*, discard to limits) and a play in step 2 changes the parameters of step 1 with immediate retroactive settlement. Any planner over a lifted state needs a re-entry rule saying how a partially executed macro-step is reconciled with its new parameters — and the rulebook's is a monotone one worth copying: the counts are floors already satisfied, never debts (`Draw 2` after drawing 3 takes nothing back). **(brainstorm)** Monotone reconciliation is what keeps the retroactive case from requiring rollback machinery. The other branch of the fork is [[wiki/entities/nomic.md]]'s Rule 107, which voids a rule-change's own claim to apply retroactively and so removes the re-entry problem rather than reconciling it — at the price of a rule taking effect one step later than its author intends.

**5 · Indexical rules need an argument slot.** A Limit is not a proposition about the world; it is a proposition about *the agent, off-turn*. A rule-node whose truth depends on whose turn it is cannot be stored as a global edge annotation — it needs a bound variable. This is the cheap, non-social version of the perspective problem that [[wiki/entities/autotom.md]] pays for with nested mental variables.

**6 · Forced play removes the degenerate policy.** No voluntary discard and a mandatory play mean the action set is never empty and waiting is never available — including when the only legal play hands an opponent the win. **(brainstorm)** For an environment designer this is the cheapest known way to make a non-stationary domain non-trivial: without it, the optimal policy against exogenous rewriting is usually to do nothing and let the rule set drift into a favourable configuration, which measures patience rather than reasoning.

**7 · It does *not* test self-amendment.** No card edits the recency-override rule, the turn sequence or the win check. Fluxx is a two-tier domain with a very rich middle tier, not a three-tier one — gap **G9** is untouched, and `Fluxx Blanxx` (blank cards filled in by the players) is the only gesture at it, from outside the game rather than inside it. [[wiki/entities/nomic.md]] supplies the missing tier, and shows what it costs: making the override rule amendable means giving up the decidable conflict predicate for an ordinal priority order and an internal Judge, and giving up the countable rewrite generator entirely.

**8 · Supplies I23** to [[wiki/concepts/certification-instruments.md]] — the concurrent-rule-load ladder under exogenous rewrite `(brainstorm)`.

---

## Limitations as a wiki source

- **No measurements at all.** A rulebook and a 4-star product review. The "ten rules in play" figure is one group, one game, reported in passing; there is no baseline, no scoring, no protocol, and the wiki must not treat it as a capacity constant.
- **Not an implemented environment.** Unlike Baba Is AI there is no simulator, no action API and no evaluation harness — a builder wanting the exogenous-rewrite case has to write one. The card texts of the base deck are not in the source, only their types and the mechanics.
- **Multi-agent confounds the read-out.** Any measured failure mixes rule tracking with opponent modelling; the single-player variant (`LooneyLabs.com/solo-fluxx`, not in the source) would be the clean instrument and its rules are not carried here.
- **The interesting quantity is unstated.** Neither source gives the deck composition, so the multinomial in point 1 above is knowable in principle and not knowable from what has been ingested.

---

## Connections

- **[[wiki/entities/baba-is-ai.md]]** — the implemented half of the same idea: that benchmark makes the rules editable objects but lets only the solver edit them, keeps the activation predicate syntactic, and its own limitations section names this game as the tier it does not reach; this one adds exogenous rewrites, a replaceable objective and an undecidable conflict predicate, and gives up all measurement.
- **[[wiki/concepts/latent-graph-discovery.md]]** — a second domain meeting every tractability clause of hardness source 6, with the rewrite generator exactly countable (a fixed deck) and the human record suggesting that legibility buys well-posedness rather than trackability.
- **[[wiki/concepts/contextual-inference.md]]** — supplies the apparatus this domain needs and Baba does not: when others rewrite the rules, `rule_config` is a context latent with its own dynamics to be inferred online, not an action dimension to be searched.
- **[[wiki/entities/coin-model.md]]** — the concrete instance of that apparatus: a rule reified as a latent with Markov transitions, which is what a Fluxx player's belief over the live rule set would have to be.
- **[[wiki/concepts/certification-instruments.md]]** — supplies **I23**, the concurrent-rule-load ladder: hold the task fixed, vary the number of live legible rules (including inert ones), read accuracy against rule count, with an exogenous-rewrite arm.
- **[[wiki/concepts/simulation-based-planning.md]]** — the case that breaks a fixed transition model twice over: the model changes inside a step (retroactive settlement) and changes for reasons outside the planner's control (other players' plays), so a rollout must be indexed by rule-config *and* marginalised over the opponents' rewrites.
- **[[wiki/concepts/working-memory.md]]** — the reference system's failure mode: ten face-up, English-language rules exceed what experienced players combine correctly, so the limit on tracking a legible rule-config is capacity, not perception `(tentative)`.
- **[[wiki/concepts/problem-framing.md]]** — a domain where the frame is handed over completely (every rule is face up and in the instruction language) and the difficulty is entirely in maintaining it, which is the framing axis with perception and discovery removed.
- **[[wiki/concepts/objective-identifiability.md]]** — the objective is neither hidden nor stable: it is legible and *replaceable by an adversary*, so what must be inferred is not which objective is live but how long the live one will last.
- **[[wiki/concepts/temporal-abstraction-options.md]]** — the turn is a macro-action (draw *n*, play *m*, discard to limits) whose parameters can be rewritten during its own execution, which is the option-interruption case with the option's *parameters* rather than its policy changed mid-flight.
- **[[wiki/entities/nomic.md]]** — the tier above: same exogenous rewriting and replaceable objective, but there the conflict-precedence rule, the turn machinery and the amendment rules are themselves amendable, the semantic `contradicts` test is replaced by a decidable ordinal priority order with an internal Judge, retroactivity is prohibited outright, and the countable rewrite generator is given up for open natural-language proposals.
