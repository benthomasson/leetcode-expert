# File: convert-1d-array-into-2d-array/solution.py

**Date:** 2026-06-06
**Time:** 15:51

## `convert-1d-array-into-2d-array/solution.py`

### Purpose

This file implements LeetCode problem 2022: **Convert 1D Array Into 2D Array**. It owns both the solution and its test suite in a single module — the standard layout across this repository for self-contained problem implementations.

### Key Components

**`Solution.construct2DArray(original, m, n) -> list[list[int]]`**

The core algorithm. Takes a flat list and reshapes it into `m` rows of `n` columns, returning an empty list if the dimensions don't match the input length.

The implementation uses a single list comprehension that slices `original` into `m` consecutive chunks of size `n`. The slice `original[i * n : (i + 1) * n]` extracts row `i` by computing the start and end indices arithmetically — no index tracking or mutation needed.

**`TestConstruct2DArray`** — 7 test cases covering:
- Standard reshaping (2x2, 1x3)
- Impossible reshapes (too few elements, too many, wrong product)
- Edge cases (single element, single-column output)

### Patterns

- **Guard-clause-then-expression**: The method validates the size constraint up front, then the entire transformation is a single return expression. This is the dominant pattern across the repo's easy-difficulty solutions.
- **Slice-based row extraction**: Uses Python slice semantics (`start:stop` on lists creates a copy) rather than nested indexing or `itertools` chunking. Clean and O(m*n).
- **Combined solution + test module**: Tests live in the same file alongside the `Solution` class, runnable via `unittest.main()`.

### Dependencies

**Imports**: Only `unittest` from the standard library — no external dependencies.

**Imported by**: The "Imported By" list in the prompt is misleading — those are test files from *other* problems, not actual importers of this module. Each problem directory is self-contained; the list likely reflects a static analysis artifact matching on `import unittest` across the repo rather than true cross-module dependencies.

### Flow

1. Caller invokes `construct2DArray(original, m, n)`.
2. Length check: if `len(original) != m * n`, return `[]` immediately.
3. List comprehension iterates `i` from `0` to `m-1`, slicing `original[i*n : (i+1)*n]` to build each row.
4. Returns the list of rows.

The data transformation is purely functional — `original` is never mutated. Each slice creates a new list, so the output shares no mutable state with the input.

### Invariants

- **Dimension invariant**: The method guarantees that if a non-empty result is returned, it has exactly `m` lists, each of length `n`, and the total element count equals `len(original)`. This is enforced by the guard clause.
- **Element order**: Elements appear in row-major order — `original[0..n-1]` becomes row 0, `original[n..2n-1]` becomes row 1, etc.
- **No partial results**: Either the full reshape succeeds or an empty list is returned. There's no scenario where a partially-filled 2D array is produced.

### Error Handling

There are no exceptions. Invalid inputs (dimension mismatch) produce an empty list `[]` — the return type doubles as the error signal, per LeetCode convention. The method also handles `m=0` or `n=0` correctly: if both `m*n == 0` and `len(original) == 0`, the comprehension produces an empty outer list.

## Topics to Explore

- [file] `reshape-the-matrix/solution.py` — Nearly identical problem (LeetCode 566) but starts from a 2D input; compare the flattening + reshaping approach
- [function] `shift-2d-grid/solution.py:shiftGrid` — Another 2D array transformation that likely uses similar slicing patterns
- [general] `slice-vs-itertools-chunking` — Python's `itertools.batched` (3.12+) or `more_itertools.chunked` offer alternative chunking idioms worth comparing for readability and performance
- [file] `concatenation-of-array/solution.py` — Simple array construction problem that shows how the repo handles trivial one-liner solutions

## Beliefs

- `construct2d-guard-is-necessary-and-sufficient` — The check `len(original) != m * n` is the only validation needed; when it passes, the slicing arithmetic is guaranteed to partition the entire array exactly.
- `construct2d-no-mutation` — `construct2DArray` never modifies the input list `original`; all slices produce new list objects.
- `construct2d-row-major-order` — Elements are placed into the 2D array in row-major order, matching NumPy's default reshape behavior.
- `leetcode-repo-self-contained-modules` — Each problem directory contains a standalone `solution.py` with both the solution class and its tests; there are no cross-problem import dependencies.

