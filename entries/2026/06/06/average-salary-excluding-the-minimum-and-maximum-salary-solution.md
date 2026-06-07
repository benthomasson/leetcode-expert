# File: average-salary-excluding-the-minimum-and-maximum-salary/solution.py

**Date:** 2026-06-06
**Time:** 15:18

## Purpose

This file solves [LeetCode 1491: Average Salary Excluding the Minimum and Maximum Salary](https://leetcode.com/problems/average-salary-excluding-the-minimum-and-maximum-salary/). It computes the mean of a salary list after dropping the single smallest and single largest values. It follows the repo's convention of one `Solution` class per problem directory.

## Key Components

**`Solution.average(salary: List[int]) -> float`** — The sole method. Takes a list of unique integer salaries (guaranteed length >= 3 by the problem constraints) and returns the average of all elements except the min and max.

## Patterns

The solution uses a **single-pass arithmetic** approach rather than sorting. It computes `sum()`, `min()`, and `max()` — each an O(n) traversal — then derives the trimmed average algebraically:

```
(total - min - max) / (n - 2)
```

This avoids allocating a sorted copy (O(n log n)) and instead relies on three linear scans. Python's built-in functions make this both concise and readable.

## Dependencies

- **Imports**: `typing.List` — standard type annotation, no external dependencies.
- **Imported by**: `average-salary-excluding-the-minimum-and-maximum-salary/test_solution.py` directly. The massive "Imported By" list in the prompt is misleading — those are test files for *other* problems that happen to share a common test harness pattern, not actual consumers of this module's `Solution` class.

## Flow

1. Sum all salaries → `total`
2. Subtract `min(salary)` and `max(salary)` from `total`
3. Divide by `len(salary) - 2` (the count of remaining elements)
4. Return the float result

No intermediate data structures, no mutation of the input.

## Invariants

- **Unique salaries**: The problem guarantees all values are distinct, so `min` and `max` each correspond to exactly one element. If duplicates existed at the extremes, only one copy would be subtracted, producing a wrong answer.
- **Length >= 3**: The divisor `len(salary) - 2` must be positive. With fewer than 3 elements, this would divide by zero or negative.

## Error Handling

None. The method trusts LeetCode's input guarantees. No validation of list length, no check for duplicates, no guard against empty input. This is appropriate — LeetCode solutions operate within a well-defined contract enforced by the judge.

## Topics to Explore

- [file] `average-salary-excluding-the-minimum-and-maximum-salary/test_solution.py` — See what edge cases the tests cover (e.g., minimum-length input of 3 elements)
- [file] `mean-of-array-after-removing-some-elements/solution.py` — A related "trimmed mean" problem that removes the top and bottom 5%, likely uses sorting instead of min/max subtraction
- [function] `average-of-levels-in-binary-tree/solution.py:averageOfLevels` — Another averaging problem but over tree levels, showing how the same arithmetic pattern adapts to different data structures
- [general] `sum-minus-extremes-vs-sort` — Whether this algebraic approach (sum - min - max) versus sort-and-slice is a recurring choice across the repo's solutions

## Beliefs

- `average-salary-single-pass-arithmetic` — The solution avoids sorting by computing sum/min/max independently, making it O(n) time and O(1) extra space
- `average-salary-unique-values-invariant` — Correctness depends on all salary values being unique; duplicate min or max values would cause the subtraction to remove only one copy
- `average-salary-no-input-validation` — The method performs no bounds checking or duplicate detection, relying entirely on LeetCode's problem constraints
- `average-salary-divisor-assumes-length-gte-3` — The expression `len(salary) - 2` would produce a ZeroDivisionError if called with fewer than 3 elements

