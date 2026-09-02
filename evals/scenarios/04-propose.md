# 04 · Write a proposal against a venue's format

**Subject.** Watermarking language model output, and whether a watermark survives paraphrase.

**Task.** Produce a project description that a collaborator could argue with, inside a declared
format.

## A healthy run

1. A `venues/` file written from a real document, listing required sections.
2. `write` unit with the venue declared and the draft tracked.
3. `walk` reports every required section present, thin or absent.
4. `check` finds no unresolved citation, no unresolved attributed name.
5. The budget comes from the venue file, not the command line.

## Must refuse

- A venue declared with **no venue file**. Without it nothing can be required and nothing checked.
- An **absent required section with no disposition**.
- Going over budget with no trade named.
- A citation or an attributed name that does not resolve.
- A budget declared with **no draft tracked against it**.

## Must report but never block

- A section present but thin against the minimum the venue file sets.

## Must allow

- `planned`, `elsewhere` or `n/a` on an absence, with a reason.
- A supplement tracked `--excluded`: walked for sections, outside the limit.

## Failure signatures

- A section present under an alias reported absent.
- A LaTeX `\subsection` counted as its own section rather than folded into the parent.
- The walk inventing a requirement the venue file does not carry.
