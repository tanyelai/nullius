# nullius

> **nullius in verba.** “Take nobody's word for it.”
> The Royal Society's motto since 1660.

A harness for research work in [Claude Code](https://claude.com/claude-code). It turns the
unread paper, the unsearched literature and the unbounded critique into states a session
**cannot finish in**.

> [!NOTE]
> **Status: installable, and nothing is left stubbed.** The ledger, the gates, multi-index
> search with fallbacks, the citation walk, the venue walk and the calibration engine all
> work: 461 assertions in
> [`tests/smoke.sh`](tests/smoke.sh), offline and in both directions, plus seven
> end-to-end [scenarios](evals/) against live indexes. What remains is calibration, and
> [algorithms/](algorithms/) says where each mechanism is weakest, including that none of
> them has been evaluated against a control.
>
> The argument is in **[WHY.md](WHY.md)**: what goes wrong, why better instructions do
> not fix it, and what a harness has to constrain instead. Read that first if you want
> to know whether this is for you.

![Where nullius intervenes in a session: it tells you what is open at SessionStart and after
compaction; refuses a write that cites nothing resolvable, or that still carries wording an
open finding quotes as defective, whether the write arrives through Write, Edit or a shell
heredoc, and whether it lands in the draft or in a file the draft speaks through; and refuses
to end the turn while a fact says otherwise. A fact blocks; a threshold somebody chose is
reported instead.](assets/gates.svg?v=3)

---

## Install

Three lines, none of them in a terminal. Open Claude Code in the folder your research lives
in and type:

```
/plugin marketplace add tanyelai/nullius
/plugin install nullius@tanyelai
```

Restart Claude Code, then say, in plain words:

> set up nullius in this folder

That is the whole installation. Claude runs `nullius init`, which creates a `.nullius/`
folder for your notes, references and claims, and tells you what to fill in. Nothing else
is installed, no account is created, and nothing leaves your machine except the searches
you ask for.

<details>
<summary>If the slash commands are not available, or you prefer doing it by hand</summary>

Create `.claude/settings.json` in your research folder with exactly this:

```json
{
  "extraKnownMarketplaces": {
    "tanyelai": {
      "source": { "source": "github", "repo": "tanyelai/nullius", "ref": "stable" },
      "autoUpdate": true
    }
  },
  "enabledPlugins": { "nullius@tanyelai": true }
}
```

Restart Claude Code and ask it to set up nullius in the folder, as above.
</details>

**What you get is the `stable` channel.** The marketplace entry pins the plugin to that
branch, which moves only when a release is cut and approved, so work landing on `main` never
reaches an installed session. Updates arrive when the version in
[`plugin.json`](.claude-plugin/plugin.json) changes, which is once per release, and
[CHANGELOG.md](CHANGELOG.md) says what changed. The releases are
[tagged](https://github.com/tanyelai/nullius/releases).

**Requirements:** Claude Code, and Python 3.8 or newer, which macOS and every Linux
already have. There is nothing to `pip install`. If you want the tool to be able to read
PDFs it finds, install [poppler](https://poppler.freedesktop.org/) as well; without it you
get links to the papers instead of their text, and everything else works the same.

**Give it an email.** Not a login, and it grants no access to anything paywalled, and no
account is created anywhere. It does two measurable things: **Unpaywall refuses a request
without one** (HTTP 422), and that is the entire route to preprint copies of paywalled work;
and OpenAlex and Crossref use it to put you in their polite pool rather than the common one.

```bash
./.nullius/bin/nullius config contact you@university.edu
```

`contact` is written to `~/.config/nullius/config.json`, outside every repository, so it
cannot reach a commit. Anything else set with `--user` goes there too; everything without it
lands in the project's own `.nullius/config.json`, which is meant to be committed.

## First five minutes

```bash
./.nullius/bin/nullius start intro-rewrite write "sharpen the framing" \
    --artifact paper/intro.tex
./.nullius/bin/nullius accept "does the intro state what the method cannot do"

./.nullius/bin/nullius cite 2005.11401              # resolves, or refuses
./.nullius/bin/nullius note lewis2020 --depth abstract
./.nullius/bin/nullius claim "retrieval helps on knowledge-heavy tasks" \
    --warrant authors-claim --status single-result --strength reports \
    --source lewis2020
```

![Two independent caps on a claim. How far the source was read caps what the claim may
assert: an abstract supports reports, a skim adds holds, the method section adds mechanism,
replication adds generalises. Separately, how many independent author sets stand behind it
caps how settled it may be called, and contested, established and textbook each need two.
](assets/claim-caps.svg)

Add `--venue <name>` once you have written `.nullius/venues/<name>.md` from the real call or
author guidelines. Until that file exists the tool will not require anything of the draft,
which is deliberate: it may not ask for what it cannot cite a line for.

That last command is the shape of the whole tool. Ask for `--strength mechanism` on a
source you only read to `abstract` and it refuses; ask for `--status established` on two
papers that share an author and it refuses, because independence is set arithmetic on
author lists rather than a judgement. Write `\\cite{somethingUnresolved}` into a tracked draft
and the write itself is refused.

**A file the unit does not track is a scratch note**, and a scratch note is where the work
actually happens. An invented identifier is still refused there, because that is a fact and
it is the worst thing this tool could let through. An unattributed surname is reported as a
lead instead, because the name may belong to something cited elsewhere or to nothing yet.
`nullius artifact <path>` holds a file to the draft's bar when you are ready for that.

When you try to finish, `nullius status` says why the gate is holding, and which of its
reasons are facts and which are thresholds somebody chose.

## The commands you start with

Run them as `./.nullius/bin/nullius <command>`, or just ask Claude in plain words: the gate
that fires at startup hands the session the whole vocabulary.

| when you are | the commands |
|---|---|
| opening work | `start` · `accept` · `status` · `done` · `compact` |
| reading a literature | `lit` · `snowball` · `screen` · `coverage` |
| recording what you know | `cite` · `note` · `claim` · `considered` · `falsify` |
| recording what you do not | `needs` · `settled` |
| critiquing something | `finding` · `resolve` · `verdict` · `prose` · `unread` |
| handing it to someone | `report` · `audit` |

That is a third of them. `nullius --help` lists all forty-three with their flags, `--help` on
any one spells out that command's, and `/nullius` carries the rest of the vocabulary. The
reference lives there rather than here, because a table kept by hand goes stale and this one
had already started to.

## The stopping rule a draft writes for itself

Review on a plan does not converge on its own. A competent critic can always name another
control, so without a written boundary each round adds scope and the study never starts.

The answer is not for the tool to decide what is out of scope. It is for **the draft to say
so, in the draft**, where a reviewer will see it:

```latex
\section{What this study does not do}
...
A human persuasion study & Established by others and cited. Attempted underpowered,
                           it would make the paper about the user study \\
Causal analysis on frontier models & Impossible without weights. The behavioural arm
                           runs there and the transfer inference is labelled conditional \\
```

`nullius scope` reads that section out of the tracked draft, from a markdown list, a table,
or a LaTeX `tabular`. A critique unit **cannot write a finding until the boundary has been
read**, and cannot close without it. That is the same guarantee the completeness walk gives:
enumeration, not judgement. No textual test can decide whether a suggestion falls under a
boundary row, so the tool refuses to guess and refuses to let you not look.

Two things keep the boundary from becoming a shield:

- **Every row has to say why.** A row that excludes something without a reason is a fact the
  gate refuses on. Out by decision, with the decision missing, is not a boundary.
- **The boundary itself can be attacked.** `nullius finding <severity> scope "<why this
  boundary is wrong>"` is admissible, and it is the only way back in. A design decision is
  reviewable; what is not reviewable is re-raising it round after round as though it had
  never been taken.

If a finding shares terms with a row, the tool says so and calls it a lead rather than a
verdict, because a wrong match here suppresses a legitimate finding, and that is the
direction of error worth being careful about.

## Closing the frontier

![How the walk chooses where to go and when to stop: the next hop is led by the works most of your own seeds agree on, tie-broken by nearness to their era rather than by citation count, and the walk stops when a hop is 60% already-seen, when the 400-work budget is spent, or when nothing new is left.](assets/walk.svg)

A query finds what shares your words. The citation graph finds what the field itself linked,
and it is the only thing a claim that the frontier is closed can rest on.

`nullius snowball` walks both directions from the works you **screened in**, not from what a
query returned: backward into what a seed cites, forward into what cites it.

```
nullius: walking from <the work you screened in>
  back: 61 in the graph, 5 retrieved  (capped)
  forward: 98 in the graph, 5 retrieved  (capped)
```

`--depth 2` walks again from whatever the first hop's seeds **agreed on**, rather than from
everything, because following what the field points at repeatedly is what going deeper means.

The payload is not the list. It is the multiplicity:

```
hop 1: 1 seed(s)     16 new, 0 already reached
hop 2: 4 seed(s)     60 new, 4 already reached, 6% of this hop was known

reached from more than one of 7 seeds, which no query would have told you:
  3/7 (43%)  2020   276  <the paper the field descends from>
  2/7 (29%)  1998   273  <its standard textbook>
```

A work several of your seeds point at is what the field agrees is behind them: the canon, or
the thing everyone is arguing with. A keyword query will not reliably surface it, because the
canon is often phrased in older words. And the "already reached" percentage is the saturation
signal: when a hop stops returning anything new, you have the literature. When it is 6%, you
do not, and no amount of confident prose changes that.

Everything retrieved lands in a search log like any other, carrying how it was reached
(`via back from ...`), and gets screened the same way. A `survey` unit cannot close while a
work you kept has never been walked, which turns *the frontier is closed* from a claim into a
count. A kept work the index does not carry cannot be walked at all, and that is reported
rather than skipped.

Where Semantic Scholar has parsed a citing paper's full text it also returns the sentence in
which the citation appears, and whether the citation was influential. Those are **sparse**:
present for some papers and not others, so the tool shows them when they exist and never
counts on them.

## What a correction has to reach

A claim dies in the ledger and goes on standing in the draft, because words do not change
themselves. Four gates close that gap, and each one exists because it was missed:

| The gate | What it refuses |
|---|---|
| **pinned wording** | a `fatal` or `material` finding quotes the sentence it condemns, and that quote is pinned. The draft does not pass `check` while it still contains it. Removing the finding is not the same as removing the sentence |
| **companions** | `artifact draft.md --includes figures.py` says which files reach the reader *through* the draft. They are checked with it whatever their extension, because a figure caption goes on asserting what the prose has stopped asserting |
| **staleness** | `falsify` marks every tracked draft unchecked. The unit does not close until each has been read against what died |
| **the shell** | `Bash` is matched as well as `Write|Edit`. A quoted heredoc carries its own body, so it is checked exactly like a write; a redirect from a program cannot be, and is said out loud instead. A gate you can step around by choosing another tool is not a gate |

## What an opinion has to rest on

Three more, against the two ways a screen quietly fails:

| The gate | What it refuses |
|---|---|
| **a tight zero** | a query that returned nothing over title and abstract, never re-run with `--loose`. The words were wrong is not the same as the literature is empty |
| **a failed vocabulary** | works excluded on a search the tool itself reported as a finding about the vocabulary. `screen ... unknown` is the honest third answer, and it reads later as what it was |
| **an impression** | an `idea` unit where nothing was read past `abstract`. The nearest work is precisely the one an abstract will not settle |

And an `idea` unit does not close with no `considered` on the record: an idea with no rejected
sibling is a preference rather than a choice, and the reasoning is the first thing lost.

## A thread is a line of enquiry, and the gates read one

Nobody works on one question at a time. `start --thread <name>` says which line this unit
belongs to, and every search and claim written under it is stamped with that thread.

```bash
./.nullius/bin/nullius start novelty idea "has anyone measured X" --thread calibration
```

**The gates then read that thread and no other.** Unfiltered, one search logged in March
satisfied *silence is a failed search* for every idea unit after it, and one failed
vocabulary blocked every unrelated idea after that. A project with two live questions is the
ordinary case rather than an exotic one.

Nothing needs migrating: a record written before threads existed reads as `main`.

## What is on disk, and what comes back

They are different decisions and this tool used to make them once, so the only way to read
less was to record less. The ledger keeps everything and `report` walks everything. What
crosses a context boundary is what is still **live** on the thread in front of you:

| | |
|---|---|
| a search | recites its kept works while anything is unscreened. After that its counts are in `coverage` and its rows stay there |
| a buried idea | named when it shares a term with the question you are asking, counted when it does not. Never silently dropped, which the old cap at eight was |
| what is unknown | until it is `observed` or `unmet`; `carried` keeps it coming back |

`nullius compact` is the only thing that deletes, and it deletes only what can be rebuilt:
cached full text, which `fulltext` refetches, and growth samples outside the window any
detector reads. It will not remove a claim, a finding, a screening decision or a buried
idea, and there is no flag that will. The file-drawer problem is why this tool writes things
down in the first place.

## Whose word a read depth rests on

`strength ≤ depth` is the tool's flagship cap and both sides of it are typed by whoever is
at the keyboard. With a person reading a paper that is an honest-broker field. In an
unattended run it is the only unchecked thing left, so it can be settled against the source:

```bash
./.nullius/bin/nullius note lewis2020 --depth method --quote "we fine-tune the retriever"
```

The passage is checked verbatim against the cached text or the note is refused, and every
claim records whether its depth came from the source or from the session. That row is the
one *nullius in verba* did not have.

## A draft does not go out unread

A `critique` unit has always had to produce a verdict. A `write` unit never had to receive
one, so a draft could reach the end having been read by nobody. That is the oldest gate in
science and this repository had every piece of it -- located findings, a venue scale, three
agents that start in a clean context and do not know whose draft it is -- and never joined
them.

**A write unit that names a venue does not close while a tracked draft has no recommendation
on it.** Naming a venue is the act of saying this goes out; a unit without one is drafting,
and drafting is where the work happens.

```bash
# have something read it that did not write it, then record what came back
./.nullius/bin/nullius finding material structural "no limitations section" --at p.md:40
./.nullius/bin/nullius verdict rework --by referee
```

**The tool never reads the recommendation.** A `rework` closes the unit exactly as an
`accept` does. It checks that somebody looked, not that they approved, and what to do about a
finding stays where it always was.

Two things keep it honest in the other direction. A verdict with no `--by` is reported as
*the session's own verdict on its own draft*, which is the check this whole tool exists to
say is not one. And `nullius unread "<why>"` sends it out unread on purpose, recorded and
travelling with the unit, because a gate with no way past it is a gate people route around.

## Saying a thing once

Length was never the problem. A long document with nothing repeated is fine; a short one
that makes its point three ways is not, and that is the thing a model does and a person
does not. It is also, unlike elegance, partly measurable:

```
$ nullius prose proposal.md
nullius prose  proposal.md
  108 words, about 1 minute(s) to read
  3 paragraph(s) long enough to compare, 0 figure/table/diagram, short version at the top: yes
  78%  line 3  The central difficulty is that speculative decoding is eva
       line 9  Nobody has characterised whether draft and verify decoding
```

Three signals, all of them counts:

| | |
|---|---|
| **one point, twice** | passage pairs sharing most of their content words. Containment rather than overlap, because the failure is a point restated *more briefly* somewhere else |
| **no way in** | past a threshold, a document with no summary and no short opening paragraph |
| **no shape** | past the same threshold, a document with no figure, table or diagram at all |

**Every one of these is a lead, never a verdict, and none of them refuses anything.** Two
paragraphs on one subject legitimately share vocabulary, and a tool that deleted the second
would be editing rather than checking. They reach the stop through the channel marked as
chosen rather than measured, alongside the other numbers somebody picked.

## How long is it allowed to be

A different question, and a smaller one. The mirror of an old gate is now closed. A declared budget with no draft tracked against
it has always been a fact this refuses. **A tracked draft with no declared length now is
too**, because without a number there is nothing the writing can exceed and no point at
which an addition becomes a trade.

```
./.nullius/bin/nullius start proposal write "draft it" --artifact p.md --words 900
./.nullius/bin/nullius config default_words 900     # or once, as the house norm
```

Three places satisfy it: the unit, the venue file, or the project's house norm. **The tool
never picks the number.** It has no view on how long your work should be, and a default it
chose would be exactly that. What it refuses is for nobody to have chosen, which is the same
move as the acceptance question, the killing assumption and the scope boundary.

Every write to a counted draft then says where it puts you, rather than waiting for the
stop:

```
nullius: this write puts the tracked draft(s) at 1,040 of 900 words.
  Over. An addition here is a trade: name what it costs, or subtract.
```

**What this does not reach.** Anything not tracked as an artifact, including a session's
prose in the terminal. Track a slide deck or a memo and it is covered; leave it untracked
and only [`invariants/voice.md`](invariants/voice.md) applies, which is an instruction and
therefore the weaker kind of constraint. This repository is candid about that difference
everywhere else and should be here too.

## What not knowing has to become

Every other gate here can refuse. None of them could say *not yet, and here is the door*, and
so the one thing a careful person does most often had nowhere to go. `nullius needs` records
it as a countable state instead of a sentence:

```bash
./.nullius/bin/nullius needs "run it once on data the model never saw" \
    --for c003 --cost "one afternoon of retraining"
```

It outlives the unit that found it, it comes back at every session start, and it closes three
ways and no others:

| | |
|---|---|
| `observed` | you got the observation. Say what it was |
| `unmet` | it could not be got. Say why, and it travels with the conclusion rather than being dropped when the paragraph is written |
| `carried` | still open, and you are saying where it now lives |

**Staying open is fine, and `carried` is how you say so.** What the unit cannot close on is a
question it asked itself and then walked past, which is the same guarantee the venue walk and
the reviewer points give: enumeration, not judgement.

This is also why `--warrant assumed` is refused. An assumption is an open question wearing
another word, and now there is somewhere for it to be one.

## When a draft is only getting longer

![Three refusals on a critique loop that would otherwise never close: an ask with no
terminating answer, a finding that cites none of the four admissible referents, and a draft
that grew for three turns with nothing that generates work closed. Fatal and material findings
still keep the loop open.](assets/critique.svg)

Growth is not the signal. A draft that grew while four material findings were fixed is a
draft being worked on. Growth **with nothing closed** is the other thing:

```
p.md: 3 turns, 4201 to 7001 words, and no finding that generates work closed in
that span. Growth is not the signal; growth with nothing closed is. If the last
real gap is shut, the answer is a verdict rather than another pass.
```

Length is sampled per artifact at the stop, and only when the measured state moves, so the
series counts turns rather than keystrokes. Alongside it runs a count of `fatal` and
`material` findings actually closed with `nullius resolve`, across every unit the project
has run. The detector compares the two over a window of three turns.

It is a **chosen threshold**, not a fact: three turns and a quarter of growth are numbers
somebody picked. So it reports to you and never ends a turn.

## Handing it to someone

![A real search reported as a funnel: 12,549 matched at OpenAlex, 74 retrieved through one
vocabulary of three, all 74 screened, 3 included, and the 71 discards attributed to two named
rules rather than seventy-one separate judgements.](assets/funnel.svg)

`nullius report` writes what the ledger holds as markdown a person reads: every claim with its
warrant, its status and what it may assert; every source with how far it was actually read; the
search as a funnel with the rules that did the discarding; what was dispositioned and what was
discharged; and what is still refusing the stop.

It is **markdown on purpose, and there is no typesetting here.** The venue owns the format, the
house style is yours, and a template shipped with a tool becomes a house style that is not
either. What the tool owns is the epistemic state, and that is the half a collaborator cannot
reconstruct from the draft. Feed the markdown to whatever build you already have.

The report closes on what it does not establish, which is most things: not coverage, not
quality, and not independence where a record carried no author identifiers.

## Four agents, and why they run blind

The plugin installs four subagents alongside the CLI. Each one starts in a **clean context**,
which is the feature rather than an implementation detail: a second opinion is worth something
only if it did not watch you form the first one.

| agent | what it does |
| --- | --- |
| `skeptic` | takes one claim through one lens and returns survives, dies, or the observation that would settle it |
| `librarian` | runs a search protocol and returns records: identifiers, counts, screening decisions. It is forbidden from summarising them |
| `referee` | reviews a draft as a reviewer at one named venue, against that venue's own written requirements |
| `reader` | reads one source at a stated depth and returns what it establishes, every point carrying a passage it has checked verbatim with `nullius quote` |

Ask for them in plain words: *have the skeptic take apart c003*, or *get the referee to read
this against the venue file*.

Two of the prohibitions are load-bearing. The `skeptic` is never told whose claim it is, so a
claim from a famous lab and a claim from you get the same bar; a check that knows the answer
you are hoping for has already stopped being one. And the `librarian` may not summarise,
because a summary is exactly where a thin search stops looking thin: six shallow hits become a
confident paragraph about what the field thinks, and the thinness is no longer visible to
anybody, including you.

The `reader` is the one that looks like it breaks the librarian's rule and does not. That
prohibition is about summarising **a set of works**, where the summary hides how thin the set
was. Explaining **one source whose full text you hold** is a different act, and it is
checkable in a way no summary is: every point comes back with a passage, the agent runs
`nullius quote` on each before returning it, and a fabricated point cannot produce a passage
that verifies. Without cached text it refuses to start, because an explanation built from an
abstract is the failure it exists to prevent rather than a smaller version of the job.

None of the four decides anything. They return findings, and what to do about a finding stays
yours.

## Where the rest of it is

This file is how to run the thing. Everything else has its own home, and none of it is
summarised back here.

**[WHY.md](WHY.md) is the argument**: what goes wrong by default, why more instructions do not
fix it, what plays the part a compiler plays in software, and what this is not. It also holds
the one thing you have to supply yourself, in §10: the tool ships knowing nothing about your
field, so `field.md`, `venues/<venue>.md` and `program.md` are files you write, and they are
what make a critique *calibrated* rather than idealised. `falsified.md` is the one people
underestimate.

**[algorithms/](algorithms/) is the interesting half.** Every mechanism in this tool replaced
something that looked reasonable and did not work, and each entry carries the measurement that
killed the naive version: the query that matched 15,277 works against the one that matched 811,
the citation walk that offered a 1962 statistics paper as the canon of a field two decades
younger, the guard that called a document clean while every reference in it was unverified.
Written as schemas rather than prose where the mechanism has any structure, one file per stage,
and open at the end of each on where it is still weak. If one is wrong, the measurement is the
thing to attack.

[evals/](evals/) runs seven scenarios against live indexes: one per use case, each on a
different AI subject, plus the path where the index refuses to answer at all. It is not a
benchmark and seven runs are not calibration; it measures whether each path completes and
whether the gates fire on real material rather than only on the fixtures. Two defects came out
of the first pass, both recorded under `## Found by running this` in the scenario that found
them.

[examples/](examples/) has three worked fields: clinical machine learning, language model
evaluation, and quantitative social science. The `field.md` files are real and you
should argue with them; the venue files are skeletons, because a checklist invented for a real
conference would break the tool's own rule that it may not require what it cannot cite.

[REFERENCES.md](REFERENCES.md) is where the design's own claims are sourced. Every mechanism
here answers a failure somebody has already characterised, and every identifier in that file
was resolved with `nullius cite` rather than written from memory, the same bar the tool
holds a draft to.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). The short version: a change to a gate needs a test
in `tests/smoke.sh` that fails without it, in **both** directions, because a gate that only ever
passes is not a gate. If a claim in WHY.md or REFERENCES.md is wrong, that is a finding and
an issue is the right place for it.

Run the gate before you push. CI runs this same file, so it cannot disagree with you about what
passing means:

```bash
bash tests/preflight.sh
```

**Landing a change, and shipping one, are separate.** A pull request into `main` needs
`preflight` green, and merging it reaches nobody: what an installed session runs is the
`stable` branch. That branch moves only when a maintainer dispatches the
[release workflow](.github/workflows/release.yml) and then approves it, which is also the only
thing that moves it. The workflow refuses to release a version the tree does not already carry
or the [changelog](CHANGELOG.md) does not explain, so the bump and its entry land as a
reviewable commit first.

## License

[MIT](LICENSE).
