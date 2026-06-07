# File: minimum-recolors-to-get-k-consecutive-black-blocks/solution.py

**Date:** 2026-06-06
**Time:** 18:00

## Purpose

This file solves [LeetCode 2379: Minimum Recolors to Get K Consecutive Black Blocks](https://leetcode.com/problems/minimum-recolors-to-get-k-consecutive-black-blocks/). Given a string of `'W'` (white) and `'B'` (black) characters, it finds the minimum number of white blocks you'd need to repaint black to create a contiguous run of `k` black blocks.

It owns exactly one responsibility: the `min_operations` function.

## Key Components

### `min_operations(blocks: str, k: int) -> int`

**Contract**: Given a string `blocks` containing only `'W'` and `'B'`, and an integer `k` where `1 <= k <= len(blocks)`, returns the minimum number of recolors (white-to-black) needed to produce `k` consecutive black blocks.

## Patterns

**Fixed-size sliding window.** This is the textbook application: maintain a count over a window of size `k`, slide it one position at a time, and track the minimum.

The implementation avoids recomputing the count from scratch each step. Instead, it updates incrementally by adding the incoming element and removing the outgoing one. The expression `(blocks[i] == "W") - (blocks[i - k] == "W")` exploits Python's `bool`-to-`int` coercion — `True` becomes `1`, `False` becomes `0` — to do the add/remove in a single arithmetic statement.

## Dependencies

**Imports**: None. Pure standard Python.

**Imported by**: The `test_solution.py` in the same directory. The "Imported By" list in the prompt is misleading — those are all unrelated test files for other problems, likely an artifact of the indexing tool matching on a shared test harness pattern, not actual imports of this module.

## Flow

1. **Initialize window** (line 14): Count `'W'`s in `blocks[0:k]` using `str.count`. This is the cost of making the *first* window all-black.
2. **Set baseline** (line 15): `min_ops = white_count`.
3. **Slide** (lines 18–19): For each position `i` from `k` to `len(blocks) - 1`:
   - Add 1 if `blocks[i]` is `'W'` (entering the window).
   - Subtract 1 if `blocks[i - k]` is `'W'` (leaving the window).
   - Update `min_ops` if the new count is lower.
4. **Return** `min_ops`.

## Invariants

- The window always has exactly `k` elements. The loop index `i` is the right edge; `i - k` is the element just left of the window.
- `white_count` is always the exact number of `'W'`s in the current window `blocks[i-k+1 : i+1]`.
- `min_ops` is monotonically non-increasing or stays the same — it never rises.

## Error Handling

None. The function trusts its inputs match the LeetCode constraints. If `k > len(blocks)`, `blocks[:k].count("W")` still works (counts over the full string), but the loop body never executes, so you'd get the count of `'W'`s in the entire string — which would be a valid but semantically wrong answer for an invalid input. No validation is performed; this is typical for LeetCode solutions.

## Topics to Explore

- [file] `minimum-recolors-to-get-k-consecutive-black-blocks/test_solution.py` — See the test cases and edge cases exercised against this solution
- [file] `diet-plan-performance/solution.py` — Another fixed-size sliding window problem; compare the window update pattern
- [file] `maximum-average-subarray-i/solution.py` — Classic sliding window over numeric arrays; contrast with this string-based variant
- [general] `sliding-window-variants` — How fixed-size windows (this problem) differ from variable-size windows (e.g., minimum window substring)

## Beliefs

- `sliding-window-o1-update` — `min_operations` updates the window count in O(1) per step by adding/removing single elements, not recomputing over the full window
- `bool-int-coercion-trick` — The increment expression relies on Python's `True == 1` / `False == 0` to combine add and remove into one arithmetic operation
- `no-input-validation` — `min_operations` performs no validation on `blocks` content or the relationship between `k` and `len(blocks)`
- `initial-window-uses-str-count` — The first window's white count is computed via `str.count("W")` rather than the same incremental logic used for subsequent windows

