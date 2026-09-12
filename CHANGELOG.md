# Changelog

Versions follow [semantic versioning](https://semver.org). Until `1.0.0` the ledger format
and the CLI surface may change; when they do, the change is listed here with what it breaks.

## Unreleased

- **The gate says where you are and what to do, before what is wrong.** It listed the facts
  refusing and left the reader to work out which command answered the first one, and whether
  anything had moved since the last time. Every fact already names its command, so the first
  is lifted to the front; the unit, its thread, what is open and what has closed go on the
  line above. Six refusals went from eight lines to four. `status` opens with the same two.
  Three rules in `voice.md` follow: lead with what can be done rather than only with what is
  known, say where they are before saying what is wrong, and name what has closed without
  celebrating it -- a rigour tool that starts handing out congratulations has changed what
  it measures.

  The shape is adapted from [i-have-adhd](https://github.com/ayghri/i-have-adhd) by ayghri (MIT),
  which argues that knowing an answer and doing it are different and that the gap between
  them is where work stops. The clinical framing is not borrowed: what transfers is that
  state a reader is assumed to be carrying is state they are not carrying, which is this
  repository's own argument about context boundaries, pointed at the person instead of the
  model.

## 0.8.2

**A door.**

Measured against the published guidance for what a Claude Code plugin is -- skills, slash
commands, subagents, hooks -- this one shipped two of four, and the consequence was testable:
plugin installed, folder without a `.nullius/`, **SessionStart emitted zero characters.** The
whole vocabulary arrived only after a project existed, and creating one required already
knowing the command. It worked in practice because a user types *set up nullius* and the
model reasons its way there, which is luck rather than design.

- **`skills/nullius/SKILL.md`.** Fires on setting the harness up and on the work it gates:
  is this idea already published, cover this literature, read this paper, resolve this
  citation, draft against this venue, review this draft, interpret this result. Sixty lines.
  It does not restate the command vocabulary, which SessionStart already injects inside a
  project; what it carries is the part a session cannot get anywhere else -- the `init` path
  from `CLAUDE_PLUGIN_ROOT`, the two files only the user can write, and which unit kind fits
  which question.
- **The README promised a `/nullius` slash command that has never existed.** Six reviews
  today went past that line. It now says what is actually there.

Still two of four: there is no slash command, because the skill covers discovery and a
command to reprint a vocabulary already injected would earn nothing.

## 0.8.1

**One mistyped letter turned every gate off.**

- **`mode` is an enum of two, validated.** `mode` was a free string where `certain` was
  magic and anything else silently behaved as report-only, with no validation anywhere:
  `nullius config mode certian` was accepted and the stop gate went from exit 2 to exit 0
  without a word. It is an enum of two now, `certain` and `advice`, and a session in `advice`
  is told so at every start, because otherwise it believes it is being gated and is not.
  Found by being asked why a harness needs a mode setting if there is only one mode. There
  were two; the count in the 0.8.0 notes was of code sites, not modes, and was wrong.

## 0.8.0

**Two broken agents, an eval record that read a failure as green, and a third less prose.**

### The prose

- **`invariants/*.md`: 1,933 -> 1,158 words.** Every rule survives -- the bold rules were
  diffed before and after, 39 in and 39 out, and the one genuine loss, *a reviewer-proof
  paper does not exist*, was restored. What went is the argument around each rule, which
  `WHY.md` and `algorithms/` already carry. All four tables stay: they are the vocabulary,
  not prose. `voice.md` lost most (560 -> 262) and had been injecting a reference to `prose`,
  a command deleted two hours earlier. **SessionStart on an empty project: 2,569 -> 1,794
  words**, below where the day started.
- **README: 4,841 -> 2,542 words, twenty minutes to eleven.** Twelve sections argued for one
  mechanism each. They are one table of what refuses and one paragraph of what reports; the
  arguments were already in `WHY.md` and `algorithms/`.
- **CHANGELOG: two entries at 1,413 and 811 words** against a historical median near 430. A
  changelog says what changed and why it was wrong before; those re-argued the design.
- **`paragraphs()` treated a figure's alt text as prose.** The 82-word alt text atop this
  README counted as its opening paragraph, so `check` called the file *no short version at
  the top* when its first sentence is thirty words. It also inflated the cross-file
  duplication count used to argue for this cut: **34 pairs measured, 11 real**. The headline
  number was partly an artifact of the instrument that produced it.
- **Also cut:** `WHY.md` section 12, which was credentials and a build order; section 5's
  table, which is `warrant.md`'s; `algorithms/README.md`'s prose, which was `CONTRIBUTING`'s;
  `examples/README.md`'s account of files that no longer exist; and
  `evals/results/06-2026-09-02.md`, which held two runs concatenated with a failure first.

Repository prose: 43,974 -> 39,341 words.

### The machinery

A second pair of clean-context reviews, one on the prose and one on everything that is not
`bin/nullius`. The prose one measured what the tool's own repetition detector found when
pointed at the repository for the first time: 34 cross-file paragraph pairs sharing half
their content words or more, and a README that `check` reads as 4,568 words, twenty minutes,
no short version at the top.

- **`agents/referee.md` mandated `major-revision` and `minor-revision`.** `DEFAULT_SCALE` is
  `desk-reject / major / minor / accept`, so an agent obeying its own file was refused by
  `nullius verdict` on every review. It now names the venue file's scale, which the same file
  said two paragraphs earlier.
- **`agents/librarian.md` had the `screen` arguments in the wrong order**, documenting
  `screen <search> <index> <include|exclude>` where the index is a flag. An agent following it
  failed on every screening call.
- **The eval runner never truncated its output file.** `tee -a` into a name keyed on the date
  means a same-day re-run concatenates, and `results/06-2026-09-02.md` is two runs in one
  file: the first ends `| 8 | 1 | 0 |` with a gate that should have refused and did not, the
  second ends `| 9 | 0 | 0 |`. A reader taking the last table read a failed run as green.
- **The bytecode check added this morning reported an untruth.** It said *tracked* and
  globbed the working tree, so an untracked, gitignored `.pyc` turned preflight red on a
  clean repository. That is the `5 passed, 1 failed` seen earlier today and waved away as
  transient. It was not transient. It reads `git ls-files` now.
- **Three byte-identical venue skeletons, and two duplicate eval results.** The three
  `examples/*/venues/EXAMPLE.md` had the same md5 as each other and as `templates/venue.md`,
  which `init` already writes, so copying a worked field into a project overwrote a copy of
  itself. `results/04-` and `05-2026-09-10.md` differed from their 09-02 twins by a timestamp
  and one citation count.
- **`examples/README.md` claimed index presets `init` does not pick.** True for
  `clinical-ml`, false for the other two: `FIELD_INDEXES` has no key matching *language
  models* or *social science*.
- **About 900 words of restated argument.** WHY.md section 6 was `invariants/status.md` with
  the column headers reworded, and section 7's boundary subsection was the third telling of
  what `algorithms/critique.md` carries with its parse schema. The injected files are
  canonical because they are the copy a session actually sees. The duplication was not only
  bloat: today's correction to the folklore claim reached two of the four places it was
  stated, and section 6 was still describing a citation walk that does not exist.
- **The README's `Where the rest of it is` section** opened by saying nothing is summarised
  back here and then summarised five files for thirty-five lines.

**A finding checked and rejected.** The machinery review reported that `PostCompact` is not a
Claude Code hook event and that the entry in `hooks/hooks.json` is inert. It is a valid event,
per the official documentation, and it fires. The constraint re-injection that
[REFERENCES.md](REFERENCES.md) cites `chen2026` for does happen. Acting on that finding
unchecked would have deleted a working mechanism, which is the whole argument for checking.

## 0.7.0

**A cut, four claims that were not true, and one agent.**

Two reviews with a lens nobody had applied: what does not earn its place, and do the pieces
agree. Both put `mode block` first.

- **Cut:** `mode block`, undocumented and untested, whose one behaviour made chosen
  thresholds refuse the stop -- the mistake `harness.md` records making once already.
  `explain`, which appeared in one place and no gate branched on. `referee` as a unit kind,
  handled identically to `critique` and colliding with the agent's name. `prose`, four hours
  old and 85% of `check`. The single-source signal, which fired on nearly every claim and
  reported what the independence arithmetic already refused. `budget_overrun_ratio` and
  `terms.md`, each with one occurrence: their own definitions.
- **Four claims the code did not support.** The folklore walk is described in three sections
  of WHY.md and nothing has ever walked a citation trail. A finding's locator is stored and
  printed, never resolved, so the termination guarantee is that admissible kinds are finite.
  `program.md` is read by nothing. `done --force` was the one way past a gate needing no
  sentence.
- **`reader`, and two lenses rather than a second agent.** An elegance critic was designed
  with six lenses and mostly declined: five duplicated existing lenses or were aspirations
  rather than failure modes. `parsimony` and `baseline` are rows in the `skeptic`'s table.
  A uniqueness agent was declined outright: whether something has been done is retrieval and
  the `idea` unit already does it against identifiers that resolve. `reader` explains one
  source at `brief`, `working` or `full`, every point carrying a passage it has run
  `nullius quote` on, and refuses to start without cached text.
- **A release can be pinned to the commit approved.** 0.6.0 was dispatched at one commit and
  released three later, because approval happens before any step runs.

## 0.6.0

**A thread, a lifecycle, a channel that leads with the answer, and three false claims.**

Four clean-context reviews, one lens each, went at this repository against the standard it
sets for itself. Two returned `dies`.

- **`--thread <name>` scopes a line of enquiry.** Searches and claims are stamped with it and
  the gates read only that thread. Unfiltered, one search in March satisfied *silence is a
  failed search* for every idea unit after it, and a brand-new `idea` unit with zero
  references reported finishable. Records written before threads read as `main`.
- **Surfacing is a lifecycle query.** Storage and surfacing were one decision, so the only
  way to read less was to record less. Forty finished searches emitted 3,796 words at every
  session start; eighty emitted 8,116. Now a search recites its rows only while something is
  unscreened and a buried idea is named when it shares a term with the question and counted
  when it does not. The same ledger emits 2,223 words and no longer grows.
- **The stop gate leads with the states; `status --why` has the reasoning.** Six refusals went
  from about 400 words to 71.
- **A file the unit does not track is a scratch note.** The write gate fired on any `.md`, so
  a half-formed thought naming a surname exited 2 and you could not keep a thinking file. An
  invented identifier is still refused there.
- **`note --quote` grounds a read depth in the source.** Both sides of `strength <= depth`
  were typed by whoever was at the keyboard. Claims now record which vouched for the depth,
  and WHY.md section 1 gains the narrator its table never had.
- **`compact`, `start --force` archives, and `audit`.** `compact` deletes only what can be
  rebuilt. `--force` used to write over the displaced unit, losing its findings and
  miscounting the growth detector after. `audit` resolves what a document names with no
  project, which `evals/control.md` needs to score arms alike.
- **Three false statements.** WHY.md said *no prompt prepended* while `hook_session_start`
  prepends five files; it said a script decides the read-depth difference, and no script
  reads either sentence; `falsify` said its record was injected before a write, which it
  never was. Section 11 declined the AI-Scientist programme on grounds that were a
  prospect-driven survey of what that programme needs, plus a work cited by bare title.
- **Five defects a fifth review found in the four above, before any shipped.** Grounding
  survived a depth change, so a claim recorded that the source attested a depth nothing
  checked. Session start stopped showing kept works precisely while screening was
  unfinished. Screening relabelled a pre-threads search onto the open thread. A tracked
  draft written `./draft.md` became a scratch note. `terse` cut *Scaling laws vs. emergent
  abilities* at "vs."
- **An invented DOI raised instead of refusing, and 0.4.0 shipped it.** Both indexes
  answering empty is the case for every fabricated identifier, and the merge of their
  answers guarded each one-sided case and fell through both into `dict(None)`. The suite is
  offline and the live evals only ever asked for identifiers that exist, so both directions
  had never been applied to the network path.
- **A 300kB `.pyc` reached 0.5.1**, because the tests import `bin/nullius` as a module.

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
