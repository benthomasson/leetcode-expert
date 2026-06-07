# File: find-numbers-with-even-number-of-digits/solution.py

**Date:** 2026-06-06
**Time:** 16:40

## `find-numbers-with-even-number-of-digits/solution.py`

### Purpose

This file is a self-contained solution to [LeetCode 1295: Find Numbers with Even Number of Digits](https://leetcode.com/problems/find-numbers-with-even-number-of-digits/). It owns both the algorithm implementation and its test suite, following the repo-wide convention of colocating solution and tests in a single file per problem.

### Key Components

**`Solution.findNumbers(nums: List[int]) -> int`** — The core method. Takes a list of positive integers and returns how many of them have an even digit count. The implementation is a single generator expression:

```python
return sum(1 for n in nums if len(str(n)) % 2 == 0)
```

It converts each number to its string representation, checks if the length is even, and sums the truthy results.

**`TestFindNumbers`** — A `unittest.TestCase` with 7 test methods covering:
- LeetCode's two provided examples
- Single-element lists (both odd and even digit counts)
- All-even and all-odd digit count lists
- The upper boundary value `100000` (6 digits, even)

### Patterns

- **String-based digit counting**: Uses `str(n)` rather than `math.log10` or repeated division. This is the idiomatic Python approach — simpler, correct for all positive integers, and avoids floating-point edge cases that `log10` introduces.
- **Generator with `sum`**: The `sum(1 for ...)` pattern counts matches without building an intermediate list. Equivalent to `len([...])` but more memory-efficient.
- **Single-file solution+test**: Matches every other problem directory in the repo. The `if __name__ == "__main__"` guard allows running tests directly via `python solution.py`.

### Dependencies

**Imports**: `typing.List` (type annotation) and `unittest` (test framework). No project-internal dependencies.

**Imported by**: The massive `imported_by` list is misleading — those are other problems' test files, likely sharing a common test runner or import pattern, not actually importing `findNumbers`. The real consumer is `find-numbers-with-even-number-of-digits/test_solution.py`, which presumably imports the `Solution` class.

### Flow

1. Instantiate `Solution`
2. Call `findNumbers([12, 345, 2, 6, 7896])`
3. Generator iterates: `12` → `"12"` → len 2 → even → count 1; `345` → len 3 → odd → skip; `2` → len 1 → skip; `6` → len 1 → skip; `7896` → len 4 → even → count 1
4. `sum` returns `2`

### Invariants

- Input is assumed to be positive integers (per LeetCode constraints: `1 <= nums[i] <= 10^5`). Negative numbers would include the `-` sign in `str(n)`, inflating the digit count by 1 — the code does not guard against this.
- `str(0)` returns `"0"` (length 1, odd), which is correct but `0` is outside the stated constraint range.

### Error Handling

None. The method trusts its caller to provide valid input, consistent with LeetCode solution conventions. No try/except, no input validation. If `nums` is `None`, it raises `TypeError` from the generator; if an element is non-numeric, `str()` still works but `len()` would count non-digit characters.

## Topics to Explore

- [file] `find-numbers-with-even-number-of-digits/test_solution.py` — The separate test file that imports this solution; clarifies the actual import relationship
- [file] `find-numbers-with-even-number-of-digits/review.md` — Code review notes that may document alternative approaches (log10, division loop)
- [general] `str-vs-log10-digit-counting` — Why `len(str(n))` is preferred over `math.log10` in Python despite being O(d) in digit count — floating-point precision issues with `log10(1000)` returning `2.9999...`
- [file] `count-integers-with-even-digit-sum/solution.py` — Related digit-manipulation problem; compare how digit extraction is handled when you need digit values, not just count
- [file] `run_tests.py` — The repo-wide test runner; explains why so many test files appear in the `imported_by` list

## Beliefs

- `str-digit-count-correctness` — `findNumbers` is correct for all positive integers in `[1, 10^5]` but would miscount negative integers due to the `-` character in `str(n)`
- `single-pass-no-allocation` — The generator expression processes the list in a single pass with O(1) auxiliary memory (no intermediate list constructed)
- `solution-test-colocation` — Every problem directory contains a `solution.py` with both the `Solution` class and a `unittest.TestCase` subclass, runnable standalone via `__main__`
- `no-input-validation` — The solution performs zero input validation, relying on LeetCode's constraint guarantees (`1 <= nums[i] <= 10^5`, `1 <= nums.length <= 500`)

