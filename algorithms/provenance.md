# Provenance

## A bare identifier is a citation

**Measured.** A note citing three works, each written as a bare `arXiv:` id or `doi.org` link
in running prose, no `\cite` anywhere. A guard keyed to `\cite`, `[@key]` and `@key` reported
it **clean**. That is not an unusual style.

**Why this form matters more, not less.** No bibliography file ever sees a bare identifier, so
nothing else in a normal workflow catches an invented one.

**Not a new idea, and the framing is borrowed.** Phantom References
([arXiv:2607.00738](https://arxiv.org/abs/2607.00738)) puts it better than we did: a citation is
*"a more auditable surface: a reference either resolves to a real source or it does not"*, and
it reports fabricated references surviving peer review at top venues. HalluCiteChecker
([arXiv:2604.26835](https://arxiv.org/abs/2604.26835)) is a standalone tool for the same check.
What is different here is only where the check sits: inside the write, before the text exists,
rather than as an audit afterwards.

## A name is a citation

**Measured.** A note attributing three works entirely by author name. Reported **clean** again,
by a guard that had just been taught about bare identifiers.

```
for name in attributed(text):                 # X et al. · X and Y report · X (2021)
    if fold(name) ∉ {fold(surname) : author in resolved_refs}:
        REFUSE
```

**Weak, measured on the same note.** A two-letter surname is missed, because the pattern needs
three characters to avoid firing on ordinary capitalised words. The failure mode is silence.

## Names must fold before they compare

**Measured, immediately after the above.** An index spelled a hyphenated surname with
**U+2010** and the draft used an ASCII hyphen. Visually identical, unequal as bytes, so a
correctly cited work was flagged as unsourced.

```
fold(name) = lowercase(strip_combining(NFKD(translate(name, dashes→'-', quotes→"'"))))
```

**Why this direction of error is the one to fear.** A false positive suppresses a legitimate
citation and teaches people to switch the guard off, and then the real findings arrive through
a channel nobody reads.

## Resolving an identifier

```
arxiv id → arXiv API → title
         → OpenAlex title match, REQUIRING |year − preprint year| ≤ 2
         → among survivors, most cited wins
         → no survivor: stay the preprint it is
```

**Measured.** Resolving one arXiv id by title returned a 2025 stub with the same title ahead of
the 2017 paper. Indexes carry duplicate and thin records under one title.

**Also measured.** A colon in a title returned HTTP 400 rather than the work, which is most
computer science titles. After that was handled by blacklisting a few characters, a title
ending in a question mark did the same. Whitelist, never blacklist. And one route is not a
route: when the structured filter refuses, fall back to the endpoint that parses nothing.

## Getting the text

```
locations ← unpaywall(doi) ∪ index oa_url          # filter out .jpg/.png: an index's
                                                    # "best OA location" was once a
                                                    # graphical abstract
arxiv_id  ← rec.arxiv or extract from locations
text      ← arxiv HTML | europepmc XML | pdftotext(any location) | NONE
```

**Measured.** A DOI-only Elsevier reference with no open text at the publisher. Unpaywall's
repository locations carried an arXiv id, its HTML rendering carried **35,305 words**, and the
verbatim quote gate could fire for the first time.

Where nothing legal has it, the note stays at `abstract` depth and the claim is capped. That is
a state, not a failure.

## What a claim may say

```
depth abstract   → "they report X"
      skim       → + "X holds"
      method     → + "their method shows why"
      replicated → + "this generalises"

status established | textbook  requires  |disjoint author sets| ≥ 2
```

*They report a 12% gain* and *the method gives a 12% gain* are different strings, and the ledger
holds the depth recorded before the claim existed. A script can decide it; *be appropriately
skeptical* cannot be decided by anything.

**Weak.** Where a record carries no author identifiers, independence falls back to names and two
spellings of one person read as two groups. The claim records that, because the arithmetic is
not clean there.
