# Error Consistency — Trial-by-Trial Agreement as a Test of Shared Strategy

**Two systems implement the same strategy only if they fail on the same individual inputs. Error consistency is that comparison made into a number: `κ = (c_obs − c_exp)/(1 − c_exp)`, the chance-discounted rate at which two decision makers agree per trial on *correct vs incorrect*. `κ = 0` means the two are independent — whatever else is true, they are not running the same algorithm. It is a **necessary, not sufficient** condition, and it is the only instrument in the wiki that compares two black boxes using nothing but their per-trial correctness.**

> **Provenance.** Geirhos, Meding & Wichmann 2020, *Beyond accuracy: quantifying trial-by-trial behaviour of CNNs and humans by measuring error consistency*, NeurIPS 2020 (`raw/geirhos-2020-error-consistency.md`). Code and data: `github.com/wichmann-lab/error-consistency`. Its lineage is Green's **molecular psychophysics** — the goal of a perceptual model is to predict the response to each *trial*, not the mean over trials, and once models get good enough, accuracy stops being able to rank them (Green 1964). This page holds the instrument; the vision result it returned sits on [[wiki/entities/ventral-visual-stream.md]] and [[wiki/entities/stylized-imagenet.md]].

---

## The formalism

For two observers `i, j` responding to the same `n` trials, scored only as correct/incorrect (choice count is irrelevant):

```
c_obs(i,j) = e(i,j) / n                          observed agreement (both right or both wrong)
c_exp(i,j) = p_i·p_j + (1 − p_i)(1 − p_j)        agreement expected from two independent binomial observers
κ(i,j)     = (c_obs − c_exp) / (1 − c_exp)       Cohen's kappa, repurposed
```

| Reading | Meaning |
|---|---|
| `κ > 0` | Agreement beyond chance — *compatible with* a shared strategy |
| `κ = 0` | Independent. **Excludes** a shared strategy |
| `κ < 0` | Anti-consistent — the systems find *different* items hard, i.e. inverse strategies |

**`c_exp` is the whole point.** Two accurate observers agree on most trials by arithmetic alone; a raw overlap score is therefore mostly an accuracy score. Discounting by `c_exp` is `F15` of [[wiki/concepts/certification-instruments.md]] — *an undifferenced score is partly an accuracy score* — applied to an agreement statistic instead of a post-shift one, and it is why prior image-by-image comparisons that omitted the correction reported higher similarity for pairs that were merely both better.

**Bounds.** `κ` is not free to range over `[−1, 1]` at a given `c_exp`; for `p_i ≠ p_j` the accuracy mismatch alone caps it. With `c_obs ∈ [|p_i + p_j − 1|, 1 − |p_i − p_j|]`:

```
c_exp ≤ 0.5 :  −c_exp/(1−c_exp)              ≤ κ ≤ (1 − √(1−2c_exp) − c_exp)/(1 − c_exp)
c_exp ≥ 0.5 :  (√(2c_exp−1) − c_exp)/(1−c_exp) ≤ κ ≤ 1
```

**The confidence interval must be simulated, not looked up.** Cohen's own approximation was later shown to be wrong, and the naive binomial interval is wrong for a second reason — the x-coordinate `c_exp` is itself estimated from the same data. The authors sample 100,000 experiments under the independent-observer null and take percentiles. Anyone reusing `κ` inherits this: **the null is cheap to simulate and the closed form is not available.**

---

## The two preconditions

Both are stated as requirements, and both are violated by default practice.

| Precondition | Why | Consequence when violated |
|---|---|---|
| **Identical stimuli, per trial, responses joinable by item** | The statistic is defined per trial; presentation order is free, item identity is not | Any aggregate comparison (confusion matrices, KL scores, per-condition accuracy) is *molar* and loses the information the instrument runs on |
| **Neither system at ceiling nor at chance** | At ceiling `c_exp → 1` and the bound collapses; at chance there is no signal | The instrument is undefined exactly where accuracy benchmarks end up, which is what forces out-of-distribution stimuli into the protocol |

The second precondition is why the experiments below are run on **out-of-distribution** stimuli — cue-conflict, edge and silhouette images — rather than on clean ImageNet: the shift is not the object of study, it is the device that moves both systems off ceiling into the regime where trial-level disagreement is measurable. This is the mirror image of `F7` on [[wiki/concepts/certification-instruments.md]] (a benchmark that floors every solver destroys the ordering): error consistency needs a *band*, open at both ends.

---

## What it returned on vision

