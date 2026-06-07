# File: latest-time-by-replacing-hidden-digits/solution.py

**Date:** 2026-06-06
**Time:** 17:20

## Purpose

This file solves [LeetCode 1736 — Latest Time by Replacing Hidden Digits](https://leetcode.com/problems/latest-time-by-replacing-hidden-digits/). Given a time string in `"HH:MM"` format where `?` characters represent unknown digits, it finds the latest (maximum) valid time by greedily replacing each `?` with the largest digit that keeps the time valid. The file is self-contained: solution class and unit tests in one module.

## Key Components

### `Solution.maximumTime(self, time: str) -> str`

The single method. It converts the input string to a mutable list, then resolves each `?` position left-to-right with greedy choices:

| Position | Rule | Rationale |
|----------|------|-----------|
| `t[0]` (tens-hour) | `'2'` if `t[1]` is `?` or `0-3`; else `'1'` | Hours go up to 23. If the ones-hour is 4–9, tens-hour can't be 2 (that would exceed 23), so 1 is the max. |
| `t[1]` (ones-hour) | `'3'` if `t[0] == '2'`; else `'9'` | When tens-hour is 2, ones-hour maxes at 3 (23:xx). Otherwise it's 9 (19:xx, 09:xx). |
| `t[3]` (tens-minute) | `'5'` | Minutes range 00–59; tens digit maxes at 5. |
| `t[4]` (ones-minute) | `'9'` | Ones digit always maxes at 9. |

Position `t[2]` is always `:` and is never touched.

### `TestMaximumTime`

Twelve test cases covering: the three LeetCode examples, all-`?`, no-`?`, each individual position in isolation, and the critical coupling between `t[0]` and `t[1]` (the `?4:00` → `14:00` vs `?3:00` → `23:00` distinction).

## Patterns

**Greedy positional resolution.** Each digit is resolved independently, left-to-right. This works because earlier positions have strictly higher place value — maximizing them first always produces the global maximum. The only dependency is between positions 0 and 1 (hours), which the code handles via cross-referencing.

**Mutable list idiom.** Python strings are immutable, so the code converts to `list(time)`, mutates in place, then joins back. Standard pattern for character-level string manipulation in Python.

**Self-contained test module.** Tests live alongside the solution with `unittest.main()` at the bottom, matching the repo-wide convention.

## Dependencies

**Imports:** Only `unittest` from the standard library. No external dependencies.

**Imported by:** The `test_solution.py` file in this same directory imports from it. The massive "Imported By" list in the prompt is misleading — those are *other problems'* test files that happen to share the same structural pattern, not actual importers of this module.

## Flow

1. Input: `"HH:MM"` string with `?` wildcards
2. Convert to `list` of 5 characters
3. Resolve `t[0]` — depends on `t[1]`'s current value (which may still be `?`)
4. Resolve `t[1]` — depends on `t[0]`'s now-resolved value
5. Resolve `t[3]` — independent
6. Resolve `t[4]` — independent
7. Join and return

The ordering matters: `t[0]` must be resolved before `t[1]` because `t[1]`'s max depends on whether `t[0]` is `2`. Conversely, `t[0]`'s logic checks `t[1]`'s *original* value (or `?`), which is correct — when `t[1]` is still `?`, it means "any digit is possible," so `t[0]` can safely be `2`.

## Invariants

- Output is always a valid 24-hour time (`00:00` through `23:59`).
- Each `?` is replaced with the largest digit that maintains validity.
- Non-`?` characters are never modified.
- The hour constraint (0–23) creates a dependency between `t[0]` and `t[1]`; the minute constraint (0–59) does not create any cross-position dependency.

## Error Handling

None. The method assumes well-formed input: exactly 5 characters, format `"??:??"` where each `?` is either a valid digit or `?`, and a colon at position 2. No validation, no exceptions. This is typical for LeetCode solutions where input constraints are guaranteed by the problem.

## Topics to Explore

- [file] `latest-time-by-replacing-hidden-digits/test_solution.py` — Separate test file that imports this solution; check whether it duplicates or extends the inline tests
- [file] `number-of-valid-clock-times/solution.py` — Related problem (counting valid times instead of maximizing); likely uses similar digit-constraint logic
- [general] `greedy-digit-resolution` — The pattern of resolving digits left-to-right by place value appears in several problems (maximum-69-number, largest-number-after-digit-swaps-by-parity); compare approaches
- [file] `latest-time-by-replacing-hidden-digits/review.md` — Code review notes that may document edge cases or alternative approaches considered
- [function] `latest-time-by-replacing-hidden-digits/solution.py:maximumTime` — The `t[1] in '?0123'` check is the subtle heart of the algorithm; trace what happens when `t[1]` is `4` vs `3` to build intuition

## Beliefs

- `greedy-left-to-right-is-optimal` — Resolving digits left-to-right (highest place value first) produces the globally maximum valid time because each position's contribution strictly dominates all lower positions combined.
- `hour-digits-are-coupled` — Position 0 and position 1 have a mutual dependency: `t[0]`'s max depends on `t[1]`'s current value, and `t[1]`'s max depends on `t[0]`'s resolved value. The code handles this by resolving `t[0]` first while `t[1]` may still be `?`.
- `minute-digits-are-independent` — Positions 3 and 4 have fixed maximums (5 and 9) regardless of any other position, because the minute range 00–59 doesn't create cross-digit constraints.
- `question-mark-means-unconstrained-for-predecessor` — When `t[0]` checks `t[1] in '?0123'`, including `?` is correct: if `t[1]` is unknown, `t[0]=2` is safe because `t[1]` will later resolve to at most 3.

