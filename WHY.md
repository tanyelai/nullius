# Why nullius exists

> **nullius in verba** — “take nobody's word for it.”
> The Royal Society's motto since 1660.

This is the argument, not the manual. It says what an AI assistant does wrong in research
work by default, why writing better instructions does not fix it, and what a harness has to
constrain instead.

The short version: **research has no compiler**, so the design problem is finding what plays
that part. Four things do. Everything else is built on top of them, and nothing that cannot
fail is allowed to block.

---

## 1 · The motto is the specification

Names are usually labels. This one is a specification. *Nullius in verba* was adopted by the
Royal Society in 1660 as a refusal to settle questions by citing authority, and every
constraint in this harness turns out to be that sentence pointed at a different narrator.

| do not take | the mechanism |
| --- | --- |
| the author's word | an `authors-claim` may never be written as a bare assertion |
| the abstract's word | warrant is capped by how deeply you actually read |
| the field's word | `established` is computed from author-set overlap, never declared |
| the repeated word | folklore is a citation trail that never reaches data |
| your own word | your unpublished data is held to a published paper's bar |
| the reviewer's word | a `defensible` finding closes with one sentence, permanently |

The last row is the one people are surprised by, and it is the reason this is a harness
rather than a critic. Taking nobody's word for it cuts both ways: an unexamined objection is
no better than an unexamined claim, and a tool that can always find one more thing wrong has
stopped providing evidence and started providing pressure.

## 2 · What goes wrong by default

None of this is the model being lazy. Each is a place where nothing in the loop *could*
fail, so the default filled the gap.

**It skims the literature and does not know it.** Four papers, one query, one afternoon,
written up as *“a review of the literature on X”*. The prose form hides it perfectly: one
query and forty look identical on the page. Worse, the search runs in *your* vocabulary
rather than the field's, so an entire literature can sit one synonym away and never appear.

**It trusts a paper the way the paper describes itself.** An abstract is a marketing
document. What a study *shows* is in its tables, and the gap between the two is where most of
the interesting reading happens. By default that gap is collapsed: the claimed contribution
and the evidenced contribution arrive as one sentence.

**It cannot tell settled from proposed.** This is the expensive one. *“Attention improves
long-range modelling”* and *“method Y improves long-range modelling”* come out in the same
declarative mood at the same confidence. One carries a decade of independent replication; the
other carries one paper and one benchmark. Build three chapters on the second believing it
was the first, and you find out late.

**Its critique has no floor.** Asked what is missing, it answers. Asked again, it answers
again — *more* reads as *more rigorous*, so a finished draft becomes an infinite project, and
a page limit that was never declared cannot object. One real proposal went from 12 pages to
24 across three runs, and the fourth still returned a list.

> **The asymmetry that makes this hard.** Suppress *“what is missing”* and a genuinely
> absent control section goes unmentioned. Leave it unbounded and the draft doubles and is
> still called incomplete. A single rule cannot serve both, which is why the two have to stop
> being one axis.

## 3 · Why more instructions do not fix it

The instinct is to write the rule more firmly. *Search thoroughly. Verify before claiming. Do
not overstate.* These are not wrong. They constrain the wrong thing.

A rule that describes *how* to work has no truth value. Nothing can check it, so it competes
for attention with everything else in the context and loses whenever the task gets
interesting. A constraint on *what must hold* has a truth value: it can be observed, it costs
nothing until it fires, and it leaves the approach entirely alone.

| process constraint · unenforceable | outcome constraint · enforceable |
| --- | --- |
| “survey the literature first” | a survey unit cannot close with `unscreened > 0` |
| “don't over-trust the paper” | a claim may not exceed its source's read depth |
| “distinguish settled from new” | `established` requires disjoint author sets |
| “cite accurately” | an unresolved identifier cannot reach the draft |
| “say what done means” | an acceptance question that is open right now |
| “don't pad it” | over budget, an addition must name what it costs |
| “know when to stop” | zero material findings is a verdict, not a shorter list |

Each row on the right is a state the session can be observed to be in. That is the whole
difference, and it is why this is a set of gates rather than a longer prompt.

## 4 · Research has no compiler

Software gets this for free. *It builds*, *the suite is green*, *the check went red to green*
are facts, observed rather than reported, and facts can block. Research has no equivalent, so
the entire design question is: which questions here are **equally objective**?

Fewer than you would like. Four are genuine facts — a lookup with a yes or no answer, no
judgement anywhere in it:

| fact | how it is decided | when it cannot fire |
| --- | --- | --- |
| this reference exists | the DOI or arXiv id resolves against Crossref or OpenAlex | — |
| it was not retracted | retraction metadata on the resolved record | the index has no record |
| this quote is verbatim | string match against cached full text | **no open-access text was retrievable** |
| these sources are independent | author and institution id sets are disjoint | an id is missing from the record |

Three more are **counts**. A count is a fact; the threshold you compare it to is a choice,
and the two must not be confused:

