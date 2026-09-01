# The mechanisms, and the measurements behind them

Every entry here replaced something that looked reasonable and did not work. Where a number
appears it was measured on a live index or a real document, not estimated, because a
mechanism whose justification is an intuition cannot be argued with and therefore cannot be
improved.

Read it as a list of open questions with current answers. If one of these is wrong, the
measurement is the thing to attack.

---

## Retrieval

### Relevance gates, impact orders

**The naive move.** You want the important papers first, so you ask the index to sort its
matches by citation count.

**What happened.** A search for *retrieval augmented generation evaluation faithfulness*
returned, at the top of 15,277 matches, **"Revolutionizing healthcare: the role of artificial
intelligence"**. Sorting the whole matching corpus by citations returns the most-cited works
that share **any** term with the query, and "artificial intelligence" is a term.

**The mechanism.** Relevance is a gate; citations are an order **within** what got through
it. Never one knob. The index decides what is relevant, because on that question it knows
more than we do; we decide what to read first among the relevant.

**Still weak.** Relevance is whatever the index's scoring says. There is no appeal.

### Title and abstract, not full text

**Measured.** *retrieval augmented generation evaluation faithfulness* matched **15,277** works
through OpenAlex's `search` and **811** through `title_and_abstract.search`. The top result
changed from a general survey of RAG to *Evaluation of Retrieval-Augmented Generation: A
Survey*, which is the subject.

**The mechanism.** Match on title and abstract by default. Full text is `--loose` and says so
when used.

### A quoted phrase is the only thing that narrows

**Measured**, same terms, three syntaxes:

| syntax | matches |
|---|---|
| `retrieval augmented generation evaluation` | 13,655 |
| `retrieval AND augmented AND generation AND evaluation` | 13,655 |
| `"retrieval augmented generation" evaluation` | 13,239 |

The first two being **identical** is the finding: `AND` is not an operator here, it is another
term to OR. The quoting effect is small on that query because those words rarely occur apart.

Where they do occur apart it bites. *context relevance answer faithfulness* matched **205**
works; `"answer faithfulness"` matched **65**, with the same paper at the top. A third of the
candidate set, same target.

**The mechanism.** The index ORs bare terms and does not read `AND` as an operator. Only quotes
AND. So quotes survive sanitisation, an unclosed quote is dropped rather than sent, and a query
with more than three unquoted terms is told what the index is about to do with them.

### arXiv ORs its terms too

**Measured.** `all:retrieval augmented generation evaluation` returned **1,174,335** matches,
which is most of arXiv. ANDing the same four terms returned **3,789**. The first number then
became the headline figure that is supposed to make a thin search undeniable.

**The mechanism.** Quoted phrases stay phrases; loose words are ANDed. And per-index counts
are reported separately rather than collapsed into one maximum, because one index answering
nonsense should not poison the number.

### An empty result is information

**The naive move.** Few results, so widen the search and return something.

**Why it is wrong.** An empty title-and-abstract result says *the field does not use these
words*. That is a finding about your vocabulary, and it is exactly the finding that makes a
literature search work. Substituting a looser search returns something and destroys it.

**The mechanism.** Thin stays thin, and says what it means. Widening is opt-in.

### Citations per year, and a band for what has not had time

Raw counts rank a 2015 paper above a 2026 one that matters more. Impact is citations divided
by age. Work too recent to have earned any is shown in its own band rather than buried, since
it has not failed to be cited, it has not had the chance. A work with no year is unrankable
rather than ranked last.

### Unknown is not zero

**The naive move.** `(cited_by or 0) < threshold` for a bulk exclusion rule.

**What happened.** Every row where no index reported a count was swept away, and those were
exactly the preprints enrichment had failed on. The rule dropped what it most needed to keep.

**The mechanism.** A citation rule applies only to rows that have a count, says how many it
left alone, and `--all-remaining` is a separate decision.

---

## The citation graph

### Multiplicity is the signal, not the edge

**The naive move.** Follow references from a good paper. Then follow theirs.

