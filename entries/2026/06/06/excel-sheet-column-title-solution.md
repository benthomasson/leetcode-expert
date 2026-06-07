# File: excel-sheet-column-title/solution.py

**Date:** 2026-06-06
**Time:** 16:30

## `excel-sheet-column-title/solution.py`

### Purpose

This file solves [LeetCode #168 — Excel Sheet Column Title](https://leetcode.com/problems/excel-sheet-column-title/). It converts a 1-indexed integer into the corresponding Excel column label (A, B, ..., Z, AA, AB, ..., ZZ, AAA, ...). It's the inverse of the `excel-sheet-column-number` solution elsewhere in this repo.

### Key Components

**`convert_to_title(columnNumber: int) -> str`** — The core algorithm. Takes an integer in `[1, 2^31 - 1]` and returns the Excel column string.

The function is a modified base-26 conversion. Standard base-26 would use digits 0–25, but Excel columns are 1-indexed (A=1, Z=26, not A=0, Z=25). The `columnNumber -= 1` on line 15 shifts from 1-indexed to 0-indexed on each iteration, which is the entire trick.

### Flow

Walk through `convert_to_title(28)` → `"AB"`:

1. **Iteration 1**: `28 - 1 = 27`. `27 % 26 = 1` → `chr(1 + 65) = 'B'`. `27 // 26 = 1`.
2. **Iteration 2**: `1 - 1 = 0`. `0 % 26 = 0` → `chr(0 + 65) = 'A'`. `0 // 26 = 0`.
3. `result = ['B', 'A']`, reversed → `"AB"`.

Characters are appended least-significant-first, then the list is reversed at the end. This avoids repeated string prepending (which would be O(n) per step).

### Patterns

- **Self-contained solution + test file**: follows the repo convention of putting the solution function and its unit tests in the same file, runnable via `python -m unittest` or the repo's `run_tests.py` harness.
- **Subtract-before-mod idiom**: the `columnNumber -= 1` before modding converts the "1-indexed base-26" system (where there's no zero digit) into standard 0-indexed arithmetic. This is the canonical approach for this problem — you'll see it in nearly every editorial.

### Dependencies

- **Imports**: only `unittest` (stdlib).
- **Imported by**: the "Imported By" list in the prompt is misleading — those are test files for *other* problems that happen to share the same `import unittest` line, not actual consumers of `convert_to_title`. The real consumer is `excel-sheet-column-title/test_solution.py`.

### Invariants

- `columnNumber` must be ≥ 1. The while loop's `columnNumber > 0` guard means passing 0 returns `""`, which is silently wrong rather than an error.
- The output uses only uppercase ASCII letters A–Z.
- Output length grows logarithmically: a k-letter title covers columns from `26^0 + 26^1 + ... + 26^(k-1) + 1` to that sum plus `26^k`.

### Error Handling

None. No input validation, no exceptions. Invalid inputs (≤ 0, non-integer) produce silently wrong results. This is typical for LeetCode solutions where the problem statement guarantees valid input.

### Test Coverage

Four test methods cover:
- Single-letter range (1, 26)
- Two-letter range (27, 28, 701, 702) — including the boundary at ZZ
- Three-letter boundary (703 → AAA)
- Max 32-bit signed integer (2^31 - 1 → FXSHRXW)

## Topics to Explore

- [file] `excel-sheet-column-number/solution.py` — The inverse operation (title → number); understanding both directions clarifies why the subtract-before-mod is necessary in one direction but not the other
- [general] `bijective-base-k-numeration` — The formal name for this numbering system; standard base-26 has a zero digit, bijective base-26 does not, which is why naive division doesn't work
- [function] `excel-sheet-column-title/solution.py:convert_to_title` — Trace what happens at every Z→AA boundary (26→27, 702→703) to see how the subtract-before-mod prevents off-by-one errors
- [file] `cells-in-a-range-on-an-excel-sheet/solution.py` — Another Excel-column-related problem in the repo; likely uses similar character arithmetic

## Beliefs

- `excel-column-title-is-bijective-base-26` — The conversion is bijective base-26 (no zero digit), not standard base-26; the `columnNumber -= 1` on each iteration is what corrects for this
- `excel-column-title-builds-lsb-first` — Characters are appended least-significant-digit-first and reversed at the end, making the loop O(n) total rather than O(n^2) from repeated string prepend
- `excel-column-title-inverse-of-column-number` — `convert_to_title` is the exact inverse of the `title_to_number` function in `excel-sheet-column-number/solution.py`
- `excel-column-title-no-input-validation` — The function performs no validation; inputs ≤ 0 silently return an empty string rather than raising

