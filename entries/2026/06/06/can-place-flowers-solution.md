# File: can-place-flowers/solution.py

**Date:** 2026-06-06
**Time:** 15:31

## Can Place Flowers — Solution Explanation

### Purpose

This file implements the solution for [LeetCode 605: Can Place Flowers](https://leetcode.com/problems/can-place-flowers/). It's a standalone greedy algorithm that determines whether `n` new flowers can be planted in a flowerbed without violating the no-adjacent-flowers rule. Within the project, it's one of hundreds of problem solutions following a uniform `solution.py` convention.

### Key Components

**`canPlaceFlowers(flowerbed, n) -> bool`** — The sole public function. It takes a binary list (0 = empty, 1 = planted) and a count of flowers to place, returning whether placement is feasible.

The contract is straightforward: the function **mutates** `flowerbed` in place, marking planted spots with `1` as it goes. This is a side effect the caller must be aware of — if you need the original array preserved, copy it first.

### Patterns

**Greedy single-pass.** The algorithm scans left-to-right, greedily planting a flower at every valid position it encounters. This works because planting as early as possible never reduces future opportunities — an empty slot that's valid now can't become *more* valid later, and skipping it can only constrain what comes after.

**Early exit.** The `if n <= 0: return True` check at the top of the loop short-circuits once all flowers are placed, avoiding unnecessary iteration over the rest of the array.

**Boundary handling via disjunction.** The conditions `i == 0 or flowerbed[i - 1] == 0` and `i == len(flowerbed) - 1 or flowerbed[i + 1] == 0` treat array edges as implicitly empty — a flower at index 0 has no left neighbor to conflict with, and one at the last index has no right neighbor. This avoids sentinel padding.

### Dependencies

**Imports:** None. Pure Python with no external dependencies.

**Imported by:** The `can-place-flowers/test_solution.py` file directly. The "Imported By" list in the prompt is misleading — those are unrelated test files across the repo, likely an artifact of how the import graph was collected (probably all test files share a common test harness pattern, not that they import *this* solution).

### Flow

1. Iterate over each index `i` in `flowerbed`.
2. If `n` is already satisfied (`n <= 0`), return `True` immediately.
3. For each position, check three conditions conjunctively:
   - Current spot is empty (`flowerbed[i] == 0`)
   - Left neighbor is empty or doesn't exist (`i == 0 or flowerbed[i-1] == 0`)
   - Right neighbor is empty or doesn't exist (`i == len(flowerbed) - 1 or flowerbed[i+1] == 0`)
4. If all three hold, plant here: set `flowerbed[i] = 1` and decrement `n`.
5. After the loop, return `n <= 0`.

The mutation at step 4 is critical — it prevents the next iteration from planting at `i+1`, which would violate adjacency. Without it, you'd need to manually skip an index after each placement.

### Invariants

- **No two adjacent 1s.** The three-way guard guarantees that every planted flower has empty (or nonexistent) neighbors. Since the input is assumed valid (no pre-existing adjacency violations), the output preserves this invariant.
- **`n` can be zero.** Both the early exit and the final return handle `n == 0` (and even negative `n`) gracefully — they return `True`, meaning "zero flowers to plant" is trivially satisfiable.
- **Input is mutated.** The function writes to `flowerbed[i]`. This is intentional — it's the mechanism that prevents double-planting adjacent slots — but it means the caller loses the original state.

### Error Handling

There is none. The function assumes valid input: `flowerbed` is a non-empty list of 0s and 1s with no pre-existing adjacency violations, and `n` is a non-negative integer. Passing a negative `n`, an empty list, or a list with adjacent 1s won't raise an exception but may produce meaningless results.

### Complexity

- **Time:** O(n) where n is `len(flowerbed)` — single pass, constant work per element.
- **Space:** O(1) — modifies in place, no auxiliary storage.

---

## Topics to Explore

- [file] `can-place-flowers/test_solution.py` — See what edge cases the test suite covers (empty beds, full beds, n=0, single-element arrays)
- [file] `can-place-flowers/plan.md` — Understand the planning process and whether alternative approaches (e.g., counting maximal independent sets) were considered
- [file] `can-place-flowers/review.md` — Check if the mutation side effect was flagged during review
- [general] `greedy-correctness-proof` — Why greedy left-to-right placement is optimal here (exchange argument: swapping a later placement for an earlier one never worsens the outcome)
- [function] `assign-cookies/solution.py:findContentChildren` — Another greedy problem in this repo; compare the greedy strategy and how sorting vs. single-pass differs

---

## Beliefs

- `can-place-flowers-mutates-input` — `canPlaceFlowers` modifies the `flowerbed` list in place by setting planted positions to 1; callers who need the original must copy first
- `can-place-flowers-greedy-is-optimal` — Greedy left-to-right placement is provably optimal: planting at the earliest valid slot never reduces the number of remaining valid slots compared to any alternative placement
- `can-place-flowers-handles-n-zero` — Passing `n=0` returns `True` immediately (via the early-exit check or the final `n <= 0` return), correctly treating "plant nothing" as always feasible
- `can-place-flowers-boundary-as-empty` — Array boundaries are treated as empty plots: index 0 has no left constraint and the last index has no right constraint, handled by short-circuit `or` in the guard conditions

