# nullius

> **nullius in verba** — “take nobody's word for it.”
> The Royal Society's motto since 1660.

A harness for research work in [Claude Code](https://claude.com/claude-code). It turns the
unread paper, the unsearched literature and the unbounded critique into states a session
**cannot finish in**.

> [!NOTE]
> **Status: design settled, build starting. Nothing is installable yet.**
> The argument is in **[`why/why-nullius.pdf`](why/why-nullius.pdf)** — eight pages on what
> goes wrong, why better instructions do not fix it, and what a harness has to constrain
> instead. Read that first if you want to know whether this is for you.

---

## The problem

An AI assistant is a good research collaborator right up to the point where nothing can
check it. Then three things happen, and none of them is fixed by asking more firmly.

**It skims the literature and does not know it.** Four papers, one query, one afternoon,
written up as *“a review of the literature on X”*. The prose form hides it perfectly: one
query and forty look identical on the page. Worse, the search runs in *your* vocabulary
rather than the field's, so an entire literature can sit one synonym away and never appear.

**It cannot tell settled from proposed.** *“Attention improves long-range modelling”* and
*“method Y improves long-range modelling”* arrive in the same declarative mood at the same
confidence. One carries a decade of independent replication; the other carries one paper and
one benchmark. Build on the second believing it was the first and you find out late.

**Its critique has no floor.** Asked what is missing, it answers. Asked again, it answers
again — because *more* reads as *more rigorous*. One real proposal went from 12 pages to 24
across three runs, and the fourth still returned a list of what was missing.

## Why better instructions do not fix it

A rule that describes *how* to work has no truth value. Nothing can check it, so it competes
for attention with everything else in the context and loses whenever the task gets
interesting. A constraint on *what must hold* can be observed, costs nothing until it fires,
and leaves the approach entirely alone.

| process constraint · unenforceable | outcome constraint · enforceable |
| --- | --- |
| “survey the literature first” | a survey unit cannot close with `unscreened > 0` |
| “don't over-trust the paper” | a claim may not exceed its source's read depth |
| “distinguish settled from new” | `established` requires disjoint author sets |
| “cite accurately” | an unresolved identifier cannot reach the draft |
| “say what done means” | an acceptance question that is open right now |
| “don't pad it” | over budget, an addition must name what it costs |
| “know when to stop” | zero material findings is a verdict, not a shorter list |

## Research has no compiler

Software gets this for free: *it builds*, *the suite is green*, *the check went red to green*
are facts, observed rather than reported, and facts can block. Research has no equivalent, so
the whole design question is which questions here are **equally objective**. Seven are, and
every one is a lookup or a count:

| question | the check |
| --- | --- |
| Does this reference exist? | the identifier resolves, or it does not |
| Was it retracted or corrected? | retraction metadata on the record |
| Does the paper say this? | the quote is verbatim in the cached text, or it is not |
| Are these two sources independent? | author and institution sets: disjoint, or not |
| Does this claim's trail reach data? | walk the references back and see where it lands |
| Did you search the field's words? | distinct query vocabularies, with hit counts |
| Is a required section absent? | the venue's own list, walked |

Two of those are the cheapest real epistemics available and nobody builds them. **Source
independence is set arithmetic on author lists.** **Folklore is a citation trail that never
lands on evidence.** Both fall out of metadata already fetched to render a bibliography.

Everything else in the design is built on top of those seven. Nothing that cannot fail is
allowed to block — thresholds that were chosen rather than measured are reported, and marked
as chosen.

## Make it yours

The harness ships knowing nothing about your field. That is deliberate: a tool that
hard-coded one field's norms would be useless in every other field and quietly wrong in its
own. So the norms are files you write, and they are what make a critique *calibrated* rather
than idealised.

| file | what it holds |
| --- | --- |
| `field.md` | your subfield's norms — what a normal sample size is here, what a standard baseline is, which claims need what kind of evidence |
| `venues/<venue>.md` | required sections, page limit, what reviewers there actually ask for. Bootstrapped once from the real call or author guidelines |
| `program.md` | what you are actually working on, so a thread that does not trace to it gets flagged as the distraction it is |
| `threads/`, `papers/`, `claims.md`, `falsified.md` | the durable record — the half that survives a dead context window, and a dead semester |

A structural finding must cite a line in `venues/<venue>.md`, so the tool cannot invent a
requirement. And `falsified.md` costs a minute to write and is the only thing standing between
you and re-proposing, in June, the idea you buried in March.

## Install

Not yet — there is nothing to install. When there is, it will be two keys in
`.claude/settings.json` in whatever repo or directory your research lives in:

```jsonc
{
  "extraKnownMarketplaces": {
    "tanyelai": {
      "source": { "source": "github", "repo": "tanyelai/nullius", "ref": "stable" },
      "autoUpdate": true
    }
  },
  "enabledPlugins": { "nullius@tanyelai": true }
}
```

No install step, no dependency to manage: Claude Code fetches the plugin on open. The
literature spine talks to public APIs (OpenAlex, Crossref, Semantic Scholar, arXiv,
Unpaywall, Europe PMC) and needs no key, though most of them ask for an email so they can
rate-limit politely.

## Roadmap

| | | |
| --- | --- | --- |
| **P0** | the prose spine — invariants, project templates, the vocabulary | changes behaviour with zero code |
| **P1** | ledger and CLI — `start`, `accept`, `claim`, `falsify`, `status`, `doctor` | the budget starts biting |
| **P2** | the blocking gates — citation resolved, quote verbatim, read-depth cap, the completeness walk | hallucinated citations stop being possible |
| **P3** | the literature spine — the indexes, `lit`, `snowball`, `screen`, `trail`, `coverage` | the largest piece of real capability |
| **P4** | agents and the calibration engine — gap kinds, the trade requirement, the extension detector | the part most likely to be wrong on first contact |
| **P5** | public release — smoke tests, worked examples, a `stable` branch | when it has earned it |

## What this is not

- **Not a literature database.** It queries real indexes through their official APIs.
  Coverage is theirs, and it is uneven by field. The contribution is refusing to let you
  *not* look, not pretending the index is complete.
- **Not a substitute for reading.** The read-depth cap exists precisely because the tool
  cannot read for you. It can only refuse to let an abstract masquerade as a method section.
- **Not a calibrated judge.** The severity classes rank; they do not measure.
- **Not a way around a paywall.** Official APIs and legally open full text only.
- **Not an author.** It has no opinion about what you should study, and the parts that look
  like opinions are your own `field.md` read back to you.

## Prior art

The design is a port. Its predecessor is a harness the author built for software work, in
daily use, where the compiler does the blocking — six hooks on shell events, one ledger on
disk, and agents that get a clean context window. It replaced a 43,494-word instruction
collection with something that could actually fail. Everything here is the attempt to answer
one question honestly: *what plays the compiler's part when the work is research.*

## Contributing

Not open yet — the design is still cheap to change and the build has not started. If a claim
in [`why/why-nullius.pdf`](why/why-nullius.pdf) is wrong, that is a finding and an issue is
the right place for it. The tool this describes would refuse to let it stand without a
locator, and the document should be held to the same bar.

## License

[MIT](LICENSE).
