---
name: nullius
description: Set up or use the nullius research harness in this folder. Use when the user wants to set up nullius, or asks for work this harness gates -- checking whether an idea is already published, covering a literature, reading a paper into a ledger at honest depth, resolving or verifying a citation, drafting against a venue's requirements, reviewing a draft, or interpreting a result. Also when they ask what nullius is or why a gate is refusing.
argument-hint: what you are trying to do
allowed-tools: Bash(./.nullius/bin/nullius:*) Bash(nullius:*)
---

# nullius

`nullius in verba`. It turns the unread paper, the unsearched literature and the unbounded
critique into states a session cannot finish in. Facts refuse; numbers somebody chose are
reported and marked as chosen.

## If there is no `.nullius/` here

```bash
python3 "${CLAUDE_PLUGIN_ROOT}/bin/nullius" init --field "<their subfield, in their words>"
```

Then offer to draft the two files only they can supply. `.nullius/field.md`: normal sample
size here, expected baselines, where results fail to transfer -- this is what makes a
critique calibrated rather than idealised. `.nullius/venues/<name>.md`: required sections and
limit, copied from the real call, because a structural finding must cite a line in it.

Once, outside every repository: `nullius config contact you@university.edu`. Unpaywall
refuses a request without one, and that is the whole route to preprint copies.

## If there is

Run `./.nullius/bin/nullius status` first: it says what is open and what the stop gate is
waiting on, and `--why` adds what each means. Open a unit before the work:

| they are | kind |
|---|---|
| deciding whether an idea is already published | `idea` |
| covering a literature | `survey` |
| reading one paper properly | `read` |
| drafting against a venue | `write` |
| reviewing a draft, theirs or anyone's | `critique` |
| reading a result without moving the goalposts | `interpret` |
| answering reviewers | `respond` |

`start <slug> <kind> "<question>" --thread <line>`, then `accept "<what would close this>"`
before anything else. The full command list arrives at every session start inside a project.

## Three things worth knowing before you are refused

**Never write an identifier you have not seen resolve.** `nullius cite <doi|arxiv|title>`
resolves or refuses, and a draft cannot contain an unresolved one.

**A claim may not exceed its source's read depth**, and the depth is your word until
`note --quote "<a passage>"` checks it against the cached text.

**Zero fatal and zero material findings is a verdict**, not a shorter list.

## The agents, when a second opinion is worth having

Each starts in a clean context, which is the point. `skeptic` attacks one claim through one
lens; `librarian` returns records and never a summary; `referee` reviews against one venue
and must recommend; `reader` explains one source, every point carrying a verified passage.
