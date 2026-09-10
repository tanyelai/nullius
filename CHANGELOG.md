# Changelog

Versions follow [semantic versioning](https://semver.org). Until `1.0.0` the ledger format
and the CLI surface may change; when they do, the change is listed here with what it breaks.

## 0.6.0

**A thread, a lifecycle, and a channel that leads with the answer.**

Four independent reviews, each with a clean context and one lens, went at this repository
against the standard it sets for itself. Two returned `dies`. What follows is what they
found and what it cost to fix. Every claim below was verified against the code before it
was acted on, including the two that turned out to be false statements in the documentation.

- **A thread is a first-class key.** `start --thread <name>` scopes a line of enquiry, and
  every search and claim written under it is stamped. The gates then read that thread and no
  other. Unfiltered, one search logged in March satisfied "silence is a failed search" for
  every idea unit after it, and one failed vocabulary blocked every unrelated idea after
  that; verified in an isolated project, a brand-new `idea` unit with zero references and
  zero claims reported finishable. Records written before threads existed read as `main`, so
  nothing migrates.
- **Surfacing is a lifecycle query, not the whole ledger.** Storage and surfacing were one
  decision, so the only way to read less was to record less. A driven project with 40
  finished searches emitted 3,796 words at every SessionStart and one with 80 emitted 8,116,
  because the cap on kept works was per search and not across them. Now a search recites its
  rows only while something is unscreened, a buried idea is named when it shares a term with
  the question and **counted** when it does not, and the same 40-search ledger emits 2,223
  words. Twelve buried ideas used to arrive as eight with nothing saying four were missing.
- **`compact`**, the only thing here that deletes, and it deletes only what can be rebuilt:
  cached full text and growth samples outside the detector's window. Not a claim, a finding,
  a screening decision or a buried idea, and no flag will.
- **The gate leads with the state and `status --why` has the reasoning.** A stop that
  emitted around 400 words now emits 71. The reasoning is written for the model, which
  chooses its next action from it; a person reading six refusals wants the six states. This
  is `voice.md` applied to the tool's own output for the first time: it budgeted the draft
  and never itself.
- **A file the unit does not track is a scratch note.** The write gate fired on any `.md` in
  the project, so `Vaswani et al. say otherwise, check later` in a thinking file exited 2 and
  you could not keep one. An invented identifier is still refused there; an unattributed
  surname is now a lead, which is the call `check_artifact` already made for companions and
  for the same reason.
- **`note --quote` grounds a read depth in the source.** `strength <= depth` is the flagship
  cap and both sides of it were typed by whoever was at the keyboard. A passage checked
  verbatim against the cached text settles it instead, and every claim records whether its
  depth came from the source or from the session. WHY.md section 1 gains the row the motto
  never had: not the author's word, not the field's, not yours, but whoever is typing.
- **`start --force` archives the unit it displaces.** It used to write straight over the top,
  so findings, points, alternatives and the accept answer went with it, and
  `closed_work_count` reads that log, so the growth detector then miscounted for every unit
  after.
- **Three false statements in the documentation.** WHY.md said "no prompt prepended" while
  `hook_session_start` prepends five prose files and a command reference. It said the
  read-depth cap works because the difference is textual and a script can decide it; no
  script here reads either sentence. And `falsify` told the user its record was "injected
  before a write", which it never was: `falsified.md` is read at session start only.
- **A generated binary was in the tree.** The tests import `bin/nullius` as a module to unit
  test one function, which writes a 300kB `.pyc` beside it, and `git add -A` put one in
  0.5.1. Untracked, ignored, prevented at the source with `PYTHONDONTWRITEBYTECODE`, and
  preflight now refuses it, since the repository's rule about figures applies to everything.
- **A `reader` agent, and two lenses rather than a second critic.** An elegance agent was
  designed and then mostly declined: `parsimony` (which parts could be deleted and the claim
  still hold) and `baseline` (what is the simplest thing that would also produce this) are
  lenses, and the `skeptic` is a lens-taking agent, so they are two rows in its table rather
  than a new file. Both are told that the honest answer is usually that it is fine, because
  anything can be described as having one part too many and a critic that can always find
  something has stopped being one. The `novelty` lens now reads the search log before forming
  a view; a judgement about a literature made without looking at what was searched for is the
  impression this tool is built against.
  `reader` is the genuinely missing one: it reads a single source at `brief`, `working` or
  `full` depth and returns what the source establishes, what it does not, and what could not
  be accounted for. It looks like it breaks the `librarian`'s prohibition on summarising and
  does not -- that rule is about a *set* of works, where a summary hides how thin the set
  was. Every point here carries a passage the agent has run `nullius quote` on before
  returning it, so a fabricated point cannot produce one that verifies, and with no cached
  text it refuses to start.
- **A draft does not go out unread.** A `critique` unit has always had to produce a verdict
  and a `write` unit never had to receive one, so a draft could reach the end read by
  nobody. Every piece of the oldest gate in science was already here -- located findings, a
  venue scale, three agents that start in a clean context and do not know whose draft it is
  -- and nothing joined them: the enforced half was arithmetic, the smart half was advice,
  and section 3 of WHY.md says what happens to advice. A write unit **that names a venue**
  now does not close while a tracked draft has no recommendation on it. Naming a venue is
  the act of saying this goes out; a unit without one is drafting, and firing on every write
  unit would tax thinking. The tool never reads the recommendation -- a `rework` closes the
  unit exactly as an `accept` does -- so this requires a judgement without depending on one,
  which is the venue walk one level up. `verdict --by` records who read it, a verdict with
  no reader named is reported as the session's own verdict on its own draft, and
  `unread "<why>"` is the way past, recorded and travelling.
- **`prose`, because the failure is repetition and not length.** A long document with
  nothing repeated is fine; a short one making its point three ways is not, and that is what
  a model does and a person does not. Three signals, all counts: passage pairs sharing most
  of their content words (containment rather than overlap, because the failure is a point
  restated *more briefly* elsewhere), a document past a threshold with no figure, table or
  diagram at all, and one with no summary and no short opening paragraph. Every one is a
  lead and none refuses: two paragraphs on one subject legitimately share vocabulary, and a
  tool that deleted the second would be editing rather than checking. They reach the stop
  through the channel marked chosen. `voice.md` is rewritten around saying a thing once,
  giving the reader a way in and a way out, and using a figure when the thing has a shape.
- **A tracked draft has to say how long it may be.** A declared budget with no draft
  tracked against it has been a fact this refuses since the first release; its mirror was
  missing, so a tracked draft with no declared length had no length it could exceed and
  nothing could notice an eight-hundred-word answer arriving at four thousand. Three places
  satisfy it -- the unit, the venue file, or `config default_words` as the house norm -- and
  the tool never picks the number, because a default it chose would be the tool deciding how
  long your work is. What it refuses is for nobody to have decided, which is the acceptance
  question and the killing assumption again. Every write to a counted draft now also says
  where it puts you rather than waiting for the stop.
- **Five defects a fifth review found in the four changes above**, before any of it
  shipped. Grounding survived a depth change, so `--depth abstract --quote "..."` then
  `--depth replicated` produced a claim recording that the source attested a depth nothing
  had checked, which is the exact narrator the feature exists to name. Session start stopped
  showing kept works precisely while screening was unfinished, because the fallback tested
  whether any search was live rather than whether there was anything to show. Screening a
  search logged before threads existed relabelled it onto whatever thread was open, which is
  the rewriting-under-you that reading an absent thread as `main` exists to avoid. A tracked
  draft written as `./draft.md` compared unequal to `draft.md` and quietly became a scratch
  note. And `terse` cut at the first period, so a work titled *Scaling laws vs. emergent
  abilities* ended a sentence at "vs."
- **Section 11 is rewritten.** It declined the AI-Scientist programme outright on grounds
  that turned out to be a prospect-driven survey of what that programme still needs, plus a
  second work carried by bare title with no identifier anywhere in the repository. The
  position now turns on what is actually true: an unattended run is tolerable in proportion
  to how checkable its output is.

## 0.5.1

**A refusal that arrived as a stack trace, and the command that found it.**

0.5.0 shipped with this and 0.4.0 had it too. It is the headline path, so this is a patch
release rather than something to fold into the next one.

- **An invented DOI raised instead of refusing, and it shipped in 0.4.0.** Crossref and
  OpenAlex both answering empty is the case for every fabricated identifier, and the merge of
  their two answers guarded each one-sided case and fell through both into `dict(None)`. So
  the one refusal this tool is named for arrived as a `TypeError` rather than as the sentence
  that explains what to do about it. Nothing caught it because the suite is offline and never
  resolves, and the live scenarios only ever asked for identifiers that exist:
  [both directions](algorithms/provenance.md) had never been applied to the network path.
  Eval 03 now asks for both.
- **`audit`.** Resolves every identifier a document names against the live indexes, counts
  what came back, and needs no project. `check` audits a draft against a ledger; this audits
  a document that never had one, which is what
  [evals/control.md](evals/control.md) needs to score three arms the same way. Three buckets,
  not two: an index that refuses is not an index that has nothing. It reads PDFs where
  poppler is installed, and it is what turned up the defect above.

## 0.5.0

**The third answer, and a gate that only ever passed.**

- **`needs` and `settled`.** Not knowing had nowhere to go. Every way of saying it here was a
  singleton or free text: one `accept` per unit, one `kills` per idea, one `decisive` per
  interpretation, threads nobody counts, and a `skeptic` verdict with no ledger state to land
  in. `nullius needs "<the observation that would settle it>"` is countable, outlives the unit
  that found it, and arrives at every session start until it is `observed`, `unmet` or
  `carried`. A unit does not close on one it opened and never came back to. An open one is
  fine, and `carried` is how you say so.
- **`--warrant assumed` names the mechanism.** It was refused and redirected to a free-text
  thread file, which is a place things go rather than a place things come back from.
- **The pre-write gate crashed on every clean write.** A duplicated attribution block
  referenced two names that were not bound in that scope, and it sat after the refusal had
  already been decided, so it could only ever raise. `cmd_hook` catches everything and exits 0
  so a broken gate cannot wedge a session, which meant the suite's `expect_hook pre-write 0`
  passed on a gate that was doing nothing. The read-depth note the PreToolUse hook is
  documented to inject had therefore never once fired. Tests now assert the third direction:
  not refused, and not silent either.
- **A softer mode is gentler, not quieter.** Any `mode` outside `certain|block` skipped the
  refusal and dropped the reasons with it, so a project in a soft mode heard less than a
  strict one. The facts now go out through `systemMessage` and `additionalContext` instead.
- **Three directions, not two.** A gate is tested for what it refuses, what it allows, and
  now for whether it did anything on the allowing path. `expect_hook` fails on a raised gate
  whatever the exit code, and `expect_hook_out` checks what a hook said. One `NameError`
  injected into `hook_stop` now turns 25 assertions red instead of almost none.
- **The channel nothing was watching.** Five assertions covered the state block SessionStart
  prints and none covered the two things it exists to carry. The invariants directory could
  have gone missing and the hook would have gone on exiting 0 with a state summary and no
  rules attached. Both are asserted now, along with the silence cases: a non-draft and a
  harmless shell command must draw no comment at all.
- **[algorithms/loops.md](algorithms/loops.md).** What may end a loop, and why an exit the
  model computes is not one.
- **The gates figure enumerates the stop's facts, and had gone one short.** The front door
  drew five and there are six. Camo keys its cache on the URL, so the README link moves to
  `?v=3` or a changed diagram at an unchanged path goes on serving the old one.
- **[evals/control.md](evals/control.md).** The arm this repository has never run: the same
  advice, enforced against not enforced. It needs real sessions, so it is a protocol rather
  than a scenario, and it names the one instrument still missing to run it.

## 0.4.0

**Seven gates, against two defect classes the first six did not cover.**

The first is a correction that does not travel. A claim is falsified in the ledger and the
sentence it condemned stays in the draft, because words do not change themselves. The same
wording survives wherever else the draft says it, and `check` reports clean throughout when
that elsewhere is a file it was never pointed at: figure sources, a template, anything whose
text reaches the reader without carrying a draft's extension.

The second is a screen that fails quietly. A query returns nothing and the nothing is read as
a statement about the literature rather than about the words; a work is excluded on a search
the tool itself called a vocabulary failure; an idea is called open on titles and abstracts.

- **Pinned wording.** A `fatal` or `material` finding usually quotes the sentence it condemns.
  That quote is now pinned, and the draft does not pass while it still contains it.
- **Companions.** `artifact <draft> --includes <path>` declares files whose text reaches the
  reader through the draft. Checked with it whatever the extension. A name in a shared asset
  may belong to another draft, so an unresolved name there is reported rather than refused.
- **Staleness.** `falsify` marks every tracked draft unchecked, and the unit does not close
  until each has been read again.
- **The shell.** `PreToolUse` matches `Bash` as well as `Write|Edit`. A quoted heredoc carries
  its own body and is checked exactly like a write; a redirect a program fills cannot be, and
  is reported instead of refused.
- **`considered`.** `decisions.md` shipped from the first release and nothing ever wrote to it.
  Now there is a command, and an `idea` unit does not close without an alternative on the
  record.
- **A tight zero is not a zero.** A query that returned nothing over title and abstract and was
  never re-run with `--loose` is refused as evidence. Full text reaches work that shares no
  vocabulary with the query, which is exactly the neighbour a tight zero hides.
- **A failed vocabulary is not a screen.** Works excluded on a search the tool itself called a
  finding about the vocabulary are refused. `screen ... unknown` is the third answer.
- **An impression is not a reading.** An `idea` unit where nothing was read past `abstract` is
  refused, and `coverage` now separates resolved from opened.

Nothing in the ledger format changed, so a `0.3.0` project keeps working; units opened before
this release will meet the new gates when they next try to close.

## 0.3.0

**A release channel.** The marketplace entry was a relative source, which serves whatever the
default branch holds, so every commit to `main` was a publish and the `stable` branch
guaranteed nothing. The plugin is now pinned to `ref: stable`, and that branch moves only when
a release is dispatched and a maintainer approves it. Two rules on the branch, verified by
attempting both, refuse a force-push and a deletion with no bypass for anyone.

This matters more than the plumbing suggests. Claude Code resolves a plugin's version from
`plugin.json` and skips the update when the string has not changed, so with an unpinned source
two people both on `0.2.0` could be running different trees with no way to tell. A version that
does not identify the content is the kind of claim this tool refuses in a draft.

**One gate, in one file.** [`tests/preflight.sh`](tests/preflight.sh) runs the suite, the
official `claude plugin validate --strict` on both manifests, and the structural checks; CI
runs that same file rather than a second list, so local and CI cannot drift apart on what
passing means. Every check in it comes from a defect this repo actually shipped.

It found two on its first run. Four em dashes in `algorithms/README.md` and two in
`bin/nullius`, while the hand-run `grep` used to check for them had been reporting a clean tree
for a week: BSD grep was silently failing to match the multibyte alternation. The pair in
`bin/nullius` are the dash-folding table, which has to contain those codepoints, so they are
escapes now, which leaves the check with no exception and therefore no hole.

**A working fallback left no trace.** A rate limit that ended in an error row was always
visible. One the Semantic Scholar fallback absorbed produced ordinary-looking rows while the
walk's log header carried a literal `"indexes": ["openalex"], "unreachable": []` written before
any fallback existed. Eighteen rows arrived through Semantic Scholar and the log said OpenAlex
answered, which `coverage` then reported as the funnel's provenance. The header is derived from
what answered now, the refusal travels as data rather than as prose inside an error string, and
a substitution prints once for the run. It survived because eval 07 required exactly this and
checked the wrong handle: provenance on the walk's rows, and the header on `lit`'s log.

**Five figures**, in [assets/](assets/): where the harness intervenes and the two channels out
of the stop gate, the two independent caps on a claim, a real search as a funnel, the three
refusals that let a critique close, and what leads a citation walk. Hand-written SVG, 40 KB for
the set, and the funnel reports a real run rather than an illustrative shape.

**The README stopped restating WHY.md.** Measured before cutting: the section named after
WHY.md's "why more instructions do not fix it" shared 86% of its six-word sequences with it,
"where this came from" 74%, "what this is not" 70%. 545 lines to 337. The thirty-six-row command
table, which had already gone stale, is five rows grouped by what you are doing, and `--help`
is the reference.

## 0.2.0

**[evals/](evals/)** runs seven scenarios end to end, one per use case plus the path where the
index refuses to answer, each on a different AI
subject picked at random: speculative decoding, machine unlearning evaluation, mixture-of-experts
routing, watermark robustness, reviewing the proposal scenario 04 wrote, and influence
functions at scale. Every
scenario states what must be refused and what must be allowed, because a gate tested in one
direction is not tested.

It found two defects on its first pass. Scope headings were matched as phrases, so a draft headed
*What this does not do* declared a boundary the tool never saw, and a finding that boundary should
have stopped went through: one word, and the whole mechanism was inert. They are patterns now,
pinned by a test. And `close` answered the acceptance question without saying that the stop still
refused, which three scenarios were written wrongly against before the ambiguity was the
explanation.

Nothing designed for this release is left stubbed. What changed beyond the features listed
under 0.1.0 is in the entries below; what is worth reading first is new.

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
