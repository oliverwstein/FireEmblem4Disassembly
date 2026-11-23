#!/usr/bin/env python3
"""r.py NAME... : print routine bodies compactly, with callers."""
import glob, re, sys, subprocess
files = glob.glob('engine/**/*.asm', recursive=True)
text = {f: open(f).read().split('\n') for f in files}
hdr = re.compile(r'^\s+(r[ls][A-Za-z0-9_]+|a[A-Za-z0-9_]+|proc[A-Za-z0-9_]+) ; [0-9A-F]{2}/[0-9A-F]{4}')
skip = re.compile(r'^\s*(\.al|\.xl|\.as|\.xs|\.autsiz|\.databank.*|; [0-9A-F]{2}/[0-9A-F]{4})\s*$')
LIM=999
args=sys.argv[1:]
if args and args[0].startswith('-n'):
    LIM=int(args[0][2:]); args=args[1:]
for name in args:
    for f, lines in text.items():
        for i, l in enumerate(lines):
            if re.match(r'^\s+' + re.escape(name) + r' ; ', l):
                out = [f'### {f}:{i+1} {l.strip()}']
                j = i + 1
                while j < len(lines) and not hdr.match(lines[j]) and '.endsection' not in lines[j]:
                    s = lines[j]
                    if s.strip() and not skip.match(s):
                        out.append(s.rstrip()[6:] if s.startswith('      ') else s.rstrip())
                    j += 1
                print('\n'.join(out[:LIM+1]) + (f'\n  ... ({len(out)-1} lines)' if len(out)>LIM+1 else ''))
                refs = []
                for g, ls in text.items():
                    for k, m in enumerate(ls):
                        if re.search(r'\b' + re.escape(name) + r'\b', m.split(';')[0]) and not (g == f and k == i):
                            refs.append(f'{g.split("/")[-1]}:{k+1}')
                print('  refs:', ' '.join(refs[:12]), f'({len(refs)})' if len(refs) > 12 else '')
