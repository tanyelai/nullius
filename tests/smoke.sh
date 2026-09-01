#!/usr/bin/env bash
# Both directions on every guard: a gate that only ever passes is not a gate.
# Offline -- the ledger is fabricated where a real resolution would need network.
set -uo pipefail

NULLIUS="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/bin/nullius"
WORK="$(mktemp -d)"; trap 'rm -rf "$WORK"' EXIT
cd "$WORK" || exit 1

pass=0; fail=0
ok()   { pass=$((pass+1)); }
bad()  { fail=$((fail+1)); printf '  FAIL  %s\n' "$1"; }

# expect_exit <code> <label> -- command on stdin-free argv
expect_exit() {
  local want="$1" label="$2"; shift 2
  local out; out="$("$@" 2>&1)"; local got=$?
  if [ "$got" = "$want" ]; then ok; else
    bad "$label: wanted exit $want, got $got"; printf '        %s\n' "${out%%$'\n'*}"
  fi
}

# expect_hook <event> <code> <label> <json>
expect_hook() {
  local event="$1" want="$2" label="$3" json="$4"
  local out; out="$(printf '%s' "$json" | python3 "$NULLIUS" _hook "$event" 2>&1)"
  local got=$?
  if [ "$got" = "$want" ]; then ok; else
    bad "$label: wanted exit $want, got $got"; printf '        %s\n' "${out%%$'\n'*}"
  fi
}

expect_grep() {
  local pat="$1" label="$2"; shift 2
  if "$@" 2>&1 | grep -q -- "$pat"; then ok; else bad "$label: no match for '$pat'"; fi
}

N() { python3 "$NULLIUS" "$@"; }

echo "nullius smoke, in $WORK"

# ---------------------------------------------------------------- setup ----
expect_exit 1 "commands refuse outside a project" python3 "$NULLIUS" status
expect_exit 0 "init"            python3 "$NULLIUS" init --field "test-field"
[ -f .nullius/config.json ] && ok || bad "init wrote no config"
[ -d .nullius/papers ] && [ -d .nullius/venues ] && ok || bad "init made no dirs"
[ -f .nullius/field.md ] && ok || bad "init copied no field template"
expect_exit 1 "init refuses twice" python3 "$NULLIUS" init

# ----------------------------------------------------------------- unit ----
expect_exit 0 "start"           python3 "$NULLIUS" start t1 write "does it hold"
expect_exit 1 "start refuses a second unit" python3 "$NULLIUS" start t2 read "x"
expect_grep "not declared" "status shows no acceptance" python3 "$NULLIUS" status

CWD_JSON="{\"cwd\":\"$WORK\"}"
expect_hook stop 2 "stop refuses with no acceptance question" "$CWD_JSON"

expect_exit 0 "accept"          python3 "$NULLIUS" accept "is the frame stated"
expect_exit 1 "accept refuses a silent rewrite" python3 "$NULLIUS" accept "something else"
expect_exit 1 "close refuses an answer with no locator" python3 "$NULLIUS" close "yes it is"
expect_exit 0 "close accepts a locator"  python3 "$NULLIUS" close "stated at draft.md:12"
expect_hook stop 0 "stop allows once acceptance closed" "$CWD_JSON"

# --------------------------------------------------------------- claims ----
expect_exit 1 "claim refuses a terminal assumption" \
  python3 "$NULLIUS" claim "x" --warrant assumed --status emerging
expect_exit 1 "claim refuses an unresolved source" \
  python3 "$NULLIUS" claim "x" --warrant measured --status emerging --source ghost2020

# a fabricated ledger: two works sharing an author, one independent of both
python3 - <<'PY'
import json, pathlib
A = {"id": "https://openalex.org/A1", "name": "Shared Author"}
B = {"id": "https://openalex.org/A2", "name": "Other One"}
C = {"id": "https://openalex.org/A3", "name": "Third Party"}
def rec(t, authors, retracted=False):
    return {"openalex": "https://openalex.org/W" + t, "doi": "10.1/" + t,
            "title": t, "year": 2021, "type": "article", "venue": "Test J",
            "peer_reviewed": True, "retracted": retracted, "authors": authors,
            "institutions": [], "cited_by": 1, "oa_url": None,
            "referenced_works": [], "resolved_at": "now", "index": "openalex"}
