import glob, re, sys, collections, json
files = glob.glob('engine/**/*.asm', recursive=True)
hdr = re.compile(r'^\s+((?:r[ls]|proc|a)[A-Za-z0-9_]+) ; ([0-9A-F]{2}/[0-9A-F]{4})')
routines = {}  # name -> dict
order = []
for f in files:
    cur = None
    for i, l in enumerate(open(f)):
        m = hdr.match(l)
        if m:
            cur = m.group(1); routines[cur] = dict(file=f, line=i+1, addr=m.group(2), lines=0, calls=set(), ram=set(), text=[])
            order.append(cur); continue
        if '.endsection' in l: cur = None; continue
        if cur:
            code = l.split(';')[0]
            if code.strip():
                routines[cur]['lines'] += 1
                for w in re.findall(r'\b((?:r[ls]|proc|a)[A-Za-z0-9_]+)\b', code):
                    routines[cur]['calls'].add(w)
                for w in re.findall(r'\$7F[EF][0-9A-F]{3}|\$0[0-9A-F]{3},b|\$21[0-9A-F]{2}|\$43[0-9A-F]{2}', code):
                    routines[cur]['ram'].add(w)
callers = collections.defaultdict(set)
for n, r in routines.items():
    for c in r['calls']:
        if c in routines and c != n: callers[c].add(n)
json.dump({n: dict(file=r['file'], addr=r['addr'], lines=r['lines'], calls=sorted(c for c in r['calls'] if c in routines and c != n), ram=sorted(r['ram']), callers=sorted(callers[n])) for n, r in routines.items()}, open('wip/cg.json', 'w'))
