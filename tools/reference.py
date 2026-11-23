#!/usr/bin/env python3
"""Generate the reference index in docs/reference/ from the source.

usage: tools/reference.py [--check]

Writes, and overwrites, only generated files:

  docs/reference/routines/<folder>.md   one page per folder of engine/: each file's
                                        header comment, then every named routine
                                        and table in it, with its comment, the
                                        routines and events that call or point at
                                        it, and the routines it calls;
  docs/reference/ram.md                 every name in include/WRAM.h with its
                                        address and comment, and how many places
                                        use it;
  docs/reference/INDEX.md               every named label, alphabetically, with
                                        the page it is on.

"Named" means the label does not contain "Unknown". Unknown routines are only
counted (per file), since their entries would say nothing yet; they appear as
callers and callees under their own names.

The hand-written system overviews (docs/reference/<system>.md) are not touched.
--check exits 1 if the generated files would change (to catch a stale index).
"""
import datetime
import argparse
import collections
import glob
import os
import re
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OUT = 'docs/reference'
TOP = re.compile(r'^ {6}([A-Za-z_]\w*)\b(.*?);\s*([0-9A-F]{2})/?([0-9A-F]{4})\s*$')
IDENT = re.compile(r'[A-Za-z_][A-Za-z0-9_]*(?:\._?[A-Za-z0-9_]+)?')
CALL = re.compile(r'^\s*(jsl|jsr|jml|jmp|RUN_ASM)\b\s*\(?\s*([A-Za-z_]\w*)')
DIRECTIVES = ('.al', '.as', '.xl', '.xs', '.autsiz', '.databank')
NOTE = re.compile(r'^; (Found by tools/sweep\.py|Found through fe4\.cdl)')


def strip_comment(line):
    i = line.find(';')
    return line if i < 0 else line[:i]


def read_files():
    files = sorted(glob.glob('engine/**/*.asm', recursive=True))
    return {f: open(f, encoding='utf-8').read().split('\n') for f in files}


def parse(files):
    """labels: name -> dict(file, line, addr, comment, body (start, end))."""
    labels = {}
    for f, lines in files.items():
        tops = [(i, m) for i, l in enumerate(lines) if (m := TOP.match(l))]
        for k, (i, m) in enumerate(tops):
            end = tops[k + 1][0] if k + 1 < len(tops) else len(lines)
            # A routine ends at its section's end too.
            for j in range(i + 1, end):
                if '.endsection' in lines[j]:
                    end = j
                    break
            comment, started = [], False
            for j in range(i + 1, end):
                t = lines[j].strip()
                if not t:
                    if comment:
                        comment.append('')
                    continue
                if t.startswith(DIRECTIVES):
                    continue
                if t.startswith(';'):
                    if re.match(r';\s*[0-9A-F]{2}/[0-9A-F]{4}$', t) or NOTE.match(t):
                        continue
                    comment.append(t[1:].strip())
                    continue
                break
            text = ' '.join(comment).strip()
            text = re.sub(r'\s{2,}', ' ', text)
            labels[m.group(1)] = dict(file=f, line=i + 1, addr=f'${m.group(3)}/{m.group(4)}',
                                      comment=text, start=i, end=end,
                                      table=not m.group(1).startswith(('rl', 'rs')))
    return labels


def references(files, labels):
    """callers[name] = set of (kind, referrer); callees[name] = list of names."""
    callers = collections.defaultdict(set)
    callees = collections.defaultdict(list)
    for f, lines in files.items():
        current = None
        for i, line in enumerate(lines):
            m = TOP.match(line)
            if m:
                current = m.group(1)
                continue
            code = strip_comment(line)
            if not code.strip() or current is None:
                continue
            c = CALL.match(code)
            for ident in IDENT.findall(code):
                name = ident.split('.')[0]
                if name not in labels or name == current:
                    continue
                kind = 'call' if c and c.group(2) == name else 'ref'
                callers[name].add((kind, current))
                if kind == 'call' and name not in callees[current]:
                    callees[current].append(name)
    for f in sorted(glob.glob('events/**/*.asm', recursive=True)):
        ev = os.path.splitext(os.path.basename(f))[0]
        for line in open(f, encoding='utf-8'):
            code = strip_comment(line)
            for ident in IDENT.findall(code):
                name = ident.split('.')[0]
                if name in labels:
                    callers[name].add(('event', ev))
    return callers, callees


def named(n):
    return 'Unknown' not in n


def anchor(n):
    return n.lower()


def link(n, labels, here):
    if n not in labels or not named(n):
        return f'`{n}`'
    page = page_of(labels[n]['file'])
    target = '' if page == here else f'{os.path.basename(page)}'
    return f'[`{n}`]({target}#{anchor(n)})'


def page_of(f):
    parts = f.split('/')
    folder = parts[1] if len(parts) > 2 else 'engine'
    return f'{OUT}/routines/{folder}.md'


def file_header(lines):
    out = []
    for l in lines:
        t = l.strip()
        if t.startswith(';'):
            out.append(t[1:].strip())
        elif t:
            break
        elif out:
            break
    return ' '.join(out)


