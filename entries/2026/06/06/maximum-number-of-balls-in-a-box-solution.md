# File: maximum-number-of-balls-in-a-box/solution.py

**Date:** 2026-06-06
**Time:** 17:39

## Purpose

This file is the self-contained solution and test suite for [LeetCode 1742 — Maximum Number of Balls in a Box](https://leetcode.com/problems/maximum-number-of-balls-in-a-box/). It owns the implementation, the unit tests, and (unusually) an alias to satisfy a mismatched task spec. Like every other problem directory in this repo, it follows the `solution.py` + `test_solution.py` convention, though here both live in a single file.

## Key Components

### `Solution.countBalls(lowLimit, highLimit) -> int`

The core method. Given a range `[lowLimit, highLimit]`, it assigns each ball numbered `i` to the box whose label equals the digit sum of `i`, then returns the count of the most populated box.

The implementation is a single expression: build a `Counter` over digit sums, then take the `max` of its values.

### `maxWidthOfVerticalArea` (alias)

A class-level alias pointing to `countBalls`. The comment says it exists because the task spec expected a different method name — likely a copy-paste artifact from LeetCode's code template for a different problem (1637 — Widest Vertical Area). This means `Solution().maxWidthOfVerticalArea(1, 10)` calls the same function.

### `TestCountBalls`

Six tests covering:
- Three LeetCode examples (`1..10`, `5..15`, `19..28` — all expect 2)
- Single-element range (`7..7` — expects 1)
- Full constraint range (`1..100000` — smoke test, just asserts > 0)
- Alias correctness

## Patterns

**Counter-based frequency analysis** — the canonical Python idiom for "count occurrences, find the max." The generator expression inside `Counter(...)` avoids materializing an intermediate list.

**Digit-sum via string conversion** — `sum(int(d) for d in str(i))` converts the integer to a string, iterates characters, casts back. Readable but slower than repeated `divmod`. For LeetCode constraints (`highLimit <= 100000`) it's fine.

**Inline test suite** — tests live in the same file behind `if __name__ == "__main__"`, so `python solution.py` runs them directly.

## Dependencies

**Imports:** `collections.Counter` (frequency counting), `unittest` (test harness).

**Imported by:** The `test_solution.py` files listed in the `Imported By` section don't actually import *this* file — that list appears to be a repo-wide cross-reference artifact showing all test files that follow the same pattern, not true reverse dependencies. The real consumer is `maximum-number-of-balls-in-a-box/test_solution.py`.

## Flow

1. Iterate every integer `i` in `[lowLimit, highLimit]`.
2. For each `i`, convert to string, sum the digit characters cast to int → this is the box number.
3. Feed all box numbers into `Counter` to get `{box_number: count}`.
4. Return `max(counts.values())`.

Time: O(n * d) where n = highLimit - lowLimit + 1 and d = number of digits (~5 at most). Space: O(k) where k = number of distinct digit sums (at most 45 for 5-digit numbers).

## Invariants

- `lowLimit <= highLimit` is assumed (per LeetCode constraints). No validation.
- The digit sum for any number in `[1, 100000]` falls in `[1, 45]`, so the Counter will have at most 45 keys.
- `max(counts.values())` is safe because the range is non-empty (at least one ball exists).

## Error Handling

None. Invalid inputs (e.g., `lowLimit > highLimit`) would produce an empty `Counter`, and `max()` on an empty sequence would raise `ValueError`. This is acceptable — LeetCode guarantees valid inputs.

---

## Topics to Explore

- [file] `maximum-number-of-balls-in-a-box/review.md` — See what the automated review flagged (likely the alias oddity or string-based digit sum)
- [function] `count-largest-group/solution.py:countLargestGroup` — Closely related problem (LeetCode 1399) that also groups by digit sum but returns the count of groups at max size
- [general] `digit-sum-patterns` — Several solutions in this repo use digit-sum computation; compare approaches (string conversion vs divmod) across `add-digits`, `sum-of-digits-of-string-after-convert`, `count-integers-with-even-digit-sum`
- [file] `maximum-number-of-balls-in-a-box/test_solution.py` — The separate test file that likely imports from this solution; check whether it duplicates the inline tests

## Beliefs

- `digit-sum-via-str-conversion` — `countBalls` computes digit sums by casting to string and summing character values, not by arithmetic divmod
- `alias-is-identity` — `maxWidthOfVerticalArea` is a direct reference to `countBalls`, not a wrapper; calling either invokes the same code object
- `counter-max-keys-bounded` — The Counter produced by `countBalls` has at most 45 entries (max digit sum for a 5-digit number), regardless of input range size
- `no-input-validation` — The solution assumes `1 <= lowLimit <= highLimit <= 100000` per LeetCode constraints and will raise on empty ranges

