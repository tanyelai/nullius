#!/usr/bin/env bash
# The gate, runnable here. CI runs this same file, so green locally means green
# there: the checks are not written twice and cannot disagree.
#
# Every check below is here because this repo shipped that defect once.
set -uo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.."

pass=0; fail=0
ok()  { pass=$((pass+1)); printf '  ok    %s\n' "$1"; }
bad() { fail=$((fail+1)); printf '  FAIL  %s\n' "$1"; }
run() {
  local name="$1"; shift
  local out; out="$("$@" 2>&1)"
  if [ $? -eq 0 ]; then ok "$name"; else bad "$name"; printf '%s\n' "$out" | sed 's/^/        /'; fi
}

echo "nullius preflight"
echo

out="$(bash tests/smoke.sh 2>&1)"
if printf '%s' "$out" | grep -q ' 0 failed'; then
  ok "smoke, $(printf '%s' "$out" | grep -o '[0-9]* passed')"
else
  bad "smoke"; printf '%s\n' "$out" | tail -20 | sed 's/^/        /'
fi

if command -v claude >/dev/null 2>&1; then
  run "manifest: plugin"      claude plugin validate .claude-plugin/plugin.json --strict
  run "manifest: marketplace" claude plugin validate .claude-plugin/marketplace.json --strict
  # First-party check that plugin.json and the marketplace entry agree about the
  # version. -f drops its clean-tree and tag-exists checks, which belong to a
  # release rather than to a working tree somebody is still editing; what survives
  # is the agreement check, and that one has teeth: a conflicting version in the
  # marketplace entry exits 1 and says which side wins at install time.
  run "manifest: the two agree on the version" claude plugin tag . --dry-run -f
else
  echo "  skip  claude is not on PATH, so the structural checks below stand alone"
fi

python3 - <<'PY'
import json,sys,re,io,os,glob,xml.dom.minidom
bad=[]
def check(c,m):
    if not c: bad.append(m)

for p in [".claude-plugin/plugin.json",".claude-plugin/marketplace.json","hooks/hooks.json"]:
    try: d=json.load(io.open(p,encoding="utf-8"))
    except Exception as e: bad.append(f"{p}: {e}"); continue
    if p.endswith("/plugin.json"):
        check(re.fullmatch(r"\d+\.\d+\.\d+", d.get("version","")), "plugin.json: version is not semver")
    if p.endswith("marketplace.json"):
        pl=d.get("plugins") or []
        check(len(pl)==1, "marketplace.json: expected exactly one plugin")
        if pl:
            src=pl[0].get("source")
            check(isinstance(src,dict),
                  "marketplace.json: source must be a pinned object. A relative path serves "
                  "whatever the default branch holds, so every commit to main would reach users.")
            if isinstance(src,dict):
                check(src.get("ref")=="stable", "marketplace.json: source.ref must be 'stable'")
            check("version" not in pl[0],
                  "marketplace.json: do not set version here. plugin.json wins silently, so a "
                  "version here can only mislead.")

v=json.load(io.open(".claude-plugin/plugin.json",encoding="utf-8"))["version"]
check(re.search(rf"^## \[?{re.escape(v)}", io.open("CHANGELOG.md",encoding="utf-8").read(), re.M),
      f"CHANGELOG.md has no section for {v}, so a release of it would ship an unexplained version")

for f in glob.glob("**/*.md",recursive=True):
    if ".git" in f: continue
    for m in re.finditer(r'!?\[[^\]]*\]\(([^)#][^)]*)\)', io.open(f,encoding="utf-8").read(), re.S):
        t=m.group(1).split('#')[0].strip()
        if t.startswith(("http","mailto")): continue
        check(os.path.exists(os.path.normpath(os.path.join(os.path.dirname(f),t))),
              f"{f}: dead link {t}")

head={"#"+re.sub(r'[^a-z0-9 -]','',h.lower()).replace(' ','-')
      for h in re.findall(r'^#+ (.+)$', io.open("README.md",encoding="utf-8").read(), re.M)}
for f in glob.glob("**/*.md",recursive=True):
    if ".git" in f: continue
    for m in re.finditer(r'\]\((README\.md)?(#[a-z0-9-]+)\)', io.open(f,encoding="utf-8").read()):
        if f=="README.md" or m.group(1):
            check(m.group(2) in head, f"{f}: dead anchor {m.group(2)}")

for f in glob.glob("**/*",recursive=True):
    if ".git" in f or not os.path.isfile(f): continue
    if os.path.splitext(f)[1] not in (".md",".sh",".json",".svg",".yml",".yaml"): continue
    try: t=io.open(f,encoding="utf-8").read()
    except Exception: continue
    for d,n in ((chr(0x2014),"em"),(chr(0x2013),"en")):
        check(d not in t, f"{f}: contains an {n} dash")

for f in sorted(glob.glob("assets/*.svg")):
    try: xml.dom.minidom.parse(f)
    except Exception as e: bad.append(f"{f}: not well-formed XML: {e}"); continue
    t=io.open(f,encoding="utf-8").read()
    check('role="img"' in t,  f'{f}: no role="img"')
    check('aria-label' in t,  f"{f}: no aria-label, so a reader who cannot see it gets nothing")

n=len(glob.glob("evals/scenarios/*.md"))
word={1:"one",2:"two",3:"three",4:"four",5:"five",6:"six",7:"seven",8:"eight",9:"nine",
      10:"ten",11:"eleven",12:"twelve"}.get(n,str(n))
for f in ("README.md","CHANGELOG.md","evals/README.md"):
    t=io.open(f,encoding="utf-8").read()
    if re.search(r"(one|two|three|four|five|six|seven|eight|nine|ten|\d+) (scenarios|runs)", t):
        check(re.search(rf"{word} (scenarios|runs)", t),
              f"{f}: claims a scenario count that is not {word}, and there are {n} scenario files")

for b in bad: print(f"  FAIL  {b}")
sys.exit(1 if bad else 0)
PY
if [ $? -eq 0 ]; then ok "structural: manifests, links, anchors, dashes, figures, counts"
else fail=$((fail+1)); fi

python3 - <<'PY'
import re,io,subprocess,sys
h=subprocess.run(["python3","bin/nullius","--help"],capture_output=True,text=True).stdout
real=set(re.findall(r'[\{,]([a-z][a-z-]+)', h)) | set(re.findall(r'^\s{2,4}([a-z][a-z-]+)\s{2,}', h, re.M))
m=re.search(r'## The commands you start with(.*?)^## ', io.open("README.md",encoding="utf-8").read(), re.S|re.M)
named=set(re.findall(r'`([a-z][a-z-]+)`', m.group(1))) if m else set()
missing=sorted(named-real)
if missing:
    print(f"  FAIL  README names commands the CLI does not have: {', '.join(missing)}")
    sys.exit(1)
if not named:
    print("  FAIL  could not find the command table in README, so nothing was checked")
    sys.exit(1)
PY
if [ $? -eq 0 ]; then ok "README names only commands the CLI has"; else fail=$((fail+1)); fi

echo
echo "  $pass passed, $fail failed"
[ $fail -eq 0 ] || exit 1
