# Worked examples

Three fields, each with a `field.md` that is real and a `venues/` entry that is a skeleton.

The asymmetry is deliberate. **Field norms are things one can state**: what a normal sample
size is, which baselines a reviewer expects, where results usually fail to transfer. Those are
written out here and you should argue with them.

**A venue's requirements are not.** The tool's own rule is that it may not require anything it
cannot cite a line for, and shipping an invented checklist for a real conference would break
exactly that rule. So the venue files carry the syntax, the format block and the parts that
generalise, and the required-section list is marked for you to fill from the call for papers,
the author guidelines or the reviewer form. Filling it takes ten minutes once, and it is what
makes every later critique calibrated rather than idealised.

Copy the one nearest your work into `.nullius/` and edit:

```bash
cp -r examples/clinical-ml/* .nullius/
```

| | field | indexes `init` would pick |
|---|---|---|
| [`clinical-ml`](clinical-ml/) | machine learning on clinical images and signals | openalex, crossref, europepmc, arxiv |
| [`nlp-eval`](nlp-eval/) | evaluating language models and systems built on them | openalex, crossref, arxiv |
| [`empirical-social`](empirical-social/) | quantitative social science | openalex, crossref |
