# File: decode-xored-array/solution.py

**Date:** 2026-06-06
**Time:** 16:11

## Purpose

This file solves [LeetCode 1720: Decode XORed Array](https://leetcode.com/problems/decode-xored-array/). It reconstructs an original array from its XOR-encoded form given the first element. The file owns both the solution logic and its unit tests — a pattern consistent across the entire `leetcode-implementations` repo.

## Key Components

### `Solution.minOperations(encoded, first) -> List[int]`

Despite the misleading method name (`minOperations` — likely a copy-paste artifact from LeetCode's template, since the actual LeetCode method is `decode`), this function decodes an XOR-encoded array.

**Contract:**
- `encoded`: a list of integers where `encoded[i] = arr[i] XOR arr[i+1]`
- `first`: the first element of the original array
- Returns: the original array of length `len(encoded) + 1`

### `TestSolution`

Six test cases covering: LeetCode's provided examples, single-element encoded arrays, all-zeros, zero as `first`, and large values. No edge case for empty `encoded` (which the LeetCode constraints guarantee won't happen).

## Patterns

**XOR self-inverse property.** The entire solution rests on one algebraic fact: if `encoded[i] = arr[i] ^ arr[i+1]`, then `arr[i+1] = arr[i] ^ encoded[i]`. XOR is its own inverse — `a ^ b ^ b = a`. The loop on line 16 applies this recurrence iteratively.

**Accumulator pattern.** The result array is built by appending to `arr`, where each new element depends only on the previous element and the current encoded value. This is a left fold / scan.

**Self-contained test file.** Both solution and tests live in one file, runnable via `python solution.py`. This matches the repo-wide convention.

## Dependencies

**Imports:** `unittest` (stdlib) and `List` from `typing`. No external dependencies.

**Imported by:** The `Imported By` list in the prompt is misleading — those are *other* test files across the repo, not actual importers of this module. They likely share the same boilerplate structure, not a real import relationship.

## Flow

1. Initialize `arr` with `[first]`.
2. For each value in `encoded`, XOR the last element of `arr` with that value and append the result.
3. Return `arr`.

The loop runs exactly `len(encoded)` times, producing an output array of length `len(encoded) + 1`. Time: O(n). Space: O(n) for the output.

## Invariants

- **Loop invariant:** After processing `encoded[0..k-1]`, `arr` contains the first `k+1` elements of the original array, and `arr[-1]` is the correct value to XOR with `encoded[k]`.
- **Output length:** `len(result) == len(encoded) + 1` — always.
- **XOR correctness:** For all `i`, `arr[i] ^ arr[i+1] == encoded[i]`. This is guaranteed by the self-inverse property.

## Error Handling

None. The function assumes valid inputs per LeetCode constraints (`1 <= n <= 10^4`, `0 <= encoded[i] <= 10^5`). Empty `encoded` would correctly return `[first]` — the loop simply wouldn't execute.

## Topics to Explore

- [file] `xor-operation-in-an-array/solution.py` — Another XOR-based problem; compare how XOR is used constructively vs. deconstructively
- [function] `defuse-the-bomb/solution.py:Solution` — Similar array-construction-from-neighbors pattern with a different operator
- [general] `xor-self-inverse-property` — The algebraic identity `a ^ b ^ b = a` underpins this entire class of problems; understanding it unlocks decode/encode pairs, missing-number tricks, and swap-without-temp
- [file] `find-the-difference/solution.py` — Uses XOR to find a single differing element, same core insight applied differently
- [general] `method-name-mismatch` — `minOperations` doesn't match the problem; check if this is a repo-wide issue or isolated

## Beliefs

- `xor-decode-linear-time` — The decode loop runs in O(n) time and O(n) space with a single pass over `encoded`
- `xor-decode-method-name-wrong` — The method is named `minOperations` but implements `decode`; this is a naming error, not a logic error
- `xor-decode-empty-encoded-safe` — Passing an empty `encoded` list returns `[first]` without error, though LeetCode constraints guarantee non-empty input
- `xor-decode-deterministic` — Given `encoded` and `first`, the original array is uniquely determined — there is exactly one valid decoding

