# File: number-of-arithmetic-triplets/solution.py

**Date:** 2026-06-06
**Time:** 18:14

## Purpose

This file solves [LeetCode 2367 — Number of Arithmetic Triplets](https://leetcode.com/problems/number-of-arithmetic-triplets/). Given a **strictly increasing** array `nums` and an integer `diff`, it counts how many triplets `(i, j, k)` satisfy `i < j < k` where `nums[j] - nums[i] == diff` and `nums[k] - nums[j] == diff`.

## Key Components

### `count_arithmetic_triplets(nums, diff) -> int`

The sole exported function. It uses a single-pass, set-based lookup approach rather than the naive O(n³) triple-nested loop.

**Contract:**
- **Input**: `nums` is a strictly increasing list of integers; `diff` is a positive integer.
- **Output**: Count of triplets where consecutive elements differ by exactly `diff`.

## Patterns

**Set-based membership testing.** Instead of checking all `(i, j, k)` combinations, the function builds a `seen` set as it iterates. For each element `x`, it checks whether both `x - diff` and `x - 2*diff` already exist in `seen`. If so, `(x - 2*diff, x - diff, x)` forms a valid triplet.

This is a standard technique for reducing lookup complexity — converting an O(n) scan per element into O(1) hash lookups.

**Single-pass accumulation.** The loop processes each element exactly once, adding it to `seen` *after* checking for triplet membership. This ordering is correct because `nums` is strictly increasing — by the time we reach `x`, any valid `x - diff` and `x - 2*diff` must appear earlier and already be in the set.

## Dependencies

**Imports:** None — pure standard library (uses built-in `set`).

**Imported by:** `number-of-arithmetic-triplets/test_solution.py` directly. The massive "Imported By" list in the prompt is misleading — those are unrelated test files that likely share a common test harness, not actual consumers of this function.

## Flow

1. Initialize empty `seen` set and `count = 0`.
2. For each `x` in `nums` (left to right):
   - Check if `x - diff` is in `seen` (middle element exists).
   - Check if `x - 2 * diff` is in `seen` (first element exists).
   - If both exist, increment `count` — `x` is the largest element of a valid triplet.
   - Add `x` to `seen`.
3. Return `count`.

## Invariants

- **Strict monotonicity assumed.** The algorithm relies on `nums` being strictly increasing. Duplicate values would still work (the set just wouldn't grow), but the problem guarantees uniqueness.
- **Insertion after check.** `seen.add(x)` happens after the triplet check. This prevents an element from being part of its own triplet, though with strictly increasing values and positive `diff`, self-reference is impossible anyway.

## Complexity

- **Time:** O(n) — one pass, three O(1) set operations per element.
- **Space:** O(n) — the `seen` set grows to hold all elements.

This is optimal compared to the brute-force O(n³) and the two-pointer O(n²) alternatives.

## Error Handling

None. The function trusts its inputs match the LeetCode contract (valid list, positive diff). No bounds checking, type validation, or exception handling — appropriate for a competitive programming solution.

## Topics to Explore

- [file] `number-of-arithmetic-triplets/test_solution.py` — See which edge cases the tests cover (empty arrays, single-element, large diff)
- [file] `number-of-arithmetic-triplets/plan.md` — The original approach analysis before implementation
- [file] `number-of-arithmetic-triplets/review.md` — Post-implementation review notes and alternative approaches
- [function] `count-good-triplets/solution.py:count_good_triplets` — Another triplet-counting problem; compare how it handles a more complex constraint (three separate bounds instead of a single diff)
- [general] `set-lookup-optimization` — This pattern (build a set while scanning, check membership for complements) recurs across two-sum, pair-diff, and triplet problems in this repo

## Beliefs

- `arithmetic-triplets-linear-time` — `count_arithmetic_triplets` runs in O(n) time and O(n) space via set-based lookups, not brute-force enumeration
- `arithmetic-triplets-backward-lookup` — The algorithm treats each element as the *largest* of a potential triplet and looks backward for `x - diff` and `x - 2*diff`, which is correct because iteration is left-to-right on a sorted array
- `arithmetic-triplets-no-imports` — The solution uses only Python builtins (set, int) with zero external or standard library imports
- `arithmetic-triplets-insert-after-check` — Each element is added to `seen` after the triplet membership check, ensuring the invariant that only previously-visited elements are candidates

