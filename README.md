# nullius

> **nullius in verba.** “Take nobody's word for it.”
> The Royal Society's motto since 1660.

A harness for research work in [Claude Code](https://claude.com/claude-code). It turns the
unread paper, the unsearched literature and the unbounded critique into states a session
**cannot finish in**.

> [!NOTE]
> **This is not finished and it is not meant to be.** It is installable, tested and in real
> use, and the shape of a research session is not something one person can get right alone.
> If a gate misfires in your field, if your subdiscipline needs a check that is not here, or
> if you use it for something I did not think of, that is the most useful thing you can send.
> [Open an issue](https://github.com/tanyelai/nullius/issues) -- a gate that is wrong for you
> is a finding, and this repository treats it as one.
>
> <details>
> <summary>what is built, what is not, and what has been measured</summary>
>
> **Built and tested.** The ledger, the gates, multi-index search with fallbacks, the citation
> walk, the venue walk and the calibration engine: 492 assertions in
> [`tests/smoke.sh`](tests/smoke.sh), offline and in both directions, plus eight end-to-end
> [scenarios](evals/) against live indexes. [algorithms/](algorithms/) says where each
> mechanism is weakest.
>
> **Documented and not built.** The folklore walk in [WHY.md](WHY.md) section 4: `folklore` is
> a status you can record, not a trail anything follows.
>
> **Measured, five times.** The control arm has been run on
> [an easy topic](evals/results/control-2026-09-11.md), [a hard one](evals/results/control-2026-09-11b.md),
> [once more with the rules cut by 40%](evals/results/control-2026-09-12.md),
> [once outside AI entirely](evals/results/control-2026-09-13.md), and
> [once on a literature three months old](evals/results/control-2026-09-13b.md). Fifteen arms,
> **zero fabricated citations** -- including in those with no harness at all. What separates the
> arms is what a reader can resolve: on the young literature the unharnessed session cited the
> paper at the centre of the dispute through a vendor's blog, and half its links were not papers
> at all. The fourth run also found that **the harness engages on the prompt, not on being
> installed**: asked only to answer, a session in a nullius project opened no unit, searched
> nothing, and the stop gate had nothing to refuse. Small samples, and the write-ups say so.
>
> </details>
>
> The argument is in **[WHY.md](WHY.md)**. Read it if you want to know whether this is for you.

## What changes

One question put to two sessions -- one with this installed, one launched with nothing, same
model, neither prompt naming the tool. Twice, on two kinds of literature that fail differently.

### A literature three months old

> *Do large reasoning models actually reason, or do they pattern-match? How settled is the
> answer? Do the literature search properly before you answer. About 350 words.*

Both answers are good, and both lean on the same central paper. The difference is what happens
when you try to go and read it.

<table>
<tr><td width="50%">

**Before**

> Apple's **"The Illusion of Thinking"** reported accuracy collapse on puzzles past a
> complexity threshold.

The link goes to `arize.com/blog/` -- a monitoring vendor's marketing post *about* the paper.

**Five of its ten links are not papers**: that blog, a conference poster page, a company's own
publication venue, a benchmark product page, a Substack. **No DOI anywhere in the document.**

</td><td width="50%">

**After**

> **Shojaee et al. (2025, NeurIPS)** report *"complete accuracy collapse beyond certain
> complexities"*

The same work, resolved to *Advances in Neural Information Processing Systems*, carrying a DOI,
flagged peer-reviewed, read to `method` depth -- and that quotation **checked verbatim** against
the cached text, along with four others.

</td></tr>
</table>

One session routed a NeurIPS paper through a vendor's blog. The other could not: `cite` resolves
a work or refuses it, and a blog post is not a work.

And **nine of the eighteen sources it found are not peer reviewed** -- eight arXiv, one Research
Square -- which it marks on every one. That is the true shape of this literature and the part
the popular account never states. [The run.](evals/results/control-2026-09-13b.md)

<details>
<summary>the whole of the <b>Before</b> answer, for this question</summary>

Verbatim, dashes normalised to this repository's convention. 309 words, links left whole so the
count below can be checked.

> # Do large reasoning models reason, or pattern-match?
>
> **Short answer:** both, and the field has largely stopped treating it as a binary. What is *not* settled is how far the genuine-computation part generalizes.
>
> ## The case for pattern-matching
>
> The strongest evidence is degradation under superficial perturbation. [GSM-Symbolic](https://arxiv.org/abs/2410.05229) showed accuracy falling when only names and numbers change, and collapsing further with added irrelevant clauses. Apple's ["The Illusion of Thinking"](https://arize.com/blog/the-illusion-of-thinking-what-the-apple-ai-paper-says-about-llm-reasoning/) reported accuracy collapse on puzzles past a complexity threshold. The [ARC Prize 2025 technical report](https://arxiv.org/html/2601.10904v1) is blunter: models solve reliably only where pretraining knowledge coverage exists plus a verifiable feedback signal, and calls this "fundamentally constrained by knowledge coverage… distinct from human reasoning." Gemini 3 Deep Think spends ~138k tokens on tasks humans solve instantly. On the RL side, [Yue et al.](https://neurips.cc/virtual/2025/poster/119944) found RLVR models beaten by their own base models at high pass@k -- RL sharpens sampling rather than adding capability.
>
> ## The case against
>
> Several headline results have not held up cleanly. [Lawsen's rebuttal](https://arxiv.org/html/2507.01231v1) showed much of the Hanoi "collapse" was output-token truncation, with models explicitly saying they were stopping for length. A [2026 statistical re-evaluation of GSM-Symbolic](https://arxiv.org/pdf/2605.28700) found only 8 of 20 open models showed significant drops, and that the variants skew toward larger numbers -- calling blanket conclusions "statistically premature." Similarly, CoT-unfaithfulness findings partly reverse under larger token budgets ([ACL 2026](https://arxiv.org/abs/2512.23032)).
>
> Mechanistically, Anthropic's [attribution-graph work](https://transformer-circuits.pub/2025/attribution-graphs/biology.html) finds intervention-verified multi-step circuits -- real internal computation, not lookup. And frontier systems have produced genuinely novel mathematics: a [disproof of Erdős's unit-distance conjecture](https://epoch.ai/frontiermath), formally verified.
>
> ## Where it stands
>
> Melanie Mitchell's read still holds -- ["there's no consensus"](https://aiguide.substack.com/p/the-llm-reasoning-debate-heats-up). Much of the disagreement is definitional: nobody has an operational threshold separating "abstraction" from "very broad interpolation." The defensible position is that these models perform real, non-retrieval computation over representations whose coverage is set by training data -- brittle off-distribution, but not empty.

**Ten links. Five of them are not papers**: `arize.com` (a vendor blog standing in for the
paper), `neurips.cc` (a poster page, not the paper), `transformer-circuits.pub` (a company's own
venue), `epoch.ai` (a benchmark product page, and the sole support for the strongest claim in
the document), `aiguide.substack.com`. The other five are arXiv preprints. **No DOI anywhere,
and no source presented as peer reviewed.**

</details>

<details>
<summary>the whole of the <b>After</b> answer, for this question</summary>

Verbatim, dashes normalised. 350 words, against a 350-word brief.

> # Do large reasoning models reason, or pattern-match?
>
> **Not settled -- and the dichotomy is part of why it stays that way.**
>
> ## What is established
>
> Frontier accuracy is not invariant to changes that leave the problem intact. Mirzadeh et al.
> (2024) show performance declines when only the numeric values in a grade-school maths question
> change, and that adding "seemingly relevant but ultimately irrelevant information" costs up to
> 65% across every state-of-the-art model tested. Wu et al. (2024) report that on counterfactual
> variants of familiar tasks -- base-9 arithmetic, shifted keyboards -- GPT-4 "consistently and
> substantially underperforms" its default-condition score. Two independent groups, both measured:
> whatever these systems do is bound to the surface form of a problem in a way competent human
> reasoning is not.
>
> ## What is contested
>
> The headline evidence is under live methodological attack. Shojaee et al. (2025, NeurIPS)
> report "complete accuracy collapse beyond certain complexities", plus a counterintuitive decline
> in reasoning effort as problems get harder. Lawsen (2025, preprint) argues these findings
> "primarily reflect experimental design limitations rather than fundamental reasoning failures":
> output token limits, a rigid automated scorer, and River Crossing instances that are
> mathematically unsolvable for N≥6 yet scored as model failures. The analogy literature splits the
> same way -- Lewis and Mitchell (2024) read counterfactual tasks as evidence against general
> reasoning; Webb et al. (2025, *PNAS Nexus*) run comparable tasks and conclude the opposite.
>
> ## Why the question is badly posed
>
> Mechanistic work suggests both camps are arguing over a false choice. Nikankin et al. (2024) find
> that LLMs do arithmetic "using neither robust algorithms nor memorization; rather, they rely on a
> bag of heuristics" -- many narrow, composable circuits. That is a third thing, and no behavioural
> benchmark can distinguish it from either pole.
>
> ## What would settle it
>
> Complexity varied independently of required output length and answer format, on a problem family
> held out *by construction* from an auditable pretraining corpus. No study here can audit the
> corpora of the models it tests, so "outside the training distribution" is asserted, never
> verified. Until that is fixed, collapse curves stay confounded.

**Eighteen sources, every one resolved to a DOI, nine of them peer reviewed and each marked.**
The venue travels in the sentence: *Lawsen (2025, preprint)*, *Shojaee et al. (2025, NeurIPS)*,
*Webb et al. (2025, PNAS Nexus)*. Five were read to `method` depth, and the five passages quoted
above check verbatim against the cached text:

```
nullius quote mirzadeh2024 "seemingly relevant but ultimately irrelevant information"
nullius: verbatim in mirzadeh2024.        ... and four more, five for five
```

Behind it sit five claims with a warrant and a status. One reaches `established` -- the first
in five control runs -- on two independent groups both measuring; the contested heart of the
dispute is recorded as `contested` over the two papers that disagree.

</details>

### A literature forty years old

Where the sources are refereed and the dispute is old, the failure is quieter. Both answers are
verbatim.

> *Does the language you speak change what you can see? How settled is the answer? Do the
> literature search properly before you answer. About 350 words.*

<table>
<tr><td width="50%">

**Before**

> Almost certainly not at the level of seeing. ... The strongest neural evidence for the
> first claim **has just collapsed.**

551 words for a 350-word brief. Nine works linked, **3** with a resolvable identifier. Six
people credited, three a reader can chase. Nothing about what the search missed.

</td><td width="50%">

**After**

> Narrowly yes; in the way the question is usually meant, no.

355 words for the same brief. **14** sources, all 14 resolved and carrying a read depth. Then,
unasked, a closing note:

> the walk stopped at **46% known per hop**, so the literature was still opening up, and
> paywalls held every source **to abstract depth** -- so each claim is what a study *reports*,
> not mechanism.

</td></tr>
</table>

Both sessions ran into paywalls; one said so where a reader would see it. *46% known per hop*
is a figure you can argue with, and *the literature suggests* is not.

**Neither column invents anything** -- every identifier in both resolves, as in all fifteen arms
across five runs. Both reach the same *direction*. What they do not reach is the same
**confidence**: *Before* calls the early-vision question *clear* and one 2026 paper
*decisive*; *After* calls it **unsettled**, and of its thirteen recorded claims not one reaches
`established`. Only one of them earned its confidence, and **you cannot tell which from the
prose.** That is the failure this is built for, and it is not the one people expect.
[The run.](evals/results/control-2026-09-13.md)

<details>
<summary>the whole of the <b>Before</b> answer, for this question</summary>

Verbatim, dashes normalised to this repository's convention. 551 words.

> # Does the language you speak change what you can see?
>
> **Almost certainly not at the level of seeing. Probably yes at the level of naming, deciding
> and remembering what you saw. The strongest neural evidence for the first claim has just
> collapsed.**
>
> ## The case that was built
>
> Winawer et al. (2007) is canonical. Russian obligatorily splits blue into *siniy* (dark) and
> *goluboy* (light); English does not. Russian speakers discriminated cross-boundary blues
> faster than within-boundary ones; English speakers showed no such boundary. Gilbert et al.
> (2006) found the effect only in the right visual field -- language-side -- which looked like
> a smoking gun. Thierry et al. (2009) reported a larger visual mismatch negativity for Greek
> speakers' *ghalazio/ble* contrast: a pre-attentive ERP component, language reaching into
> vision before awareness.
>
> ## The case that came apart
>
> Three things went wrong.
>
> First, the original study carried its own deflation: the Russian advantage "was eliminated by
> a verbal, but not a spatial, dual task." Occupy the language system and the effect vanishes
> -- what you expect if people are *covertly labelling*, not seeing differently.
>
> Second, replication. Martinovic, Paramei & MacInnes (2020, *Cognition*) re-ran the Russian
> blues with tighter colorimetric control and found no categorical facilitation in processing
> speed. Witzel found robust category effects only in speeded discrimination with untrained
> observers, and none at green-blue once sensitivity was controlled. The right-visual-field
> lateralisation has repeatedly come out bilateral or absent.
>
> Third, and decisively: Martinovic et al. (2026, *PNAS*) -- "Cognition does not automatically
> influence perception" -- ran a close replication of Thierry et al. across three EEG
> experiments and found no robust categorical modulation. The early differences track hue,
> saturation, luminance contrast and adaptation to it, not linguistic categories.
>
> ## How settled
>
> Settled enough for a direction, not a full stop. Kapelle & Flecken's 2025 scoping review of
> 72 studies concludes the effects are **context-dependent and transient**, sitting in top-down
> stages where participants can anticipate task demands, strongest under memory load --
> consistent with Bae et al. (2015), where categorical bias is *amplified* by working memory
> rather than born in vision. Wakui et al. (2025) still find Himba speakers showing categorical
> effects in visual search for newly acquired colour terms, so learned categories do something.
> The live question is not *whether* language touches colour cognition but *where in the
> pipeline* -- and the early end now looks clear.
>
> ## Sources
>
> - Winawer et al. 2007, *PNAS* -- Russian blues reveal effects of language on color
>   discrimination → `fermatslibrary.com/s/russian-blues-...`
> - Gilbert et al. 2006, *PNAS* -- Whorf hypothesis is supported in the right visual field but
>   not the left → `pnas.org/doi/`**`10.1073/pnas.0509868103`**
> - Thierry et al. 2009, *PNAS* -- Unconscious effects of language-specific terminology on
>   preattentive color perception → `pnas.org/doi/`**`10.1073/pnas.0811155106`**
> - Martinovic, Paramei & MacInnes 2020, *Cognition* -- Russian blues reveal the limits of
>   language influencing colour discrimination → `pubmed.ncbi.nlm.nih.gov/32276236/`
>   (+ a postprint PDF at `hira.hope.ac.uk`)
> - Martinovic et al. 2026, *PNAS* -- Cognition does not automatically influence perception →
>   `pmc.ncbi.nlm.nih.gov/articles/PMC13273331/`
> - Kapelle & Flecken 2025, *Language and Cognition* -- Perceiving colour through a language
>   lens: a scoping review → `cambridge.org/core/journals/...`
> - Bae, Olkkonen, Allred & Flombaum 2015, *JEP:General* -- Why some colors appear more
>   memorable than others → `sas.upenn.edu/~mariaol/files/BaeEtAlJEP2015.pdf`
> - Witzel 2015, *Journal of Vision* -- Categorical facilitation with equally discriminable
>   colors → `arvojournals.org/.../i1534-7362-15-8-22.pdf`
> - Wakui, Mylonas, Caparos & Davidoff 2025, *Color Research & Application* -- Categorical
>   color perception in a cross-lingual comparison of visual search →
>   `onlinelibrary.wiley.com/doi/`**`10.1002/col.22964`**

*(The prose is verbatim; the nine source lines are the document's own, with each link shown as
its host rather than in full. The three DOIs are bolded.)*

**This is not a bad answer.** It is current, it is hedged in several of the right places, and it
is the only one of the two that found the 2026 replication. Nothing in it is invented. What is
worth checking against it are facts rather than tone, and they fall in two groups.

**What a reader cannot trace.**

- **Three of the nine links carry a DOI.** The other six are a third-party mirror, a PubMed
  listing with a repository postprint beside it, a PMC record, a publisher's article page and
  two PDFs.
- **The canonical paper is linked to a mirror**, not to the paper. Winawer et al. 2007 goes to
  `fermatslibrary.com`, and by the session's own log the quotation drawn from it came off that
  page.
- **Six people are credited in the prose; three of them can be traced** to a work this document
  makes resolvable. The three that cannot are Bae, Martinovic and **Winawer** -- the canonical
  one, and unresolvable for the reason directly above: its only link is the mirror.

**What it asserts past its evidence.** Each of these is answered by a source *After*
holds and this one does not.

- **One replication is called *decisive*.** It is one paper. Across the thirteen claims
  *After* recorded, the statuses come out ten `single-result`, two `emerging`, one
  `contested` and **no `established` at all**, because a status here is arithmetic over author
  independence and one study does not move it.
- **The load-bearing negative claim carries no source at all.** *"The right-visual-field
  lateralisation has repeatedly come out bilateral or absent"* -- no citation. It is true, and
  *After* is where you find out why: `brederoo2019`, nine powered near-exact
  replications with Bayesian analysis.
- **Its central inference is stated as clean when the literature says it is not.** Occupying the
  language system makes the effect vanish, *"what you expect if people are covertly labelling,
  not seeing differently."* Pilling et al. 2003, *Is color "categorical perception" really
  perceptual?*, report that it survives verbal interference when the interference type is
  unpredictable, so the dual task is not a clean diagnostic. *After* says so in the same breath
  in which it makes the argument.
- **The history is missing, and it changes the story.** This reads as a case built and then
  recently collapsed. Kay and Kempton 1984 had already placed the effect in naming rather than
  in seeing, in an experiment built to block exactly that route. Its first author is Paul Kay,
  of *Basic Color Terms* -- the monograph that [eval 08](evals/scenarios/08-relativity.md)
  finds at four of five seeds on the citation graph and that no keyword search returned.

None of that is visible from the prose, which reads as settled throughout. It is visible from
`nullius audit`, which reads the document and nothing else, and from the column beside it.

</details>

<details>
<summary>the whole of the <b>After</b> answer, for this question</summary>

Verbatim, dashes normalised to this repository's convention. 355 words, and a
`nullius report` beside it holding the rest.

> # Does the language you speak change what you can see?
>
> Narrowly yes; in the way the question is usually meant, no.
>
> Language reliably changes *performance on perceptual tasks*. Winawer et al. report that
> Russian speakers, whose language obligatorily splits *goluboy* from *siniy*, discriminate
> boundary-crossing blues faster than within-category blues, while English speakers on
> identical stimuli do not [@winawer2007].
>
> Kay and Kempton set the shape of this literature: they found a Whorfian colour effect,
> proposed that it ran through a naming strategy, then ran a second experiment to block that
> strategy -- and it disappeared, as predicted [@kay1984]. Winawer's advantage likewise
> vanished under a verbal, but not a spatial, dual task -- the signature of online verbal
> comparison, not altered sensation. Pilling et al. complicate this, finding that categorical
> perception survived verbal interference when its type was unpredictable [@pilling2003].
>
> The strongest bid for a genuinely perceptual locus was lateralisation -- effects confined to
> the right visual field, hence to the language-dominant left hemisphere [@gilbert2005] --
> backed by ERP work on preattentive change detection [@thierry2009; @mo2011]. That bid is in
> trouble. A friendly replication found left-visual-field effects too [@drivonikou2007]; Brown
> and colleagues found none at green-blue by two methods [@brown2011]; and Brederoo et al.,
> across nine powered near-exact replications, found no evidence for the asymmetry at all
> [@brederoo2019]. Zhong et al. found the pattern shifts with whichever categorisation was
> primed first [@zhong2017].
>
> Pre-linguistic infants already discriminate categorically [@franklin2008; @ozturk2012], and
> naming across languages tracks near-optimal partitions of perceptual space [@regier2007] --
> the categories are not language's invention.
>
> Settled: language speeds and biases perceptual judgement. Unsettled: whether it reaches early
> vision. Lupyan et al. argue the perceptual/decisional split is itself unprincipled
> [@lupyan2020], much of why this stays open.
>
> ---
>
> *What this rests on:* 19 vocabularies over OpenAlex and Crossref plus a 6-hop walk; 639
> records screened, 91 kept. Two limits: the walk stopped at 46% known per hop, so the
> literature was still opening up, and paywalls held every source to abstract depth -- so each
> claim is what a study *reports*, not mechanism. Nearly all of it concerns colour. Full
> protocol, read depths and DOIs: nullius-report.md

**Every bracketed key above resolves.** And behind the answer sit thirteen claims, each with
what warrants it and how far its sources were read. Four of them, abridged where marked:

| claim | warrant | status | asserts | sources |
|---|---|---|---|---|
| Whether the lateralised (right-visual-field) Whorfian colour effect is real is contested: reported by its originators, found only partially in a friendly replication, absent at the green-blue boundary ... and absent in a powered nine-study Bayesian replication programme | `measured` | `contested` | `reports` | gilbert2005, drivonikou2007, brown2011, brederoo2019 |
| Pre-linguistic infants show faster discrimination across colour category boundaries than within them, so categorical colour discrimination does not require colour language | `replicated` | `emerging` | `reports` | franklin2008, ozturk2012 |
| A Whorfian colour effect was detected and then made to disappear in a second experiment specifically designed to block the hypothesised naming strategy ... | `measured` | `single-result` | `reports` | kay1984 |
| Cross-language colour naming is argued to reflect near-optimal partitions of an irregularly shaped perceptual colour space ... | `authors-claim` | `single-result` | `reports` | regier2007 |

**Nothing reached `established`**, because the independence arithmetic did not support it. No
row asserts `mechanism`: every source was read to abstract depth and a claim may not exceed its
source's read depth. And ten of the thirteen may not be written as a bare assertion, which the
report states where the session will see it.

That is the half a collaborator cannot reconstruct from the prose, and it is the half
*Before* does not have.

</details>

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

<details>
<summary>release channel, requirements, and the one email it wants</summary>

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

</details>

## First five minutes

<details>
<summary>the commands, in the order you meet them</summary>

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

When you try to finish, the gate says where you are and the one command that answers the
first thing holding it:

```
nullius: w (idea · calibration) · 3 open, 1 settled
  now   nullius close "<the answer, with its locator>"
  then  an idea unit with no search logged · no alternative recorded
  `nullius status --why` for what each means.
```

`nullius status` has the same two lines and then the full list, marked for which reasons are
facts and which are thresholds somebody chose.

</details>

## The commands you start with

<details>
<summary>the sixth of them you need on day one</summary>

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
any one spells out that command's. There is no `/nullius` slash command; this line used to
say there was. What reaches a session instead is a skill, which fires when you ask for work
the harness gates, and the whole vocabulary, which arrives at every session start inside a
project. The
reference lives there rather than here, because a table kept by hand goes stale and this one
had already started to.

</details>

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

**Two modes, and only two.** `certain` refuses on a fact; `advice` computes the same facts
and reports every one of them without refusing, which is what
[evals/control.md](evals/control.md) needs and what you want if you are trying the tool out.
A session in `advice` is told so at every start, because otherwise it believes it is being
gated and is not.

**Two things scope the rest.** `start --thread <name>` says which line of enquiry a unit
belongs to, and the gates read only that thread. And what crosses a context boundary is what
is still live on it: a search stops reciting its rows once everything is screened, a buried
idea is named when it shares a term with your question and counted when it does not. The
ledger keeps all of it; `compact` deletes only what `fulltext` can refetch.

## Closing the frontier

<details>
<summary>how the citation walk decides where to go and when to stop</summary>

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

</details>

## Handing it to someone

<details>
<summary>what `report` writes, and what it refuses to establish</summary>

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

</details>

## Four agents, and why they run blind

<details>
<summary>what each is for, and the two prohibitions that matter</summary>

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

</details>

## Where the rest of it is

This file is how to run the thing. The rest is not summarised here, which used to be claimed
one line above a summary of it.

- **[WHY.md](WHY.md)** -- the argument: what goes wrong by default, why more instructions do
  not fix it, and what this is not. Section 10 is the one thing you supply yourself.
- **[algorithms/](algorithms/)** -- one file per mechanism, each carrying the measurement that
  killed the naive version and a note on where it is still weak.
- **[evals/](evals/)** -- eight scenarios against live indexes, and
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
