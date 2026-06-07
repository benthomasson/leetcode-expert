# File: missing-number-in-arithmetic-progression/solution.py

**Date:** 2026-06-06
**Time:** 18:05

## Missing Number in Arithmetic Progression

### Purpose

This file solves [LeetCode 1228 — Missing Number In Arithmetic Progression](https://leetcode.com/problems/missing-number-in-arithmetic-progression/). Given an array where exactly one interior value has been removed from an arithmetic progression, it finds and returns that value.

### Key Components

**`Solution.mctFromLeafValues(arr: List[int]) -> int`**

The method name is a bug — `mctFromLeafValues` belongs to LeetCode 1130 ("Minimum Cost Tree From Leaf Values"). The actual implementation solves the missing-number problem. The docstring is correct; the method name is not.

### Flow

The algorithm runs in three stages:

1. **Recover the common difference** (line 15): `expected_diff = (arr[-1] - arr[0]) // n`. Since the problem guarantees the missing element is never the first or last, `arr[0]` and `arr[-1]` are the true endpoints of the original AP. The original AP had `n + 1` elements and `n` gaps, so `(last - first) / n` recovers the exact common difference. Integer division is safe here because the numerator is always exactly divisible.

2. **Handle constant sequences** (lines 17–18): If `expected_diff == 0`, every element is the same, and the missing value equals any element.

3. **Scan for the gap** (lines 20–22): Walk adjacent pairs. The first pair where the actual difference doesn't match `expected_diff` is where the removal happened. The missing value is `arr[i] + expected_diff`.

4. **Fallback** (line 24): `return arr[0]` — a defensive return that shouldn't be reached under valid inputs (if `expected_diff != 0`, there must be a gap somewhere).

**Complexity**: O(n) time, O(1) space.

### Patterns

- **LeetCode class convention**: Stateless `Solution` class with a single method, matching the LeetCode submission interface.
- **Difference-recovery from endpoints**: A common technique in AP problems — derive the step from the total span and count, then scan for the anomaly.

### Dependencies

**Imports**: `typing.List` — used only for the type annotation.

**Imported by**: The large "Imported By" list in the repository context is misleading. Those test files import the generic test runner infrastructure, not this specific solution. The actual consumer is `missing-number-in-arithmetic-progression/test_solution.py`.

### Invariants

- The input must be a sorted array with exactly one interior element removed from a valid AP.
- `arr[0]` and `arr[-1]` must be the true endpoints of the original progression — the problem guarantees this by stating the removed value is never the first or last.
- `(arr[-1] - arr[0])` is always exactly divisible by `len(arr)`, so the integer division introduces no truncation error.

### Error Handling

None. The code trusts its inputs entirely, which is standard for competitive programming solutions. No validation of array length, sortedness, or arithmetic-progression structure.

---

## Topics to Explore

- [file] `missing-number-in-arithmetic-progression/test_solution.py` — See how the test harness exercises edge cases (constant sequences, large arrays, negative progressions)
- [file] `missing-number-in-arithmetic-progression/review.md` — Check if the code review flagged the incorrect method name
- [function] `missing-number/solution.py:Solution` — Compare with the simpler "Missing Number" problem (LeetCode 268), which uses XOR or Gauss summation instead of difference recovery
- [file] `can-make-arithmetic-progression-from-sequence/solution.py` — Related AP problem; likely uses sorting + uniform-difference check rather than endpoint recovery
- [general] `method-name-mismatch-pattern` — Whether other solutions in this repo have similar copy-paste naming errors from the LeetCode template

## Beliefs

- `wrong-method-name-mctFromLeafValues` — The method is named `mctFromLeafValues` (from LeetCode 1130) but implements the missing-number-in-AP algorithm (LeetCode 1228)
- `endpoint-preservation-invariant` — The algorithm's correctness depends on the problem guarantee that the removed element is never the first or last in the original progression
- `integer-division-exact` — The expression `(arr[-1] - arr[0]) // n` never truncates under valid inputs because the span is always an exact multiple of n
- `constant-sequence-special-case` — When `expected_diff == 0`, the code short-circuits and returns `arr[0]` rather than scanning, since every element is identical

