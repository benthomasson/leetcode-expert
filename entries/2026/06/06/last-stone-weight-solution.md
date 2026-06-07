# File: last-stone-weight/solution.py

**Date:** 2026-06-06
**Time:** 17:19

## `last-stone-weight/solution.py`

### Purpose

This file solves [LeetCode 1046 — Last Stone Weight](https://leetcode.com/problems/last-stone-weight/). It simulates the stone-smashing game: each round, take the two heaviest stones and smash them together. If they differ in weight, the remainder goes back. Repeat until at most one stone remains.

### Key Components

**`Solution.lastStoneWeight(stones: List[int]) -> int`** — The single entry point. Takes a list of positive integer weights, returns the weight of the last surviving stone (or 0 if all stones cancel out).

### Patterns

**Max-heap via negation.** Python's `heapq` is a min-heap. The standard idiom to get max-heap behavior is to negate every value on the way in and negate again on the way out. Lines 14-15 build the negated heap; lines 18-19 pop the two largest by negating the popped values; line 21 pushes the remainder back as a negative.

**Heapify-then-loop.** `heapq.heapify(heap)` runs in O(n), giving a cheaper initialization than n individual pushes (which would be O(n log n)). The loop then does at most n-1 iterations, each with O(log n) push/pop, so overall complexity is O(n log n).

### Dependencies

**Imports:** `heapq` (stdlib heap operations), `typing.List` (type annotation).

**Imported by:** `last-stone-weight/test_solution.py` directly. The massive "Imported By" list in the prompt is an artifact of the repo's test harness sharing a common import pattern — those other test files don't actually call this solution.

### Flow

1. Negate all stone weights and build a min-heap (effectively a max-heap of the original values).
2. While two or more stones remain:
   - Pop the two largest (`y >= x` by heap ordering — `y` comes out first because its negation is smaller).
   - If they differ, push `y - x` back (negated).
   - If they're equal, both are destroyed (nothing pushed).
3. Return the remaining stone's weight, or 0 if the heap is empty.

### Invariants

- **`y >= x` always holds** after the two pops, because the heap pops the smallest negated value first, which corresponds to the largest original value.
- **Heap contents are always negative** (or zero, though zero-weight stones don't arise from the problem constraints). The negation is applied symmetrically on insert and extract.
- **The loop terminates** because each iteration removes at least one element from the heap (two popped, at most one pushed back).

### Error Handling

None. The function trusts that `stones` is a non-empty list of positive integers, matching the LeetCode contract. An empty input would return 0 via the `else` branch on line 23, which is technically beyond the problem's stated constraints (1 <= stones.length).

---

## Topics to Explore

- [file] `last-stone-weight/test_solution.py` — See what edge cases the test suite covers (single stone, two equal stones, all equal, etc.)
- [file] `take-gifts-from-the-richest-pile/solution.py` — Another heap-based simulation problem; compare the pattern
- [file] `kth-largest-element-in-a-stream/solution.py` — Uses `heapq` differently (min-heap of size k, no negation trick)
- [general] `python-heapq-negation-idiom` — Why Python lacks a max-heap and what alternatives exist (e.g., `heapq.nlargest`, wrapper classes)
- [file] `last-stone-weight/plan.md` — The planning document may describe alternative approaches considered (sorting each round, etc.)

## Beliefs

- `last-stone-weight-max-heap-via-negation` — The solution simulates a max-heap by negating all values before inserting into Python's min-heap, and negating again on extraction.
- `last-stone-weight-time-complexity` — Overall time complexity is O(n log n): O(n) heapify plus up to n-1 iterations each doing O(log n) heap operations.
- `last-stone-weight-loop-removes-at-least-one` — Each loop iteration pops two elements and pushes back at most one, guaranteeing termination in at most n-1 iterations.
- `last-stone-weight-empty-heap-returns-zero` — When all stones cancel out and the heap is empty, the function returns 0 rather than raising an error.

