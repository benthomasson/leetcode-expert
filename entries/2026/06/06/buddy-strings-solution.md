# File: buddy-strings/solution.py

**Date:** 2026-06-06
**Time:** 15:27

## `buddy-strings/solution.py`

### Purpose

This file solves [LeetCode 859 — Buddy Strings](https://leetcode.com/problems/buddy-strings/). It determines whether you can swap exactly two characters in string `s` to produce string `goal`. It's a standalone solution module following the repo's convention of one problem per directory with a `Solution` class.

### Key Components

**`Solution.buddyStrings(self, s, goal) -> bool`** — The only method. Takes two strings and returns whether a single swap in `s` can yield `goal`.

The method handles two fundamentally different cases:

1. **`s == goal` (lines 14-15):** If the strings are already equal, a swap can only produce the same string if there's a duplicate character. `len(s) != len(set(s))` checks this — if the set is smaller than the string, some character repeats, so swapping two copies of that character is a valid no-op swap.

2. **`s != goal` (lines 17-23):** Collect indices where the strings differ. If there are exactly 2 differing positions, check that swapping those two characters in `s` produces `goal` — i.e., the characters cross-match.

### Patterns

- **Early exit cascade:** Length mismatch exits first (line 12), then the equal-strings case short-circuits (line 14-15), then the loop bails at >2 diffs (line 20). This is a common LeetCode idiom — handle degenerate cases top-down before reaching the general logic.
- **Single-class convention:** Every solution in the repo follows the `class Solution` pattern with a single method matching the LeetCode signature.

### Dependencies

**Imports:** None — pure Python, no standard library needed.

**Imported by:** `buddy-strings/test_solution.py` directly. The "Imported By" list in the prompt is misleading — those are test files for *other* problems that happen to share a test harness pattern, not actual importers of this module.

### Flow

1. Reject if lengths differ → `False`
2. If strings are identical, return whether any character is duplicated
3. Walk both strings in lockstep, recording indices where they differ
4. Short-circuit to `False` as soon as a 3rd diff is found (avoids scanning the rest)
5. After the loop, require exactly 2 diffs with a cross-match: `s[i] == goal[j]` and `s[j] == goal[i]`

### Invariants

- The swap must be **exactly one** swap — zero swaps (when strings differ) and more-than-one swaps both return `False`.
- The `diffs` list never exceeds length 2 due to the early return on line 21, so the final index accesses (`diffs[0]`, `diffs[1]`) are always safe when `len(diffs) == 2`.
- When `s == goal`, the method never enters the diff-collecting loop — the two code paths are mutually exclusive.

### Error Handling

None. The method is a pure predicate with no exceptions, no edge-case sentinels. Invalid input (non-string, `None`) would raise a standard Python `TypeError`/`AttributeError` — no defensive handling is added, which is typical for LeetCode solutions where input constraints are guaranteed.

## Topics to Explore

- [file] `buddy-strings/test_solution.py` — See what edge cases are covered (empty strings, single-char, all-same-chars)
- [function] `check-if-one-string-swap-can-make-strings-equal/solution.py:Solution.areAlmostEqual` — Very similar problem (LeetCode 1790) but without the equal-strings duplicate-character subtlety; comparing the two solutions highlights why the `s == goal` branch matters here
- [file] `buddy-strings/plan.md` — The planning doc may capture the reasoning for choosing this approach over alternatives (e.g., Counter-based)
- [general] `single-swap-vs-permutation-distance` — The concept of edit distance constrained to transpositions; this solution checks Cayley distance == 1

## Beliefs

- `buddy-strings-equal-case-requires-duplicate` — When `s == goal`, the method returns `True` only if `s` contains at least one repeated character, because a swap of two identical characters is the only way to "swap and match"
- `buddy-strings-early-exit-on-third-diff` — The diff-collection loop exits as soon as 3 mismatches are found, making worst-case iteration O(n) but typical rejection much faster
- `buddy-strings-cross-match-invariant` — The final check enforces that the two differing positions have their characters swapped (not merely different), which is necessary and sufficient for a single-swap solution
- `buddy-strings-no-imports` — The solution uses no imports; the algorithm relies only on built-in list, set, and string operations

