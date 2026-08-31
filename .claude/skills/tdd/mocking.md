# When to Mock

Mock at **system boundaries** only:

- External services (a remote API, a job scheduler, a metrics sink)
- Storage: checkpoints, datasets on disk (prefer a tmp dir with real files)
- Time/randomness (seed instead of mocking wherever you can)
- Anything slow enough that a test would never be run: a full training run, a large pretrained checkpoint

Don't mock:

- Your own modules, layers, or transforms
- Internal collaborators
- Anything you control
- Numerics. A mocked tensor op tests nothing — run it on a 4-dimensional toy input instead.

## Designing for Mockability

At system boundaries, design interfaces that are easy to substitute:

**1. Use dependency injection**

Pass external dependencies in rather than creating them internally:

```python
# Easy to substitute
def evaluate(model, dataset):
    return dataset.score(model)

# Hard to substitute
def evaluate(model):
    dataset = load_from_s3(os.environ["EVAL_BUCKET"])
    return dataset.score(model)
```

The same applies to randomness: take a `numpy.random.Generator` (or a seed) as an argument rather than calling the global RNG.

**2. Prefer named operations over one generic caller**

Create a specific function per external operation instead of one generic function with conditional logic:

```python
# GOOD: each operation is independently substitutable
class CheckpointStore:
    def save(self, step, state): ...
    def load(self, step): ...
    def latest_step(self): ...

# BAD: substituting requires conditional logic inside the fake
class CheckpointStore:
    def call(self, op, **kwargs): ...
```

The named approach means:
- Each fake returns one specific shape
- No conditional logic in test setup
- Easier to see which operations a test exercises
- Type safety per operation

**3. Prefer a real toy over a mock**

A 2-layer model on 16 synthetic examples runs in milliseconds and exercises the real code path. Reach for it before reaching for a mock — most "too slow to test" claims dissolve at toy scale.
