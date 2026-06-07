# File: two-sum-iii-data-structure-design/solution.py

**Date:** 2026-06-06
**Time:** 19:33

## Purpose

This file implements LeetCode problem **170 - Two Sum III (Data Structure Design)**. It provides a class that supports two operations: adding numbers to a multiset, and querying whether any pair of previously-added numbers sums to a given target. It's the streaming/online variant of the classic Two Sum problem — instead of a fixed array, numbers arrive incrementally.

## Key Components

### `TwoSum` class

A stateful data structure with two methods:

- **`__init__`**: Initializes `self.counts` as an empty `Counter` — a frequency map tracking how many times each number has been added.

- **`add(number: int) -> None`**: Increments the count for `number`. O(1) amortized.

- **`find(value: int) -> bool`**: Iterates all distinct numbers in the multiset. For each `num`, computes `complement = value - num` and checks two cases:
  - **`complement != num`**: A different number is needed — just check if `complement` exists in `counts`.
  - **`complement == num`**: The same number is needed twice — check if `counts[num] >= 2`.

  Returns `True` on first match, `False` after exhausting all keys. O(n) where n is the number of distinct values.

## Patterns

**Hash-based complement lookup** — the same pattern as classic Two Sum, but adapted for a streaming context. Instead of building a set during a single pass over a fixed array, the `Counter` accumulates state across multiple `add` calls.

**Self-pairing guard** — the `complement != num` branch prevents a number from pairing with itself unless it was added at least twice. This is the critical subtlety in the problem; without the count check, `add(3); find(6)` would incorrectly return `True`.

## Dependencies

- **Imports**: `collections.Counter` — used as the backing frequency map.
- **Imported by**: `two-sum-iii-data-structure-design/test_solution.py` (the "Imported By" list in the prompt is the full test suite across all problems — an artifact of how the repo is structured, not actual cross-problem imports).

## Flow

1. Client creates a `TwoSum()` instance.
2. Client calls `add(n)` repeatedly — each call is a single `Counter` increment.
3. Client calls `find(value)` — the method performs a linear scan over the keys of `counts`, computing the complement for each and checking existence/count. Short-circuits on first hit.

## Invariants

- `self.counts[x]` always equals the exact number of times `x` has been added. This count is never decremented.
- `find` never mutates state — it's a pure query.
- A number can only pair with itself if it appears with multiplicity >= 2.

## Error Handling

None. The class assumes valid integer inputs per the LeetCode contract. No bounds checking, no exception handling. `Counter.__getitem__` returns 0 for missing keys, so the `complement in self.counts` check is the only guard needed.

## Topics to Explore

- [file] `two-sum/solution.py` — The original Two Sum on a fixed array; compare the one-shot hash approach with this streaming variant
- [file] `two-sum-iv-input-is-a-bst/solution.py` — Two Sum variant on a BST; contrasts hash-based lookup with tree traversal strategies
- [file] `two-sum-less-than-k/solution.py` — Two Sum variant with an inequality constraint; likely uses sorting + two pointers instead of hashing
- [general] `add-vs-find-optimization-tradeoff` — This solution optimizes `add` to O(1) at the cost of O(n) `find`; the inverse (precompute all sums on add, O(1) find) is better when finds dominate
- [file] `two-sum-iii-data-structure-design/test_solution.py` — Verify which edge cases are covered (duplicate adds, self-pairing, negative numbers)

## Beliefs

- `two-sum-iii-find-is-linear` — `find()` is O(n) in the number of distinct added values, scanning all keys of the Counter
- `two-sum-iii-add-is-constant` — `add()` is O(1) amortized, performing a single Counter increment
- `two-sum-iii-self-pair-requires-count-two` — A number can only pair with itself to reach a target sum if it has been added at least twice
- `two-sum-iii-find-is-read-only` — `find()` never modifies `self.counts`; interleaving adds and finds in any order is safe
- `two-sum-iii-counter-default-zero` — The implementation relies on `Counter` returning 0 for missing keys, avoiding KeyError without explicit checks

