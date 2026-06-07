# File: lucky-numbers-in-a-matrix/solution.py

**Date:** 2026-06-06
**Time:** 17:29

## `lucky-numbers-in-a-matrix/solution.py`

### Purpose

This file solves [LeetCode 1380 — Lucky Numbers in a Matrix](https://leetcode.com/problems/lucky-numbers-in-a-matrix/). A "lucky number" is an element that is simultaneously the minimum in its row and the maximum in its column. The file owns both the solution and its inline unit tests.

### Key Components

**`dfs(matrix: List[List[int]]) -> List[int]`** — The solver function. Despite the name `dfs`, this performs no depth-first search; it's a brute-force scan over rows. The naming is a repo-wide convention (all solutions export a function called `dfs`) rather than a description of the algorithm.

Contract:
- **Input**: An `m × n` matrix of distinct integers.
- **Output**: A list of all lucky numbers (could be empty, though the problem guarantees at most one exists when values are distinct).

**`TestDfs`** — Seven unit tests covering the examples from the problem, plus edge cases for single-element, single-row, single-column, and corner-position lucky numbers.

### Patterns

- **Row-min then column-max check**: For each row, find the minimum value and its column index, then verify that value is also the column maximum. This is an O(m·n) approach per candidate, O(m²·n) worst case.
- **`all()` with `<=`**: The column-max check on line 18 uses `<=` rather than `<`. This works because the problem states all values are distinct — `<=` and `==` behave identically for the candidate value, and strict `<` for all others.
- **Inline tests alongside solution**: The file bundles `unittest.TestCase` directly, gated by `if __name__ == "__main__"`. A separate `test_solution.py` imports `dfs` for the test harness.

### Dependencies

**Imports**: `typing.List` (type hint), `unittest` (inline tests).

**Imported by**: `lucky-numbers-in-a-matrix/test_solution.py` (and hundreds of other test files import from their respective `solution.py` — the "Imported By" list in the prompt is the cross-reference for the test runner, not actual imports of *this* file).

### Flow

1. Iterate over each `row` in the matrix.
2. Compute `min_val = min(row)` — the row minimum.
3. Find `col = row.index(min_val)` — the column index of that minimum.
4. Check if `min_val` is the column maximum by asserting `matrix[r][col] <= min_val` for every row `r`.
5. If so, append `min_val` to the result list.

### Invariants

- **Distinct values assumed**: The `row.index(min_val)` call returns the first occurrence, which is the *only* occurrence when values are distinct. If duplicates existed, this could silently pick the wrong column and miss a lucky number.
- **At most one lucky number**: With distinct values, there can be at most one lucky number in any matrix (provable by contradiction). The code doesn't rely on this — it accumulates into a list — but the tests all assert single-element or empty results.

### Error Handling

None. Empty matrices would cause `min()` to raise `ValueError`, but the problem guarantees `m, n >= 1`. The function trusts its caller to provide valid input per the LeetCode contract.

---

## Topics to Explore

- [file] `lucky-numbers-in-a-matrix/test_solution.py` — The external test harness that imports `dfs`; shows how the repo's test runner integrates with solutions
- [file] `lucky-numbers-in-a-matrix/review.md` — Code review notes that may document the naming mismatch or complexity discussion
- [general] `dfs-naming-convention` — Why every solution exports `dfs` regardless of algorithm; understanding the repo-wide contract that test files depend on
- [function] `special-positions-in-a-binary-matrix/solution.py:dfs` — Another matrix problem with a row/column cross-check pattern, useful for comparing approaches
- [general] `lucky-number-uniqueness-proof` — The mathematical property that distinct-valued matrices have at most one lucky number, and whether the solution could exploit this for an early return

## Beliefs

- `lucky-numbers-row-min-then-col-max` — The algorithm finds row minimums first, then validates each as a column maximum; it never scans columns independently.
- `lucky-numbers-distinct-values-required` — `row.index(min_val)` assumes no duplicate values in the matrix; duplicates could cause incorrect column selection.
- `lucky-numbers-dfs-is-misnomer` — The function is named `dfs` by repo convention, not because it performs depth-first search; the actual algorithm is a nested linear scan.
- `lucky-numbers-lte-equivalence` — The `<=` comparison on line 18 is equivalent to `<` for non-candidate rows because all matrix values are distinct.

