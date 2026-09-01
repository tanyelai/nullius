# nullius

> **nullius in verba.** “Take nobody's word for it.”
> The Royal Society's motto since 1660.

A harness for research work in [Claude Code](https://claude.com/claude-code). It turns the
unread paper, the unsearched literature and the unbounded critique into states a session
**cannot finish in**.

> [!NOTE]
> **Status: installable, and incomplete.** The ledger, the gates and citation
> resolution work and are covered by [`tests/smoke.sh`](tests/smoke.sh). Snowballing,
> the venue completeness walk and the review agents' calibration engine are not built
> yet. See [Roadmap](#roadmap).
>
> The argument is in **[WHY.md](WHY.md)**: what goes wrong, why better instructions do
> not fix it, and what a harness has to constrain instead. Read that first if you want
> to know whether this is for you.

---

## Install

Three lines, none of them in a terminal. Open Claude Code in the folder your research lives
in and type:

```
/plugin marketplace add tanyelai/nullius
/plugin install nullius@tanyelai
```

Restart Claude Code, then say, in plain words:

> set up nullius in this folder

That is the whole installation. Claude runs `nullius init`, which creates a `.nullius/`
folder for your notes, references and claims, and tells you what to fill in. Nothing else
is installed, no account is created, and nothing leaves your machine except the searches
you ask for.

<details>
<summary>If the slash commands are not available, or you prefer doing it by hand</summary>

Create `.claude/settings.json` in your research folder with exactly this:

```json
{
  "extraKnownMarketplaces": {
    "tanyelai": {
      "source": { "source": "github", "repo": "tanyelai/nullius", "ref": "main" },
      "autoUpdate": true
    }
  },
  "enabledPlugins": { "nullius@tanyelai": true }
}
```

Restart Claude Code and ask it to set up nullius in the folder, as above.
</details>

**Requirements:** Claude Code, and Python 3.8 or newer, which macOS and every Linux
already have. There is nothing to `pip install`. If you want the tool to be able to read
PDFs it finds, install [poppler](https://poppler.freedesktop.org/) as well; without it you
get links to the papers instead of their text, and everything else works the same.

**Give it an email.** Not a login, and it grants no access to anything paywalled, and no
account is created anywhere. It does two measurable things: **Unpaywall refuses a request
without one** (HTTP 422), and that is the entire route to preprint copies of paywalled work;
and OpenAlex and Crossref use it to put you in their polite pool rather than the common one.

```bash
./.nullius/bin/nullius config contact you@university.edu
```

`contact` is written to `~/.config/nullius/config.json`, outside every repository, so it
cannot reach a commit. Anything else set with `--user` goes there too; everything without it
lands in the project's own `.nullius/config.json`, which is meant to be committed.

## First five minutes

```bash
./.nullius/bin/nullius start intro-rewrite write "sharpen the framing" \
    --venue MICCAI --words 800 --artifact paper/intro.tex
./.nullius/bin/nullius accept "does the intro state what the method cannot do"

./.nullius/bin/nullius cite 10.1016/j.media.2017.07.005   # resolves, or refuses
./.nullius/bin/nullius note litjens2017 --depth abstract
./.nullius/bin/nullius claim "deep learning dominates the field" \
    --warrant authors-claim --status single-result --strength reports \
    --source litjens2017
```

That last command is the shape of the whole tool. Ask for `--strength mechanism` on a
source you only read to `abstract` and it refuses; ask for `--status established` on two
papers that share an author and it refuses, because independence is set arithmetic on
author lists rather than a judgement. Write `\\cite{somethingUnresolved}` into the draft
and the write itself is refused.

When you try to finish, `nullius status` says why the gate is holding, and which of its
reasons are facts and which are thresholds somebody chose.

## Every command

Run them as `./.nullius/bin/nullius <command>`, or just ask Claude, since the session already
knows the vocabulary, because the gate that fires at startup carries it.

| | |
|---|---|
| `init` | scaffold .nullius/ here |
| `config` | read or set a config key |
| `start` | open a work unit |
| `accept` | declare what would close this unit |
| `close` | answer the acceptance question |
| `trade` | price an addition made over budget |
| `artifact` | track a draft against this unit |
| `cite` | resolve an identifier, or record a source no index |
| `fulltext` | find a legal full text, and cache it |
| `quote` | check a quote verbatim against cached text |
| `note` | open a paper note at a read depth |
| `claim` | record a claim with its warrant and status |
| `thread` | open or list a research thread |
| `falsify` | record an idea that died, and why |
| `lit` | search the indexes and log the protocol |
| `screen` | include or exclude retrieved works |
| `coverage` | the counts, and what is unscreened |
| `check` | run the write guards over a draft |
| `status` | why the stop gate is refusing |
| `done` | close the unit |
| `doctor` | is this project still set up correctly |

`--help` on any of them spells out its flags.

## The problem

An AI assistant is a good research collaborator right up to the point where nothing can check
it. After that the failures are quiet, and there are more of them than any short list
suggests. [WHY.md](WHY.md) maps them by stage of work: opening an idea, circling one you
already have, literature, deciding what is actually known, interpreting results,
understanding, writing and critique. Roughly thirty distinct ways to be wrong, and that list
is not closed either.

A sample, one from each end of the process:

- **Novelty by silence.** *"I could not find anything like this"* reads as a green light. It
  almost always means the terms were wrong.
- **Echo mistaken for corroboration.** Five sources, one lab, citing each other.
- **Folklore.** Everyone says it. Follow the citations and the trail never reaches data.
- **Your own pilot, over-read.** n=8 gets described as "demonstrates", and the assistant
  agrees with you.
- **Hedging collapse.** *"may suggest"* in the literature review becomes *"shows"* in the
  discussion, with no new evidence in between.

Four of them cost the most, and most of this repository is about those.

**It skims the literature and does not know it.** Four papers, one query, one afternoon,
written up as *"a review of the literature on X"*. The prose form hides it perfectly: one
query and forty look identical on the page. Worse, the search runs in *your* vocabulary
rather than the field's, so an entire literature can sit one synonym away and never appear.

**It trusts a paper the way the paper describes itself.** An abstract is a marketing
document. What a study *shows* is in its tables, and the gap between the two is where most of
the interesting reading happens.

**It cannot tell settled from proposed.** *"Attention improves long-range modelling"* and
*"method Y improves long-range modelling"* arrive in the same declarative mood at the same
confidence. One carries a decade of independent replication; the other carries one paper and
one benchmark. Build on the second believing it was the first and you find out late.

**Its critique has no floor.** Asked what is missing, it answers. Asked again, it answers
again, because *more* reads as *more rigorous*. One real proposal went from 12 pages to 24
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
allowed to block. Thresholds that were chosen rather than measured are reported, and marked
as chosen.

## Make it yours

The harness ships knowing nothing about your field. That is deliberate: a tool that
hard-coded one field's norms would be useless in every other field and quietly wrong in its
own. So the norms are files you write, and they are what make a critique *calibrated* rather
than idealised.

| file | what it holds |
| --- | --- |
| `field.md` | your subfield's norms: what a normal sample size is here, what a standard baseline is, which claims need what kind of evidence |
| `venues/<venue>.md` | required sections, page limit, what reviewers there actually ask for. Bootstrapped once from the real call or author guidelines |
| `program.md` | what you are actually working on, so a thread that does not trace to it gets flagged as the distraction it is |
| `threads/`, `papers/`, `claims.jsonl`, `falsified.md` | the durable record: the half that survives a dead context window, and a dead semester |

A structural finding must cite a line in `venues/<venue>.md`, so the tool cannot invent a
requirement. And `falsified.md` costs a minute to write and is the only thing standing between
you and re-proposing, in June, the idea you buried in March.

## Getting the paper

The route does not matter; reaching it does. `nullius fulltext <citekey>` walks the legal
ones in the order most likely to yield machine-readable text, and tells you what it found:

1. **a preprint copy**, since most paywalled work in these fields has one, and Unpaywall's
   repository locations are where it usually turns up. A DOI-only citation gets its arXiv id
   filled in here.
2. **Europe PMC** full text, for anything with a PMC id, which is strong coverage in biomedical.
3. **Unpaywall** OA locations, filtered: an index's "best OA location" is sometimes the
   graphical abstract, and an image is not a copy of the paper.
4. **`pdftotext`**, if the machine happens to have poppler. Nothing requires it; without it
   you get the URLs instead.
5. the publisher, your institution's proxy, the author's own copy, interlibrary loan.

Once text is cached, `nullius quote <citekey> "<text>"` checks a quotation against it. Until
then the note stays at `abstract` depth, which caps what may be claimed from it. That is
the honest state rather than a failure.

**Not Sci-Hub.** It is a copyright infringement service in most jurisdictions and has lost
the cases; wiring it into a research-integrity tool would be an odd place to start. The
routes above find a legal copy of most things, and where they do not, an email to the
author works more often than people expect.

## Ranking, and its confound

`nullius lit` ranks by **citations per year**, not raw citations. Raw counts put a 2015 paper
above a 2026 one that matters more, and a literature search is about what to read next.

Work too recent to have accrued citations is shown in its own band rather than buried: it
has not failed to be cited, it has not had the chance. Everything else with no citations
sorts last, and one recorded rule clears it:

```bash
nullius screen <search-id> exclude "no citations yet, deprioritised" --below-citations 1
```

That is an exclusion criterion applied uniformly and written into the search log, which is
both less work than forty judgements and more reproducible than them: the next reader sees
the rule and can disagree with it in one place.

## Roadmap

| | | |
| --- | --- | --- |
| **P0** | invariants, templates, the vocabulary | **done** |
| **P1** | ledger and CLI: `start`, `accept`, `claim`, `note`, `falsify`, `status`, `doctor` | **done** |
| **P2** | the blocking gates: citation resolved, not retracted, read-depth cap, independence cap, untraded overrun | **done**, and pinned by tests |
| **P3** | the literature spine: multi-index search and ranking, Crossref, arXiv, Europe PMC, Unpaywall, preprint hunting, the verbatim quote check | **done**; snowballing and citation-context are open |
| **P4** | the gap kinds, the extension detector, and honouring an artifact's own scope boundary | the walk is **done**; the rest open |
| **P5** | a `stable` release branch, worked examples for two or three fields, public | open |

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

## Where this came from

Two tracks, run at the same time: a few thousand hours inside Claude Code as a founding AI
engineer, and an active research line alongside it.

The harness idea was sharpened on the engineering side first, for a plain reason. There the
feedback is fast and unforgiving: a rule that fails to hold shows up as a red build in
seconds, so the pattern *instructions lose under load* becomes visible quickly, and then
repeatedly, until it stops looking like a series of accidents.

Research has the same failures and hides them for much longer. A shallow search does not fail
loudly. It fails in a reviewer's comment six months later, or in a reinvention nobody ever
catches. Working in both is what made the shape recognisable, and the failures this tool
gates against are ones hit first-hand in reading, drafting and analysis rather than inferred
from engineering by analogy.

What the two do not share is a compiler, and that is the one real gap. Software gets *it
builds* for free. Research has no equivalent, so the question the whole design answers is
what plays that part instead. The answer is smaller than one would like, and where it is thin
[WHY.md](WHY.md) says so rather than rounding up.

What did work, in both places, was making a failure into a state the session **cannot finish
in**. That is the method, and everything here is one application of it.

## Design notes

[WHY.md](WHY.md) is the argument: what goes wrong, why instructions do not fix it, and
what a harness has to constrain instead.

[REFERENCES.md](REFERENCES.md) is where the design's own claims are sourced. Every mechanism
here answers a failure somebody has already characterised, and every identifier in that file
was resolved with `nullius cite` rather than written from memory, the same bar the tool
holds a draft to.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). The short version: a change to a gate needs a test
in `tests/smoke.sh` that fails without it, in **both** directions, because a gate that only ever
passes is not a gate. If a claim in WHY.md or REFERENCES.md is wrong, that is a finding and
an issue is the right place for it.

Versions are in [CHANGELOG.md](CHANGELOG.md).

## License

[MIT](LICENSE).
