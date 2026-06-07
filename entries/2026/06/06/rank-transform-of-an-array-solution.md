# File: rank-transform-of-an-array/solution.py

**Date:** 2026-06-06
**Time:** 18:38

## Rank Transform of an Array — `solution.py`

### Purpose

This file implements LeetCode problem 1331: given an array of integers, replace each element with its **dense rank** (1-based position in the sorted unique values). It's a self-contained solution + test module following the repo's standard layout.

### Key Components

**`Solution.arrayRankTransform(arr)`** — The single method. Takes a `List[int]` and returns a `List[int]` of equal length where each element is replaced by its rank.

The implementation is a one-liner in two steps:

```python
rank_map = {v: i + 1 for i, v in enumerate(sorted(set(arr)))}
return [rank_map[x] for x in arr]
```

1. `sorted(set(arr))` — deduplicates and sorts, producing the rank order.
2. Dict comprehension maps each unique value to its 1-based index.
3. List comprehension replaces every original element via the lookup.

**`TestArrayRankTransform`** — 10 test cases covering: standard examples, empty input, single element, negatives, pre-sorted/reverse-sorted, all-same, and extreme values (`-10^9`, `10^9`).

### Patterns

- **Sort-and-index ranking**: The canonical approach for dense ranking — `set` removes duplicates, `sorted` establishes order, `enumerate` assigns ranks. O(n log n) time, O(n) space.
- **Single-file solution+test**: Matches every other problem directory in the repo. Tests are `unittest`-based, run via `__main__`.

### Dependencies

**Imports**: `typing.List` (type annotation), `unittest` (test framework). No project-internal imports.

**Imported by**: The `test_solution.py` in this same directory, plus it appears in a large "imported by" list — that list is an artifact of the repo's shared test infrastructure, not direct code dependencies on this module.

### Flow

1. `set(arr)` — O(n) to deduplicate.
2. `sorted(...)` — O(k log k) where k = unique count.
3. Dict comprehension — O(k) to build the rank map.
4. List comprehension — O(n) to produce the output by looking up each element.

Total: **O(n log n)** time, **O(n)** space.

### Invariants

- **Dense ranking**: Ranks are consecutive integers starting at 1 with no gaps. Equal values always receive the same rank.
- **Stability of position**: The output preserves the original array's index order — only values change.
- **Empty input → empty output**: The `set`/`sorted`/comprehension chain handles this naturally without a special case.

### Error Handling

None. The method assumes valid input per LeetCode constraints. No bounds checking, no exception handling. Invalid input (non-integer elements, `None`) would raise at the `sorted`/`set` level with standard Python errors.

## Topics to Explore

- [file] `rank-transform-of-an-array/review.md` — The code review for this solution may document alternative approaches (e.g., using `bisect` or `numpy.argsort`)
- [function] `relative-ranks/solution.py:arrayRankTransform` — A closely related problem (LeetCode 506) that assigns medals to top-3, likely uses the same sort-and-index pattern
- [function] `how-many-numbers-are-smaller-than-the-current-number/solution.py:smallerNumbersThanCurrent` — Another ranking variant that counts elements smaller than each value rather than assigning dense rank
- [general] `dense-vs-competition-ranking` — Understanding the difference between dense rank (1,2,2,3), competition rank (1,2,2,4), and ordinal rank (1,2,3,4) clarifies why `set()` is used here

## Beliefs

- `rank-uses-dense-ranking` — `arrayRankTransform` produces dense ranks (no gaps): if k unique values exist, ranks span exactly [1, k]
- `rank-map-is-o-n-log-n` — The solution's time complexity is O(n log n) dominated by the `sorted()` call; the dict lookup per element is O(1) amortized
- `rank-handles-empty-naturally` — Empty input produces empty output without any explicit guard; the `set`/`sorted`/comprehension pipeline degenerates cleanly
- `rank-preserves-original-order` — The output list maintains index correspondence with the input; only values are transformed

