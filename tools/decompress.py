#!/usr/bin/env python3
"""The game's decompressor (rlDecompressor, $80/AA02), ported to Python.

usage: tools/decompress.py ADDR [ADDR ...] [--out FILE] [--hex]
       tools/decompress.py --self-test

ADDR is a CPU address such as $A8D2F0 or A8D2F0. For each, prints the address,
the compressed length (bytes of the stream, terminator included), the
decompressed length and where the stream ends. --out writes the decompressed
bytes (of the last ADDR) to FILE; --hex prints them.

--self-test checks the port against data whose extent is known: every stream in
gfx/ (its file length) and the portraits (each ends where the next begins).

As a module:

    from decompress import decompress
    data, end = decompress(rom, 0xA8D2F0)   # end: CPU address after the stream

A stream that starts below $8000 in its bank continues at $0000 of the next
bank when it reaches $8000; one at $8000 or above continues at $8000 of the
next. The portraits in the lower halves of banks $CA-$D0 cross this way.

The port follows the assembly step by step, including the order in which it
reads bytes, because one method copies earlier bytes of the compressed stream
itself (a lookback, methods $F8-$FD): it reads from an earlier point for a
counted number of bytes, then returns. The count goes down once per stream byte
read, but at points that differ between methods, so a lookback can end in the
middle of a method; the port reproduces that.

Stream format (first byte of each method, b):
  $00-$3F  literal: (b & $3F) + 1 bytes follow
  $40-$4F  nybble fill: (b & $0F) + 1 output bytes from the nybbles that follow,
           OR'd with a fixed nybble given by the next byte
  $50-$5F  doubled: (b & $0F) + 1 bytes follow, each written twice
  $60-$6F  byte before: next byte v, then (b & $0F) + 2 bytes, each preceded by v
  $70-$7F  byte after: the same, each followed by v
  $80-$BF  copy from output: length ((b >> 2) & $0F) + 2,
           distance ((b & 3) << 8 | next byte)
  $C0-$DF  copy from output: 2-byte form, longer length and distance
  $E0-$EF  run: ((b & $0F) << 8 | next) + 3 copies of the byte after
  $F0-$F7  short run: (b & 7) + 3 copies of the next byte
  $F8-$FB  lookback in the stream: 3-byte form
  $FC-$FD  lookback in the stream: 2-byte form
  $FE-$FF  end
"""
import argparse
import os
import sys


class DecompressionError(Exception):
    pass


def rom_offset(addr):
    """File offset of a HiROM CPU address, or None if it is not ROM."""
    bank, lo = addr >> 16, addr & 0xFFFF
    if bank >= 0xC0 or 0x40 <= bank <= 0x7D:
        return (bank & 0x3F) << 16 | lo
    if 0x80 <= bank <= 0xBF and lo >= 0x8000:
        return (bank & 0x3F) << 16 | lo
    return None