pathlib.Path(".nullius/refs.json").write_text(json.dumps({
    "alpha2021": rec("alpha", [A, B]),
    "beta2021":  rec("beta",  [A]),          # shares A with alpha -> one group
    "gamma2021": rec("gamma", [C]),          # disjoint -> a second group
    "bad2021":   rec("bad",   [C], True),    # retracted
}, indent=2))
PY

expect_exit 1 "claim refuses a source with no paper note" \
  python3 "$NULLIUS" claim "x" --warrant measured --status emerging --source alpha2021
expect_exit 1 "claim refuses a retracted source" \
  python3 "$NULLIUS" claim "x" --warrant measured --status emerging --source bad2021

expect_exit 0 "note at abstract depth" python3 "$NULLIUS" note alpha2021 --depth abstract
expect_exit 0 "note at method depth"   python3 "$NULLIUS" note beta2021  --depth method
expect_exit 0 "note gamma"             python3 "$NULLIUS" note gamma2021 --depth method

expect_exit 1 "read depth caps claim strength" \
  python3 "$NULLIUS" claim "the method explains it" --warrant measured \
    --status emerging --strength mechanism --source alpha2021
expect_exit 0 "the weaker claim is allowed at that depth" \
  python3 "$NULLIUS" claim "they report a gain" --warrant authors-claim \
    --status single-result --strength reports --source alpha2021

expect_exit 1 "established refuses one author group" \
  python3 "$NULLIUS" claim "settled" --warrant replicated --status established \
    --strength holds --source alpha2021 --source beta2021
expect_exit 0 "established accepts two independent groups" \
  python3 "$NULLIUS" claim "settled" --warrant replicated --status established \
    --strength holds --source beta2021 --source gamma2021

# --------------------------------------------------------------- drafts ----
printf 'We build on \\cite{alpha2021} and on [@gamma2021].\n' > good.md
printf 'As shown in \\cite{nosuchkey2019}.\n' > bad.md
printf 'Following \\cite{bad2021}.\n' > retracted.md

expect_exit 0 "check passes a draft whose citations resolve" python3 "$NULLIUS" check good.md
expect_exit 2 "check refuses an unresolved citation"         python3 "$NULLIUS" check bad.md
expect_exit 2 "check refuses a retracted citation"           python3 "$NULLIUS" check retracted.md

WRITE_OK="{\"cwd\":\"$WORK\",\"tool_name\":\"Write\",\"tool_input\":{\"file_path\":\"$WORK/x.md\",\"content\":\"see \\\\cite{alpha2021}\"}}"
WRITE_BAD="{\"cwd\":\"$WORK\",\"tool_name\":\"Write\",\"tool_input\":{\"file_path\":\"$WORK/x.md\",\"content\":\"see \\\\cite{ghost1999}\"}}"
WRITE_CODE="{\"cwd\":\"$WORK\",\"tool_name\":\"Write\",\"tool_input\":{\"file_path\":\"$WORK/x.py\",\"content\":\"see \\\\cite{ghost1999}\"}}"
expect_hook pre-write 0 "write allowed when the citation resolves"   "$WRITE_OK"
expect_hook pre-write 2 "write refused when the citation does not"   "$WRITE_BAD"
expect_hook pre-write 0 "non-draft files are none of its business"   "$WRITE_CODE"

# --------------------------------------------------------------- budget ----
expect_exit 0 "track the draft" python3 "$NULLIUS" artifact good.md
python3 -c "open('good.md','a').write(' word'*400)"
python3 - <<'PY'
import json, pathlib
p = pathlib.Path(".nullius/work/current.json"); u = json.loads(p.read_text())
u["budget"] = {"words": 50}; p.write_text(json.dumps(u, indent=2))
PY
expect_hook stop 2 "stop refuses an untraded overrun" "$CWD_JSON"
expect_exit 0 "trade prices the overrun" python3 "$NULLIUS" trade "cut the related work"
expect_hook stop 0 "stop allows once the overrun is priced" "$CWD_JSON"

