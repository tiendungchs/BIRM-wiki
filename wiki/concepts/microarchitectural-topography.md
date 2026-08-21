# Microarchitectural Topography — Gradient or Interdigitation, and Why the Choice Is a Wiring Decision

**Given a set of units that differ in what they compute, *where you put them* determines what they can cheaply combine. More than 90% of cortico-cortical connections run between neighbouring microcircuits, so the spatial layout of microarchitecture is a connectivity prior, not a cosmetic fact. Cortex uses two layouts and they buy different things: a **smooth gradient**, where similar units are adjacent and the arrangement is monotone along a spatial axis, supports *progressive convergence* — signals transformed step by step toward higher-order representations; and **interdigitation**, where contrasting unit types alternate on a fine scale, supports *linking of disparate sources* — domain specialisation and cross-domain binding in the same patch. Both motifs occur inside a single network, in different subregions, and the difference is measurable with two scalars.**

> **Provenance.** Paquola et al. 2025, *The architecture of the human default mode network explored through cytoarchitecture, wiring and signal flow*, Nat Neurosci 28:654–664, doi:10.1038/s41593-024-01868-0 (`raw/paquola-2025-dmn-cytoarchitecture-signal-flow.md`). The measurements are on the BigBrain 3D histological reconstruction (one 65-year-old male brain, 100 μm) plus a 7-T quantitative-T1 replication in 8 individuals; the interdigitation interpretation is supported by, not derived from, primate tract-tracing and precision functional imaging in prefrontal cortex and inferior parietal lobule.

---

## The two scalars

Both are computed on `E1`, the first eigenvector of a nonlinear manifold over intracortical cell-density profiles — i.e. on a per-vertex scalar saying *what kind of microcircuit is here*.

| Metric | Definition | High value means |
|---|---|---|
| **Smoothness** | Proportion of variance in `E1` explained by regression on spatial axes (second-, third-, fourth-order) | The microarchitecture is a monotone function of position — a gradient |
| **Waviness** | Deviation from the local mean, a surface-metrology measure borrowed from mechanical engineering | The microarchitecture flips repeatedly between contrasting values over short distances — a checkerboard |

They are complementary rather than opposite: a region can be poorly explained by spatial regression *and* low in waviness (unstructured), or well explained and wavy (a gradient with ripples). Both were validated on simulated fields before use.

**The measured dissociation, inside one network:**

| Subregion | Smoothness | Waviness | Motif | Claimed product |
|---|---|---|---|---|
| Parahippocampus | High | Low | Gradient | Progressive convergence: low-order → higher-order representation in steps |
| Dorsal prefrontal cortex | Low (poor regression fit) | **High** | Interdigitation | Linking of information from disparate sources; substrate for domain specialisation *and* cross-domain integration |

Subregions differ significantly on both: smoothness `F = 14.5 / 14.9 / 20.1`, `P < 0.004`; waviness `F = 48.3`, `P = 0.001`. The 7-T individual replication reproduces waviness well (`r_avg = 0.74`, `P = 0.011`) and smoothness weakly (`r_avg = 0.51`, `P = 0.09`, n.s.) — so the *interdigitated* motif is the more robust of the two across brains and modalities.

---

## Why the layout is a connectivity prior

The load-bearing statistic is not new here but is what licenses reading topography as wiring: **the majority of cortico-cortical connections are shorter than ~10 mm** (quantitative tract-tracing, carried on [[wiki/concepts/broadcast-hierarchy.md]]). Consequences:

| Layout | What is cheap | What is expensive |
|---|---|---|
| Gradient | Coupling units of *similar* type (each neighbour is the next step) | Coupling distant points of the axis — needs a long-range tract |
| Interdigitation | Coupling units of *dissimilar* type (a contrasting patch is one hop away) | Preserving a pure representation of one type — every neighbourhood is mixed |

So a gradient is a **serial compressor** built out of locality, and interdigitation is a **local mixer** built out of the same locality. Neither needs long-range wiring to do its job, which is why both survive under a metabolic budget that keeps most axons short.

**This also makes Barbas' laminar-type rule readable as a special case.** That rule ([[wiki/concepts/canonical-cortical-microcircuit.md]]) says areas preferentially connect to areas with *similar* laminar profiles. On a gradient, similar-type neighbours are spatially adjacent, so the rule and locality agree. On an interdigitated patch they disagree — the type-matched partner is the *next-but-one* patch, not the neighbour — which predicts short-range skipping connectivity inside prefrontal cortex, and is the pattern primate tract-tracing reports there as interdigitated projections.

---

## (brainstorm) The transferable design question

Every modular architecture in the wiki places its modules by index, and index has no geometry: module `k` is equidistant from all others, or connected to all others, or connected to a hand-specified subset. The measurement here says biology instead assigns each unit a *type scalar* and then chooses a **spatial arrangement of that scalar**, from which the cheap edge set follows. Written as a design recipe:

