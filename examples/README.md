# Worked examples

Three `field.md` files, which are the one thing the tool cannot ship: what a normal sample
size is here, which baselines a reviewer expects, where results usually fail to transfer.
They are real and you should argue with them.

```bash
cp examples/nlp-eval/field.md .nullius/field.md
```

| | field |
|---|---|
| [`clinical-ml`](clinical-ml/) | machine learning on clinical images and signals |
| [`nlp-eval`](nlp-eval/) | evaluating language models and systems built on them |
| [`empirical-social`](empirical-social/) | quantitative social science |

There are no venue files here. Each field carried one, all three were byte-identical to each
other and to [`templates/venue.md`](../templates/venue.md) which `init` already writes, so
copying a field over your project overwrote a copy of itself. Nothing field-specific had
survived, because the tool may not require what it cannot cite a line for and an invented
checklist for a real conference would break that rule. Write the venue file once from the
call for papers; that is what makes a critique calibrated rather than idealised.
