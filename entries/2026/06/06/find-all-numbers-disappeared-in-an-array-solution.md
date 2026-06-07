# File: find-all-numbers-disappeared-in-an-array/solution.py

**Date:** 2026-06-06
**Time:** 16:33

## Purpose

This file solves [LeetCode 448 — Find All Numbers Disappeared in an Array](https://leetcode.com/problems/find-all-numbers-disappeared-in-an-array/). Given an array `nums` of `n` integers where each value is in `[1, n]`, it returns all integers in that range that do not appear in the array. The constraint that matters: it must be solvable in O(n) time without extra space (beyond the output).

## Key Components

### `find_disappeared_numbers(nums: list[int]) -> list[int]`

Single function, single responsibility. Takes the array, returns the missing numbers.

**Contract**: `nums` contains values in `[1, n]` where `n = len(nums)`. The function **mutates** `nums` in place as a side effect — callers get back correct results but the input array is destroyed.

## Patterns

**In-place negation marking** — the core technique. Since every value maps to a valid index (`val - 1`), the array itself becomes a visited-set by flipping signs:

1. **Mark phase** (lines 8–10): For each value, compute `idx = abs(num) - 1` and negate `nums[idx]` if it's positive. The `abs()` is critical — values encountered later in the scan may already have been negated by an earlier iteration, so you need the original magnitude.

2. **Collect phase** (line 12): Any index `i` where `nums[i]` is still positive means no value `i + 1` existed in the original array.

This is the textbook O(n) time / O(1) space pattern for "find missing/duplicate in [1, n]" problems. The alternative approaches — hash set (O(n) space) or sorting (O(n log n) time) — are strictly worse on the constraint axis this problem tests.

## Dependencies

**Imports**: None. Pure algorithmic code with no dependencies.

**Imported by**: The `test_solution.py` in the same directory. The "Imported By" list in the prompt is misleading — those are unrelated test files across the repo that happen to share a common test harness import pattern, not actual consumers of this function.

## Flow

```
Input: [4, 3, 2, 7, 8, 2, 3, 1]    (n=8, missing: 5 and 6)

Mark phase — iterate and negate at (abs(val) - 1):
  4 → negate idx 3:  [4, 3, 2, -7, 8, 2, 3, 1]
  3 → negate idx 2:  [4, 3, -2, -7, 8, 2, 3, 1]
  2 → negate idx 1:  [4, -3, -2, -7, 8, 2, 3, 1]
  7 → negate idx 6:  [4, -3, -2, -7, 8, 2, -3, 1]
  8 → negate idx 7:  [4, -3, -2, -7, 8, 2, -3, -1]
  2 → idx 1 already negative, skip
  3 → idx 2 already negative, skip
  1 → negate idx 0:  [-4, -3, -2, -7, 8, 2, -3, -1]

Collect phase — positive positions are 4 and 5 (0-indexed):
  → return [5, 6]
```

## Invariants

- **Value-to-index mapping**: Every value `v` maps to index `v - 1`. This only works because values are guaranteed in `[1, n]`.
- **Idempotent marking**: The `if nums[idx] > 0` guard ensures a position is negated at most once, even when duplicates target the same index. Without this guard, a duplicate would double-negate (restore the positive sign) and produce a false "missing" result.
- **`abs()` preserves original value**: Once a cell is negated, subsequent reads of that cell as a *value* (not as a marker) must use `abs()` to recover the original number.

## Error Handling

None. The function assumes valid input per the problem constraints. Values outside `[1, n]` would cause an `IndexError`; non-integer input would fail at `abs()`. This is appropriate for a LeetCode solution where input validity is guaranteed.

## Topics to Explore

- [file] `find-all-numbers-disappeared-in-an-array/test_solution.py` — See what edge cases the test suite covers (empty array, no missing, all duplicates)
- [function] `set-mismatch/solution.py:find_error_nums` — Uses the same negation-marking pattern to find both the duplicate and the missing number
- [function] `missing-number/solution.py:missing_number` — Contrasting approach (XOR or Gauss sum) for the simpler "one missing number" variant
- [general] `in-place-negation-marking` — The family of problems where the `[1, n]` constraint enables using the array as its own hash set (find duplicates, find missing, find all duplicates)

## Beliefs

- `negation-idempotent` — The `if nums[idx] > 0` guard ensures each index is negated exactly once, correctly handling duplicate values
- `mutates-input` — `find_disappeared_numbers` destructively modifies the input array; callers cannot reuse `nums` after the call
- `abs-required-for-values` — Removing the `abs()` call on line 9 would cause `IndexError` on negative indices whenever a previously-marked cell is read as a value
- `linear-time-constant-space` — The algorithm is O(n) time and O(1) auxiliary space (output list excluded), which is strictly better than hash-set or sorting approaches

