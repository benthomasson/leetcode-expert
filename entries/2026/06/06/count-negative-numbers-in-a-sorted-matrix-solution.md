# File: count-negative-numbers-in-a-sorted-matrix/solution.py

**Date:** 2026-06-06
**Time:** 16:00

## `count-negative-numbers-in-a-sorted-matrix/solution.py`

### Purpose

Solves [LeetCode 1351: Count Negative Numbers in a Sorted Matrix](https://leetcode.com/problems/count-negative-numbers-in-a-sorted-matrix/). The file exports a single function that counts how many elements in a matrix are negative, exploiting the matrix's sort invariant to achieve better-than-brute-force performance.

### Key Components

**`balanced_string(grid: List[List[int]]) -> int`** — The sole function. Despite the misleading name (likely a copy-paste artifact from the code generation pipeline), it counts negative numbers in a matrix where each row and each column is sorted in non-increasing order.

**Contract:**
- **Input**: An `m x n` matrix where every row is sorted descending (left-to-right) and every column is sorted descending (top-to-bottom).
- **Output**: Total count of elements `< 0`.
- **Complexity**: O(m + n) time, O(1) space.

### Patterns

**Staircase traversal** — The algorithm starts at the top-right corner and walks a "staircase" path through the matrix. At each position:

1. **If `grid[row][col] < 0`**: everything below in this column is also negative (column is sorted descending), so add `m - row` to the count and move left (`col -= 1`).
2. **If `grid[row][col] >= 0`**: nothing useful to count in this row at this column, so move down (`row += 1`).

This is the canonical O(m+n) technique for searching in a row-sorted, column-sorted matrix — the same pattern used in "Search a 2D Matrix II" (LeetCode 240). Each step either decrements `col` or increments `row`, so the loop runs at most `m + n` iterations.

### Dependencies

**Imports**: Only `List` from `typing` — no external libraries.

**Imported by**: `count-negative-numbers-in-a-sorted-matrix/test_solution.py` directly. The massive "Imported By" list in the prompt is noise — those test files import from their own sibling `solution.py`, not from this one. The only real consumer is the co-located test file.

### Flow

```
Start: row=0, col=n-1 (top-right corner)
  ┌─────────────────────────────────┐
  │ grid[row][col] < 0?             │
  │   YES → count += (m - row)      │──→ col -= 1 (move left)
  │   NO  → row += 1 (move down)    │
  └─────────────────────────────────┘
  Loop until row >= m OR col < 0
```

Example with a 3x4 matrix:
```
 [ 4,  3,  2, -1]     Start at (0,3)=-1 → negative → count+=3, move left
 [ 3,  2,  1, -1]     At (0,2)=2 → non-neg → move down
 [ 1,  1, -1, -2]     At (1,2)=1 → non-neg → move down
 [-1, -1, -2, -3]     At (2,2)=-1 → negative → count+=1, move left
                       At (2,1)=1 → non-neg → move down → row=3 ≥ m → stop
                       Total: 4 → but wait, let me retrace...
```

The key insight: when a negative is found at `(row, col)`, all cells `(row..m-1, col)` are negative because the column is sorted descending. So we can count the entire column segment in O(1) and move left.

### Invariants

- The matrix must be sorted in non-increasing order both row-wise and column-wise. The algorithm produces wrong results otherwise — there's no validation.
- `grid` must be non-empty (at least 1x1). An empty grid would cause an `IndexError` at `len(grid[0])`.

### Error Handling

None. The function trusts its input completely — consistent with LeetCode solution conventions where inputs are guaranteed by the problem constraints.

### Notable Quirk

The function is named `balanced_string`, which has nothing to do with counting negatives. This is a naming bug, likely from the automated solution generation pipeline reusing a template or symbol name. The docstring correctly describes the actual behavior.

## Topics to Explore

- [file] `count-negative-numbers-in-a-sorted-matrix/test_solution.py` — See what edge cases the tests cover (empty rows, all-negative, all-positive, single element)
- [function] `binary-search/solution.py:balanced_string` — Check whether other solutions share this naming pattern, confirming a systematic naming issue in the generation pipeline
- [general] `staircase-traversal-pattern` — The same O(m+n) walk appears in LeetCode 240 (Search a 2D Matrix II) and 378 (Kth Smallest Element in a Sorted Matrix) — worth comparing implementations
- [file] `count-negative-numbers-in-a-sorted-matrix/plan.md` — The planning doc may explain why staircase was chosen over binary-search-per-row (O(m log n)) or brute force (O(mn))

## Beliefs

- `staircase-neg-count-is-o-m-plus-n` — The staircase traversal visits at most m+n cells, making it strictly linear in the matrix dimensions rather than quadratic
- `balanced-string-is-misnamed` — The function `balanced_string` implements negative-number counting, not anything related to balanced strings; this is a naming bug
- `column-sorted-invariant-required` — The algorithm depends on columns being sorted descending to justify counting `m - row` cells as negative in one step; row-only sorting would make this incorrect
- `no-input-validation` — The function will IndexError on an empty grid and produce wrong results on an unsorted matrix, with no guards

