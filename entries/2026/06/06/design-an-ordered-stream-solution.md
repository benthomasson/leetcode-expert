# File: design-an-ordered-stream/solution.py

**Date:** 2026-06-06
**Time:** 16:16

## Purpose

This file implements [LeetCode 1656 — Design an Ordered Stream](https://leetcode.com/problems/design-an-ordered-stream/). It solves the problem of buffering out-of-order inserts and releasing values only when a contiguous prefix is available — essentially a reordering buffer with a read pointer.

## Key Components

### `OrderedStream`

A class with two methods:

- **`__init__(self, n: int)`** — Allocates a fixed-size list of `None` values and initializes a pointer `self.ptr` at index 0. The list is pre-sized to `n` because IDs are 1-indexed and bounded by `n`.

- **`insert(self, idKey: int, value: str) -> List[str]`** — Places `value` at `idKey - 1` (converting from 1-indexed to 0-indexed), then scans forward from `self.ptr`, collecting all non-`None` values into a result list. The pointer advances past every collected value and stays there for the next call.

## Patterns

**Monotonic pointer scan**: The pointer only moves forward, never backward. Each element is visited by the pointer at most once across all `insert` calls, giving O(n) total pointer work amortized over n inserts.

**Pre-allocated buffer with sentinel**: Uses `None` as a sentinel to distinguish filled vs. unfilled slots. This avoids needing a separate "filled" set or bitmap.

## Dependencies

**Imports**: Only `List` from `typing` — no external or project dependencies.

**Imported by**: `design-an-ordered-stream/test_solution.py`. The massive "Imported By" list in the prompt is an artifact of the repo's test infrastructure, not actual imports of this module.

## Flow

1. Caller creates `OrderedStream(n)` — a buffer of `n` slots and a pointer at 0.
2. Each `insert(idKey, value)` writes to slot `idKey - 1`.
3. The while loop drains all contiguous non-`None` slots starting at `self.ptr`.
4. If the inserted slot is ahead of the pointer (gap exists), the loop body never executes and an empty list is returned.
5. If the inserted slot fills the gap the pointer was waiting on, the loop flushes all contiguous ready values.

## Invariants

- **Pointer monotonicity**: `self.ptr` only increases. Every slot at index `< self.ptr` has been returned exactly once.
- **No duplicate IDs**: The problem guarantees each `idKey` is inserted exactly once. If duplicates were inserted, the second write would silently overwrite — no guard against this.
- **1-indexed to 0-indexed mapping**: `idKey - 1` is used everywhere. Valid `idKey` range is `[1, n]`; passing 0 or `n+1` would be an out-of-bounds access.

## Error Handling

None. The code trusts that callers respect the LeetCode contract (valid `idKey` range, no duplicates). An out-of-range `idKey` would raise `IndexError` from the list access.

## Topics to Explore

- [file] `design-an-ordered-stream/test_solution.py` — See what edge cases are tested (single element, reverse-order inserts, already-contiguous inserts)
- [file] `design-an-ordered-stream/review.md` — The code review may note complexity analysis or alternative approaches
- [general] `amortized-pointer-analysis` — Why the while loop is O(n) total across all calls despite appearing inside each insert
- [function] `design-compressed-string-iterator/solution.py:StringIterator` — Another stateful iterator design in this repo, useful for comparing pointer-based patterns

## Beliefs

- `ordered-stream-amortized-linear` — Total pointer movement across all n insert calls is O(n), making each insert O(1) amortized
- `ordered-stream-none-sentinel` — `None` is the only sentinel value; inserting `None` as a value would break the contiguity scan
- `ordered-stream-no-input-validation` — No bounds checking on `idKey` and no duplicate detection; the code relies entirely on the LeetCode contract
- `ordered-stream-pointer-monotonic` — `self.ptr` never decreases; once a value is returned it is never returned again

