# File: longest-palindrome/solution.py

**Date:** 2026-06-06
**Time:** 17:27

## `longest-palindrome/solution.py`

### Purpose

Solves [LeetCode 409 — Longest Palindrome](https://leetcode.com/problems/longest-palindrome/). Given a string of mixed-case English letters, it computes the length of the longest palindrome you could build by rearranging the characters. This is a construction problem, not a substring search — you're picking letters from a bag, not finding a contiguous run.

### Key Components

**`longestPalindrome(s: str) -> int`** — The sole public function. It counts character frequencies, then greedily takes the largest even portion of each frequency. If any character has an odd count, one extra character can sit in the center of the palindrome.

### Flow

1. `Counter(s)` builds a frequency map in O(n).
2. The loop iterates over counts (not characters — the keys are irrelevant).
3. `count // 2 * 2` extracts the largest even number ≤ count. For count=5, that's 4. This is equivalent to `count - (count % 2)` but makes the "pairs of two" intent explicit.
4. `has_odd` is a boolean flag set once any count is odd — meaning at least one leftover character exists to place in the palindrome center.
5. `return length + has_odd` — `has_odd` is `True`/`False`, which Python treats as 1/0 in arithmetic. At most one center character contributes.

### Patterns

- **Greedy frequency counting**: A standard idiom for palindrome construction problems. Rather than trying permutations, you reason about what a palindrome structurally requires: mirrored pairs, plus an optional center.
- **Boolean-as-int arithmetic**: `length + has_odd` exploits Python's `bool` being a subclass of `int`. Concise but worth knowing if you're reading quickly.

### Dependencies

**Imports**: `collections.Counter` — the only dependency. No custom data structures or project-level imports.

**Imported by**: The `longest-palindrome/test_solution.py` file imports this function directly. The massive "Imported By" list in the prompt is an artifact of the repo's test infrastructure — those other test files don't actually import this solution; they share a common test harness pattern.

### Invariants

- The palindrome length is always ≤ `len(s)`. The greedy approach guarantees this: `count // 2 * 2 ≤ count` for every character, and `has_odd` adds at most 1.
- The center character bonus is applied at most once, regardless of how many characters have odd counts.
- Works for both lowercase and uppercase letters (no case normalization). `'A'` and `'a'` are treated as distinct characters, which matches the LeetCode problem spec.

### Error Handling

None. The function assumes valid input per LeetCode constraints: a non-empty string of English letters. No edge-case guards for empty strings (would return 0, which is correct anyway since `Counter("").values()` is empty and `has_odd` stays `False`).

### Complexity

- **Time**: O(n) for counting + O(k) for iterating unique characters, where k ≤ 52. Effectively O(n).
- **Space**: O(k) for the Counter. Bounded by alphabet size, so O(1) in practice.

## Topics to Explore

- [file] `longest-palindrome/test_solution.py` — See the test cases to understand edge cases (all same characters, all unique, single character)
- [file] `palindrome-permutation/solution.py` — A closely related problem: checking if *any* palindrome permutation exists, which is the boolean version of this same counting logic
- [function] `longest-palindrome/solution.py:longestPalindrome` — Compare against an alternative approach using a set to toggle odd-count characters instead of a Counter
- [file] `longest-palindrome/plan.md` — The planning document may capture alternative approaches considered before settling on this one
- [general] `greedy-frequency-counting` — This pattern recurs in problems like "reorganize string", "task scheduler", and "minimum deletions to make character frequencies unique"

## Beliefs

- `longest-palindrome-greedy-pairs` — `longestPalindrome` computes the result by summing the largest even portion of each character count, plus 1 if any character has an odd count
- `longest-palindrome-center-at-most-one` — The center bonus (`has_odd`) is added at most once regardless of how many characters have odd frequencies
- `longest-palindrome-case-sensitive` — Uppercase and lowercase letters are treated as distinct characters; `'A'` and `'a'` do not combine into pairs
- `longest-palindrome-linear-time` — The algorithm runs in O(n) time and O(1) space (bounded by alphabet size of 52)

