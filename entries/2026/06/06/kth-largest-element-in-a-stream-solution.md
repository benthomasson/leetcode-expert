# File: kth-largest-element-in-a-stream/solution.py

**Date:** 2026-06-06
**Time:** 17:12

## Purpose

This file implements [LeetCode 703 — Kth Largest Element in a Stream](https://leetcode.com/problems/kth-largest-element-in-a-stream/). It provides a `KthLargest` class that maintains a running stream of integers and can answer "what is the kth largest element right now?" in O(log k) time per insertion. It's a textbook application of a bounded min-heap.

## Key Components

### `KthLargest` class

**Constructor** `__init__(self, k: int, nums: list[int]) -> None`

- Copies `nums`, heapifies it in O(n), then pops until only `k` elements remain.
- After construction, `self.heap` is a min-heap of exactly `min(k, len(nums))` elements representing the k largest values seen so far.
- `self.k` is stored for use in `add()`.

**Method** `add(self, val: int) -> int`

- Pushes `val` onto the heap, then pops the smallest if size exceeds `k`.
- Returns `self.heap[0]` — the minimum of the k largest elements, which is by definition the kth largest overall.

## Patterns

**Bounded min-heap** — the central insight. Instead of sorting or maintaining all elements, keep only the top k in a min-heap. The heap root is always the answer. This is the canonical approach for "kth largest in a stream" problems and generalizes to any top-k tracking scenario.

**Defensive copy** — `nums[:]` on line 12 avoids mutating the caller's list when `heapify` rearranges it in-place.

## Dependencies

**Imports**: `heapq` from the standard library — provides `heapify`, `heappush`, `heappop`.

**Imported by**: `kth-largest-element-in-a-stream/test_solution.py` directly. The massive "Imported By" list in the prompt is an artifact of the test harness — those test files all share a common import pattern, not a direct dependency on this solution.

## Flow

1. **Init**: `nums` → copy → `heapify` (O(n)) → pop down to size k (O((n-k) log n))
2. **Add**: push val (O(log k)) → conditional pop (O(log k)) → return root (O(1))

Total init cost: O(n log n) worst case. Each `add`: O(log k). Space: O(k).

## Invariants

- `len(self.heap) <= self.k` after every operation (init and add both enforce this).
- `self.heap[0]` is always the kth largest element across all values seen so far — guaranteed by the min-heap property combined with the size bound.
- The heap may have fewer than k elements only if fewer than k total values have been provided (initial `nums` had fewer than k elements and not enough `add` calls yet).

## Error Handling

None. The code trusts its inputs: `k >= 1`, `nums` is a valid list, and `add` is called with an integer. Calling `add` before k elements exist will still work — `self.heap[0]` returns the minimum of whatever's present, which is correct for the LeetCode contract (the problem guarantees at least k elements exist when `add` is called).

## Topics to Explore

- [file] `kth-largest-element-in-a-stream/test_solution.py` — See the test cases to understand edge cases like empty initial lists and streams shorter than k
- [file] `last-stone-weight/solution.py` — Another heap-based solution; compare how max-heap is simulated via negation vs. the min-heap used here
- [file] `take-gifts-from-the-richest-pile/solution.py` — Similar bounded-heap pattern applied to a different problem
- [general] `heapq-nlargest-comparison` — `heapq.nlargest(k, nums)` solves the static case in one call; understanding why a class with incremental `add` is needed here clarifies the stream vs. batch distinction

## Beliefs

- `heap-size-invariant` — After `__init__` and every `add` call, `len(self.heap) <= self.k` holds unconditionally
- `root-is-kth-largest` — `self.heap[0]` equals the kth largest element across all values ever provided (init + all add calls), assuming at least k values have been seen
- `add-is-log-k` — Each `add` call performs at most one push and one pop on a heap of size k, giving O(log k) time regardless of total stream length
- `no-mutation-of-input` — The constructor copies `nums` before heapifying, so the caller's list is never modified

