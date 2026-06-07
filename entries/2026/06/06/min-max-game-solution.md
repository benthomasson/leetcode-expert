# File: min-max-game/solution.py

**Date:** 2026-06-06
**Time:** 17:50

## `min-max-game/solution.py`

### Purpose

This file solves [LeetCode 2293 — Min Max Game](https://leetcode.com/problems/min-max-game/). It simulates a tournament-style reduction of an array: pair up adjacent elements, alternately take the min or max of each pair, and repeat until one element remains.

### Key Components

**`min_steps(nums: List[int]) -> int`** — Despite the name suggesting "steps," this function returns the *last remaining value*, not a count. It takes an array whose length is a power of 2 and reduces it by half each round until a single element is left.

The pairing rule per round:
- Even-indexed pairs (`i % 2 == 0`): take `min(nums[2*i], nums[2*i+1])`
- Odd-indexed pairs (`i % 2 == 1`): take `max(nums[2*i], nums[2*i+1])`

### Patterns

**Iterative simulation** — Rather than using recursion or a mathematical shortcut, it directly simulates the game by building a new half-sized array each round. This is the most straightforward approach: O(n) total work across all rounds (n + n/2 + n/4 + ... = 2n), O(n) space for the working array.

**In-place reassignment** — `nums = new_nums` at the end of each iteration replaces the old array, letting the GC reclaim previous rounds. No mutation of the input.

### Dependencies

- **Imports**: `List` from `typing` (type annotation only).
- **Imported by**: `min-max-game/test_solution.py` — the test harness for this problem. The massive "Imported By" list in the prompt is an artifact of the repo's test infrastructure importing a shared test runner, not actual callers of `min_steps`.

### Flow

1. Enter the `while` loop — runs `log2(len(nums))` times.
2. Each iteration pairs elements `(nums[0], nums[1])`, `(nums[2], nums[3])`, etc.
3. For pair index `i`: apply `min` if `i` is even, `max` if `i` is odd.
4. Collect results into `new_nums`, reassign `nums`.
5. When `len(nums) == 1`, return `nums[0]`.

For `[1, 3, 5, 2, 4, 8, 2, 2]`:
- Round 1: `min(1,3)=1`, `max(5,2)=5`, `min(4,8)=4`, `max(2,2)=2` → `[1, 5, 4, 2]`
- Round 2: `min(1,5)=1`, `max(4,2)=4` → `[1, 4]`
- Round 3: `min(1,4)=1` → `[1]` → return `1`

### Invariants

- **Power-of-2 length**: The algorithm assumes `len(nums)` is a power of 2. If not, the final unpaired element would be silently dropped — no validation guards this.
- **Non-empty input**: If `nums` is empty, `nums[0]` on the return would raise `IndexError`.
- **Alternating min/max is index-based**: The min/max alternation resets each round (pair 0 is always `min`).

### Error Handling

None. The function trusts its caller to provide a valid power-of-2-length array. Invalid inputs produce silent wrong answers or index errors rather than descriptive exceptions. This is typical for LeetCode solutions where the problem guarantees valid input.

### Naming Note

The function is named `min_steps`, which is misleading — it returns the surviving *value*, not a step count. This likely came from a naming template applied across the repo and wasn't corrected for this problem.

## Topics to Explore

- [file] `min-max-game/test_solution.py` — Test cases revealing edge behavior (single-element input, all-equal arrays)
- [file] `min-max-game/plan.md` — The planning doc may explain why iterative simulation was chosen over recursion
- [function] `delete-greatest-value-in-each-row/solution.py:min_steps` — Another iterative-reduction problem to compare structural similarity
- [general] `tournament-reduction-patterns` — How other problems (e.g., segment trees, elimination games) use the same halving structure
- [file] `min-max-game/review.md` — May flag the naming issue or discuss alternative approaches

## Beliefs

- `min-max-game-returns-value-not-count` — `min_steps` returns the last surviving element, not the number of reduction rounds
- `min-max-alternation-resets-per-round` — Pair index `i` resets to 0 each round, so the first pair always uses `min`
- `min-max-game-linear-total-work` — Total comparisons across all rounds is O(n) due to geometric halving (n/2 + n/4 + ...)
- `min-max-game-no-input-validation` — The function does not verify that `len(nums)` is a power of 2 or that the list is non-empty

