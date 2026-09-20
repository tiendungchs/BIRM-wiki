# Token Reinforcement — a Subgoal Currency That Is Earned, Held, Counted and Cashed Out Separately

**A token is a manufactured reinforcer with an inventory. Because it is earned on one schedule, becomes spendable on a second and is redeemed on a third, the single scalar an artificial agent pays itself splits into three independently-manipulable contingencies — and the behavioural result is that choice is governed by the *cash-out* schedule, not by the schedule that produces the token. Everything a machine intrinsic reward does at the instant it is generated, biology does across a held balance.**

> **Provenance.** Hackenberg 2009, *Token reinforcement: a review and analysis*, Journal of the Experimental Analysis of Behavior 91(2):257–286 (`raw/hackenberg-2009-token-reinforcement-review-and-analysis.md`). A review of the laboratory literature — chimpanzees (Wolfe 1936, Cowles 1937, Kelleher 1956/1958), rats (Malagodi 1967a–c, Waddell et al. 1972, Webbe & Malagodi 1978, Malagodi et al. 1975), pigeons (Foster et al. 2001, Foster & Hackenberg 2004, Jackson & Hackenberg 1996, Bullock & Hackenberg 2006, Pietras & Hackenberg 2005, Raiff et al. 2008, Yankelevitz et al. 2008), humans (Logue et al. 1986, Hyten et al. 1994, Critchfield et al. 2003, Rasmussen & Newland 2008, Magoon & Critchfield 2008) and capuchins/chimpanzees on framing (Chen et al. 2006, Brosnan et al. 2007). No new data; every result is cited there to its original.

Why this earns a page rather than a section on [[wiki/concepts/conditioned-reinforcement.md]]. That page establishes that a pairing manufactures a want and measures what the want is worth. This source takes the same manufactured want and gives it **an inventory and a redemption contingency**, which is the structure every hierarchical learner's intrinsic reward lacks: `r̃` is produced and consumed in the same step. Splitting the one event into production, exchange-production and exchange makes three separately-measurable prices out of what the wiki carries as one number (`G127`), and makes the "agent pays itself" failure (`T367`) a schedule property rather than a constant.

---

## The three-schedule decomposition

| Component | Contingency | Economic analogue | Controls |
|---|---|---|---|
| **Token-production schedule** | responses → one token | wage | rate and patterning of work; FR/VI signatures identical to food schedules |
| **Exchange-production schedule** | tokens → an exchange *opportunity* | procurement cost (getting to the store) | pausing, accumulation, and — with the other two held constant — choice |
| **Token-exchange schedule** | tokens → primary reinforcer during the exchange period | selling price | terminal-link rate; the later link dominates |

A token has **no intrinsic value**; every function it holds is conferred by its relations to other reinforcers, and it can hold several at once (reinforcing, discriminative, eliciting, and — on loss — punishing).

## What each schedule does, measured

| Manipulation | Result | Reading |
|---|---|---|
| FR / FI / VI **token production** (Kelleher 1956, 1958; Malagodi 1967a–c; Bullock & Hackenberg 2006) | break-run under FR, steady moderate rate under VI, rate falls with FR size; break-run survives into extinction | schedule control over a *conditioned* reinforcer is indistinguishable in form from schedule control over food |
| FR vs VR **exchange production** (Webbe & Malagodi 1978; Foster et al. 2001) | rates higher and pauses shorter under VR; rate more sensitive to ratio size under FR | the schedule signature reappears **one level up**, with the whole token-production run as the unit |
| FI **exchange production**, 1.5–9 min (Waddell et al. 1972) | token-production *units* scallop across the exchange cycle; quarter-life rises with FI | the FI pattern is expressed in units of completed ratios, not responses |
| **Token-exchange** ratio (Malagodi et al. 1975 — the only study that manipulated it) | initial-link rates ordered inversely with exchange FR; rates rise approaching the terminal link | later links in the chain exert disproportionate control |

**The synthesis the source draws, and the one a builder wants:** a token schedule is a **second-order schedule** — a pattern generated under the first-order (token-production) schedule is itself treated as a single response, reinforced by the second-order (exchange-production) schedule. The evidence is that the *same* functional forms (FR pausing, VR smoothness, FI scalloping, ratio-size sensitivity) hold at both levels. This is the wiki's only empirical demonstration that the control law is **scale-free across a hierarchy level** — the upper level is not a different mechanism, it is the same schedule algebra applied to compiled units.

Token schedules differ from ordinary chained and second-order schedules in four ways the source enumerates: the added stimuli are **arrayed continuously** (a visible balance, not a transient cue); each token is individually paired with food at exchange; the number of tokens is correlated with **amount available**, not only with proximity; and the whole arrangement is procedurally identical to point/money systems used with humans, so it is a cross-species common method.

---

## Choice is governed by the exchange delay, not the token delay

