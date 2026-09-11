# Warrant

The obligation attaches to the **kind of claim**, not to how confident you feel.

| claim | what settles it | what does not |
|---|---|---|
| a number from a paper | the number at a locator: `citekey:table-3` | the abstract's summary of it |
| what a paper asserts | `authors-claim`, recorded as *the authors assert* | your agreement with it |
| that something replicates | two independent groups, disjoint author sets | one lab's follow-up to itself |
| a consensus | a survey or meta-analysis, **plus a search run against it** | five papers that cite each other |
| something you derived | its premises, each itself warranted | plausibility |
| your own unpublished data | `path:cell`, held to a published paper's bar | having run it yourself |

**A claim may not exceed its source's read depth.** `abstract` supports *they report X*;
`skim` adds *X holds*; `method` adds *their method shows why*; only `replicated` supports
*this generalises*.

**A read depth is your word until it is the source's.** `note --depth <d> --quote "<passage>"`
checks it verbatim; without one, the claim records that the session attested it.

**There is no terminal `assumed`.** `nullius needs "<what would settle it>"`, and dispose of
it before the unit closes.

**The counter-search is not optional on a consensus claim.** Searching until something agrees
with you is choosing the answer first.

**Cite so the next reader can re-check you.** An identifier that resolves, and a locator
inside the work.
