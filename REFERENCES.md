# References

Every mechanism in this harness is an answer to a failure somebody has already
characterised. This file is where those characterisations live, so a design decision can be
argued with rather than taken on trust.

Each identifier below was resolved with `nullius cite` rather than written from memory,
which is the same bar the tool holds a user's draft to. If one is wrong, that is a finding.

## What a claim is worth

| | |
|---|---|
| **Ioannidis (2005)**, *Why Most Published Research Findings Are False*, PLoS Medicine | [10.1371/journal.pmed.0020124](https://doi.org/10.1371/journal.pmed.0020124) |

The base rate that makes `single-result` a distinct status rather than a pedantic one. A
finding from one study, one setting, is more likely wrong than right in most fields, and
the prose has to carry that rather than flatten it into a bare assertion.

| | |
|---|---|
| **Open Science Collaboration (2015)**, *Estimating the reproducibility of psychological science*, Science | [10.1126/science.aac4716](https://doi.org/10.1126/science.aac4716) |
| **Baker (2016)**, *1,500 scientists lift the lid on reproducibility*, Nature | [10.1038/533452a](https://doi.org/10.1038/533452a) |

Why `established` needs **independent** replication computed from author sets rather than
declared. Replication that shares a lab is not the check it looks like, and the measured
gap between "published" and "replicates" is what the status axis exists to keep visible.

## Why the evidence bar is where it is

| | |
|---|---|
| **Greenland et al. (2016)**, *Statistical tests, P values, confidence intervals, and power: a guide to misinterpretations*, European Journal of Epidemiology | [10.1007/s10654-016-0149-3](https://doi.org/10.1007/s10654-016-0149-3) |

Twenty-five documented misreadings of a p-value. The `statistician` lens and the rule that
a claim of *size* needs an effect size rather than a significance test come from here.

| | |
|---|---|
| **Simmons, Nelson & Simonsohn (2011)**, *False-Positive Psychology*, Psychological Science | [10.1177/0956797611417632](https://doi.org/10.1177/0956797611417632) |
| **Kerr (1998)**, *HARKing: Hypothesizing After the Results are Known*, Personality and Social Psychology Review | [10.1207/s15327957pspr0203_4](https://doi.org/10.1207/s15327957pspr0203_4) |

Why an `interpret` unit must name the number that would change its conclusion **before** the
results are opened. Researcher degrees of freedom are not dishonesty; they are what happens
when the analysis decision comes after the data, and the only fix is ordering.

| | |
|---|---|
| **Rosenthal (1979)**, *The file drawer problem and tolerance for null results*, Psychological Bulletin | [10.1037/0033-2909.86.3.638](https://doi.org/10.1037/0033-2909.86.3.638) |

Why `falsified.md` is a first-class file. The result you did not write down does not stop
existing; it stops being available to you, and then you run it again.

## Why the search protocol is a protocol

| | |
|---|---|
| **Page et al. (2021)**, *The PRISMA 2020 statement*, BMJ | [10.1136/bmj.n71](https://doi.org/10.1136/bmj.n71) |

The found / screened / included counts, the requirement that an exclusion carry a reason,
and the idea that a bulk rule beats forty individual judgements because a reader can
disagree with it in one place. This harness runs a much lighter version of PRISMA, and says
so: it is a discipline for one person's reading, not a registered systematic review.

## The indexes, and what they can carry

| | |
|---|---|
| **Priem, Piwowar & Orr (2022)**, *OpenAlex: A fully-open index of scholarly works, authors, venues, institutions, and concepts* | [arXiv:2205.01833](https://arxiv.org/abs/2205.01833) |
| **Peroni & Shotton (2020)**, *OpenCitations, an infrastructure organization for open scholarship*, Quantitative Science Studies | [10.1162/qss_a_00023](https://doi.org/10.1162/qss_a_00023) |
| **Piwowar et al. (2018)**, *The state of OA*, PeerJ | [10.7717/peerj.4375](https://doi.org/10.7717/peerj.4375) |

Author identifiers are what make the independence check set arithmetic rather than a
judgement, and open-access location data is what makes "reach the paper by some legal
route" a real promise rather than an aspiration. The measured OA share in the last of these
is why hunting for a preprint copy is worth doing before concluding a paper is unreachable.

## Why the harness is gates rather than instructions

| | |
|---|---|
| **Liu et al. (2024)**, *Lost in the Middle: How Language Models Use Long Contexts*, TACL | [10.1162/tacl_a_00638](https://doi.org/10.1162/tacl_a_00638) |

Instructions in the middle of a long context are the ones that stop being followed. A rule
that must survive there loses; a gate that fires outside the model does not have to.

| | |
|---|---|
| **Zheng et al. (2023)**, *Judging LLM-as-a-Judge with MT-Bench and Chatbot Arena* | [arXiv:2306.05685](https://arxiv.org/abs/2306.05685) |

Verbosity bias: a model judging output rewards length. That is backwards for a `referee`
whose most valuable finding is often that nothing more is needed, which is why the agent is
told about the bias explicitly and why "zero material findings" is defined as a verdict
rather than as a short list.

## The failures this tool gates against, as other people found them

| | |
|---|---|
| **Foster et al. (2026)**, *AI Research Preference Models* | [arXiv:2608.13940](https://arxiv.org/abs/2608.13940) |

Budget allocation across candidates you cannot all run. Shaped like the retrieval problem here
and solved with a learned preference model, which is why it is discussed in
[algorithms/retrieval.md](algorithms/retrieval.md) as a direction considered and declined.

| | |
|---|---|
| *Phantom References: Hallucinated Citations That Survive Peer Review at Top-Tier Venues* (2026) | [arXiv:2607.00738](https://arxiv.org/abs/2607.00738) |
| *HalluCiteChecker: A Lightweight Toolkit for Hallucinated Citation Detection* (2026) | [arXiv:2604.26835](https://arxiv.org/abs/2604.26835) |

The premise of the citation guard, argued by people who measured it. The first states the
auditability argument better than this repository did and reports fabricated references
surviving peer review; the second is a standalone tool for the same check.

| | |
|---|---|
| *Confidence-Based Stopping Methods for Systematic Reviews* (2026) | [arXiv:2606.15380](https://arxiv.org/abs/2606.15380) |
| *Stopping Methods for Technology Assisted Reviews based on Point Processes* (2023) | [arXiv:2311.08597](https://arxiv.org/abs/2311.08597) |

When to stop screening, studied properly and targeting recall rather than saturation. The
saturation signal here is a crude proxy for what these estimate, and
[algorithms/graph.md](algorithms/graph.md) says so.

| | |
|---|---|
| *How Far Are AI Scientists from Changing the World?* (2025) | [arXiv:2507.23276](https://arxiv.org/abs/2507.23276) |

The autonomous-agent programme this tool is deliberately not part of.

---

## What is deliberately not cited here

The claim that this design works. It has not been evaluated against a control, the severity
classes are uncalibrated, and no inter-rater agreement has been measured. Where a number in
this repository was chosen rather than measured, the tool reports it as chosen, and the
same rule applies to the repository's own claims about itself.
