# Critique, and stopping

## Three kinds of gap, and only two are real

*Something is missing* is three claims wearing one word. They differ in whether they can point
at something enumerable.

| kind | grounded in | terminates because |
|---|---|---|
| structural | the venue's required-section list | the checklist is finite |
| evidential | the claim ledger | the claims are enumerable |
| coherence | two locations in the artifact | the pairs are finite |
| **enhancement** | **nothing** | **it never does** |

```
admissible(f) = f.referent ∈ {structural, evidential, coherence, scope} and f.locator ≠ ∅
```

No severity intuition required: a finding either has a referent or it does not.

## The budget is a price, not a ceiling

The failure this addresses: a proposal that went 12 pages, then 24, and came back with a list
on the fourth pass.

Suppressing *what is missing* is the opposite failure, so the budget does not forbid additions.

```
                 inside budget          over budget
real gap    →    say it, add            say it, and name what it costs
no real gap →    SUBMIT                 cuts only
```

Nobody trades two working paragraphs for a nice-to-have, so soft findings collapse under their
own price without anyone judging them soft. And the switch from *what is missing* to *what
earns its place* is nobody's judgement call: it happens when the last real gap closes.

## Zero fatal and zero material is a verdict

```
if no finding generates work and verdict ∉ positive_end_of_scale: REFUSE
```

With nothing that generates work, the honest recommendation is the positive end of the venue's
own scale. Producing more findings past that point is pressure rather than rigour.

## A defensible finding closes permanently

A property of the study rather than a defect in it is discharged by one sentence in Limitations
and written to a committed file. Matching is on normalised text.

**Verified.** *"one site bounds generality"* discharged, then *"one site, bounds generality"*
refused.

## The draft declares its own boundary

A plan that survives review states what it deliberately does not cover, with a reason per row,
**in the plan**, where a reviewer sees it. The boundary is read from the draft, not kept beside
it.

```
boundary ← parse(draft, section ∈ scope_headings)   # markdown list | pipe table | LaTeX tabular
before any finding: require boundary was rendered in this unit
overlap(finding, row) → print as a LEAD, never act on it
row with no reason → REFUSE the stop
finding with referent = scope → admissible without reading first
```

**The decision worth arguing with.** No textual test can decide whether a suggestion falls
under a boundary row, so the guarantee is **enumeration, not judgement**. A wrong match here
silences a legitimate finding, which is the direction of error to avoid.

Two rules stop it becoming a shield: a row that excludes without saying why refuses the stop,
and the boundary itself is attackable. A design decision is reviewable; what is not reviewable
is re-raising it every round as though it had never been taken.

## Growth with nothing closed

Growth is not the signal. A draft that grew while four material findings were fixed is a draft
being worked on, and a detector firing on that would teach people to pad nothing and cut
everything.

```
sample at each stop, only when the measured state moves:
    (artifact, words, closed_work_findings)

over the last 3 samples:
    words ↑ by ≥ 25%  and  closed_work unchanged   →  report, with the numbers
```

A chosen threshold, so it reports and never ends a turn.

## Post-hoc is allowed, and labelled

Naming the number that would change your conclusion after seeing the results is legitimate and
common. What is not legitimate is presenting it as confirmatory. So it is refused silently and
allowed with `--post-hoc`, which labels the unit exploratory and carries the label into the
next session.
