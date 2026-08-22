---
title: "Convergent brain structures for spatial memory"
source: "https://claude.ai/chat/53c19ca3-8b82-4820-be1e-435adeb10ea6"
author:
published:
created: 2026-06-13
description: "Claude conversation with 4 messages"
tags:
  - "clippings"
---
**User**

The mushroom bodies of jumping spider and Hippocampal formation of vertebrates are an example of convergent evolution. They tried to solve the same problem and arrive in pretty much the same solution. That seems to be the optimal solution to build a allocentric world model, and they are really good at generalization. Are there any other brain structure of any other type of organism that can do the same thing? Thanks

---

**Claude**

This is a fascinating area of comparative neuroscience. Yes, there are several strong candidates — and the convergence runs surprisingly deep, sometimes down to circuit-level architecture. Here are the most compelling examples:

---

### 🦑 Cephalopod Vertical Lobe (Octopus, Cuttlefish, Squid)

Probably the strongest case. The vertical lobe of cephalopods is strikingly convergent with the hippocampus at the **circuit architecture level**:

- A massive **fan-out expansion layer** (amacrine cells) feeding into a compressed output layer — mirroring the dentate gyrus → CA3 architecture
- Enables **sparse coding**, pattern separation, and generalization
- Lesion studies show profound deficits in spatial and contextual learning
- Evolved completely independently ~500 million years ago from vertebrates
- Octopuses demonstrate clear allocentric navigation (they return to dens via novel routes)

The convergence here isn't just functional — it's **topological**, which makes it especially remarkable.

---

### 🦗 Insect Central Complex (Flies, Bees, Locusts, Cockroaches)

This might actually be the *most* relevant example to your point, and it's worth distinguishing from the mushroom bodies. The **central complex** (CX) is now understood to be the primary allocentric navigation center in insects:

- Contains **head direction cells** with ring-attractor dynamics — essentially identical in function to the vertebrate head direction system
- Contains **grid cell-like neurons** and **place cell-like activity** in Drosophila and locusts
- Performs **vector integration** (path integration) and goal-directed navigation
- The architecture (EB/PB rings) implements coordinate transformations similar to entorhinal → hippocampal processing

Recent work (Seelig & Jayaraman 2015, Turner-Evans et al.) has shown the CX implements an **internal compass that updates allocentrically** — arguably the most direct functional parallel to the hippocampal formation found so far in invertebrates.

---

### 🦀 Crustacean Hemiellipsoid Bodies (Crabs, Mantis Shrimp, Lobsters)

The hemiellipsoid bodies in malacostracan crustaceans are considered the evolutionary sister structure to insect mushroom bodies, but have expanded independently in different lineages:

- Mantis shrimp have **disproportionately large** hemiellipsoid bodies relative to body size
- Crabs show **place cell-like neural activity** in these regions during spatial exploration
- The architecture shares the characteristic **Kenyon cell-like sparse coding** that makes mushroom bodies efficient at generalization

---

### 🪱 Polychaete Annelid Mushroom Bodies

Several polychaete worms (e.g., *Nereis*, *Platynereis*) have well-developed **mushroom body homologs** with the same basic circuit motif — a large number of Kenyon cell-like neurons receiving multimodal input and projecting to a compact output region. This is particularly interesting because:

- Annelids and arthropods diverged ~600 million years ago
- Some researchers argue this represents **deep homology** (shared ancestry), others argue **convergence** — the debate is ongoing
- *Platynereis* has become a model for studying the evolution of centralized nervous systems

---

### 🐝 A Note on the Computational Motif

What's striking is that across all these cases, the same **circuit solution** keeps reappearing:

```
Many inputs → Expansion layer (sparse, high-dimensional coding)
             → Compression/output layer (pattern completion, generalization)
```

This is essentially the same as the **dentate gyrus → CA3 → CA1** motif in the hippocampus. It seems to be a near-optimal solution for:

- **Pattern separation** (distinguishing similar contexts)
- **Pattern completion** (recovering full maps from partial cues)
- **Generalization** across novel environments

The fact that evolution keeps rediscovering this architecture — in mollusks, arthropods, annelids, and vertebrates — strongly suggests it may be a **fundamental computational constraint** for building flexible world models, not just one solution among many.

---

### Summary Table

| Structure | Organism | Estimated Independent Origin |
| --- | --- | --- |
| Hippocampal formation | Vertebrates | ~500 Mya |
| Mushroom bodies | Insects / Jumping spiders | ~400–500 Mya |
| Central complex | Insects | ~400 Mya |
| Vertical lobe | Cephalopods | ~500 Mya |
| Hemiellipsoid bodies | Crustaceans | ~400 Mya |
| Mushroom body analogs | Polychaete annelids | ~600 Mya |

The cephalopod vertical lobe and the insect central complex are probably your richest comparisons — both the functional parallels and the architectural convergence are remarkably tight given the evolutionary distance.

---

**User**

