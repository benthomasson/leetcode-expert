# File: check-if-an-array-is-consecutive/solution.py

**Date:** 2026-06-06
**Time:** 15:37

## Purpose

This file solves [LeetCode 2229: Check if an Array is Consecutive](https://leetcode.com/problems/check-if-an-array-is-consecutive/). It determines whether a given integer array contains every number in the contiguous range `[min, min + n - 1]` — i.e., the elements form a complete consecutive sequence regardless of order. The file is self-contained: solution class and unit tests in one module.

## Key Components

### `Solution.isConsecutive(nums: List[int]) -> bool`

The core method. It checks two conditions that together are necessary and sufficient for consecutiveness:

1. **No duplicates**: `len(set(nums)) == n` — if any value repeats, the array can't cover `n` distinct consecutive integers.
2. **Range matches length**: `max(nums) - min(nums) + 1 == n` — the span of values exactly equals the count of elements.

Both conditions together guarantee every integer in `[min, max]` is present exactly once.

### `TestIsConsecutive`

Eight test cases covering:
- Positive examples: `[1,3,4,2]`, `[3,5,4]`, single elements, zero-start
- Negative examples: `[1,3]` (gap), duplicates `[1,1,2,3]`, gap in middle `[1,2,4,5]`
- Boundary: single-element arrays with `0` and `100000`

## Patterns

- **Set-based uniqueness check** — converting to a set and comparing lengths is the standard O(n) duplicate detection idiom in Python.
- **Range-span identity** — instead of sorting or building a complete set of expected values, it exploits the mathematical property that `n` unique integers are consecutive iff their range equals `n - 1`. This avoids O(n log n) sorting.
- **Inline tests** — solution and tests colocated in one file, consistent with the repo convention visible across all problem directories.

## Dependencies

**Imports**: `typing.List` (type annotation), `unittest` (test framework). No project-internal dependencies.

**Imported by**: The "Imported By" list in the prompt is misleading — those are unrelated test files across the repo, not actual importers of this module. The file is standalone.

## Flow

1. Compute `n = len(nums)`.
2. Build `num_set = set(nums)` — O(n) time, O(n) space.
3. If the set is smaller than the array, duplicates exist → return `False`.
4. Check if the value range `max - min + 1` equals `n`. If so, the unique values span exactly `n` consecutive integers → return `True`.

The method makes two passes for `max`/`min` (could be one, but Python's builtins are C-optimized so this is fine in practice).

## Invariants

- **Uniqueness before range check**: The duplicate check must come first. Without it, `[1, 1, 3]` would pass the range check (`3 - 1 + 1 == 3`) despite not being consecutive.
- **Assumes non-empty input**: The method calls `max(nums)` and `min(nums)` without guarding against empty lists. This matches the LeetCode constraint (`1 <= nums.length`).

## Error Handling

None. Empty input would raise `ValueError` from `max()`/`min()`. The LeetCode contract guarantees `nums` is non-empty, so no defensive check is needed.

## Topics to Explore

- [file] `can-make-arithmetic-progression-from-sequence/solution.py` — Related problem: checking if elements form an arithmetic progression (consecutive is the special case with difference 1)
- [file] `missing-number/solution.py` — Uses similar set/math reasoning to find the one missing value in a consecutive range
- [general] `set-vs-sort-for-uniqueness` — This solution chose set over sort; understanding when each is preferable (sort for follow-up queries, set for one-shot checks)
- [file] `find-all-numbers-disappeared-in-an-array/solution.py` — Extends the "consecutive range" concept to finding all missing values, often with O(1) space tricks

## Beliefs

- `consecutive-requires-both-checks` — The duplicate check (`len(set) == n`) and range check (`max - min + 1 == n`) are both required; either alone has false positives (e.g., `[1,1,3]` passes range-only, `[1,2,4]` passes uniqueness-only).
- `consecutive-check-is-linear` — `isConsecutive` runs in O(n) time and O(n) space, avoiding sorting.
- `consecutive-assumes-nonempty` — The method has no empty-input guard; it relies on the LeetCode constraint `len(nums) >= 1`.
- `consecutive-solution-is-self-contained` — The file has no project-internal imports; it depends only on `typing` and `unittest`.

