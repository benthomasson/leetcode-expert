# File: capitalize-the-title/solution.py

**Date:** 2026-06-06
**Time:** 15:32

## `capitalize-the-title/solution.py`

### Purpose

This file is the complete solution and test suite for [LeetCode 2129: Capitalize the Title](https://leetcode.com/problems/capitalize-the-title/). It owns both the algorithm implementation and its verification. Like every other problem directory in this repo, it follows a self-contained pattern: one `Solution` class with the LeetCode-expected method signature, plus inline `unittest` tests.

### Key Components

**`Solution.capitalizeTitle(self, title: str) -> str`** — The core algorithm. Takes a space-separated title string and applies two rules per word:
- Words with **length <= 2**: lowercased entirely
- Words with **length >= 3**: title-cased (first letter uppercase, rest lowercase)

Returns the transformed title as a single string with words joined by spaces.

**`TestCapitalizeTitle`** — Eight test cases covering:
- The three LeetCode examples (mixed-case inputs)
- Edge cases: single short word (`"aB"`), single long word (`"hELLO"`), single character (`"Z"`), all-short words, and the boundary case of exactly 3 characters (`"THE"`)

### Patterns

The solution uses a **generator expression inside `str.join`** — the idiomatic Python approach for word-by-word string transformations. Rather than building a list and joining, it streams transformed words directly.

The title-casing is done manually (`w[0].upper() + w[1:].lower()`) instead of using Python's built-in `str.title()`. This is intentional: `str.title()` doesn't have the length-based conditional, so you'd still need the branch, and `.capitalize()` would work but this explicit form makes the transformation visible.

The file bundles solution and tests in a single module with `if __name__ == "__main__": unittest.main()`, matching the repo-wide convention. Tests use `setUp` to instantiate `Solution` once per test method.

### Dependencies

**Imports**: Only `unittest` from the standard library — no external dependencies.

**Imported by**: The `capitalize-the-title/test_solution.py` file imports from this module. The massive "Imported By" list in the prompt is misleading — those are test files across the entire repo that import `unittest`, not this specific solution. The actual dependent is just `test_solution.py` in the same directory.

### Flow

1. `title.split()` tokenizes on whitespace, producing a list of words
2. For each word, check `len(w) <= 2`
3. If short: `w.lower()` — full lowercase
4. If long: `w[0].upper() + w[1:].lower()` — uppercase first char, lowercase the rest
5. `" ".join(...)` reassembles with single spaces

The entire transformation is a single `return` statement — no intermediate state, no mutation.

### Invariants

- Input is guaranteed to be space-separated English letters only (per the LeetCode constraint), so `split()` without arguments is safe — no punctuation or multi-space handling needed.
- The length threshold is **strictly** `<= 2`, meaning exactly-3-letter words get title-cased. The test `test_three_letter_word` verifies this boundary.
- `w[1:]` on a word of length >= 3 is always non-empty, so no index errors.

### Error Handling

None. The LeetCode contract guarantees valid input (non-empty title, only English letters and spaces, no leading/trailing spaces, no consecutive spaces). The solution trusts those preconditions and does no validation — appropriate for a competitive programming context.

---

## Topics to Explore

- [file] `capitalize-the-title/test_solution.py` — The separate test file that imports this solution; may have additional edge cases or a different test structure
- [file] `capitalize-the-title/review.md` — Code review notes that may highlight alternative approaches or complexity analysis
- [function] `detect-capital/solution.py:Solution.detectCapital` — A related LeetCode problem about capitalization rules, likely using similar string manipulation patterns
- [general] `title-casing-edge-cases` — How Python's `str.title()` and `str.capitalize()` behave differently with Unicode, apostrophes, and digits — and why manual casing is safer here
- [file] `capitalize-the-title/plan.md` — The problem-solving plan that preceded this implementation

## Beliefs

- `capitalize-title-threshold-is-2` — Words of length exactly 2 are lowercased; words of length exactly 3 are title-cased. The boundary is `<= 2`, not `< 3` (equivalent, but the code expresses it as the former).
- `capitalize-title-single-pass` — The solution processes each word exactly once with no lookahead or backtracking — O(n) in the total character count.
- `capitalize-title-no-builtin-titlecase` — The solution manually constructs title case (`w[0].upper() + w[1:].lower()`) rather than using `str.title()` or `str.capitalize()`.
- `capitalize-title-split-preserves-contract` — `str.split()` without arguments handles the LeetCode guarantee of single-space separation and no leading/trailing spaces, producing a clean word list with no empty strings.

