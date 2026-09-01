# Changelog

Versions follow [semantic versioning](https://semver.org). Until `1.0.0` the ledger format
and the CLI surface may change; when they do, the change is listed here with what it breaks.

## 0.1.0

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
