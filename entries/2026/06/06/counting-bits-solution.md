# File: counting-bits/solution.py

**Date:** 2026-06-06
**Time:** 16:07

## `counting-bits/solution.py`

### Purpose

This file solves [LeetCode 338 — Counting Bits](https://leetcode.com/problems/counting-bits/). Given a non-negative integer `n`, it returns an array `ans` of length `n+1` where `ans[i]` is the number of `1` bits (popcount) in the binary representation of `i`. It's one of ~500+ solutions in the `leetcode-implementations` repo, each in its own directory with the standard `solution.py` / `test_solution.py` / `review.md` / `plan.md` layout.

### Key Components

**`countBits(n: int) -> list[int]`** — The sole public function. Contract: given `n >= 0`, returns a list of `n+1` integers where index `i` holds `bin(i).count('1')`.

### Patterns

The solution uses a **dynamic programming recurrence** based on bit-shifting:

```
ans[i] = ans[i >> 1] + (i & 1)
```

This decomposes the popcount of `i` into two parts:
1. **`ans[i >> 1]`** — the popcount of `i` with its least-significant bit removed (i.e., `i // 2`). Since `i >> 1 < i`, this value is already computed.
2. **`(i & 1)`** — whether the least-significant bit of `i` is set (0 or 1).

This is the "last set bit" DP variant. An alternative recurrence uses `ans[i & (i-1)]` (Brian Kernighan's trick to drop the lowest set bit), but the right-shift approach avoids the subtraction.

The DP builds bottom-up from index 1, with the base case `ans[0] = 0` established by the `[0] * (n + 1)` initialization.

### Dependencies

**Imports:** None — pure Python, no standard library or third-party dependencies.

**Imported by:** The `counting-bits/test_solution.py` file imports `countBits` directly. The massive "Imported By" list in the prompt is misleading — those are unrelated test files that happen to share a common test harness import pattern, not actual consumers of `countBits`.

### Flow

1. Allocate a zero-initialized list of size `n+1`.
2. Iterate `i` from 1 to `n` inclusive.
3. For each `i`, look up the already-computed popcount of `i >> 1` and add the LSB of `i`.
4. Return the completed array.

Time complexity: O(n). Space complexity: O(n) for the output (no auxiliary space beyond that).

### Invariants

- **Loop invariant:** At the start of iteration `i`, `ans[0..i-1]` all hold correct popcount values. Since `i >> 1 < i` for all `i >= 1`, the lookup `ans[i >> 1]` always references a previously computed (correct) value.
- **Base case:** `ans[0] = 0` is correct because `bin(0)` has no set bits.
- The function assumes `n >= 0`. For `n = 0`, the loop body never executes and `[0]` is returned, which is correct.

### Error Handling

None. Negative `n` would produce `[0] * (n+1)` which is an empty list for `n = -1` or would error for more negative values due to list construction — but the LeetCode constraint guarantees `0 <= n <= 10^5`.

## Topics to Explore

- [file] `counting-bits/test_solution.py` — See what edge cases (n=0, powers of 2, large n) the test suite covers
- [file] `counting-bits/plan.md` — Check whether alternative approaches (Kernighan's `i & (i-1)`, built-in `bin().count()`) were considered and why this recurrence was chosen
- [function] `number-of-1-bits/solution.py:hammingWeight` — The single-number popcount problem that this DP solution generalizes across a range
- [general] `dp-via-bit-manipulation` — Other solutions in this repo that combine DP with bit tricks (e.g., `hamming-distance`, `reverse-bits`, `number-complement`)
- [file] `counting-bits/review.md` — Post-implementation review assessing correctness and style

## Beliefs

- `counting-bits-dp-recurrence` — `ans[i] = ans[i >> 1] + (i & 1)` computes popcount in O(1) per element by reusing the popcount of `i // 2`
- `counting-bits-no-dependencies` — The solution uses no imports and depends only on Python built-in list and integer operations
- `counting-bits-linear-time` — The algorithm runs in O(n) time with a single pass, making it optimal for the problem's output size
- `counting-bits-base-case` — The zero-initialization of the array simultaneously establishes the base case `ans[0] = 0` and avoids a separate assignment

