# File: check-if-string-is-decomposable-into-value-equal-substrings/solution.py

**Date:** 2026-06-06
**Time:** 15:43

## `check-if-string-is-decomposable-into-value-equal-substrings/solution.py`

### Purpose

This file solves [LeetCode 1933](https://leetcode.com/problems/check-if-a-string-is-decomposable-into-value-equal-substrings/) — given a digit string, determine whether it can be partitioned into consecutive substrings of identical characters where every group has length 3, except exactly one group which has length 2.

### Key Components

**`is_decomposable_into_value_equal_substrings(s: str) -> bool`** — The sole function. It takes a digit string and returns whether a valid decomposition exists. The contract: every maximal run of identical characters must be fully consumed by some mix of length-3 and length-2 chunks, with exactly one length-2 chunk across the entire string.

### Patterns

The solution uses **run-length encoding via `itertools.groupby`** — a common idiom for LeetCode string problems involving consecutive identical characters. Rather than materializing groups, it counts each group's length with `sum(1 for _ in group)` (consuming the iterator without allocation).

The key insight is modular arithmetic: for a run of length `n` consisting of one repeated character, the only way to tile it with 3s and 2s is to use `n // 3` threes and at most one two. So:

- `n % 3 == 0`: fully covered by length-3 chunks, no length-2 needed
- `n % 3 == 2`: one length-2 chunk required (remainder)
- `n % 3 == 1`: **impossible** — you can't tile a run leaving remainder 1 with only 3s and one 2 (a single 2 would leave remainder 2, not 1, and two 2s would need remainder 4 ≡ 1 mod 3 but that means using two length-2 chunks from a single run, which also doesn't work since 1 = 3k+1 means no valid decomposition)

Wait — actually `n % 3 == 1` with `n >= 4` could be tiled as, say, `4 = 2 + 2`. But the problem says exactly one length-2 substring total. So a remainder of 1 from a single group would require two 2-chunks from that group (e.g., length 4 = 2+2), which would already exceed the "exactly one" constraint. And length 1 obviously can't be decomposed at all. So returning `False` for remainder 1 is correct — it's a short-circuit that catches both the impossible case (length 1) and the case that would overcount (using two 2-chunks from one group).

### Flow

1. Initialize `twos = 0` counter
2. Iterate over consecutive character groups via `groupby(s)`
3. For each group, compute `remainder = len(group) % 3`
4. If `remainder == 1`: return `False` immediately (no valid decomposition for this group)
5. If `remainder == 2`: increment `twos`
6. After all groups: return `twos == 1` (exactly one length-2 substring total)

### Dependencies

**Imports:** `itertools.groupby` — used for run-length grouping.

**Imported by:** `check-if-string-is-decomposable-into-value-equal-substrings/test_solution.py` directly. The massive "Imported By" list in the prompt appears to be an artifact of the repository's test infrastructure (likely a shared conftest or test runner), not actual imports of this function.

### Invariants

- Every group length must be expressible as `3k` or `3k + 2` for non-negative `k`. A remainder of 1 is an immediate rejection.
- The global count of length-2 chunks must be exactly 1. Zero (all length-3) or two-or-more both fail.
- The function assumes `s` is non-empty. An empty string produces `twos == 0`, returning `False` — correct behavior since there's no length-2 substring.

### Error Handling

None — pure function with no exceptions. Invalid inputs (non-string, None) would raise standard Python `TypeError` from `groupby`. The function trusts the caller to pass a valid digit string per the LeetCode contract.

## Topics to Explore

- [file] `check-if-string-is-decomposable-into-value-equal-substrings/test_solution.py` — Edge cases tested (single char, all length-3, multiple remainder-2 groups)
- [function] `consecutive-characters/solution.py` — Another groupby-based solution; compare the run-length pattern
- [function] `count-substrings-with-only-one-distinct-letter/solution.py` — Similar consecutive-character decomposition problem
- [general] `groupby-vs-manual-counting` — When `itertools.groupby` is preferable vs a manual loop with a counter
- [file] `check-if-string-is-decomposable-into-value-equal-substrings/review.md` — Design rationale and alternative approaches considered

## Beliefs

- `remainder-1-impossible` — A character run of length `n` where `n % 3 == 1` cannot be decomposed into substrings of length 2 and 3 using at most one length-2 substring
- `exactly-one-two-required` — The function returns `True` only when the total count of groups with `len % 3 == 2` across the entire string is exactly 1
- `early-exit-on-invalid-group` — The function short-circuits to `False` on the first group whose length mod 3 equals 1, without examining remaining groups
- `empty-string-returns-false` — An empty input produces zero groups, so `twos` stays 0 and the function returns `False`

