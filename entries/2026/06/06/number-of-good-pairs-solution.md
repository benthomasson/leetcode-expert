# File: number-of-good-pairs/solution.py

**Date:** 2026-06-06
**Time:** 18:19

## Purpose

This file solves [LeetCode 1512 — Number of Good Pairs](https://leetcode.com/problems/number-of-good-pairs/). A "good pair" is defined as `(i, j)` where `i < j` and `nums[i] == nums[j]`. The file owns the algorithm implementation and exposes it via the standard `Solution` class that LeetCode and the project's test harness expect.

## Key Components

### `Solution.numIdenticalPairs(nums: List[int]) -> int`

The single method. It counts how many ordered pairs of equal elements exist in `nums`. Rather than brute-forcing all O(n^2) pairs, it uses a single-pass counting trick: for each element, the number of new good pairs it forms equals how many times that value has already been seen.

## Patterns

**Incremental combinatorics.** When the k-th occurrence of some value arrives, it can pair with each of the (k-1) previous occurrences. So you accumulate `seen[num]` into `count` *before* incrementing `seen[num]`. This avoids computing `C(n, 2)` after the fact and keeps everything in one pass.

**`defaultdict(int)` as a frequency map.** The zero-default lets the code skip existence checks — `seen[num]` is always valid, starting at 0.

**Standard LeetCode class shape.** A `Solution` class with a single public method matching the problem signature. Every solution in this repo follows this convention, which is why hundreds of test files can import it uniformly.

## Dependencies

**Imports:** `collections.defaultdict` (frequency tracking) and `typing.List` (type annotation). No project-internal dependencies.

**Imported by:** The companion `number-of-good-pairs/test_solution.py`. The massive "Imported By" list in the prompt is an artifact of the test harness structure — those other test files import their *own* `solution.py`, not this one.

## Flow

1. Initialize `count = 0` and an empty frequency map `seen`.
2. Iterate through `nums` once, left to right.
3. For each `num`: add `seen[num]` (number of prior occurrences) to `count`, then increment `seen[num]`.
4. Return `count`.

For input `[1, 2, 3, 1, 1, 3]`:
- `1`: seen=0, count=0, then seen[1]=1
- `2`: seen=0, count=0, then seen[2]=1
- `3`: seen=0, count=0, then seen[3]=1
- `1`: seen=1, count=1, then seen[1]=2
- `1`: seen=2, count=3, then seen[1]=3
- `3`: seen=1, count=4, then seen[3]=2

Result: 4.

## Invariants

- **O(n) time, O(n) space.** Single pass over `nums` with a hash map bounded by the number of distinct values.
- **Pair ordering is implicit.** Because we only count previously-seen elements, every counted pair satisfies `i < j` by construction — no explicit index comparison needed.
- **The sum `Σ seen[v]` across all iterations equals `Σ C(freq(v), 2)`.** The incremental approach is mathematically equivalent to the combinatorial formula but avoids a second pass.

## Error Handling

None. The method assumes valid input per LeetCode constraints (1 <= nums.length <= 100, 1 <= nums[i] <= 100). Empty lists would return 0 correctly since the loop body never executes.

## Topics to Explore

- [file] `number-of-good-pairs/test_solution.py` — See the test cases and edge cases exercised against this solution
- [file] `number-of-good-pairs/review.md` — The generated review may note alternative approaches (e.g., `Counter` + `C(n,2)`)
- [function] `number-of-equivalent-domino-pairs/solution.py:numEquivDominoPairs` — Same incremental-counting pattern applied to a canonicalized key
- [function] `count-equal-and-divisible-pairs-in-an-array/solution.py:countPairs` — A harder variant where pairs need an additional divisibility constraint
- [general] `incremental-pair-counting` — The `count += seen[x]; seen[x] += 1` idiom recurs across many pair-counting problems in this repo

## Beliefs

- `good-pairs-linear-time` — `numIdenticalPairs` runs in O(n) time via incremental counting, not O(n^2) brute force
- `good-pairs-implicit-ordering` — The `i < j` constraint is satisfied by construction (only counting previously-seen values), with no explicit index comparison
- `good-pairs-defaultdict-zero` — The solution relies on `defaultdict(int)` returning 0 for unseen keys, so no key-existence check is needed
- `good-pairs-equivalence-to-combination` — The single-pass `count += seen[num]` accumulation is mathematically equivalent to summing `C(freq, 2)` for each distinct value