Setup: the [[wiki/entities/stylized-imagenet.md]] psychophysics — 16 categories, 224×224 images, 200 ms presentation, N = 10 observers; 1,280 cue-conflict trials, 160 edge trials, 160 silhouette trials; 16 ImageNet-trained torchvision CNNs plus CORnet-S, 1,000-way outputs mapped to 16 via WordNet.

| Comparison | `κ` | What it forecloses |
|---|---|---|
| Human ↔ human (cue conflict) | **.331** | The instrument has a working range: humans agree about which cats are hard well beyond chance |
| ResNet-50 ↔ human | **.068** | |
| CORnet-S ↔ human | **.066** | The "current best model of the primate ventral stream" buys **nothing** behaviourally over its own baseline |
| AlexNet (2012) ↔ human | **.080** | Eight years of architecture progress moved human-likeness *backwards* on this measure |
| CORnet-S ↔ ResNet-50 | **.711** | The recurrent brain-inspired model is behaviourally a ResNet-50 |
| DenseNet-121 ↔ ResNet-18 (max observed) | **.793** | Different family, different depth (121 vs 18), different connectivity — and the *highest* consistency in the study |
| **CNN ↔ CNN, generally** | > human ↔ human, in **all three** experiments | And this holds *despite lower CNN accuracy* (silhouettes: human .75, CNN .54), so it is not an accuracy artefact — `c_exp` already removed that |

Highest CORnet-S↔human consistency is below the *lowest* human↔human consistency.

**Does a better ImageNet model make more human-like errors?** Regressions of `κ`(CNN, human) on ImageNet accuracy:

| Stimulus set | Result |
|---|---|
| Cue conflict | `F(1,158) = 0.086, p = .769, R² = 0.001` — **null** |
| Edge / line drawings | `F(1,158) = 0.478, p = .491, R² = 0.003` — **null** |
| Silhouettes | `F(1,158) = 53.530, p = 1.21·10⁻¹¹, R² = 0.253` — **positive** |
| ImageNet (top-5) | `F(1,30) = 8.162, p = .008, R² = 0.214` — **negative** |

Three signs across four stimulus sets. The scaling story that holds for transfer learning and for neural predictivity does not hold here, and on clean images it **inverts**.

---

## The three findings that survive the vision framing