The sharpest result in the source, and the one with the most direct machine consequence.

| Study | Design | Result |
|---|---|---|
| Logue et al. 1986; Flora & Pavlik 1992 (humans, points) | smaller-sooner vs larger-later **tokens**; exchange held at end of session | self-control (prefers larger-later) — the standard "humans are self-controlled" finding |
| Hyten et al. 1994 (humans) | exchange delays equal vs unequal-and-shorter for the small option | self-control only when **exchange** delays are equal |
| Jackson & Hackenberg 1996 (pigeons, light tokens) | 1 token now vs 3 tokens after a delay; exchange delays equal (ED) or unequal (UD) | **all 3 pigeons**: larger-later under ED, smaller-sooner under UD — preference reverses with the token contingency untouched |
| Hackenberg & Vaidya 2003 | exchange delays and terminal-food delays manipulated separately | disproportionate control by the *later* delays |

**The token's own delay does not select the action.** Under the equal-exchange arrangement the pigeon looks "human" (self-controlled); under the unequal arrangement the human looks "animal" (impulsive). The species difference that a large literature treats as cognitive is, in this dataset, a **procedural** difference in where the cash-out sits.

Three consequences for a builder:

1. An intrinsic-reward agent that credits `r̃` at subgoal completion has silently chosen the UD arrangement — the pay-out is immediate and unequal across options — which is the arrangement that produces impulsive, subgoal-captured behaviour. The ED arrangement (token now, redemption at a fixed common time) is a one-line change and predicts the opposite policy. Nothing in the wiki has the choice available, because nothing separates earning from spending (`G127`).
2. `T367`'s worry — an agent preferring its own subgoal payment to the goal — is **a tunable schedule property**, not an inherent defect of self-payment.
3. The measured quantity that controls behaviour is *time to the redemption event*, which is neither the option's termination time nor the episode return.

---

## Accumulation: a held balance makes batching a decision

Yankelevitz, Bullock & Hackenberg 2008 arranged the token-production and exchange-production keys **concurrently** after the first token, so every moment offers a choice: earn another token, or go cash out.

| Manipulation | Accumulation before exchange |
|---|---|
| exchange-production ratio ↑ (cash-out more expensive) | **more** tokens accumulated |
| token-production ratio ↑ (each token more expensive) | **fewer** tokens accumulated |
| tokens removed from display, contingencies unchanged | accumulation **collapses** |

The trade-off is explicit: going immediately to exchange minimises the next reward's delay but pays the procurement cost every time; accumulating raises the delay and lowers the responses-per-food. Accumulating the maximum (12) was always the long-run optimum; subjects accumulated intermediate amounts that a discounted unit-price model fits. Sousa & Matsuzawa 2001 report the same "spontaneous saving" in a chimpanzee with no contingency requiring it.

Two architecture-relevant readings. **(i)** The last row means the token display is *discriminative for further earning*, not only a stored balance — remove the read-out and the policy changes even though the economics did not. A wiki agent's internal reward counter is never an observation; here the balance is one, and it is load-bearing. **(ii)** Batching intrinsic rewards is a decision no agent in the wiki makes; deciding *when to cash in* is a control problem the options formalism cannot state.

---

## Tokens bridge delays that nothing else bridges — and not by bridging

Wolfe 1936, progressive-delay breakpoints in chimpanzees:

| Condition | Breakpoint |
|---|---|
| 1. immediate token, delayed exchange/food | 20 min–1 hr; undefined (>1 hr) for 2 of 4 subjects |
| 2. no token, delayed food | < 3 min |
| 3. non-paired (brass) token during delay, delayed food | < 3 min |
| 4. token earned *and deposited immediately*, delayed food | < 3 min |

Conditions 1 vs 4 hold the response-produced stimulus change constant and vary only whether the token is present across the delay: 1 ≫ 4 rules out **marking** as the explanation. Pushing further, the two best subjects kept responding at **5 h and 24 h** delays while being removed from the chamber (and from the token) for most of the interval — so physical presence of the token is not what carries the gap either, once the pairing history exists. Williams 1994's beginning-and-end > continuous result ([[wiki/concepts/conditioned-reinforcement.md]]) is the same conclusion in a non-token preparation.

**What this buys:** the longest response–reinforcer delays anywhere in the wiki's behavioural literature, purchased with a held, food-paired token rather than with a temporally continuous signal. The mechanism is not a bridge; it is a *possession whose value was set elsewhere*.

---

## Token loss is conditioned punishment, and the currency makes gains and losses commensurable