Amongst all the brain region of all those that can build an allocentric world model, which one has the most in dept studies, or we have the most insight about while being the most simpl/elegant? I want to build a machine learning model that can generalize by building a world model, inspired by biology. The problem is that the dynamic between the Hippocampal formation and other brain region during learning and prediction during navigation is very complicated imo.

---

**Claude**

### The Insect Central Complex (CX) — Especially in Drosophila

This is almost certainly your best target. Here's why it dominates all the other candidates for your purpose:

---

#### Why the CX wins on all your criteria

**Most studied + most insight:**

- The *Drosophila* **full connectome is known** (hemibrain project, then the full FAFB and larval connectomes). Every neuron, every synapse, mapped.
- Decades of in-vivo electrophysiology, calcium imaging, and optogenetics
- The ring attractor was **directly confirmed in a living animal** (Seelig & Jayaraman, 2015) — you can literally watch the "bump of activity" rotate as the fly turns. That almost never happens in neuroscience.

**Most elegant/simple:**

- The core head direction circuit has ~80 neurons (E-PG cells) arranged in a ring
- The update rule is essentially **one operation**: shift the activity bump proportional to angular velocity
- The full spatial navigation circuit decomposes cleanly into ~4 separable modules (see below)

---

#### The Circuit Architecture (What You'd Actually Implement)

This is the key insight — the CX solves the world model problem with a clean **modular pipeline**, unlike the hippocampus which is deeply entangled with cortex, thalamus, striatum, etc.

```
┌─────────────────────────────────────────────────────────┐
│                  CENTRAL COMPLEX                        │
│                                                         │
│  [Sensory landmarks] ──► E-PG neurons                   │
│                          (Ring attractor ~80 cells)     │
│                          "Where am I heading?"          │
│                               │                         │
│                               ▼                         │
│  [Self-motion/speed] ──► P-EN neurons                   │
│                          "Shift the bump"               │
│                          (path integration)             │
│                               │                         │
│                               ▼                         │
│  [Goal/reward]       ──► FC2/PFL neurons                │
│                          "Where do I want to go?"       │
│                               │                         │
│                               ▼                         │
│                          Motor output                   │
│                          (heading error → turn)         │
└─────────────────────────────────────────────────────────┘
```

The **allocentric world model** emerges from the interaction between:

1. **E-PG ring** → current heading state (attractor network)
2. **Path integrator** → dead-reckoning update when no landmarks
3. **Landmark binding** → corrects drift when visual cues appear
4. **Goal vector** → separates representation from action

This is a **Kalman filter intuition** realized in neurons: prediction (path integration) + correction (landmark update).

---

#### Why the Hippocampus is harder for your purpose

|  | Hippocampal Formation | Insect CX |
| --- | --- | --- |
| Regions involved | HPC + EC + PFC + striatum + thalamus | Mostly self-contained |
| Connectome known? | No | Yes (Drosophila) |
| Core computation | Still debated | Ring attractor — proven |
| Number of cell types for spatial nav | 10+ (place, grid, border, speed, theta...) | ~4–5 core types |
| Learning rule | Unclear (STDP? theta sequences?) | Hebbian + neuromodulation, well-mapped |

---

#### What to Read (in order)

1. **Seelig & Jayaraman (2015)** — *Nature* — Direct observation of the ring attractor. The paper that confirmed everything. Start here.
2. **Stone et al. (2017)** — "An anatomically constrained model for path integration in the bee brain" — Already a computational model you can implement
3. **Turner-Evans et al. (2017, 2020)** — Path integration in Drosophila CX
4. **Hulse et al. (2021)** — *Neuron* — Full computational framework of the CX across behaviors. The most comprehensive synthesis.
5. **Lyu et al. (2022)** — Goal-directed navigation using the CX vector system

---

#### The ML Translation

The CX maps almost directly onto modern ML primitives:

| Biology | ML equivalent |
| --- | --- |
| Ring attractor (E-PG) | **Circular state space with fixed-point dynamics** — implementable as a recurrent net with cosine connectivity |
| Path integration (P-EN) | **GRU/RNN with velocity input** updating a latent heading state |
| Landmark correction | **Attention mechanism** over sensory observations that anchors the latent state |
| Goal vector (PFL) | **Separate goal embedding** + vector subtraction → action |
| Neuromodulation (dopamine) | **Learning rate gating** / modulated Hebbian update |

The key advantage over hippocampus-inspired models (like the Tolman-Eichenbaum Machine, which is beautiful but complex) is that the CX gives you a **clean separation of concerns**: the world model (ring + integrator) is explicitly decoupled from the goal/action system. That's architecturally very clean to implement.

---

#### The Core Insight for Your Model

The reason it generalizes so well is this: the CX doesn't memorize paths — it maintains a **continuous low-dimensional state** (heading + position estimate) that gets updated by two independent signals (self-motion and landmarks). Generalization is free because any new environment just produces new landmark corrections on the same underlying ring. You never overfit to a specific trajectory.

That's the biological principle worth stealing: **a compressed, dynamic state representation that separates self-motion integration from sensory grounding**.