#!/usr/bin/env python3
"""Disassemble 65816 code from fe4.sfc into routines in this project's style.

usage: tools/disasm.py START [END] [--m8] [--x8] [--name NAME] [--labels FILE]
       tools/disasm.py --selftest

START and END are CPU addresses such as 88C4D9 or 88/C4D9. Without END, the
disassembly stops at the first instruction that ends the routine (rts, rtl, rti,
jmp, jml, bra, brl) beyond which no branch inside the routine leads.

The accumulator and index registers start 16-bit unless --m8/--x8 say otherwise.
Widths then follow rep/sep, and each branch carries its widths to its target, so
the output declares .al/.as/.xl/.xs wherever a label is reached with widths that
differ from the code just above it. The data bank is followed through
`phk / plb` and `lda #bank / pha / plb`, and declared with .databank.

Operands use the names in labels.txt (written by ./build.sh) where exactly one
name fits; everything else stays a raw address. Branch targets inside the routine
become local labels named after their address (_C507).

The output goes to standard output. It should match the ROM as written; check it
with tools/test_routines.py after saving it to a wip/ file, then give it names.

--selftest disassembles every routine already in the build and checks that the
output reassembles to the same bytes. Run it after changing this tool.
"""
import argparse, glob, os, re, subprocess, sys, tempfile

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from asmlib import read_rom, offset, ASFLAGS

# Routines that take inline arguments after the jsl, and how many bytes.
INLINE_ARGS = {
    'rlFadePaletteToBlack': 2,
    'rlFadePaletteToColors': 6,
    'rlSavePaletteBufferColorsToRAM': 7,
}

# Opcode table: mnemonic and addressing mode for every opcode.
_ROWS = """
brk imp|ora dpindx|cop imm8|ora sr|tsb dp|ora dp|asl dp|ora dpil|php imp|ora immm|asl acc|phd imp|tsb abs|ora abs|asl abs|ora absl
bpl rel8|ora dpindy|ora dpind|ora sriy|trb dp|ora dpx|asl dpx|ora dpily|clc imp|ora absy|inc acc|tcs imp|trb abs|ora absx|asl absx|ora abslx
jsr absj|and dpindx|jsl abslj|and sr|bit dp|and dp|rol dp|and dpil|plp imp|and immm|rol acc|pld imp|bit abs|and abs|rol abs|and absl
bmi rel8|and dpindy|and dpind|and sriy|bit dpx|and dpx|rol dpx|and dpily|sec imp|and absy|dec acc|tsc imp|bit absx|and absx|rol absx|and abslx
rti imp|eor dpindx|wdm imm8|eor sr|mvp blk|eor dp|lsr dp|eor dpil|pha imp|eor immm|lsr acc|phk imp|jmp absj|eor abs|lsr abs|eor absl
bvc rel8|eor dpindy|eor dpind|eor sriy|mvn blk|eor dpx|lsr dpx|eor dpily|cli imp|eor absy|phy imp|tcd imp|jml abslj|eor absx|lsr absx|eor abslx
rts imp|adc dpindx|per rel16|adc sr|stz dp|adc dp|ror dp|adc dpil|pla imp|adc immm|ror acc|rtl imp|jmp absind|adc abs|ror abs|adc absl
bvs rel8|adc dpindy|adc dpind|adc sriy|stz dpx|adc dpx|ror dpx|adc dpily|sei imp|adc absy|ply imp|tdc imp|jmp absindx|adc absx|ror absx|adc abslx
bra rel8|sta dpindx|brl rel16|sta sr|sty dp|sta dp|stx dp|sta dpil|dey imp|bit immm|txa imp|phb imp|sty abs|sta abs|stx abs|sta absl
bcc rel8|sta dpindy|sta dpind|sta sriy|sty dpx|sta dpx|stx dpy|sta dpily|tya imp|sta absy|txs imp|txy imp|stz abs|sta absx|stz absx|sta abslx
ldy immx|lda dpindx|ldx immx|lda sr|ldy dp|lda dp|ldx dp|lda dpil|tay imp|lda immm|tax imp|plb imp|ldy abs|lda abs|ldx abs|lda absl
bcs rel8|lda dpindy|lda dpind|lda sriy|ldy dpx|lda dpx|ldx dpy|lda dpily|clv imp|lda absy|tsx imp|tyx imp|ldy absx|lda absx|ldx absy|lda abslx
cpy immx|cmp dpindx|rep imm8|cmp sr|cpy dp|cmp dp|dec dp|cmp dpil|iny imp|cmp immm|dex imp|wai imp|cpy abs|cmp abs|dec abs|cmp absl
bne rel8|cmp dpindy|cmp dpind|cmp sriy|pei dpind|cmp dpx|dec dpx|cmp dpily|cld imp|cmp absy|phx imp|stp imp|jml absil|cmp absx|dec absx|cmp abslx
cpx immx|sbc dpindx|sep imm8|sbc sr|cpx dp|sbc dp|inc dp|sbc dpil|inx imp|sbc immm|nop imp|xba imp|cpx abs|sbc abs|inc abs|sbc absl
beq rel8|sbc dpindy|sbc dpind|sbc sriy|pea imm16|sbc dpx|inc dpx|sbc dpily|sed imp|sbc absy|plx imp|xce imp|jsr absindx|sbc absx|inc absx|sbc abslx
"""
OPS = [tuple(c.split()) for row in _ROWS.split('\n') if row for c in row.split('|')]
assert len(OPS) == 256

