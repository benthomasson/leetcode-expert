# File: take-gifts-from-the-richest-pile/solution.py

**Date:** 2026-06-06
**Time:** 19:26

## Purpose

This file solves [LeetCode 2558: Take Gifts From the Richest Pile](https://leetcode.com/problems/take-gifts-from-the-richest-pile/). It owns the single responsibility of simulating `k` rounds of a process where you repeatedly pick the largest pile, take most of its gifts (leaving behind the integer square root), and return the total remaining.

## Key Components

### `giftsRemaining(gifts, k) -> int`

The sole public function. Contract:

- **Input**: `gifts` — a list of non-negative integers representing pile sizes; `k` — number of rounds to simulate.
- **Output**: The sum of all piles after `k` rounds of reducing the largest pile to `floor(sqrt(max))`.
- **Side effects**: None on the input list (a separate heap is built internally).

## Patterns

**Max-heap via negation.** Python's `heapq` is a min-heap. The code negates all values (`-g`) to simulate max-heap behavior — a standard Python idiom. Every push/pop inverts the sign on the way in and out.

**In-place simulation.** Rather than sorting or scanning for the max each round, the heap gives O(log n) extraction and reinsertion per round, making the overall complexity O(n + k log n) instead of O(k * n).

## Dependencies

**Imports:**
- `heapq` — heap operations (`heapify`, `heappop`, `heappush`)
- `math` — `math.isqrt` for integer square root (exact floor, no float truncation issues)

**Imported by:** The corresponding `take-gifts-from-the-richest-pile/test_solution.py`. The long "Imported By" list in the prompt is an artifact of the test harness importing a shared fixture, not this solution file itself.

## Flow

1. **Build heap**: Negate every gift value and heapify in O(n).
2. **Simulate k rounds**: Each round pops the max (smallest negative), computes `isqrt`, pushes the negated result back.
3. **Sum**: Negate the sum of the heap to get the true total.

Concrete trace with `gifts=[25, 64, 9], k=1`:
- Heap after init: `[-64, -25, -9]`
- Round 1: pop `-64` → `max_val=64` → `isqrt(64)=8` → push `-8` → heap is `[-25, -8, -9]`
- Return `-(-25 + -8 + -9) = 42`

## Invariants

- All heap elements are non-positive (negated gift counts). The sign flip is applied symmetrically on every insert and every read.
- `math.isqrt` guarantees an exact integer floor — no floating-point rounding surprises that `int(math.sqrt(...))` can produce for large values.
- The function assumes `gifts` is non-empty and `k >= 0`. No explicit validation; LeetCode constraints guarantee this.

## Error Handling

None. The function trusts its inputs per LeetCode constraints. Passing an empty list would cause `heappop` to raise `IndexError`; passing negative gift values would produce incorrect results since `isqrt` rejects negatives with a `ValueError`.

---

## Topics to Explore

- [file] `take-gifts-from-the-richest-pile/test_solution.py` — See what edge cases the test suite covers (single-element, k larger than needed, all-equal piles)
- [function] `last-stone-weight/solution.py:lastStoneWeight` — Another max-heap-via-negation solution in this repo; compare the shared idiom
- [general] `isqrt-vs-sqrt` — Why `math.isqrt` is preferred over `int(math.sqrt(n))` for large integers (float precision loss near 2^53)
- [file] `take-gifts-from-the-richest-pile/plan.md` — The planning doc may capture alternative approaches considered (e.g., sorted list, early termination when max is 0 or 1)

## Beliefs

- `negated-max-heap-idiom` — All values in the heap are stored as their negation; the sign is flipped on every pop and push to emulate a max-heap with Python's min-heap.
- `isqrt-avoids-float-error` — `math.isqrt` is used instead of `int(math.sqrt(...))` to avoid incorrect results for large integers where float precision is insufficient.
- `time-complexity-k-log-n` — The algorithm runs in O(n + k log n): O(n) for heapify, then O(log n) per round for pop+push.
- `no-early-termination` — The loop always runs exactly `k` iterations even if the max pile is already 0 or 1, where the operation is a no-op.

