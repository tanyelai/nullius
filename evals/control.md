# The arm that is missing

Every scenario in [scenarios/](scenarios/) answers *did this path complete and did the gates
fire on real material*. None of them answers the question the whole repository rests on:

> Does a session under these gates produce better-warranted work than the same session with
> the same advice and nothing enforcing it?

[algorithms/harness.md](../algorithms/harness.md) already says this has not been done:
*nothing has been evaluated against a control*. This file is the design, so that the gap is a
protocol somebody can run rather than a sentence somebody can nod at.

It is not runnable by `run.sh`. That runner drives the CLI from bash with no model in the
loop, and the question here is about what a model does, so the arms have to be real sessions.
What follows is the protocol and, at the end, the one instrument that does not exist yet.

## Three arms, and why the middle one is the whole experiment

| arm | what the session gets | what it tests |
|---|---|---|
| **A, bare** | the task, nothing else | the floor |
| **B, advice** | the five [invariants](../invariants/) in context, verbatim, and **nothing enforced** | whether writing the rule down is enough |
| **C, enforced** | the same five, plus the gates | whether enforcement adds anything over advice |

**B is the arm that makes this worth running.** A against C measures the whole package and
proves nothing anyone disputes. B against C isolates the single claim
[WHY.md](../WHY.md) section 3 actually makes: that a constraint on *what must hold* does
something a rule about *how to work* cannot. If B and C come out the same, that section is
wrong and the gates are ceremony. That is the result worth being able to get.

Arm B is configurable today. The blocking paths are guarded by
`cfg["mode"] in ("certain", "block")`, so any other value leaves every gate computing and
reporting and none of them refusing:

```bash
nullius config mode advice        # gates report through systemMessage, nothing exits 2
```

The SessionStart hook still injects the invariants and the current state, and the stop gate
still says what it found. That is exactly what arm B has to be: the advice, delivered as well
as it can be delivered, with no teeth behind it. A mode that stayed silent would measure
whether the session was told rather than whether it was refused, which is the wrong
difference and was the behaviour until the commit that added this file.

## Tasks

Reuse the seven scenario subjects. They were picked at random, none is a subject the author
works in, and they already span the six unit kinds. Each becomes a prompt with no mention of
nullius: *decide whether X is an open question*, *cover the literature on Y*, *review this
draft against this call*. Run every arm on every task, several times, because the variance
between two runs of one arm is what decides how many runs the comparison needs and nobody
knows it yet.

## What to measure

The point of measuring these and not others is that each one is a **fact**, in this
repository's sense: a lookup or a count with no judgement anywhere in it. They can be computed
from the artifacts each arm produced, by somebody who was not in the session.

| measure | how it is decided |
|---|---|
| unresolved identifiers | every DOI and arXiv id in the draft, resolved against a live index. A count of the ones that do not exist |
| retracted sources cited | retraction metadata on the resolved records |
| attributed names with nothing behind them | surnames the draft credits, against the author lists of what resolved |
| claims above their source's read depth | the strength the prose asserts against how far the source was read |
| statuses above what independence earns | `established` or `textbook` on sources whose author sets intersect |
| vocabularies searched | distinct query framings, counted |
| screened over retrieved | how much of what was found was ever looked at |
| findings with a referent | of the findings a critique produced, how many cite a required section, a claim, two conflicting locations or a scope row |
| corrections that reached the draft | of the claims abandoned mid-session, how many stopped being asserted in the text |

The last row is the one this repository is in the best position to measure and nobody else is
measuring. The self-correction literature scores whether the **answer** changed. This scores
whether the **artifact** changed, which is the thing that matters and the thing that silently
does not happen.

Arm C should score near zero on the first five by construction: the gates refuse those states,
so a session under them cannot end in one. That is not a result, it is a check that the
instrument works. **The result is arm B.** If advice alone gets most of the way there, this
harness is over-engineered and should be a prompt.

## And one measure that is not a fact

Whether the work is any *good*. That needs human labels, at least two raters, and an agreement
measure, and none of it exists here. It is the calibration work
[harness.md](../algorithms/harness.md) names and it should not be smuggled in under a proxy:
an LLM judge is verbosity-biased ([REFERENCES.md](../REFERENCES.md)), which is backwards for a
harness whose most valuable output is often that nothing more is needed.

Report the facts. Say the quality question is open.

## The instrument

The first three measures are computed by `nullius audit`, which exists for this and runs
outside a project on purpose:

```bash
nullius audit arm-a/draft.md arm-b/draft.md arm-c/draft.md --json
```

`check` audits a draft against a ledger. Scoring arm C from its ledger and arm A from its
text would compare two different things, so `audit` reads the artifact and nothing else, and
every arm is scored the same way.

It reports three buckets rather than two, because an index that refuses is not an index that
has nothing:

```
identifiers named       12
  resolved               9
  did not resolve        2    arXiv:2599.88888 · 10.9999/not-a-real-doi
  could not be checked   1    RateLimited
  RETRACTED              1
names attributed         8
  an author of a resolved work   6
  nothing behind them            2
```

**Read the rows for what they are.** *Did not resolve* is a fact: those were looked for and
the indexes did not have them. *Nothing behind them* is a lead, because a name can be cited
through a bibliography the auditor cannot see. And a resolved identifier exists without being
the work the sentence claims it is; nothing here reads the sentence.

Writing this command is what turned up the defect in
[algorithms/provenance.md](../algorithms/provenance.md): the first document it audited
contained an invented DOI, and the merge of two empty index answers raised instead of
refusing. That is the first thing this file has established, and it was established before
any arm was run.

## It has been run once, and it did not go the way this file assumed

[results/control-2026-09-11.md](results/control-2026-09-11.md). One task, three arms, one run
each. Every arm scored clean on every measure `audit` covers, including the bare one: the
failure the headline gate prevents did not occur anywhere. The arms did differ, and not here
-- arm B adopted the status vocabulary with nothing enforcing it, and arm C produced a ledger
of claims with warrants, statuses and grounded read depths.

**The distinguishing measure was the ledger, and the instrument does not score the ledger.**
That is not an oversight to patch quickly: scoring the artifact alone is exactly what makes
the three arms comparable, and the moment a measure reads arm C's ledger it is measuring
something arms A and B cannot have. The honest form of that measure is whether a third party
can check a claim in the draft, which is answerable for all three and is not in the nine.

Read the run's own last section before designing the second one. It lists four reasons the
result is weak, and the fourth is that the experiment was designed by the author of the thing
under test.

## What is still missing

The remaining six measures. Four of them read a ledger, which arm A does not have, so they
compare arms B and C only; the last, corrections that reached the draft, needs the session
instrumented rather than the artifact read. And the runs themselves: nothing here has been
run, so the honest statement about this design stays the one in
[REFERENCES.md](../REFERENCES.md), that the claim it works is deliberately not cited.
