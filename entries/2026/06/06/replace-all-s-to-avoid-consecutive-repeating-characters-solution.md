# File: replace-all-s-to-avoid-consecutive-repeating-characters/solution.py

**Date:** 2026-06-06
**Time:** 18:51

## `replace-all-s-to-avoid-consecutive-repeating-characters/solution.py`

### Purpose

This file solves [LeetCode 1576: Replace All ?'s to Avoid Consecutive Repeating Characters](https://leetcode.com/problems/replace-all-s-to-avoid-consecutive-repeating-characters/). It owns both the solution logic and its test suite in a single module. The problem directory name uses `s` in place of `?` because `?` is not filesystem-safe.

### Key Components

**`Solution.dfs(self, s: str) -> str`** — The core solver. Despite the name `dfs`, this is a **greedy linear scan**, not a depth-first search. It iterates through the string once, replacing each `?` with the first character from `'abc'` that doesn't conflict with either neighbor. The method name is misleading — there's no recursion, no backtracking, and no search tree.

**`TestSolution`** — A `unittest.TestCase` covering the LeetCode examples plus edge cases (single `?`, all `?`s, no `?`s, `?` between identical neighbors). Because the problem has multiple valid outputs, most tests assert structural properties (no consecutive repeats, non-`?` characters preserved) rather than exact strings.

**`_assert_no_consecutive(self, s)`** — A test helper that verifies the primary invariant: no two adjacent characters are equal. Used by nearly every test method.

### Patterns

- **Greedy replacement with a fixed candidate set**: Only `'a'`, `'b'`, `'c'` are tried as replacements. This works because any position has at most 2 neighbors, so 3 candidates always guarantees a valid choice.
- **Mutable list conversion**: `chars = list(s)` converts the immutable string to a list for O(1) in-place updates, then `''.join(chars)` converts back.
- **Property-based assertions over exact-match**: The tests verify invariants (`_assert_no_consecutive`, `assertNotEqual` against neighbors) rather than pinning to a specific valid output. This is the right pattern for problems with multiple correct answers.

### Dependencies

**Imports**: Only `unittest` from the standard library. No external dependencies.

**Imported by**: The `test_solution.py` in this same directory imports from it (as listed in the `imported_by` section). The massive `imported_by` list in the prompt is an artifact of the repo's cross-referencing — those are other problems' test files, not actual importers of this module.

### Flow

1. Convert input string to a `list` of characters.
2. For each index `i` in `[0, n)`:
   - Skip if `chars[i] != '?'`.
   - Try `'a'`, then `'b'`, then `'c'`:
     - If the candidate matches the left neighbor (`chars[i-1]`) or the right neighbor (`chars[i+1]`), skip it.
     - Otherwise, assign it and `break`.
3. Join and return.

The right-neighbor check (`chars[i+1]`) works correctly even when `chars[i+1]` is itself a `?` — in that case no candidate will match `'?'`, so the check is vacuously satisfied. The `?` at `i+1` will be resolved when the loop reaches it.

### Invariants

- **Post-condition**: The returned string contains no `?` characters and no two adjacent characters are equal.
- **Left-to-right resolution**: Each `?` is resolved using already-resolved left neighbors and unresolved right neighbors. This is safe because the right neighbor either isn't `?` (so the check is meaningful) or is `?` (so no candidate matches it, and it will be resolved later with awareness of the choice made here).
- **Three candidates suffice**: With at most 2 constraints (left and right neighbor), 3 options guarantee at least one valid replacement. The loop over `'abc'` will always find a match and `break`.

### Error Handling

None. The code assumes valid input per LeetCode constraints (lowercase letters and `?` only). There's no handling for empty strings, but `range(0)` produces an empty loop, so `""` returns `""` correctly.

---

## Topics to Explore

- [function] `consecutive-characters/solution.py:Solution` — Related problem about counting max-length runs of consecutive identical characters; inverse concern (measuring repeats vs. preventing them)
- [general] `greedy-vs-backtracking-naming` — The method is named `dfs` but implements a greedy scan; worth auditing whether other solutions in this repo have similar naming mismatches
- [file] `delete-characters-to-make-fancy-string/solution.py` — Another problem about eliminating consecutive character runs, likely uses a similar single-pass approach
- [general] `three-candidate-sufficiency` — The pigeonhole argument for why 3 characters always suffice to avoid matching 2 neighbors; the same principle appears in graph coloring of paths

## Beliefs

- `greedy-three-chars-always-valid` — Trying candidates from `'abc'` guarantees a valid replacement at every `?` position because a character has at most 2 neighbors, and 3 candidates means at least one is conflict-free
- `left-to-right-no-backtrack` — The algorithm resolves `?`s left-to-right in a single pass with no backtracking; each resolved position never changes again
- `dfs-method-name-misleading` — `Solution.dfs` performs a greedy linear scan, not depth-first search; the name does not reflect the algorithm
- `right-neighbor-question-mark-safe` — Checking `chars[i+1]` against candidates is safe when `chars[i+1] == '?'` because no candidate in `'abc'` equals `'?'`, so the check never falsely rejects

