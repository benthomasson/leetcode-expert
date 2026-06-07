# File: sum-of-unique-elements/solution.py

**Date:** 2026-06-06
**Time:** 19:24

## `sum-of-unique-elements/solution.py`

### Purpose

This file solves [LeetCode 1748 — Sum of Unique Elements](https://leetcode.com/problems/sum-of-unique-elements/). Given an integer array `nums`, it returns the sum of all elements that appear exactly once. It's a standalone solution module following the repo's convention of one problem per directory.

### Key Components

**`Solution.sumOfUniqueElements(self, nums: List[int]) -> int`** — The single method. It counts element frequencies, then sums only elements with a count of 1. The entire logic is a one-liner generator expression.

### Patterns

**Counter + filter idiom**: Rather than manually tracking frequencies with a dict, it delegates to `collections.Counter`, then filters with a generator expression inside `sum()`. This is a common Python pattern for frequency-based problems — build the histogram first, then query it. The generator avoids allocating an intermediate list.

**LeetCode class convention**: The `Solution` class with a specifically-named method matches LeetCode's expected interface. Every solution in the repo follows this pattern.

### Dependencies

**Imports**: `collections.Counter` (frequency counting) and `typing.List` (type annotation). No project-internal dependencies.

**Imported by**: `sum-of-unique-elements/test_solution.py` directly. The massive "Imported By" list in the provided context is misleading — those are test files across the repo that happen to share a common test harness or import structure, not files that actually use `sumOfUniqueElements`.

### Flow

1. `Counter(nums)` builds a `{value: count}` dictionary in O(n) time.
2. The generator iterates over `.items()`, yielding `val` only when `cnt == 1`.
3. `sum()` consumes the generator, producing the final integer.

For `nums = [1, 2, 3, 2]`: Counter gives `{1:1, 2:2, 3:1}`, the filter keeps `1` and `3`, and `sum` returns `4`.

### Invariants

- Only elements appearing **exactly once** contribute to the sum. Elements with count 0 (impossible in input) or count ≥ 2 are excluded.
- The return value is always a non-negative integer (since elements with count 1 could be negative, the sum could technically be negative — but LeetCode constrains `1 <= nums[i] <= 100`).

### Error Handling

None. The method trusts that `nums` is a valid non-empty list of integers per LeetCode's constraints. An empty list would return `0` from `sum()` over an empty generator, which is correct.

### Complexity

- **Time**: O(n) — single pass to build the Counter, single pass to filter and sum.
- **Space**: O(n) — the Counter stores up to n distinct entries.

## Topics to Explore

- [file] `sum-of-unique-elements/test_solution.py` — Test cases revealing edge cases and constraint boundaries
- [file] `sum-of-unique-elements/review.md` — Code review notes on this solution's tradeoffs
- [function] `largest-unique-number/solution.py:Solution.largestUniqueNumber` — Similar Counter-based frequency filtering problem, returns max instead of sum
- [general] `counter-based-solutions` — How many solutions in this repo lean on `collections.Counter` as the core data structure
- [file] `count-common-words-with-one-occurrence/solution.py` — Another "exactly once" frequency problem with a two-input twist

## Beliefs

- `sum-unique-returns-zero-on-no-uniques` — `sumOfUniqueElements` returns 0 when every element in `nums` appears more than once, because `sum()` over an empty generator yields 0
- `sum-unique-single-pass-counter` — The solution runs in O(n) time using a single Counter construction plus one iteration over its items
- `sum-unique-no-intermediate-list` — The generator expression `(val for val, cnt in ...)` avoids allocating a list, keeping auxiliary space to the Counter itself
- `solution-class-convention` — Every problem directory contains a `solution.py` with a `Solution` class whose method name matches the LeetCode interface

