# File: fixed-point/solution.py

**Date:** 2026-06-06
**Time:** 16:51

## `fixed-point/solution.py`

### Purpose

This file solves [LeetCode 1064 - Fixed Point](https://leetcode.com/problems/fixed-point/): given a **sorted** array of **distinct** integers, find the smallest index `i` where `arr[i] == i`. It returns `-1` if no such index exists. This is a premium/easy problem that tests whether the solver recognizes binary search applicability on a sorted array.

### Key Components

**`fixedPoint(arr: List[int]) -> int`** — The sole exported function. Contract:

- **Input**: A sorted array of distinct integers.
- **Output**: The smallest fixed-point index, or `-1`.
- **Complexity**: O(log n) time, O(1) space.

### Patterns

**Modified binary search with leftmost-match tracking.** Rather than returning immediately when `arr[mid] == mid`, the function records the match in `result` and continues searching left (`hi = mid - 1`). This guarantees it finds the *smallest* fixed point, not just any fixed point.

The branching logic is:

| Condition | Action | Rationale |
|-----------|--------|-----------|
| `arr[mid] >= mid` | Search left (`hi = mid - 1`) | If `arr[mid] > mid`, all indices to the right are also too large (sorted + distinct means `arr[j] >= arr[mid] + (j - mid) > j` for `j > mid`). If `arr[mid] == mid`, there might still be a smaller fixed point to the left. |
| `arr[mid] < mid` | Search right (`lo = mid + 1`) | By the same sorted+distinct argument, all indices to the left also satisfy `arr[j] < j`. |

This collapses two cases (`arr[mid] > mid` and `arr[mid] == mid`) into a single branch, which is a common binary search idiom for finding the leftmost occurrence.

### Dependencies

- **Imports**: Only `List` from `typing` — no external dependencies.
- **Imported by**: `fixed-point/test_solution.py` directly. The massive "Imported By" list in the prompt is an artifact of the test harness importing a shared test runner, not this solution file specifically.

### Flow

1. Initialize `lo = 0`, `hi = len(arr) - 1`, `result = -1`.
2. While the search window is non-empty (`lo <= hi`):
   - Compute `mid = (lo + hi) // 2`.
   - If `arr[mid] >= mid`: record a match if equal, then narrow to the left half.
   - Else: narrow to the right half.
3. Return `result` (still `-1` if no fixed point was found).

### Invariants

- **Sorted + distinct precondition**: The O(log n) pruning relies on `arr` being sorted with distinct values. If values repeat, the monotonicity argument (`arr[j] - j` is strictly increasing) breaks, and the algorithm can miss valid fixed points.
- **Leftmost guarantee**: By always continuing left after a match, `result` holds the smallest fixed point seen so far when the loop terminates.
- **No mutation**: The input array is never modified.

### Error Handling

None — the function trusts its caller to provide a valid sorted, distinct array. An empty array (`len(arr) == 0`) is handled implicitly: `hi` starts at `-1`, the loop never executes, and `-1` is returned.

---

## Topics to Explore

- [file] `fixed-point/test_solution.py` — See which edge cases are covered (empty array, all negative, fixed point at boundaries)
- [file] `fixed-point/plan.md` — Understand the reasoning process that led to choosing binary search over linear scan
- [function] `binary-search/solution.py:search` — Compare with the standard binary search template in this repo to see how the fixed-point variant diverges
- [general] `sorted-distinct-binary-search-family` — Other problems in this repo that exploit the sorted+distinct property for O(log n) solutions (e.g., `first-bad-version`, `search-insert-position`, `find-smallest-letter-greater-than-target`)

## Beliefs

- `fixed-point-uses-leftmost-binary-search` — The algorithm always continues searching left after finding a match, guaranteeing the smallest fixed point is returned.
- `fixed-point-correctness-requires-distinct-values` — The pruning logic depends on `arr[j] - j` being strictly increasing; duplicate values would break this invariant and could cause missed results.
- `fixed-point-handles-empty-input` — An empty array produces `-1` without any special-case code, because the while-loop condition `lo <= hi` is immediately false when `hi = -1`.
- `fixed-point-single-branch-collapse` — The `arr[mid] > mid` and `arr[mid] == mid` cases share the same search direction (left), differing only in whether `result` is updated — a deliberate simplification over a three-way branch.