def write_routine_pages(files, labels, callers, callees):
    pages = collections.defaultdict(list)
    for f in files:
        pages[page_of(f)].append(f)
    written = {}
    for page, fs in sorted(pages.items()):
        folder = os.path.splitext(os.path.basename(page))[0]
        out = [f'# `engine/{folder}/`', '',
               f'Generated by `tools/reference.py` from the source on {datetime.date.today().isoformat()}; do not edit. '
               'Each entry gives the comment from the source, then who uses the label '
               '(*calls*: jsl/jsr/jml/jmp/RUN_ASM; *points at*: any other mention, such as a '
               'table entry or a pointer load; *events*: event scripts) and what it calls. '
               '`Unknown` routines are only counted.', '']
        for f in sorted(fs):
            names = [n for n, d in labels.items() if d['file'] == f]
            names.sort(key=lambda n: labels[n]['line'])
            known = [n for n in names if named(n)]
            out += [f'## [{os.path.basename(f)}](../../../{f})', '']
            h = file_header(files[f])
            if h:
                out += [h, '']
            unknown = len(names) - len(known)
            out += [f'{len(known)} named, {unknown} `Unknown`.', '']
            for n in known:
                d = labels[n]
                out.append(f'### `{n}`')
                out.append('')
                out.append(f'{d["addr"]} · [{f}:{d["line"]}](../../../{f}#L{d["line"]})')
                out.append('')
                if d['comment']:
                    out += [d['comment'], '']
                refs = callers.get(n, set())
                calls = sorted({r for k, r in refs if k == 'call'})
                points = sorted({r for k, r in refs if k == 'ref'} - set(calls))
                events = sorted({r for k, r in refs if k == 'event'})
                if calls:
                    out.append('- Called by: ' + ', '.join(link(r, labels, page) for r in calls))
                if points:
                    out.append('- Pointed at by: ' + ', '.join(link(r, labels, page) for r in points))
                if events:
                    out.append('- Events: ' + ', '.join(f'`{e}`' for e in events))
                if not (calls or points or events):
                    out.append('- Nothing in the source refers to it.')
                if callees.get(n):
                    out.append('- Calls: ' + ', '.join(link(c, labels, page) for c in callees[n]))
                out.append('')
        written[page] = '\n'.join(out).rstrip() + '\n'
    return written


def write_ram(files):
    text = open('include/WRAM.h', encoding='utf-8').read().split('\n')
    rows = []
    rx = re.compile(r'^\s+([A-Za-z_]\w*)\s+\.(word|byte|long|fill|block|dstruct|\w+)\b[^;]*;\s*\$([0-9A-Fa-f]{6})\s*(?:;\s*(.*))?$')
    for l in text:
        m = rx.match(l)
        if m:
            rows.append((m.group(1), m.group(2), m.group(3).upper(), (m.group(4) or '').strip()))
    uses = collections.Counter()
    names = {r[0] for r in rows}
    for lines in files.values():
        for line in lines:
            for ident in re.findall(r'[A-Za-z_]\w*', strip_comment(line)):
                if ident in names:
                    uses[ident] += 1
    out = ['# RAM', '',
           f'Generated by `tools/reference.py` from [include/WRAM.h](../../include/WRAM.h) on {datetime.date.today().isoformat()}; do not edit. '
           '*Uses* counts the lines of `engine/` that name the variable.', '',
           '| Address | Name | Type | Uses | Comment |', '|---|---|---|---|---|']
    for name, kind, addr, comment in rows:
        out.append(f'| `${addr[:2]}:{addr[2:]}` | `{name}` | {kind} | {uses[name]} | {comment.replace("|", "/")} |')
    named_rows = sum(1 for r in rows if 'Unknown' not in r[0])
    out[4:4] = [f'{len(rows)} names, {named_rows} of them not `Unknown`.', '']
    return {f'{OUT}/ram.md': '\n'.join(out) + '\n'}


def write_index(labels):
    out = ['# Index', '', f'Generated by `tools/reference.py` on {datetime.date.today().isoformat()}; do not edit. Every named routine and table in `engine/`.', '']
    letter = None
    for n in sorted((n for n in labels if named(n)), key=str.lower):
        stem = re.sub(r'^(rl|rs|proc|a|g|gc|ac|dialogue)(?=[A-Z0-9])', '', n)
        first = stem[:1].upper()
        if first != letter:
            letter = first
            out += ['', f'## {letter}', '']
        page = os.path.basename(page_of(labels[n]['file']))
        out.append(f'- [`{n}`](routines/{page}#{anchor(n)}) {labels[n]["addr"]}')
    return {f'{OUT}/INDEX.md': '\n'.join(out) + '\n'}


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    ap.add_argument('--check', action='store_true')
    args = ap.parse_args()
    os.chdir(ROOT)
    files = read_files()
    labels = parse(files)
    callers, callees = references(files, labels)
    out = {}
    out.update(write_routine_pages(files, labels, callers, callees))
    out.update(write_ram(files))
    out.update(write_index(labels))
    stale = [p for p, t in out.items() if not os.path.exists(p) or open(p, encoding='utf-8').read() != t]
    if args.check:
        for p in stale:
            print('stale:', p)
        sys.exit(1 if stale else 0)
    os.makedirs(f'{OUT}/routines', exist_ok=True)
    for p in stale:
        open(p, 'w', encoding='utf-8').write(out[p])
    n = sum(1 for x in labels if named(x))
    print(f'{len(out)} pages ({len(stale)} changed); {n} named labels of {len(labels)}')


if __name__ == '__main__':
    main()
