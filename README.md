# nullius

> **nullius in verba.** “Take nobody's word for it.”
> The Royal Society's motto since 1660.

A harness for research work in [Claude Code](https://claude.com/claude-code). It turns the
unread paper, the unsearched literature and the unbounded critique into states a session
**cannot finish in**.

> [!NOTE]
> **Status: installable, and one thing is still described and unbuilt.** The ledger, the gates, multi-index
> search with fallbacks, the citation walk, the venue walk and the calibration engine all
> work: 456 assertions in
> [`tests/smoke.sh`](tests/smoke.sh), offline and in both directions, plus seven
> end-to-end [scenarios](evals/) against live indexes. What remains is calibration, and
> [algorithms/](algorithms/) says where each mechanism is weakest, including that none of
> them has been evaluated against a control, except once, on one task, where
> [every arm scored clean](evals/results/control-2026-09-11.md) including the one with no
> harness. The folklore walk that
> [WHY.md](WHY.md) section 4 describes does not exist: `folklore` is a status you can record,
> not a trail anything follows.
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
| critiquing something | `finding` · `resolve` · `verdict` · `unread` |
| handing it to someone | `report` · `audit` |

That is a third of them. `nullius --help` lists all forty-two with their flags, `--help` on
any one spells out that command's, and `/nullius` carries the rest of the vocabulary. The
reference lives there rather than here, because a table kept by hand goes stale and this one
had already started to.

## What it refuses, and what it only tells you

Twelve sections used to sit here, one per mechanism, each arguing for itself. The argument is
[WHY.md](WHY.md)'s job and the mechanisms are in [algorithms/](algorithms/). This is the list.

**A fact refuses.** No calibration is needed for any of these to be right.

| | |
|---|---|
| an unresolved or retracted citation, in a tracked draft | a bare `arXiv:` id or a credited surname counts, and so does a shell heredoc |
| a claim above its source's read depth | `strength <= depth`, and `--quote` grounds the depth in the source |
| a status above what author independence earns | `established` needs two disjoint author sets |
| a survey closing with anything unscreened or unwalked | the citation graph is the only thing a closed frontier can rest on |
| a tight zero never re-run over full text | *the words were wrong* is not *the literature is empty* |
| an `idea` unit with no killing assumption, no cost, or nothing read past an abstract | |
| an `interpret` unit that names its decisive number after the results | unless `--post-hoc`, which labels it and carries the label forward |
| a finding with no referent, or a critique with no verdict | zero fatal and zero material **is** the verdict |
| a draft still carrying wording an open finding quotes as defective | removing the finding is not removing the sentence |
| a question you asked yourself and never came back to | `needs` closes `observed`, `unmet` or `carried` |
| a draft that names a venue going out unread | `unread "<why>"` is the way past, and it is recorded |
| a tracked draft with no declared length | so an addition has something to be a trade against |

**A chosen number is reported and marked as chosen.** Fewer vocabularies than suggested; a
status reached through names rather than identifiers; passages sharing most of their words; a
long draft with no figure; growth with nothing closed; a read depth the session attested
rather than the source.

**Two things scope the rest.** `start --thread <name>` says which line of enquiry a unit
belongs to, and the gates read only that thread. And what crosses a context boundary is what
is still live on it: a search stops reciting its rows once everything is screened, a buried
idea is named when it shares a term with your question and counted when it does not. The
ledger keeps all of it; `compact` deletes only what `fulltext` can refetch.

## Closing the frontier

![How the walk chooses where to go and when to stop: the next hop is led by the works most of your own seeds agree on, tie-broken by nearness to their era rather than by citation count, and the walk stops when a hop is 60% already-seen, when the 400-work budget is spent, or when nothing new is left.](assets/walk.svg)

A query finds what shares your words. The citation graph finds what the field itself linked.
`nullius snowball` walks both directions from the works you **screened in**, and the payload
is not the list, it is the multiplicity:

```
hop 1: 1 seed(s)     16 new, 0 already reached
hop 2: 4 seed(s)     60 new, 4 already reached, 6% of this hop was known

reached from more than one of 7 seeds, which no query would have told you:
  3/7 (43%)  2020   276  <the paper the field descends from>
  2/7 (29%)  1998   273  <its standard textbook>
```

A work several seeds point at is what the field agrees is behind them, and a keyword query
will not reliably surface it because the canon is phrased in older words. The already-reached
percentage is the saturation signal: at 6% you do not have the literature, and no amount of
confident prose changes that. [algorithms/graph.md](algorithms/graph.md) has the walk, its
stopping rule, and the measurement that killed the naive version.

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

This file is how to run the thing. The rest is not summarised here, which used to be claimed
one line above a summary of it.

- **[WHY.md](WHY.md)** -- the argument: what goes wrong by default, why more instructions do
  not fix it, and what this is not. Section 10 is the one thing you supply yourself.
- **[algorithms/](algorithms/)** -- one file per mechanism, each carrying the measurement that
  killed the naive version and a note on where it is still weak.
- **[evals/](evals/)** -- seven scenarios against live indexes, and
  [control.md](evals/control.md), which is the arm that actually tests the claim and has now
  been run twice.
- **[examples/](examples/)** -- three worked fields. The `field.md` files are real and you
  should argue with them.
- **[REFERENCES.md](REFERENCES.md)** -- where this design's own claims are sourced. Every
  identifier there was resolved with `nullius cite`.

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
