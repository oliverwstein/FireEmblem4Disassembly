"""Shared helpers for the disassembly tools in this folder.

All functions expect to run from the repository root, next to build.asm and fe4.sfc.
"""
import os, re, shutil, subprocess, tempfile, contextlib

ASFLAGS = ['-x', '-f', '-C', '-a', '-Wall', '-Wno-portable', '-Wno-shadow', '-Wno-deprecated']
ROM_PATH = 'fe4.sfc'
ROM_SIZE = 0x400000

# A top-level routine or table label: six spaces, the name, then its address, e.g.
#       rlGetRandomNumber ; 80/A73A
# A label followed by a directive on the same line also counts, e.g.
#       aSomeTable .word 1, 2, 3 ; 85/8000
ROUTINE_RE = re.compile(r'^ {6}([A-Za-z]\w*)(?:\s+\.[^;]*?)?\s*;\s*([0-9A-F]{2})/?([0-9A-F]{4})\s*$')
BRANCH_OPCODES = {0x10, 0x30, 0x50, 0x70, 0x80, 0x90, 0xB0, 0xD0, 0xF0, 0x82}
JUMP_OPCODES = {0x4C, 0x5C, 0x20, 0x22}  # jmp, jml, jsr, jsl (absolute/long targets)

# The same operation with an absolute operand and with a long one (also abs,x and long,x).
ABS_TO_LONG = {0xAD: 0xAF, 0x8D: 0x8F, 0x6D: 0x6F, 0xED: 0xEF, 0xCD: 0xCF, 0x2D: 0x2F, 0x0D: 0x0F, 0x4D: 0x4F,
               0xBD: 0xBF, 0x9D: 0x9F, 0x7D: 0x7F, 0xFD: 0xFF, 0xDD: 0xDF, 0x3D: 0x3F, 0x1D: 0x1F, 0x5D: 0x5F}
LONG_TO_ABS = {v: k for k, v in ABS_TO_LONG.items()}

# The same operation with a direct page operand and with an absolute one (also dp,x and abs,x).
DP_TO_ABS = {0x05: 0x0D, 0x25: 0x2D, 0x45: 0x4D, 0x65: 0x6D, 0x85: 0x8D, 0xA5: 0xAD, 0xC5: 0xCD, 0xE5: 0xED,
             0x86: 0x8E, 0xA6: 0xAE, 0x84: 0x8C, 0xA4: 0xAC, 0x64: 0x9C, 0xE6: 0xEE, 0xC6: 0xCE,
             0x06: 0x0E, 0x46: 0x4E, 0x26: 0x2E, 0x66: 0x6E, 0x24: 0x2C, 0x04: 0x0C, 0x14: 0x1C,
             0xE4: 0xEC, 0xC4: 0xCC,
             0x15: 0x1D, 0x35: 0x3D, 0x55: 0x5D, 0x75: 0x7D, 0x95: 0x9D, 0xB5: 0xBD, 0xD5: 0xDD, 0xF5: 0xFD,
             0x74: 0x9E, 0xF6: 0xFE, 0xD6: 0xDE, 0xB4: 0xBC, 0x34: 0x3C, 0x16: 0x1E, 0x56: 0x5E, 0x36: 0x3E,
             0x76: 0x7E}


def read_rom():
    return open(ROM_PATH, 'rb').read()


def offset(addr):
    """CPU address ($80-$FF banks, HiROM) to file offset."""
    return addr & 0x3FFFFF


def find_routines(lines):
    """[(line index, name, CPU address)] for every top-level label with an address comment."""
    return [(i, m.group(1), int(m.group(2) + m.group(3), 16))
            for i, l in enumerate(lines) if (m := ROUTINE_RE.match(l))]


@contextlib.contextmanager
def repo_copy():
    """A temporary copy of the working tree (without .git), removed afterwards."""
    tmp = tempfile.mkdtemp(prefix='fe4-')
    try:
        subprocess.run(['rsync', '-a', '--exclude', '.git', '--exclude', '*.smc',
                        '--exclude', 'FE4Disassembly.sfc', './', tmp + '/'], check=True)
        yield tmp
    finally:
        shutil.rmtree(tmp)


def assemble(root, out='out.sfc', extra=()):
    """Assemble build.asm in root. Returns (success, log text)."""
    r = subprocess.run(['64tass', *ASFLAGS, *extra, '-o', out, 'build.asm'],
                       cwd=root, capture_output=True, text=True)
    ok = r.returncode == 0 and os.path.exists(os.path.join(root, out))
    return ok, r.stdout + r.stderr


