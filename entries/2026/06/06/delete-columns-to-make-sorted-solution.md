# File: delete-columns-to-make-sorted/solution.py

**Date:** 2026-06-06
**Time:** 16:15

## `delete-columns-to-make-sorted/solution.py`

### Purpose

This file solves [LeetCode 944: Delete Columns to Make Sorted](https://leetcode.com/problems/delete-columns-to-make-sorted/). Given a list of equal-length strings (imagine them as rows of a grid), it counts how many columns are **not** sorted in non-decreasing lexicographic order. Each such column would need to be "deleted" to make every remaining column sorted top-to-bottom.

### Key Components

**`Solution.minDeletionSize(strs: List[str]) -> int`** — The sole method. It iterates column-by-column over the character grid formed by `strs`, and for each column checks whether any adjacent pair of characters violates non-decreasing order. If so, that column is counted and immediately skipped via `break`.

### Patterns

**Column-major traversal with early exit.** The outer loop walks columns (`j`), the inner loop walks rows (`i`). The `break` on the first out-of-order pair avoids unnecessary comparisons in the rest of the column — once you know a column is unsorted, you don't need to keep checking.

**Grid-as-strings idiom.** Rather than converting to a 2D array, the code indexes directly into each string with `strs[i][j]`. This is standard for LeetCode string-grid problems and avoids allocation.

### Dependencies

- **Imports:** `List` from `typing` (type annotation only).
- **Imported by:** `delete-columns-to-make-sorted/test_solution.py` directly. The large "Imported By" list in the prompt is an artifact of the project's test infrastructure — those other test files don't actually import this solution; they share a common test harness pattern.

### Flow

1. Initialize `count = 0`.
2. For each column index `j` in `0..len(strs[0])`:
   - For each row index `i` in `1..len(strs)`:
     - Compare `strs[i][j]` against `strs[i-1][j]`.
     - If the current character is strictly less than the one above, increment `count`, `break` out of the row loop.
3. Return `count`.

### Invariants

- **All strings in `strs` have equal length.** The code indexes `strs[0]` to get the column count and assumes every other string shares that length. No guard exists for ragged input.
- **`strs` is non-empty and each string is non-empty.** `len(strs[0])` would throw on an empty list, and the problem guarantees at least one string of at least one character.
- **Lexicographic comparison uses Python's native `<` on single characters**, which compares by Unicode code point — correct for lowercase English letters as guaranteed by the problem.

### Error Handling

None. The code trusts the LeetCode contract: `strs` is a non-empty list of equal-length, non-empty, lowercase-letter strings. An empty `strs` would raise `IndexError` at `len(strs[0])`.

### Complexity

- **Time:** O(n * m) where n = number of strings, m = string length. Each cell is visited at most once.
- **Space:** O(1) beyond the input.

---

## Topics to Explore

- [file] `delete-columns-to-make-sorted/test_solution.py` — See what edge cases the tests cover (single row, single column, already sorted, fully unsorted)
- [file] `delete-columns-to-make-sorted/plan.md` — Understand the problem decomposition approach before coding
- [general] `column-sorted-grid-problems` — LeetCode 955 (Delete Columns to Make Sorted II) extends this to a harder lexicographic ordering variant worth comparing
- [function] `verifying-an-alien-dictionary/solution.py:isAlienSorted` — Another pairwise-comparison pattern over ordered sequences, using a custom alphabet

---

## Beliefs

- `delete-cols-early-exit` — The inner loop breaks on the first unsorted pair, so each column is counted at most once and no redundant comparisons occur after a violation.
- `delete-cols-assumes-uniform-length` — The code assumes all strings in `strs` share the same length as `strs[0]`; ragged input would cause silent incorrect results or an `IndexError`.
- `delete-cols-linear-space` — The solution uses O(1) auxiliary space — no data structures beyond a single counter.
- `delete-cols-native-char-compare` — Column sortedness is checked via Python's native `<` operator on single characters, which is correct only for uniform-case single-byte alphabets (as the problem guarantees lowercase a-z).