# --------------------------------------------------------------- survey ----
expect_exit 0 "done"  python3 "$NULLIUS" done
expect_exit 0 "start a survey unit" python3 "$NULLIUS" start s1 survey "what exists"
expect_exit 0 "accept it" python3 "$NULLIUS" accept "the frontier is closed"
expect_exit 0 "close it"  python3 "$NULLIUS" close "closed at coverage:0-unscreened"
python3 - <<'PY'
import json, pathlib
pathlib.Path(".nullius/searches").mkdir(parents=True, exist_ok=True)
pathlib.Path(".nullius/searches/2026-01-01-q.json").write_text(json.dumps({
    "id": "2026-01-01-q", "query": "q", "vocabulary": "mine", "when": "now",
    "found": 40, "results": [
        {"title": "one", "year": 2020, "doi": None, "screened": None, "reason": None},
        {"title": "two", "year": 2021, "doi": None, "screened": "include",
         "reason": "on topic"}]}, indent=2))
PY
expect_hook stop 2 "a survey unit cannot close on an unscreened work" "$CWD_JSON"
expect_exit 0 "screen it" python3 "$NULLIUS" screen 2026-01-01-q exclude "off topic" --index 0
expect_hook stop 0 "a chosen threshold reports but never ends the turn" "$CWD_JSON"
expect_grep "systemMessage" "and it reaches the person, not the model" \
  bash -c "printf %s \"$CWD_JSON\" | python3 \"$NULLIUS\" _hook stop"
expect_grep "chosen" "the vocabulary count is marked as chosen, not a fact" \
  python3 "$NULLIUS" status
expect_grep "unscreened" "coverage names what is unscreened" python3 "$NULLIUS" coverage

# ------------------------------------------------- sources with no index ----
expect_exit 1 "a non-indexed source needs a title" \
  python3 "$NULLIUS" cite "https://example.org/post" --kind blog
expect_exit 0 "a blog is citable" \
  python3 "$NULLIUS" cite "https://example.org/post" --kind blog --title "A post" --year 2026
expect_exit 0 "a book chapter is citable" \
  python3 "$NULLIUS" cite "isbn:000" --kind chapter --title "A chapter" --year 2020 --author "Ada Lovelace"
expect_grep "example2026" "the citekey comes from the domain when there is no author" \
  python3 "$NULLIUS" cite "https://example.org/post" --kind blog --title "A post"

expect_exit 0 "note the blog"    python3 "$NULLIUS" note example2026 --depth method
expect_exit 0 "note the chapter" python3 "$NULLIUS" note lovelace2020 --depth method
expect_exit 1 "a blog cannot make a claim established" \
  python3 "$NULLIUS" claim "widely settled" --warrant consensus --status established \
    --strength holds --source example2026 --source gamma2021
expect_exit 0 "a book chapter can carry textbook status" \
  python3 "$NULLIUS" claim "the standard account" --warrant consensus --status textbook \
    --strength holds --source lovelace2020 --source gamma2021

# ------------------------------------------------------- bulk screening -----
python3 - <<'PYIN'
import json, pathlib
pathlib.Path(".nullius/searches/2026-02-02-r.json").write_text(json.dumps({
    "id": "2026-02-02-r", "query": "r", "vocabulary": "second", "when": "now",
    "found": 3, "results": [
        {"title": "cited", "year": 2020, "cited_by": 40, "screened": None, "reason": None},
        {"title": "uncited a", "year": 2026, "cited_by": 0, "screened": None, "reason": None},
        {"title": "uncited b", "year": 2026, "cited_by": 0, "screened": None, "reason": None}]},
    indent=2))
PYIN
expect_grep "excluded 2 by rule" "one rule screens the uncited tail" \
  python3 "$NULLIUS" screen 2026-02-02-r exclude "no citations yet" --below-citations 1
expect_grep "cited_by<1" "and the rule itself is recorded, not just its effect" \
  cat .nullius/searches/2026-02-02-r.json
