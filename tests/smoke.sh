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
expect_exit 0 "screen it" python3 "$NULLIUS" screen 2026-01-01-q 0 exclude "off topic"
expect_hook stop 0 "a chosen threshold reports but never ends the turn" "$CWD_JSON"
expect_grep "systemMessage" "and it reaches the person, not the model" \
  bash -c "printf %s \"$CWD_JSON\" | python3 \"$NULLIUS\" _hook stop"
expect_grep "chosen" "the vocabulary count is marked as chosen, not a fact" \
  python3 "$NULLIUS" status
expect_grep "unscreened" "coverage names what is unscreened" python3 "$NULLIUS" coverage

echo
echo "  $pass passed, $fail failed"
[ "$fail" -eq 0 ]