def decompress(rom, source, limit=0x20000, linear=False):
    """Decompress the stream at CPU address `source`.

    linear=True is the entry rlDecompressLinear (the sound loader's): the
    source is read as bank:0000+Y with bFlag set, so a stream runs on from
    $xx/FFFF to $xx+1/0000 and lookbacks cross banks downward.

    Returns (data, end): the output bytes, and the CPU address just after the
    stream's terminator in the main stream (lookbacks excluded).
    """
    # Registers and direct-page variables, as in the assembly (8-bit A).
    src_bank = source >> 16
    y = source & 0xFFFF
    if linear:
        base = 0x0000
    elif y & 0x8000:
        base = 0x0000                       # ROM source: [lSource],y with lSource = bank:0000
    else:
        base = 0x8000                       # source below $8000: bank-1:8000, Y + $8000
        y = (y + 0x8000) & 0xFFFF
        src_bank = (src_bank - 1) & 0xFF
    flag = 1 if linear else 0               # bFlag
    count = 0                               # bCount: bytes left in a lookback
    temp_bank = temp_y = 0                  # lTemp: where the main stream resumes
    out = bytearray()

    def address():
        return ((src_bank << 16) + base + y) & 0xFFFFFF

    def read():
        nonlocal y, src_bank
        o = rom_offset(address())
        if o is None or o >= len(rom):
            raise DecompressionError(f'stream runs out of ROM at ${address():06X}')
        v = rom[o]
        y = (y + 1) & 0xFFFF
        if y == 0:                          # _BankBoundary
            src_bank = (src_bank + 1) & 0xFF
            y = base
            if y == 0 and not flag:
                y = 0x8000
        return v

    def tick():                             # bCount: dec, and at 0 _SetSource
        nonlocal count, src_bank, y
        if count:
            count = (count - 1) & 0xFF
            if count == 0:
                src_bank, y = temp_bank, temp_y

    def write(v):
        out.append(v & 0xFF)
        if len(out) > limit:
            raise DecompressionError(f'output passes {limit:#x} bytes')

    def copy_from_output(dist, n):
        start = len(out) - dist
        if dist == 0:                       # would copy bytes not written yet
            raise DecompressionError('copy from output with distance 0')
        if start < 0:
            raise DecompressionError(f'copy from before the output start (distance {dist})')
        for i in range(n):
            write(out[start + i])           # byte by byte: overlapping copies repeat

    methods = 0
    while True:
        methods += 1                        # lookbacks inside lookbacks can loop
        if methods > limit:                 # without writing: not a real stream
            raise DecompressionError(f'more than {limit:#x} methods')
        b = read()                          # _GetNextMethod
        tick()
        if b < 0x40:                        # literal
            for _ in range((b & 0x3F) + 1):
                write(read())
                tick()
        elif b < 0x50:                      # _ORR: nybble fill
            mc = (b & 0x0F) + 1
            c = read()
            tick()
            if c >= 0x80:                   # _ORR80Plus: first byte and fill nybble
                if c >= 0xC0:
                    if c & 0x10:
                        write((c << 4) | 0x0F)
                        a = 0x1F
                    else:
                        write((c & 0x0F) | 0xF0)
                        a = 0x0F
                else:
                    if c & 0x10:
                        write(c << 4)
                        a = 0x10
                    else:
                        write(c & 0x0F)
                        a = 0x00
            else:
                a = c
            if a < 0x10:                    # _LowerNybbleData: fixed high nybble
                fixed = (a << 4) & 0xFF
                while True:
                    d = read()
                    write((d >> 4) | fixed)
                    tick()
                    mc -= 1
                    if mc < 0:
                        break
                    write((d & 0x0F) | fixed)
                    mc -= 1
                    if mc < 0:
                        break
            else:                           # _UpperDataLoop: fixed low nybble
                fixed = a & 0x0F
                while True:
                    d = read()
                    write((d & 0xF0) | fixed)
                    tick()
                    mc -= 1
                    if mc < 0:
                        break
                    write(((d << 4) & 0xFF) | fixed)
                    mc -= 1
                    if mc < 0:
                        break
        elif b < 0x60:                      # _DupLoop
            for _ in range((b & 0x0F) + 1):
                d = read()
                write(d)
                write(d)
                tick()
        elif b < 0x80:                      # _Preappend / _Postappend
            v = read()
            tick()
            for _ in range((b & 0x0F) + 2):
                if b < 0x70:
                    write(v)
                    write(read())
                    tick()
                else:
                    write(read())
                    tick()
                    write(v)
        elif b < 0xC0:                      # _LZ77
            n = ((b >> 2) & 0x0F) + 2
            dist = (b & 3) << 8 | read()
            copy_from_output(dist, n)
            tick()
        elif b < 0xE0:                      # _UpperMethodOrLZLong
            c = read()
            tick()
            n = (((b & 0x1F) << 1) | (c >> 7)) + 2
            dist = (c & 0x7F) << 8 | read()
            copy_from_output(dist, n)
            tick()
        elif b < 0xF0:                      # RLE
            c = read()
            tick()
            v = read()
            for _ in range((((b & 0x0F) << 8) | c) + 3):
                write(v)
            tick()
        elif b < 0xF8:                      # _ShortRLELoop
            v = read()
            for _ in range((b & 7) + 3):
                write(v)
            tick()
        elif b < 0xFE:                      # lookback into the stream
            if b < 0xFC:
                b1, b2 = read(), read()
                n = ((b & 3) << 3) | (b1 >> 5)
                dist = (((b1 & 0x1F) << 8) | b2) + 3
            else:
                b1 = read()
                n = ((b & 1) << 2) | (b1 >> 6)
                dist = (b1 & 0x3F) + 2
            temp_bank, temp_y = src_bank, y          # _SetReadposAndCount
            if flag:
                new = y - dist
                if new < 0:
                    src_bank = (src_bank - 1) & 0xFF
                y = new & 0xFFFF
            else:
                new = (y - dist) & 0xFFFF
                if not new & 0x8000:                 # left the bank's upper half
                    new = (new + 0x8000) & 0xFFFF
                    src_bank = (src_bank - 1) & 0xFF
                y = new
            count = (n + 3) & 0xFF
        else:                               # _EndDecomp
            if count:                       # ended inside a lookback: the main
                src_bank, y = temp_bank, temp_y      # stream resumes at lTemp
            return bytes(out), address()