```
1. give every module a scalar level  ℓ_i  (its own compression / differentiation, not its index)
2. embed modules in a metric space
3. make coupling cost grow with distance  → most edges local
4. choose the LAYOUT of ℓ over the space:
     monotone   → serial abstraction pipeline
     alternating → local cross-type binder
5. add a sparse long-range overlay for whatever the layout made expensive
```

Steps 1–3 exist piecemeal in the wiki ([[wiki/concepts/small-world-topology.md]] has the distance cost, [[wiki/concepts/broadcast-hierarchy.md]] has the level scalar); **step 4 has no instance anywhere**. Two concrete predictions a builder could test cheaply: (i) a mixture-of-experts whose experts are ordered by a learned abstraction statistic and whose routing is distance-penalised should develop a gradient if the task is compositional-serial and an alternating layout if it requires binding across unrelated domains; (ii) waviness of a trained model's layer-wise representational-similarity field is a *diagnostic* — a region of the network that alternates rather than progresses is doing binding, not abstraction, and is where cross-domain transfer should be found.

**A second use: waviness as an interpretability statistic.** Both metrics are computed on a scalar field over a spatial embedding and require no task, no labels and no ablation. Given any embedding of units (channels, heads, experts) with a per-unit compression measure, the same two numbers are computable and would say whether a subnetwork is arranged as a pipeline or as a mosaic. The wiki's probing methods ([[wiki/concepts/representation-probing.md]]) all ask *what* is represented; this asks *how the representing units are laid out*, which is the question that decides what can be combined without new wiring.

---

## Why it matters that both motifs are in one system

The default mode network contains both ([[wiki/entities/default-mode-network.md]]). The authors' reading is that when these regions act as a collective they combine **two different types of integration** — convergent and combinatorial — in one act. That is a specification the wiki's integration pages do not have: [[wiki/concepts/complementary-learning-systems.md]] splits integration by *timescale*, [[wiki/concepts/integration-segregation-balance.md]] by *how much*, and neither by *kind*. It also gives the network's notorious functional heterogeneity a structural cause that is not "it does many things": a system that convergently abstracts at one end and combinatorially binds at the other will look like several faculties to any task-based decomposition.

---

## Open problems

| Problem | Why it is open |
|---|---|
| **The mapping from motif to computation is asserted** | Gradient→convergence and interdigitation→linking are inferences from other literatures (mesiotemporal gradient studies, prefrontal tract-tracing), not measured here. No experiment varies the motif and measures what is computed |
| **`n = 1` histology** | The cytoarchitectural field is a single postmortem brain; the 7-T replication uses myelin (qT1), not cell bodies, and confirms waviness better than smoothness |
| **Which component of the manifold is being read** | The authors concede that curvature, resolution and interpolation may bias the profiles toward deep layers, and that higher components (E4, E5) may carry the classic laminar-type information — so the field on which both metrics are computed is method-contingent |
| **No account of what sets a subregion's motif** | Nothing says whether the assignment is developmental, activity-dependent, or a consequence of which inputs a subregion must combine |
| **The metrics have no scale parameter reported** | Waviness is a deviation-from-mean statistic and so depends on the neighbourhood size chosen; no sensitivity analysis over that scale is given, which matters because interdigitation is defined by its spatial frequency |

---

## Connections

- **[[wiki/entities/default-mode-network.md]]** — the system both motifs were measured in, and the reason the measurement matters: a network that abstracts convergently in its parahippocampal end and binds combinatorially in its prefrontal end will fractionate under any task-based decomposition, which is that page's central unresolved problem.
- **[[wiki/concepts/broadcast-hierarchy.md]]** — supplies the level scalar and the <10 mm connection statistic this page turns into a layout rule; that page's apex has a *depth*, this page adds that depth need not be laid out monotonically in space.
- **[[wiki/concepts/canonical-cortical-microcircuit.md]]** — the laminar-type coupling rule read as a special case: on a gradient it coincides with locality, on an interdigitated patch it does not, which predicts short-range skipping connections in prefrontal cortex.
- **[[wiki/concepts/small-world-topology.md]]** — the wiring-cost half of the argument: locality is what makes layout a connectivity prior at all, and the sparse long-range overlay is what buys back whatever the layout made expensive.
- **[[wiki/concepts/integration-segregation-balance.md]]** — that page measures *how much* integration is happening; this page distinguishes two *kinds* whose local wiring differs, so a single participation coefficient cannot tell a convergent pipeline from a combinatorial mixer.
- **[[wiki/concepts/representation-probing.md]]** — the two metrics are label-free, task-free diagnostics computable on any embedding of units with a per-unit compression measure, which is a different question from what a probe asks: not what is encoded, but how the encoders are arranged.
- **[[wiki/concepts/node-definition-problem.md]]** — interdigitation is the reason a parcellation can be wrong in principle rather than in resolution: if contrasting microcircuits alternate below the parcel size, every parcel is a mixture and no finer atlas of the same kind fixes it.
- **[[wiki/concepts/population-geometry.md]]** — the same question asked in state space rather than in physical space: which directions are combinable is set there by the geometry of the code, here by the geometry of the tissue, and the <10 mm statistic is what ties the second to the first.
