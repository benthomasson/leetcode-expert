# File: make-array-zero-by-subtracting-equal-amounts/solution.py

**Date:** 2026-06-06
**Time:** 17:30

## `make-array-zero-by-subtracting-equal-amounts/solution.py`

### Purpose

This file solves [LeetCode 2357: Make Array Zero by Subtracting Equal Amounts](https://leetcode.com/problems/make-array-zero-by-subtracting-equal-amounts/). It belongs to a repository of LeetCode solutions, each in its own directory with a standard layout (`solution.py`, `test_solution.py`, `plan.md`, `review.md`).

The problem: given a non-negative integer array, in each operation you choose the smallest positive element `x` and subtract `x` from every positive element. Return how many operations it takes to make the entire array zero.

### Key Components

**`Solution.minOperations(self, nums: List[int]) -> int`** — The single method. It computes the answer in O(n) time and O(n) space with a one-liner:

```python
return len(set(nums) - {0})
```

This converts `nums` to a set (deduplicating values), removes `0`, and returns the count of remaining distinct values.

### Patterns

**Set-based reduction** — The solution recognizes that each operation eliminates exactly one distinct positive value from the array. When you subtract the current minimum positive value, all elements equal to that minimum become zero, and the relative differences between larger elements are preserved. So the total number of operations equals the number of distinct positive values.

This is a common LeetCode pattern: translating a simulation problem into a counting/set problem by identifying what each operation actually eliminates.

### Dependencies

**Imports**: `List` from `typing` — used only for the type annotation on the method signature.

**Imported by**: `make-array-zero-by-subtracting-equal-amounts/test_solution.py` imports the `Solution` class. The large "Imported By" list in the prompt is an artifact of the repository tooling and reflects test files across the entire repo, not direct consumers of this module.

### Flow

1. `set(nums)` — deduplicate all values → O(n)
2. `- {0}` — set difference removes zero → O(1)
3. `len(...)` — count remaining distinct positive values → O(1)

No loops, no mutation, no intermediate state.

### Invariants

- `nums` contains only non-negative integers (problem constraint). The code doesn't validate this but would still return a correct count for any integer list since negative values would simply be counted as distinct non-zero values.
- The return value is always `>= 0`. If all elements are zero, `set(nums) - {0}` is empty, so `len(...)` is `0`.

### Error Handling

None. The method trusts the caller to pass a valid `List[int]`. An empty list returns `0` (correct). No exceptions are raised or caught.

## Topics to Explore

- [file] `make-array-zero-by-subtracting-equal-amounts/test_solution.py` — Verify edge cases covered (all zeros, single element, all distinct)
- [file] `make-array-zero-by-subtracting-equal-amounts/plan.md` — See the reasoning that led to the set-based insight vs. simulation
- [file] `make-array-zero-by-subtracting-equal-amounts/review.md` — Check if alternative approaches (sorting, simulation) were considered and rejected
- [general] `set-reduction-pattern` — Other problems in this repo where simulation reduces to counting distinct values (e.g., `count-distinct-numbers-on-board`)
- [function] `run_tests.py:main` — How the test harness discovers and runs solution tests across all problem directories

## Beliefs

- `min-ops-equals-distinct-positives` — `minOperations` returns the count of distinct positive values in the input, which equals the number of simulation steps
- `zero-removal-correctness` — Removing `{0}` from the set is necessary because zeros don't generate an operation; without it, an array like `[0, 0, 0]` would incorrectly return `1`
- `no-mutation` — The method is pure: it does not modify the input `nums` list
- `linear-time-constant-passes` — The solution runs in O(n) time with a single pass to build the set, compared to O(n * k) for naive simulation where k is the number of distinct positive values

