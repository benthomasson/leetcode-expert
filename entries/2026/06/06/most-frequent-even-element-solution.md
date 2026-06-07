# File: most-frequent-even-element/solution.py

**Date:** 2026-06-06
**Time:** 18:07

## Purpose

This file is a self-contained LeetCode solution for [problem 2404: Most Frequent Even Element](https://leetcode.com/problems/most-frequent-even-element/). It owns both the algorithm implementation and its test suite in a single module — the standard pattern across this repository's ~500+ problem directories.

## Key Components

### `most_frequent_even(nums: list[int]) -> int`

The sole public function. Contract:

- **Input**: A list of non-negative integers.
- **Output**: The most frequent even element. If there's a tie in frequency, returns the smallest among the tied values. Returns `-1` if no even elements exist.

### `TestMostFrequentEven` (unittest.TestCase)

Nine test cases covering:
- LeetCode's three provided examples (basic, dominant element, all-odd)
- Edge cases: single even, single odd, zero, all-same
- Tie-breaking: two-way tie, four-way tie — both verify the "smallest wins" rule

## Patterns

**Filter-count-select via `Counter`**: The solution uses a generator expression inside `Counter()` to simultaneously filter (even only) and count in one pass. This is a common idiom in this repo for frequency problems — it avoids a separate filtering step.

**Composite sort key for tie-breaking**: `min(counts, key=lambda x: (-counts[x], x))` is a classic Python trick. By negating the count, `min` finds the *maximum* frequency first, then among ties picks the smallest value. This collapses what would otherwise be a two-pass operation (find max freq, then filter and min) into a single `min` call.

**Inline tests**: Tests live in the same file as the solution rather than in a separate `test_solution.py`. The `test_solution.py` file exists in the directory but likely imports from this module.

## Dependencies

**Imports**:
- `collections.Counter` — frequency counting
- `unittest` — test framework

**Imported by**: The `test_solution.py` files listed in the "Imported By" section (~400+ files) suggest a shared test harness or import pattern across the repo. The function is likely imported by `most-frequent-even-element/test_solution.py` directly, while the other test files listed are probably a repo-wide cross-reference artifact (they don't actually import *this* file — they follow the same structural pattern).

## Flow

1. Build a `Counter` over only even elements: `Counter(x for x in nums if x % 2 == 0)`
2. If the counter is empty (no even elements), return `-1`
3. Find the element with the highest count, breaking ties by smallest value, using `min` with a composite key `(-count, value)`

The entire algorithm is O(n) time and O(n) space where n is the length of `nums`.

## Invariants

- The function never raises — it returns `-1` as the sentinel for "no even elements" rather than raising `ValueError` or returning `None`.
- Tie-breaking is deterministic: smallest value always wins among equally frequent elements.
- Zero is treated as even (which is mathematically correct and tested explicitly).

## Error Handling

There is none, by design. The function assumes valid input per the LeetCode contract (non-empty list of non-negative integers). No input validation, no try/except. Empty counter is the only "error" path and it returns the sentinel `-1`.

## Topics to Explore

- [file] `most-frequent-even-element/test_solution.py` — See how the external test file imports and exercises this solution, and whether it adds cases beyond the inline tests
- [file] `most-frequent-even-element/review.md` — Code review notes may document alternative approaches or performance observations
- [function] `most-frequent-number-following-key-in-an-array/solution.py:mostFrequentFollowingKey` — A related frequency-counting problem that likely uses a similar Counter pattern with different filtering logic
- [general] `counter-with-tiebreak-pattern` — Several solutions in this repo (largest-unique-number, count-common-words) use the same Counter + composite-key-min/max idiom — worth comparing implementations
- [file] `run_tests.py` — The repo-level test runner that orchestrates test execution across all problem directories

## Beliefs

- `most-frequent-even-returns-negative-one-sentinel` — `most_frequent_even` returns -1 (not None or an exception) when the input contains no even numbers
- `tiebreak-selects-smallest-value` — When multiple even elements share the highest frequency, the function returns the numerically smallest one
- `single-pass-filter-and-count` — Even filtering and frequency counting happen in a single pass via a generator inside `Counter()`, not as separate list comprehension + count steps
- `zero-is-even` — The function correctly classifies 0 as an even number, verified by an explicit test case

