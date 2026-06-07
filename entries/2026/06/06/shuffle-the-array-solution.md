# File: shuffle-the-array/solution.py

**Date:** 2026-06-06
**Time:** 19:06

## `shuffle-the-array/solution.py`

### Purpose

This file solves [LeetCode 1470 — Shuffle the Array](https://leetcode.com/problems/shuffle-the-array/). It takes an array of `2n` elements structured as `[x1, x2, ..., xn, y1, y2, ..., yn]` and interleaves the two halves to produce `[x1, y1, x2, y2, ..., xn, yn]`.

### Key Components

**`Solution.shuffle(nums, n)`** — The sole method. Takes the full array and the half-length `n`, returns a new list with elements interleaved.

- **Contract**: `nums` has exactly `2n` elements. `n` splits the array into two equal halves. The caller (LeetCode harness) guarantees `1 <= n <= 500`.

### Patterns

- **Index arithmetic over slicing**: Rather than slicing `nums[:n]` and `nums[n:]` and zipping, it uses a single loop with offset indexing (`nums[i]` and `nums[n + i]`). This avoids allocating intermediate lists.
- **New-list construction**: Builds `result` from scratch rather than mutating `nums` in-place. This is the simplest correct approach — in-place interleaving for this problem requires bit-packing tricks that aren't worth the complexity.

### Dependencies

- **Imports**: `typing.List` — used only for the type annotation on the method signature.
- **Imported by**: `shuffle-the-array/test_solution.py` and (per the provided list) hundreds of other test files — likely an artifact of a shared test harness or import pattern across the repo, not actual usage of this solution class.

### Flow

1. Initialize empty `result` list.
2. Loop `i` from `0` to `n - 1`:
   - Append `nums[i]` (the i-th element from the first half).
   - Append `nums[n + i]` (the i-th element from the second half).
3. Return `result`.

For input `[2, 5, 1, 3, 4, 7]` with `n = 3`: the loop pairs `(2,3)`, `(5,4)`, `(1,7)` → output `[2, 3, 5, 4, 1, 7]`.

### Invariants

- After `i` iterations of the loop, `result` contains exactly `2i` elements: the first `i` pairs interleaved.
- The method never mutates `nums`.
- Time is O(n), space is O(n) for the output list.

### Error Handling

None. The method trusts its inputs — no bounds checking on `n` vs `len(nums)`. This is standard for LeetCode solutions where input constraints are guaranteed by the problem.

## Topics to Explore

- [file] `shuffle-the-array/test_solution.py` — See what edge cases the tests cover (n=1, large arrays, duplicate values)
- [file] `shuffle-the-array/plan.md` — Read the planning notes to understand if alternative approaches (zip, in-place) were considered
- [file] `shuffle-the-array/review.md` — Check if the review flagged any complexity or style issues
- [general] `in-place-interleave` — The O(1) space version of this problem uses cycle-leader or encoding tricks; worth comparing
- [function] `shuffle-string/solution.py:Solution.restoreString` — A related permutation-based shuffle problem in this repo

## Beliefs

- `shuffle-returns-new-list` — `shuffle` always returns a newly allocated list and never mutates the input `nums`
- `shuffle-output-length-equals-input` — The returned list has exactly `2n` elements, same as the input
- `shuffle-linear-time` — The algorithm runs in O(n) time with a single pass over the indices
- `shuffle-no-validation` — No runtime checks exist for `len(nums) == 2*n`; the method relies on caller-guaranteed preconditions

