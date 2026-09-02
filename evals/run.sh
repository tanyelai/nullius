#!/usr/bin/env bash
# One scenario, against live indexes, in a throwaway project.
# Records what happened and whether each expectation held, in both directions.
set -uo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
N="$ROOT/bin/nullius"
S="${1:?usage: run.sh <01..06>}"
WORK="$(mktemp -d)"; OUT="$ROOT/evals/results/$S-$(date -u +%Y-%m-%d).md"
mkdir -p "$ROOT/evals/results"
pass=0; fail=0; blocked=0
say() { printf '%s\n' "$*" | tee -a "$OUT" >/dev/null; }
log() { printf '%s\n' "$*"; say "$@"; }

# expect <refuse|allow> "<label>" <cmd...>
expect() {
  local want="$1" label="$2"; shift 2
  local out rc
  out="$("$@" 2>&1)"; rc=$?
  if printf '%s' "$out" | grep -q "rate limiting this session"; then
    blocked=$((blocked+1)); log "- [ ] **blocked by the index** · $label"; return
  fi
  case "$want" in
    refuse) [ "$rc" -ne 0 ] && { pass=$((pass+1)); log "- [x] refused · $label"; } \
                            || { fail=$((fail+1)); log "- [ ] **PERMITTED, should refuse** · $label"; \
                                 say '  ```'; say "  ${out:0:300}"; say '  ```'; } ;;
    allow)  [ "$rc" -eq 0 ] && { pass=$((pass+1)); log "- [x] allowed · $label"; } \
                            || { fail=$((fail+1)); log "- [ ] **REFUSED, should allow** · $label"; \
                                 say '  ```'; say "  ${out:0:300}"; say '  ```'; } ;;
    report) printf '%s' "$out" | grep -qiE "$3" >/dev/null 2>&1 ;;
  esac
}
nl() { python3 "$N" "$@"; }
# a fact the stop gate reports. Cleaner than nesting a grep inside bash -c, where the
# exit code of the pipeline is easy to get backwards.
expect_fact() {
  local pat="$1" label="$2"
  if nl status 2>&1 | grep -qi -- "$pat"; then pass=$((pass+1)); log "- [x] refused · $label"
  else fail=$((fail+1)); log "- [ ] **NOT REPORTED, should refuse** · $label"; fi
}
note() { say ""; say "$*"; say ""; }

cd "$WORK" || exit 1
say "# eval $S · $(date -u +%Y-%m-%dT%H:%MZ)"
say ""
say "Run in \`$WORK\`, against live indexes."
say ""

case "$S" in
01) # is a gap real, or did the search fail --- speculative decoding
  nl init --field "natural language processing" >/dev/null
  nl start gap idea "is it known when speculative decoding changes output quality, not only latency" >/dev/null
  nl accept "has anyone characterised a quality cost of draft-and-verify decoding" >/dev/null
  say "## the search"; say '```'
  nl lit '"speculative decoding"' --vocabulary field --limit 8 2>&1 | head -14 | tee -a "$OUT" >/dev/null
  sleep 4
  nl lit '"draft and verify" language model inference' --vocabulary mine --limit 6 2>&1 | head -4 | tee -a "$OUT" >/dev/null
  sleep 4
  nl lit '"lossless acceleration" decoding' --vocabulary adjacent --limit 6 2>&1 | head -4 | tee -a "$OUT" >/dev/null
  say '```'
  note "## expectations"
  nl close "no such work exists, per the Method section" >/dev/null
  expect_fact "no search logged\|empty neighbour set" "the stop, with nothing screened in"
  SID=$(ls .nullius/searches 2>/dev/null | head -1); SID=${SID%.json}
  [ -n "$SID" ] && nl screen "$SID" include "nearest work on the quality question" --index 0 >/dev/null 2>&1
  [ -n "$SID" ] && nl screen "$SID" exclude "latency only" --all-remaining >/dev/null 2>&1
  expect_fact "no killing assumption" "the stop, with no killing assumption"
  nl kills "if a quality-cost characterisation exists in any of the three vocabularies, the gap is not real" >/dev/null
  expect_fact "no cost estimate" "the stop, with no cost estimate"
  nl cost "reading time only; no compute, no data collection" >/dev/null
  expect refuse "an acceptance answer with no locator"  nl close "nothing found"
  expect allow  "closing once all four are done, with a locator"  nl close "searched three vocabularies, see coverage:vocabularies-3"
  expect allow  "and the stop, once the unit has done its work"  bash -c "printf '%s' '{\"cwd\":\"$PWD\"}' | python3 '$N' _hook stop"
  say ""; say "## coverage"; say '```'; nl coverage 2>&1 | head -8 | tee -a "$OUT" >/dev/null; say '```'
  ;;
