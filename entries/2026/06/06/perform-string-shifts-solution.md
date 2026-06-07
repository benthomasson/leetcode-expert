# File: perform-string-shifts/solution.py

**Date:** 2026-06-06
**Time:** 18:32

## `perform-string-shifts/solution.py`

### Purpose

This file solves [LeetCode 1427 — Perform String Shifts](https://leetcode.com/problems/perform-string-shifts/). It implements a single function that applies a sequence of left/right shift operations to a string and returns the result. This was a 30-day LeetCode challenge problem (April 2020).

### Key Components

**`inorder(s, shift)`** — The sole public function. Despite the misleading name (it has nothing to do with tree traversal), it performs circular string rotation.

- **Parameters**: `s` (the string to shift), `shift` (list of `[direction, amount]` pairs where `0` = left shift, `1` = right shift)
- **Returns**: The string after all shifts are applied
- **Contract**: Assumes `s` is non-empty (uses `len(s)` as a modulo divisor on line 16 without a guard)

### Patterns

**Net-shift optimization**: Rather than applying each shift operation sequentially (which would be O(n * total_shift_amount) with string copies), the solution collapses all operations into a single net displacement. Right shifts add, left shifts subtract. This reduces the problem to a single string slice — O(n) total regardless of how many shift operations exist.

**Modular arithmetic**: `net %= len(s)` on line 16 normalizes the displacement into `[0, len(s))`, handling shifts that wrap around multiple times. This also collapses negative net values into their positive equivalents via Python's floor-modulo semantics (e.g., `-2 % 5 == 3`).

**Slice-based rotation**: `s[-net:] + s[:-net]` on line 20 performs a right rotation by `net` positions using two complementary slices. This is the standard Python idiom for circular rotation.

### Dependencies

- **Imports**: Only `typing.List` for the type annotation.
- **Imported by**: `perform-string-shifts/test_solution.py` directly. The "Imported By" list in the prompt is misleading — those are other test files that import from their *own* `solution.py`, not from this one.

### Flow

1. Accumulate a net shift value: right (`direction == 1`) adds, left subtracts
2. Normalize via modulo to handle wraparound
3. Short-circuit if `net == 0` (no-op)
4. Return the rotated string via slicing

For input `s = "abcdefg"`, `shift = [[1, 1], [1, 1], [0, 2], [1, 3]]`:
- Net = +1 +1 -2 +3 = 3
- 3 % 7 = 3
- Result: `s[-3:] + s[:-3]` = `"efg" + "abcd"` = `"efgabcd"`

### Invariants

- `net` after the modulo is always in `[0, len(s))` — Python's `%` operator guarantees non-negative results for positive divisors
- The early return on line 19 prevents `s[0:] + s[:0]` which would work but is a wasteful copy

### Error Handling

None. The function will raise `ZeroDivisionError` if `s` is empty (line 16). It trusts that `shift` entries are well-formed `[int, int]` pairs — no validation. This is typical for LeetCode solutions where input constraints are guaranteed by the problem.

---

## Topics to Explore

- [file] `perform-string-shifts/test_solution.py` — See the test cases to understand edge cases (empty shifts, full rotations, net-zero shifts)
- [file] `shift-2d-grid/solution.py` — Another shift/rotation problem; compare how the rotation idiom adapts to 2D
- [file] `rotate-string/solution.py` — The closely related "is B a rotation of A?" problem, likely uses the double-concatenation trick
- [general] `python-modulo-negative-numbers` — Python's floor-division modulo makes `(-2) % 5 == 3`, which is load-bearing here; C/Java would give `-2`
- [function] `perform-string-shifts/solution.py:inorder` — The name `inorder` is a misnomer inherited from a code generation template; the canonical LeetCode method name is `stringShift`

---

## Beliefs

- `net-shift-collapse` — All individual shift operations are collapsed into a single net displacement before any string manipulation occurs, making the solution O(n + k) where k is the number of shift operations
- `python-modulo-invariant` — The modulo on line 16 normalizes negative net shifts into valid positive indices because Python's `%` always returns a non-negative result for positive divisors
- `empty-string-crash` — Passing an empty string `s` will raise `ZeroDivisionError` at `net %= len(s)` — no guard exists
- `function-name-misnomer` — The function is named `inorder` but performs string rotation; this naming pattern appears to be a template artifact across the repository rather than an intentional choice

