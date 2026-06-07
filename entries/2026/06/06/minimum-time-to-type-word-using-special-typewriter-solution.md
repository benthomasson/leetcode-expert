# File: minimum-time-to-type-word-using-special-typewriter/solution.py

**Date:** 2026-06-06
**Time:** 18:02

## Purpose

This file implements the solution to [LeetCode 1974: Minimum Time to Type Word Using Special Typewriter](https://leetcode.com/problems/minimum-time-to-type-word-using-special-typewriter/). It owns the single responsibility of computing the minimum number of seconds to type a given word on a circular typewriter where 26 lowercase letters are arranged in a ring (`a`-`z` wrapping back to `a`), and the pointer starts at `'a'`.

Each second, you can either move the pointer one position clockwise/counterclockwise, or type the current character. The goal is to minimize total seconds.

## Key Components

**`Solution.minTimeToType(self, word: str) -> int`** — The sole method. Takes a lowercase word and returns the minimum seconds to type it.

- `curr` (line 5): Tracks the pointer's current position as an integer offset from `'a'` (0–25). Starts at 0 (`'a'`).
- `target` (line 7): The position of the next character to type, computed as `ord(ch) - ord('a')`.
- `diff` (line 8): The linear (non-wrapping) distance between the current position and the target.
- `min(diff, 26 - diff)` (line 9): The shorter of the two arcs around the circular alphabet. This is the core insight — on a ring of 26 elements, the shortest path is always `min(|a - b|, 26 - |a - b|)`.
- The `+ 1` on line 9 accounts for the one second needed to actually type the character after arriving at it.

## Patterns

**Circular distance idiom**: `min(diff, 26 - diff)` is the standard formula for shortest arc distance on a modular ring. This same pattern appears in `distance-between-bus-stops/solution.py` and `single-row-keyboard/solution.py` (without the circular wrap).

**Greedy sequential processing**: Each character is processed left-to-right with no lookahead. This is optimal because the pointer must visit each character in order — there's no way to benefit from reordering.

## Dependencies

**Imports**: None. Pure algorithm, no standard library or external dependencies.

**Imported by**: `minimum-time-to-type-word-using-special-typewriter/test_solution.py` (the `Imported By` list in the prompt is the full test suite across the repo — each test file imports its own `solution.py` via a shared test harness pattern, not this specific file).

## Flow

1. Initialize `time = 0`, `curr = 0` (pointer at `'a'`).
2. For each character in `word`:
   - Compute `target` position (0–25).
   - Compute `diff = abs(target - curr)` — the naive linear gap.
   - Add `min(diff, 26 - diff) + 1` to `time` — shortest arc + 1 second to type.
   - Update `curr = target`.
3. Return accumulated `time`.

For `word = "abc"`: pointer moves `a→a` (0+1), `a→b` (1+1), `b→c` (1+1) = 5.

## Invariants

- `curr` is always in `[0, 25]` — it's set directly from `ord(ch) - ord('a')` on valid lowercase input.
- The move cost for any single character is in `[0, 13]` (at most halfway around a 26-element ring), plus 1 for typing, so per-character cost is `[1, 14]`.
- The result is always `>= len(word)` because every character costs at least 1 second to type even if the pointer is already there.

## Error Handling

None. The method assumes `word` consists of lowercase English letters per the LeetCode contract. Invalid input (uppercase, non-alpha, empty string) would either produce wrong results or raise a `TypeError`/incorrect computation silently.

## Topics to Explore

- [file] `single-row-keyboard/solution.py` — Similar problem but on a linear (non-circular) keyboard; compare how the distance formula differs
- [file] `distance-between-bus-stops/solution.py` — Another circular-distance problem; uses the same `min(d, total - d)` idiom but over arbitrary weights
- [function] `minimum-time-to-type-word-using-special-typewriter/test_solution.py` — See which edge cases are tested (single char, full alphabet, repeated chars, max-distance jumps)
- [general] `circular-distance-problems` — The `min(diff, N - diff)` pattern recurs across modular arithmetic problems (bus stops, rotating arrays, clock angles)

## Beliefs

- `min-time-typewriter-greedy-optimal` — Processing characters left-to-right with shortest-arc moves is provably optimal; no lookahead or reordering can reduce total time.
- `min-time-typewriter-per-char-bound` — Each character contributes exactly `min(|target - curr|, 26 - |target - curr|) + 1` seconds, bounded to `[1, 14]`.
- `min-time-typewriter-no-imports` — The solution uses no imports and depends only on the `ord` builtin.
- `min-time-typewriter-result-lower-bound` — The return value is always `>= len(word)` because typing each character costs at least 1 second regardless of pointer position.

