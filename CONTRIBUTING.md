# Contributing

The tool refuses work that cannot be checked. It would be strange if the repository did not
hold itself to the same rule, so there is one hard requirement and the rest is ordinary.

## A change to a gate needs a test that fails without it

`tests/smoke.sh` runs against a throwaway project and needs no network. Every guard is
tested in **both** directions, the case it must refuse and the case it must allow,
because a gate that only ever passes is not a gate, and a gate that always fires gets
switched off within a week.

```bash
bash tests/smoke.sh        # a few seconds, no network
```

If your change makes a gate stricter, add the case it now refuses *and* a neighbouring case
it must still allow. That second one is the test that stops a future edit from turning a
gate into a nuisance.

## What blocks and what reports is not a style choice

A **fact** is a lookup or a count with no judgement in it: an identifier resolves or it does
not, two author sets are disjoint or they are not. Facts refuse the stop.

A **chosen threshold** is a number somebody picked: three vocabularies, one citation, a
budget. Those are reported to the person through `systemMessage` and leave the turn alone.

A new gate has to say which it is, and the burden is on the stricter answer. If you cannot
describe the check without using a word like *sufficient* or *appropriate*, it is a
threshold.

## Things that are not wanted

- **A gate that blocks on judgement.** It gets switched off, and the good gates go with it.
- **A network call inside a hook.** Hooks read local state only; a hook that reaches the
  network hangs the session. Resolution belongs in a command the user ran on purpose.
- **A third-party dependency.** The CLI is Python 3 standard library. A researcher should be
  able to use this without a package manager, and `pdftotext` is the model for anything
  optional: better if present, fine if absent.
- **Sci-Hub, or anything like it.** Copyright infringement in most jurisdictions, and an odd
  foundation for a research-integrity tool. The legal routes in `nullius fulltext` reach
  most things.

## Field knowledge belongs to the user, not the plugin

`field.md` and `venues/*.md` are per-project on purpose. A norm hard-coded into the plugin
is wrong in every field but one and quietly wrong in that one too. If a field needs support
the plugin cannot give, that is usually a missing *template*, not a missing rule.

## Claims about the design

If something in [WHY.md](WHY.md) or [REFERENCES.md](REFERENCES.md) is wrong, open an issue.
Name the locator. The tool would refuse to let the claim stand without one, and the
documents are held to the same bar, including the parts that flatter the design.

## A new mechanism goes in algorithms/

Four parts, in order: the naive thing that was tried, the measurement that killed it, the
mechanism as a schema, and where it is still weak. An entry with no weakness listed has not
been used enough. The measurement is what makes it arguable, and a mechanism nobody can argue
with cannot be improved.

## The figures are hand-written SVG

`assets/*.svg` are plain text you can edit in any editor. No build step, no toolchain, no
generated binary in the diff: a change to a figure shows up as a line you can read.

To see what you changed, on macOS:

```bash
qlmanage -t -s 1400 -o /tmp assets/gates.svg && open /tmp/gates.svg.png
```

Two rules keep the set coherent. The colours carry meaning rather than decoration: oxblood
marks what the tool **refuses**, slate marks what it merely tells you, and a figure that
spends oxblood on something that does not block is lying in the same way a wrong number
would. And the machine's own vocabulary is set in mono while what it means is set in sans, so
`exit 2` and *the turn does not end* never read as the same kind of statement.

Each plate carries its own light ground on purpose. They are figures, the way a paper's
figures are, and one that inverted with the reader's theme would need two files that drift
apart. A figure also needs a real `role="img"` and `aria-label` saying what it shows, because
a reader who cannot see it is owed the content and not the word "diagram".

If a figure states a number, that number comes from a run. `assets/funnel.svg` reports a real
search, and if you change it, run one.

## Commits

Say what changed and why it was wrong before. A commit message is the only place the
reasoning survives; the diff already says what.
