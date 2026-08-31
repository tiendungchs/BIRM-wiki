#!/usr/bin/env python3
"""Set the `Closes when:` field on registry detail files. Reads `id<TAB>text`
lines on stdin. Idempotent: rewrites the field if it is already set."""
import sys,re,pathlib
W=pathlib.Path(__file__).resolve().parent.parent/"wiki"
n=0
for line in sys.stdin:
    line=line.rstrip("\n")
    if not line.strip(): continue
    rid,text=line.split("\t",1)
    d="gaps" if rid[0]=="G" else "tensions"
    f=W/d/f"{rid[0].lower()}{int(rid[1:]):03d}.md"
    if not f.exists(): sys.exit(f"missing {f}")
    t=f.read_text()
    new=f"**Closes when:** {text.strip()}"
    t2,k=re.subn(r'^\*\*Closes when:\*\* .*$',new.replace("\\","\\\\"),t,count=1,flags=re.M)
    if k!=1: sys.exit(f"{f}: no Closes when field")
    f.write_text(t2); n+=1
print(f"set {n}")
