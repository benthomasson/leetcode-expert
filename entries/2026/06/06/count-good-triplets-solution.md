# File: count-good-triplets/solution.py

**Date:** 2026-06-06
**Time:** 15:58

## Purpose

This file implements the solution to [LeetCode 1534 - Count Good Triplets](https://leetcode.com/problems/count-good-triplets/). It owns the core algorithm for counting all index triplets `(i, j, k)` in an array where `i < j < k` and three absolute-difference constraints are simultaneously satisfied. It's one solution module among hundreds in the `leetcode-implementations` repo, following the same single-class-per-file convention.

## Key Components

**`Solution.countGoodTriplets(arr, a, b, c) -> int`**

The sole public method. Contract:
- **Input**: `arr` (list of ints), and three non-negative integer thresholds `a`, `b`, `c`.
- **Output**: Count of triplets `(i, j, k)` with `i < j < k` satisfying all three conditions: `|arr[i] - arr[j]| <= a`, `|arr[j] - arr[k]| <= b`, `|arr[i] - arr[k]| <= c`.
- **Mutates nothing** — pure function over the input.

## Patterns

**Brute-force triple loop with early pruning.** The outer two loops (`i`, `j`) check the `a`-constraint first; if it fails, the entire `k`-loop is skipped via `continue`. This is the standard O(n^3) approach for this problem, which is acceptable given the LeetCode constraints (n <= 100).

The pruning on line 10 (`if abs(arr[i] - arr[j]) > a: continue`) is the key optimization — it converts a strict O(n^3) into something closer to O(n^2 * m) where m is the average number of valid `j` values per `i`. For inputs where `a` is tight relative to the array's value range, this cuts significant work.

**Loop bound tightening.** `range(n - 2)` and `range(i + 1, n - 1)` ensure there are always enough remaining elements for a valid triplet, avoiding off-by-one issues.

## Dependencies

**Imports**: Only `typing.List` — no external libraries. The algorithm is self-contained.

**Imported by**: The `count-good-triplets/test_solution.py` file (the "Imported By" list in the prompt is the full repo's test suite cross-referencing, not specific to this file — each test file imports its own `Solution`).

## Flow

1. Initialize `count = 0`, get array length `n`.
2. For each `i` in `[0, n-3]`:
   - For each `j` in `[i+1, n-2]`:
     - **Gate**: if `|arr[i] - arr[j]| > a`, skip to next `j`.
     - For each `k` in `[j+1, n-1]`:
       - If both `|arr[j] - arr[k]| <= b` AND `|arr[i] - arr[k]| <= c`, increment `count`.
3. Return `count`.

The two remaining conditions (`b` and `c`) are checked together in a single `if` on line 12, relying on short-circuit evaluation — if the `b`-check fails, the `c`-check is never evaluated.

## Invariants

- Strict index ordering `i < j < k` is guaranteed by loop construction.
- All three constraints must hold simultaneously — there's no partial credit.
- The algorithm is deterministic and order-preserving (indices are enumerated in ascending order).

## Error Handling

None. The method assumes valid input per the LeetCode contract (non-empty array, non-negative thresholds). If `n < 3`, the outer loop's `range(n - 2)` produces an empty range, returning 0 — which is correct.

## Topics to Explore

- [file] `count-good-triplets/test_solution.py` — Verify which edge cases are covered (n < 3, all-same values, tight vs. loose thresholds)
- [file] `count-good-triplets/plan.md` — See if alternative approaches (sorting, prefix sums) were considered and rejected
- [general] `pruning-in-brute-force-triplets` — Whether the `a`-constraint pruning order was chosen deliberately (pruning on the outermost feasible loop maximizes skipped work)
- [function] `number-of-unequal-triplets-in-array/solution.py:countTripletsUnequal` — Compare with another triplet-counting problem to see if a similar pattern or a different algorithmic approach is used
- [file] `count-good-triplets/review.md` — Check if the review flagged the O(n^3) complexity or suggested improvements

## Beliefs

- `count-good-triplets-is-O-n-cubed` — The algorithm is O(n^3) worst-case with an early-exit optimization that prunes the innermost loop when the `a`-constraint fails
- `count-good-triplets-pruning-order` — The `a`-constraint is checked between the second and third loops, meaning failed `(i,j)` pairs skip all `k` iterations; the `b` and `c` constraints are only checked inside the innermost loop
- `count-good-triplets-handles-small-arrays` — Arrays with fewer than 3 elements return 0 without error, via empty `range` behavior
- `count-good-triplets-pure-function` — `countGoodTriplets` has no side effects and does not modify the input array