SIZE = {'imp': 0, 'acc': 0, 'imm8': 1, 'imm16': 2, 'dp': 1, 'dpx': 1, 'dpy': 1, 'dpind': 1,
        'dpindx': 1, 'dpindy': 1, 'dpil': 1, 'dpily': 1, 'sr': 1, 'sriy': 1, 'abs': 2, 'absx': 2,
        'absy': 2, 'absj': 2, 'absind': 2, 'absindx': 2, 'absil': 2, 'absl': 3, 'abslx': 3,
        'abslj': 3, 'rel8': 1, 'rel16': 2, 'blk': 2, 'immm': 2, 'immx': 2}

# The project writes inx as "inc x" and so on.
STYLE = {'inx': 'inc x', 'iny': 'inc y', 'dex': 'dec x', 'dey': 'dec y'}
ENDS = {'rts', 'rtl', 'rti', 'stp', 'bra', 'brl', 'jml'}


def parse_addr(s):
    return int(s.replace('/', '').replace('$', ''), 16)


def load_labels(path):
    """{address: [names]} for top-level labels (no local labels)."""
    names = {}
    if not os.path.exists(path):
        return names
    for line in open(path, encoding='utf-8'):
        p = line.split()
        if len(p) == 3 and p[0] == 'al' and ':' not in p[2]:
            names.setdefault(int(p[1], 16), []).append(p[2].lstrip('.'))
    return names


