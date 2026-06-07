# File: di-string-match/solution.py

**Date:** 2026-06-06
**Time:** 16:22

## DI String Match — `di-string-match/solution.py`

### Purpose

Solves [LeetCode 942: DI String Match](https://leetcode.com/problems/di-string-match/). Given a string `s` of length `n` containing only `'I'` (increase) and `'D'` (decrease) characters, construct a permutation `perm` of `[0, 1, ..., n]` such that for every `i`: if `s[i] == 'I'` then `perm[i] < perm[i+1]`, and if `s[i] == 'D'` then `perm[i] > perm[i+1]`.

### Key Components

**`Solution.diStringMatch(self, s: str) -> list[int]`** — The sole method. Uses a greedy two-pointer approach with `low` and `high` tracking the smallest and largest unused values in `[0..n]`.

### Patterns

**Greedy with extremal values.** The core insight: when you see `'I'`, placing the current smallest unused value guarantees the next value (whatever it is) will be larger. Symmetrically, `'D'` places the current largest unused value, guaranteeing the next will be smaller. This is a classic greedy pattern — making the locally safest choice at each step produces a globally valid permutation.

The algorithm avoids any sorting, backtracking, or search. It's a single linear pass.

### Dependencies

**Imports:** None — pure algorithmic code with no external dependencies.

**Imported by:** The `di-string-match/test_solution.py` file directly. The large "Imported By" list in the prompt is an artifact of the repo's test infrastructure — those other test files don't actually import this solution; they share a common test harness pattern.

### Flow

1. Initialize `low = 0`, `high = n` — the full range of available values.
2. Iterate over each character in `s`:
   - `'I'`: append `low`, then increment `low`. This places the smallest remaining value, ensuring the next value placed will be strictly greater.
   - `'D'`: append `high`, then decrement `high`. This places the largest remaining value, ensuring the next value placed will be strictly smaller.
3. After the loop, `low == high` — exactly one value remains. Append it. This is the `n+1`th element (the permutation has length `n+1` for a string of length `n`).

**Time:** O(n). **Space:** O(n) for the output list.

### Invariants

- **`low` and `high` always bound the unused range.** At every iteration, `low <= high`, and `result` contains exactly the values `[0, low)` and `(high, n]`.
- **After the loop, `low == high`.** The loop runs `n` times, consuming one value each iteration from a pool of `n+1` values, leaving exactly one.
- **Every value in `[0..n]` appears exactly once.** Each iteration takes from one end; the final append takes the last remaining value. No duplicates, no gaps.
- **The permutation satisfies all DI constraints by construction.** An `'I'` at position `i` places the minimum available, so any subsequent value (drawn from the remaining pool) is strictly larger. The `'D'` case is symmetric.

### Error Handling

None. The method assumes valid input per LeetCode constraints — `s` contains only `'I'` and `'D'`, and `len(s) >= 1`. An empty string would produce `[0]`, which is correct (trivial permutation).

## Topics to Explore

- [file] `di-string-match/test_solution.py` — See which edge cases are tested (empty string, all-I, all-D, alternating)
- [file] `di-string-match/plan.md` — The pre-implementation reasoning and approach selection
- [file] `di-string-match/review.md` — Post-implementation review notes and complexity analysis
- [general] `greedy-extremal-value-pattern` — This same "pick min/max from remaining" greedy strategy appears in other permutation-construction problems (e.g., advantage shuffle, task scheduler variants)

## Beliefs

- `di-string-match-greedy-correctness` — Placing the current min on 'I' and current max on 'D' always produces a valid permutation; no backtracking is ever needed
- `di-string-match-linear-time` — The algorithm runs in O(n) time and O(n) space with a single pass over the input string
- `di-string-match-loop-postcondition` — After the for-loop, `low == high` holds unconditionally, so the final append always places exactly the one remaining unused value
- `di-string-match-no-dependencies` — The solution uses no imports and depends only on Python built-in list operations

