# nullius

> **nullius in verba.** “Take nobody's word for it.”
> The Royal Society's motto since 1660.

A harness for research work in [Claude Code](https://claude.com/claude-code). It turns the
unread paper, the unsearched literature and the unbounded critique into states a session
**cannot finish in**.

> [!NOTE]
> **Status: installable, and everything on the roadmap is built.** 239 assertions in
> [`tests/smoke.sh`](tests/smoke.sh), offline and in both directions, plus seven
> end-to-end [scenarios](evals/) against live indexes. What remains is calibration, and
> [algorithms/](algorithms/) says where each mechanism is weakest, including that none of
> them has been evaluated against a control.
>
> The argument is in **[WHY.md](WHY.md)**: what goes wrong, why better instructions do
> not fix it, and what a harness has to constrain instead. Read that first if you want
> to know whether this is for you.

![Where nullius intervenes in a session: it tells you what is open at SessionStart and after
compaction, refuses a write to a draft that cites nothing resolvable, and refuses to end the
turn while a fact says otherwise. A fact blocks; a threshold somebody chose is reported
instead.](assets/gates.svg)

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
      "source": { "source": "github", "repo": "tanyelai/nullius", "ref": "stable" },
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
    --artifact paper/intro.tex
./.nullius/bin/nullius accept "does the intro state what the method cannot do"

./.nullius/bin/nullius cite 2005.11401              # resolves, or refuses
./.nullius/bin/nullius note lewis2020 --depth abstract
./.nullius/bin/nullius claim "retrieval helps on knowledge-heavy tasks" \
    --warrant authors-claim --status single-result --strength reports \
    --source lewis2020
```

![Two independent caps on a claim. How far the source was read caps what the claim may
assert: an abstract supports reports, a skim adds holds, the method section adds mechanism,
replication adds generalises. Separately, how many independent author sets stand behind it
caps how settled it may be called, and contested, established and textbook each need two.
](assets/claim-caps.svg)

Add `--venue <name>` once you have written `.nullius/venues/<name>.md` from the real call or
author guidelines. Until that file exists the tool will not require anything of the draft,
which is deliberate: it may not ask for what it cannot cite a line for.

That last command is the shape of the whole tool. Ask for `--strength mechanism` on a
source you only read to `abstract` and it refuses; ask for `--status established` on two
papers that share an author and it refuses, because independence is set arithmetic on
author lists rather than a judgement. Write `\\cite{somethingUnresolved}` into the draft
and the write itself is refused.

When you try to finish, `nullius status` says why the gate is holding, and which of its
reasons are facts and which are thresholds somebody chose.

## Every command

Run them as `./.nullius/bin/nullius <command>`, or just ask Claude, since the session already
knows the vocabulary: the gate that fires at startup carries it.

| | |
|---|---|
| `init` | scaffold .nullius/ here |
| `config` | read or set a config key |
| `start` | open a work unit |
| `accept` | declare what would close this unit |
| `close` | answer the acceptance question |
| `decisive` | the number that would change the conclusion |
| `reading` | what was actually observed |
| `finding` | one finding, with a referent and a locator |
| `findings` | what this unit has found so far |
| `resolve` | close a finding, with what changed |
| `verdict` | the recommendation this critique adds up to |
| `point` | a reviewer's point, and what you did about it |
| `kills` | the observation that would end this idea |
| `cost` | what this idea would take to run |
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
| `snowball` | walk the citation graph from what you kept |
| `screen` | include or exclude retrieved works |
| `walk` | every required section, present/thin/absent |
| `frontier` | close a walk by decision, with a reason |
| `scope` | what the draft itself rules out, and why |
| `section` | say what an absent required section is |
| `coverage` | the counts, and what is unscreened |
| `check` | run the write guards over a draft |
| `report` | what the ledger holds, for a person to read |
| `status` | why the stop gate is refusing |
| `done` | close the unit |
| `doctor` | is this project still set up correctly |
`--help` on any of them spells out its flags.

## The stopping rule a draft writes for itself

Review on a plan does not converge on its own. A competent critic can always name another
control, so without a written boundary each round adds scope and the study never starts.

The answer is not for the tool to decide what is out of scope. It is for **the draft to say
so, in the draft**, where a reviewer will see it:

```latex
\section{What this study does not do}
...
A human persuasion study & Established by others and cited. Attempted underpowered,
                           it would make the paper about the user study \\
Causal analysis on frontier models & Impossible without weights. The behavioural arm
                           runs there and the transfer inference is labelled conditional \\
```

`nullius scope` reads that section out of the tracked draft, from a markdown list, a table,
or a LaTeX `tabular`. A critique unit **cannot write a finding until the boundary has been
read**, and cannot close without it. That is the same guarantee the completeness walk gives:
enumeration, not judgement. No textual test can decide whether a suggestion falls under a
boundary row, so the tool refuses to guess and refuses to let you not look.

Two things keep the boundary from becoming a shield:

- **Every row has to say why.** A row that excludes something without a reason is a fact the
  gate refuses on. Out by decision, with the decision missing, is not a boundary.
- **The boundary itself can be attacked.** `nullius finding <severity> scope "<why this
  boundary is wrong>"` is admissible, and it is the only way back in. A design decision is
  reviewable; what is not reviewable is re-raising it round after round as though it had
  never been taken.

If a finding shares terms with a row, the tool says so and calls it a lead rather than a
verdict, because a wrong match here suppresses a legitimate finding, and that is the
direction of error worth being careful about.

## Closing the frontier

![How the walk chooses where to go and when to stop: the next hop is led by the works most of your own seeds agree on, tie-broken by nearness to their era rather than by citation count, and the walk stops when a hop is 60% already-seen, when the 400-work budget is spent, or when nothing new is left.](assets/walk.svg)

A query finds what shares your words. The citation graph finds what the field itself linked,
and it is the only thing a claim that the frontier is closed can rest on.

`nullius snowball` walks both directions from the works you **screened in**, not from what a
query returned: backward into what a seed cites, forward into what cites it.

```
nullius: walking from <the work you screened in>
  back: 61 in the graph, 5 retrieved  (capped)
  forward: 98 in the graph, 5 retrieved  (capped)
```

`--depth 2` walks again from whatever the first hop's seeds **agreed on**, rather than from
everything, because following what the field points at repeatedly is what going deeper means.

The payload is not the list. It is the multiplicity:

```
hop 1: 1 seed(s)     16 new, 0 already reached
hop 2: 4 seed(s)     60 new, 4 already reached, 6% of this hop was known

reached from more than one of 7 seeds, which no query would have told you:
  3/7 (43%)  2020   276  <the paper the field descends from>
  2/7 (29%)  1998   273  <its standard textbook>
```

A work several of your seeds point at is what the field agrees is behind them: the canon, or
the thing everyone is arguing with. A keyword query will not reliably surface it, because the
canon is often phrased in older words. And the "already reached" percentage is the saturation
signal: when a hop stops returning anything new, you have the literature. When it is 6%, you
do not, and no amount of confident prose changes that.

Everything retrieved lands in a search log like any other, carrying how it was reached
(`via back from ...`), and gets screened the same way. A `survey` unit cannot close while a
work you kept has never been walked, which turns *the frontier is closed* from a claim into a
count. A kept work the index does not carry cannot be walked at all, and that is reported
rather than skipped.

Where Semantic Scholar has parsed a citing paper's full text it also returns the sentence in
which the citation appears, and whether the citation was influential. Those are **sparse**:
present for some papers and not others, so the tool shows them when they exist and never
counts on them.

## When a draft is only getting longer

![Three refusals on a critique loop that would otherwise never close: an ask with no
terminating answer, a finding that cites none of the four admissible referents, and a draft
that grew for three turns with nothing that generates work closed. Fatal and material findings
still keep the loop open.](assets/critique.svg)

Growth is not the signal. A draft that grew while four material findings were fixed is a
draft being worked on. Growth **with nothing closed** is the other thing:

```
p.md: 3 turns, 4201 to 7001 words, and no finding that generates work closed in
that span. Growth is not the signal; growth with nothing closed is. If the last
real gap is shut, the answer is a verdict rather than another pass.
```

Length is sampled per artifact at the stop, and only when the measured state moves, so the
series counts turns rather than keystrokes. Alongside it runs a count of `fatal` and
`material` findings actually closed with `nullius resolve`, across every unit the project
has run. The detector compares the two over a window of three turns.

It is a **chosen threshold**, not a fact: three turns and a quarter of growth are numbers
somebody picked. So it reports to you and never ends a turn.

## Handing it to someone

![A real search reported as a funnel: 12,549 matched at OpenAlex, 74 retrieved through one
vocabulary of three, all 74 screened, 3 included, and the 71 discards attributed to two named
rules rather than seventy-one separate judgements.](assets/funnel.svg)

`nullius report` writes what the ledger holds as markdown a person reads: every claim with its
warrant, its status and what it may assert; every source with how far it was actually read; the
search as a funnel with the rules that did the discarding; what was dispositioned and what was
discharged; and what is still refusing the stop.

It is **markdown on purpose, and there is no typesetting here.** The venue owns the format, the
house style is yours, and a template shipped with a tool becomes a house style that is not
either. What the tool owns is the epistemic state, and that is the half a collaborator cannot
reconstruct from the draft. Feed the markdown to whatever build you already have.

The report closes on what it does not establish, which is most things: not coverage, not
quality, and not independence where a record carried no author identifiers.

## Three agents, and why they run blind

The plugin installs three subagents alongside the CLI. Each one starts in a **clean context**,
which is the feature rather than an implementation detail: a second opinion is worth something
only if it did not watch you form the first one.

| agent | what it does |
| --- | --- |
| `skeptic` | takes one claim through one lens and returns survives, dies, or the observation that would settle it |
| `librarian` | runs a search protocol and returns records: identifiers, counts, screening decisions. It is forbidden from summarising them |
| `referee` | reviews a draft as a reviewer at one named venue, against that venue's own written requirements |

Ask for them in plain words: *have the skeptic take apart c003*, or *get the referee to read
this against the venue file*.

Two of the prohibitions are load-bearing. The `skeptic` is never told whose claim it is, so a
claim from a famous lab and a claim from you get the same bar; a check that knows the answer
you are hoping for has already stopped being one. And the `librarian` may not summarise,
because a summary is exactly where a thin search stops looking thin: six shallow hits become a
confident paragraph about what the field thinks, and the thinness is no longer visible to
anybody, including you.

None of the three decides anything. They return findings, and what to do about a finding stays
yours.

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
| **P3** | the literature spine | **done**: multi-index search and ranking, Crossref, arXiv, Europe PMC, Unpaywall, preprint hunting, the verbatim quote check, and snowballing in both directions |
| **P4** | the calibration engine | **done**: the venue walk, the gap kinds, the permanent discharge of a `defensible` finding, the draft's own scope boundary, and the extension detector |
| **P5** | a `stable` release branch, worked examples, the mechanisms written down | **done** |

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

[WHY.md](WHY.md) is the argument: what goes wrong, why instructions do not fix it, and what a
harness has to constrain instead.

**[algorithms/](algorithms/) is the interesting half.** Every mechanism in this tool replaced
something that looked reasonable and did not work, and each entry carries the measurement that
killed the naive version: the query that matched 15,277 works against the one that matched 811,
the citation walk that offered a 1962 statistics paper as the canon of a field two decades
younger, the guard that called a document clean while every reference in it was unverified.
Written as schemas rather than prose where the mechanism has any structure, one file per stage,
and open at the end of each on where it is still weak. If one is wrong, the measurement is the
thing to attack.

[evals/](evals/) runs seven scenarios against live indexes: one per use case, each on a
different AI subject, plus the path where the index refuses to answer at all. It is not a
benchmark and seven runs are not calibration; it measures whether each path completes and
whether the gates fire on real material rather than only on the fixtures. Two defects came out
of the first pass, both recorded under `## Found by running this` in the scenario that found
them.

[examples/](examples/) has three worked fields: clinical machine learning, language model
evaluation, and quantitative social science. The `field.md` files are real and you
should argue with them; the venue files are skeletons, because a checklist invented for a real
conference would break the tool's own rule that it may not require what it cannot cite.

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
