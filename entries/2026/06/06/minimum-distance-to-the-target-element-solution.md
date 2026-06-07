# File: minimum-distance-to-the-target-element/solution.py

**Date:** 2026-06-06
**Time:** 17:57

## `minimum-distance-to-the-target-element/solution.py`

### Purpose

This file solves [LeetCode 1848 — Minimum Distance to the Target Element](https://leetcode.com/problems/minimum-distance-to-the-target-element/). It's one of ~500 problem solutions in the `leetcode-implementations` repo, each following the same directory convention: `{problem-slug}/solution.py`.

The file owns exactly one responsibility: given an array, a target value, and a starting index, find the closest index containing the target.

### Key Components

**`get_min_distance(nums, target, start) -> int`** — The sole public function. It takes a list of integers, a target value, and a starting index, and returns the minimum absolute distance `|i - start|` across all indices `i` where `nums[i] == target`.

The contract is simple: the caller guarantees that `target` exists in `nums` at least once (per the problem constraints). The function returns a non-negative integer.

### Patterns

**Generator expression inside `min()`** — The entire solution is a single expression. It uses a generator (not a list comprehension), so it streams candidates into `min()` without materializing a full list. This is idiomatic Python for "find the best match across a filtered set."

**`enumerate` for index+value iteration** — Standard Python idiom to avoid manual index tracking.

**Single-pass linear scan** — No sorting, no binary search, no preprocessing. It walks the array once, evaluating every element. For this problem's constraints (array length up to 10^4), this is the right call — anything fancier would be over-engineering.

### Dependencies

**Imports**: None. The function uses only builtins (`min`, `abs`, `enumerate`).

**Imported by**: The "Imported By" list in the prompt is misleading — those are test files across many other problems, likely an artifact of a shared test harness or import scanning tool picking up the entire solution directory. The real consumer is `minimum-distance-to-the-target-element/test_solution.py`.

### Flow

1. `enumerate(nums)` yields `(index, value)` pairs.
2. The generator filter `if v == target` keeps only indices where the value matches.
3. `abs(i - start)` computes the distance for each matching index.
4. `min()` selects the smallest distance.

There's no intermediate state, no mutation, no branching — it's a pure functional pipeline.

### Invariants

- **Target must exist in `nums`**: If no element matches `target`, the generator is empty and `min()` raises `ValueError`. The function relies on the caller (or LeetCode's constraints) to guarantee at least one match.
- **`start` is a valid index**: The function doesn't bounds-check `start`. It doesn't need to — `start` is only used in the distance calculation, not as an array index.

### Error Handling

None. If the precondition (target exists in nums) is violated, `min()` raises `ValueError` with "min() arg is an empty sequence". This is the right behavior for a LeetCode solution — fail loud rather than return a nonsensical value.

---

## Topics to Explore

- [file] `minimum-distance-to-the-target-element/test_solution.py` — See what edge cases the test suite covers (empty matches, target at start, multiple occurrences)
- [file] `minimum-distance-to-the-target-element/review.md` — Code review notes may document alternative approaches or complexity analysis
- [function] `find-nearest-point-that-has-the-same-x-or-y-coordinate/solution.py:get_nearest_valid_point` — A structurally similar "find nearest matching element" problem worth comparing
- [general] `linear-scan-vs-binary-search-for-nearest` — When the array is sorted, binary search finds the nearest target in O(log n); this problem doesn't guarantee sorted input, so linear scan is optimal

## Beliefs

- `min-distance-linear-time` — `get_min_distance` runs in O(n) time and O(1) space via a single-pass generator
- `min-distance-no-imports` — The solution uses only Python builtins; it has zero import dependencies
- `min-distance-precondition-target-exists` — `get_min_distance` raises `ValueError` if `target` is absent from `nums`; it does not handle this case internally
- `min-distance-generator-not-list` — The solution uses a generator expression (lazy) inside `min()`, not a list comprehension, avoiding allocation of an intermediate list

