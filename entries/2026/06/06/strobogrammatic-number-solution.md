# File: strobogrammatic-number/solution.py

**Date:** 2026-06-06
**Time:** 19:17

## `strobogrammatic-number/solution.py`

### Purpose

This file solves [LeetCode 246 — Strobogrammatic Number](https://leetcode.com/problems/strobogrammatic-number/). A strobogrammatic number looks the same when rotated 180 degrees (flipped upside down). The file owns a single responsibility: determining whether a given numeric string has this rotational symmetry property.

### Key Components

**`Solution.isStrobogrammatic(self, num: str) -> bool`**

The sole method. It takes a string of digits and returns whether it reads identically after a 180-degree rotation.

**`mapping` dict** — The core lookup table encoding which digits are valid under rotation and what they map to:

| Digit | Rotated |
|-------|---------|
| 0     | 0       |
| 1     | 1       |
| 6     | 9       |
| 8     | 8       |
| 9     | 6       |

Digits 2, 3, 4, 5, 7 are absent — any string containing them is automatically non-strobogrammatic because the `num[left] not in mapping` check fails.

### Patterns

**Two-pointer inward sweep** — Classic palindrome-style traversal. `left` starts at 0, `right` at the last index, and they converge toward the center. This naturally handles both odd-length strings (where the middle digit must map to itself — only 0, 1, 8 qualify) and even-length strings.

The check `mapping[num[left]] != num[right]` is the key insight: unlike a palindrome where `s[i] == s[n-1-i]`, strobogrammatic numbers require `rotate(s[i]) == s[n-1-i]`. The mapping encodes the rotation.

### Dependencies

**Imports**: None. Pure self-contained logic with no stdlib or third-party dependencies.

**Imported by**: The `test_solution.py` in the same directory. The "Imported By" list in the prompt is misleading — those are unrelated test files in sibling problem directories that happen to share import machinery, not actual consumers of this solution.

### Flow

1. Build the rotation mapping (5 entries).
2. Initialize two pointers at string boundaries.
3. Loop while `left <= right`:
   - If `num[left]` isn't a rotatable digit → return `False`.
   - If the rotated version of `num[left]` doesn't match `num[right]` → return `False`.
   - Advance both pointers inward.
4. If the loop completes without failing → return `True`.

The `<=` in the loop condition (not `<`) is critical: for odd-length strings, the center character is compared against itself via `mapping[num[mid]] != num[mid]`, which correctly rejects `6` or `9` at the center (since `mapping['6'] == '9' != '6'`).

### Invariants

- Every digit in `num` must exist in `mapping`, or the number is rejected.
- For each position pair `(i, n-1-i)`, the rotated value of `num[i]` must equal `num[n-1-i]`.
- The center digit of an odd-length string must be self-symmetric under rotation (0, 1, or 8).

### Error Handling

None. The method assumes valid input (a non-empty string of digit characters), consistent with LeetCode's problem contract. No exceptions are raised or caught.

---

## Topics to Explore

- [file] `strobogrammatic-number/test_solution.py` — See what edge cases (single digit, leading zeros, center-digit rejection) are covered
- [file] `confusing-number/solution.py` — Related problem: a confusing number rotates to a *different* valid number, reuses the same digit-rotation mapping
- [general] `two-pointer-palindrome-variants` — This pattern recurs across palindrome, strobogrammatic, and two-sum problems in this repo
- [general] `strobogrammatic-number-ii` — The generative version (LeetCode 247) builds all strobogrammatic numbers of length n, a natural follow-up

## Beliefs

- `strobogrammatic-only-five-valid-digits` — Only digits 0, 1, 6, 8, 9 are valid in a strobogrammatic number; any other digit causes immediate rejection
- `strobogrammatic-center-must-be-self-symmetric` — The middle digit of an odd-length strobogrammatic number must be 0, 1, or 8 (enforced by the `left == right` iteration checking `mapping[d] == d`)
- `strobogrammatic-is-not-palindrome` — The check is `mapping[num[left]] == num[right]`, not `num[left] == num[right]`; "69" is strobogrammatic but not a palindrome
- `strobogrammatic-linear-time` — The algorithm runs in O(n) time and O(1) space (the mapping dict is fixed-size)

