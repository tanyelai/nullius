# Field: machine learning on clinical images and signals

## What counts as evidence

A held-out test set drawn from the same sites as training is not evidence of clinical use. The
claim a reviewer reads is transfer, so the evidence has to be **external**: another site,
another scanner or device, another population, or a prospective cohort. In-sample performance
supports *the model fits*, and nothing beyond it.

An improvement in AUC without a decision threshold and its operating characteristics does not
support a claim about clinical benefit, because a clinician acts at a threshold.

## Normal scale

Reviewers object below a few hundred subjects for a diagnostic claim, and below tens of
thousands of records for a screening one, though what matters more is the number of **positive
cases** and the number of **sites**. One site is a case study whatever the record count. Report
subjects, not images: ten images of one person are one person.

## Standard baselines

Compare against the clinical standard of care, not only against another network. A model that
beats ResNet and loses to the existing scoring rule has not made the point. Where a guideline
score exists for the task, its absence from the comparison is a material finding.

## Standard reporting

CLAIM and TRIPOD-AI for prediction models, STARD for diagnostic accuracy, CONSORT-AI for
trials. Whichever applies, its checklist is what belongs in the venue file, taken from the
statement itself.

State the split at the **subject** level and say so explicitly. Say which sites and which
devices. Say what happened to the excluded cases.

## Known traps

- **Leakage through subjects.** Two images of one patient across the split is the commonest
  fatal defect in this literature and it inflates everything.
- **Scanner and device shortcuts.** A model can learn the site rather than the disease when
  prevalence differs by site.
- **Label provenance.** A label read off a report is not the same object as a label read from
  the image, and a model trained on the first can learn the reporting habit.
- **The saturated benchmark.** Public sets with a decade of tuning behind them no longer
  separate methods.
- **Retrospective selection.** Cases chosen because they were interpretable are not the
  population the model would see.

## Words that mean two things

`validation` means a tuning split to one half of this field and a prospective study to the
other. `accuracy` is uninformative under class imbalance and is still reported. Register both
in terms.md the first time they appear in two senses.
