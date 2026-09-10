# 03 · Read one paper into the ledger at honest depth

**Subject.** Routing in mixture-of-experts models: how tokens are assigned to experts and what
that costs.

**Task.** Take one paper from identifier to claims, at the depth actually read and no further.

## A healthy run

1. `cite` the paper. It resolves, or the run stops there.
2. `fulltext`. Either text is cached, or the routes are listed and the note stays at
   `abstract`.
3. `note` at the depth genuinely reached.
4. `claim` at a strength that depth supports.
5. `quote` a sentence and have it verified against the cached text.

## Must refuse

- An identifier that **does not exist**, in both forms, with the sentence that explains why
  rather than a stack trace. Everything else here asks a live index for something real, so
  this leg is the only one that exercises the refusal the whole tool is named for.

- A `--strength mechanism` claim from a source noted at `abstract`.
- A claim whose source has **no note at all**.
- `--status established` from sources sharing an author.
- A quote that is not verbatim in the cached text.
- Any claim on a source recorded as retracted.

## Must allow

- `abstract` depth as a legitimate resting state when no full text is retrievable.
- A `single-result` claim, provided the prose attributes and situates it.

## Failure signatures

- Full text cached but `quote` fails on a sentence that is in the paper.
- The read-depth cap fires on a claim the depth does support.
- A preprint copy exists and `fulltext` does not find it.
