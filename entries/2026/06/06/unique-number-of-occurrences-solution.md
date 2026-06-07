# File: unique-number-of-occurrences/solution.py

**Date:** 2026-06-06
**Time:** 19:36

## `unique-number-of-occurrences/solution.py`

### Purpose

This file solves [LeetCode 1207 — Unique Number of Occurrences](https://leetcode.com/problems/unique-number-of-occurrences/). It determines whether every distinct value in an integer array appears a unique number of times. For example, `[1,2,2,1,1,3]` returns `True` because 1 appears 3 times, 2 appears 2 times, and 3 appears 1 time — all distinct counts.

### Key Components

**`Solution.uniqueOccurrences(self, arr: List[int]) -> bool`** — The single method. Takes a list of integers, returns a boolean. The contract is: return `True` if and only if no two distinct values share the same frequency.

### Patterns

The solution follows a **count-then-deduplicate** idiom that's common across this repo's frequency-based problems:

1. **Count** — `Counter(arr)` builds a frequency map in O(n).
2. **Deduplicate** — Convert the counts to a `set` and compare cardinalities. If any two values had the same count, the set will be smaller than the original collection.

This is the canonical two-liner for "are all X unique" checks: `len(xs) == len(set(xs))`.

### Dependencies

**Imports:**
- `collections.Counter` — frequency counting.
- `typing.List` — type annotation (could be dropped on Python 3.9+ with `list[int]`).

**Imported by:** The `test_solution.py` in this directory plus hundreds of other test files across the repo. The "Imported By" list in the prompt is misleading — those other test files don't actually import *this* solution; they import their own local `solution.py`. The only real consumer is `unique-number-of-occurrences/test_solution.py`.

### Flow

```
arr → Counter(arr) → .values() → compare len(values) vs len(set(values)) → bool
```

No loops, no branching, no mutation. It's a pure functional pipeline compressed into two expressions.

### Invariants

- `Counter(arr).values()` is never empty when `arr` is non-empty (LeetCode guarantees `1 <= len(arr) <= 1000`).
- The set comparison works because `dict_values` preserves duplicates (it's a view, not a set), so converting to `set` drops them.

### Error Handling

None. The method trusts the caller to pass a valid `List[int]` per the LeetCode contract. Empty input would return `True` (0 == 0), which is a reasonable default even though the constraint forbids it.

## Topics to Explore

- [file] `unique-number-of-occurrences/test_solution.py` — See what edge cases (empty arrays, single elements, negative numbers) the tests cover
- [file] `check-if-all-characters-have-equal-number-of-occurrences/solution.py` — Sibling problem: checks if all counts are *equal* rather than *unique* — same Counter pattern, opposite predicate
- [function] `sort-array-by-increasing-frequency/solution.py:sortByFrequency` — Uses Counter output as a sort key rather than a uniqueness check
- [general] `counter-vs-set-idiom` — The `len(x) == len(set(x))` uniqueness test appears across many solutions in this repo; understanding it as a reusable pattern speeds up reading them all

## Beliefs

- `unique-occurrences-is-o-n` — The solution runs in O(n) time and O(n) space where n is the length of the input array
- `uniqueness-via-set-cardinality` — The uniqueness check relies on `len(collection) == len(set(collection))` — if these differ, at least two elements were identical
- `counter-values-preserves-duplicates` — `Counter.values()` returns a `dict_values` view that can contain duplicate counts; converting to `set` is what collapses them
- `no-explicit-error-handling` — The method performs no input validation and will not raise on any list of integers, including an empty list

