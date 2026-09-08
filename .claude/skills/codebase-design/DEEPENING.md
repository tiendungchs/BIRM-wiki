# Deepening

How to deepen a cluster of shallow modules safely, given its dependencies. Assumes the vocabulary in [SKILL.md](SKILL.md): **module**, **interface**, **seam**, **adapter**.

Two taxonomies follow. Use [Dependency categories: authored code](#dependency-categories-authored-code) when the modules are written; use [Dependency categories: learned modules](#dependency-categories-learned-modules) when a module is trained. They do not mix — deployment topology says nothing about a seam inside a model, and gradient flow says nothing about a seam between services.

## Dependency categories: authored code

When assessing a candidate for deepening, classify its dependencies. The category determines how the deepened module is tested across its seam.

### 1. In-process

Pure computation, in-memory state, no I/O. Always deepenable: merge the modules and test through the new interface directly. No adapter needed.

### 2. Local-substitutable

Dependencies that have local test stand-ins (PGLite for Postgres, in-memory filesystem). Deepenable if the stand-in exists. The deepened module is tested with the stand-in running in the test suite. The seam is internal; no port at the module's external interface.

### 3. Remote but owned (Ports & Adapters)

Your own services across a network boundary (microservices, internal APIs). Define a **port** (interface) at the seam. The deep module owns the logic; the transport is injected as an **adapter**. Tests use an in-memory adapter. Production uses an HTTP/gRPC/queue adapter.

Recommendation shape: *"Define a port at the seam, implement an HTTP adapter for production and an in-memory adapter for testing, so the logic sits in one deep module even though it's deployed across a network."*

### 4. True external (Mock)

Third-party services (Stripe, Twilio, etc.) you don't control. The deepened module takes the external dependency as an injected port; tests provide a mock adapter.

## Dependency categories: learned modules

For a trained module the substitutability question is not *where does this dependency run* but *what survives the seam when you train through it*. Classify on the gradient.

### 1. Differentiable

Gradient flows both ways; the two sides co-adapt. Always mergeable — but note that merging is not free: co-adaptation means the deepened module's blocks are no longer separately meaningful, which is the trade in [SKILL.md](SKILL.md)'s *depth trades against legibility*. Deepen here only when the internal factorization is not the claim.

### 2. Stop-gradient / detached

The seam passes activations forward and no gradient back (a target network, a frozen encoder's output, a written memory read later). This is a **real seam** with a real interface: the downstream block must decode a representation it cannot ask to be changed. Denials are stated here (see the interface's *negative half*), and this is where an instrument is needed to make any claim about what the seam carries.

### 3. Discrete / non-differentiable

The seam carries a symbol, an index, a sampled action, a hard routing decision. Substitutable only through an estimator — straight-through, REINFORCE-style, or a relaxation — and the estimator is part of the interface, because its bias and variance are facts the downstream block's training depends on. Never treat the estimator as a hidden implementation detail; a change of estimator is a change of contract.

### 4. Frozen / external

A pretrained component or a fixed dataset process you do not train. The analogue of a true external dependency: the deepened module takes it as an injected seam adapter, and evaluation must include at least one substitution (a different frozen backbone, a shuffled or ablated input) or the seam is untested and the result may be an artifact of that one component.

**Test-side substitution** in all four cases means an ablation or a swap, not a mock. The test that a seam is real is that the system's behaviour changes in the predicted direction when what crosses it is cut, shuffled, or replaced.

## Seam discipline

- **One adapter means a hypothetical seam. Two adapters means a real one.** Don't introduce a port unless at least two adapters are justified (typically production + test). A single-adapter seam is just indirection.
- **Internal seams vs external seams.** A deep module can have internal seams (private to its implementation, used by its own tests) as well as the external seam at its interface. Don't expose internal seams through the interface just because tests use them.

## Testing strategy: replace, don't layer

Applies to **authored code only**. For a learned module, add — never replace: a change of decomposition is not behaviour-preserving, and the old evaluation is the only comparison between the old shape and the new one. See *Do not replace tests — add them* in [SKILL.md](SKILL.md).

- Old unit tests on shallow modules become waste once tests at the deepened module's interface exist; delete them.
- Write new tests at the deepened module's interface. The **interface is the test surface**.
- Tests assert on observable outcomes through the interface, not internal state.
- Tests should survive internal refactors, since they describe behaviour, not implementation. If a test has to change when the implementation changes, it's testing past the interface.
