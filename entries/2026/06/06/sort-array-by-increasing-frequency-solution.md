# File: sort-array-by-increasing-frequency/solution.py

**Date:** 2026-06-06
**Time:** 19:10

## `sort-array-by-increasing-frequency/solution.py`

### Purpose

This file solves [LeetCode 1636 — Sort Array by Increasing Frequency](https://leetcode.com/problems/sort-array-by-increasing-frequency/). It's one of ~400+ problem solutions in the `leetcode-implementations` repo, each following the same structure: a `solution.py` with the core algorithm, a `test_solution.py` for validation, and optional `plan.md`/`review.md` files.

### Key Components

**`num_sub(nums: list[int]) -> list[int]`** — The sole public function. Takes an integer array and returns a new array sorted by two criteria:

1. **Primary**: ascending frequency (elements that appear fewer times come first)
2. **Secondary**: descending value (among elements with the same frequency, larger values come first)

The function name `num_sub` is a repo-wide convention — every solution exposes this same entry point regardless of the problem.

### Patterns

The entire solution is a single `sorted()` call with a composite sort key: `(freq[x], -x)`. This exploits Python's tuple comparison — it sorts by the first element, then breaks ties with the second. Negating `x` reverses the natural ordering for the tiebreaker, giving descending-by-value within each frequency group.

Using `Counter` for frequency counting + `sorted` with a lambda key is the idiomatic Python approach for frequency-based sorting problems. No in-place mutation — the input is untouched.

### Dependencies

**Imports**: `collections.Counter` — standard library, used for O(n) frequency counting.

**Imported by**: The massive `imported_by` list is misleading. Those are test files across the entire repo that share a common test harness or import pattern — they don't actually depend on this solution's logic. Only `sort-array-by-increasing-frequency/test_solution.py` directly tests this function.

### Flow

1. `Counter(nums)` builds a `{value: count}` dictionary in a single pass — O(n).
2. `sorted()` produces a new list using the key `(freq[x], -x)` — O(n log n).
3. The sorted list is returned directly.

Total: O(n log n) time, O(n) space.

### Invariants

- The output always contains exactly the same elements as the input (it's a permutation, not a filter).
- Elements with frequency 1 always appear before elements with frequency 2, etc.
- Within a frequency group, `5` appears before `3` appears before `1` (descending value).
- The negation trick (`-x`) assumes integer inputs. It would not generalize to non-numeric types.

### Error Handling

None. The function trusts its caller to pass a valid `list[int]`. Empty lists work correctly (`sorted([])` returns `[]`). This is consistent with the repo convention — solutions mirror LeetCode's constraints and don't add defensive validation.

## Topics to Explore

- [file] `sort-array-by-increasing-frequency/test_solution.py` — See what edge cases are tested (empty arrays, all-same-frequency, negatives)
- [file] `sort-array-by-increasing-frequency/review.md` — Check if the review flagged the `num_sub` naming or the negation trick's limitation
- [function] `relative-sort-array/solution.py:num_sub` — A related frequency/custom-order sorting problem worth comparing approaches
- [general] `python-sort-stability` — Python's sort is stable (Timsort), which matters when reasoning about tiebreaking behavior in multi-key sorts
- [file] `sort-integers-by-the-number-of-1-bits/solution.py` — Another composite-key sorting problem; compare how the key tuple is constructed

## Beliefs

- `frequency-sort-uses-composite-tuple-key` — The sort key `(freq[x], -x)` encodes both criteria in a single tuple, relying on Python's lexicographic tuple comparison rather than chaining separate sorts.
- `negation-trick-requires-integers` — The tiebreaker `−x` only produces correct descending order for numeric types; applying this pattern to strings or other non-numeric types would fail.
- `num-sub-is-pure` — `num_sub` has no side effects and does not mutate its input; it returns a new list.
- `counter-single-pass` — Frequency counting via `Counter(nums)` is O(n) and happens exactly once before the sort, not inside the key function (the key function does O(1) dict lookups).

