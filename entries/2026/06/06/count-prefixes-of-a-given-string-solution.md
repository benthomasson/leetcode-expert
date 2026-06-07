# File: count-prefixes-of-a-given-string/solution.py

**Date:** 2026-06-06
**Time:** 16:03

## Purpose

This file is a self-contained solution to [LeetCode 2255: Count Prefixes of a Given String](https://leetcode.com/problems/count-prefixes-of-a-given-string/). It owns both the algorithm implementation and its test suite, following the repo-wide pattern of one directory per problem with `solution.py` containing everything needed to verify correctness.

## Key Components

### `Solution.countPrefixes(words, s) -> int`
The core algorithm. Given a list of strings `words` and a target string `s`, it returns how many elements of `words` are prefixes of `s`. The implementation is a single generator expression: `sum(1 for w in words if s.startswith(w))`. This delegates the prefix-matching logic entirely to Python's built-in `str.startswith`, which handles edge cases like empty strings and length mismatches internally.

**Contract**: accepts any `List[str]` and a `str`; returns a non-negative integer. Duplicates in `words` are counted independently (tested explicitly in `test_duplicates`).

### `TestCountPrefixes`
Eight test methods covering: LeetCode's provided examples, no-match case, word longer than `s`, exact equality, single character, all matching, and duplicate words. The test class uses `setUp` to instantiate `Solution` once per test.

## Patterns

- **Single-file solution + tests**: matches every other problem directory in the repo. The `if __name__ == "__main__": unittest.main()` guard allows running tests directly via `python solution.py`.
- **Generator-expression reduction**: `sum(1 for ...)` is the idiomatic Python way to count matching items without materializing a list. O(n * m) where n = len(words) and m = max word length (bounded by len(s) in practice since `startswith` short-circuits on length).
- **No data structure overhead**: no sets, dicts, or tries — appropriate for this easy-tier problem where the brute-force approach is optimal for the constraint bounds.

## Dependencies

**Imports**: `List` from `typing` (for type annotation), `unittest` (for test harness). No project-internal imports.

**Imported by**: The "Imported By" list in the prompt is misleading — those are test files from *other* problem directories, not actual importers of this module. They likely share test infrastructure or were auto-generated from the same template. This file does not export anything consumed by other solutions.

## Flow

1. `countPrefixes` iterates over `words` once.
2. For each word `w`, `s.startswith(w)` checks whether `s[:len(w)] == w` in O(len(w)) time.
3. Matching words contribute 1 to the sum; non-matching contribute 0.
4. Total time: O(sum of lengths of all words), bounded by O(n * len(s)).

## Invariants

- Every element in `words` is checked — no early termination, no deduplication. This means duplicate words are counted multiple times, which matches the problem's specification.
- The return value is always in `[0, len(words)]`.

## Error Handling

None. The function assumes valid inputs per LeetCode constraints (non-empty list, lowercase English letters). `str.startswith` handles empty-string edge cases gracefully (returns `True`), but no tests cover that scenario.

## Topics to Explore

- [file] `count-prefixes-of-a-given-string/review.md` — Review notes may document alternative approaches (trie-based, sorted prefix matching) or complexity analysis
- [file] `counting-words-with-a-given-prefix/solution.py` — The inverse problem (check if words start with a prefix rather than if they are prefixes of a string); compare implementation choices
- [function] `check-if-string-is-a-prefix-of-array/solution.py:Solution` — Related prefix problem with different semantics (concatenation-based prefix check)
- [general] `startswith-vs-slicing` — Whether `s.startswith(w)` vs `s[:len(w)] == w` differs in performance for CPython's string internals
- [file] `run_tests.py` — How the repo-level test runner discovers and executes these per-problem test suites

## Beliefs

- `count-prefixes-linear-scan` — `countPrefixes` performs a single linear pass over `words` with no filtering, sorting, or early exit
- `count-prefixes-duplicates-counted` — Duplicate entries in `words` are each counted independently toward the result, not deduplicated
- `count-prefixes-delegates-to-startswith` — All prefix-matching logic is delegated to `str.startswith`; no manual character comparison occurs
- `count-prefixes-no-external-deps` — This solution has zero project-internal dependencies; it only uses stdlib (`typing`, `unittest`)

