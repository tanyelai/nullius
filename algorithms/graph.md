# The citation graph

## Multiplicity is the signal, not the edge

**Naive.** Follow references from a good paper, then follow theirs.

**Why that is not enough.** Following edges gives reachability. What tells you what a field is
built on is **how many of your seeds point at the same work**. A keyword query will not
reliably surface it, because a canon is usually phrased in older words than the papers citing
it.

**Measured.** Two hops from a single seed surfaced, by two separate paths, the monograph the
whole line descends from. Three keyword searches over the same subject had not returned it
once.

```
reached ← {}                                  # work → set of seeds that reached it
for hop in 1..depth:
    for s in frontier:
        for w in index.cited_by(s) ∪ index.cites(s):    # one call each
            reached[w].add(s)
    frontier ← next_seeds(reached)
```

## Agreement is a share, not a count

**Measured.** With thirteen seeds, the works reached by three of them came back as a 1962 paper
on probability density estimation and four more kernel density classics, offered as the canon
of a subject two decades younger.

Three of thirteen is 23%. At that level agreement is noise: almost anything adjacent to
machine learning cites a density classic somewhere. Report the share. `2/13` and `2/3` are not
the same claim.

## An ancestor of everything is not this field's canon

**Measured, same walk.** The next hop's seeds were ranked by multiplicity then **citation
count**, so a work reached by three seeds with **10,593** citations and a **1962** date led the
hop and walked the search into statistics.

```
era ← median(year of seeds)

next_seeds(reached) =
    sort(reached, key = (|seeds reaching|, −|year − era|))  ← not by citations
    take k not already walked

flag w as ancestor? if w.year < min(seed years) − 12
```

A field's own shared reference is contemporary with the field. An ancestor of everything nearby
is far older. With that changed, the same seeds returned the subject's founding paper at 3/7,
its standard textbook at 2/7, and its other founding paper.

**Weak.** The right discriminator is lift over a base rate: how much more often *these* seeds
point at a work than the literature at large does. That needs a base rate nobody has cheaply.
Era proximity is a proxy, and it will misjudge a field whose canon genuinely is old.

## Saturation is the read-enough signal

```
new, seen ← partition(hop results, already in reached)
saturation ← seen / (new + seen)
```

Zero percent on hop one and six on hop two says the literature is not covered. It is a count
rather than an impression.

**Weak, and there is a literature saying so.** Technology Assisted Review has studied when to
stop screening for two decades, and its methods target **recall** rather than saturation:
Confidence-Based Stopping Methods for Systematic Reviews ([arXiv:2606.15380](https://arxiv.org/abs/2606.15380))
and Stopping Methods based on Point Processes ([arXiv:2311.08597](https://arxiv.org/abs/2311.08597))
estimate how much of the relevant set has been seen, which is the question saturation only
gestures at. What is here is a crude proxy and should be read as one. Implementing a real
estimator is the clearest open improvement in this file.

A `survey` unit cannot close while a work you screened in has never been walked. That turns
*the frontier is closed* from a sentence into a count. A work the index does not carry cannot
be walked at all, and that is reported rather than skipped.
