# 06 · Interpret a result without moving the goalposts

**Subject.** Training-data attribution with influence functions at scale, and whether the
approximations hold.

**Task.** State what would change the conclusion, then read the result against it.

## A healthy run

1. `interpret` unit.
2. `decisive` recorded **before** any result is in the ledger.
3. `reading` recorded against it.
4. The conclusion states what was actually observed, not what was hoped.

## Must refuse

- Closing with **no decisive observation named**.
- `reading` before there is anything to read against.
- `decisive` recorded silently once `mine-unpublished` results already exist.

## Must allow

- `decisive --post-hoc` when the results are already in. Exploratory analysis is legitimate.
- A reading that contradicts the prediction. That is a successful run.

## Must report but never block

- The post-hoc label, carried into the next session so it travels with the conclusion.

## Failure signatures

- A post-hoc framing that is not labelled.
- The label lost at a context boundary.
- The tool refusing exploratory analysis outright rather than labelling it.
