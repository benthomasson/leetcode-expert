# File: two-sum/solution.py

**Date:** 2026-06-06
**Time:** 15:08

## `two-sum/solution.py`

### Purpose

This file solves [LeetCode #1 — Two Sum](https://leetcode.com/problems/two-sum/): given an array of integers and a target sum, return the indices of the two numbers that add up to the target. It's the canonical entry point for the repo — LeetCode's most famous problem — and follows the same `solution.py` convention used by every other problem directory.

### Key Components

**`twoSum(nums, target) -> list[int]`** — The single exported function. Contract: given a list with exactly one valid pair, returns a two-element list `[i, j]` where `i < j` and `nums[i] + nums[j] == target`.

### Patterns

**Hash map complement lookup** — the textbook O(n) approach. Instead of brute-forcing all pairs (O(n²)), it maintains a dictionary `seen` mapping each previously-visited value to its index. For each new element, it computes `complement = target - num` and checks if that complement was already encountered. This is a single-pass algorithm — it never revisits elements.

The dictionary key is the *value*, not the index. This is the standard idiom for "have I seen this value before, and if so, where?"

### Dependencies

**Imports**: None — pure stdlib Python, no external dependencies.

**Imported by**: Hundreds of `test_solution.py` files across the repo import from their own problem directories (not from this file). The `two-sum/test_solution.py` file is the direct consumer. The "Imported By" list in the prompt appears to be the full test suite of the repo, not specific importers of this module — each test file imports its own `solution.py`.

### Flow

1. Initialize empty dict `seen`.
2. Iterate through `nums` with index `i` and value `num`.
3. Compute `complement = target - num`.
4. If `complement` exists in `seen`, return `[seen[complement], i]` — the earlier index first, current index second.
5. Otherwise, store `seen[num] = i` for future lookups.
6. Implicit: if no pair exists, returns `None` (falls off the end). The problem guarantees exactly one solution, so this path is unreachable under valid input.

### Invariants

- **Earlier index first**: `seen[complement]` is always strictly less than `i` because values are only added to `seen` after they've been passed. This guarantees the returned list is ordered `[smaller_index, larger_index]`.
- **No self-pairing**: An element can't pair with itself (e.g., `target=6, nums=[3]`) because a value is looked up *before* it's inserted into `seen`. If `nums = [3, 3]` and `target = 6`, the second `3` finds the first `3` already in the map — correct behavior.
- **First valid pair wins**: If multiple valid pairs exist, it returns the one involving the earliest second index.

### Error Handling

None. The function assumes valid input per LeetCode's guarantee ("each input has exactly one solution"). No pair found → implicit `None` return. No type checking, no bounds validation. This is appropriate for a competitive programming solution.

## Topics to Explore

- [file] `two-sum/test_solution.py` — See what edge cases the test suite covers (duplicates, negatives, single-pair guarantees)
- [file] `two-sum/review.md` — The code review analysis for this solution, likely discusses time/space tradeoffs
- [file] `two-sum-iv-input-is-a-bst/solution.py` — Same core problem adapted to a BST structure; compare how the complement-lookup pattern changes with a tree
- [file] `two-sum-iii-data-structure-design/solution.py` — The streaming/design variant where add and find are separate operations
- [general] `hash-map-complement-pattern` — This single-pass complement lookup recurs across many problems (e.g., `contains-duplicate-ii`, `find-subarrays-with-equal-sum`)

## Beliefs

- `two-sum-single-pass-linear` — `twoSum` runs in O(n) time and O(n) space via a single-pass hash map, never iterating the array more than once
- `two-sum-index-ordering` — The returned indices are always in ascending order because values enter `seen` strictly before the current index
- `two-sum-no-self-pair` — An element cannot pair with itself; the lookup-before-insert order prevents `seen[num]` from matching the current index
- `two-sum-implicit-none-on-no-solution` — If no valid pair exists (violating the problem contract), the function silently returns `None` rather than raising