**Why that is not enough.** Following edges gives you reachability. What tells you what a
field is built on is **how many of your seeds point at the same work**. A paper cited by five
of your eight seeds is almost certainly foundational, and a keyword query will not reliably
surface it, because the canon is usually phrased in older words than the papers citing it.

**Measured.** Two hops from a single seed surfaced, from two separate paths, the monograph the
whole line of that work descends from. Three keyword searches over the same subject had not
returned it once.

### Agreement is a share, not a count

**Measured.** With thirteen seeds, the works reached by three of them came back as a 1962 paper
on probability density estimation and four more kernel density classics, presented as the canon
of a subject two decades younger than any of them.

Three of thirteen is 23 percent, and at that level agreement is noise: almost anything adjacent
to machine learning cites a density estimation classic somewhere.

**The mechanism.** Report the share, not the count. Two of thirteen and two of three are not
the same claim.

### An ancestor of everything is not this field's canon

**Measured, same walk.** The second hop's seeds were ranked by multiplicity and then by
citation count, so a work reached by three seeds with **10,593** citations and a **1962** date
led the hop and walked the entire search into statistics.

**The mechanism.** A field's own shared reference is contemporary with the field; an ancestor
of everything nearby is far older. So the tie-break at equal multiplicity is nearness to the
seed set's era, not popularity, and a result more than a dozen years older than the oldest
seed is marked `ancestor?` as a lead rather than filtered out.

**With that changed**, the same seeds returned the subject's founding paper at 3 of 7, its
standard textbook at 2 of 7, and its other founding paper. None of the three had appeared in
any of three keyword searches, which is the point: a canon is usually phrased in older words
than the papers citing it.

**Still weak.** The right discriminator would be lift over a base rate: how much more often
these seeds point at a work than the literature at large does. That needs a base rate nobody
has cheaply. Era proximity is a proxy and it will be wrong for a field whose canon genuinely
is old.

### Depth follows agreement, not everything

Each further hop walks from the works the previous seeds most agreed on. That is what going
deeper means, and it bounds the call count without an arbitrary cut.

### Saturation is the read-enough signal

What fraction of a hop was already reached. Zero percent on hop one and six on hop two says
the literature is not covered. It is a count rather than an impression, and it is the honest
answer to *have I read enough*, which otherwise has none.

### A rate limit is a wait, not a wall

**Measured, by deserving it.** Enough calls in a short window and OpenAlex answers HTTP 429.
The tool reported the index as unreachable and the walk as having closed, which reads as *the
work is not there* rather than *the index said later*.

**The mechanism.** 429 and 503 retry with backoff, honouring `Retry-After`, and if they persist
they say what they are: a quota, clearing in minutes, and a contact email puts you in a
different one. A hop whose calls were refused reports itself as incomplete rather than as
having found nothing.

---

## Identity and provenance

### A bare identifier is a citation

**Measured.** A short note citing three works, every one written as a bare identifier in
running prose: two `arXiv:` ids and one `doi.org` link, no `\cite` anywhere. A guard keyed to
`\cite`, `[@key]` and `@key` reported it **clean**. This is not an unusual style; plenty of
working drafts and internal notes cite exactly this way.

**Why this form matters more, not less.** No bibliography file ever sees a bare identifier, so
nothing else in a normal workflow would catch an invented one.

### A name is a citation

**Measured.** A note attributing three works entirely by author name: *X and colleagues
report*, *Y et al. show*, *Z and colleagues find*. Zero identifiers anywhere. Reported **clean**
again, by a guard that had just been taught about bare identifiers.

**The mechanism.** Four attribution patterns are recognised, and an attributed name with no
resolved reference carrying an author of that name refuses the write.

**Known limit, measured on the same note.** A two-letter surname is missed, because the pattern
requires three characters to avoid firing on ordinary capitalised words. Short surnames are a
real gap and the failure mode is silence.

### Names must fold before they compare

**Measured, immediately after the above.** An index spelled a hyphenated surname with
**U+2010**, and the draft spelled it with an ASCII hyphen. Visually identical, unequal as
bytes, so a work that had been cited correctly was flagged as unsourced.

