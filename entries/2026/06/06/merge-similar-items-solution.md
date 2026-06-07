# File: merge-similar-items/solution.py

**Date:** 2026-06-06
**Time:** 17:46

## `merge-similar-items/solution.py`

### Purpose

This file solves [LeetCode 2363 - Merge Similar Items](https://leetcode.com/problems/merge-similar-items/). It owns a single responsibility: given two lists of `[value, weight]` pairs (each with unique values within its own list), merge them by summing weights for matching values and return the result sorted by value. The file is self-contained — it includes both the solution and its unit tests.

### Key Components

**`sum_weights(items1, items2) -> list[list[int]]`** — The sole public function. Contract:
- **Input**: Two lists of `[value, weight]` pairs. Values are unique within each list but may overlap across lists.
- **Output**: A sorted list of `[value, total_weight]` pairs, where `total_weight` is the sum of weights from both lists for that value.
- **Guarantee**: Output is sorted ascending by value.

**`TestSumWeights`** — Seven test cases covering overlapping items, no overlap, full overlap, single elements, and boundary values (max 1000).

### Patterns

**Accumulator via `defaultdict(int)`** — The classic "group-and-sum" idiom. Instead of checking for key existence, `defaultdict(int)` initializes missing keys to 0, so `weights[value] += weight` works unconditionally for both lists. This collapses what would be a merge-then-aggregate into a single linear scan of each input.

**Sort-at-the-end** — Rather than maintaining sorted order during insertion (which would require a tree or bisect), the function dumps everything into a dict and sorts once at the end. This is O(n log n) in the total number of unique values, which dominates the O(n) insertion.

**Inline tests** — Tests live in the same file as the solution, runnable via `python solution.py`. This is the standard pattern across the entire repository.

### Dependencies

**Imports:**
- `collections.defaultdict` — the only stdlib dependency beyond `unittest`
- `unittest` — test framework

**Imported by:** The `test_solution.py` files listed in the "Imported By" section don't actually import *this* file — that list appears to be a repository-wide cross-reference artifact. The real consumer is `merge-similar-items/test_solution.py`, which likely imports `sum_weights` from this module.

### Flow

1. Create an empty `defaultdict(int)` called `weights`.
2. Iterate over `items1`, adding each `weight` to `weights[value]`.
3. Iterate over `items2`, doing the same — overlapping values accumulate.
4. Build a list comprehension `[v, w]` from `weights.items()`.
5. `sorted()` orders by the first element of each sublist (value), since Python compares lists lexicographically.
6. Return the sorted result.

The entire function is three logical steps: accumulate, project, sort.

### Invariants

- **Uniqueness within each input list** — The problem guarantees values are unique per list. The code doesn't enforce this but doesn't break if violated (it would just sum duplicates within a single list).
- **Output ordering** — The result is always sorted by value ascending. This is enforced by `sorted()` on the final output, not by maintaining order during accumulation.
- **No empty output** — Given the problem constraints (both lists are non-empty), the output will always contain at least one pair.

### Error Handling

None. The function trusts its inputs match the LeetCode contract. No validation of types, lengths, value ranges, or weight non-negativity. This is appropriate for a competitive programming solution where the platform guarantees valid input.

---

## Topics to Explore

- [file] `merge-two-2d-arrays-by-summing-values/solution.py` — Nearly identical problem (LeetCode 2570); compare whether it uses the same defaultdict approach or exploits the pre-sorted input with a two-pointer merge
- [function] `merge-similar-items/test_solution.py:TestSumWeights` — Check whether the external test file duplicates these inline tests or adds additional edge cases
- [general] `defaultdict-vs-counter-pattern` — Several solutions in this repo likely choose between `defaultdict(int)` and `Counter` for aggregation; understanding when each is preferred
- [file] `intersection-of-multiple-arrays/solution.py` — Another set-aggregation problem that may use a different merge strategy worth comparing

---

## Beliefs

- `merge-similar-items-uses-defaultdict-accumulation` — `sum_weights` uses `defaultdict(int)` to merge both lists in O(n) time before a single O(n log n) sort, rather than a two-pointer merge on pre-sorted input.
- `merge-similar-items-output-sorted-by-value` — The return value is always sorted ascending by the first element (value) of each pair, enforced by `sorted()` on the list comprehension.
- `merge-similar-items-no-input-validation` — The function performs no validation on its inputs; it assumes the LeetCode contract (non-empty lists, unique values per list, positive integers).
- `merge-similar-items-self-contained-tests` — The file includes both the solution and a `unittest.TestCase` with 7 test methods, runnable standalone via `__main__`.