def errors(log):
    return [l for l in log.split('\n') if 'error' in l.lower() and 'Error messages' not in l]


def section_ranges(log, prefix=''):
    """{section name: (start offset, end offset)} from the 64tass log's Data: lines."""
    out = {}
    for m in re.finditer(r'Data:[ \t]+\d+[ \t]+\$([0-9a-f]+)-\$([0-9a-f]+)[ \t]+\$[0-9a-f]+[ \t]+(\w+)', log):
        if m.group(3).startswith(prefix):
            out[m.group(3)] = (int(m.group(1), 16), int(m.group(2), 16) + 1)
    return out


def add_to_build(root, include_path, placements):
    """Include a file right after the base ROM is loaded and append placement blocks."""
    p = os.path.join(root, 'build.asm')
    b = open(p, encoding='utf-8').read()
    anchor = '  ROM = binary("fe4.sfc")\n'
    assert anchor in b, 'build.asm layout changed: base ROM anchor not found'
    b = b.replace(anchor, anchor + f'  .include "{include_path}"\n', 1)
    blocks = [f'    * = ${offset(addr):06X}\n    .logical ${addr:06X}\n'
              + ''.join(f'      .dsection {s}\n' for s in secs) + '    .here\n'
              for addr, secs in placements]
    open(p, 'w', encoding='utf-8').write(b.rstrip('\n') + '\n\n' + '\n'.join(blocks))


def source_map():
    """bytes, one per ROM byte: 1 if the current build produces it from source.

    Builds twice with the base ROM replaced by $00 and by $FF; bytes that agree come from source.
    """
    results = []
    with repo_copy() as tmp:
        for fill in (0x00, 0xFF):
            open(os.path.join(tmp, ROM_PATH), 'wb').write(bytes([fill]) * ROM_SIZE)
            ok, log = assemble(tmp, f'{fill:02X}.sfc')
            if not ok:
                raise RuntimeError('fill build failed:\n' + '\n'.join(errors(log)[:10]))
            results.append(open(os.path.join(tmp, f'{fill:02X}.sfc'), 'rb').read())
    return bytes(x == y for x, y in zip(*results))


def probe_widths(path, labels, file_start=('.al', '.xl')):
    """Register widths at each label of a routines file, as 64tass sees them.

    Assembles the file's routines at their addresses (in a temp copy) with a probe before
    each label in `labels`. Returns {label: ('.al'|'.as', '.xl'|'.xs')}.
    """
    labels = set(labels)
    lines = open(path, encoding='utf-8').read().split('\n')
    routines = find_routines(lines)
    out = [f'      {file_start[0]}', f'      {file_start[1]}', '']
    place = []
    for k, (i, name, addr) in enumerate(routines):
        end = routines[k + 1][0] if k + 1 < len(routines) else len(lines)
        body = lines[i:end]
        if name in labels:
            body = [f'      .virtual\n_pa{name} lda #0\n_px{name} ldx #0\n_pe{name}\n      .endv\n'
                    f'      .warn format("PROBE {name} A=%d X=%d", _px{name}-_pa{name}, _pe{name}-_px{name})'] + body
        sec = f'PROBE_{addr:06X}'
        out += [f'    .section {sec}'] + body + [f'    .endsection {sec}', '']
        place.append((addr, [sec]))
    with repo_copy() as tmp:
        rel = os.path.join(os.path.dirname(path), '_probe.asm')
        open(os.path.join(tmp, rel), 'w').write('\n'.join(out))
        add_to_build(tmp, rel, place)
        ok, log = assemble(tmp)
    found = {}
    for n, a, x in re.findall(r'PROBE (\w+) A=([23]) X=([23])', log):
        found.setdefault(n, set()).add(('.al' if a == '3' else '.as', '.xl' if x == '3' else '.xs'))
    missing = labels - set(found)
    if missing or not ok:
        raise RuntimeError(f'probe failed (missing {sorted(missing)[:5]}):\n' + '\n'.join(errors(log)[:10]))
    conflicting = {n for n, v in found.items() if len(v) > 1}
    if conflicting:
        raise RuntimeError(f'inconsistent widths reported for {sorted(conflicting)}')
    return {n: v.pop() for n, v in found.items()}