class Disassembler:
    def __init__(self, rom, labels, start, end, m8, x8):
        self.rom, self.labels = rom, labels
        self.start, self.end = start, end
        self.bank = start & 0xFF0000
        self.m8, self.x8 = m8, x8

    def byte(self, addr):
        return self.rom[offset(addr)]

    def name(self, addr, rom_only=False):
        """The single label at addr, or None. ROM labels prefer a name without 'Unknown'."""
        found = self.labels.get(addr, [])
        if rom_only or addr >= 0x800000:
            known = [n for n in found if 'Unknown' not in n]
            found = known or found
            return found[0] if found else None
        if len(found) == 1:
            return found[0]
        if found:
            return None
        # The upper bytes of a word or long variable, written as name+1 or name+2.
        for k, prefixes in ((1, ('w', 'l')), (2, ('l',))):
            near = self.labels.get(addr - k, [])
            if len(near) == 1 and near[0].startswith(prefixes):
                return f'{near[0]}+{k}'
        return None

    def decode(self):
        """First pass: decode instructions, widths and branch targets."""
        insns, targets, open_targets = [], {}, set()
        pc, m8, x8 = self.start, self.m8, self.x8
        db, pushed, a_low = None, None, None
        stop = False
        while not stop:
            if self.end is not None and pc >= self.end:
                break
            if pc in targets and targets[pc] is not None and insns and insns[-1]['ends']:
                m8, x8 = targets[pc]
            op = self.byte(pc)
            mn, mode = OPS[op]
            size = SIZE[mode]
            if mode == 'immm':
                size = 1 if m8 else 2
            elif mode == 'immx':
                size = 1 if x8 else 2
            raw = bytes(self.byte(pc + 1 + i) for i in range(size))
            val = int.from_bytes(raw, 'little') if raw else None
            ins = dict(pc=pc, op=op, mn=mn, mode=mode, size=size, val=val, m8=m8, x8=x8,
                       db=db, ends=mn in ENDS or (mn == 'jmp'), args=0)
            nxt = pc + 1 + size

            # Branch and jump targets.
            tgt = None
            if mode == 'rel8':
                tgt = (nxt + (val - 256 if val >= 128 else val)) & 0xFFFF | self.bank
            elif mode == 'rel16':
                tgt = (nxt + (val - 65536 if val >= 32768 else val)) & 0xFFFF | self.bank
            elif mode == 'absj':
                tgt = self.bank | val
            elif mode == 'abslj':
                tgt = val
            ins['target'] = tgt
            if tgt is not None and mn != 'per' and tgt >= self.start and (self.end is None or tgt < self.end):
                if mn in ('jsr', 'jsl'):
                    targets.setdefault(tgt, None)
                else:
                    targets.setdefault(tgt, (m8, x8))
                    # Without END, branches keep the routine open up to their target, and
                    # so do jumps a short way ahead in the same bank (the original code
                    # often uses jml to get past the branch range).
                    near = mode.startswith('rel') or (tgt & 0xFF0000 == self.bank and 0 < tgt - pc <= 0x200)
                    if near:
                        open_targets.add(tgt)

            # Width and data bank tracking.
            if mn == 'rep':
                m8 = m8 and not (val & 0x20)
                x8 = x8 and not (val & 0x10)
            elif mn == 'sep':
                m8 = m8 or bool(val & 0x20)
                x8 = x8 or bool(val & 0x10)
            if mn == 'lda' and mode == 'immm':
                a_low = val & 0xFF
            elif mn in ('pla', 'txa', 'tya', 'tdc', 'tsc', 'xba') or (mn in ('lda', 'adc', 'sbc', 'and', 'ora', 'eor') and mode != 'immm'):
                a_low = None
            if mn == 'phk':
                pushed = self.bank >> 16
            elif mn == 'pha':
                pushed = a_low
            elif mn == 'plb':
                db = pushed
                ins['set_db'] = db
            elif mn in ('phb', 'phx', 'phy', 'php', 'phd'):
                pushed = None

            if mn == 'jsl' and tgt is not None:
                n = INLINE_ARGS.get(self.name(tgt, rom_only=True) or '', 0)
                ins['args'] = n
                nxt += n

            insns.append(ins)
            pc = nxt
            if self.end is None:
                if pc & 0xFF0000 != self.bank:
                    stop = True
                elif ins['ends'] and not any(t >= pc for t in open_targets):
                    stop = True
        self.stop_pc = pc
        return insns, targets

    def fmt_ram(self, val, bank_known, db):
        """Operand text for an absolute operand val with data bank db."""
        if val < 0x2000:
            n = self.name(val)
            return f'{n},b' if n else f'${val:04X},b'
        if db is not None:
            full = (db << 16) | val
            n = self.name(full)
            if n:
                return n
        return f'${val:04X},b'

    def operand(self, ins, local):
        mode, val, mn = ins['mode'], ins['val'], ins['mn']
        db = ins['db']

        def dp(v):
            n = self.name(v)
            return n if n and v < 0x100 else f'${v:02X}'

        def target(t):
            if t in local:
                return local[t]
            n = self.name(t, rom_only=True)
            return n if n else f'${t:06X}'

        def long(v):
            # 64tass shortens a long operand when it can, so force long addressing
            # where the bank is $00 or the data bank in effect.
            n = self.name(v)
            text = n if n else f'${v:06X}'
            return f'@l {text}' if v < 0x10000 or (db is not None and v >> 16 == db) else text

        if mode in ('imp',):
            return ''
        if mode == 'acc':
            return 'a'
        if mode in ('imm8', 'immm', 'immx'):
            return f'#${val:02X}' if ins['size'] == 1 else f'#${val:04X}'
        if mode == 'imm16':
            return f'#${val:04X}'
        if mode == 'dp':
            return dp(val)
        if mode == 'dpx':
            return f'{dp(val)},x'
        if mode == 'dpy':
            return f'{dp(val)},y'
        if mode == 'dpind':
            return f'({dp(val)})'
        if mode == 'dpindx':
            return f'({dp(val)},x)'
        if mode == 'dpindy':
            return f'({dp(val)}),y'
        if mode == 'dpil':
            return f'[{dp(val)}]'
        if mode == 'dpily':
            return f'[{dp(val)}],y'
        if mode == 'sr':
            return f'#{val},s'
        if mode == 'sriy':
            return f'(#{val},s),y'
        if mode == 'abs':
            return self.fmt_ram(val, db is not None, db)
        if mode in ('absx', 'absy'):
            # A small offset from an index register is usually a field of a
            # struct that the register points to, not a variable.
            text = f'${val:04X},b' if val < 0x100 else self.fmt_ram(val, db is not None, db)
            return text + (',x' if mode == 'absx' else ',y')
        if mode in ('absj', 'abslj', 'rel8', 'rel16'):
            return target(ins['target'])
        if mode == 'absind':
            n = self.name(val)
            return f'({n})' if n else f'(${val:04X})'
        if mode == 'absindx':
            return f'({target(self.bank | val)},x)'
        if mode == 'absil':
            n = self.name(val)
            return f'[{n}]' if n else f'[${val:04X}]'
        if mode == 'absl':
            return long(val)
        if mode == 'abslx':
            return long(val) + ',x'
        raise ValueError(mode)

    def long_pointer_loads(self, insns):
        """Operand text for the usual way of loading a long pointer to a label:
            lda #(`label)<<8 / sta lX+1 / lda #<>label / sta lX
        Returns {pc: operand} for the two lda instructions."""
        out = {}
        stores = ('dp', 'abs')
        for i in range(len(insns) - 3):
            a, b, c, d = insns[i:i + 4]
            if not (a['mn'] == c['mn'] == 'lda' and a['mode'] == c['mode'] == 'immm' and a['size'] == c['size'] == 2):
                continue
            if not (b['mn'] == d['mn'] == 'sta' and b['mode'] in stores and d['mode'] == b['mode']):
                continue
            if b['val'] != d['val'] + 1 or a['val'] & 0xFF:
                continue
            n = self.name(((a['val'] >> 8) << 16) | c['val'], rom_only=True)
            if n:
                out[a['pc']] = f'#(`{n})<<8'
                out[c['pc']] = f'#<>{n}'
        return out

    def render(self, name):
        insns, targets = self.decode()
        starts = {i['pc'] for i in insns}
        local = {t: f'_{t & 0xFFFF:04X}' for t in targets if t in starts and t != self.start}
        bad = [t for t in targets if t not in starts and t != self.stop_pc]
        override = self.long_pointer_loads(insns)

        b = self.start
        out = [f'      {name} ; {b >> 16:02X}/{b & 0xFFFF:04X}', '',
               '        .as' if self.m8 else '        .al',
               '        .xs' if self.x8 else '        .xl',
               '        .autsiz', '        .databank ?', '']
        for t in bad:
            out.append(f'        ; WARNING: a branch or jump leads into the middle of an instruction at ${t:06X}')
        asm_m, asm_x = self.m8, self.x8   # widths as 64tass will see them, in source order
        asm_db = None
        for k, ins in enumerate(insns):
            pc = ins['pc']
            if pc in local:
                out.append('')
                out.append(f'        {local[pc]}')
                if ins['m8'] != asm_m:
                    out.append('        .as' if ins['m8'] else '        .al')
                if ins['x8'] != asm_x:
                    out.append('        .xs' if ins['x8'] else '        .xl')
            asm_m, asm_x = ins['m8'], ins['x8']
            mn = STYLE.get(ins['mn'], ins['mn'])
            if ins['mode'] == 'blk':
                src, dst = ins['val'] >> 8, ins['val'] & 0xFF
                out.append(f'        .byte ${ins["op"]:02X}, ${dst:02X}, ${src:02X} ; {mn} from bank ${src:02X} to bank ${dst:02X}')
            elif ins['mn'] in ('brk', 'cop', 'wdm', 'stp'):
                text = ', '.join(f'${self.byte(pc + i):02X}' for i in range(1 + ins['size']))
                out.append(f'        .byte {text} ; {mn}')
            else:
                opnd = override.get(pc) or self.operand(ins, local)
                out.append(f'        {mn} {opnd}'.rstrip())
            if ins['mn'] == 'rep' or ins['mn'] == 'sep':
                v = ins['val']
                asm_m = (asm_m or bool(v & 0x20)) if ins['mn'] == 'sep' else (asm_m and not v & 0x20)
                asm_x = (asm_x or bool(v & 0x10)) if ins['mn'] == 'sep' else (asm_x and not v & 0x10)
            if 'set_db' in ins:
                out.append(f'        .databank ${ins["set_db"]:02X}' if ins['set_db'] is not None else '        .databank ?')
                asm_db = ins['set_db']
            if ins['args']:
                a = pc + 4
                data = ', '.join(f'${self.byte(a + i):02X}' for i in range(ins['args']))
                out.append('')
                out.append(f'          .byte {data}')
                out.append('')
            if ins['ends'] and k + 1 < len(insns):
                out.append('')
        out += ['', '        .databank 0', '']
        e = self.stop_pc
        out.append(f'        ; {e >> 16:02X}/{e & 0xFFFF:04X}')
        return '\n'.join(out) + '\n'


