# File: count-vowel-substrings-of-a-string/solution.py

**Date:** 2026-06-06
**Time:** 16:06

## `count-vowel-substrings-of-a-string/solution.py`

### Purpose

Solves [LeetCode 2062: Count Vowel Substrings of a String](https://leetcode.com/problems/count-vowel-substrings-of-a-string/). The file exports a single function that counts substrings which are composed entirely of vowels **and** contain all five vowels (a, e, i, o, u). It's a standalone solution module — no imports, no classes, just one pure function.

### Key Components

**`count_vowel_substrings(word: str) -> int`** — The sole entry point. Takes a lowercase English string, returns the count of qualifying substrings.

The function enforces a conjunction of two constraints on each substring:
1. Every character must be a vowel (no consonants allowed).
2. All five vowels must appear at least once.

### Patterns

**Brute-force enumeration with early termination.** The outer loop picks every possible start index `i`. The inner loop extends the substring rightward from `i`. The `break` on line 15 is the key optimization — the moment a consonant is hit, all longer substrings starting at `i` are guaranteed to also contain that consonant, so the inner loop terminates early.

**Accumulator set (`seen`).** Rather than re-scanning each substring to check for all five vowels, the code incrementally builds a set of distinct vowels seen so far. This turns the "contains all five vowels" check into a constant-time `len(seen) == 5` comparison.

This is an O(n²) worst-case solution (when the entire string is vowels), which is fine for the problem's constraint of `n ≤ 100`.

### Dependencies

**Imports:** None. Pure Python with only `set` from builtins.

**Imported by:** `count-vowel-substrings-of-a-string/test_solution.py` (and incidentally listed alongside hundreds of other test files in the "Imported By" section — that list reflects the repo's test harness structure, not actual usage of this function by other solutions).

### Flow

1. Build the reference vowel set `{'a', 'e', 'i', 'o', 'u'}`.
2. For each start position `i` in `[0, n)`:
   - Reset `seen` to empty.
   - For each end position `j` in `[i, n)`:
     - If `word[j]` is a consonant → `break` (no further extension is valid).
     - Otherwise, add `word[j]` to `seen`.
     - If `seen` has all 5 vowels → increment `count` (and keep going — longer substrings may also qualify).
3. Return `count`.

### Invariants

- **`seen` is a subset of `vowels` at all times** within the inner loop — enforced by the `break` on non-vowel characters.
- **Once `len(seen) == 5`, every subsequent iteration of the inner loop also increments `count`** — because `seen` only grows (characters are added, never removed), and the loop only continues through vowels.
- The function is **pure** — no mutation of the input, no side effects.

### Error Handling

None. The function assumes well-formed input (lowercase English letters). Empty strings naturally return 0 because the outer `range(n)` produces no iterations.

---

## Topics to Explore

- [file] `count-vowel-substrings-of-a-string/test_solution.py` — See what edge cases the test suite covers (empty string, all-consonant, all-vowel, single-vowel runs)
- [general] `sliding-window-vowel-variants` — An O(n) solution exists using a sliding window with two pointers and a "at most K distinct" trick; compare against this brute-force approach
- [file] `count-binary-substrings/solution.py` — Another substring-counting problem that may use a different enumeration strategy worth comparing
- [file] `count-the-number-of-vowel-strings-in-range/solution.py` — Related vowel problem with different semantics (whole strings vs. substrings)

## Beliefs

- `vowel-only-break-optimization` — The inner loop `break` on consonants guarantees no substring containing a consonant is ever counted, and prunes all extensions beyond the first consonant from position `i`
- `seen-set-monotonic` — The `seen` set within each inner loop iteration is monotonically non-decreasing in size; once all 5 vowels are found, every further vowel-only extension also counts
- `quadratic-worst-case` — The algorithm is O(n²) in time and O(1) in auxiliary space (the `seen` set is bounded at 5 elements), which is acceptable given the problem's n ≤ 100 constraint
- `pure-function-no-deps` — The solution has zero imports and is a pure function with no side effects, making it trivially testable in isolation

