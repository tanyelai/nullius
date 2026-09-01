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
