# 08 · A literature whose canon is older than its vocabulary

**Subject.** Whether the language you speak changes what you can see: the colour-term case,
from Berlin and Kay through the categorical-perception dispute to the information-theoretic
account.

**Task.** Cover the literature well enough that *what the field is built on* is a count rather
than a recollection.

**The point.** Every other scenario here is an AI subject, and AI literatures share a shape:
the canon is fifteen years old, everything is on arXiv, and the words the founding papers use
are the words today's papers use. This one breaks all three. The indexes chosen for the field
carry no arXiv at all, the founding work is a 1969 monograph, and the terms a newcomer would
search are not the terms the field's own canon is phrased in.

That last property is what `snowball` exists for and what no scenario had yet tested on a
literature where it is severe.

## A healthy run

1. `init --field "linguistics and the philosophy of language"` selects **openalex, crossref**.
   No arXiv, no Europe PMC. A field-index guess is a starting point and the run says so.
2. Three vocabularies, logged separately. Measured, on the three below:

   | vocabulary | query | openalex matched | retrieved |
   |---|---|---|---|
   | mine | `"linguistic relativity" color perception` | 48 | 7 |
   | field | `"basic color terms" cross-linguistic` | 25 | 8 |
   | adjacent | `"color naming" "communicative efficiency"` | 4 | 4 |

   **The three sets are nearly disjoint**, and the adjacent one is the smallest while carrying
   the highest-impact work on the subject anywhere in the run, at 31 citations per year. The
   only row above it, at 32, is a vision-science textbook that screening throws out. A
   vocabulary that returns four works is not a failed search.

3. Screen all of it. Nineteen retrieved from the queries, six kept across all three
   vocabularies, thirteen excluded by three recorded rules.
4. `snowball --both --until-saturated` from those five.
5. Read the multiplicity, not the citation count.

## What the walk must surface, and the searches must not

**Measured.** Three keyword searches returned nineteen works and **not one of them was the
canon**. One walk, and 456 works the graph reached that no vocabulary returned:

```
  hop   new   known   saturation   reached from >1 seed
    1    95      13         12%                9
    2    67      41         38%                9
    3    54      42         44%                9
    4   112       8          7%                9
    5    65      55         46%                9
    6    82      38         32%                9
  stopped, budget spent: 475 works reached, at the cap of 400. This is not
  convergence, and the two are different claims

  4/5 (80%)  1971   2195  Basic Color Terms: Their Universality and Evol  ancestor?
  3/5 (60%)  2005    450  coordinating perceptually grounded categories
  2/5 (40%)  2000    621  Color categories are not universal: Replicatio
  2/5 (40%)  2005    316  Focal colors are universal after all
  2/5 (40%)  2003    329  Resolving the question of color naming univers
```

Berlin and Kay at **four of five seeds**, and those five are drawn from three vocabularies that
do not share a word with each other. That is the claim in
[algorithms/graph.md](../../algorithms/graph.md) --
*a canon is usually phrased in older words than the papers citing it* -- holding on a
literature outside the one it was written for.

And the two rows at 2/5 are the dispute itself: *Color categories are not universal* and
*Focal colors are universal after all*, both surfaced by the same walk. A session that reads
one side and not the other has not read this literature, and no keyword query in this run
returned either.

## The known weakness this scenario exists to exercise

`graph.md` declares it and nothing had ever run it:

> Era proximity is a proxy, and it will misjudge a field whose canon genuinely is old.

**It misjudges here, exactly as written.** The oldest seed is 1997, the ancestor gap is 12
years, so Berlin and Kay 1969 is flagged `ancestor?` -- *often an ancestor of everything nearby
rather than this field's own reference*. It is this field's own reference. It is the most
central work the walk found, at the highest multiplicity in the run, and the heuristic labels
it as the thing to be careful of.

**The flag firing is correct behaviour and the label is wrong, and those are different
sentences.** The scenario asserts the first and records the second. A run where Berlin and Kay
arrives *without* the mark would mean the gap threshold had been quietly tuned to make this
case look good, which is worse than a proxy that says what it is.

## Must refuse

- Closing a `survey` while anything retrieved is unscreened, the walk's own 475 rows included.
- Closing while a work screened in has never been walked.
- A claim from the trade book below, or from any source, with no note against it.
- `established` on this question from one author group. The dispute has at least two and the
  arithmetic has to see both.

## Must report but never block

- `ancestor?` on the field's founding monograph. A lead, not a verdict.
- A kept work carrying no index record, so the graph cannot be walked from it.
- Saturation as a proxy for coverage. This run never reached the target at all and stopped on
  the work cap with 82 arriving new on the last hop, which the stop reason says in those words:
  *this is not convergence, and the two are different claims.*

## Must allow

- A vocabulary that retrieves four works. Thin is a finding about the vocabulary.
- **A source the indexes do not carry.** Guy Deutscher's *Through the Language Glass* is where
  the popular version of this question lives and it has no DOI:
  `cite <url> --kind book --title "..." --author "Guy Deutscher" --year 2010`. It records as
  `peer_reviewed: false`, which caps what a claim resting on it may assert. That is the point
  of having it in the ledger rather than in the prose.
- Two OpenAlex records for one monograph -- the book and a journal review of it -- arriving as
  separate rows. The index carries them separately and the walk does not merge by title.

## Found by running this

**Saturation is not monotonic, and one hop's number is not a curve.** The run above went
12% → 38% → 44% → **7%** → 46% → 32%. Hop 4 collapsed to 7% because the walk had arrived
somewhere it had not been. A stop rule reading only the last hop would have called hop 3 nearly
converged and been wrong about the shape of what was left.

**The same walk, same parameters, stops for different reasons depending on which two works you
screened in.** A hand-picked seed set drawn one per vocabulary converged at hop 3 on 60%
saturation with 210 works reached. The seed set this scenario takes -- the top two of each
vocabulary -- never converged and spent the budget at 475. Same three queries, same limit, same
depth.

That is the walk's sensitivity to its seeds, measured. `graph.md` already fixed circularity
*between* the walk and its seeds; nothing yet checks whether the seeds are independent of each
other, and agreement across five seeds drawn from one ranking is a weaker fact than agreement
across five drawn from five entry points. The share is reported, so the reader can see the
denominator. What is not reported is how correlated it is.

**Berlin and Kay arrived at 4/5 in both runs**, which is the one thing that did not move.

## Failure signatures

- A run that reports the retrieved set as the literature. Nineteen works, none of them the
  canon, is what that looks like here.
- The walk drifting into general colour science or vision psychophysics. Multiplicity is over
  *your* seeds; if it is not, a 2000 vision-science textbook leads the hop.
- `ancestor?` silently absent, or the gap threshold changed so this case passes.
- A single replication, however recent, treated as settling the dispute.
