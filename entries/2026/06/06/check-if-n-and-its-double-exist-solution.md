# File: check-if-n-and-its-double-exist/solution.py

**Date:** 2026-06-06
**Time:** 15:40

## `check-if-n-and-its-double-exist/solution.py`

### Purpose

This file implements LeetCode problem 1346: "Check If N and Its Double Exist." It owns both the solution logic and its test suite in a single module. The problem asks whether any two distinct indices `i` and `j` exist in an array such that `arr[i] == 2 * arr[j]`.

### Key Components

**`checkIfExist(arr: list[int]) -> bool`** — The core solver. Performs a single-pass scan using a hash set to check, for each element `x`, whether its double (`2x`) or its half (`x/2`) has already been seen. Returns `True` on the first match, `False` if the array is exhausted.

**`TestCheckIfExist`** — Eight unit tests covering the standard cases: positive match, no match, zero-handling (both duplicate zeros and a single zero), negative numbers, minimum-length arrays, and a double appearing later in the array.

### Patterns

**Single-pass hash set lookup.** Rather than using a brute-force O(n^2) nested loop, the solution builds a `seen` set incrementally. For each element `x`, it checks two conditions before inserting `x`:

1. `2 * x in seen` — has a value that is double of `x` already appeared?
2. `x % 2 == 0 and x // 2 in seen` — is `x` even, and has its half already appeared?

The order matters: checking before inserting ensures `i != j` naturally (an element can't match itself), except when the same value appears twice — which is correct behavior (e.g., `[0, 0]`).

**Self-contained module.** Solution and tests coexist in one file with `if __name__ == "__main__": unittest.main()`, following the repo-wide convention.

### Dependencies

**Imports:** Only `unittest` from the standard library. No external dependencies.

**Imported by:** The `test_solution.py` in this same directory, plus hundreds of other test files across the repo. The "Imported By" list in the prompt is misleading — those other test files don't actually import *this* solution. That list likely reflects a shared test runner or a cross-referencing artifact from the code-expert tooling, not real Python import edges.

### Flow

1. Initialize empty `seen: set`.
2. For each `x` in `arr`:
   - If `2 * x` is in `seen` → return `True` (some prior element is half of `x`'s double).
   - If `x` is even and `x // 2` is in `seen` → return `True` (some prior element is `x`'s half).
   - Add `x` to `seen`.
3. If loop completes → return `False`.

This is O(n) time and O(n) space.

### Invariants

- **Distinctness guarantee:** Because `x` is inserted *after* the lookup, the function never matches an element against itself. This is what makes `[0, 1, 2]` return `False` (the single `0` doesn't self-match as `0 == 2*0`) while `[0, 0]` returns `True`.
- **Even-check guard:** The `x % 2 == 0` guard on the half-check prevents false positives from integer division truncation. Without it, an odd `x` like `7` would compute `7 // 2 = 3`, and if `3` were in `seen`, it would incorrectly match.

### Error Handling

None. The function assumes valid input per the LeetCode contract (a list of integers with length >= 2). No bounds checking, no exception handling.

## Topics to Explore

- [file] `two-sum/solution.py` — Uses the same single-pass hash set pattern to find a pair with a target sum; compare the lookup structure
- [general] `zero-handling-in-set-lookups` — The insert-after-check trick that prevents self-matching is reused across many problems in this repo; understanding it deeply helps with all hash-based pair-finding solutions
- [function] `check-if-n-and-its-double-exist/solution.py:checkIfExist` — Try tracing through `[-10, 12, -20, -8, 15]` by hand to see how both the double and half checks fire at different points
- [file] `contains-duplicate-ii/solution.py` — Another single-pass set/dict problem with an index-distance constraint; shows how the pattern adapts to sliding windows

## Beliefs

- `check-double-insert-after-lookup` — `checkIfExist` inserts each element into `seen` only after checking for its double/half, which prevents self-matching at the same index
- `check-double-even-guard` — The `x % 2 == 0` guard is required for correctness; without it, odd numbers would falsely match via integer division truncation (e.g., `7 // 2 = 3`)
- `check-double-linear-complexity` — `checkIfExist` runs in O(n) time and O(n) space due to single-pass iteration with hash set lookups
- `check-double-zero-pair` — Two zeros in the input correctly return `True` because the second zero finds `2 * 0 = 0` already in `seen` from the first zero