def selftest(rom, labels):
    """Disassemble every routine already in the build and check that it reassembles to
    the ROM's bytes. Starting widths come from each routine's existing source. ROM names
    are left out, since the test assembles without the engine files."""
    ram = {a: n for a, n in labels.items() if a < 0x800000}
    starts = []
    for f in glob.glob('engine/**/*.asm', recursive=True):
        lines = open(f, encoding='utf-8').read().split('\n')
        for i, l in enumerate(lines):
            m = re.match(r'^ {6}(r[ls]\w+) ; ([0-9A-F]{2})/([0-9A-F]{4})\s*$', l)
            if m:
                head = ' '.join(lines[i + 1:i + 6])
                starts.append((int(m.group(2) + m.group(3), 16), m.group(1), '.as' in head, '.xs' in head))
    starts.sort()
    src = ['.cpu "65816"', '.include "include/fe4.h"', '* := 0', '.fill $400000, 0']
    ranges, done = [], 0
    for a, name, m8, x8 in starts:
        if a < done:
            continue
        d = Disassembler(rom, ram, a, None, m8, x8)
        text = d.render(f'test{a:06X}')
        done = d.stop_pc
        ranges.append((a, d.stop_pc, name))
        src += [f'* = ${offset(a):06X}', f'.logical ${a:06X}', text, '.here']
    with tempfile.TemporaryDirectory() as tmp:
        open(os.path.join(tmp, 'test.asm'), 'w').write('\n'.join(src))
        os.symlink(os.path.abspath('include'), os.path.join(tmp, 'include'))
        r = subprocess.run(['64tass', *ASFLAGS, '-o', 'test.bin', 'test.asm'], cwd=tmp,
                           capture_output=True, text=True)
        errs = [l for l in (r.stdout + r.stderr).split('\n') if 'error' in l]
        for e in errs[:20]:
            print(e)
        if errs:
            return 1
        out = open(os.path.join(tmp, 'test.bin'), 'rb').read()
    bad = [(a, e, n) for a, e, n in ranges if out[offset(a):offset(e)] != rom[offset(a):offset(e)]]
    for a, e, n in bad:
        k = next(i for i in range(offset(a), offset(e)) if out[i] != rom[i])
        print(f'  {n} ({a:06X}): differs at {k | 0xC00000:06X}: built {out[k:k + 4].hex()}, original {rom[k:k + 4].hex()}')
    print(f'{len(ranges)} routines, {sum(e - a for a, e, _ in ranges):,} bytes: {len(bad)} differ')
    return 1 if bad else 0


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    ap.add_argument('start', nargs='?')
    ap.add_argument('end', nargs='?')
    ap.add_argument('--m8', action='store_true', help='accumulator starts 8-bit')
    ap.add_argument('--x8', action='store_true', help='index registers start 8-bit')
    ap.add_argument('--name', help='label for the routine (default rlUnknownXXXXXX)')
    ap.add_argument('--labels', default='labels.txt')
    ap.add_argument('--selftest', action='store_true',
                    help='check the disassembler against every routine already in the build')
    a = ap.parse_args()
    if a.selftest:
        return selftest(read_rom(), load_labels(a.labels))
    if not a.start:
        ap.error('START is required')
    start = parse_addr(a.start)
    end = parse_addr(a.end) if a.end else None
    d = Disassembler(read_rom(), load_labels(a.labels), start, end, a.m8, a.x8)
    name = a.name or f'rlUnknown{start:06X}'
    sys.stdout.write(d.render(name))


if __name__ == '__main__':
    sys.exit(main())
