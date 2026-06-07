# File: largest-unique-number/solution.py

**Date:** 2026-06-06
**Time:** 17:18

## Purpose

This file implements the solution to LeetCode problem **1133 - Largest Unique Number**. It owns exactly one responsibility: given a list of integers, find the largest one that appears exactly once. If no such integer exists, return `-1`.

It's one of ~500+ problem solutions in the `leetcode-implementations` repo, following the standard per-problem directory layout (`solution.py`, `test_solution.py`, `plan.md`, `review.md`).

## Key Components

### `largest_unique_number(nums: list[int]) -> int`

The sole public function. Contract:

- **Input**: a list of integers (may contain duplicates, may be empty)
- **Output**: the largest integer with count == 1, or `-1` if every element is duplicated or the list is empty
- **Side effects**: none — pure function

## Patterns

**Count-filter-reduce**: a three-step idiom common across this repo's solutions:

1. **Count** — `Counter(nums)` builds a frequency map in O(n)
2. **Filter** — list comprehension keeps only elements where `c == 1`
3. **Reduce** — `max()` extracts the answer, with an empty-check guard

The ternary `max(uniques) if uniques else -1` avoids a `ValueError` from calling `max()` on an empty sequence. This is the idiomatic Python approach — no sentinel values or try/except needed.

## Dependencies

**Imports**: `collections.Counter` — the only dependency. No custom modules, no framework code.

**Imported by**: The `largest-unique-number/test_solution.py` file imports this function. The massive "Imported By" list in the prompt is misleading — those are test files for *other* problems that happen to share a common test harness or import pattern, not direct consumers of this function.

## Flow

```
nums → Counter(nums) → {value: count} → filter(count == 1) → max() or -1
```

For input `[5, 7, 3, 9, 4, 9, 8, 3, 1]`:
1. `Counter` → `{5:1, 7:1, 3:2, 9:2, 4:1, 8:1, 1:1}`
2. Filter → `[5, 7, 4, 8, 1]`
3. `max()` → `8`

## Invariants

- The return value is always an `int` — either an element from `nums` or the literal `-1`
- `-1` is returned if and only if `uniques` is empty (no element has count 1)
- Elements with count > 1 are never candidates, regardless of their magnitude

## Error Handling

None explicit. The function relies on `Counter` accepting any iterable and `max()` being guarded by the truthiness check on `uniques`. An empty input list produces an empty `Counter`, an empty `uniques` list, and returns `-1` — the correct answer per the problem spec.

## Topics to Explore

- [file] `largest-unique-number/test_solution.py` — See what edge cases are covered (empty list, all duplicates, single element)
- [file] `largest-unique-number/review.md` — Read the code review for alternative approaches and complexity analysis
- [function] `sum-of-unique-elements/solution.py:sum_of_unique_elements` — Near-identical count-filter-reduce pattern but with `sum()` instead of `max()`
- [general] `counter-based-solutions` — Explore how many solutions in this repo use `Counter` as the core data structure
- [file] `largest-unique-number/plan.md` — Understand the planning/reasoning that led to this approach choice

## Beliefs

- `largest-unique-returns-minus-one-on-empty` — `largest_unique_number([])` returns `-1` because `Counter({})` yields no items with count 1
- `counter-filter-max-is-o-n` — The solution runs in O(n) time and O(n) space where n is `len(nums)`, since `Counter` is a single pass and the filter/max are bounded by the number of distinct values
- `uniqueness-means-count-exactly-one` — The filter `c == 1` enforces that "unique" means appearing exactly once, not "distinct"; `[3, 3]` has no unique numbers
- `no-exception-on-all-duplicates` — The ternary guard `if uniques` prevents `ValueError` from `max()` on an empty list, making `-1` the only error signal

