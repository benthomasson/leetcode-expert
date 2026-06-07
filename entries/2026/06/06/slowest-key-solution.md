# File: slowest-key/solution.py

**Date:** 2026-06-06
**Time:** 19:08

## `slowest-key/solution.py`

### Purpose

This file solves [LeetCode 1629: Slowest Key](https://leetcode.com/problems/slowest-key/). It determines which key was held the longest based on an array of cumulative release times and a corresponding string of keys. It's one solution module in a repo of ~500+ LeetCode problems, each following the same `solution.py` / `test_solution.py` / `review.md` convention.

### Key Components

**`minInteger(releaseTimes, keysPressed) -> str`** — The sole exported function. Despite the misleading name (`minInteger` suggests something numeric), it finds the key with the **longest press duration**, breaking ties by choosing the **lexicographically largest** key.

**Contract:**
- **Input:** `releaseTimes` is a list of strictly increasing integers representing cumulative timestamps. `keysPressed` is a string of the same length, where `keysPressed[i]` is the key released at `releaseTimes[i]`.
- **Output:** A single character — the winning key.
- **Tie-breaking:** When two keys share the same max duration, the lexicographically larger character wins (`'b' > 'a'`).

### Patterns

**Single-pass greedy tracking.** The algorithm maintains a running best (`best_key`, `best_dur`) and updates in one linear scan — a standard pattern for "find the max with a secondary comparator" problems. No sorting, no auxiliary data structures.

**Implicit first-element handling.** The first keypress duration equals `releaseTimes[0]` (time since 0). Subsequent durations are computed as `releaseTimes[i] - releaseTimes[i-1]`. The code initializes `best_dur = releaseTimes[0]` to handle this asymmetry without a special case inside the loop.

### Dependencies

- **Imports:** Only `typing.List` — no external libraries.
- **Imported by:** The "Imported By" list in the prompt is misleading — those are unrelated test files that happen to import `List` from `typing`, not this module. The actual consumer is `slowest-key/test_solution.py`.

### Flow

1. Initialize `best_key` to the first character and `best_dur` to `releaseTimes[0]` (duration of the first keypress, measured from time 0).
2. Iterate `i` from 1 to `len(releaseTimes) - 1`:
   - Compute `dur = releaseTimes[i] - releaseTimes[i-1]`.
   - Replace the current best if `dur` strictly exceeds `best_dur`, **or** if `dur` equals `best_dur` and the current key is lexicographically greater.
3. Return `best_key`.

### Invariants

- `releaseTimes` is assumed sorted and strictly increasing (per the problem constraints). The code does not validate this.
- `len(releaseTimes) == len(keysPressed)` and both are non-empty. No empty-input guard exists.
- The tie-break condition (`keysPressed[i] > best_key`) relies on Python's native character comparison, which is lexicographic by Unicode code point — correct for lowercase English letters.

### Error Handling

None. If `releaseTimes` or `keysPressed` is empty, line 13 (`keysPressed[0]`) raises an `IndexError`. This is consistent with the repo's convention of trusting LeetCode's input guarantees.

## Topics to Explore

- [file] `slowest-key/test_solution.py` — See which edge cases are covered (ties, single key, all same duration)
- [file] `slowest-key/review.md` — Likely contains a code review with complexity analysis and alternative approaches
- [function] `the-employee-that-worked-on-the-longest-task/solution.py:minInteger` — Structurally identical problem (longest task from cumulative times), good for comparing patterns
- [general] `function-naming-conventions` — `minInteger` is a misnomer carried over from LeetCode's class template; worth checking if other solutions have similar naming drift
- [file] `slowest-key/plan.md` — Documents the approach chosen before implementation

## Beliefs

- `slowest-key-single-pass` — The solution runs in O(n) time and O(1) space with exactly one pass over the input
- `slowest-key-tiebreak-largest` — Ties in duration are broken by choosing the lexicographically **largest** key, not the smallest
- `slowest-key-first-duration-from-zero` — The first keypress duration is `releaseTimes[0]` (implicitly measuring from time 0), not a delta from a previous element
- `slowest-key-no-input-validation` — The function assumes non-empty inputs and strictly increasing release times without any defensive checks