| count | the fact | the choice |
| --- | --- | --- |
| screening | how many found, screened, included | whether unscreened must reach zero |
| vocabularies | how many distinct query vocabularies were logged | whether three is enough |
| format | words or pages against the declared limit | the limit, which the venue sets |

And one is openly a **heuristic**, which is why it reports and never blocks: walking a
claim's citations backwards to see whether the trail reaches primary evidence. No index has a
*“this work reports data”* field, so the walk infers it from work type and reference count.
It is a good lead and a bad gate.

Two of these are the cheapest real epistemics available and nobody builds them. **Source
independence is set arithmetic on author lists.** **Folklore is a citation trail that never
lands on evidence.** Both fall out of metadata already fetched to render a bibliography.

The honest floor is small, and it is enough — because *shallow* is invisible in prose and
undeniable in a row of numbers:

```
$ nullius coverage
found        231    screened 0     included   4
vocabularies 1      of 3 suggested — try the field's terms, not yours
groups       1      4 works, 2 shared authors, not independent
years        2024–2026   most-cited ancestor of the seed set unread
```

*“I reviewed the literature”* survives any amount of scrutiny. That block does not.

## 5 · Warrant, capped by read depth

Every claim carries a warrant class saying what settles it. The class that matters most is
the one nobody tracks: `authors-claim`, meaning *the authors assert this*, recorded
separately from what their tables show.

Then the cap. A paper note records how far you actually got, and **a claim may not exceed the
read depth of its source.**

| read depth | “they report X” | “X holds” | “their method shows why” | “this generalises” |
| --- | :-: | :-: | :-: | :-: |
| `abstract` | ok | refused | refused | refused |
| `skim` | ok | ok | refused | refused |
| `method` | ok | ok | ok | refused |
| `replicated` | ok | ok | ok | ok |

This works where an instruction does not because the difference is **textual**. *“They report
a 12% gain”* and *“the method gives a 12% gain”* are different strings, and the ledger holds
the class. A script can decide it. *“Be appropriately skeptical”* cannot be decided by
anything.

## 6 · Settled versus proposed

Epistemic status is a second axis, and it is the one that costs years when it is missing.
Warrant asks *how do you know this*. Status asks *how settled is this in the field*. A claim
can be perfectly warranted and barely established, and that cell is the dangerous one.

| status | what earns it | how it may appear in prose |
| --- | --- | --- |
| `textbook` | graduate texts treat it as background | bare assertion |
| `established` | *independent* replication, disjoint author sets | bare assertion, review cited |
| `contested` | serious work on both sides, both logged | must name both sides |
| `emerging` | one or two groups, recent | “early evidence suggests”, groups counted |
| `single-result` | one paper, one setting | attributed and situated, never bare |
| `folklore` | repeated; the trail never reaches data | marked unsourced, or dropped |

Two things stop status from being self-declared. It is **capped by source independence** —
the exact parallel to the read-depth cap, and computable from author identifiers the record
already carries. And its rendering is greppable, so the discipline lives in a difference a
script can see rather than in an adjective the model is asked to feel.

Pointed the other way, the same axis is what stops your open question from being closed on
your behalf: a live disagreement rendered as `contested` keeps a door open that a confident
summary would have quietly shut.

## 7 · Missing, or merely more

Back to the asymmetry. The resolution is that *“something is missing”* is three different
claims wearing one word, and they differ in whether they can point at something enumerable.

| kind | grounded in | why it terminates |
| --- | --- | --- |
| `structural` | the venue's list of required sections | the checklist is finite |
| `evidential` | the claim ledger | the claims are enumerable |
| `coherence` | two locations in the artifact | the pairs are finite |
| `enhancement` | **nothing** | **it never does** |

So: **a finding must cite a required-section id, a claim id with an empty warrant, or two
conflicting locations. A finding that cites none of the three is enhancement, and
inadmissible.** No severity intuition required — a finding either has a referent or it does
not.

The same rule keeps the tool honest in the other direction. The completeness sweep is
**walked, not sampled**: every required section gets present, thin or absent, every run.
*“It never told me the timeline was missing”* cannot happen, because the checklist is
enumerated rather than intuited. And “required” comes from a real document — the grant call,
the author guidelines, the venue's checklist, the field's reporting standard — so the tool
cannot invent a requirement it cannot cite.

### The budget is a price, not a ceiling

Now the two axes compose. A gap is real or it is not; the artifact is inside its format or
over it. Four situations, one honest answer each.

| | inside the budget | over the budget |
| --- | --- | --- |
| **a real gap exists** | **Say it. Additions admissible.** The gap is real and there is room. The ordinary case, and nothing here suppresses it. | **Say it — and name what it costs.** Both are true at once, so the fix is a *trade*. “The sampling frame is unstated; the two paragraphs on X are the cheapest 150 words.” |
| **no real gap** | **`submit`.** Zero structural, evidential and coherence gaps, inside the format. A verdict — and the tool is forbidden from producing further findings. | **Only cuts.** Nothing is missing and it is too long. Now, and only now, the question becomes what earns its place. |