expect_exit 1 "screen needs an index or a rule" \
  python3 "$NULLIUS" screen 2026-02-02-r include "x"

# ------------------------------------------------------ verbatim quoting ----
expect_exit 1 "quote refuses when no text was retrievable" \
  python3 "$NULLIUS" quote alpha2021 "anything"
mkdir -p .nullius/cache/text
printf 'the method improves recall by twelve percent on the held-out split\n' \
  > .nullius/cache/text/alpha2021.txt
expect_exit 0 "quote passes on the real string" \
  python3 "$NULLIUS" quote alpha2021 "improves recall by twelve percent"
expect_exit 2 "quote refuses a near miss" \
  python3 "$NULLIUS" quote alpha2021 "improves recall by twenty percent"

# ------------------------------------- what the review turned up, pinned ----
# unknown is not zero: a rule about citation counts must not sweep away the rows
# no index reported a count for.
python3 - <<'PYIN'
import json, pathlib
pathlib.Path(".nullius/searches/2026-03-03-u.json").write_text(json.dumps({
    "id": "2026-03-03-u", "query": "u", "vocabulary": "third", "when": "now",
    "found": 90, "retrieved": 3, "results": [
        {"title": "known zero", "year": 2020, "cited_by": 0, "screened": None, "reason": None},
        {"title": "unknown", "year": 2024, "cited_by": None, "screened": None, "reason": None},
        {"title": "cited", "year": 2019, "cited_by": 90, "screened": None, "reason": None}]},
    indent=2))
PYIN
expect_grep "excluded 1 by rule" "a citation rule sweeps only the counts it has" \
  python3 "$NULLIUS" screen 2026-03-03-u exclude "none yet" --below-citations 1
expect_grep "unknown is not zero" "and says why it left the rest alone" \
  python3 "$NULLIUS" screen 2026-03-03-u exclude "none yet" --below-citations 1

# a budget nothing measures looks like a working gate and is not one
expect_exit 0 "open a budgeted unit with nothing tracked" \
  python3 "$NULLIUS" start b write "x" --words 10 --force
expect_exit 0 "accept it" python3 "$NULLIUS" accept "does it hold"
expect_exit 0 "close it"  python3 "$NULLIUS" close "shown in the Methods section"
expect_hook stop 2 "a declared budget with no tracked draft refuses the stop" "$CWD_JSON"
expect_grep "nothing is measuring it" "and names the omission" python3 "$NULLIUS" status
printf 'one two three\n' > tracked.md
expect_exit 0 "track something" python3 "$NULLIUS" artifact tracked.md
expect_hook stop 0 "and allows once a draft is tracked" "$CWD_JSON"

# a locator is anything the next reader can turn to -- and "yes" is not
for good in "shown in Table 2" "see the Limitations" "draft.tex:88"; do
  python3 "$NULLIUS" accept "q" --force >/dev/null 2>&1
  expect_exit 0 "locator accepted: $good" python3 "$NULLIUS" close "$good"
done
for bad in "yes it is" "trust me" "obviously"; do
  python3 "$NULLIUS" accept "q" --force >/dev/null 2>&1
  expect_exit 1 "locator refused: $bad" python3 "$NULLIUS" close "$bad"
done

# the attribution heuristic reports a bare assertion and stays quiet on an
# attributed one -- a check that can never fire is dead weight
python3 "$NULLIUS" claim "the effect is large and general" --warrant authors-claim \
  --status single-result --strength reports --source alpha2021 >/dev/null 2>&1
printf 'The effect is large and general. We build on this.\n' > bare.md
printf 'Smith et al. report the effect is large and general.\n' > cued.md
expect_grep "bare assertion" "a weak claim written flat is reported" \
  python3 "$NULLIUS" check bare.md
expect_grep "clean" "the same claim, attributed, is not" \
  python3 "$NULLIUS" check cued.md

