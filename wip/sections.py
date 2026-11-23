import re, json, sys
g=json.load(open('wip/cg.json'))
def sections(f):
    out=[]; cur=None
    for l in open(f):
        m=re.match(r'\s*\.section (\S+)',l)
        if m: cur=[m.group(1),[]]; out.append(cur); continue
        m=re.match(r'^\s+((?:r[ls]|a|proc|g)[A-Za-z0-9_]+) ; ([0-9A-F]{2}/[0-9A-F]{4})',l)
        if m and cur: cur[1].append(m.group(1))
    return out
if __name__=='__main__':
    f=sys.argv[1]; lo,hi=sys.argv[2],sys.argv[3]
    for s,rs in sections(f):
        if not rs: continue
        a=g.get(rs[0],{}).get('addr','')
        if not (lo<=a<=hi): continue
        callers=set()
        for r in rs:
            for c in g.get(r,{}).get('callers',[]):
                if c not in rs: callers.add(c)
        print(a, s, ' '.join(rs)[:110], '<-', ' '.join(sorted(callers))[:140])