def stream_size(start, end):
    """Bytes from start to end in the stream, counting only the half of each bank
    the stream uses: a stream below $8000 runs on into the next bank's lower half
    (the upper half between holds other things), one at $8000 or above into the
    next bank's upper half."""
    banks = (end >> 16) - (start >> 16)
    if not banks:
        return end - start
    half = 0x8000 if start & 0x8000 else 0
    return (0x8000 + half - (start & 0xFFFF)) + (banks - 1) * 0x8000 + (end & 0xFFFF) - half


def parse_addr(s):
    return int(s.lstrip('$').replace('/', ''), 16)


def self_test(root, rom):
    import csv
    import glob
    failures = 0
    files = sorted(glob.glob(os.path.join(root, 'gfx', '**', '*.comp'), recursive=True))
    for path in files:
        data = open(path, 'rb').read()
        buf = bytearray(rom)                # the stream alone at $FF/0000, then $FF filler
        buf[0x3F0000:0x400000] = data + b'\xFF' * (0x10000 - len(data))
        try:
            _, end = decompress(bytes(buf), 0xFF0000)
            ok = end & 0xFFFF == len(data)
        except DecompressionError:
            ok = False
        if not ok:
            failures += 1
            print(f'FAIL {os.path.relpath(path, root)}')
    print(f'gfx/: {len(files) - failures} of {len(files)} streams end at their file end')
    csv_path = os.path.join(root, 'data', 'portraits', 'PortraitGraphicPointers.csv')
    labels = {}
    for line in open(os.path.join(root, 'labels.txt')):
        parts = line.split()
        if len(parts) == 3:
            labels[parts[2].lstrip('.')] = int(parts[1], 16)
    starts = set()
    for name, value in list(csv.reader(open(csv_path)))[1:]:
        starts.add(labels[value] if value in labels else parse_addr(value))
    starts = sorted(starts, key=rom_offset)
    joined = 0
    for a, b in zip(starts, starts[1:]):
        if decompress(rom, a)[1] == b:
            joined += 1
        else:
            failures += 1
            print(f'FAIL portrait ${a:06X} does not end at ${b:06X}')
    print(f'Portraits: {joined} of {len(starts) - 1} end where the next begins')
    return 1 if failures else 0


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    ap.add_argument('addrs', nargs='*')
    ap.add_argument('--self-test', action='store_true')
    ap.add_argument('--out')
    ap.add_argument('--hex', action='store_true')
    args = ap.parse_args()
    root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    rom = open(os.path.join(root, 'fe4.sfc'), 'rb').read()
    if args.self_test:
        return self_test(root, rom)
    data = b''
    for s in args.addrs:
        a = parse_addr(s)
        try:
            data, end = decompress(rom, a)
        except DecompressionError as e:
            print(f'${a:06X}: {e}')
            continue
        size = stream_size(a, end)
        print(f'${a:06X}: {size} bytes compressed, {len(data)} decompressed, ends at ${end:06X}')
        if args.hex:
            for i in range(0, len(data), 16):
                print(f'  {i:04X}: ' + ' '.join(f'{x:02X}' for x in data[i:i + 16]))
    if args.out:
        open(args.out, 'wb').write(data)


if __name__ == '__main__':
    sys.exit(main())
