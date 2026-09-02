# 02 · Cover a literature and close the frontier

**Subject.** Evaluating machine unlearning: how a claim that a model has forgotten something is
tested.

**Task.** Reach the point where *the frontier is closed* is a count rather than a claim.

## A healthy run

1. `survey` unit. Three vocabularies at least, logged separately with hit counts.
2. Screen every retrieved work, individually or by a recorded rule.
3. `snowball` both directions from what was screened in, and read the multiplicity.
4. `coverage` reports matched, retrieved, screened, included, vocabularies, groups, years.

## Must refuse

- Closing with **anything retrieved left unscreened**.
- Closing while a work screened in has **never been walked**.

## Must report but never block

- Fewer vocabularies than suggested. A chosen threshold.
- A kept work the index does not carry, so the graph cannot be walked from it.
- Single-source claims, thin independence.

## Must allow

- A bulk exclusion by recorded rule, rather than forty individual judgements.
- Rows with no citation count surviving a `--below-citations` rule. Unknown is not zero.

## Found by running this

The walk produces candidates of its own, and the survey cannot close until those are screened
either. The loop is search, screen, walk, screen again, close, and the gate enforces it in that
order rather than letting a walk quietly enlarge the retrieved set behind you. Worth knowing
before you run one: sixteen new works arrived from a single hop.

## Failure signatures

- Saturation reported as if it settled the question. It is a proxy; see `algorithms/graph.md`.
- A hop refused by rate limiting reported as the graph having closed.
- Multiplicity dominated by works far older than the seed set without an `ancestor?` mark.
