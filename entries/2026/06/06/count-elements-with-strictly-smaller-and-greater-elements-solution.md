# File: count-elements-with-strictly-smaller-and-greater-elements/solution.py

**Date:** 2026-06-06
**Time:** 15:57

## `count-elements-with-strictly-smaller-and-greater-elements/solution.py`

### Purpose

This file solves [LeetCode 2148: Count Elements With Strictly Smaller and Greater Elements](https://leetcode.com/problems/count-elements-with-strictly-smaller-and-greater-elements/). It's a standalone solution module following the repo's convention of one problem per directory, each with a `solution.py` exporting a single function.

### Key Components

**`min_moves(nums: list[int]) -> int`** — The sole public function. Despite the name (which matches the LeetCode class method naming), it counts how many elements in `nums` are strictly between the global minimum and maximum. An element qualifies if and only if `min(nums) < x < max(nums)`.

The contract is simple: pass a list of integers, get back an integer count. The function is pure — no mutation, no side effects.

### Patterns

- **Precompute-then-scan**: Computes `min_val` and `max_val` once (O(n) each), then makes a single pass with a generator expression to count qualifying elements. This avoids recomputing min/max per element.
- **Generator expression inside `sum()`**: A standard Python idiom that avoids materializing an intermediate list. Each `1` is yielded lazily and accumulated.
- **Flat function, no class**: The repo uses bare functions rather than wrapping them in a `Solution` class as LeetCode does. Test files import the function directly.

### Dependencies

**Imports**: None — pure stdlib, no external packages.

**Imported by**: The `test_solution.py` in the same directory, plus hundreds of other test files across the repo. That sprawling `imported_by` list is an artifact of the test harness structure (likely a shared conftest or test runner importing all solution modules), not a sign that other solutions depend on this logic.

### Flow

1. `min(nums)` scans the list → `min_val`
2. `max(nums)` scans the list → `max_val`
3. Generator iterates `nums`, yields `1` for each `x` where `min_val < x < max_val`
4. `sum()` accumulates the count
5. Returns the integer count

Total: three linear passes over `nums`. Time complexity is O(n), space complexity is O(1) (the generator doesn't allocate a list).

### Invariants

- If all elements are equal, `min_val == max_val`, so the strict inequality `min_val < x < max_val` is never satisfied → returns 0. This correctly handles the edge case.
- If the list has exactly 1 or 2 elements, min and max are either equal or adjacent values with no "interior" elements possible — again returns 0 or the correct count without special-casing.
- Elements equal to the min or max are excluded by the strict `<` operators.

### Error Handling

None. Calling `min()` or `max()` on an empty list raises `ValueError`. The function does not guard against this — the LeetCode constraint guarantees `nums` has at least 1 element, so this is by design, not an oversight.

---

## Topics to Explore

- [file] `count-elements-with-strictly-smaller-and-greater-elements/test_solution.py` — See how edge cases (all-equal, two-element, single-element) are exercised
- [file] `count-elements-with-strictly-smaller-and-greater-elements/review.md` — The code review captures design trade-offs and correctness analysis
- [function] `average-salary-excluding-the-minimum-and-maximum-salary/solution.py:average` — A structurally similar "exclude min/max then aggregate" pattern worth comparing
- [general] `solution-naming-conventions` — Why functions use names like `min_moves` instead of matching LeetCode's method signatures, and how the test harness discovers them

## Beliefs

- `min-moves-excludes-boundary-values` — `min_moves` uses strict inequality (`<`), so elements equal to `min(nums)` or `max(nums)` are never counted
- `min-moves-returns-zero-for-uniform-lists` — When all elements are identical, `min_val == max_val` makes the condition `min_val < x < max_val` unsatisfiable, returning 0
- `min-moves-no-empty-list-guard` — The function will raise `ValueError` on an empty input list; it relies on the caller (LeetCode constraints) to guarantee non-empty input
- `min-moves-linear-time-constant-space` — Three O(n) passes and a generator make this O(n) time, O(1) auxiliary space