# threads were promised by the documentation and written by nothing
expect_grep "no threads yet" "an empty thread list says so" python3 "$NULLIUS" thread
expect_exit 0 "open a thread" python3 "$NULLIUS" thread "sample-efficiency"
[ -f .nullius/threads/sample-efficiency.md ] && ok || bad "thread file not written"
expect_grep "sample-efficiency" "and it lists" python3 "$NULLIUS" thread
expect_grep "Threads open" "the session gate surfaces open threads" \
  bash -c "printf %s \"$CWD_JSON\" | python3 \"$NULLIUS\" _hook session-start"

# independence by name is weaker than independence by identifier, and says so
expect_grep "name matching" "a name-matched group is flagged on the claim" \
  python3 "$NULLIUS" claim "settled by name-matched groups" --warrant replicated \
    --status established --strength holds --source lovelace2020 --source gamma2021

# ------------------------------------------- the venue completeness walk ----
expect_exit 0 "open a unit against a venue that has no file" \
  python3 "$NULLIUS" start v write "x" --venue conf --artifact paper.tex --force
expect_grep "no .nullius/venues/conf.md" "a declared venue with no file is a fact" \
  python3 "$NULLIUS" status
expect_exit 1 "and the walk itself refuses to invent one" python3 "$NULLIUS" walk

cat > .nullius/venues/conf.md <<'VENUE'
## Format

- limit: 8 pages
- words: 4000

## Required sections

- Introduction
- Related Work | Background
- Method | Approach | min 150
- Limitations | Threats to Validity | min 60
- Ethics Statement
VENUE
cat > paper.tex <<'PAPER'
\section{Introduction}
This studies a thing at enough length to be a section rather than a placeholder heading,
with words in it.

\section{Background}
Prior work exists and is described here with a reasonable number of words in the body.

\section{Approach}
We propose a method. It is short.

\subsection{Details}
More words that belong to the approach rather than to a new top-level section of the paper.

\section{Threats to Validity}
The sample is small.
PAPER
expect_exit 0 "accept it" python3 "$NULLIUS" accept "is the method defensible"
expect_exit 0 "close it"  python3 "$NULLIUS" close "in the Approach section"
expect_grep "Related Work" "an alias satisfies its entry" python3 "$NULLIUS" walk
expect_grep "under the 150" "the minimum comes from the venue file, per section" \
  python3 "$NULLIUS" walk
expect_grep "4000" "and so does the word budget" python3 "$NULLIUS" status
expect_grep "ABSENT   Ethics Statement" "an entry with no heading is absent" \
  python3 "$NULLIUS" walk
expect_hook stop 2 "an absence nobody looked at refuses the stop" "$CWD_JSON"
expect_grep "conf.md:" "and the finding cites a line in the venue file" \
  python3 "$NULLIUS" status
expect_exit 1 "elsewhere has to name where" \
  python3 "$NULLIUS" section "Ethics Statement" elsewhere
expect_exit 0 "disposition it" \
  python3 "$NULLIUS" section "Ethics Statement" planned "after registration"
expect_hook stop 0 "and the stop is allowed once every absence has a word about it" "$CWD_JSON"
expect_grep "chosen" "a thin section is reported, never enforced" python3 "$NULLIUS" status

# a placeholder must not clobber a real value from the layer beneath it
export XDG_CONFIG_HOME="$WORK/xdgconf"
expect_exit 0 "set a user-level contact" \
  python3 "$NULLIUS" config contact person@example.edu
[ -f "$XDG_CONFIG_HOME/nullius/config.json" ] && ok || bad "user config not written"
expect_grep "person@example.edu" "and the project reads it back" \
  python3 "$NULLIUS" config contact
python3 - <<'PYIN'
import json, pathlib
p = pathlib.Path(".nullius/config.json"); c = json.loads(p.read_text())
c["contact"] = ""                      # exactly what a placeholder looks like
p.write_text(json.dumps(c, indent=2))
PYIN
expect_grep "person@example.edu" "an empty project value does not clobber it" \
  python3 "$NULLIUS" config contact
expect_grep "not in .nullius" "and the project config never holds the address" \
  bash -c "grep -q person@example.edu .nullius/config.json && echo in .nullius || echo not in .nullius"

echo
echo "  $pass passed, $fail failed"
[ "$fail" -eq 0 ]
