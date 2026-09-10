# Harness

## Facts block, chosen thresholds report

A **fact** is a lookup or a count with no judgement in it. A **chosen threshold** is a number
somebody picked.

```
mode certain:
    fact      → exit 2, reason on stderr        # refuses the stop
    threshold → systemMessage, exit 0           # reaches the person, turn may end
```

**This was got wrong once**, and the suite caught it: thresholds were exiting 2, which ends a
turn on a number nobody measured. A gate that blocks on judgement gets switched off, and the
good gates go with it.

## A net that catches failures also hides them

`cmd_hook` wraps every gate in a bare `except` and exits 0, because a broken gate must never
wedge a session. That is right and it stays. What it also does is make a crash and a clean
pass **the same observation**: both are exit 0 with the tool out of the way.

**Measured.** The write gate carried a duplicated attribution block referencing two names
that were not bound in that scope. It raised on every clean write to a draft, so the
read-depth note the PreToolUse hook is documented to inject had never once fired, and
`expect_hook pre-write 0` read the crash as the gate allowing the write. Two hundred and
seventy-two assertions, both directions on every guard, and the suite was green throughout.

```
a guard is tested in three directions, not two:
    refuses what it must refuse
    allows what it must allow
    and, on the allowing path, DID SOMETHING            <- the one nobody names
```

So `expect_hook` now fails on `gate error` in the output whatever the exit code, and
`expect_hook_out` asserts what a hook said rather than only what it returned. Injecting one
`NameError` into `hook_stop` turns 25 assertions red; before, it turned almost none.

**The general form, and it is not about tests.** When a safety mechanism converts failures
into the success signal, the success signal stops being evidence. It is the same shape as the
fallback in [retrieval.md](retrieval.md) that worked and left no trace, and the same shape as
a `defensible` finding closing silently. Anywhere this tool degrades gracefully, something has
to observe that the degradation happened.

**Weak.** The check greps for one string. A gate that fails by returning quietly rather than
by raising is still invisible, and the only defence against that is the per-assertion kind:
naming, for each allowing path, what the gate should have said. Seventeen such assertions were
audited once; nothing keeps a new one honest.

## Hooks read local state only

A hook that makes a network call hangs a session. Resolution happens in a command the user ran
on purpose; the gates check what it wrote.

## Config merges per key, and an empty value must not win

```
config = DEFAULTS ⊕ user_layer ⊕ project_layer
where ⊕ skips keys whose value is "" or None
```

Two layers: user level for anything that must never reach a commit, project level for the rest.

**Why the rule exists.** The placeholder `init` wrote silently overrode a user-level contact
email, which took Unpaywall out of the picture and with it the whole route to preprint copies.
The feature failed silently and the gate had nothing to report.

## The durable half has to cross the boundary

A killing assumption and a cost estimate, the two decisions an idea rests on, were written to
the ledger and never carried into the next context window. Neither was the screening state, nor
why each kept paper was kept.

Writing something down that never comes back is worse than not writing it, because you believe
it is somewhere.

## Enumeration over judgement

The pattern appears three times and is the same each time: the venue walk, the scope boundary,
and the attribution guard.

The tool cannot decide whether a section is present in spirit, whether a suggestion falls under
a boundary row, or whether a name refers to the work you meant. So it does not try. It refuses
to let the list go unlooked-at and leaves the decision where it belongs.

## Storage and surfacing are two decisions

**Naive.** Write everything down, and hand all of it back at every session start. The
file-drawer result says the record you did not keep stops being available and then you run
the experiment again, so the writing half is right and stays.

**Measured.** The handing-back half was the same decision. A driven project with 40 finished
searches emitted 3,796 words at SessionStart and one with 80 emitted 8,116, because the
per-search cap on kept works had no cap across searches. A fresh project with nothing in it
emitted 2,091 words, of which 39 were about the project: 1.7x the ceiling this repository
sets for its own subagents, and the part that was about today began 72% of the way down.
Twelve buried ideas were injected as eight with no sign that four were missing.

**Instead**, keep the ledger complete and make surfacing a query over state:

```
live(search)  = any result still unscreened          # else its counts are in `coverage`
live(killed)  = shares a term with the question      # else counted, never dropped
live(need)    = not observed and not unmet           # `carried` stays live, and says where
scope         = the thread the open unit is on
order         = state, then invariants, then vocabulary
```

The same ledger now emits 2,223 words at 40 searches instead of 3,796, and the excess no
longer grows with the project. Deletion is a separate command and touches only what can be
rebuilt.

**Weak.** The floor is still 2,091 words and 94% of it is the invariants and the command
list, which are what make the harness work at all. Nothing budgets them, and cutting them
trades directly against the constraint reaching the model. Term overlap for buried ideas is
the same crude instrument `scope` uses and will miss a re-proposal phrased in new words.

## Where all of this is weakest

- **The severity classes are uncalibrated.** They rank; they do not measure. Calibrating them
  needs a hundred or two labelled examples and an agreement measure, and that has not been done.
- **Attribution is four regexes.** They will miss a style nobody thought of, silently.
- **Era proximity is a proxy** for field specificity and will misjudge an old canon.
- **Coverage is whatever the public indexes hold**, unevenly by field. *No such result was
  found* is a statement about a search, and the search is logged so the claim can be re-run
  rather than trusted.
- **Nothing has been evaluated against a control.** Every number in these files measures a
  failure, not an improvement.
