# File: finding-3-digit-even-numbers/solution.py

**Date:** 2026-06-06
**Time:** 16:49

## `finding-3-digit-even-numbers/solution.py`

### Purpose

This file solves [LeetCode 2094: Finding 3-Digit Even Numbers](https://leetcode.com/problems/finding-3-digit-even-numbers/). Given an array of digits, find all unique 3-digit even numbers that can be formed using those digits (respecting multiplicity). The file owns both the solution and its unit tests.

### Key Components

**`Solution.findThreeDigitEvenNumbers(digits: List[int]) -> List[int]`** — The core algorithm. Instead of generating permutations of the input digits (which would require deduplication), it iterates over the *candidate space* — all even 3-digit numbers from 100 to 998 — and checks each against the available digit frequencies.

**`TestSolution`** — Six test cases covering the LeetCode examples plus edge cases (all zeros, single repeated even digit, minimal valid input).

### Patterns

**Enumerate-and-filter over generate-and-deduplicate.** The solution avoids combinatorial explosion by looping over the 450 even numbers in [100, 998] rather than generating all 3-permutations of the input. This is O(450) regardless of input size — a constant-time trick that sidesteps the need for a set to deduplicate.

**Frequency counting with `Counter`.** The input digits are counted once upfront. Each candidate is decomposed into its three digits, their required frequencies are computed via `Counter([d1, d2, d3])`, and a subset check (`freq[d] >= needed[d]`) determines feasibility.

**`divmod` for digit extraction.** The hundreds digit comes from `divmod(num, 100)`, then tens and units from `divmod(rem, 10)`. This avoids string conversion.

### Dependencies

**Imports:** `Counter` from `collections` (frequency counting), `List` from `typing` (type annotation), `unittest` (test harness).

**Imported by:** `finding-3-digit-even-numbers/test_solution.py` (and listed among hundreds of other test files, likely due to a shared test infrastructure or indexing artifact rather than actual import).

### Flow

1. Build a `Counter` from the input `digits`.
2. Loop `num` over `range(100, 999, 2)` — all 3-digit even integers (step 2 skips odds).
3. For each `num`, decompose into digits `d1`, `d2`, `d3` via two `divmod` calls.
4. Build `needed = Counter([d1, d2, d3])` — the required digit frequencies.
5. Check if every digit in `needed` has sufficient count in `freq`. If yes, append `num`.
6. Return the accumulated list (inherently sorted because the loop iterates in ascending order).

### Invariants

- **Output is sorted** — guaranteed by the ascending iteration order, not by an explicit sort.
- **No leading zeros** — guaranteed because the loop starts at 100.
- **Even numbers only** — guaranteed by `range(..., 2)` stepping by 2 from 100 (which is even).
- **Digit reuse respects multiplicity** — the `freq[d] >= needed[d]` check ensures a digit isn't used more times than it appears in the input.

### Error Handling

None. The function assumes valid input per the LeetCode contract (list of single digits 0-9). Invalid inputs (negative numbers, multi-digit values, non-integers) would silently produce wrong results rather than raising exceptions.

---

## Topics to Explore

- [file] `finding-3-digit-even-numbers/plan.md` — The planning document likely discusses why enumerate-and-filter was chosen over permutation-based approaches
- [file] `finding-3-digit-even-numbers/review.md` — Post-implementation review capturing complexity analysis and alternative approaches
- [general] `counter-subset-check-pattern` — The `Counter` subset check (`all(freq[d] >= needed[d] ...)`) recurs across many combinatorial problems in this repo (e.g., `find-words-that-can-be-formed-by-characters`, `rearrange-characters-to-make-target-string`)
- [function] `finding-3-digit-even-numbers/test_solution.py:TestSolution` — Whether the test file duplicates these inline tests or extends them with additional edge cases
- [general] `enumerate-candidate-space-pattern` — Other solutions in this repo that iterate over the answer space rather than generating from input (e.g., `count-integers-with-even-digit-sum`)

## Beliefs

- `finding-3digit-output-sorted-by-construction` — The output list is sorted without an explicit sort call, guaranteed by ascending iteration over `range(100, 999, 2)`
- `finding-3digit-constant-candidate-space` — The algorithm examines exactly 450 candidate numbers regardless of input size, making it O(1) in the size of `digits`
- `finding-3digit-no-string-conversion` — Digit extraction uses `divmod` arithmetic, never converting the number to a string
- `finding-3digit-multiplicity-enforced` — The `Counter` comparison ensures each digit is used at most as many times as it appears in the input array

