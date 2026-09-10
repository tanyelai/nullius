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

## Requiring a judgement without depending on it

**Naive.** Gates must be computable, so a gate can only ever check what a script can decide.
That is why every gate in this tool counts something, and it is why none of them is smart.

**The category that was missing.** This repository already built three critics that start in
a clean context and do not know whose work they are reading. They are the smartest thing in
it. **Nothing has ever depended on one running.** So the enforced half was dumb, the smart
half was optional, and WHY.md section 3 says exactly what happens to an optional rule.

The asymmetry made it concrete: a `critique` unit must produce a verdict, and a `write` unit
need never receive one. A draft could reach the end read by nobody.

```
gate:  a write unit that names a venue does not close
       while a tracked draft has no recommendation on it
never: the tool does not read the recommendation, and does not care what it says
```

**Why this is not a judgement inside a gate.** The tool checks that a verdict exists. It
never checks whether the verdict is right, and a `rework` closes the unit exactly as an
`accept` does. What to do about a finding stays where it always was. This is the venue walk
one level up: the tool cannot decide whether a draft is good, so it refuses to let nobody
look.

**Why it is hard to satisfy dishonestly.** A verdict has to be on the venue's own scale, and
zero findings that generate work already forces the positive end of it. Producing a plausible
review means producing located findings against a file the tool can read. That is more work
than obtaining one.

**Only once it names a venue.** A write unit with no venue is drafting, and drafting is where
the work happens. Declaring a venue is the observable act of saying this goes out. Firing on
every write unit would tax thinking, and a gate that taxes thinking is switched off inside a
week.

**Weak, and it is the same weakness as everywhere else.** Nothing verifies that the reader had
a clean context, or was a reader at all. `--by` records the answer and `report` carries it, so
a verdict with no reader named is reported as the session's own verdict on its own draft,
which is the check this tool exists to say is not one. And `unread "<why>"` is the way past,
because a gate with no way past it is a gate people route around; the decision is recorded and
travels.

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

## Every reviewer point, enumerated

**Naive.** Write the response letter.

**Why it is wrong.** A response written straight through concedes the easy points and quietly
skips the hard one, and nobody notices until the second round.

```
for each point the reviewers made:
    record it before writing any of the reply
    settle it: changed | rebutted | declined
    rebutted and declined need a reason
```

The gate refuses a point nobody looked at. What you do about one is yours, and the count of
declined points travels with the reply, because that is the half a reviewer reads hardest.

## Post-hoc is allowed, and labelled

Naming the number that would change your conclusion after seeing the results is legitimate and
common. What is not legitimate is presenting it as confirmatory. So it is refused silently and
allowed with `--post-hoc`, which labels the unit exploratory and carries the label into the
next session.
