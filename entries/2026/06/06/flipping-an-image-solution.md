# File: flipping-an-image/solution.py

**Date:** 2026-06-06
**Time:** 16:53

## `flipping-an-image/solution.py`

### Purpose

This file solves [LeetCode 832 — Flipping an Image](https://leetcode.com/problems/flipping-an-image/). Given an `n x n` binary matrix, it flips each row horizontally (reverses it), then inverts every value (`0 → 1`, `1 → 0`). The file owns this single transformation and exposes it via the standard `Solution` class that LeetCode and the project's test harness expect.

### Key Components

**`Solution.flipAndInvertImage(self, image: list[list[int]]) -> list[list[int]]`**

The only method. It mutates the input matrix in-place and also returns it — matching LeetCode's convention where the return value is the same object.

### Patterns

**Fused reverse-and-invert via two-pointer swap.** The clever move here is that the reverse and invert are not done as separate passes. Instead, a single `while lo <= hi` loop does both at once:

```python
row[lo], row[hi] = row[hi] ^ 1, row[lo] ^ 1
```

This simultaneously swaps `row[lo]` and `row[hi]` (the reverse) and XORs each with `1` (the invert). When `lo == hi` (the middle element in an odd-length row), the element is XORed with `1` twice in the same assignment — but since `row[lo]` and `row[hi]` refer to the same position, the value is read once and written once, so it's correctly inverted exactly once.

**In-place mutation.** No new lists are allocated. The method modifies the input matrix directly, which is O(1) extra space.

### Dependencies

**Imports:** None — pure standard-library Python with no external dependencies.

**Imported by:** The project's `flipping-an-image/test_solution.py` imports and tests this class. The long "Imported By" list in the prompt is an artifact of the repo's test infrastructure — those other test files don't actually depend on this solution; they share a common test harness pattern.

### Flow

1. Iterate over each `row` in `image`.
2. Initialize two pointers: `lo = 0`, `hi = len(row) - 1`.
3. While `lo <= hi`, swap-and-invert the elements at both ends, then move the pointers inward.
4. After all rows are processed, return the (now mutated) `image`.

For a 3×3 matrix like `[[1,1,0],[1,0,1],[0,0,0]]`:
- Row `[1,1,0]`: swap+invert positions 0↔2 → `[1,0,0]`, then position 1 (middle) inverts → `[1,0,0]` — wait, let's trace precisely: `lo=0, hi=2`: `row[0], row[2] = 0^1, 1^1 = 1, 0` → `[1,1,1]` wait — nope. Let me be precise. Original row: `[1,1,0]`. `lo=0, hi=2`: `row[0], row[2] = row[2]^1, row[0]^1 = 0^1, 1^1 = 1, 0` → `[1,1,0]` hmm, that gives `[1,1,0]`. Then `lo=1, hi=1`: `row[1], row[1] = row[1]^1, row[1]^1 = 0, 0` → `[1,0,0]`. Result: `[1,0,0]`. Which is correct: reverse `[1,1,0]` → `[0,1,1]`, invert → `[1,0,0]`.

### Invariants

- **Binary input**: The code assumes all values are `0` or `1`. XOR with `1` only produces a valid flip for binary values.
- **Rectangular matrix**: Each row is processed independently; rows can technically differ in length, though the problem guarantees `n × n`.
- **`lo <= hi` not `lo < hi`**: The `<=` is critical — it ensures the middle element of odd-length rows gets inverted. Using `<` would leave it unchanged, which is a bug.

### Error Handling

None. The method trusts its input conforms to the problem constraints. No validation, no exceptions. This is typical for LeetCode solutions in this repo.

---

## Topics to Explore

- [file] `flipping-an-image/test_solution.py` — See what edge cases the test suite covers (empty matrix, single-element, even vs odd dimensions)
- [file] `flipping-an-image/review.md` — The code review likely discusses the fused swap-invert trick and any alternative approaches considered
- [function] `transpose-matrix/solution.py:transpose` — Another matrix manipulation solution; compare how it handles in-place vs allocating a new matrix
- [general] `xor-bit-flip-pattern` — The `^ 1` idiom for binary inversion appears across multiple solutions in this repo (e.g., `complement-of-base-10-integer`, `number-complement`)
- [file] `determine-whether-matrix-can-be-obtained-by-rotation/solution.py` — Related matrix transformation problem that may use similar two-pointer or in-place techniques

## Beliefs

- `fused-reverse-invert` — The swap-and-XOR in `flipAndInvertImage` performs both the horizontal flip and the bit inversion in a single pass per row, not two separate passes.
- `middle-element-correctness` — The `lo <= hi` condition (not `lo < hi`) ensures the center element of odd-length rows is inverted exactly once when `lo == hi`.
- `in-place-mutation` — `flipAndInvertImage` mutates and returns the same `image` object; it allocates no new lists.
- `no-input-validation` — The method performs no bounds checking or type validation; it assumes a well-formed binary matrix per LeetCode constraints.

