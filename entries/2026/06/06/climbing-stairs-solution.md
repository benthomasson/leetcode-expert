# File: climbing-stairs/solution.py

**Date:** 2026-06-06
**Time:** 15:46

## `climbing-stairs/solution.py`

### Purpose

This file solves [LeetCode 70 — Climbing Stairs](https://leetcode.com/problems/climbing-stairs/): given `n` stairs where you can climb 1 or 2 steps at a time, return the number of distinct ways to reach the top. It's a classic dynamic programming problem whose answer is the (n+1)th Fibonacci number.

### Key Components

**`Solution.climbStairs(self, n: int) -> int`** — the single method, following LeetCode's expected class/method signature.

- **Base case**: for `n <= 2`, the answer is `n` itself (1 way for 1 stair, 2 ways for 2 stairs).
- **Iterative DP**: uses two variables `a` and `b` to compute the answer bottom-up from stair 3 to stair `n`, replacing a full DP array with O(1) space.

### Patterns

**Space-optimized Fibonacci recurrence.** The number of ways to reach stair `k` is `ways(k-1) + ways(k-2)` — you can arrive from one step below or two steps below. Since each state depends only on the previous two, the solution keeps just two rolling variables (`a`, `b`) instead of an array. This is the standard idiom for 1D DP problems with a fixed lookback window.

The tuple swap `a, b = b, a + b` is a Python idiom that updates both values simultaneously without a temporary variable — identical to computing the next Fibonacci number.

### Dependencies

**Imports**: None. The solution is self-contained.

**Imported by**: The `climbing-stairs/test_solution.py` file directly, plus the "Imported By" list in the prompt shows hundreds of other test files. That's an artifact of the repo's test infrastructure — those test files likely share a common test harness or import pattern, not a direct dependency on this solution's logic.

### Flow

1. If `n` is 1 or 2, return `n` immediately.
2. Initialize `a = 1` (ways to reach stair 1), `b = 2` (ways to reach stair 2).
3. Loop from 3 to `n` inclusive. Each iteration advances the window: `a` becomes the old `b`, `b` becomes the old `a + b`.
4. After the loop, `b` holds the answer for stair `n`.

For `n = 5`:
```
Start:       a=1, b=2
i=3:         a=2, b=3
i=4:         a=3, b=5
i=5:         a=5, b=8
Return 8
```

### Invariants

- **Input constraint**: `1 <= n <= 45` (per LeetCode spec). The code doesn't validate this — it trusts the caller, which is appropriate for a LeetCode submission.
- **Loop invariant**: at the start of iteration `i`, `a` = ways(i-2), `b` = ways(i-1). After the iteration, `b` = ways(i).
- **No overflow concern**: Python integers are arbitrary precision, and `n <= 45` produces values well within machine int range anyway (fib(46) ≈ 1.8 billion).

### Error Handling

None. The function assumes valid input per the problem constraints. Passing `n <= 0` would return `n` (0 or negative), which is technically wrong but outside the contract. No exceptions are raised.

## Topics to Explore

- [file] `climbing-stairs/test_solution.py` — See what edge cases and input ranges the tests cover
- [file] `min-cost-climbing-stairs/solution.py` — The weighted variant of this problem; compare how the recurrence changes when steps have costs
- [file] `n-th-tribonacci-number/solution.py` — Same rolling-variable pattern but with a 3-term recurrence instead of 2
- [general] `fibonacci-variants-in-dp` — Many LeetCode DP problems (decode ways, house robber, tiling) reduce to Fibonacci-like recurrences with different base cases
- [file] `divisor-game/solution.py` — Another simple DP problem in the repo; compare whether it uses the same space-optimization pattern

## Beliefs

- `climbing-stairs-is-fibonacci` — `climbStairs(n)` returns the (n+1)th Fibonacci number (fib(1)=1, fib(2)=1, fib(3)=2, ...), making the problem isomorphic to Fibonacci computation.
- `climbing-stairs-constant-space` — The solution uses O(1) auxiliary space via two rolling variables, not an O(n) DP array.
- `climbing-stairs-linear-time` — The loop runs exactly `n - 2` iterations for `n >= 3`, giving O(n) time complexity.
- `climbing-stairs-no-input-validation` — The function does not guard against `n <= 0` or `n > 45`; it trusts the caller to satisfy the LeetCode constraint `1 <= n <= 45`.

