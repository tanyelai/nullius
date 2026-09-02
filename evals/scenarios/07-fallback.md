# 07 · When the index will not answer

**Subject.** Any. This scenario is about the tool, not a literature.

**Task.** Establish that a rate limit slows the work rather than stopping it, and that what
answered instead is recorded.

**The point.** OpenAlex is the only index here with `cites:` and `cited_by:` filters, so
without a graph fallback a refusal ends a walk rather than delaying it. And a set retrieved
through a different index is a **different set**: a claim about a literature made through
Crossref is not the claim made through OpenAlex, so the log has to say which answered.

`NULLIUS_FORCE_RATELIMIT=openalex` is the seam that makes this testable. A fallback nobody has
exercised is a fallback that fails when it is needed.

## A healthy run

1. `lit` with OpenAlex forced to refuse still returns works, through Crossref, arXiv and
   Europe PMC.
2. The output says openalex was unreachable and which index answered instead.
3. `snowball` with OpenAlex forced to refuse still walks, through Semantic Scholar, and every
   row carries `(semanticscholar)` in its provenance.
4. The search log records `indexes`, `unreachable` and per-index `matched` -- checked on the
   **walk's own** log, not only on `lit`'s, because those are two writers and only one of them
   was ever derived from what answered.
5. A healthy walk, in its own ledger, records `openalex` and an empty `unreachable`. A second
   walk from the same seed reaches nothing new and writes no log at all, so this leg needs a
   fresh ledger or it silently reads the forced run's log.

## Must not happen

- A silent substitution. If Crossref answered, the run says so.
- A walk reporting that the graph closed when the index refused.
- Rows from a fallback index indistinguishable from OpenAlex rows in the log.

## Must allow

- A seed with no DOI failing to walk under a rate limit, and saying that is why. Semantic
  Scholar is addressed by DOI, so a record without one has no fallback route.

## Failure signatures

- `lit` returning nothing at all when one index refuses.
- Provenance missing from the rows or the log.
- The fallback firing when OpenAlex is healthy.
