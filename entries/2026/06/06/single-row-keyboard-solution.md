# File: single-row-keyboard/solution.py

**Date:** 2026-06-06
**Time:** 19:07

## Purpose

This file solves [LeetCode 1165 - Single Row Keyboard](https://leetcode.com/problems/single-row-keyboard/). It calculates the total time to type a word on a keyboard where all 26 letters are arranged in a single row. The "time" to move between keys equals the absolute difference of their positions. The finger starts at position 0 (the first key).

## Key Components

### `calculate_time(keyboard: str, word: str) -> int`

The sole public function. Contract:

- **Input**: `keyboard` is a 26-character string representing the physical layout (each character's index is its position on the keyboard). `word` is the string to type.
- **Output**: Total time as the sum of absolute position differences for each consecutive pair of key presses, starting from position 0.
- **Assumption**: Every character in `word` exists in `keyboard`. No validation is performed.

### `TestCalculateTime`

Seven unit tests covering:
- Standard LeetCode examples (alphabetical keyboard, rotated keyboard)
- Edge cases: single character at position 0, single character at position 25, repeated same character (zero movement), worst-case alternating endpoints, sequential full alphabet

## Patterns

**Precomputed index map**: The function builds a `pos` dictionary mapping each character to its keyboard index in O(26) time before iterating the word. This is the standard hash-map-for-O(1)-lookup idiom — avoids calling `keyboard.index(c)` (O(26)) per character.

**Accumulator loop**: Tracks `current` position and accumulates `total` cost in a single pass over `word`. This is the canonical "simulate the process" pattern for position-tracking problems.

**Self-contained test file**: Tests live alongside the solution rather than in a separate test directory, following the project-wide convention visible in the repository structure.

## Dependencies

**Imports**: Only `unittest` from the standard library. No external dependencies.

**Imported by**: The "Imported By" list in the prompt is misleading — it lists hundreds of test files across the entire repo. This is likely an artifact of the analysis tool picking up `import unittest` as a shared dependency, not actual imports of this module's `calculate_time` function. The real consumer is `single-row-keyboard/test_solution.py`.

## Flow

1. Build `pos`: `{c: i for i, c in enumerate(keyboard)}` — O(26) dictionary comprehension.
2. Initialize `current = 0` (finger starts at the leftmost key).
3. For each character `c` in `word`:
   - Add `abs(current - pos[c])` to `total`.
   - Update `current` to `pos[c]`.
4. Return `total`.

Total complexity: O(n) where n = len(word), with O(1) space beyond the fixed-size 26-entry dictionary.

## Invariants

- `keyboard` must be a permutation of 26 lowercase letters (not enforced, but assumed).
- Every character in `word` must appear in `keyboard`, otherwise `pos[c]` raises `KeyError`.
- `current` always reflects the position of the most recently typed character (or 0 before any typing).

## Error Handling

None. Invalid inputs (characters not in the keyboard, empty keyboard, non-lowercase characters) will raise unhandled `KeyError` or produce silently wrong results. This is typical for LeetCode solutions where inputs are guaranteed valid by the problem constraints.

## Topics to Explore

- [file] `single-row-keyboard/plan.md` — The planning document may reveal alternative approaches considered (e.g., direct `str.index` vs. hash map)
- [file] `single-row-keyboard/review.md` — Code review notes that may discuss complexity tradeoffs or edge cases
- [function] `minimum-time-to-type-word-using-special-typewriter/solution.py:minTimeToType` — A closely related problem where the keyboard is circular (modular arithmetic instead of absolute difference)
- [file] `keyboard-row/solution.py` — Another keyboard-position problem; compare how keyboard layout is modeled
- [general] `index-map-pattern` — The `{char: index}` precomputation pattern recurs across many string/array problems in this repo (e.g., decode-the-message, find-anagram-mappings)

## Beliefs

- `single-row-keyboard-linear-time` — `calculate_time` runs in O(n) time and O(1) auxiliary space (the pos dict is fixed at 26 entries regardless of input size)
- `single-row-keyboard-no-validation` — The function assumes all characters in `word` exist in `keyboard`; a missing character raises an unhandled `KeyError`
- `single-row-keyboard-start-position` — The finger always starts at index 0 of the keyboard string, not at the position of any particular letter
- `single-row-keyboard-self-contained` — The file combines solution and tests in a single module, runnable via `python -m unittest` or `python solution.py`