02) # cover a literature --- machine unlearning evaluation
  nl init --field "natural language processing" >/dev/null
  nl start sv survey "how is a claim that a model has forgotten something tested" >/dev/null
  nl accept "is the frontier closed on unlearning evaluation" >/dev/null
  say "## the search"; say '```'
  nl lit '"machine unlearning" evaluation' --vocabulary field --limit 8 2>&1 | head -12 | tee -a "$OUT" >/dev/null
  sleep 4
  nl lit '"forgetting" "membership inference" model' --vocabulary adjacent --limit 6 2>&1 | head -4 | tee -a "$OUT" >/dev/null
  say '```'
  note "## expectations"
  nl close "closed, see coverage:0-unscreened" >/dev/null
  expect_fact "never screened" "the stop, with work still unscreened"
  SID=$(ls .nullius/searches 2>/dev/null | head -1); SID=${SID%.json}
  [ -n "$SID" ] && nl screen "$SID" include "an evaluation method, not an application" --index 0 >/dev/null 2>&1
  for f in .nullius/searches/*.json; do g=$(basename "$f" .json); nl screen "$g" exclude "not an evaluation method" --all-remaining >/dev/null 2>&1; done
  expect_fact "never been walked" "the stop, while a kept work has never been walked"
  say ""; say "## the walk"; say '```'
  nl snowball --both --depth 1 --limit 8 --no-context 2>&1 | head -16 | tee -a "$OUT" >/dev/null
  say '```'
  expect_fact "were never screened" "the stop, with the walk's own results unscreened"
  for f in .nullius/searches/*.json; do g=$(basename "$f" .json)
    nl screen "$g" exclude "reached by the walk, not an evaluation method" --all-remaining >/dev/null 2>&1; done
  expect allow "the stop, once the walk's results are screened too"  bash -c "printf '%s' '{\"cwd\":\"$PWD\"}' | python3 '$N' _hook stop"
  say ""; say "## coverage"; say '```'; nl coverage 2>&1 | head -8 | tee -a "$OUT" >/dev/null; say '```'
  ;;
03) # read one paper --- mixture-of-experts routing
  nl init --field "natural language processing" >/dev/null
  nl start rd read "how are tokens routed to experts and what does it cost" >/dev/null
  nl accept "does the paper state what happens when an expert is overloaded" >/dev/null
  say "## resolving"; say '```'
  nl cite 2101.03961 --first 2>&1 | head -6 | tee -a "$OUT" >/dev/null
  say '```'
  KEY=$(python3 -c "import json;d=json.load(open('.nullius/refs.json'));print(list(d)[0] if d else '')" 2>/dev/null)
  note "## expectations"
  if [ -z "$KEY" ]; then blocked=$((blocked+1)); log "- [ ] **blocked by the index** · the paper did not resolve"; else
    expect refuse "a claim from a source with no note at all"  nl claim "routing is learned" --warrant measured --status single-result --strength reports --source "$KEY"
    say ""; say "## full text"; say '```'; nl fulltext "$KEY" 2>&1 | head -8 | tee -a "$OUT" >/dev/null; say '```'
    nl note "$KEY" --depth abstract >/dev/null
    expect refuse "a mechanism claim from a source read to abstract"  nl claim "the router balances load because of the auxiliary loss" --warrant measured --status single-result --strength mechanism --source "$KEY"
    expect allow  "the weaker claim the depth does support"  nl claim "they report a routing scheme" --warrant authors-claim --status single-result --strength reports --source "$KEY"
    expect refuse "established from a single author group"  nl claim "settled" --warrant replicated --status established --strength holds --source "$KEY"
    if [ -f ".nullius/cache/text/$KEY.txt" ]; then
      expect refuse "a quote that is not in the cached text"  nl quote "$KEY" "this exact sentence is certainly not in the paper anywhere at all"
      expect allow  "a quote that is"  nl quote "$KEY" "expert"
    else
      log "- [ ] no machine-readable full text, so the verbatim gate could not be exercised"
    fi
    expect allow "closing with a locator"  nl close "stated in the Method section"
  fi
  ;;
04) # write a proposal --- watermarking robustness
  nl init --field "natural language processing" >/dev/null
  mkdir -p .nullius/venues
  cat > .nullius/venues/house.md <<'V'
## Format
- limit: a short project description
- words: 1200
## Required sections
- Plain words | In plain words
- Why it is open | Why this is open
- What would be proved | The claim
- Plan A
- What is checked and what is not
- Next steps
## Recommendation scale
rework / discuss / accept
V
  nl start pr write "draft it" --venue house --artifact prop.md >/dev/null
  nl accept "does the proposal state something that could fail" >/dev/null
  note "## expectations"
  expect refuse "a budget declared with no draft tracked"  bash -c "printf '%s' '{\"cwd\":\"$PWD\"}' | python3 '$N' _hook stop"
  cat > prop.md <<'P'
# Does a watermark survive being rewritten

## In plain words
A watermark is a statistical signature planted in generated text. The question is whether it
survives paraphrase, and nobody agrees on how much paraphrase is a fair test.

## Why this is open
The attack and the defence are evaluated on different paraphrasers, so results do not compare.

## The claim
A detection bound stated as a function of edit distance rather than of a named paraphraser.

## Plan A
Fix an edit-distance budget, sweep it, and report detection as a curve rather than a point.

## What is checked and what is not
Checked: nothing yet. Not checked: whether such a bound already exists.

## Next steps
Search the two venue families this has not reached.
P
  nl artifact prop.md >/dev/null
  say "## the walk"; say '```'; nl walk 2>&1 | head -12 | tee -a "$OUT" >/dev/null; say '```'
  expect allow "the walk runs and finds the sections under their aliases"  nl walk
  printf '\nRecent work (arXiv:2301.10226) is the one everybody cites.\n' >> prop.md
  expect refuse "a bare identifier that has never resolved"  nl check prop.md
  say ""; say "## resolving it"; say '```'; nl cite 2301.10226 --first 2>&1 | head -4 | tee -a "$OUT" >/dev/null; say '```'
  expect allow "the same draft once the identifier resolves"  nl check prop.md
  printf '\nKirchenbauer and colleagues report a green-list scheme.\n' >> prop.md
  expect allow "an attributed name whose work is resolved"  nl check prop.md
  printf '\nNobodyhere et al. showed it first.\n' >> prop.md
  expect refuse "an attributed name with nothing behind it"  nl check prop.md
  expect allow "closing with a locator"  nl close "stated in The claim section"
  ;;
05) # critique --- reviewing a proposal
  nl init --field "natural language processing" >/dev/null
  mkdir -p .nullius/venues
  cat > .nullius/venues/house.md <<'V'
## Format
- words: 1200
## Required sections
- Plain words | In plain words
- Limitations | What this does not do
## Recommendation scale
rework / discuss / accept
V
  cat > draft.md <<'P'
# Does a watermark survive being rewritten

## In plain words
A watermark is a statistical signature planted in generated text, and the question is whether
it survives paraphrase, which nobody currently tests the same way twice.

## What this does not do
- A human paraphrase study: established elsewhere and would need its own paper
- Anything about image watermarks
P
  nl start cr critique "does this go out" --venue house --artifact draft.md >/dev/null
  note "## expectations"
  nl accept "make it better" >/dev/null; nl close "in the In plain words section" >/dev/null
  expect_fact "no terminating answer" "accepting on an ask with no terminating answer"
  nl accept "does this go out as it stands" --force >/dev/null
  nl close "in the In plain words section" >/dev/null
  expect refuse "a finding written before the draft's own boundary was read"  nl finding material evidential "add a human paraphrase study" --at "draft.md:9"
  say ""; say "## the boundary the draft declares"; say '```'; nl scope 2>&1 | head -10 | tee -a "$OUT" >/dev/null; say '```'
  expect refuse "a finding citing no referent"  nl finding material enhancement "it would be stronger with more" --at "draft.md:4"
  expect allow  "a defensible finding, discharged"  nl finding defensible evidential "one paraphraser bounds the claim" --at "draft.md:5"
  expect refuse "re-raising it, reworded"  nl finding material evidential "one paraphraser, bounds the claim" --at "draft.md:5"
  expect refuse "a verdict outside the venue's own scale"  nl verdict "looks-fine"
  nl verdict rework >/dev/null
  expect_fact "zero fatal and zero material" "rework with nothing that generates work"
  expect allow  "the honest verdict"  nl verdict accept
  expect_fact "without saying why" "a boundary row that excludes with no reason"
  sed -i.bak 's/- Anything about image watermarks/- Anything about image watermarks: a different signal and a different attack/' draft.md
  expect allow  "and then the critique is finished, once every row says why"  bash -c "printf '%s' '{\"cwd\":\"$PWD\"}' | python3 '$N' _hook stop"
  ;;
06) # interpret --- influence functions at scale
  nl init --field "natural language processing" >/dev/null
  nl start ip interpret "did the approximation hold at scale" >/dev/null
  nl accept "does the influence estimate track leave-one-out retraining" >/dev/null
  nl close "at results.md:12" >/dev/null
  note "## expectations"
  expect_fact "no decisive observation" "closing with no decisive observation named"
  expect refuse "reading before there is anything to read against"  nl reading "0.31 rank correlation"
  expect allow  "naming what would change the conclusion"  nl decisive "rank correlation with leave-one-out above 0.5 on any subset"
  expect_fact "never recorded what was actually observed" "closing with the prediction made and nothing observed"
  expect allow  "recording what was observed"  nl reading "0.31, which is below the line, so the approximation did not hold"
  expect allow  "and then it closes"  bash -c "printf '%s' '{\"cwd\":\"$PWD\"}' | python3 '$N' _hook stop"
  nl start ip2 interpret "what did we see" --force >/dev/null
  nl claim "a result that arrives inside this unit" --warrant mine-unpublished \
     --status single-result --strength reports >/dev/null 2>&1
  expect refuse "naming the number silently once a result arrives inside the unit"  nl decisive "anything above 0.5"
  expect allow  "unless it is labelled exploratory"  nl decisive "anything above 0.5" --post-hoc
  expect allow  "and the label crosses a context boundary"  bash -c "printf '%s' '{\"cwd\":\"$PWD\"}' | python3 '$N' _hook session-start | grep -q 'framed after the results\\|post-hoc'"
  ;;
07) # a rate limit is a delay, not a stop
  nl init --field "natural language processing" >/dev/null
  note "## expectations"
  out="$(NULLIUS_FORCE_RATELIMIT=openalex python3 "$N" lit '"retrieval augmented generation" evaluation' --vocabulary fb --limit 5 2>&1)"
  say '```'; printf '%s\n' "$out" | head -6 | tee -a "$OUT" >/dev/null; say '```'
  if printf '%s' "$out" | grep -q "retrieved [1-9]"; then pass=$((pass+1)); log "- [x] allowed · lit still returns works with openalex refusing"
  else fail=$((fail+1)); log "- [ ] **returned nothing** · lit with openalex refusing"; fi
  if printf '%s' "$out" | grep -q "openalex (rate limited)"; then pass=$((pass+1)); log "- [x] recorded · the refusal is named, not hidden"
  else fail=$((fail+1)); log "- [ ] **silent** · the refusal was not named"; fi
  if printf '%s' "$out" | grep -qi "ran through crossref"; then pass=$((pass+1)); log "- [x] recorded · and which index answered instead"
  else fail=$((fail+1)); log "- [ ] **silent** · no note about which index answered"; fi
  nl cite 10.1145/3626772.3657834 --first >/dev/null 2>&1
  wout="$(NULLIUS_FORCE_RATELIMIT=openalex python3 "$N" snowball --refs --both --limit 5 --no-context 2>&1)"
  say '```'; printf '%s\n' "$wout" | head -4 | tee -a "$OUT" >/dev/null; say '```'
  if printf '%s' "$wout" | grep -qE "[1-9][0-9]* new"; then pass=$((pass+1)); log "- [x] allowed · the walk still reaches works"
  else fail=$((fail+1)); log "- [ ] **stopped** · the walk reached nothing"; fi
  if grep -q "semanticscholar" .nullius/searches/*snowball*.json 2>/dev/null; then
    pass=$((pass+1)); log "- [x] recorded · every row says it came from the fallback"
  else fail=$((fail+1)); log "- [ ] **untraceable** · rows do not name the fallback index"; fi
  if python3 -c "import json,glob,sys; d=json.load(open(glob.glob('.nullius/searches/*fb*.json')[0])); sys.exit(0 if d['unreachable'] and d['indexes'] else 1)" 2>/dev/null; then
    pass=$((pass+1)); log "- [x] recorded · the log carries indexes and unreachable"
  else fail=$((fail+1)); log "- [ ] **not logged** · the search log lost the provenance"; fi
  ;;
*) echo "no scenario $S"; exit 1 ;;
esac

say ""
say "## result"
say ""
say "| passed | failed | blocked by the index |"
say "|---|---|---|"
say "| $pass | $fail | $blocked |"
printf '\n  %s: %s passed, %s failed, %s blocked -> %s\n' "$S" "$pass" "$fail" "$blocked" "$OUT"
rm -rf "$WORK"
[ "$fail" -eq 0 ]
