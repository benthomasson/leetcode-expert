# File: n-th-tribonacci-number/solution.py

**Date:** 2026-06-06
**Time:** 18:12

## Purpose

This file implements [LeetCode 1137 — N-th Tribonacci Number](https://leetcode.com/problems/n-th-tribonacci-number/). It owns exactly one responsibility: computing the n-th value of the Tribonacci sequence, defined as:

- T(0) = 0, T(1) = 1, T(2) = 1
- T(n) = T(n-1) + T(n-2) + T(n-3) for n >= 3

## Key Components

**`Solution.tribonacci(self, n: int) -> int`** — The sole method. Takes an index `n` (0 through 37 per the problem constraints) and returns the corresponding Tribonacci number.

## Patterns

**Iterative sliding window over recurrence state.** Rather than memoization or recursion, the solution keeps exactly three variables `(a, b, c)` representing the last three values in the sequence and advances them via simultaneous tuple assignment:

```python
a, b, c = b, c, a + b + c
```

This is the same idiom used in the classic iterative Fibonacci — extended from two state variables to three. The tuple swap is idiomatic Python: all right-hand-side values are evaluated before any assignment, so no temporary variable is needed.

**Early return for base cases.** The two `if` guards at lines 13–16 handle `n == 0` and `n <= 2` before entering the loop. This keeps the loop's range (`3..n`) clean — it never runs for `n < 3`.

## Dependencies

**Imports:** None. The solution is self-contained with no standard library or third-party dependencies.

**Imported by:** The `n-th-tribonacci-number/test_solution.py` file directly tests this class. The massive "Imported By" list in the prompt is an artifact of the repo's test harness structure — those other test files don't actually import *this* solution; they share a common test runner or import pattern.

## Flow

1. If `n == 0`, return 0 immediately.
2. If `n` is 1 or 2, return 1 immediately.
3. Initialize `(a, b, c) = (0, 1, 1)`, representing T(0), T(1), T(2).
4. Loop from 3 to `n` inclusive. Each iteration shifts the window forward: `a` becomes the old `b`, `b` becomes the old `c`, and `c` becomes the sum of all three old values.
5. After the loop, `c` holds T(n). Return it.

## Invariants

- **Loop invariant:** At the start of iteration `i`, `(a, b, c)` equals `(T(i-3), T(i-2), T(i-1))`. After the assignment, `c = T(i)`.
- **O(1) space:** Only three integers are stored regardless of `n`.
- **O(n) time:** The loop runs exactly `n - 2` iterations for `n >= 3`.
- **Constraint assumption:** The docstring states `0 <= n <= 37`. T(37) = 2,082,876,103, which fits in a 32-bit signed integer. Python ints have arbitrary precision, so there's no overflow risk here regardless.

## Error Handling

None. The method trusts that `n` satisfies `0 <= n <= 37` per the LeetCode contract. Negative `n` would fall through both guards and enter a `range(3, n+1)` that produces no iterations, returning `c = 1` — silently wrong but not an exception. This is typical for LeetCode solutions where input constraints are guaranteed by the judge.

## Topics to Explore

- [file] `n-th-tribonacci-number/test_solution.py` — See which edge cases (n=0, n=1, n=37) the test suite covers
- [file] `climbing-stairs/solution.py` — Classic Fibonacci variant using the same sliding-window recurrence pattern with two variables instead of three
- [file] `min-cost-climbing-stairs/solution.py` — DP problem that extends the recurrence idiom with a cost array
- [general] `tribonacci-vs-matrix-exponentiation` — An O(log n) alternative using matrix power for the 3x3 companion matrix; worth comparing against the iterative approach for large n
- [file] `n-th-tribonacci-number/plan.md` — Design rationale and alternative approaches considered before implementation

## Beliefs

- `tribonacci-iterative-o1-space` — `tribonacci` uses O(1) auxiliary space via a three-variable sliding window, not memoization or an array
- `tribonacci-base-cases-complete` — The three base cases T(0)=0, T(1)=1, T(2)=1 are fully handled before the loop begins
- `tribonacci-no-validation` — The method performs no input validation; it assumes the caller satisfies `0 <= n <= 37`
- `tribonacci-tuple-swap-correctness` — The simultaneous tuple assignment `a, b, c = b, c, a+b+c` evaluates all RHS values before mutation, ensuring correctness without temporaries

