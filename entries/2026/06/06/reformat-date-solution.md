# File: reformat-date/solution.py

**Date:** 2026-06-06
**Time:** 18:41

## `reformat-date/solution.py`

### Purpose

This file solves [LeetCode #1507: Reformat Date](https://leetcode.com/problems/reformat-date/). It converts a human-readable date string in `"Day Month Year"` format (e.g., `"20th Oct 2052"`) into the ISO-like `"YYYY-MM-DD"` format (e.g., `"2052-10-20"`). The file is self-contained: it holds both the solution class and its unit tests.

### Key Components

**`Solution.reformatDate(date: str) -> str`** — The core method. It:
1. Defines a `months` dict mapping 3-letter abbreviations to zero-padded month numbers.
2. Splits the input into three tokens: day (with ordinal suffix), month abbreviation, year.
3. Strips the ordinal suffix from the day using `rstrip("stndrdth")`.
4. Returns the formatted string with `zfill(2)` to ensure single-digit days get a leading zero.

**`TestReformatDate`** — Three test methods covering:
- `test_examples`: The three examples from the LeetCode problem statement.
- `test_ordinal_suffixes`: All four ordinal suffix types (`st`, `nd`, `rd`, `th`) including edge cases like `21st`, `22nd`, `23rd`, `31st`.
- `test_all_months`: Iterates all 12 months to verify correct month-number mapping.

### Patterns

- **Single-file solution+test**: Standard pattern in this repo — every problem directory bundles `solution.py` with an inline `unittest` suite and a separate `test_solution.py` that imports from it.
- **Dictionary lookup over parsing**: Uses a static dict for month mapping rather than `datetime.strptime`, keeping the solution self-contained and O(1).
- **`rstrip` for suffix removal**: A concise idiom — `rstrip("stndrdth")` strips any trailing characters from the set `{s, t, n, d, r, h}`. This works because no valid day digit (`0-9`) appears in that character set, so it cleanly removes `"st"`, `"nd"`, `"rd"`, or `"th"` without touching the numeric portion.

### Dependencies

**Imports**: Only `unittest` from the standard library — no external dependencies.

**Imported by**: The `test_solution.py` in the same directory imports `Solution` from this file. The large "Imported By" list in the prompt is misleading — those are *other* problems' test files, not actual importers of this module. They share the same structural pattern but don't reference this file's code.

### Flow

```
"20th Oct 2052"
  → split() → ["20th", "Oct", "2052"]
  → rstrip("stndrdth") on "20th" → "20"
  → months["Oct"] → "10"
  → f"{2052}-{10}-{20}" → "2052-10-20"
```

For single-digit days like `"6th"`: `rstrip` yields `"6"`, then `zfill(2)` pads to `"06"`.

### Invariants

- Input is guaranteed to be well-formed per the LeetCode constraint: always `"Day Month Year"` with a valid ordinal suffix and 3-letter month abbreviation.
- The `months` dict covers exactly the 12 valid month abbreviations. An unrecognized abbreviation would raise `KeyError`.
- `rstrip("stndrdth")` is safe only because day digits `0-9` are disjoint from the strip character set `{s,t,n,d,r,h}`.

### Error Handling

None. The solution trusts LeetCode's input guarantees. An invalid month abbreviation would propagate a `KeyError`; a completely non-numeric day string would produce garbage from `zfill` but not raise.

---

## Topics to Explore

- [file] `reformat-date/test_solution.py` — The external test file that imports `Solution`; may have additional edge cases beyond the inline tests
- [function] `reformat-date/solution.py:reformatDate` — Verify whether `rstrip("stndrdth")` could misfire on any valid day (it can't, but worth reasoning through for similar problems)
- [file] `day-of-the-week/solution.py` — Another date-manipulation problem in the repo; compare approaches to date parsing
- [general] `rstrip-vs-regex-suffix-removal` — `rstrip` strips a *set of characters*, not a substring — understanding why this works here (and where it wouldn't) is important for similar string-cleaning problems

---

## Beliefs

- `rstrip-suffix-safety` — `rstrip("stndrdth")` never removes day digits because no digit character appears in the strip set `{s,t,n,d,r,h}`
- `month-dict-completeness` — The `months` dictionary maps exactly the 12 three-letter English month abbreviations to zero-padded two-digit strings `"01"` through `"12"`
- `zfill-single-digit-padding` — `zfill(2)` is only needed for days 1–9; days 10–31 already have two characters after suffix stripping
- `no-stdlib-date-parsing` — The solution avoids `datetime` entirely, relying on manual string splitting and dictionary lookup

