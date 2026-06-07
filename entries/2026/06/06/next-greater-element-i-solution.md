# File: next-greater-element-i/solution.py

**Date:** 2026-06-06
**Time:** 18:12

## Purpose

This file solves [LeetCode 496 — Next Greater Element I](https://leetcode.com/problems/next-greater-element-i/). Given two arrays `nums1` (a subset of `nums2`), it finds, for each element in `nums1`, the first element in `nums2` that is strictly greater and appears to its right. Returns `-1` when no such element exists.

It's a standalone solution module following the repo's convention: one directory per problem, each containing `solution.py`, `test_solution.py`, `plan.md`, and `review.md`.

## Key Components

**`next_greater_element(nums1, nums2) -> list[int]`** — The sole public function. Precomputes a next-greater mapping for all elements in `nums2`, then answers each query from `nums1` via dictionary lookup.

- `next_greater: dict[int, int]` — Maps each value in `nums2` to its next greater element. Only populated for values that *have* a next greater element; absence means -1.
- `stack: list[int]` — A monotonic decreasing stack of values from `nums2` still waiting for their next greater element.

## Patterns

**Monotonic stack** — This is the textbook application. The stack maintains a decreasing sequence of unresolved values. When a new value `num` arrives that's larger than the stack top, all smaller values on the stack have found their answer. The `while` loop pops and records them all before pushing `num`.

This separates the problem into two phases:
1. **Precomputation** (lines 14–18): Single pass over `nums2` builds the full `next_greater` map in O(n).
2. **Query** (line 20): Each `nums1` lookup is O(1) via `dict.get`.

This two-phase approach avoids the naive O(n*m) nested search.

## Dependencies

**Imports**: None — pure standard library, no external dependencies.

**Imported by**: `next-greater-element-i/test_solution.py` and (per the `imported_by` list) hundreds of other test files across the repo — likely because a shared test runner or fixture mechanism imports solution modules generically, not because those tests actually use this function.

## Flow

1. Initialize empty `next_greater` dict and empty `stack`.
2. Iterate each `num` in `nums2`:
   - While the stack is non-empty and `stack[-1] < num`: pop the top, record `popped → num` in `next_greater`.
   - Push `num` onto the stack.
3. After the loop, any values still on the stack have no next greater element — they're simply never added to `next_greater`.
4. Map each element of `nums1` through `next_greater.get(num, -1)`, returning -1 for unresolved values.

**Concrete trace** — `nums2 = [1, 3, 4, 2]`:
- `num=1`: stack=`[1]`
- `num=3`: pop 1→3, stack=`[3]`
- `num=4`: pop 3→4, stack=`[4]`
- `num=2`: stack=`[4, 2]`
- Result: `next_greater = {1: 3, 3: 4}`. Values 4 and 2 have no next greater.

## Invariants

- **Stack monotonicity**: The stack is always in decreasing order (top is smallest). The `while` loop enforces this — anything smaller than the incoming value is popped before the push.
- **Unique elements**: The problem guarantees all elements in `nums1` and `nums2` are unique, so the dict keyed by value is unambiguous. If duplicates existed, later occurrences would overwrite earlier mappings.
- **Subset constraint**: `nums1` is guaranteed to be a subset of `nums2`. The code doesn't validate this — it silently returns -1 for values not in `nums2`.

## Error Handling

None. The function trusts its inputs per LeetCode constraints. `dict.get` with default -1 is the only defensive measure — it handles both "no next greater exists" and (implicitly) "value not in `nums2`" identically.

## Complexity

- **Time**: O(n + m) where n = len(nums2), m = len(nums1). Each element is pushed and popped from the stack at most once.
- **Space**: O(n) for the dictionary and stack.

## Topics to Explore

- [file] `next-greater-element-i/test_solution.py` — Test cases revealing edge cases the solution handles (empty arrays, single elements, fully decreasing input)
- [file] `final-prices-with-a-special-discount-in-a-shop/solution.py` — Another monotonic stack problem in this repo; compare how the stack direction and comparison operator change for "next smaller" variants
- [general] `monotonic-stack-family` — LeetCode 496, 503 (Next Greater Element II, circular), 739 (Daily Temperatures) all use the same core pattern with small variations
- [file] `next-greater-element-i/plan.md` — The planning document likely captures the decision to use a monotonic stack vs. brute force

## Beliefs

- `nge-linear-time` — The solution runs in O(n + m) time because each element of nums2 is pushed and popped from the stack at most once
- `nge-precompute-then-query` — The algorithm separates into a precomputation pass over nums2 and an O(1)-per-element query phase for nums1, making it efficient when nums1 is much smaller than nums2
- `nge-unique-elements-assumed` — The dict-keyed-by-value approach is correct only because the problem guarantees all elements are unique; duplicate values would cause silent overwrites
- `nge-stack-monotonic-decreasing` — The stack invariant is strictly decreasing from bottom to top at all times during the nums2 iteration

