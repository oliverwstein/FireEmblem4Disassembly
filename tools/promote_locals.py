#!/usr/bin/env python3
"""Make code addresses that a pointer reaches into top-level routines.

usage: tools/promote_locals.py FILE ADDR... [--prefix rl]
       tools/promote_locals.py FILE --from-code-pointers

A proc or active sprite often switches to its next step by storing the step's
address in its on-cycle pointer:

    lda #$97E2
    sta aProcSystem.aHeaderOnCycle,b,x

When a chain of such steps was disassembled as one routine, the step is only a
local label (_97E2) or no label at all, and tools/code_pointers.py cannot write
the pointer as a label. This tool turns each ADDR (CPU address, e.g. 9F97E2)
in FILE into a routine of its own:

          _97E2                    ->     rlUnknown9F97E2 ; 9F/97E2

                                            .al
                                            .xl
                                            .autsiz
                                            .databank ?

The widths are the ones the engines call on-cycle routines with (16-bit A and
X). Local labels that end up in a different routine than a reference to them
are written as Routine._XXXX, everywhere in the source. --from-code-pointers
takes the addresses from tools/code_pointers.py's report ("is the local label",
"no routine label at") for FILE. Run tools/code_pointers.py --write and
./build.sh afterwards.
"""
import glob, os, re, subprocess, sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import asmlib

LIST_RE = re.compile(r'^(\d+)\t\.[0-9a-f]+\t([0-9a-f]{6})\t([0-9a-f ]*)\t+(.*)$')
TOP_RE = re.compile(r'^ {6}([A-Za-z]\w*)\b')
LOCAL_DEF_RE = re.compile(r'^ {8}(_\w+)\s*$')


def listing():
    with asmlib.repo_copy() as tmp:
        ok, log = asmlib.assemble(tmp, extra=('-L', 'list.txt', '--no-monitor', '--line-numbers'))
        if not ok:
            raise SystemExit('build failed:\n' + '\n'.join(asmlib.errors(log)[:10]))
        return open(os.path.join(tmp, 'list.txt'), encoding='utf-8', errors='replace').read().split('\n')


def line_of(lines, lst, addr):
    """Index in lines of the instruction or local label at addr (checked against the text)."""
    for l in lst:
        m = LIST_RE.match(l)
        if not m or int(m.group(2), 16) != addr:
            continue
        n = int(m.group(1)) - 1
        if 0 <= n < len(lines) and lines[n].rstrip() == m.group(4).rstrip():
            if m.group(3).strip() or LOCAL_DEF_RE.match(lines[n]):
                return n
    return None


def from_code_pointers(path):
    r = subprocess.run([sys.executable, 'tools/code_pointers.py'], capture_output=True, text=True)
    addrs = set()
    for l in r.stdout.split('\n'):
        if not l.strip().startswith(path + ':'):
            continue
        m = re.search(r'\$([0-9A-F]{2})/([0-9A-F]{4}) is the local label', l) or \
            re.search(r'no routine label at \$([0-9A-F]{2})/([0-9A-F]{4})', l)
        if m:
            addrs.add(int(m.group(1) + m.group(2), 16))
    return sorted(addrs)


def main():
    args = sys.argv[1:]
    if not args:
        raise SystemExit(__doc__)
    path = args[0]
    addrs = from_code_pointers(path) if '--from-code-pointers' in args else \
        [int(a.replace('$', '').replace('/', ''), 16) for a in args[1:] if not a.startswith('--')]
    lines = open(path, encoding='utf-8').read().split('\n')
    lst = listing()
    taken = set(re.findall(r'\b[A-Za-z]\w*\b', '\n'.join(open(f, encoding='utf-8').read()
                for f in glob.glob('engine/**/*.asm', recursive=True))))
    old_owner = owners(lines)
    inserts = {}
    for a in addrs:
        n = line_of(lines, lst, a)
        if n is None:
            print(f'${a >> 16:02X}/{a & 0xFFFF:04X}: no instruction starts there in {path}, skipped')
            continue
        name = f'rlUnknown{a:06X}'
        if name in taken:
            print(f'{name} already exists, skipped')
            continue
        header = [f'      {name} ; {a >> 16:02X}/{a & 0xFFFF:04X}', '', '        .al', '        .xl',
                  '        .autsiz', '        .databank ?', '']
        inserts[n] = (header, bool(LOCAL_DEF_RE.match(lines[n])), lines[n].strip())
        print(f'{name}')
    out = []
    promoted = {}
    for i, l in enumerate(lines):
        if i in inserts:
            header, replace, local = inserts[i]
            if out and out[-1].strip():
                out.append('')
            out += header
            if replace:
                promoted[(old_owner.get(i), local)] = header[0].split()[0]
                continue
        out.append(l)
    lines = out
    new_owner = owners(lines)
    # Where does each local now live? (owner routine, local) -> new owner
    defs = {}
    for i, l in enumerate(lines):
        m = LOCAL_DEF_RE.match(l)
        if m:
            defs.setdefault(m.group(1), []).append(new_owner[i])
    # Rewrite references inside the file.
    for i, l in enumerate(lines):
        code, sep, comment = l.partition(';')
        if LOCAL_DEF_RE.match(l) or not code.strip():
            continue
        me = new_owner.get(i)

        def fix(m):
            loc = m.group(1)
            where = defs.get(loc)
            if not where or me in where or len(set(where)) != 1:
                if not where and (old_owner_name(loc, promoted)):
                    return old_owner_name(loc, promoted)
                return m.group(0)
            return f'{where[0]}.{loc}'
        code2 = re.sub(r'(?<![\w.])(_[0-9A-Fa-f]\w*)\b', fix, code)
        lines[i] = code2 + sep + comment
    open(path, 'w', encoding='utf-8').write('\n'.join(lines))
    # Qualified references elsewhere: Old._XXXX where _XXXX moved or was promoted.
    for f in glob.glob('engine/**/*.asm', recursive=True) + ['build.asm']:
        t = open(f, encoding='utf-8').read()

        def fix_q(m):
            owner, loc = m.group(1), m.group(2)
            if (owner, loc) in promoted:
                return promoted[(owner, loc)]
            where = defs.get(loc)
            if where and owner not in where and len(set(where)) == 1 and \
                    any(o == owner for o in old_owner.values()):
                return f'{where[0]}.{loc}'
            return m.group(0)
        t2 = re.sub(r'\b([A-Za-z]\w*)\.(_[0-9A-Fa-f]\w*)\b', fix_q, t)
        if t2 != t:
            open(f, 'w', encoding='utf-8').write(t2)


def old_owner_name(loc, promoted):
    names = [v for (o, l), v in promoted.items() if l == loc]
    return names[0] if len(names) == 1 else None


def owners(lines):
    """{line index: name of the top-level label above it}."""
    cur, out = None, {}
    for i, l in enumerate(lines):
        m = TOP_RE.match(l)
        if m and not l.strip().startswith('.'):
            cur = m.group(1)
        out[i] = cur
    return out


if __name__ == '__main__':
    main()
