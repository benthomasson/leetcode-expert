# File: shortest-distance-to-target-string-in-a-circular-array/solution.py

**Date:** 2026-06-06
**Time:** 19:05

## Purpose

This file solves [LeetCode 2515: Shortest Distance to Target String in a Circular Array](https://leetcode.com/problems/shortest-distance-to-target-string-in-a-circular-array/). It provides a single function `shortest_distance` that finds the minimum number of steps to reach a target string from a given starting index, where the array wraps around circularly (you can walk left or right).

## Key Components

### `shortest_distance(words, target, startIndex) -> int`

The sole public function. Given a circular array of strings, it returns the fewest steps needed to reach any occurrence of `target` starting from `startIndex`, moving either direction. Returns `-1` if `target` isn't present.

**Parameters:**
- `words`: the circular array
- `target`: string to find
- `startIndex`: where you start in the array

**Return:** minimum circular distance, or `-1`

## Patterns

**Sentinel-based minimum tracking.** Instead of tracking a boolean `found` flag separately, the code initializes `result = n` — a value impossible to achieve as a real distance (max circular distance is `n // 2`). After the loop, `result < n` doubles as a "was found" check. This avoids branching on a separate flag.

**Dual-distance formula.** For any candidate index `i`, the clockwise distance is `abs(i - startIndex)` and the counter-clockwise distance is `n - abs(i - startIndex)`. The line `min(result, dist, n - dist)` computes both directions in one expression and keeps the running minimum — a standard idiom for circular distance problems.

## Dependencies

**Imports:** None. Pure function with no external dependencies.

**Imported by:** Its own `test_solution.py`. The "Imported By" list in the prompt is misleading — those are test files for *other* problems that happen to share a test harness or runner pattern, not actual imports of this function.

## Flow

1. Capture array length `n`.
2. Set sentinel `result = n`.
3. Linear scan: for each index `i`, if `words[i] == target`, compute `dist = abs(i - startIndex)`, then update `result = min(result, dist, n - dist)`.
4. Return `result` if a match was found (`result < n`), else `-1`.

Single pass, O(n) time, O(1) space.

## Invariants

- `dist` is always the linear (non-circular) distance between `i` and `startIndex`, in `[0, n-1]`.
- `n - dist` is the complementary circular distance. The minimum of the two is the true shortest path.
- The sentinel `n` is strictly greater than any achievable circular distance, so it can never be confused with a real answer.

## Error Handling

No explicit error handling. If `target` is absent from `words`, the sentinel survives the loop and the ternary returns `-1`. Empty `words` list would return `-1` correctly (loop body never executes, `result` stays at `0` which equals `n`... actually both are 0, so `0 < 0` is false → returns `-1`).

## Topics to Explore

- [file] `shortest-distance-to-target-string-in-a-circular-array/test_solution.py` — See edge cases tested (empty array, multiple occurrences, target at startIndex)
- [file] `distance-between-bus-stops/solution.py` — Another circular-distance problem; compare the dual-direction distance approach
- [file] `minimum-time-to-type-word-using-special-typewriter/solution.py` — Circular distance on a 26-letter ring; same `min(d, n-d)` idiom
- [general] `circular-array-distance-idiom` — The `min(abs(i-j), n - abs(i-j))` pattern recurs across many LeetCode problems involving rings or cycles
- [file] `most-visited-sector-in-a-circular-track/solution.py` — Different circular-array problem with a modular arithmetic approach worth contrasting

## Beliefs

- `sentinel-equals-n` — The sentinel value `n` is chosen because the maximum possible circular distance is `n // 2`, so `n` can never be a legitimate result
- `single-pass-all-occurrences` — The algorithm checks every index, correctly handling multiple occurrences of `target` by keeping the running minimum
- `no-modular-arithmetic-needed` — The circular distance is computed via `min(abs(i - startIndex), n - abs(i - startIndex))` without any modulo operations
- `returns-neg-one-on-missing` — When `target` is not in `words`, the function returns `-1` (not 0, not an exception)

