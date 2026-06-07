# File: find-n-unique-integers-sum-up-to-zero/solution.py

**Date:** 2026-06-06
**Time:** 16:39

## `find-n-unique-integers-sum-up-to-zero/solution.py`

### Purpose

This file solves [LeetCode 1304: Find N Unique Integers Sum up to Zero](https://leetcode.com/problems/find-n-unique-integers-sum-up-to-zero/). Given an integer `n`, it returns any array of `n` unique integers that sum to zero. It follows the repo's convention of one `Solution` class per problem directory.

### Key Components

**`Solution.sumZero(n: int) -> List[int]`** — The single method. It constructs the result by pairing positive and negative integers symmetrically around zero:

- For each `i` in `[1, n//2]`, it appends both `i` and `-i`. These pairs cancel out, contributing 0 to the total sum.
- If `n` is odd, it appends `0` to fill the remaining slot without affecting the sum.

### Patterns

**Symmetric cancellation** — The core technique. Rather than solving a constraint satisfaction problem, the solution exploits the fact that `i + (-i) = 0` for any integer. This is the simplest construction possible and avoids any need for tracking a running sum.

**Greedy construction** — The result is built in a single pass with no backtracking. The algorithm never needs to revisit prior choices because every pair is independently valid.

### Dependencies

- **Imports**: `typing.List` (type annotation only — no runtime dependencies).
- **Imported by**: `find-n-unique-integers-sum-up-to-zero/test_solution.py` and hundreds of other test files in the repo (the "Imported By" list in the prompt is the test harness's cross-reference index, not actual imports of this specific file).

### Flow

1. Initialize empty `result` list.
2. Loop `i` from `1` to `n // 2` inclusive — append `i` and `-i` on each iteration (2 elements per iteration, so `n // 2` iterations produce `2 * (n // 2)` elements).
3. If `n` is odd, one slot remains — fill it with `0`.
4. Return `result`.

For `n = 5`: loop produces `[1, -1, 2, -2]`, then `0` is appended → `[1, -1, 2, -2, 0]`. Sum = 0, all unique, length = 5.

### Invariants

- **Uniqueness**: Guaranteed because positive values `1..n//2` are distinct, their negations are distinct from each other and from the positives, and `0` (if added) doesn't collide with any value in `[1, n//2]` or `[-n//2, -1]`.
- **Sum = 0**: Each `(i, -i)` pair sums to 0, and the optional `0` doesn't change the sum.
- **Length = n**: `2 * (n // 2)` elements from pairs + `n % 2` element from the zero case = `n`.

### Error Handling

None. The method trusts that `n >= 1` per the problem constraints. If `n = 0`, it returns `[]` (the loop doesn't execute, the odd check fails). No validation, no exceptions — appropriate for a LeetCode solution where inputs are guaranteed valid.

### Complexity

- **Time**: O(n) — single pass producing n elements.
- **Space**: O(n) — the output list.

---

## Topics to Explore

- [file] `find-n-unique-integers-sum-up-to-zero/test_solution.py` — See what edge cases (n=1, n=2, large n) are validated and how uniqueness/sum constraints are asserted
- [file] `find-n-unique-integers-sum-up-to-zero/review.md` — The code review may discuss alternative constructions (e.g., `[-n+1, -n+2, ..., n-1]` or arithmetic sequences)
- [general] `symmetric-pair-construction` — This pattern (pair `x` with `-x`) recurs in problems requiring zero-sum or balanced partitions
- [function] `convert-integer-to-the-sum-of-two-no-zero-integers/solution.py:sumZero` — A related decomposition problem with different constraints (no zeros allowed in digits)

## Beliefs

- `sumzero-output-length-equals-n` — `sumZero(n)` always returns exactly `n` elements: `2 * (n // 2)` from pairs plus `n % 2` from the zero append
- `sumzero-uniqueness-by-construction` — All returned integers are unique because positive values `1..n//2`, their negations, and the optional `0` form disjoint sets
- `sumzero-zero-sum-invariant` — The output always sums to zero because every `(i, -i)` pair cancels and the optional `0` is additive identity
- `sumzero-no-input-validation` — The method performs no bounds checking on `n`; it relies on LeetCode's guarantee that `1 <= n <= 1000`

