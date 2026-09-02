# Evals

Six scenarios, one per use case, each on a different AI subject picked at random and none of
them one the author works in. Every scenario says what a healthy run produces **and what would
count as a failure in both directions**: the tool blocking something it should allow, and
passing something it should refuse.

## What this can measure

- **Does each use case complete end to end** against live indexes and real papers, or does the
  tool wedge, crash, or refuse something reasonable.
- **Do the gates fire on real material**, not only on the synthetic fixtures in
  `tests/smoke.sh`. A guard that works on a constructed string and not on a real draft is worse
  than no guard.
- **What breaks.** Every session of real use so far has surfaced defects the suite could not,
  and that has been the actual value: a name spelled with U+2010, an index that ORs its terms,
  a durable record that did not survive a context boundary.

## What this cannot measure

It is not a benchmark and six runs are not calibration. In particular it says **nothing** about
whether the severity classes are right, whether a critique the tool permits is a good critique,
or whether a researcher using this ends up with better work than one who does not. Those need a
control, human labels and an agreement measure. None of that exists here, and
[`algorithms/harness.md`](../algorithms/harness.md) says so.

Read a green run as *nothing broke on this path today*, not as evidence the tool works.

## One thing these runs taught about reading them

`close` answers the acceptance question. It does not finish the unit, and the gates that decide
finishability live at the **stop**. Three scenarios were written expecting `close` to refuse and
were wrong about where to look. The separation is right, but nothing said so, and `close` now
reports how many things still refuse the stop.

## Running one

```bash
bash evals/run.sh 01        # writes evals/results/01-<date>.md
```

Live indexes are involved, so a run can be refused by rate limiting. That is not a failure of
the scenario; re-run it later. The runner records it either way.

## The scenarios

| | use case | subject |
|---|---|---|
| [01](scenarios/01-gap.md) | is a gap real, or did the search fail | speculative decoding |
| [02](scenarios/02-survey.md) | cover a literature and close the frontier | machine unlearning evaluation |
| [03](scenarios/03-read.md) | read one paper into the ledger at honest depth | mixture-of-experts routing |
| [04](scenarios/04-propose.md) | write a proposal against a venue's format | watermarking robustness |
| [05](scenarios/05-critique.md) | review what 04 produced, and stop | the output of 04 |
| [06](scenarios/06-interpret.md) | interpret a result without moving the goalposts | influence functions at scale |
| [07](scenarios/07-fallback.md) | keep working when an index refuses | the tool itself |
