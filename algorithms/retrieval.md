# Retrieval

## Relevance gates, impact orders

**Naive.** Ask the index to sort its matches by citation count, so the important work is first.

**Measured.** *retrieval augmented generation evaluation faithfulness*, sorted that way over
15,277 matches, returned **"Revolutionizing healthcare: the role of artificial intelligence"**
at the top. Sorting the whole corpus by citations returns the most cited work sharing **any**
term, and *artificial intelligence* is a term.

**Instead.**

```
candidates ← index.search(query)        # relevance decides membership
ranked     ← sort(candidates, by = citations / age)   # impact decides order
```

Two knobs, never one. The index knows more about relevance than we do; we decide what to read
first among what it returned.

**Weak.** Relevance is whatever the index scores. There is no appeal.

## Match title and abstract, not full text

**Measured.** The same query: **15,277** through `search`, **811** through
`title_and_abstract.search`. The top result changed from a general survey to *Evaluation of
Retrieval-Augmented Generation: A Survey*, which was the subject.

Full text is `--loose`, and says so when used.

## Only a quoted phrase narrows

**Measured**, same terms, three syntaxes:

| syntax | matches |
|---|---|
| `retrieval augmented generation evaluation` | 13,655 |
| `retrieval AND augmented AND generation AND evaluation` | 13,655 |
| `"retrieval augmented generation" evaluation` | 13,239 |

The first two being **identical** is the finding: `AND` is not an operator, it is another term
to OR. Where terms do occur apart it bites: *context relevance answer faithfulness* matched
**205**, `"answer faithfulness"` matched **65**, same paper on top.

```
sanitise(q):
    keep letters, digits, spaces, hyphens, and DOUBLE QUOTES
    drop an unclosed quote rather than send it
    if unquoted_terms(q) > 3: warn that the index will OR them
```

arXiv has the same shape. `all:a b c d` matched **1,174,335** works, most of arXiv; the four
terms ANDed matched **3,789**. Quoted phrases stay whole, loose words are ANDed.

## An empty result is information

**Naive.** Few results, so widen and return something.

**Why it is wrong.** An empty title-and-abstract result says *the field does not use these
words*, which is the finding that makes a literature search work. Substituting a looser search
destroys it. Thin stays thin and says what it means; widening is opt-in.

## Counts

```
impact(w)  = w.citations / max(1, this_year - w.year + 1)   # None if year unknown
recent(w)  = w.year > this_year - 3 and w.citations < 1     # own band, not buried
rule(w, n) = SKIP if w.citations is None                    # unknown ≠ zero
             else w.citations < n
```

**Measured.** `(citations or 0) < n` swept away every row no index reported a count for, which
were exactly the preprints enrichment had missed.

Per-index totals are reported separately, never as one maximum: one index answering nonsense
should not poison the number.

## Report the funnel, not the survivors

**Naive.** Report what you found: 6 works included.

**Why it is thin.** A search that retrieved 40 and discarded 34 looks identical to one that
retrieved 6, and they are not the same search. What killed the difference is the number that
says how hard you looked.

```
matched      per index, never one maximum
retrieved    40   across N searches and M vocabularies
screened     40   0 unscreened
  by rule    34   exclude 17  cited_by<1        "no citations yet"
                  exclude 17  all-remaining     "an application, not a method"
  one by one  6
included      6   15% of what was retrieved
walked        1   of 1 kept on the graph, 5 off it
saturation   69%  on the last hop (a proxy for coverage, not a measure of it)
```

The rules are printed because a criterion applied uniformly is one thing a reader can
disagree with, and forty individual judgements are forty.

## One index is not a route

**Naive.** Pick the best index and use it.

**What happened.** OpenAlex is the only index reachable here with `cites:` and `cited_by:`
filters, so a rate limit did not slow a citation walk down, it ended one. And a `lit` run
returned whatever the other two indexes happened to hold.

**Measured**, on the fallbacks, before choosing between them:

| route | answers | shape |
|---|---|---|
| Crossref search | yes | relevance-ranked, carries `is-referenced-by-count` |
| Semantic Scholar `/references` and `/citations` | yes, five rapid calls unthrottled | title, year, citation count in **one** call |
| OpenCitations | yes, at `api.opencitations.net/index/v1/` | DOI pairs only, so N further lookups per hop |
| DBLP | timed out | dropped |

So search falls back to Crossref, and the graph falls back to Semantic Scholar. OpenCitations
is the honest third option and is not wired, because a payload of bare DOIs turns one hop into
one call plus a lookup per result.

**And the substitution is never silent.** A set retrieved through Crossref is not the set
OpenAlex would have returned, so the run says which index answered and the search log keeps
`indexes`, `unreachable` and per-index `matched`. Every walked row carries the index it came
from. A claim about a literature is a claim through the index that answered.

```
lit:      openalex → RateLimited → crossref, and say so
snowball: openalex → RateLimited → semanticscholar by DOI, and label every row
          no DOI on the seed → no fallback route, and say that too
```

**The case that nearly escaped.** A substitution that *fails* leaves an error row, so it was
always visible. A substitution that *works* leaves rows that look ordinary, and the walk's log
header was a literal `"indexes": ["openalex"], "unreachable": []` written before any fallback
existed. So the one path that mattered was the one that said nothing: eighteen rows arrived
through Semantic Scholar while the header recorded that OpenAlex answered and nothing was
unreachable, and `coverage` reads that header. The header is now derived from what answered,
the refusal travels as data rather than as prose inside an error string, and the run prints the
substitution instead of leaving it per-row.

It survived because the eval that required it checked the wrong handle: provenance on the
walk's **rows**, and the header on `lit`'s log. Two correct checks, and the defect lived in the
gap between them.

**Testable on purpose.** `NULLIUS_FORCE_RATELIMIT=openalex` forces the path, because a
fallback nobody has exercised is a fallback that fails when it is needed. Covered by
[eval 07](../evals/scenarios/07-fallback.md), in both directions: forced, the walk log must
name Semantic Scholar and OpenAlex; healthy, it must claim neither.

## A rate limit is a wait, not a wall

**Measured, by deserving it.** Enough calls and the index answers HTTP 429. Before any of this
existed the tool called that an unreachable index and the walk closed, which reads as *the work
is not there* when what happened was *ask again in a minute*.

**Three layers, and the order matters.** A 429 or 503 retries with backoff and honours
`Retry-After`, because most of them clear on their own. What outlives the retries takes the
fallback route above. Only when there is no route left does a hop report itself **incomplete
rather than empty**, and that is a different sentence from *the graph closed here*. The tool
says whichever one is true and never the other.

**Weak.** A seed with no DOI has no third layer at all, because Semantic Scholar is addressed
by DOI. For those the honest report is the only report, and how often that bites depends on how
much of your ledger came from arXiv.

## Considered and declined: predicting what is worth reading

AI Research Preference Models ([arXiv:2608.13940](https://arxiv.org/abs/2608.13940)) solves a
shaped-alike problem for autonomous agents: far more candidate experiments than the GPU budget
can run, so a model predicts which are promising and the budget follows the prediction. The
analogue here is obvious. You retrieve 231 works and can read six.

It is declined, for one reason. A preference model is a **judgement**, and a judgement inside a
gate is the thing this harness exists to keep out: it would quietly decide what you never see,
and the failure mode is silent. Ranking by impact is a proxy that says what it is; a learned
preference is a proxy that does not.

The honest middle, if this is ever built, is a **reported** ordering that never filters, sitting
beside the counts rather than replacing them.
