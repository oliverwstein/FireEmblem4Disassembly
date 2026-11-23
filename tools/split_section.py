#!/usr/bin/env python3
"""Split a section at a label and move the rest of it into another file as a new section.

usage: tools/split_section.py FILE SECTION LABEL NEW_FILE NEW_SECTION

Everything in SECTION from LABEL on moves to NEW_FILE (created if needed, with a TODO
description) as NEW_SECTION, placed right after SECTION in build.asm so the ROM is
unchanged. The register widths in effect at LABEL are measured and stated at the start
of NEW_SECTION. Run ./build.sh afterwards to confirm the output still matches.
"""
import os, re, sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import asmlib


def label_re(name):
    return re.compile(rf'^ {{6}}{re.escape(name)}\b[^\n]*$', re.M)


def measure_widths(src_file, label):
    with asmlib.repo_copy() as tmp:
        p = os.path.join(tmp, src_file)
        t = open(p, encoding='utf-8').read()
        probe = ('      .virtual\n_pa lda #0\n_px ldx #0\n_pe\n      .endv\n'
                 '      .warn format("PROBE A=%d X=%d", _px-_pa, _pe-_px)\n')
        t, n = label_re(label).subn(lambda m: probe + m.group(0), t, count=1)
        if n != 1:
            raise SystemExit(f'label {label} not found in {src_file}')
        open(p, 'w', encoding='utf-8').write(t)
        ok, log = asmlib.assemble(tmp)
    found = set(re.findall(r'PROBE A=([23]) X=([23])', log))
    if not ok or len(found) != 1:
        raise SystemExit('could not measure register widths:\n' + '\n'.join(asmlib.errors(log)[:10]))
    a, x = found.pop()
    return ('.al' if a == '3' else '.as', '.xl' if x == '3' else '.xs')


def first_addr(text):
    m = re.search(r';\s*([0-9A-F]{2})/?([0-9A-F]{4})\b', text)
    return int(m.group(1) + m.group(2), 16) if m else 0


def main():
    if len(sys.argv) != 6:
        print(__doc__); return 2
    src_file, section, label, dst_file, new_section = sys.argv[1:6]
    if not os.path.isdir(os.path.dirname(dst_file) or '.'):
        raise SystemExit(f'{os.path.dirname(dst_file)} does not exist')
    widths = measure_widths(src_file, label)

    t = open(src_file, encoding='utf-8').read()
    sec = re.compile(rf'(    \.section {section}\n)(.*?)(\n    \.endsection {section}\n)', re.S)
    m = sec.search(t)
    if not m:
        raise SystemExit(f'section {section} not found in {src_file}')
    body = m.group(2)
    cut = label_re(label).search(body)
    if not cut:
        raise SystemExit(f'label {label} is not in section {section}')
    head, tail = body[:cut.start()].rstrip('\n') + '\n', body[cut.start():].rstrip('\n')
    open(src_file, 'w', encoding='utf-8').write(t[:m.start(2)] + head + t[m.end(2):])

    new = (f'    .section {new_section}\n\n      {widths[0]}\n      {widths[1]}\n\n{tail}\n\n'
           f'    .endsection {new_section}\n')
    if os.path.exists(dst_file):
        d = open(dst_file, encoding='utf-8').read()
        parts = list(re.finditer(r'    \.section (\w+)\n.*?\n    \.endsection \1\n', d, re.S))
        pos = next((q.start() for q in parts if first_addr(q.group(0)) > first_addr(tail)), None)
        d = d.rstrip('\n') + '\n\n\n' + new if pos is None else d[:pos] + new + '\n\n' + d[pos:]
    else:
        d = '; TODO: describe this file.\n\n' + new
    open(dst_file, 'w', encoding='utf-8').write(d)

    b = open('build.asm', encoding='utf-8').read()
    b, n = re.subn(rf'^(\s*)\.dsection {section}\n', lambda q: f'{q.group(0)}{q.group(1)}.dsection {new_section}\n',
                   b, flags=re.M)
    if n != 1:
        raise SystemExit(f'.dsection {section} found {n} times in build.asm')
    inc = f'  .include "{dst_file}"\n'
    if inc not in b:
        b = b.replace(f'  .include "{src_file}"\n', f'  .include "{src_file}"\n{inc}', 1)
    open('build.asm', 'w', encoding='utf-8').write(b)
    print(f'split {section} at {label} -> {dst_file} : {new_section} ({widths[0]} {widths[1]})')
    return 0


if __name__ == '__main__':
    sys.exit(main())
