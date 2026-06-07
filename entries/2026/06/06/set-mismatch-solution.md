# File: set-mismatch/solution.py

**Date:** 2026-06-06
**Time:** 19:03

## `set-mismatch/solution.py`

### Purpose

This file solves [LeetCode 645 - Set Mismatch](https://leetcode.com/problems/set-mismatch/). Given an array that should contain integers `1` through `n` exactly once, but where one number was duplicated (replacing another), it identifies which number is duplicated and which is missing. Returns `[duplicate, missing]`.

### Key Components

**`Solution.findErrorNums(self, nums: List[int]) -> List[int]`** — The sole method. Takes a corrupted 1-to-n sequence and returns the duplicate and missing numbers as a two-element list.

### Flow

The algorithm uses two passes with a mathematical finish:

1. **Find the duplicate** (lines 12-16): Iterates through `nums`, tracking seen values in a set. The first number already in `seen` is the duplicate.

2. **Find the missing via sum arithmetic** (lines 17-19): The expected sum of `1..n` is `n*(n+1)//2`. The actual sum differs from expected by exactly `missing - duplicate` (since one copy of `missing` was replaced by an extra copy of `duplicate`). Rearranging: `missing = expected_sum - actual_sum + duplicate`.

### Patterns

- **Set-based duplicate detection**: O(n) time, O(n) space. Straightforward and avoids mutating the input array (unlike the in-place sign-flipping variant).
- **Gauss sum formula**: Uses the closed-form `n*(n+1)//2` to avoid a second pass to find the missing element. This is a common idiom across this repo's solutions for problems involving missing/duplicate numbers in a 1-to-n range (see also `missing-number`, `find-all-numbers-disappeared-in-an-array`).

### Dependencies

- **Imports**: `typing.List` — standard type annotation, no external dependencies.
- **Imported by**: `set-mismatch/test_solution.py` — the corresponding test file. The "Imported By" list in the prompt is misleading; those are test files for *other* problems that happen to share a common test harness import pattern, not actual consumers of this solution.

### Invariants

- **Input contract**: `nums` must contain exactly `n` integers from the range `[1, n]` with exactly one value appearing twice and one value missing. The code doesn't validate this — it trusts the LeetCode guarantee.
- **`duplicate` is always found before the sum calculation**: The loop is guaranteed to find a duplicate given valid input, so `duplicate` will never remain `-1` when used on line 19.
- **Integer arithmetic**: Uses `//` for integer division, avoiding float precision issues in the Gauss sum.

### Error Handling

None. The code assumes valid input per LeetCode constraints. If no duplicate exists, `duplicate` stays `-1` and the returned `missing` value will be wrong — but this can't happen under the problem's guarantees.

### Complexity

- **Time**: O(n) — one pass to find the duplicate, O(n) for `sum(nums)`.
- **Space**: O(n) — the `seen` set.

---

## Topics to Explore

- [file] `set-mismatch/test_solution.py` — Verify which edge cases are covered (e.g., duplicate at boundaries, n=2)
- [function] `missing-number/solution.py:Solution.missingNumber` — Compare how the same Gauss sum technique solves the simpler missing-number variant
- [function] `find-all-numbers-disappeared-in-an-array/solution.py:Solution.findDisappearedNumbers` — The generalized version that finds all missing numbers using in-place marking
- [general] `in-place-sign-flipping` — An O(1) space alternative for this problem that negates values at index positions to detect duplicates without a set
- [file] `fair-candy-swap/solution.py` — Another problem that uses sum-difference arithmetic to find a swap pair

## Beliefs

- `set-mismatch-two-pass-sum` — The solution finds the duplicate via a set in one pass, then derives the missing number algebraically from the Gauss sum formula rather than searching for it
- `set-mismatch-linear-space` — The `seen` set makes this O(n) space; an O(1) space solution is possible via in-place index marking but is not used here
- `set-mismatch-no-input-validation` — The code assumes exactly one duplicate and one missing value exist; it does not guard against malformed input
- `set-mismatch-return-order` — The return value is always `[duplicate, missing]`, matching the LeetCode contract for problem 645

