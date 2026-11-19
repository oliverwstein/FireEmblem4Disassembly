#!/usr/bin/env python3
"""Write proc definitions and scripts that are not in the build yet as source.

usage: tools/proc_scripts.py FILE

Collects every proc definition that has a label or that built code creates
(rlProcEngineCreateProc and the like), decodes its script (tools/procs.py), and
writes each stretch of script that still comes from the base ROM to FILE as a
routines file, using the PROC_* macros in include/Procs.h. A definition without
a label gets its header written too, as procUnknownXXXXXX. Script labels follow
the project's convention: the script of procFoo is aProcFooCode.

Check FILE with tools/test_routines.py and place it with tools/place_routines.py.
"""
import os, sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import procs
from asmlib import read_rom, offset
from disasm import Disassembler, load_labels
from trace import CREATORS, built_routines, coverage_mask, definitions


def proc_definitions(rom, labels):
    name_of = lambda a: (labels.get(a) or [None])[0]
    defs = {a for a, names in labels.items()
            if a >= 0x800000 and any(n.startswith('proc') for n in names)}
    for a, name, m8, x8 in built_routines():
        insns, _ = Disassembler(rom, labels, a, None, m8, x8).decode()
        for ptr, creator in definitions(insns, name_of):
            if CREATORS[creator] == (2, 4):
                defs.add(ptr)
    return sorted(defs)


def main():
    if len(sys.argv) != 2:
        raise SystemExit(__doc__)
    rom, labels = read_rom(), load_labels('labels.txt')
    mask = coverage_mask()

    def name_of(a):
        names = labels.get(a, [])
        known = [n for n in names if 'Unknown' not in n] or names
        return known[0] if known else None

    def covered(a, n):
        return any(mask[offset(a + i)] for i in range(n))

    entries = {}                      # address -> text
    script_label = {}                 # script start -> its label
    defs = proc_definitions(rom, labels)

    # Scripts first, so that headers can refer to them by name.
    for d in defs:
        proc = name_of(d) or f'procUnknown{d:06X}'
        script = procs.header(rom, d)[2]
        if not script or script in script_label:
            continue
        commands, _, problems = procs.walk(rom, script)
        if problems:
            print(f'{proc}: unknown command words at {", ".join(f"{a:06X}" for a, _ in problems)}; skipped')
            continue
        base = 'a' + proc[0].upper() + proc[1:] + 'Code'
        script_label[script] = name_of(script) or (None if covered(script, 2) else base)
        # Leave out commands already in the build.
        commands = {a: c for a, c in commands.items() if not covered(a, c[2])}
        run_labels = {}
        for start, end, _ in procs.runs(commands):
            run_labels[start] = name_of(start) or (base if start == script else f'{base}{start & 0xFFFF:04X}')
        for start, end, _ in procs.runs(commands):
            if start not in entries:
                entries[start] = procs.render(rom, commands, start, end, run_labels[start], run_labels,
                                              lambda a, r=run_labels: r.get(a) or name_of(a))

    # Then the headers of definitions that have no label yet.
    for d in defs:
        if covered(d, 8) or name_of(d):
            continue
        init, cycle, script = procs.header(rom, d)
        text = rom[offset(d):offset(d) + 2]
        if not all(0x20 <= b < 0x7F for b in text):
            continue
        fields = [(name_of(x) or f'${x:06X}') if x else '$0000' for x in (init, cycle)]
        code = (script_label.get(script) or name_of(script) or f'${script:06X}') if script else '$0000'
        entries[d] = (f'      procUnknown{d:06X} ; {d >> 16:02X}/{d & 0xFFFF:04X}\n\n'
                      f'        .structProcInfo "{text.decode()}", {fields[0]}, {fields[1]}, {code}\n')

    out = ['; Proc definitions and scripts written by tools/proc_scripts.py.\n']
    out += [entries[a] for a in sorted(entries)]
    open(sys.argv[1], 'w', encoding='utf-8').write('\n'.join(out))
    print(f'wrote {len(entries)} entries to {sys.argv[1]}')


if __name__ == '__main__':
    main()
