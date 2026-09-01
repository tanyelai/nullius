---
name: nullius
description: Open or manage a nullius research unit. Use when starting a literature search, reading a paper into the ledger, recording a claim with its warrant and status, killing an idea, or checking why the stop gate is refusing. Fires on "start a unit", "search the literature", "cite this", "record this claim", "why can't I finish", "that idea is dead".
---

# nullius

*nullius in verba.* The harness constrains what the work must satisfy and never how you do
it. Facts block; thresholds that were chosen rather than measured are reported and marked as
chosen.

The binary is at `${CLAUDE_PLUGIN_ROOT}/bin/nullius`. In a project that has run
`nullius init`, everything below reads and writes `.nullius/`.

## The unit

Reading one paper needs no unit. Anything past that opens one, and the kind decides what
`accept` is allowed to be.

```bash
nullius start <slug> <kind> "<question>" [--venue V] [--words N] [--artifact PATH]
nullius accept "<a question that is open right now>"
nullius close  "<the answer, with a locator>"
nullius status        # why the stop gate is refusing
nullius done
```

`kind` is one of `read · survey · idea · explain · interpret · critique · write · referee`.

`accept` is the task's own red-to-green: **a question genuinely open right now that a named
observation would close.** Declare it before the work, while it can still be observed to be
open. `close` refuses an answer that carries no locator, because an answer only you can check
is an assertion about your own work.

What each kind's acceptance has to be:

| kind | accept is | refused if |
|---|---|---|
| `read` | the questions the paper was opened to answer, each with a locator | answerable from the abstract |
| `survey` | a screening count that closes | anything retrieved is unscreened |
| `idea` | the neighbour set dispositioned, the killing assumption named, the cost estimated | **no neighbour found** -- the search failed, the idea is not novel |
| `explain` | a prediction about a case the paper did not show you, checked against it | the "still don't understand" list is empty by default |
| `interpret` | the number that would change your conclusion, named **before** you look | named after |
| `critique` | the decision this critique must enable | it is "make it better" |
| `write` | a specific section-level change, inside the budget | it describes the draft as it already is |
| `referee` | a recommendation on the venue's own scale | findings with no recommendation |

## The ledger

```bash
nullius cite <doi|arxiv|title>            # resolves, or refuses. never invent one
nullius note <citekey> --depth <abstract|skim|method|replicated>
nullius claim "<text>" --warrant W --status S --strength X --source KEY [--locator L]
nullius falsify "<idea>" "<why it died>"
```

`--warrant` is what settles it: `measured · authors-claim · replicated · consensus · inferred
· mine-unpublished`. There is no `assumed`.

`--status` is how settled it is in the field: `folklore · single-result · emerging ·
contested · established · textbook`. `established` and `textbook` need two independent author
groups, computed from the resolved records rather than declared.

`--strength` is what the sentence asserts: `reports · holds · mechanism · generalises`, and
it is **capped by the read depth of every source**. Read to `abstract`, you may write *they
report X* and nothing more.

A claim that is `single-result`, `folklore` or `authors-claim` may not be written as a bare
assertion. Attribute and situate it.

## The literature

```bash
nullius lit "<query>" --vocabulary <name>       # logs the protocol, not just the hits
nullius screen <search-id> <index> <include|exclude> "<reason>"
nullius coverage                                 # the counts, and what is unscreened
```

Three vocabularies minimum on a survey: yours, the field's own terms taken from the first
hits, and one adjacent field that studies the same thing under another name. Silence is a
failed search, not novelty.

## The draft

```bash
nullius artifact <path>     # track a draft against this unit
nullius check <path>        # run the write guards now
nullius trade "<what gets cut>"   # price an addition made over budget
```

Over the budget, a real gap is still reported -- suppressing it is the opposite failure --
but the fix is a trade and it has to name what it costs. Under the budget with no grounded
gap left, the answer is `submit`, and producing more findings past that point is pressure
rather than rigour.

## The agents

`librarian` returns records and is forbidden from summarising them. `skeptic` attacks one
claim through one lens with a clean context and no idea who made it. `referee` reviews
against one named venue's own file and must return a recommendation.

## Setup

```bash
nullius init [--field NAME] [--email you@example.org]
nullius doctor
```

`.nullius/field.md` and `.nullius/venues/<venue>.md` are what make critique calibrated. The
plugin ships knowing nothing about any field on purpose.
