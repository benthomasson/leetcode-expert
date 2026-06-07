# File: rings-and-rods/solution.py

**Date:** 2026-06-06
**Time:** 18:56

## Purpose

This file is a self-contained solution to [LeetCode 2103: Rings and Rods](https://leetcode.com/problems/rings-and-rods/). It owns both the algorithm implementation and its test suite in a single module — the standard pattern across this repository's ~500+ problem directories.

The problem: given a string encoding color-rod pairs (e.g., `"B0R0G0"`), count how many rods have all three colors (Red, Green, Blue) placed on them.

## Key Components

### `Solution.countPoints(rings: str) -> int`

The core algorithm. Takes a string where each pair of characters represents a color (`R`/`G`/`B`) followed by a rod number (`0`-`9`), and returns the count of rods that collected all three colors.

### `TestSolution`

Eight test cases covering: the three LeetCode examples, full coverage (all 10 rods with all colors), single-rod edge cases, duplicate colors on one rod, two-color insufficiency, and multi-rod qualifying scenarios.

## Patterns

**Set accumulation with `defaultdict(set)`** — Each rod maps to a set of colors. Using a set automatically deduplicates repeated colors on the same rod, which is exactly what the problem requires. The final check `len(colors) == 3` works because there are exactly three possible colors.

**Stride-2 iteration** — `range(0, len(rings), 2)` walks the string in pairs. This avoids explicit parsing or regex — the input format guarantees alternating color-char/digit-char pairs, so fixed-stride indexing is the cleanest approach.

**Counting via generator expression** — `sum(1 for ... if ...)` is the idiomatic Python pattern for conditional counting without materializing an intermediate list.

## Dependencies

**Imports**: `collections.defaultdict` (core data structure), `unittest` (test harness).

**Imported by**: The `test_solution.py` in this same directory, plus the "Imported By" list in the prompt is misleading — that list appears to be an artifact of the repository tooling referencing a shared test runner or import pattern across all problem directories, not actual imports of this specific solution.

## Flow

1. Initialize `rods` as a `defaultdict(set)` — keys are rod identifiers (single-char strings `'0'`–`'9'`), values are sets of color characters.
2. Walk `rings` two characters at a time: extract the color at position `i` and the rod at position `i+1`.
3. Add each color to its rod's set (duplicates are absorbed by the set).
4. Count and return the number of rods whose color set has exactly 3 elements.

For input `"B0R0G0R9"`: after the loop, `rods = {'0': {'B', 'R', 'G'}, '9': {'R'}}`. Rod `'0'` has 3 colors → counts. Rod `'9'` has 1 → doesn't. Returns `1`.

## Invariants

- The input string always has even length (pairs of characters). The code does not validate this — it trusts the LeetCode contract.
- Rod identifiers are single characters (`'0'`–`'9'`), so there are at most 10 rods.
- The magic number `3` in `len(colors) == 3` is tied to exactly three possible colors (`R`, `G`, `B`). If the problem added a fourth color, this would need updating.

## Error Handling

None. The solution trusts the problem's input constraints. An odd-length string would silently produce a wrong answer (the last character would be treated as a color with no rod). An empty string returns `0` correctly since `rods` stays empty.

## Topics to Explore

- [file] `rings-and-rods/test_solution.py` — Separate test file that likely imports this Solution class; compare with the inline tests here
- [file] `rings-and-rods/review.md` — Code review notes that may document alternative approaches (bitmask, Counter-based)
- [general] `set-accumulation-pattern` — Many problems in this repo use `defaultdict(set)` for group membership tracking; compare with `check-if-the-sentence-is-pangram` and `count-the-number-of-consistent-strings`
- [function] `rings-and-rods/solution.py:countPoints` — Consider the bitmask alternative: 3 bits per rod (R=1, G=2, B=4), check for `== 7`, avoids set overhead entirely
- [file] `run_tests.py` — The repo-wide test runner that exercises all solution files including this one

## Beliefs

- `rings-input-stride-2` — `countPoints` assumes the input string has exactly 2 characters per ring placement (color + rod digit) and does not validate length parity
- `rod-completion-threshold-hardcoded` — The completion check uses the literal `3`, coupling it to the RGB color set; a fourth color would require changing this constant
- `defaultdict-set-dedup` — Duplicate color placements on the same rod are harmlessly absorbed by the set, making the solution idempotent per rod-color pair
- `rod-keys-are-strings` — Rod identifiers are stored as single-character strings (not integers), since they're extracted directly from the input string without conversion

