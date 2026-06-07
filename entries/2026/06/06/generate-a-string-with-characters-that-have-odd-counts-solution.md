# File: generate-a-string-with-characters-that-have-odd-counts/solution.py

**Date:** 2026-06-06
**Time:** 16:54

## Purpose

This file solves [LeetCode 1374 — Generate a String With Characters That Have Odd Counts](https://leetcode.com/problems/generate-a-string-with-characters-that-have-odd-counts/). It constructs a string of length `n` where every distinct character appears an odd number of times. The solution is one of hundreds of LeetCode solutions in this repo, each following the same `Solution` class convention.

## Key Components

**`Solution.generateTheString(self, n: int) -> str`** — The only method. It exploits a simple observation: if `n` is odd, a single character repeated `n` times satisfies the constraint (one character, appearing an odd number of times). If `n` is even, it uses two characters — `"a"` repeated `n-1` times (odd) and one `"b"` (also odd: 1 is odd).

## Patterns

- **Parity-based case split**: The entire algorithm reduces to checking `n % 2`. This is a common pattern in LeetCode "construction" problems where the answer has different structural forms depending on an input property.
- **Constructive proof as code**: Rather than searching for a valid string, it directly constructs one. The solution is greedy and deterministic — no iteration, no backtracking.

## Dependencies

**Imports**: None. The solution uses only Python builtins (string multiplication, modulo).

**Imported by**: The `test_solution.py` in the same directory imports this `Solution` class. The massive "Imported By" list in the prompt is misleading — those are unrelated test files in sibling problem directories; they import their own local `solution.py`, not this one.

## Flow

1. Check if `n` is odd.
2. If odd → return `"a" * n`. One character, one odd count. Done.
3. If even → return `"a" * (n - 1) + "b"`. Two characters: `a` appears `n-1` times (odd, since `n` is even), `b` appears 1 time (odd).

Total string length is always exactly `n`. Every distinct character count is odd. Both branches execute in O(n) time due to string allocation.

## Invariants

- **Output length equals `n`**: Both branches produce exactly `n` characters.
- **All character counts are odd**: The odd branch has one character with count `n` (odd). The even branch has `a` at count `n-1` (odd) and `b` at count `1` (odd).
- **Input constraint**: `1 <= n <= 500`. The solution doesn't validate this — it relies on LeetCode's guarantees. For `n=1`, the odd branch returns `"a"`, which is correct.

## Error Handling

None. The method assumes valid input per the problem constraints. No exceptions are raised or caught. Invalid inputs (e.g., `n=0` or negative) would produce degenerate results — an empty string for `n=0`, or an error from negative string multiplication returning empty — but those are outside the problem's contract.

## Topics to Explore

- [file] `generate-a-string-with-characters-that-have-odd-counts/test_solution.py` — See what edge cases the test suite covers (n=1, n=2, large n)
- [file] `generate-a-string-with-characters-that-have-odd-counts/review.md` — Read the code review for quality notes or alternative approaches
- [general] `parity-construction-problems` — Other LeetCode problems where odd/even parity drives the entire solution structure (e.g., cells-with-odd-values-in-a-matrix, count-odd-numbers-in-an-interval-range)
- [function] `find-n-unique-integers-sum-up-to-zero/solution.py:Solution.sumZero` — Another constructive problem where the answer is built directly from an arithmetic property of the input

## Beliefs

- `odd-count-two-branch` — The solution uses exactly two code paths: all-same-char for odd n, two-char split for even n
- `even-case-uses-two-chars` — When n is even, the output contains exactly two distinct characters with counts (n-1, 1)
- `no-input-validation` — The method performs no bounds checking on n; correctness depends on LeetCode's 1 ≤ n ≤ 500 guarantee
- `constant-time-logic` — The branching logic is O(1); only the string construction is O(n)

