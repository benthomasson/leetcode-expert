# File: height-checker/solution.py

**Date:** 2026-06-06
**Time:** 17:00

## Height Checker — `height-checker/solution.py`

### Purpose

Solves [LeetCode 1051 — Height Checker](https://leetcode.com/problems/height-checker/): given an array of student heights, count how many students are standing in the wrong position relative to the non-decreasing sorted order. This file owns the single solution function and is imported by `height-checker/test_solution.py`.

### Key Components

**`height_checker(heights: list[int]) -> int`** — The sole public function. Takes a list of heights (values 1–100) and returns the number of indices where the current order disagrees with the sorted order.

### Patterns

**Counting sort.** Instead of calling `sorted()` (O(n log n)), the solution exploits the constrained value range (1–100) to sort in O(n + k) where k=100. It builds a frequency array `counts` of size 101 (index 0 unused), then walks through it to reconstruct the sorted order on the fly — without ever materializing the sorted array.

**Single-pass comparison against virtual sorted order.** The variable `j` acts as a cursor into the conceptual sorted array. For each element in `heights`, the code advances `j` past any exhausted values (`counts[j] == 0`), compares `h` to `j` (the next expected sorted value), and decrements the count. This fuses the "generate sorted array" and "compare" steps into one loop.

### Dependencies

- **Imports:** None — pure stdlib, no external dependencies.
- **Imported by:** `height-checker/test_solution.py` directly. The "Imported By" list in the prompt is misleading — those are unrelated test files that happen to share a common test harness pattern, not actual consumers of `height_checker`.

### Flow

1. **Build frequency table** — iterate `heights`, incrementing `counts[h]` for each value. O(n).
2. **Walk sorted order** — iterate `heights` a second time. For each `h`:
   - Advance `j` until `counts[j] > 0` (skip values with zero remaining count).
   - If `h != j`, the student is out of position — increment `mismatches`.
   - Decrement `counts[j]` to "consume" one instance of that sorted value.
3. **Return** `mismatches`.

### Invariants

- **Value range [1, 100]:** The 101-element array assumes heights are in this range. Values outside it would index out of bounds or be silently ignored at index 0.
- **`j` only advances forward:** Because the sorted order is non-decreasing, `j` never needs to backtrack. Each value in `counts` is consumed exactly once across the full loop, so the total inner `while` iterations across all outer iterations is O(k).
- **Total counts consumed equals n:** Every element contributes +1 during the build phase and exactly -1 during the comparison phase, so the frequency table reaches all zeros by the end.

### Error Handling

None. The function trusts its input matches the LeetCode contract (non-empty list, values 1–100). Out-of-range values would cause an `IndexError` (values > 100) or silently pollute index 0 (value 0). Empty input would return 0 correctly since the loop body wouldn't execute.

---

## Topics to Explore

- [file] `height-checker/test_solution.py` — See which edge cases are covered (empty, single element, already sorted, reverse sorted)
- [file] `height-checker/review.md` — Read the code review for alternative approaches and complexity discussion
- [general] `counting-sort-pattern` — Other solutions in this repo that use counting sort for constrained integer ranges (e.g., `relative-sort-array`, `sort-array-by-increasing-frequency`)
- [function] `height-checker/solution.py:height_checker` — Trace through with input `[1,1,4,2,1,3]` to see how `j` advances and `counts` drains
- [file] `height-checker/plan.md` — The planning doc that motivated choosing counting sort over `sorted()`

## Beliefs

- `height-checker-counting-sort` — `height_checker` uses counting sort (O(n+k), k=100) rather than comparison sort, exploiting the constraint that heights are in [1, 100]
- `height-checker-no-sorted-array-materialized` — The sorted order is never stored as a list; comparison happens inline by walking the frequency array with cursor `j`
- `height-checker-j-monotonic` — The cursor `j` only advances forward across the outer loop, making the total inner `while` iterations O(k) amortized, not O(n*k)
- `height-checker-assumes-positive-heights` — Index 0 of `counts` is allocated but never used; the code starts `j` at 1, implicitly assuming all heights are >= 1

