# File: fair-candy-swap/solution.py

**Date:** 2026-06-06
**Time:** 16:30

## `fair-candy-swap/solution.py`

### Purpose

This file solves [LeetCode 888 — Fair Candy Swap](https://leetcode.com/problems/fair-candy-swap/). Given two arrays representing candy box sizes for Alice and Bob, find one box from each person to swap so both end up with the same total candy count.

### Key Components

**`Solution.fairCandySwap`** — the sole method. Takes two lists of integers and returns a two-element list `[a, b]` where `a` is the box Alice gives and `b` is the box Bob gives.

### Flow

The algorithm works in three steps:

1. **Compute the delta**: `delta = (sum(aliceSizes) - sum(bobSizes)) // 2`. This is the amount by which Alice's chosen box must exceed Bob's chosen box. The derivation: after swapping boxes of size `a` and `b`, Alice's new total is `sumA - a + b` and Bob's is `sumB - b + a`. Setting them equal gives `a - b = (sumA - sumB) / 2`.

2. **Build a lookup set**: `bob_set = set(bobSizes)` enables O(1) membership checks against Bob's boxes.

3. **Linear scan**: For each box `a` in Alice's collection, check if `a - delta` exists in Bob's set. If so, that's the valid swap pair.

The function returns on the first valid pair found. The problem guarantees exactly one solution exists, so the loop always terminates with a return.

### Patterns

- **Set-based complement search** — the same pattern used in Two Sum with a hash set. Convert one collection to a set, then for each element in the other collection, check if the complement exists. This turns an O(n*m) brute-force into O(n+m).
- **Algebraic reduction** — rather than searching over all pairs, the math reduces the problem to a single variable: given `a`, the required `b` is fully determined as `a - delta`.

### Dependencies

**Imports**: None beyond Python builtins (`list`, `set`, `sum`).

**Imported by**: `fair-candy-swap/test_solution.py` and — based on the `imported_by` list — hundreds of other test files across the repo. This is almost certainly an artifact of a shared test harness or import pattern, not direct usage of this solution's logic.

### Invariants

- The problem guarantees at least one valid answer exists, so the function has no explicit fallback for "no solution found." If the input violates this guarantee, the function falls off the end and implicitly returns `None`.
- Integer division `// 2` is safe because `sumA - sumB` is always even when a valid swap exists (swapping integers can only equalize totals when the difference is even).

### Error Handling

None. The function trusts its inputs match the LeetCode contract. No validation, no exceptions. If `aliceSizes` or `bobSizes` is empty, or no valid swap exists, the function returns `None` silently.

### Complexity

- **Time**: O(n + m) — one pass to build the set, one pass to scan Alice's boxes.
- **Space**: O(m) — the set of Bob's box sizes.

## Topics to Explore

- [file] `fair-candy-swap/test_solution.py` — See what edge cases the tests cover (empty arrays, single elements, duplicate sizes)
- [file] `fair-candy-swap/plan.md` — The planning doc may explain why this approach was chosen over alternatives like sorting + two pointers
- [function] `two-sum/solution.py:twoSum` — The canonical set/map complement-search pattern that this solution mirrors
- [file] `fair-candy-swap/review.md` — Post-implementation review notes, likely covering correctness and complexity analysis
- [general] `set-complement-search-pattern` — How this O(n+m) lookup pattern recurs across the repo (two-sum, intersection problems, etc.)

## Beliefs

- `fair-candy-swap-delta-formula` — The swap delta `(sumA - sumB) // 2` is always an integer when a valid swap exists, making integer division safe
- `fair-candy-swap-linear-time` — The solution runs in O(n + m) time and O(m) space by using a hash set for Bob's sizes
- `fair-candy-swap-single-solution-assumption` — The function assumes exactly one valid answer exists per the problem guarantee; it returns `None` if none is found
- `fair-candy-swap-no-external-deps` — The solution uses only Python builtins with no library imports