**Why this direction of error is the one to fear.** A false positive here suppresses a
legitimate citation and teaches people to switch the guard off, and then the real findings
arrive through a channel nobody reads. Names fold over six dash characters, four apostrophes
and combining marks before comparison.

### Exact title match is not enough

**Measured.** Resolving arXiv:1706.03762 by title returned, first, a 2025 stub also titled
*Attention Is All You Need*, ahead of the 2017 paper. Indexes carry duplicate and thin records
under one title.

**The mechanism.** A title match must also fall inside a year window taken from the preprint,
and the most-cited survivor wins. Where the enrichment finds nothing, the record stays the
preprint it is rather than being attached to the wrong work.

### An index's punctuation is syntax

**Measured twice.** A colon in a title returned HTTP 400 rather than the work, which is most
computer science titles. After that was handled by blacklisting a few characters, a title
ending in a question mark did the same.

**The mechanism.** Whitelist, never blacklist. Keep letters, digits, spaces, hyphens and
quotes; everything else becomes a space. And one route is not a route: when the structured
filter refuses, fall back to the plain search endpoint, which parses nothing.

### An OA link can be a picture of the paper

**Measured.** Unpaywall's `best_oa_location` for one Elsevier article was a
`...-fx1_lrg.jpg`, its graphical abstract. Offering an image as a route to the text is a lie.

**The mechanism.** Document URLs are filtered by extension, and every OA location is offered
rather than only the "best" one.

### The preprint is the route to the paywall

**Measured.** A DOI-only Elsevier reference with no open text at the publisher. Unpaywall's
repository locations carried an arXiv id, the arXiv HTML rendering carried **35,305 words**, and
the verbatim quote gate could fire for the first time.

**The mechanism.** Walk the legal routes in order of likelihood of machine-readable text:
preprint copy, Europe PMC full text, OA locations, then `pdftotext` if the machine happens to
have poppler. Where nothing legal has it, the note stays at `abstract` depth and the claim is
capped, which is a state rather than a failure.

---

## What a claim is allowed to say

### Read depth caps claim strength

A paper note records how far you actually got. `abstract` supports *they report X*. `skim`
adds *X holds*. `method` adds *their method shows why*. Only `replicated` supports *this
generalises*.

**Why it works where an instruction does not.** *They report a 12% gain* and *the method gives
a 12% gain* are different strings, and the ledger holds the depth recorded before the claim
existed. A script can decide it. *Be appropriately skeptical* cannot be decided by anything.

**Verified in use.** A mechanism claim from a source read only to `abstract` was refused during
a live literature session, on a sentence that would otherwise have gone into a draft.

### Status is capped by source independence

Warrant asks how you know. Status asks how settled it is in the field. `established` and
`textbook` need two independent author groups, computed by set arithmetic on author
identifiers rather than declared.

**Still weak.** Where a record carries no author identifiers the comparison falls back to
names, and two spellings of one person then read as two independent groups. The claim records
that its independence rests on names, because the arithmetic is not clean there and pretending
otherwise would be the failure this whole tool is about.

---

## Critique, and stopping

### Three kinds of gap, and only two are real

*Something is missing* is three claims wearing one word, and they differ in whether they can
point at something enumerable.

| kind | grounded in | terminates because |
|---|---|---|
| structural | the venue's list of required sections | the checklist is finite |
| evidential | the claim ledger | the claims are enumerable |
| coherence | two locations in the artifact | the pairs are finite |
| **enhancement** | **nothing** | **it never does** |

A finding cites one of the first three or it is inadmissible. No severity intuition required:
a finding either has a referent or it does not.

### The budget is a price, not a ceiling

The failure this addresses: a proposal that went from 12 pages to 24 across three runs, where
the fourth still returned a list.

Suppressing *what is missing* is the opposite failure, so the budget does not forbid additions.
It prices them. Over budget, a real gap is still reported and the fix is a **trade**: name what
gets cut to make room. Nobody trades two working paragraphs for a nice-to-have, so soft
findings collapse under their own price without anyone having to judge them soft.

And the switch from *what is missing* to *what earns its place* is then nobody's judgement
call. It happens when the last real gap closes.

