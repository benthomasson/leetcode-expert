# File: license-key-formatting/solution.py

**Date:** 2026-06-06
**Time:** 17:22

## `license-key-formatting/solution.py`

### Purpose

This file implements [LeetCode 482 - License Key Formatting](https://leetcode.com/problems/license-key-formatting/). It's a standalone solution module in a large repository of LeetCode solutions, each following the same directory structure (`solution.py`, `test_solution.py`, `plan.md`, `review.md`). Its single responsibility is exposing the `license_key_formatting` function.

### Key Components

**`license_key_formatting(s: str, k: int) -> str`** — the sole public function. Takes a license key string containing alphanumeric characters and dashes, plus a group size `k`, and returns a reformatted key where:

- All dashes are removed and letters uppercased
- Characters are grouped into blocks of exactly `k`, separated by dashes
- The first group may have fewer than `k` characters (the remainder)

### Flow

The algorithm is three steps:

1. **Normalize** (line 13): `s.replace("-", "").upper()` strips all dashes and uppercases in one pass, producing a clean alphanumeric string.
2. **Compute first group size** (line 14): `len(cleaned) % k` determines how many characters belong in the potentially-short first group. If `first == 0`, there is no short group — all groups are exactly `k`.
3. **Build groups** (lines 15–18): Conditionally appends the short first group, then iterates from offset `first` in steps of `k`, slicing exact-size groups. This loop correctly handles the `first == 0` case because `range(0, n, k)` starts at index 0.
4. **Join** (line 19): Dash-separates all groups.

### Patterns

- **Strip-then-partition**: rather than parsing the input format, the code destroys all structure first (`replace` + `upper`), then rebuilds it from scratch. This is the idiomatic approach for reformatting problems — avoids edge cases around existing group boundaries.
- **Remainder-first grouping**: computing `len % k` upfront and handling the short prefix separately, then iterating uniformly for the rest. This is the standard pattern for "all groups size k except possibly the first."

### Dependencies

**Imports**: None — pure Python, no standard library or third-party imports.

**Imported by**: The `test_solution.py` files listed in the "Imported By" section appear to be a cross-reference artifact from the tooling rather than actual imports of this function. The real consumer is `license-key-formatting/test_solution.py`.

### Invariants

- Every group except the first has exactly `k` characters.
- The first group has between 1 and `k` characters (inclusive), unless the input is empty.
- The output contains only uppercase alphanumeric characters and dashes.
- No leading or trailing dashes appear in the output (because `parts` is never padded with empty strings — `first == 0` skips the first append, and the loop produces no empty slices since `cleaned[i:i+k]` with `i < len(cleaned)` is always non-empty).
- If `cleaned` is empty (input was all dashes or empty), `parts` stays empty and the result is `""`.

### Error Handling

None. The function assumes valid inputs per the LeetCode contract: `s` contains only alphanumeric characters and dashes, and `k >= 1`. Passing `k=0` would cause a `ZeroDivisionError` on line 14 and an infinite loop in `range`. This is acceptable — LeetCode guarantees `1 <= k <= 10^4`.

## Topics to Explore

- [file] `license-key-formatting/test_solution.py` — See the test cases to understand edge cases (all dashes, single character, exact multiples of k)
- [file] `license-key-formatting/review.md` — Code review notes that may cover alternative approaches or performance observations
- [general] `strip-then-partition-pattern` — This normalize-then-rebuild approach recurs across string reformatting problems like reformat-phone-number and divide-a-string-into-groups-of-size-k
- [file] `divide-a-string-into-groups-of-size-k/solution.py` — Similar grouping logic but with a fill character for the last group instead of a short first group
- [file] `reformat-phone-number/solution.py` — Another string reformatting problem that strips then repartitions

## Beliefs

- `license-key-first-group-remainder` — The first group size equals `len(cleaned) % k`; all subsequent groups are exactly `k` characters
- `license-key-no-imports` — The solution uses no imports — it relies entirely on `str.replace`, `str.upper`, and slicing
- `license-key-empty-input-safe` — An input of all dashes (or empty string) produces an empty string without error, because the loop range is empty and `parts` stays `[]`
- `license-key-uppercase-guarantee` — The output never contains lowercase letters because `.upper()` is applied to the entire cleaned string before grouping