| Study | Design | Result |
|---|---|---|
| Pietras & Hackenberg 2005 (pigeons) | conjoint FR 10 / FR 2 token **removal** superimposed on VR-4 (RI 30 s) token gain, multiple schedule | rates suppressed to 30–40% of baseline, not to zero |
| — same, *exchange extinction* | tokens produced and accumulated normally but never redeemable | rates stabilise **at the punishment level, far above extinction** |
| — same, full extinction (no tokens) | responding eliminated |
| Raiff, Bullock & Hackenberg 2008 | token-loss condition vs a **yoked** condition with matched food density and no loss contingency | yoked rates reduced somewhat, token-loss rates reduced more → a direct punishment effect, not a reinforcement-density artefact |

The **exchange-extinction** row is the load-bearing one for this wiki: production and accumulation of a currency that is *signalled to be unredeemable* still maintains substantial behaviour. It sharpens `G125` in both directions — the manufactured reward does decay without primary backing ([[wiki/concepts/conditioned-reinforcement.md]]), but it decays to a **non-zero floor** as long as the token itself keeps being delivered. A machine subgoal reward is farmable at full value forever; a biological one is farmable at roughly a third of value, which is a weaker but still unbounded exploit.

Token loss also delivers what the source calls the **symmetrical law of effect** as a testable claim: with gains and losses denominated in one unit, the scaling problem that blocks comparing food to shock disappears. The answer is contested — see `T396`.

---

## Unit price fails as the cost variable

| Comparison (Bullock & Hackenberg 2006) | Unit price | Response rate |
|---|---|---|
| token-production FR 25 → 100, exchange-production 4 fixed | 25 → 100 (4×) | falls, as predicted |
| exchange-production 2 → 8, token-production FR 25 fixed | **25 → 25 (unchanged)** | **falls** |

Equal unit prices, unequal behaviour. Behaviour tracked responses (or delay) **per exchange period**, indifferent to how many reinforcers the exchange period would deliver. Foster & Hackenberg 2004 add the choice version: with unit prices equal, pigeons preferred the smaller-FR/less-food option, fitted only by a unit-price model with temporal discounting bolted on, and equally by delay-reduction theory read in time rather than responses.

**Reading.** The cost that controls behaviour is the cost of *reaching the next redemption event*, not the amortised cost per unit of reward. Every cost model in the wiki that divides effort by return — including the effort terms on [[wiki/concepts/expected-value-of-control.md]] — is an amortised model of exactly the kind that fails here.

---

## One signal, four functions, and no way to separate them

| Function | Evidence |
|---|---|
| **reinforcing** | token-maintained acquisition and maintenance approaching food levels (Wolfe 1936, Cowles 1937) |
| **discriminative** | free tokens at session start raise early-cycle rates (Kelleher 1958) and lower total tokens earned ("token satiation", Cowles 1937); removing the display collapses accumulation (Yankelevitz et al. 2008) |
| **eliciting** | manipulable tokens evoke consummatory behaviour — chimps mouth food-paired chips, rats show "misbehaviour" toward ball bearings (Cowles 1937; Midgley et al. 1989; Boakes et al. 1978) |
| **punishing (on removal)** | Pietras & Hackenberg 2005; Raiff et al. 2008 |

The source's methodological recommendation is itself an architectural claim: use **non-manipulable** tokens (lights, counters) when the operant function is the object of study, because manipulable ones import stimulus–stimulus intrusions that compete with the behaviour the token is supposed to reinforce. Translated: a subgoal signal that is also a perceptible object acquires a pull toward *the signal itself* that is incompatible with the work it is meant to motivate. No wiki architecture distinguishes these functions of its own intrinsic-reward channel, and three of the four are not even represented.

---

## What a builder takes

| Finding | Consequence for an architecture |
|---|---|
| Earning, becoming-spendable and spending are three schedules | The one number `r̃` is three prices. Each is separately measurable and each moves behaviour differently (`G127`, `G33`) |
| Choice tracks the delay to **exchange**, not to the token | Where the self-payment is *redeemed* sets whether an agent is subgoal-captured; `T367` becomes tunable |
| Accumulation rises with cash-out cost, falls with token cost | A learned batching policy over intrinsic reward — a control decision no wiki agent has |
| The token balance is an **observation**, and removing it changes the policy with economics unchanged | Every internal reward counter in the wiki is invisible to its own policy |
| Token present across the delay ≫ token deposited immediately | Conditioned value, not marking, carries very long delays (5 h, 24 h breakpoints) |
| Exchange extinction holds responding at ~30–40% of baseline | The biological subgoal currency has a non-zero farming floor even when signalled worthless (`G125`) |
| Token loss suppresses beyond its reinforcement-density effect (yoked control) | Withdrawal of manufactured reward is a punisher in its own right; no wiki agent's intrinsic reward can be *taken back* |
| Equal unit prices, unequal rates | The controlling cost is per-redemption, not per-reward; amortised effort models are the wrong shape |
| FR/VR/FI signatures reappear with token-production runs as the unit | The hierarchy level is the same algebra on compiled units — the strongest empirical support the wiki has for temporal abstraction as *re-application* rather than a new mechanism |
| Generalized (multi-outcome) tokens have never been demonstrated in the lab | The fungible scalar reward every machine agent uses has, biologically, no existence proof |

