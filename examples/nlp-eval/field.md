# Field: evaluating language models and the systems built on them

## What counts as evidence

A score on a public benchmark supports *the system scores that on that benchmark*. Anything
beyond it needs the benchmark's own validity argued, because the gap between a leaderboard
number and a capability claim is where most of this literature's disagreements live.

For a system with parts, the evidence has to separate them. A retrieval-augmented pipeline
that answers well may be answering from the model rather than from what it retrieved, and a
score on the whole pipeline cannot tell the two apart. The component that carries the claim is
the component that has to be measured.

An automatic judge is a measuring instrument and needs its own validation: agreement with human
labels on this task, not on the task the judge paper validated.

## Normal scale

Reviewers ask for more than one model, more than one dataset, and more than one seed or
sampling temperature, and a single-configuration result is read as an anecdote. Report the
variance across runs, since decoding is stochastic and differences smaller than that variance
are not differences.

State the number of items, not only the number of datasets.

## Standard baselines

The strong simple thing, run properly. In retrieval, sparse lexical search tuned as carefully
as the neural system it is compared against. In generation, the model without the proposed
component. A closed-book baseline is what shows a retrieval system is retrieving.

Human performance where a defensible number exists, and an explicit statement where it does
not.

## Standard reporting

Prompts, verbatim and in full, including the system prompt. Decoding parameters. Model
versions with dates, because a hosted endpoint is not a fixed artefact and a result on it is
not reproducible without one.

Say what was in the context window and where it came from.

## Known traps

- **Contamination.** A benchmark released before the model's training cut-off may be in the
  training data, and reporting the cut-off is the minimum.
- **Judge bias.** Models judging text reward length and formatting, and prefer their own
  outputs. A judge that has not been checked against human labels on this task is an
  uncalibrated instrument.
- **Prompt sensitivity.** Reordering options or rewording an instruction moves scores by more
  than most reported gains, so a single prompt is a single measurement.
- **The saturated benchmark.** A set everyone has tuned against no longer separates methods,
  and a small gain on it is usually noise.
- **The pipeline that hides its parts.** End-to-end scores attribute credit to whichever
  component the author believes in.

## Words that mean two things

`hallucination` covers a fabricated fact, an unsupported inference and a formatting error in
different papers. `faithfulness` means grounded in the retrieved context to one half of this
literature and consistent with the world to the other, and a paper measuring one will be read
as claiming the other. `evaluation` means an automatic metric, a human study, or a leaderboard
submission. Register each the first time it appears in two senses.
