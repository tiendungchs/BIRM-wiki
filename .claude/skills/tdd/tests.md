# Good and Bad Tests

## Good Tests

**Integration-style**: Test through real interfaces, not mocks of internal parts.

```python
# GOOD: Tests observable behavior
def test_bound_pair_is_recoverable_by_unbinding():
    memory = VSAMemory(dim=1024, seed=0)
    memory.bind("colour", "red")
    assert memory.unbind("colour") == "red"
```

Characteristics:

- Tests behavior callers care about
- Uses public API only
- Survives internal refactors
- Describes WHAT, not HOW
- One logical assertion per test

## Bad Tests

**Implementation-detail tests**: Coupled to internal structure.

```python
# BAD: Tests implementation details
def test_bind_calls_circular_convolution(mocker):
    conv = mocker.patch("vsa.circular_convolution")
    VSAMemory(dim=1024).bind("colour", "red")
    conv.assert_called_once()
```

Red flags:

- Mocking internal collaborators
- Testing private methods
- Asserting on call counts/order
- Test breaks when refactoring without behavior change
- Test name describes HOW not WHAT
- Verifying through external means instead of interface

```python
# BAD: Bypasses interface to verify
def test_bind_writes_the_trace_array():
    memory = VSAMemory(dim=1024)
    memory.bind("colour", "red")
    assert memory._trace.sum() != 0

# GOOD: Verifies through interface
def test_bind_makes_the_pair_queryable():
    memory = VSAMemory(dim=1024)
    memory.bind("colour", "red")
    assert memory.query("colour") == "red"
```

**Tautological tests**: Expected value restates the implementation, so the test passes by construction.

```python
# BAD: Expected value is recomputed the way the code computes it
def test_entropy_of_uniform():
    p = np.full(4, 0.25)
    expected = -(p * np.log2(p)).sum()
    assert entropy(p) == pytest.approx(expected)

# GOOD: Expected value is an independent, known literal
def test_entropy_of_uniform():
    assert entropy(np.full(4, 0.25)) == pytest.approx(2.0)
```

**Stochastic tests**: A model test whose verdict depends on the seed is not a test.

```python
# BAD: Passes or fails depending on the run
def test_model_learns():
    assert train(steps=200).accuracy > 0.9

# GOOD: Seeded, and asserts the property the code actually guarantees
def test_training_reduces_loss_monotonically_on_a_seeded_toy_task():
    losses = train(steps=200, seed=0).losses
    assert losses[-1] < losses[0] / 2
```
