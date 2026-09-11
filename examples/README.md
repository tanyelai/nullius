# Worked examples

Three fields, each with a `field.md` that is real. **Field norms are things one can state**:
what a normal sample size is, which baselines a reviewer expects, where results usually fail
to transfer. Those are written out here and you should argue with them.

There are no venue files here any more. Each field used to carry one and all three were
byte-identical to each other and to [`templates/venue.md`](../templates/venue.md), which
`init` already writes to `.nullius/venues/EXAMPLE.md` -- so copying a field over your project
overwrote a copy of itself with a copy of itself. Nothing field-specific had survived,
because the tool may not require anything it cannot cite a line for and an invented checklist
for a real conference would break that rule. Write the venue file once from the call for
papers or the author guidelines; that is what makes a critique calibrated rather than
idealised.

```bash
cp examples/clinical-ml/field.md .nullius/field.md
```

| | field |
|---|---|
| [`clinical-ml`](clinical-ml/) | machine learning on clinical images and signals |
| [`nlp-eval`](nlp-eval/) | evaluating language models and systems built on them |
| [`empirical-social`](empirical-social/) | quantitative social science |

The index-preset table that used to sit here claimed `init` picks a set of indexes for each.
It does that for `clinical-ml` and returns nothing for the other two: `FIELD_INDEXES` has no
key matching *language models* or *social science*, and `sociol` does not match `social`.
