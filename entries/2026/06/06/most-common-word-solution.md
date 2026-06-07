# File: most-common-word/solution.py

**Date:** 2026-06-06
**Time:** 18:07

## `most-common-word/solution.py`

### Purpose

Solves [LeetCode 819: Most Common Word](https://leetcode.com/problems/most-common-word/). Given a paragraph string and a list of banned words, it finds the most frequently occurring word that isn't banned. This is a string-processing + frequency-counting problem.

### Key Components

**`Solution.mostCommonWord(paragraph, banned) -> str`** — The single method. Contract:
- **Input**: `paragraph` contains English letters, spaces, and `!?',;.`. `banned` is a list of lowercase strings.
- **Output**: The most frequent non-banned word, lowercased.
- **Assumes**: There is always at least one non-banned word present (per the problem guarantee). If that invariant is violated, `counts.most_common(1)[0][0]` raises `IndexError`.

### Patterns

The solution follows a **pipeline transformation** pattern common across this repo's solutions:

1. **Normalize** — `paragraph.lower()` flattens case.
2. **Tokenize** — `re.findall(r'[a-z]+', ...)` extracts word tokens, implicitly stripping all punctuation and spaces. This is more robust than splitting on whitespace because it handles adjacent punctuation like `"ball,"` → `"ball"`.
3. **Filter** — Generator expression excludes banned words using a set lookup.
4. **Aggregate** — `Counter` tallies frequencies; `most_common(1)` extracts the winner.

The `banned` list is converted to a `set` for O(1) membership testing — a standard idiom when you need repeated `in` checks against a fixed collection.

### Dependencies

- **Imports**: `re` (regex tokenization), `collections.Counter` (frequency counting).
- **Imported by**: `most-common-word/test_solution.py` directly. The massive "Imported By" list in the provided context is misleading — those are test files for *other* problems that likely share a common test harness importing from a shared path, not actual consumers of this solution's logic.

### Flow

```
paragraph string
  → .lower()                          # case-normalize
  → re.findall(r'[a-z]+', ...)       # tokenize into word list
  → filter out banned (via set)       # generator, lazy
  → Counter(...)                      # count frequencies
  → .most_common(1)[0][0]            # extract top word
```

Everything happens in four lines. The generator expression `(w for w in words if w not in banned_set)` is lazy — it doesn't materialize a filtered list, feeding tokens directly into `Counter`.

### Invariants

- The regex `[a-z]+` only matches after lowering, so the pattern never needs `re.IGNORECASE`.
- `banned` is assumed to already be lowercase (per the problem spec). If `banned` contained uppercase entries, they'd never match the lowered tokens — a silent logic bug, not a crash.
- There must be at least one non-banned word in the paragraph. No guard against an empty `Counter`.

### Error Handling

None. If the paragraph contains no valid non-banned words, `counts.most_common(1)` returns an empty list and `[0][0]` raises `IndexError`. This is acceptable for a LeetCode solution where the problem guarantees valid input.

## Topics to Explore

- [file] `most-common-word/test_solution.py` — See what edge cases are tested (empty banned list, single-character words, all-punctuation input)
- [function] `most-common-word/solution.py:mostCommonWord` — Compare regex tokenization vs. `str.split()` + `str.strip()` approaches for word extraction
- [general] `counter-most-common-pattern` — How `Counter.most_common` handles ties (preserves insertion order in Python 3.7+, which means first-encountered word wins)
- [file] `first-unique-character-in-a-string/solution.py` — Another frequency-counting problem; compare how Counter is used differently when seeking unique vs. most-common

## Beliefs

- `regex-strips-punctuation` — `re.findall(r'[a-z]+', ...)` on lowered input correctly tokenizes words separated by any mix of punctuation, spaces, or both, without needing an explicit character class for delimiters.
- `banned-set-lookup-is-o1` — Converting `banned` to a `set` ensures each membership check during counting is O(1) amortized, making the overall solution O(n) where n is the number of characters in the paragraph.
- `no-empty-input-guard` — The solution will raise `IndexError` if every word in the paragraph is banned or the paragraph contains no alphabetic characters; this is acceptable given LeetCode's input guarantees.
- `tie-breaking-is-insertion-order` — When multiple non-banned words share the highest frequency, `Counter.most_common(1)` returns whichever was encountered first during iteration (CPython 3.7+ dict ordering), though the problem guarantees a unique answer.