## Open problems

- **Generalized reinforcement is unestablished.** Tokens paired with *multiple* terminal reinforcers should be more durable, less price-elastic and motivationally robust — Skinner's central theoretical construct and the thing money is. The source: attempts "have either failed (Myers & Trapold 1966) or produced weak and transient effects (Lubinski & Thompson 1987)", and convincing laboratory demonstrations are "virtually nonexistent". Wolfe 1936 came closest and did not run the crucial condition (a third token paired with both food and water). **A scalar fungible reward is the unexamined assumption of every architecture in the wiki, and the only literature that manufactures value from scratch cannot yet produce one.**
- **What training history establishes a token as a reinforcer** — whether explicit pairing is necessary, whether CS functions must precede reinforcing functions — is unknown; the source calls these "fundamental but unresolved".
- **The token-exchange schedule has been manipulated once** (Malagodi et al. 1975). Two of the three prices are essentially unmapped.
- **Accumulation's time-scale question is open**: whether behaviour is organised by the immediate next reward or by a longer-run unit price is exactly what the accumulation trade-off puts in opposition, and the fit needs a discounting term the economics does not supply.
- **Punishment parameters are unmapped** — rate, magnitude and schedule of loss, and the availability of unpunished alternatives.

---

## Connections

- **[[wiki/concepts/conditioned-reinforcement.md]]** — the same manufactured want, given an inventory: that page measures what a pairing-made reinforcer is *worth* and shows every unbacked delivery extinguishes it; this one splits its delivery into production, redemption-opportunity and redemption, shows choice is controlled by the last of the three, and adds the floor the extinction account is missing (exchange extinction stabilises at 30–40% of baseline, not at zero).
- **[[wiki/concepts/temporal-abstraction-options.md]]** — the empirical realisation of the formalism and of its one untested premise: token-production runs behave as unitary responses reinforced by a second-order schedule, with FR/VR/FI signatures preserved at both levels, so a level of hierarchy is the same control law re-applied to compiled units rather than a new mechanism; and the delay that selects an option is the delay to *redemption*, which the option's `β` does not name.
- **[[wiki/concepts/pseudo-reward-prediction-error.md]]** — the pay-out schedule that page has by default and never chose: `r̃` is credited at subgoal completion, which is the unequal-exchange arrangement that made pigeons and humans alike prefer the sooner, smaller option; an equal-exchange arrangement reverses the preference with the subgoal contingency untouched (`G127`).
- **[[wiki/concepts/optimal-hierarchy-criterion.md]]** — supplies the cost currency that criterion charges in: not responses per reinforcer (equal unit prices produced unequal behaviour) but responses and delay per *redemption event*, so a decomposition's price depends on where the cash-out boundaries fall, not on the total work the decomposition implies.
- **[[wiki/concepts/subjective-value.md]]** — the same discount question asked of a held balance: accumulation trades a longer delay to the next reward against a lower long-run cost per reward, and the fitted account needs a discounting term bolted onto the unit-price model, which is that page's kernel appearing inside a cost model rather than inside a choice.
- **[[wiki/concepts/expected-value-of-control.md]]** — the wiki's amortised effort term, against a dataset where amortisation fails: with unit price held constant and procurement cost raised, response rate fell, so cost enters behaviour per redemption episode rather than per unit of return.
- **[[wiki/concepts/affective-opponency.md]]** — the currency that makes its two axes commensurable: token gain and token loss are the same quantity with a sign, which is the measurement context the symmetrical law of effect needs, and the answer disagrees across preparations (`T396`) — loss weighted ≈ 3× gain in one human matching experiment, no bias at all in another.
- **[[wiki/concepts/higher-order-conditioning.md]]** — the chain this page prices: each token is a link whose value was conferred by pairing, and the exchange-delay result says what the chain's *controlling* variable is — the terminal link's timing, not the intermediate link's, which is the behavioural counterpart of the identity-stripping that page reports at the first chaining step (`T395`).
- **[[wiki/concepts/latent-graph-discovery.md]]** — a node whose value is a *countable balance* rather than a distance estimate: the token array is simultaneously a stored quantity, an observation the policy reads, and a reinforcer, so a graph whose nodes carry inventory cannot be navigated by a distance-to-goal signal alone.
- **[[wiki/concepts/hindsight-goal-relabelling.md]]** — the contrast on redemption: a relabelled goal's reward is credited the moment the predicate is satisfied and can never be withdrawn, where a token is held, can be counted, can be spent on a schedule, and can be *taken back* as a punisher (Raiff et al. 2008's yoked control separates that from the reinforcement-density change it causes).
