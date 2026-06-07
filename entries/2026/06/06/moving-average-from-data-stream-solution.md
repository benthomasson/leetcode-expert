# File: moving-average-from-data-stream/solution.py

**Date:** 2026-06-06
**Time:** 18:09

## Purpose

This file solves [LeetCode 346 — Moving Average from Data Stream](https://leetcode.com/problems/moving-average-from-data-stream/). It implements a class that computes the moving average of the last `size` integers from a stream of values. It's a design problem — the core challenge is choosing the right data structure to make `next()` O(1).

## Key Components

### `MovingAverage`

A stateful stream processor. The constructor takes a window `size`; each call to `next(val)` ingests one integer and returns the average of the most recent `size` values (or fewer, if the stream hasn't produced that many yet).

**`__init__(self, size: int)`** — Initializes a bounded deque (`maxlen=size`) and a running sum accumulator `_sum`.

**`next(self, val: int) -> float`** — The only public method. Adds `val` to the stream, evicts the oldest value if the window is full, and returns the current average.

## Patterns

**Running sum with manual bookkeeping.** Rather than calling `sum(self._queue)` on every `next()` call (which would be O(k) where k is the window size), the code maintains `_sum` incrementally. When a value is about to be evicted (the deque is at capacity), it's subtracted from `_sum` before the new value is appended and added.

**Bounded deque as a circular buffer.** `deque(maxlen=size)` handles eviction automatically — `append` drops the leftmost element when full. But the code reads `self._queue[0]` *before* the append to subtract the evicted value from `_sum`, since after the append the old head is gone.

## Dependencies

**Imports:** `collections.deque` — the only dependency. No external packages.

**Imported by:** `moving-average-from-data-stream/test_solution.py` directly. The "Imported By" list in the prompt is misleadingly large — those are test files across the entire repo that share a common test harness, not files that import `MovingAverage`.

## Flow

1. Caller creates `MovingAverage(size=3)`.
2. Each `next(val)` call:
   - Checks if the deque is at capacity (`len == maxlen`).
   - If so, subtracts `_queue[0]` (the element about to be evicted) from `_sum`.
   - Appends `val` — if at capacity, deque auto-evicts the oldest.
   - Adds `val` to `_sum`.
   - Returns `_sum / len(_queue)`.

Example trace with `size=3`:
- `next(1)` → queue=[1], sum=1, avg=1.0
- `next(10)` → queue=[1,10], sum=11, avg=5.5
- `next(3)` → queue=[1,10,3], sum=14, avg≈4.667
- `next(5)` → evicts 1, queue=[10,3,5], sum=18, avg=6.0

## Invariants

- **`_sum` always equals `sum(self._queue)`** — maintained by subtracting evicted values and adding new ones.
- **`len(self._queue) >= 1` after any `next()` call** — division by zero is impossible because `next` always appends before dividing.
- **Window never exceeds `size`** — enforced by `deque(maxlen=size)`.

## Error Handling

None. The code trusts that `size > 0` and `val` is numeric. Passing `size=0` would cause a division-by-zero on the first `next()` call since `deque(maxlen=0)` silently drops every append, leaving `len` at 0. This matches LeetCode's constraints (`1 <= size <= 1000`).

## Topics to Explore

- [file] `moving-average-from-data-stream/test_solution.py` — Verify which edge cases are covered (size=1, negative values, large streams)
- [file] `moving-average-from-data-stream/plan.md` — See the original problem analysis and alternative approaches considered
- [general] `deque-maxlen-eviction` — How `deque(maxlen=N)` silently drops the opposite end on append, and the subtle timing of when `_queue[0]` must be read relative to the append
- [function] `diet-plan-performance/solution.py:dietPlanPerformance` — Another sliding window problem in this repo; compare the fixed-window-sum technique
- [file] `number-of-recent-calls/solution.py` — Uses a similar deque-based sliding window but with a time-based bound instead of count-based

## Beliefs

- `moving-avg-o1-next` — `MovingAverage.next()` runs in O(1) time and O(k) space where k is the window size, due to the running sum avoiding re-summation.
- `moving-avg-sum-invariant` — `self._sum == sum(self._queue)` holds after every `next()` call; if this invariant breaks, all subsequent averages are wrong.
- `moving-avg-eviction-order` — The subtraction of the evicted element must happen *before* `deque.append()` because `append` on a full `maxlen` deque silently discards `_queue[0]`.
- `moving-avg-no-size-validation` — `size=0` is not guarded against and would cause `ZeroDivisionError` on first `next()` call; the code relies on LeetCode's constraint that `size >= 1`.

