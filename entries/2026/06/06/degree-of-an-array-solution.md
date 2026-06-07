# File: degree-of-an-array/solution.py

**Date:** 2026-06-06
**Time:** 16:14

## `degree-of-an-array/solution.py`

### Purpose

Solves [LeetCode 697 — Degree of an Array](https://leetcode.com/problems/degree-of-an-array/). The "degree" of an array is the maximum frequency of any element. The task is to find the length of the shortest contiguous subarray that has the same degree as the full array — meaning the subarray must contain all occurrences of at least one most-frequent element.

### Key Components

**`findShortestSubArray(nums: list[int]) -> int`** — The sole function. Takes a non-empty list of non-negative integers, returns the length of the shortest qualifying subarray.

Three dictionaries do all the bookkeeping:
- `count` — maps each value to its total frequency
- `first` — maps each value to the index of its first occurrence
- `last` — maps each value to the index of its last occurrence

### Flow

1. **Single pass** over `nums` (lines 12–16): for each element, record its first appearance (only if unseen), always update its last appearance, and increment its count.
2. **Compute degree** (line 18): `max(count.values())` — the highest frequency in the array.
3. **Minimize span** (line 19): among all elements whose count equals `degree`, compute `last[n] - first[n] + 1` and return the minimum.

The insight is that any subarray containing all occurrences of element `n` must span from `first[n]` to `last[n]` inclusive — no shorter subarray can achieve the same count for `n`. So the answer is the minimum such span over all degree-tied elements.

### Patterns

- **Single-pass aggregation**: builds three related maps in one enumeration, avoiding repeated scans.
- **Functional-style reduction**: the final answer is a single `min(... for ...)` generator expression — no intermediate list or explicit loop.
- **No imports**: pure stdlib, no external dependencies.

### Dependencies

**Imports**: None.

**Imported by**: `degree-of-an-array/test_solution.py` (directly). The "Imported By" list in the prompt is misleading — those are unrelated test files that likely share a common test harness import pattern, not actual importers of this function.

### Invariants

- `nums` must be non-empty (otherwise `max(count.values())` raises `ValueError`).
- Every element that appears in `count` also appears in both `first` and `last` — the `if n not in first` guard ensures `first` is set exactly once per value, and `last` is overwritten every time.
- `last[n] >= first[n]` always holds, so span is always >= 1.

### Error Handling

None. The function trusts its input matches the LeetCode contract (non-empty list of non-negative ints). An empty list would crash on `max(count.values())`. No try/except, no validation.

### Complexity

- **Time**: O(n) — one pass to build the maps, one pass over distinct values to find the minimum span.
- **Space**: O(n) — three dictionaries, each with at most n entries.

---

## Topics to Explore

- [file] `degree-of-an-array/test_solution.py` — See which edge cases the tests cover (single element, all identical, ties between multiple degree-holders)
- [file] `degree-of-an-array/plan.md` — Understand the problem decomposition strategy that led to this single-pass approach
- [general] `frequency-first-last-pattern` — This three-map idiom (count/first/last) recurs in problems that ask "shortest window containing all occurrences" — compare with subarray-sum and sliding-window variants
- [function] `sort-array-by-increasing-frequency/solution.py:frequencySort` — Another frequency-counting solution in this repo; compare how frequency maps are used differently
- [file] `degree-of-an-array/review.md` — Check if the review flagged any alternative approaches (e.g., `defaultdict` vs `.get()`, or `Counter`)

## Beliefs

- `single-pass-construction` — All three dictionaries (`count`, `first`, `last`) are fully populated in a single O(n) enumeration; no second scan of `nums` occurs.
- `first-only-set-once` — `first[n]` is written exactly once per distinct value due to the `if n not in first` guard, preserving the earliest index.
- `span-minimum-over-degree-ties` — The return value considers all elements tied at the maximum frequency, not just the first one found.
- `no-input-validation` — An empty `nums` list will raise `ValueError` from `max()` — the function relies on the caller to satisfy the LeetCode precondition.

