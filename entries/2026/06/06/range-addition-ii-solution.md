# File: range-addition-ii/solution.py

**Date:** 2026-06-06
**Time:** 18:36

## Range Addition II — `solution.py`

### Purpose

This file implements and tests LeetCode 598: **Range Addition II**. It solves the problem of determining how many cells in an `m × n` matrix contain the maximum value after a series of increment operations, where each operation `[ai, bi]` increments every cell in the submatrix `[0..ai-1][0..bi-1]` by 1.

### Key Components

**`Solution.maxCount(m, n, ops)`** — The core algorithm. Takes matrix dimensions and a list of operations, returns the count of cells holding the maximum value.

The insight: every operation increments the top-left rectangle `[0..ai-1][0..bi-1]`. The cell that receives *all* increments is the one in the intersection of *every* rectangle — which is the rectangle defined by the minimum `ai` and minimum `bi` across all operations. The maximum value lives exactly in that overlap region, so the answer is `min_a * min_b`.

**`TestMaxCount`** — Eight test cases covering edge conditions: empty ops (entire matrix), single operation, full-matrix operations, degenerate 1×1 overlap, and single-row/single-column matrices.

### Patterns

- **Mathematical reduction**: Rather than simulating the matrix (O(m×n×len(ops))), the solution reduces the problem to two `min()` calls over `ops` — O(len(ops)) time, O(1) space. This is the canonical approach for this problem.
- **Early return for empty input**: The `if not ops` guard returns `m * n` immediately, since no operations means all cells are 0 (all are the maximum).
- **Self-contained test file**: Tests live alongside the solution in the same file, runnable via `unittest.main()`.

### Dependencies

**Imports**: `unittest` (stdlib), `List` from `typing` (type annotation only).

**Imported by**: The "Imported By" list in the prompt is misleading — those are *other* test files in sibling problem directories, not actual consumers of this module's code. Each problem folder is independent; the cross-references likely come from a shared test harness (`run_tests.py`) or static analysis that picked up the common `Solution` class name.

### Flow

1. If `ops` is empty → return `m * n` (all cells are zero, all are maximal).
2. Compute `min_a` = minimum of all `op[0]` values across operations.
3. Compute `min_b` = minimum of all `op[1]` values across operations.
4. Return `min_a * min_b` — the area of the intersection rectangle.

The matrix is never materialized. The original `m` and `n` parameters are unused when `ops` is non-empty, because the problem guarantees `1 <= ai <= m` and `1 <= bi <= n`, so the min values are always within bounds.

### Invariants

- **Problem guarantee**: Every `op[0]` is in `[1, m]` and every `op[1]` is in `[1, n]`. The code relies on this — it doesn't clamp or validate.
- **Non-empty ops produce a non-zero result**: Since each `ai >= 1` and `bi >= 1`, `min_a * min_b >= 1` when `ops` is non-empty.
- **Original dimensions `m`, `n` are irrelevant when ops exist**: The maximum-value region depends only on the tightest operation bounds, not the matrix size.

### Error Handling

None. The function trusts its inputs match the LeetCode contract. Empty `ops` is the only edge case handled explicitly. Passing malformed data (e.g., ops with fewer than 2 elements) would raise an `IndexError` from `op[0]`/`op[1]`.

## Topics to Explore

- [file] `range-addition-ii/plan.md` — Planning notes that may document why the mathematical approach was chosen over simulation
- [file] `range-addition-ii/review.md` — Code review notes covering correctness and edge cases
- [general] `rectangle-intersection-problems` — The geometric insight here (intersection of axis-aligned rectangles = min of each dimension) recurs in problems like Rectangle Overlap, Range Module, and interval scheduling
- [file] `cells-with-odd-values-in-a-matrix/solution.py` — A related matrix-operation problem that may use a similar row/column counting optimization instead of brute-force simulation
- [function] `run_tests.py:main` — How the shared test runner discovers and executes tests across all problem directories

## Beliefs

- `range-addition-ii-time-complexity` — `maxCount` runs in O(len(ops)) time and O(1) space, never allocating the matrix
- `range-addition-ii-empty-ops-returns-full-matrix` — When `ops` is empty, `maxCount` returns `m * n` because all cells share the same value (zero)
- `range-addition-ii-ignores-matrix-dimensions-with-ops` — When `ops` is non-empty, the parameters `m` and `n` are unused; the result depends solely on the minimums across operations
- `range-addition-ii-no-input-validation` — The function does not validate that `op[0] <= m` or `op[1] <= n`; it trusts the LeetCode contract

