# File: pascals-triangle-ii/solution.py

**Date:** 2026-06-06
**Time:** 18:29

## Pascal's Triangle II — `solution.py`

### Purpose

This file solves [LeetCode 119: Pascal's Triangle II](https://leetcode.com/problems/pascals-triangle-ii/). Given a 0-indexed row number, it returns that single row of Pascal's triangle. Unlike the Pascal's Triangle I problem (which returns all rows up to `n`), this variant asks for just one row — and this solution exploits that by using O(k) space rather than O(k^2).

### Key Components

**`get_row(row_index: int) -> list[int]`** — The sole public function. Takes a 0-indexed row number and returns the corresponding row as a list of integers.

### Patterns

**In-place row mutation.** The core trick is updating a single list in reverse order to avoid overwriting values that are still needed. This is a classic space-optimization pattern for DP problems where only the previous state matters.

The algorithm works like this on each iteration `i` (building row `i` from row `i-1`):

1. Walk the existing list **right-to-left** (`range(len(row) - 1, 0, -1)`), adding `row[j-1]` into `row[j]`. The reverse traversal is critical — going left-to-right would corrupt values before they're read as inputs.
2. Append `1` to extend the row by one element.

For example, building row 3 (`[1,3,3,1]`) from row 2 (`[1,2,1]`):
- `j=2`: `row[2] += row[1]` → `[1, 2, 3]`
- `j=1`: `row[1] += row[0]` → `[1, 3, 3]`
- Append 1 → `[1, 3, 3, 1]`

The leading `1` is never modified (loop stops at `j=1`), and the trailing `1` is always appended fresh.

### Dependencies

**Imports:** None. Pure computation with no external dependencies.

**Imported by:** Hundreds of test files across the repo import this (listed in the "Imported By" section). This is an artifact of the project's test infrastructure — the test files likely share a common import pattern or test runner, not because they actually use `get_row`. The direct consumer is `pascals-triangle-ii/test_solution.py`.

### Flow

1. Initialize `row = [1]` (row 0).
2. Loop `i` from 1 to `row_index` inclusive.
3. Inner loop mutates existing elements right-to-left: each `row[j]` becomes the sum of itself and its left neighbor.
4. Append `1` to grow the row.
5. Return the completed row.

### Invariants

- **Reverse traversal order is load-bearing.** Changing the inner loop to left-to-right breaks correctness — `row[j-1]` would already be updated when `row[j]` reads it.
- **Row always starts and ends with 1.** The leading `1` from initialization is never overwritten (loop excludes `j=0`). The trailing `1` is explicitly appended.
- **Space is O(row_index).** Only one list is maintained, growing by one element per outer iteration.
- **Time is O(row_index^2).** The inner loop grows linearly with `i`, summing to a triangular number.
- **Valid input range:** `0 <= row_index <= 33` per the docstring (matching LeetCode constraints). No guard against negative inputs.

### Error Handling

None. The function trusts its caller to provide a non-negative integer. For `row_index=0`, the outer loop doesn't execute and `[1]` is returned correctly.

## Topics to Explore

- [file] `pascals-triangle/solution.py` — The sibling problem that returns all rows; compare to see why this one can use O(k) space while that one cannot
- [function] `pascals-triangle-ii/solution.py:get_row` — Trace through `row_index=4` by hand to internalize why reverse iteration preserves correctness
- [general] `in-place-dp-space-optimization` — This reverse-traversal trick appears in many DP problems (0/1 knapsack, coin change variants) where you reduce 2D DP to 1D
- [file] `pascals-triangle-ii/test_solution.py` — Check which edge cases are covered (row 0, row 33, interior values)

## Beliefs

- `pascals-triangle-ii-reverse-traversal` — The inner loop must traverse right-to-left; left-to-right would use already-updated values and produce incorrect results
- `pascals-triangle-ii-space-linear` — The solution uses O(row_index) space by mutating a single list in place rather than building all prior rows
- `pascals-triangle-ii-no-validation` — The function performs no input validation; negative or non-integer inputs will silently produce wrong results or errors
- `pascals-triangle-ii-row-zero-correct` — For `row_index=0`, the loop body never executes and `[1]` is returned, which is correct

