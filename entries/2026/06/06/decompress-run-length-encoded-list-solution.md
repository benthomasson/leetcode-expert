# File: decompress-run-length-encoded-list/solution.py

**Date:** 2026-06-06
**Time:** 16:12

## `decompress-run-length-encoded-list/solution.py`

### Purpose

This file solves [LeetCode 1313: Decompress Run-Length Encoded List](https://leetcode.com/problems/decompress-run-length-encoded-list/). It takes a run-length encoded list — where consecutive pairs `[freq, val]` mean "repeat `val` exactly `freq` times" — and expands it into the full decompressed list.

### Key Components

**`Solution.add_rooms(self, nums: List[int]) -> List[int]`** — The single method. Note the method name `add_rooms` doesn't match the LeetCode canonical name `decompressRLElist`; this is a pattern across this repo where solutions use alternative method names.

The contract: given a list of even length where `nums[2i]` is a frequency and `nums[2i+1]` is a value, return the expanded list.

### Patterns

- **Step-2 iteration** — `range(0, len(nums), 2)` walks pairs without unpacking the list into tuples first. This is the standard idiom for processing paired elements in a flat list.
- **`list.extend` with repetition** — `[nums[i+1]] * nums[i]` builds the repeated segment in one expression, then `extend` appends it in bulk. This avoids nested loops and individual `append` calls.
- **Accumulator pattern** — `result` starts empty and grows via `extend`. The final list is returned at the end.

### Dependencies

**Imports:** `typing.List` — used only for the type annotation.

**Imported by:** `decompress-run-length-encoded-list/test_solution.py` directly. The massive "Imported By" list in the prompt is an artifact of the repo's test infrastructure — all test files share a common import pattern, not a real dependency on this specific solution.

### Flow

1. Initialize empty `result` list.
2. Iterate `i` over `0, 2, 4, ...` up to `len(nums) - 1`.
3. At each step, `nums[i]` is the frequency and `nums[i+1]` is the value.
4. Create a list of `nums[i]` copies of `nums[i+1]` and extend `result`.
5. Return the accumulated `result`.

For input `[1, 2, 3, 4]`: iteration 0 produces `[2]`, iteration 1 produces `[4, 4, 4]`, final result is `[2, 4, 4, 4]`.

### Invariants

- **Even-length input** — The code assumes `nums` has even length. An odd-length input would cause an `IndexError` on `nums[i+1]` in the last iteration. No guard is present because LeetCode guarantees this precondition.
- **Non-negative frequencies** — `[x] * n` with `n=0` produces `[]`, which is harmless. Negative `n` also produces `[]` in Python, so negative frequencies silently contribute nothing.

### Error Handling

None. The code trusts the caller to provide valid input per the LeetCode contract. An out-of-bounds access on `nums[i+1]` is the only possible failure mode, and it would propagate as an unhandled `IndexError`.

### Complexity

- **Time:** O(sum of all frequencies) — each element in the output is produced once.
- **Space:** O(sum of all frequencies) — the output list.

---

## Topics to Explore

- [file] `decompress-run-length-encoded-list/test_solution.py` — See what test cases validate this solution and how the `add_rooms` name is wired up
- [file] `decompress-run-length-encoded-list/review.md` — Read the code review for quality notes and alternative approaches
- [function] `design-compressed-string-iterator/solution.py:StringIterator` — The inverse problem: iterating over a compressed representation without fully decompressing
- [general] `run-length-encoding-solutions` — Other RLE-adjacent problems in this repo (e.g., `count-and-say`, string compression) to see how the pattern varies
- [file] `decode-xored-array/solution.py` — Another "decode a flat paired list" problem with similar iteration structure

## Beliefs

- `rle-decompress-uses-step2-iteration` — The solution processes pairs by iterating with step 2 rather than slicing or zipping, which is the dominant pair-processing idiom in this repo
- `rle-decompress-method-name-mismatch` — The method is named `add_rooms` instead of the LeetCode canonical `decompressRLElist`, consistent with this repo's convention of using alternative method names
- `rle-decompress-no-input-validation` — The solution performs no validation on input length or frequency values, relying entirely on LeetCode's guarantees
- `rle-decompress-linear-in-output-size` — Time and space complexity are both O(total decompressed length), which is optimal since every output element must be produced