The upper-right cell is the one that fourth run needed and did not have. And the funding
requirement is a severity filter the tool **cannot fake**: nobody trades two working
paragraphs for a nice-to-have, so soft findings collapse under their own price without anyone
having to judge them soft.

> **The reframe.** The budget does not forbid additions. It **prices** them — and a priced
> list has to be ranked, while a free list can only be enumerated. An unbounded set of
> improvements becomes a ranked set of trades, and a ranked set has a top and therefore a
> bottom.
>
> The switch from *“what is missing”* to *“what earns its place”* is then nobody's
> judgement call. It happens on its own, the moment the last real gap closes.

## 8 · What blocks, and what is merely reported

A fact and a chosen number are different claims, and conflating them is how a good gate turns
into a nuisance.

| facts · these refuse the stop | chosen · these are reported and marked |
| --- | --- |
| the acceptance question is still open | a citation trail that never reaches data |
| a citation is unresolved, or retracted | source independence looking thin |
| a quote is not verbatim against cached text | fewer vocabularies than suggested |
| a claim sits above its source's read depth | passes with no new external object |
| a status is stronger than independence earns | a one-sided support/refute balance |
| a required section was never walked | the extension-loop signal |
| over the format budget with no trade named | single-source claims present |
| a survey unit left items unscreened | judge scores, for ranking only |

The left column needs no calibration to be right. The right column would need a hundred or
two labelled examples and an agreement measure before it could honestly refuse anything, and
that work has not been done — so it does not refuse. Saying which is which is not a caveat.
It is the difference between a gate you trust and one you learn to route around.

## 9 · Where it touches a session

No wrapper, no proxy, no prompt prepended. Shell scripts on hook events, one ledger on disk,
and agents that get a clean context window.

```mermaid
sequenceDiagram
    autonumber
    participant S as Session
    participant G as nullius gates
    participant L as ledger on disk
    participant M as model

    S->>G: SessionStart
    G->>L: read
    G-->>M: invariants · the unit and its budget · open claims<br>falsified ideas · what is still unscreened

    M->>G: PreToolUse · Write or Edit
    G->>L: read
    G-->>M: prior notes · claims already made · registered terms
    alt a fact is violated
        G-->>M: refused, with the locator
    end

    M->>G: Stop
    G->>L: read every condition
    alt a fact is unmet
        G-->>M: exit 2 — the reason, work continues
    else only chosen thresholds are unmet
        G-->>M: reported and marked as chosen, the turn may end
    end
```

Gate code never enters the context. Only the text a gate emits costs tokens.

## 10 · Making it yours

A harness that hard-coded one field's norms would be useless in every other field and quietly
wrong in its own. So the tool ships knowing nothing, and the norms are configuration:

- **`field.md`** — your subfield's norms. What a normal sample size is here, what a standard
  baseline is, which claims need what kind of evidence. This is what makes a critique
  *calibrated* rather than idealised.
- **`venues/<venue>.md`** — required sections, page limit, what reviewers there actually ask
  for. Bootstrapped once from the real call or author guidelines. A structural finding must
  cite a line in this file, so the tool cannot invent a requirement.
- **`program.md`** — what you are actually working on, so a thread that does not trace to it
  can be flagged as the distraction it is.
- **`threads/`, `papers/`, `claims.jsonl`, `falsified.md`** — the durable record. This is the
  half that survives a dead context window, and a dead semester.

> **The one file people underestimate.** `falsified.md` holds the ideas you killed and why.
> It costs a minute to write and it is the only thing standing between you and re-proposing,
> in June, the idea you buried in March.

## 11 · What this is not

- **Not a literature database.** It queries real indexes — OpenAlex, Crossref, Semantic
  Scholar, arXiv, Unpaywall, Europe PMC — through their official APIs. Coverage is theirs,
  and it is uneven by field. The contribution is refusing to let you *not* look, not
  pretending the index is complete.
- **Not a substitute for reading.** The read-depth cap exists precisely because the tool
  cannot read for you. It can only refuse to let an abstract masquerade as a method section.
- **Not a calibrated judge.** The severity classes rank; they do not measure. Where a number
  was chosen rather than measured, the tool says so and does not block on it.
- **Not a way around a paywall.** Official APIs and legally open full text only.
- **Not an author.** It has no opinion about what you should study, and the parts that look
  like opinions are your own `field.md` read back to you.

## 12 · Where this is

The predecessor of this design is a working harness for software work, in daily use, where
the compiler does the blocking. Everything here is the attempt to answer one question
honestly — *what plays that part when the work is research* — and then to build only what
that answer supports.

The build order follows the confidence. The prose spine and the ledger first, because they
change behaviour immediately and cost nothing to revise. The blocking gates second, because
that is where hallucinated citations stop being possible. The literature spine third, because
it is the largest piece of genuine capability and the one worth doing slowly. The calibration
engine last, because it is the part most likely to be wrong on first contact with a real
draft.

---

If a claim in this document is wrong, that is a finding and it should be filed as one. The
tool this describes would refuse to let it stand without a locator, and the document should
be held to the same bar.
