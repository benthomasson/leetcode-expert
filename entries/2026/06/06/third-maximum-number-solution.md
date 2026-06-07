# File: third-maximum-number/solution.py

**Date:** 2026-06-06
**Time:** 19:28

## Purpose

This file solves [LeetCode 414 — Third Maximum Number](https://leetcode.com/problems/third-maximum-number/). It owns a single responsibility: given a list of integers, return the third distinct maximum, or fall back to the overall maximum if fewer than three distinct values exist.

## Key Components

### `third_max(nums: list[int]) -> int`

The sole public function. Contract:

- **Input**: A non-empty list of integers (may contain duplicates).
- **Output**: The third-largest *distinct* value, or the largest value if fewer than 3 distinct values exist.
- **No mutation**: The input list is never modified.

## Patterns

**Three-variable tracking with `None` sentinels.** Instead of using a set or sorted structure, the solution maintains exactly three variables (`first`, `second`, `third`) initialized to `None`. This is a common competitive-programming idiom for "top-K distinct" problems — it avoids allocating extra data structures and runs in O(n) time with O(1) space.

**Duplicate skipping via tuple membership.** Line `if n in (first, second, third)` filters duplicates by checking against all three tracked values. This works because `None in (first, second, third)` is always true when a slot is `None` — but the check happens *before* the comparison branches, and a `None` slot means "not yet filled," so a duplicate `None` value in `nums` is impossible (integers only). The `None` sentinel is safe here because `nums` contains only `int` values, never `None`.

**Cascading demotion.** When a new maximum is found (`n > first`), the current `first` is demoted to `second`, and `second` to `third`, via tuple unpacking: `first, second, third = n, first, second`. This single-line swap avoids temporary variables and guarantees no value is lost.

## Dependencies

- **Imports**: None — pure stdlib, no external dependencies.
- **Imported by**: Exclusively consumed by `third-maximum-number/test_solution.py`. The massive "Imported By" list in the prompt is a red herring — those are unrelated test files; they don't actually import this module.

## Flow

1. Initialize `first`, `second`, `third` to `None`.
2. For each `n` in `nums`:
   - Skip if `n` equals any tracked value (dedup).
   - If `n` beats `first`: cascade all three down and install `n` as `first`.
   - Else if `n` beats `second`: cascade `second` → `third`, install `n` as `second`.
   - Else if `n` beats `third`: install `n` as `third`.
3. Return `third` if it was filled, otherwise `first` (the global max).

The entire pass is a single linear scan — O(n) time, O(1) space.

## Invariants

- After the loop, `first >= second >= third` among non-`None` values, and all three are distinct.
- `first` is never `None` after the loop (input is guaranteed non-empty).
- `third is not None` implies at least 3 distinct values were seen.
- The duplicate check on line 15 ensures `first`, `second`, `third` are always mutually distinct (or `None`).

## Error Handling

None. The function assumes the caller upholds the precondition (non-empty list of integers). An empty list would cause the function to return `None` (since `first` stays `None`), which violates the `-> int` return type — but this matches LeetCode's guarantee that `nums` is non-empty.

## Topics to Explore

- [file] `third-maximum-number/test_solution.py` — See which edge cases (duplicates, negatives, exactly 3 elements) are covered
- [file] `third-maximum-number/plan.md` — Understand the planning rationale and whether alternative approaches were considered
- [general] `top-k-tracking-pattern` — Compare this three-variable approach with heap-based or sorted-set alternatives across the repo
- [function] `kth-largest-element-in-a-stream/solution.py:KthLargest` — Contrast the heap-based approach for the streaming variant of this problem
- [file] `third-maximum-number/review.md` — Check if the review flagged any edge cases or alternative approaches

## Beliefs

- `third-max-linear-time` — `third_max` runs in O(n) time and O(1) space with a single pass over the input
- `third-max-none-sentinel` — `None` is safe as a sentinel because the input domain is `int` only; no value in `nums` can collide with `None`
- `third-max-distinct-guarantee` — The duplicate-skip guard ensures `first`, `second`, and `third` are always mutually distinct when non-`None`
- `third-max-fallback-semantics` — When fewer than 3 distinct values exist, the function returns the global maximum (`first`), not an error

