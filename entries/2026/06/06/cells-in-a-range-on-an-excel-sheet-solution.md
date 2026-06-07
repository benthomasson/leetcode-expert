# File: cells-in-a-range-on-an-excel-sheet/solution.py

**Date:** 2026-06-06
**Time:** 15:33

## `cells-in-a-range-on-an-excel-sheet/solution.py`

### Purpose

This file solves [LeetCode 2194 — Cells in a Range on an Excel Sheet](https://leetcode.com/problems/cells-in-a-range-on-an-excel-sheet/). It owns exactly one responsibility: given a range string like `"K1:L2"`, enumerate every cell in that rectangular region in column-major then row-major order.

### Key Components

**`cell_range(s: str) -> list[str]`** — The sole public function. Accepts a 5-character range string in the format `"<col1><row1>:<col2><row2>"` and returns a flat list of cell identifiers.

Contract:
- Input `s` is exactly 5 characters: a letter, a digit, a colon, a letter, a digit.
- Output is sorted by column first (lexicographic on the letter), then by row (numeric on the digit) within each column.

### Patterns

**Direct index parsing** — Rather than using regex or `split(":")`, the function destructures the string by position (`s[0]`, `s[1]`, `s[3]`, `s[4]`), skipping the colon at `s[2]`. This works because the input format is fixed-width.

**`ord`/`chr` column iteration** — Columns are letters, so the code converts to ordinals to use `range()`, then converts back with `chr()`. This is the standard Python idiom for iterating over a contiguous range of characters.

**Nested list comprehension** — The outer loop iterates columns, the inner loop iterates rows. This ordering naturally produces the required column-major sort without a separate sort step.

### Dependencies

**Imports**: None — pure stdlib, no external dependencies.

**Imported by**: The `test_solution.py` in the same directory. The massive "Imported By" list in the prompt is misleading — that appears to be an artifact of the test harness sharing a common test runner pattern, not actual imports of `cell_range` from hundreds of unrelated test files.

### Flow

1. Parse `s` into four components: `c1` (start column letter), `r1` (start row int), `c2` (end column letter), `r2` (end row int).
2. Outer loop: iterate column ordinals from `ord(c1)` to `ord(c2)` inclusive.
3. Inner loop: iterate row numbers from `r1` to `r2` inclusive.
4. For each `(column, row)` pair, produce an f-string `"{chr(c)}{r}"`.
5. Return the collected list.

For input `"A1:C2"`, execution produces: `["A1", "A2", "B1", "B2", "C1", "C2"]`.

### Invariants

- **Fixed-width input**: The parsing assumes `s` is always exactly `"X#:Y#"` — single-letter columns, single-digit rows. This matches the LeetCode constraint (columns A-Z, rows 1-9).
- **Column ordering**: `c1 <= c2` and `r1 <= r2` are assumed (guaranteed by the problem). If violated, `range()` returns empty and the function returns `[]`.
- **Output ordering**: Column-major order is enforced structurally by nesting — no post-hoc sort needed.

### Error Handling

None. The function trusts its caller to provide well-formed input per the LeetCode spec. Out-of-spec input (multi-letter columns, multi-digit rows, malformed strings) would produce `IndexError` or incorrect results silently.

---

## Topics to Explore

- [file] `cells-in-a-range-on-an-excel-sheet/test_solution.py` — See what edge cases the test suite covers and whether multi-column/multi-row ranges are tested
- [function] `excel-sheet-column-number/solution.py:titleToNumber` — Related problem that converts Excel column titles to numbers; uses the same `ord()` technique but for multi-letter columns
- [function] `excel-sheet-column-title/solution.py:convertToTitle` — The inverse mapping (number to column title), showing how multi-letter columns are handled in other problems
- [general] `fixed-width-parsing-vs-split` — Compare this positional parsing approach to `s.split(":")` approaches used elsewhere in the repo

## Beliefs

- `cell-range-single-char-columns` — `cell_range` only handles single-letter columns (A-Z); multi-letter columns like "AA" would require a different parsing strategy
- `cell-range-column-major-order` — Output order is guaranteed column-major by loop nesting, not by a post-hoc sort
- `cell-range-no-validation` — The function performs no input validation; it assumes the caller provides a well-formed 5-character range string
- `cell-range-pure-function` — `cell_range` is stateless and side-effect-free, depending only on Python builtins (`ord`, `chr`, `range`, `int`)

