# File: the-k-weakest-rows-in-a-matrix/solution.py

**Date:** 2026-06-06
**Time:** 19:27

## The K Weakest Rows in a Matrix — `solution.py`

### Purpose

This file implements [LeetCode #1337](https://leetcode.com/problems/the-k-weakest-rows-in-a-matrix/). It solves the problem of finding the `k` rows in a binary matrix that have the fewest soldiers (1s), returning their indices in order from weakest to strongest. It's one solution module among hundreds in this LeetCode implementations repo, following the same single-function-per-file convention.

### Key Components

**`kWeakestRows(mat, k)`** — The sole public function. Takes a binary matrix and an integer `k`, returns a list of `k` row indices sorted ascending by soldier count, with ties broken by row index.

### Patterns

The implementation is a single-expression return using a **decorate-sort-undecorate** (Schwartzian transform) idiom compressed into a list comprehension:

```python
return [i for i, _ in sorted(enumerate(mat), key=lambda x: sum(x[1]))][:k]
```

Breaking this apart:

1. `enumerate(mat)` — pairs each row with its index: `(0, row0), (1, row1), ...`
2. `sorted(..., key=lambda x: sum(x[1]))` — sorts by the sum of each row (i.e., soldier count). Python's `sorted` is stable, so rows with equal soldier counts preserve their original index order — which is exactly the tiebreaker the problem requires.
3. `[i for i, _ in ...]` — extracts just the indices, discarding the rows.
4. `[:k]` — takes the first `k`.

This leverages **sort stability** as the tiebreaker mechanism rather than encoding it explicitly in the key (e.g., `key=lambda x: (sum(x[1]), x[0])`). Since `enumerate` produces indices in ascending order and `sorted` is stable, equal-strength rows naturally stay in index order.

### Dependencies

**Imports:** None — uses only builtins (`sorted`, `enumerate`, `sum`, list slicing).

**Imported by:** The `test_solution.py` in the same directory, plus hundreds of other test files across the repo (the "Imported By" list in the prompt appears to be a repo-wide cross-reference artifact, not actual imports of this specific function).

### Flow

1. Receive matrix `mat` and count `k`.
2. Tag each row with its index.
3. Sort all tagged rows by soldier count (ascending).
4. Strip tags, keeping only indices.
5. Return the first `k` indices.

**Time complexity:** O(m·n + m·log(m)) where m = rows, n = columns — O(m·n) to sum every row, O(m·log(m)) to sort.

**Space complexity:** O(m) for the enumerated/sorted intermediate list.

### Invariants

- The input matrix is binary (only 0s and 1s), with all 1s before all 0s in each row. The solution doesn't exploit the sorted-row property — `sum(row)` works regardless of element order, making it more general than necessary.
- Tiebreaking by row index is guaranteed by sort stability + `enumerate` producing indices in order.
- `k <= m` is assumed (per the problem constraints); no bounds checking.

### Error Handling

None. The function trusts its inputs per LeetCode's guarantees. Passing `k > len(mat)` would return fewer than `k` results (silent truncation via slicing). A non-binary matrix would still work — `sum` would count total value, not soldier count.

---

## Topics to Explore

- [file] `the-k-weakest-rows-in-a-matrix/test_solution.py` — See the test cases to understand edge cases (single row, all-zero rows, k equals row count)
- [file] `the-k-weakest-rows-in-a-matrix/plan.md` — The problem decomposition and approach reasoning before implementation
- [general] `sort-stability-as-tiebreaker` — How Python's stable sort eliminates the need for composite sort keys when natural ordering matches the desired tiebreaker
- [function] `count-negative-numbers-in-a-sorted-matrix/solution.py:countNegatives` — Another matrix problem that could exploit sorted-row structure (binary search) vs. brute-force summation
- [file] `the-k-weakest-rows-in-a-matrix/review.md` — Whether the review flags the missed binary-search optimization for counting soldiers per row

## Beliefs

- `weakest-rows-stable-sort-tiebreak` — Tiebreaking by row index relies on Python's stable sort guarantee, not an explicit secondary key
- `weakest-rows-ignores-sorted-row-property` — The solution uses `sum(row)` to count soldiers, ignoring the constraint that 1s always precede 0s (which would allow O(log n) binary search per row)
- `weakest-rows-no-input-validation` — No bounds checking on `k`; slicing silently returns fewer than `k` elements if `k > len(mat)`
- `weakest-rows-zero-imports` — The solution uses only Python builtins with no standard library or third-party imports

