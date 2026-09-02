# Changelog

Versions follow [semantic versioning](https://semver.org). Until `1.0.0` the ledger format
and the CLI surface may change; when they do, the change is listed here with what it breaks.

## 0.2.0

**[evals/](evals/)** runs seven scenarios end to end, one per use case plus the path where the
index refuses to answer, each on a different AI
subject picked at random: speculative decoding, machine unlearning evaluation, mixture-of-experts
routing, watermark robustness, reviewing that proposal, and influence functions at scale. Every
scenario states what must be refused and what must be allowed, because a gate tested in one
direction is not tested.

It found two defects on its first pass. Scope headings were matched as phrases, so a draft headed
*What this does not do* declared a boundary the tool never saw, and a finding that boundary should
have stopped went through: one word, and the whole mechanism was inert. They are patterns now,
pinned by a test. And `close` answered the acceptance question without saying that the stop still
refused, which three scenarios were written wrongly against before the ambiguity was the
explanation.

Everything on the roadmap is built. What changed in this release beyond the features listed
under 0.1.0 is recorded in the entries below; what is worth reading first is new.

**[algorithms/](algorithms/)** collects every mechanism with the measurement that killed
the naive version of it: the query that matched 15,277 works against the one that matched 811,
the citation walk that offered a 1962 statistics paper as the canon of a much younger
field, the guard that
called a document clean while it named sixteen unverified papers and then again while it
attributed five studies by name. It closes with where each mechanism is weakest, because a
list of mechanisms with no weaknesses is a sales document.

**`examples/`** carries three worked fields. The `field.md` files are real; the venue files are
skeletons on purpose, since a checklist invented for a real conference would break the rule
that the tool may not require what it cannot cite a line for.

The marketplace now points at `stable`. Work happens on `main`.

## 0.1.0

### Snowballing, and what closes a frontier

`nullius snowball` walks the citation graph in both directions from the works screened
**in**, rather than from whatever a query returned: backward through what a seed cites,
forward through what cites it, each a single call. Results land in a search log like any
other, carrying how they were reached, and screen the same way.

A `survey` unit cannot close while a work you kept has never been walked. That turns *the
frontier is closed* from a sentence into a count, which is what it needed to be: a keyword
query only ever finds what shares your words. A kept work the index does not carry cannot be
walked at all, and that is reported rather than quietly skipped.

Semantic Scholar adds, where it has parsed the citing paper's full text, the sentence the
citation sits in and whether it was influential. Measured before building on it: contexts
came back for one of four citations of BERT and none of four of ResNet, and intents were
empty throughout. So they are shown when present and never promised, and the tool says so
when a walk returns none.

Found while wiring it: search results never carried the index's work id, so nothing
retrieved could be walked and the frontier check had nothing to see. It failed silently in
both directions at once, which is the shape of bug that survives a green suite.

### The extension detector

The 12-to-24 story, measured. Artifact length is sampled per file at the stop, and only when
the measured state moves, so the series counts turns rather than keystrokes. Beside it runs
a count of `fatal` and `material` findings actually closed with `nullius resolve`, across
every unit the project has run.

Growth on its own is not the signal and the detector says so: a draft that grew while four
material findings were fixed is a draft being worked on. Growth across three turns with
nothing closed is the other thing, and it is reported with the numbers rather than as an
impression.

It is a chosen threshold, so it reports and never ends a turn. Three turns and a quarter of
growth are numbers somebody picked, and the tool says which of its reasons are like that.

`nullius findings` lists what a unit has found and what closed; `nullius resolve <n> "<what
changed>"` closes one. Until this existed there was nothing to count, which is why the
detector could not have been built before the critique gate was.

### A draft can declare its own scope boundary

`nullius scope` reads what the draft rules out from the draft itself, out of a markdown
list, a pipe table or a LaTeX `tabular`, with the reason each row carries. The symmetry with
the venue file is the point: the tool may not require what the venue does not ask for, and
it may not dismiss what the draft does not itself rule out. Neither list belongs to the tool.

A critique unit cannot write a finding until the boundary has been read, and cannot close
without it. That is enumeration rather than judgement, for the same reason the completeness
walk is: no textual test decides whether a suggestion falls under a boundary row, and a
wrong match here silences a legitimate finding, which is the direction of error worth
avoiding. A term overlap is reported as a lead and never acted on.

Two rules keep the boundary from being a shield. A row that excludes something without
saying why is a fact and refuses the stop. And the boundary is attackable through a finding
whose referent is `scope`, which is the only way back in: a design decision is reviewable,
and what is not reviewable is re-raising it every round as though it had never been taken.

Found by reading a real plan's `What this study does not do` section, which is a LaTeX table
whose column spec `{@{}L{4.8cm}L{10.0cm}@{}}` a regex stopping at the first closing brace
handed back as if it were the first row.

### interpret and critique are gated

Two kinds that had been guidance are now checks.

**`interpret`** turns on the ordering. The observation that would change your conclusion
has to be named before the results are opened (`nullius decisive`), and what was actually
seen has to be recorded against it (`nullius reading`). Naming it after the results is
legitimate and common, so it is not forbidden: it is refused silently and allowed with
`--post-hoc`, which labels the unit exploratory and carries that label into the next
session. What cannot happen is a prediction quietly written after the fact.

**`critique`** has to add up to something.

- Every finding cites a referent, one of `structural`, `evidential` or `coherence`, and
  carries a locator. A finding citing none of the three is *enhancement*, which is true
  of every text ever written and is the one kind that never runs out.
- A `defensible` finding is discharged with one sentence in Limitations and written to
  `discharged.md`, which is project-level and committed. It cannot be raised again, and
  the match is on normalised text, so rewording it does not get it back in.
- A verdict is required, from the scale the venue file names rather than one of ours.
- **Zero fatal and zero material findings means the verdict is the positive end of the
  scale**, and recording anything else is refused. With nothing that generates work,
  continuing to produce findings is pressure rather than rigour. This is the mechanism
  the whole calibration argument was for.
- A critique unit that tracks no artifact is reviewing nothing, and says so.

Section dispositions moved from the unit to the project, keyed by venue and section. Kept
on the unit, every new unit re-asked a question that had already been answered, which is
how a gate becomes noise and then gets switched off.

### Found by doing the research, not by inspecting a document

Ran a genuine session end to end: an open question, three vocabularies, screening, and
an idea unit taken to close. Five defects, and the first is the worst
thing in this repository so far.

- **the per-kind acceptance rules were prose that could not fail.** The vocabulary
  injected into every session says an `idea` unit needs a dispositioned neighbour set,
  a named killing assumption and a cost estimate, and that an empty neighbour set is
  refused. `nullius accept "vibes"` was accepted. The tool was committing, in its own
  documentation, the exact failure it exists to replace. Those three are enforced now,
  and the vocabulary marks which kinds are gated and which only shape what `accept`
  should say.
- **relevance and impact were the same knob, and impact won.** The search asked OpenAlex
  to sort its whole matching corpus by citation count, so what came back was the
  most-cited work
  sharing any term with the query. Relevance gates now; citations per year order what
  got through.
- **full-text search dilutes.** The same intent matched 15,277 works through OpenAlex's
  `search` and 811 through title and abstract, and only the second set was about the
  subject. Title and abstract is the route now, and the loose one is opt-in.
- **`all:a b c` ORs its terms**, so arXiv answered a four-word question with 2,060,445
  matches, and that figure then became the headline number that is supposed to make a
  thin search undeniable. Terms are ANDed, and per-index counts are reported separately
  rather than collapsed into one maximum.
- **the durable half was not durable.** A killing assumption and a cost estimate, the
  two decisions an idea actually rests on, were written to the ledger and never carried
  across a context boundary. Neither was the screening state, nor why each kept paper
  was kept. All of it crosses now, which is the only reason to have written it down.

Also: a query of more than seven words is now called out as prose rather than a query,
and two records of one work under different DOIs no longer both survive de-duplication.

### Found by running it against a real proposal

A real plan of some length, naming sixteen arXiv papers. Three defects, one of them in
the tool's single most important job:

- **a bare identifier is a citation, and the guard did not know it.** The document
  carries not one `\cite`; every reference is written as a bare `arXiv:` id in running
  prose. `nullius check` reported it **clean**. Bare arXiv ids, DOIs and doi.org links
  are now resolved and gated exactly like a citekey, which matters more than the keyed
  form: no bibliography file ever sees a bare identifier, so nothing else would have
  caught an invented one. Fifteen of the sixteen resolved; the sixteenth found the next
  bug.
- **punctuation in a title was still breaking resolution.** The escaping blacklisted a
  handful of operator characters, so the next one nobody thought of still returned HTTP
  400: a question mark, at the end of a title. It whitelists now, and falls back to the plain search endpoint when the
  structured filter refuses, because one route is not a route.
- **tracking a draft and counting it were one list.** Adding the positioning file so the
  walk could find its Related Work section pushed the paper over the venue's word limit,
  although that file is not part of the submission. `--excluded` separates the two:
  searched by the walk, outside the limit. Venue files already had a line for what the
  limit excludes; the code did not.

And one in the test suite itself, which is worse than a bug in the tool: `set -o pipefail`
made every `grep` assertion against a command that intentionally exits non-zero report a
false failure. A harness that lies is worse than no harness.

### Found by reviewing the first cut

Seven defects, each fixed and pinned by a test:

- a citation-count rule swept away rows **no index reported a count for**. Unknown is not
  zero, and the rows it dropped were exactly the preprints enrichment had missed
- a declared word budget with no tracked draft measured zero and reported *finishable*: a
  gate that looks like it is working and is not. It now refuses and names the omission
- `found` had come to mean *retrieved*, which destroyed the one number that makes a thin
  search undeniable. Index totals and retrieval are reported separately again
- a work with no publication year sank to the bottom of the ranking as though it had no
  impact, rather than being unrankable
- an index's "best open-access location" is sometimes the graphical abstract, and offering
  a JPEG as a route to the text is a lie
- OpenAlex reads `:` as a filter operator, so every title carrying a colon, most of them
  in this field, returned HTTP 400 instead of the work
- `threads/` was promised by the documentation and written by nothing. `nullius thread`
  exists now, and the session gate surfaces open ones

Also: the acceptance locator rule refused *"stated in the Methods section"* and *"§3.1"*,
which are locators; it now takes a named part of a paper and still refuses "yes it is". And
a status reached through author **names** rather than identifiers is flagged on the claim:
two spellings of one person read as two independent groups, which is weaker than the label
suggests.

First working version. Installable as a Claude Code plugin; nothing to install beyond
Python 3.

### The venue completeness walk

`venues/<venue>.md` lists required sections, one per line, with aliases and a per-section
minimum. Every entry is walked on every check -- present, thin or absent -- and a structural
finding cites the line in that file it comes from, so the tool cannot require anything the
venue does not.

What blocks is **not** an absent section. A section can live inside another one without its
own heading and no textual test separates that from an omission, so the guarantee is
enumeration rather than completeness: an absence must carry one word about it
(`planned`, `elsewhere`, `n/a`) before the unit closes. What you do about it stays yours;
what the tool refuses is letting the list go unlooked-at.

Thin is a word count against a threshold the venue file sets, so it is reported and never
enforced. A declared venue with no file is a fact and blocks -- without the file nothing can
be required and nothing checked.

The word budget is read from the venue file at check time rather than copied when the unit
opens, so editing the limit moves every unit that targets it instead of leaving a stale
snapshot.

### Configuration has two layers

`contact` lives in `~/.config/nullius/config.json`, outside every repository, because a
project's `config.json` is meant to be committed and an email placed there leaks on the
first push. Anything else goes there with `--user`.

The layers merge per key, and an empty value never clobbers a real one from the layer
beneath -- the placeholder `init` used to write silently overrode a user-level email, which
took Unpaywall out of the picture and with it the whole route to preprint copies.

What the email is for, measured rather than asserted: Unpaywall returns **HTTP 422** without
one, and OpenAlex and Crossref use it for their polite pool. It is not a login, no account
is created, and it grants no access to anything paywalled.

### Gates that refuse

- an unresolved or retracted citation cannot reach a draft: the write itself is refused
- a claim may not exceed the read depth recorded for its source
- `established` and `textbook` need two independent author groups, computed from author
  identifiers rather than declared
- a source kind the indexes do not carry caps how settled a claim it can support
- a survey unit cannot close on an unscreened result
- an over-budget addition must name what it costs
- the acceptance question must be declared, and closed with a locator

### Reported, and marked as chosen

Vocabulary breadth, single-source claims, thin source independence. These reach the person
through `systemMessage` and never end a turn, because a number nobody measured does not get to
block work.

### The literature spine

- multi-index search across OpenAlex, arXiv and Europe PMC, merged and de-duplicated
- ranked by citations per year rather than raw citations, with work too new to have earned
  any shown in its own band
- bulk screening by a recorded rule, so an exclusion criterion is one line a reader can
  disagree with rather than forty judgements
- resolution by whichever index has the work: Crossref for authoritative metadata and
  retraction notices, OpenAlex for the author identifiers that make independence
  computable, arXiv for preprints
- sources no index carries: documentation, blogs, books, chapters, theses, datasets, talks
- `fulltext` walks the legal routes, finds preprint copies of paywalled work, and caches
  machine-readable text where one exists, which is what lets `quote` check a quotation
  verbatim

### Known limits

The severity classes are uncalibrated. The venue completeness walk, the gap kinds and the
extension detector are designed but not built. Snowballing is not implemented. Coverage is
whatever the public indexes have, and it is uneven by field.
