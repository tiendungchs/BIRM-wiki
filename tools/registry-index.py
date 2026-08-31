#!/usr/bin/env python3
"""Rebuild the registry index tables from the per-row detail files.

  wiki/gaps/g*.md      -> table in wiki/architectural-gaps.md
  wiki/tensions/t*.md  -> table in wiki/empirical-tensions.md

Everything above the table header and below the table is left untouched, so the
prose in the index pages is hand-maintained and the table never is. Files under
<dir>/closed/ are ignored: retiring a row is `git mv`, nothing else.
"""
import re, sys, pathlib

W = pathlib.Path(__file__).resolve().parent.parent / "wiki"
PAGES = list((W/"concepts").glob("*.md")) + list((W/"entities").glob("*.md"))
TXT = [p.read_text() for p in PAGES]

SPEC = {
    "gaps":     dict(index="architectural-gaps.md", pfx="g", noun="Gap",
                     toks={"OPEN","PARTIAL","CONTESTED","CLOSED"}, kind=True),
    "tensions": dict(index="empirical-tensions.md", pfx="t", noun="Tension",
                     toks={"LIVE","LEANING","BOTH","RESOLVED"}, kind=False),
}

def cited_by(rid):
    pat = re.compile(r'(?<![A-Za-z0-9])' + rid + r'(?![0-9A-Za-z])')
    return sum(1 for t in TXT if pat.search(t))

def read_row(f, S):
    t = f.read_text()
    m = re.match(r'# ([A-Z]\d+) — (.+)', t.split("\n")[0])
    if not m: sys.exit(f"{f}: bad H1")
    rid, title = m.group(1), m.group(2).strip()
    st = re.search(r'^\*\*Status:\*\* `([^`]+)`', t, re.M)
    if not st: sys.exit(f"{f}: no Status field")
    for tok in st.group(1).split("/"):
        if tok not in S["toks"]: sys.exit(f"{f}: bad status token {tok!r}")
    kind = re.search(r'^\*\*Kind:\*\* `([^`]+)`', t, re.M)
    if S["kind"] and not kind: sys.exit(f"{f}: no Kind field")
    return rid, title, st.group(1), (kind.group(1) if kind else None)

def main():
    problems = 0
    for key, S in SPEC.items():
        d = W / key
        rows = sorted(d.glob(S["pfx"] + "[0-9]*.md"), key=lambda p: int(p.stem[1:]))
        out = []
        for f in rows:
            rid, title, st, kind = read_row(f, S)
            n = cited_by(rid)
            if n == 0:
                print(f"warn: {rid} is cited by no concept or entity page", file=sys.stderr)
                problems += 1
            cells = [rid, title] + ([kind] if S["kind"] else []) + [f"`{st}`", str(n),
                     f"[[wiki/{key}/{f.name}]]"]
            out.append("| " + " | ".join(cells) + " |")
        hdr = ["#", S["noun"]] + (["Kind"] if S["kind"] else []) + ["Status", "Cited by", "Detail"]
        table = ["| " + " | ".join(hdr) + " |",
                 "|" + "---|" * len(hdr)] + out
        p = W / S["index"]
        lines = p.read_text().split("\n")
        a = next(i for i, l in enumerate(lines) if l.startswith("| #"))
        b = max(i for i, l in enumerate(lines) if l.startswith("|"))
        p.write_text("\n".join(lines[:a] + table + lines[b+1:]))
        print(f"{S['index']}: {len(out)} rows")
    print(f"{problems} row(s) cited by no concept or entity page", file=sys.stderr)
    return 0

if __name__ == "__main__":
    sys.exit(main())
