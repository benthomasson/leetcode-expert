# File: relative-ranks/solution.py

**Date:** 2026-06-06
**Time:** 18:43

## `relative-ranks/solution.py`

### Purpose

This file solves [LeetCode 506 — Relative Ranks](https://leetcode.com/problems/relative-ranks/). Given a list of unique athlete scores, it returns a list of rank labels in the same positional order. The top three get medal names; everyone else gets their numeric rank as a string.

### Key Components

**`find_relative_ranks(score: list[int]) -> list[str]`** — The sole function. Contract:
- **Input**: A list of unique non-negative integers, each representing an athlete's score at that index.
- **Output**: A list of strings the same length as `score`, where each entry is the rank label for the athlete at that position.
- Medal labels: `"Gold Medal"` (1st), `"Silver Medal"` (2nd), `"Bronze Medal"` (3rd). All others: the 1-indexed rank as a string (`"4"`, `"5"`, ...).

### Patterns

**Argsort idiom**: `sorted(range(n), key=lambda i: score[i], reverse=True)` produces a permutation of indices ordered by descending score. This is Python's equivalent of NumPy's `argsort` — it avoids creating tuples of `(score, index)` and unpacking them later. The result `ranked[k]` answers "which original index has rank `k+1`?"

**Pre-allocated result array**: `result = [""] * n` is filled out of order via the index mapping, rather than building the result sequentially. This is the standard pattern when you need to write results back to original positions after sorting.

### Dependencies

- **Imports**: None. Pure stdlib, no external dependencies.
- **Imported by**: `relative-ranks/test_solution.py` directly. The "Imported By" list in the prompt is misleading — those are all unrelated test files that share a common test harness pattern importing from their own `solution.py`, not from this file.

### Flow

1. Compute `n = len(score)`.
2. Build `ranked`: a list of indices `[0, 1, ..., n-1]` sorted so that `score[ranked[0]]` is the largest, `score[ranked[1]]` is second largest, etc.
3. Allocate `result` of length `n`, all empty strings.
4. Iterate `place` (0-indexed rank) and `idx` (original position): assign the medal string or numeric rank string to `result[idx]`.
5. Return `result`.

Time complexity: O(n log n) from the sort. Space: O(n) for the `ranked` and `result` arrays.

### Invariants

- **Unique scores**: The problem guarantees all scores are distinct. If scores were duplicated, `sorted` would still produce a deterministic order (by original index due to Python's stable sort), but the rank assignment wouldn't handle ties — no tie-breaking logic exists.
- **Rank offset**: `place` is 0-indexed but ranks are 1-indexed, hence `str(place + 1)` for non-medal positions. The medal branches consume places 0, 1, 2 exactly.
- **Positional preservation**: The output list is the same length as the input and each index corresponds to the same athlete.

### Error Handling

None. The function assumes valid input per LeetCode constraints: `1 <= n <= 10^4`, all scores unique and non-negative. Empty list input would produce an empty result (the loop body never executes). No exceptions are raised or caught.

## Topics to Explore

- [file] `relative-ranks/test_solution.py` — See what edge cases the test suite covers (empty input, single element, large arrays)
- [file] `rank-transform-of-an-array/solution.py` — A closely related problem that handles non-unique values with dense ranking
- [function] `sort-the-people/solution.py:sort_the_people` — Another argsort-style solution; compare the index-mapping pattern
- [general] `argsort-vs-zip-sort` — When to use `sorted(range(n), key=...)` vs `sorted(zip(scores, indices))` and their tradeoffs

## Beliefs

- `relative-ranks-argsort-pattern` — `find_relative_ranks` uses the argsort idiom (`sorted(range(n), key=lambda i: score[i])`) to map ranks back to original positions without building intermediate tuples.
- `relative-ranks-no-tie-handling` — The function assumes all scores are unique; duplicate scores would receive arbitrary distinct ranks based on Python's stable sort order, with no explicit tie-breaking.
- `relative-ranks-time-complexity` — The function runs in O(n log n) time dominated by the sort, with O(n) auxiliary space.
- `relative-ranks-medal-threshold` — Exactly the first three places (0, 1, 2) receive medal strings; place 3 onward receives `str(place + 1)`.

