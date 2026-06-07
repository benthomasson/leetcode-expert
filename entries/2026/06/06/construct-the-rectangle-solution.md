# File: construct-the-rectangle/solution.py

**Date:** 2026-06-06
**Time:** 15:50

## Purpose

This file solves [LeetCode #492 — Construct the Rectangle](https://leetcode.com/problems/construct-the-rectangle/). Given an integer `area`, find dimensions `[L, W]` of a rectangle such that `L * W == area`, `L >= W`, and the difference `L - W` is minimized. It's a self-contained module: solution function + unit tests in one file.

## Key Components

### `constructRectangle(area: int) -> list[int]`

The sole public function. Contract:
- **Input**: integer `area` in range `[1, 10^7]`
- **Output**: `[L, W]` where `L >= W`, `L * W == area`, and `L - W` is minimized across all valid factor pairs
- **Pure function** — no side effects, no mutation

### `TestConstructRectangle`

Six test cases covering the key partitions: perfect squares (4, 1000000), primes (37), composites (12), edge case (1), and a larger composite (122122).

## Patterns

**Search downward from the square root.** The optimal width is the largest factor of `area` that is ≤ `sqrt(area)`. The code starts at `isqrt(area)` and decrements until it finds a divisor. This is the canonical approach — `math.isqrt` gives the integer square root (floor), and since we're searching for the largest factor ≤ sqrt, decrementing from there hits it first.

**Inline tests.** Solution and tests co-located in one file, runnable via `python solution.py`. Standard pattern across all ~500 problems in this repo.

## Dependencies

**Imports**: `math` (for `isqrt`) and `unittest` (test harness). No project-internal imports.

**Imported by**: The "Imported By" list is misleading — those 400+ test files don't actually import *this* file. They share the same structural pattern (each problem's `test_solution.py` imports its sibling `solution.py`). The `construct-the-rectangle/test_solution.py` is the only real consumer.

## Flow

1. Compute `w = isqrt(area)` — the largest integer whose square ≤ `area`.
2. While `area % w != 0`, decrement `w`. This walks down from sqrt until hitting a factor.
3. Return `[area // w, w]`. Since `w ≤ sqrt(area)`, `area // w ≥ sqrt(area)`, so `L ≥ W` is guaranteed.

**Worst case**: `area` is prime → the loop walks from `isqrt(area)` all the way down to 1. That's O(sqrt(area)) iterations, which for `area = 10^7` is ~3162 steps — trivial.

## Invariants

- `w` starts at `isqrt(area)` and only decreases, so `w ≤ sqrt(area)` always holds.
- The loop always terminates: `w = 1` is a universal divisor.
- The first factor found while decrementing from sqrt is the largest factor ≤ sqrt, which minimizes `L - W` among all factor pairs. No need to check other pairs.

## Error Handling

None — the function assumes valid input per the LeetCode constraint (`1 <= area <= 10^7`). No bounds checking, no exceptions. The `unittest` runner surfaces test failures.

## Topics to Explore

- [file] `construct-the-rectangle/test_solution.py` — Likely has additional edge-case tests beyond the inline ones
- [file] `construct-the-rectangle/plan.md` — Documents the reasoning behind the algorithm choice
- [function] `arranging-coins/solution.py:arrangeCoins` — Another problem using integer square root as the starting point for search
- [general] `isqrt-vs-sqrt` — Why `math.isqrt` is preferred over `int(math.sqrt(...))` for correctness with large integers (floating-point precision)

## Beliefs

- `search-starts-at-isqrt` — The width search begins at `math.isqrt(area)` and decrements, guaranteeing the first divisor found yields the minimum `L - W`.
- `loop-terminates-at-one` — The while loop always terminates because `w = 1` divides every positive integer.
- `l-geq-w-by-construction` — `L >= W` is enforced structurally: `w ≤ sqrt(area)` implies `area // w >= sqrt(area) >= w`.
- `worst-case-prime-input` — For prime `area`, the loop runs `isqrt(area) - 1` iterations and returns `[area, 1]`.

