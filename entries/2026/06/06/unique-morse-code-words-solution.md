# File: unique-morse-code-words/solution.py

**Date:** 2026-06-06
**Time:** 19:36

## `unique-morse-code-words/solution.py`

### Purpose

This file is a self-contained solution to [LeetCode 804 — Unique Morse Code Words](https://leetcode.com/problems/unique-morse-code-words/). It owns both the solution logic and its test suite in a single module. The problem: given a list of lowercase English words, translate each to Morse code by concatenating per-letter codes, then count how many distinct Morse strings result.

### Key Components

**`Solution.uniqueMorseCodeWords(words: List[str]) -> int`** — The only public method. Takes a list of lowercase words, returns the count of unique Morse representations.

**`morse` (local list, 26 elements)** — A lookup table mapping index 0–25 to the Morse code for `'a'`–`'z'`. This is the canonical ITU Morse alphabet. The table is defined inline rather than as a class or module constant, which keeps it scoped to the method.

**`TestSolution`** — Five test cases covering the LeetCode examples, deduplication, single-character words, and the critical property that different words can collide to the same Morse string (`"gig"` and `"msg"` both map to `"--...---."`).

### Patterns

**Set-comprehension for deduplication** — The core logic is a single expression: build a set of Morse strings via `{ "".join(...) for word in words }`, then take `len()`. This is the standard Python idiom for "count distinct values of a transformation."

**`ord(c) - ord("a")` indexing** — Converts a lowercase letter to its 0-based index without importing anything. This works because the problem guarantees lowercase English letters only.

**Solution + tests in one file** — Matches the project convention visible across the repo tree. Each problem directory has a `solution.py` that bundles implementation and `unittest` tests, runnable via `python -m unittest` or `if __name__ == "__main__"`.

### Dependencies

**Imports:** `typing.List` (type annotation) and `unittest` (test harness). No external packages.

**Imported by:** The `test_solution.py` in this same directory imports from it. The massive "Imported By" list in the prompt is misleading — those are test files from *other* problems that share the same structural pattern, not actual import dependencies on this file.

### Flow

1. Define the 26-element Morse lookup table.
2. For each word in the input, map each character `c` to `morse[ord(c) - ord('a')]` and join into one string.
3. Collect all such strings into a set (deduplication happens here).
4. Return the set's cardinality.

The entire computation is O(S) where S is the total number of characters across all words — each character is visited exactly once for the join, and set insertion is amortized O(1).

### Invariants

- **Input contract:** All characters in `words` must be lowercase `a`–`z`. Any character outside that range would index out of bounds on the `morse` list (silently returning a wrong code or raising `IndexError`).
- **Morse table ordering:** The list must be in exact alphabetical order (`a` at index 0, `z` at index 25). A transposition would silently produce wrong results.
- **No empty words:** An empty string in `words` would produce an empty Morse string `""`, which could collide with other empty words but wouldn't crash.

### Error Handling

None. The code assumes valid input per LeetCode constraints. An out-of-range character would raise an `IndexError` from the list access. There's no explicit validation or exception handling — appropriate for a competitive-programming-style solution where input is guaranteed well-formed.

---

## Topics to Explore

- [file] `unique-morse-code-words/test_solution.py` — Check whether the separate test file duplicates or extends the inline tests
- [file] `unique-morse-code-words/review.md` — See what the automated review flagged about this solution's quality or complexity
- [general] `morse-collision-properties` — Which word pairs collide in Morse without separators, and why this makes the problem non-trivial (Morse is not prefix-free for all letters)
- [file] `decode-the-message/solution.py` — Another character-mapping problem that likely uses a similar `ord`-based lookup pattern
- [function] `run_tests.py:main` — How the project-level test runner discovers and executes per-problem test suites

## Beliefs

- `morse-table-is-itu-standard` — The 26-element `morse` list matches the ITU International Morse Code alphabet in a–z order
- `set-comprehension-dedup` — Uniqueness counting is done via set comprehension, making the solution O(S) time and O(N) space where S is total characters and N is number of words
- `no-input-validation` — The method performs no bounds checking on input characters; non-lowercase-alpha input will raise `IndexError` or produce wrong results
- `gin-zen-gig-msg-collision` — The test suite explicitly verifies that `"gig"` and `"msg"` produce identical Morse strings, confirming the core deduplication behavior

