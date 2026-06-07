# File: shuffle-string/solution.py

**Date:** 2026-06-06
**Time:** 19:05

## `shuffle-string/solution.py`

### Purpose

This file solves [LeetCode 1528 — Shuffle String](https://leetcode.com/problems/shuffle-string/). Given a string `s` and an integer array `indices` of the same length, it rearranges the string so that character `s[i]` moves to position `indices[i]` in the result.

### Key Components

**`Solution.kids_with_candies`** — The method name is wrong; it's a copy-paste artifact from another problem (likely LeetCode 1431). The actual behavior is `restoreString`: it scatters characters from `s` into their target positions as specified by `indices`, then joins into a final string.

**Contract:**
- `s`: source string of length `n`
- `indices`: permutation of `[0, n)` dictating where each character lands
- Returns: the reshuffled string

### Patterns

**Scatter-write into a pre-allocated array.** Rather than building the result by sorting or inserting, it allocates a list of `len(s)` empty strings, then directly places each character at its destination index. This is the standard O(n) approach for permutation-based rearrangement — one pass, no sorting.

### Dependencies

- **Imports:** `List` from `typing` (used only for the type annotation on `indices`).
- **Imported by:** `shuffle-string/test_solution.py` directly. The massive "Imported By" list in the context is noise — those are test files for *other* problems that share a common test harness importing `Solution` generically, not actual consumers of this logic.

### Flow

1. Allocate `result` as a list of `n` empty strings.
2. Iterate over `s` with `enumerate`, getting each character's current index `i` and its target index `idx = indices[i]`.
3. Write `s[i]` into `result[idx]`.
4. Join and return.

### Invariants

- `indices` must be a valid permutation of `[0, len(s))`. If it contains duplicates, later writes silently overwrite earlier ones. If it contains out-of-range values, an `IndexError` is raised.
- Every slot in `result` is written exactly once (assuming valid input), so no empty-string sentinels leak into the output.

### Error Handling

None. Invalid inputs (wrong-length `indices`, out-of-bounds values, `None`) propagate as unhandled Python exceptions. This is typical for LeetCode solutions where input validity is guaranteed by the problem constraints.

### Notable Issue

The method is named `kids_with_candies` instead of something like `restoreString` or `shuffle_string`. This is a bug in the code generation pipeline — the wrong method name was templated in. It doesn't affect correctness (callers just use whatever name is on `Solution`), but it's confusing for anyone reading the code.

---

## Topics to Explore

- [file] `shuffle-string/test_solution.py` — Verify whether tests call `kids_with_candies` or a different method name, confirming the naming mismatch propagated
- [file] `shuffle-string/review.md` — Check if the review caught the wrong method name
- [general] `method-naming-consistency` — Audit whether other solutions have the same copy-paste naming bug across the repo
- [function] `shuffle-the-array/solution.py:Solution` — A related permutation problem; compare the scatter-write pattern used here vs. the interleaving approach there

## Beliefs

- `shuffle-string-wrong-method-name` — The method is named `kids_with_candies` but implements LeetCode 1528 (Shuffle String), not LeetCode 1431 (Kids With Candies)
- `shuffle-string-linear-scatter` — The solution uses a single O(n) pass with direct index assignment, not sorting
- `shuffle-string-assumes-valid-permutation` — Correctness depends on `indices` being a valid permutation of `[0, len(s))`; no validation is performed
- `shuffle-string-no-in-place` — The solution allocates a new list rather than shuffling in-place, using O(n) extra space

