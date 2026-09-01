# Changelog

Versions follow [semantic versioning](https://semver.org). Until `1.0.0` the ledger format
and the CLI surface may change; when they do, the change is listed here with what it breaks.

## 0.1.0

### Found by reviewing the first cut

Seven defects, each fixed and pinned by a test:

- a citation-count rule swept away rows **no index reported a count for** — unknown is not
  zero, and the rows it dropped were exactly the preprints enrichment had missed
- a declared word budget with no tracked draft measured zero and reported *finishable*: a
  gate that looks like it is working and is not. It now refuses and names the omission
- `found` had come to mean *retrieved*, which destroyed the one number that makes a thin
  search undeniable. Index totals and retrieval are reported separately again
- a work with no publication year sank to the bottom of the ranking as though it had no
  impact, rather than being unrankable
- an index's "best open-access location" is sometimes the graphical abstract, and offering
  a JPEG as a route to the text is a lie
- OpenAlex reads `:` as a filter operator, so every title carrying a colon — most of them
  in this field — returned HTTP 400 instead of the work
- `threads/` was promised by the documentation and written by nothing. `nullius thread`
  exists now, and the session gate surfaces open ones

Also: the acceptance locator rule refused *"stated in the Methods section"* and *"§3.1"*,
which are locators; it now takes a named part of a paper and still refuses "yes it is". And
a status reached through author **names** rather than identifiers is flagged on the claim —
two spellings of one person read as two independent groups, which is weaker than the label
suggests.

First working version. Installable as a Claude Code plugin; nothing to install beyond
Python 3.

### Gates that refuse

- an unresolved or retracted citation cannot reach a draft — the write itself is refused
- a claim may not exceed the read depth recorded for its source
- `established` and `textbook` need two independent author groups, computed from author
  identifiers rather than declared
- a source kind the indexes do not carry caps how settled a claim it can support
- a survey unit cannot close on an unscreened result
- an over-budget addition must name what it costs
- the acceptance question must be declared, and closed with a locator

### Reported, and marked as chosen

Vocabulary breadth, single-source claims, thin source independence. These reach the person
through `systemMessage` and never end a turn — a number nobody measured does not get to
block work.

### The literature spine

- multi-index search across OpenAlex, arXiv and Europe PMC, merged and de-duplicated
- ranked by citations per year rather than raw citations, with work too new to have earned
  any shown in its own band
- bulk screening by a recorded rule, so an exclusion criterion is one line a reader can
  disagree with rather than forty judgements
- resolution by whichever index has the work: Crossref for authoritative metadata and
  retraction notices, OpenAlex for the author identifiers that make independence
  computable, arXiv for preprints
- sources no index carries — documentation, blogs, books, chapters, theses, datasets, talks
- `fulltext` walks the legal routes, finds preprint copies of paywalled work, and caches
  machine-readable text where one exists, which is what lets `quote` check a quotation
  verbatim

### Known limits

The severity classes are uncalibrated. The venue completeness walk, the gap kinds and the
extension detector are designed but not built. Snowballing is not implemented. Coverage is
whatever the public indexes have, and it is uneven by field.
