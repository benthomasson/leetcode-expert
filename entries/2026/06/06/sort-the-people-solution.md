# File: sort-the-people/solution.py

**Date:** 2026-06-06
**Time:** 19:12

## Purpose

This file solves [LeetCode 2418 - Sort the People](https://leetcode.com/problems/sort-the-people/). It owns exactly one responsibility: given parallel arrays of names and heights, return the names sorted by height in descending order.

## Key Components

### `sort_names_by_height(names, heights) -> list[str]`

The sole public function. It takes two parallel lists — `names` and `heights` — and returns names reordered so the tallest person comes first.

The entire implementation is a single expression:

```python
return [name for _, name in sorted(zip(heights, names), reverse=True)]
```

**Contract**: `names` and `heights` must be the same length. Heights are assumed distinct (per the problem constraints), which guarantees a stable, unambiguous ordering.

## Patterns

**Decorate-sort-undecorate (DSU / Schwartzian transform)**: `zip(heights, names)` pairs each name with its sort key, `sorted()` sorts by the first tuple element (height), and the list comprehension strips the key back out. This is the idiomatic Python way to sort one list by another.

**Single-expression solution**: The function body is one `return` statement — common across this repo's easy-tier problems. No intermediate variables, no mutation.

## Dependencies

**Imports**: None. Uses only builtins (`zip`, `sorted`, list comprehension).

**Imported by**: The "Imported By" list in the prompt is misleading — those hundreds of test files don't actually import *this* solution. They each import their own `solution.py`. The real consumer is `sort-the-people/test_solution.py`.

## Flow

1. `zip(heights, names)` produces an iterator of `(height, name)` tuples, pairing elements by index.
2. `sorted(..., reverse=True)` sorts these tuples lexicographically — since heights are distinct integers, only the first element (height) matters. Descending order.
3. The list comprehension `[name for _, name in ...]` discards the height from each tuple, extracting just the name.

**Time**: O(n log n) from the sort. **Space**: O(n) for the zipped list and output.

## Invariants

- Heights must be distinct — the problem guarantees this. If duplicates existed, names with equal heights would be sorted lexicographically (tuple comparison falls through to the second element), which might not match expected output.
- The parallel-array correspondence (`names[i]` belongs to `heights[i]`) is structural and never validated.

## Error Handling

None. Mismatched lengths would silently truncate to the shorter list (that's `zip`'s behavior). Empty inputs return `[]`. There's no validation — appropriate for a LeetCode solution where inputs are guaranteed well-formed.

## Topics to Explore

- [file] `sort-the-people/test_solution.py` — See what edge cases the test suite covers (empty input, single element, already sorted)
- [file] `sort-the-people/review.md` — The code review may note alternative approaches or complexity analysis
- [function] `sort-array-by-increasing-frequency/solution.py:sort_array` — Another sorting problem that likely uses a similar DSU pattern with a more complex key
- [general] `decorate-sort-undecorate` — Understanding this pattern explains a large family of solutions in this repo that sort by derived keys
- [file] `relative-sort-array/solution.py` — A harder sorting problem that requires custom ordering beyond simple comparison

## Beliefs

- `sort-people-uses-dsu` — `sort_names_by_height` uses the decorate-sort-undecorate pattern via `zip` + `sorted` + comprehension unpacking
- `sort-people-no-imports` — The solution has zero imports; it relies entirely on Python builtins
- `sort-people-assumes-distinct-heights` — Correctness depends on the problem constraint that all heights are distinct; duplicate heights would introduce nondeterministic name ordering
- `sort-people-linear-space` — The solution allocates O(n) auxiliary space for the zipped pairs and output list

