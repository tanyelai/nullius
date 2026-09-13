# Loops, and what may end one

## A loop whose exit the model computes is not a loop

**Naive.** Iterate. Draft, critique, revise, and stop when the model says it is done. This is
what every agent framework does and it is what a session does by default when nothing says
otherwise.

**Measured, by other people, on the cheapest possible version of the question.** *Large
Language Models Cannot Self-Correct Reasoning Yet*
([arXiv:2310.01798](https://arxiv.org/abs/2310.01798)) puts a number on the revision step with
no external feedback in it. Verbatim, checked against the cached text with `nullius quote`:

> For GSM8K, 74.7% of the time, GPT-3.5 retains its initial answer.

and in the quarter that does move, the paper reports the model is more likely to break a
correct answer than to fix a wrong one. Read that as a control rather than as a result about
one model: the revision step, absent something outside the model, is close to a no-op with a
negative tail.

**The same paper carries the finding that matters for topology**, and it is the one usually
left out of the citation:

> multi-agent debate significantly underperforms simple self-consistency using majority voting.

Debate is a graph. Majority voting is a fold over independent samples. The fold won. Whatever
is doing the work in multi-agent setups, it is not the shape of the conversation, and a
harness that spent its complexity budget on who-talks-to-whom would be buying the wrong thing.

**Instead.** The rule is not *no loops*. Software engineering runs one continuously and it
does not degenerate, because `it builds` is computed by a compiler.

```
legitimate(loop) = exit_condition is computed by something that can refuse the model
                 = a program  |  the world  |  a context that did not author the work
```

That is the same sentence as [WHY.md](../WHY.md) section 4, pointed at control flow rather
than at epistemics, and it is what every gate in this repository already is:

| the loop | who computes the exit | and so |
|---|---|---|
| the stop gate | Python, over the ledger | blocks |
| `cite` | Crossref, OpenAlex, arXiv | blocks |
| `quote` | string match against cached text | blocks |
| the citation walk | saturation arithmetic over a set | stops itself, and says which of converged or budget-spent |
| the three agents | a context window that did not watch the claim being formed | returns, never decides |
| the extension detector | a threshold somebody picked | reports, never ends a turn |
| severity | the model | not a gate at all |

The last two rows are the discipline and they were got wrong once, which
[harness.md](harness.md) records.

## The exit needs a referent, or there is no exit

Termination is not a matter of trying harder to know when to stop.
[critique.md](critique.md) already carries the general form: *what is missing* is three claims
wearing one word, and only the ones that can point at something enumerable terminate. Applied
to loops:

```
every loop here exits on a set becoming empty, never on a judgement of enough:
    the venue walk        every required section has a state
    the screen            unscreened reaches zero
    the response          every reviewer point has a disposition
    the frontier          every kept work has been walked or closed by decision
    the critique          zero fatal and zero material is a verdict
    what is not known     every need has been observed, unmet or carried
    the loose draft       every draft written here is claimed by a unit or declared scratch
```

Replace *is this enough* with *is this set empty* and the loop stops being a matter of taste.

## The loop that had no gate, because it had no unit

**Measured, and it took four releases to notice.** Every gate above hangs off an open unit, and
`hook_stop` opened with `if store.unit is None: return 0`. So the whole apparatus was optional
in the one way nobody checks: not by stepping around a gate, but by never entering the state a
gate applies to. [The fourth control run](../evals/results/control-2026-09-13.md) put a number
on it -- a research answer written into a nullius project with no unit, no search and no
resolved reference, and the stop gate allowed it, correctly, because there was no unit state to
refuse.

**The wrong fix is to refuse every unit-less session.** A research folder is also where you
answer an unrelated question, read a mail, keep a list. A gate that fires on all of that is one
the user turns off, and `WHY.md` section 3 is about instructions that lose under load.

**So what is refused is the one thing that is unmistakably the work**: a draft, in this
project, that nothing claims.

```
recorded  at write time, on both paths -- Write|Edit and the shell heredoc,
          because a gate you can step around by choosing another tool is not a gate
refused   at the stop, while any draft is unclaimed
exits     nullius artifact <path>    under an open unit, and every unit gate then applies
          nullius scratch <path> "<why>"   it was a thinking file, and that is on the record
```

Same shape as the frontier and the reviewer points: a set, two named dispositions, and a
refusal that names both. What it does not reach is research that produced no draft, or a draft
written outside the project. Those are still free, and saying so is cheaper than pretending
otherwise.

## The third answer, and why it had nowhere to go

**Naive.** When the work runs out of evidence, say so in the prose. `voice.md` has asked for
exactly this since the first release: *say "I don't know," and name what would settle it.*

**Measured, in this repository.** That sentence is a process instruction with no truth value,
which is the thing [WHY.md](../WHY.md) section 3 says loses under load, and nothing here could
check it. The `skeptic` agent had a third verdict, `needs`, which returned the observation that
would settle a claim, and there was no ledger state for it to land in. `claim --warrant
assumed` was refused outright and redirected to a free-text thread file, which is a place
things go rather than a place things come back from. Four singletons covered adjacent ground
and none generalised: one `accept` per unit, one `kills` per idea, one `decisive` per
interpretation, and threads nobody counts.

So the harness could refuse, and could not say *not yet, and here is the door*.

**Instead**, one node, project level rather than unit level, because a question does not stop
being open when the unit that found it closes:

```
needs "<the observation that would settle it>" [--for <claim>] [--cost ...]

disposition:  observed  "<what it was>"
              unmet     "<why it could not be got>"     travels with the conclusion
              carried   "<where it now lives>"          still open, and says where

gate:      a need this unit opened with no disposition  -> REFUSE the stop
never:     an open need                                 -> allowed, that is `carried`
boundary:  every need not observed or unmet is printed at SessionStart
```

Enumeration again, and the same shape as the venue walk and the reviewer points: what is
refused is the question nobody came back to. Staying open is one command and it is the honest
end of most research.

Three things follow that were prose before. `assumed` now names a mechanism instead of a
directory. `report` grows a section for what is not known, and
[scholarship.md](../invariants/scholarship.md) can mean what it says when it calls an empty
version of that list a claim. And the `skeptic`'s third verdict lands somewhere that survives
a context window.

**Weak.**

- **The cost field is not priced against anything.** `--cost "one afternoon"` is free text, so
  nothing can rank two open needs against each other or against the work in flight. Ranking
  them is the obvious next step and it is also the step where a judgement would enter a gate,
  which [retrieval.md](retrieval.md) declines for preference models on grounds that apply here
  unchanged. If it is built, it reports an ordering and never filters.
- **`carried` is checkable and unverifiable.** The gate reads that a destination was named. It
  cannot read whether the thread it names exists, and pointing at a file that was never written
  would pass.
- **Nothing measures whether this changes behaviour.** Consistent with every other entry here:
  the numbers above characterise a failure, not an improvement, and no arm of this has been run
  against a control. [evals/control.md](../evals/control.md) is the design that would.