### Zero fatal and zero material is a verdict

With nothing that generates work, the honest recommendation is the positive end of the venue's
scale, and recording anything else is refused. Continuing to produce findings past that point
is pressure rather than rigour.

### A defensible finding closes permanently

A property of the study rather than a defect in it is discharged by one sentence in
Limitations and written to a committed file. Matching is on normalised text, so rewording does
not reopen it. **Verified**: *"one site bounds generality"* discharged, then *"one site, bounds
generality"* refused.

### The draft declares its own boundary, and the tool does not decide it

A plan that survives review states what it deliberately does not cover, with a reason per row,
**in the plan**, where a reviewer will see it. The boundary is read from the draft rather than
kept beside it.

**The design decision worth arguing with.** No textual test can decide whether a suggestion
falls under a boundary row. So the guarantee is **enumeration, not judgement**: a critique
cannot write a finding until the boundary has been read, and a term overlap between a finding
and a row is printed as a lead and never acted on. A wrong match here silences a legitimate
finding.

Two rules stop it becoming a shield. A row that excludes something without saying why refuses
the stop. And the boundary is attackable through a finding whose referent is `scope`, which is
the only way back in: a design decision is reviewable, and what is not reviewable is
re-raising it every round as though it had never been taken.

### The extension detector: growth with nothing closed

Growth is not the signal. A draft that grew while four material findings were fixed is a draft
being worked on, and a detector firing on that would teach people to pad nothing and cut
everything.

Length is sampled per file at the stop and only when the measured state moves, so the series
counts turns rather than keystrokes. Beside it runs a count of `fatal` and `material` findings
actually closed. Three turns of growth with nothing closed is reported with the numbers.

It is a **chosen threshold**, so it reports and never ends a turn.

### Post-hoc is allowed, and labelled

Naming the number that would change your conclusion after seeing the results is legitimate and
common. What is not legitimate is presenting it as confirmatory. So it is refused silently and
allowed with `--post-hoc`, which labels the unit exploratory and carries the label into the
next session.

---

## Harness discipline

### Facts block, chosen thresholds report

A fact is a lookup or a count with no judgement in it. A chosen threshold is a number somebody
picked. Facts refuse the stop; thresholds reach the person and leave the turn alone.

**This was got wrong once**, and the suite caught it: chosen thresholds were exiting 2, which
ends a turn on a number nobody measured. A gate that blocks on judgement gets switched off,
and the good gates go with it.

### Hooks read local state only

A hook that makes a network call hangs a session, so resolution happens in a command the user
ran on purpose and the gates check what it wrote.

### Config merges per key, and an empty value must not win

Two layers: user level for anything that must never reach a commit, project level for the rest.
They merge per key, and an empty value never clobbers a real one from the layer beneath.

**Why that rule exists.** The placeholder `init` wrote silently overrode a user-level contact
email, which took Unpaywall out of the picture and with it the whole route to preprint copies.
The feature failed silently and the gate had nothing to report.

### The durable half has to actually cross the boundary

A killing assumption and a cost estimate, the two decisions an idea rests on, were written to
the ledger and never carried into the next context window. Neither was the screening state,
nor the reason each kept paper was kept.

Writing something down that never comes back is worse than not writing it, because you believe
it is somewhere.

---

## Where this is weakest

Stated plainly, because a list of mechanisms with no weaknesses is a sales document.

- **The severity classes are uncalibrated.** `fatal`, `material`, `defensible` and `taste` rank;
  they do not measure. Calibrating them would take a hundred or two labelled examples and an
  inter-rater agreement measure, and that has not been done.
- **Era proximity is a proxy** for field specificity, and it will misjudge a field whose canon
  genuinely is old.
- **Attribution patterns are four regexes.** They will miss a citation style nobody thought of,
  and the failure mode is silence.
- **Coverage is whatever the public indexes hold**, and it is uneven by field. Operations
  research and pure mathematics index badly. *No such result was found* is a statement about a
  search, and the tool logs the search so the claim can be re-run rather than trusted.
- **Nothing here has been evaluated against a control.** Every measurement above is a
  measurement of a failure, not of an improvement.