1. **Architecture is nearly irrelevant to strategy.** Sixteen CNNs spanning eight years, four families and 18–121 layers are mutually consistent at levels human observers do not reach with each other. Whatever these networks differ in, it is not the decision rule. *(This is the behavioural counterpart of the observation that many architectures predict neural data about equally well — the models were never as different as the architecture diagrams suggest.)*
2. **Recurrence does not imply different behaviour.** CORnet-S is recurrent, was selected against Brain-Score, and reproduces monkey object-solution-times — and behaves like a feedforward ResNet-50 on a trial-by-trial read. Recurrence is not self-certifying; the conditions under which it changes the computation remain unidentified (the paper's own pointer: difficult images).
3. **`κ` between models is an ensemble-quality statistic.** Ensembling pays in proportion to member *independence*. At `κ = 0.7–0.8` between arbitrary pairs, a CNN ensemble is close to `n` copies of one decision rule — a cheap, label-free diagnostic nobody runs before ensembling. `(brainstorm)` The same statistic prices any mixture-of-experts or population-of-solvers design in the wiki: measure `κ` across experts on held-out items, and treat it as the effective-`n` correction on the diversity the design assumes ([[wiki/concepts/sparse-expert-routing.md]]).

---

## Where it sits among the wiki's evaluation instruments

| Instrument | Compares | Needs | Blind to |
|---|---|---|---|
| Accuracy | system ↔ label | labels | strategy entirely |
| **Error consistency (`κ`)** | system ↔ **second system** | the same items run through both, and correctness per trial | *which* errors, and the content of the rule — it counts agreement, not kind |
| Accuracy-profile correlation (`I13`) | system ↔ human, **per item type** | a per-type human baseline and one-heuristic-per-type authoring | within-type structure; it is `κ` aggregated to types |
| Consistency score (`I9`) | system ↔ **itself** under a meaning-preserving transform | a declared invariance | anything requiring a second system |
| Cue-conflict readout (`I28`) | system ↔ **named feature** | two nameable, crossable features | unnameable shortcuts |

`κ` and `I9` converge on the same methodological point from opposite directions: **errors are the discriminative trials.** `I9` restricts its score to items the model got *wrong*, because identical incorrect outputs cannot both be explained by being correct ([[wiki/entities/pcfg-set.md]]); `κ` keeps the correct trials but discounts them by `c_exp`, which is the same subtraction performed continuously rather than by filtering. Neither was aware of the other.

---

## Open problems

- **`κ` counts agreement, not kind.** Two systems can disagree about *which* wrong label to give while agreeing perfectly on which trials are hard, and the statistic cannot tell that apart from label-level agreement. A confusion-structure term conditioned on the both-wrong cell is the obvious extension and is not defined here.
- **No decomposition into causes.** A low `κ` says "different strategy" and stops. It does not localise the difference to the feature used, the invariance assumed, or the decision stage — which is exactly what `I28` supplies for a *nameable* feature and nothing supplies otherwise.
- **The instrument's own null on a machine pair is untested at scale.** The human↔human `κ` (.331) is the only available estimate of "same architecture, different instance" for a biological system. The machine analogue — the same network trained from a different seed — is reported *internally* divergent by other work while behaving consistently here, and that dissociation (internally different, behaviourally identical) is unexplained.
- **It has never been run on a reasoning benchmark.** Every number here is object recognition. ARC, PGM, RAVEN and the mathematics benchmarks all ship per-item machine responses and none reports per-item human responses, so `κ`(human, solver) is unavailable on the wiki's central tasks — the same missing measurement as `H4` on [[wiki/concepts/human-baseline.md]].
- **Off-ceiling is a design constraint the field ignores.** Reporting `κ` requires deliberately placing both systems in the mid-accuracy band, which conflicts with every incentive a leaderboard creates.

---

## Connections

- **[[wiki/concepts/certification-instruments.md]]** — supplies `I30`: the only instrument in that inventory whose reference is a *second decision maker* rather than a label, a declared invariance or a named feature, and one of two (with `I6`) that can register a below-chance score meaning the opposite rule was acquired. It also generalises `F15` from post-shift scores to agreement statistics.
- **[[wiki/concepts/human-baseline.md]]** — the missing statistic for that page's **job 4** (match the human *profile*, not the human number): `I13`'s profile correlation aggregated to item types is `κ` coarsened, and `κ` is what `H4` asks for at trial resolution. It also supplies the reference value job 4 has never had — human↔human `κ = .331` is the ceiling any model-vs-human comparison should be read against, not 1.0.
- **[[wiki/entities/ventral-visual-stream.md]]** — the 2020 quantification of that page's 2012 complaint that model confusion patterns "do not match IT's", and the sharpest counterweight to its optimism: the model built to top its own benchmark family is behaviourally a vanilla ResNet-50 (T307).
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — prices the reverse channel. That page's Morgan's-Canon warning ("matched performance does not license inferring a matched algorithm") is asserted there and *measured* here, and the measurement lands on the channel's flagship result: ranking architectures by neural predictivity does not rank them by behavioural similarity (T307).
- **[[wiki/concepts/predictive-adequacy.md]]** — the same discipline applied to a different object. That page scores whether *our description of a system* is right, per-neuron and per-stimulus; this page scores whether *two systems* are the same, per-trial. Both refuse aggregation, and both make the ceiling an estimated quantity (explainable variance there, `c_exp` here) so the residual becomes attributable.
- **[[wiki/entities/stylized-imagenet.md]]** — supplies the stimuli and the human data. The cue-conflict set was built to read out *which feature* a model uses; run through `κ` it answers a second question the same trials already contained — whether any two models differ at all.
- **[[wiki/entities/pcfg-set.md]]** — the independent convergence on errors-as-discriminative-trials: `I9` filters to incorrect items, `κ` discounts correct ones by chance, and the two arrive at the same claim that agreement among correct answers carries almost no evidence about mechanism.
- **[[wiki/concepts/shortcut-learning.md]]** — the explanation on offer for finding 1: if all these networks learned the same shortcuts because the training distribution admits them, architecture *should* be irrelevant to behaviour, and `κ` ≈ 0.7–0.8 between arbitrary CNN pairs is the prediction that framing makes.
- **[[wiki/concepts/sparse-expert-routing.md]]** — the design consequence: any architecture whose payoff assumes diverse members can have that assumption measured directly, and on the one population ever checked the diversity was largely absent.
- **[[wiki/concepts/representation-probing.md]]** — the complementary port. Probing reads the internal state and needs labels in the model's own coordinates (`F4`); `κ` reads only the output port and needs no coordinates at all — which is why the reported dissociation (internally divergent seeds, behaviourally identical models) is visible only when both are run.
- **[[wiki/entities/cfq.md]]** — a live instance of the defect this page corrects: three architectures are reported to make **68% of their errors on the same samples** at 29–37% accuracy, an undifferenced overlap rate whose chance-expected component is large, so the "same failure" reading needs `κ` before it carries weight.
