#!/usr/bin/env python3
"""A compressor for the game's decompressor (rlDecompressor, tools/decompress.py).

usage: tools/compress.py IN OUT          compress the file IN
       tools/compress.py --self-test     check it on the streams in the ROM

compress(data) finds the smallest encoding of data in the format (an optimal
parse, by dynamic programming over every method at every position), so it is
usually a little smaller than the game's own compressor, which made other
choices. Its output is never byte-identical to the ROM's streams; the build
keeps a graphic's original stream for as long as its PNG still decodes to the
same bytes (see tools/gfx.py), and uses this only for graphics that changed.

Methods used: literals ($00-$3F), doubled bytes ($50-$5F), a byte before or
after each of a run of bytes ($60-$7F), copies from the output ($80-$DF), runs
($E0-$F7) and the end ($FF). Not used: the nybble method ($40-$4F) and copies
from the compressed stream ($F8-$FD), which the game's portraits do not use
either.
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

MAX_LITERAL = 64
MAX_COPY = 65                  # $C0-$DF: (5 bits << 1 | 1 bit) + 2
MAX_SHORT_COPY = 17            # $80-$BF: 4 bits + 2
MAX_SHORT_DISTANCE = 0x3FF
MAX_DISTANCE = 0x7FFF
MAX_RUN = 0xFFF + 3
MAX_SHORT_RUN = 10
MAX_DOUBLED = 16               # pairs
MAX_AROUND = 17                # pairs, at least 2


def _longest_copies(data):
    """For each position, {length: smallest distance} of copies from the output."""
    n = len(data)
    heads = {}
    out = []
    for p in range(n):
        best = {}
        if p + 1 < n:
            key = data[p:p + 2]
            longest = 1
            for q in reversed(heads.get(key, ())):    # nearest first
                dist = p - q
                if dist > MAX_DISTANCE:
                    break
                k = 0
                while p + k < n and k < MAX_COPY and data[p + k] == data[q + k]:
                    k += 1
                if k > longest:
                    for length in range(longest + 1, k + 1):
                        best[length] = dist
                    longest = k
                    if k == MAX_COPY:
                        break
            heads.setdefault(key, []).append(p)
        out.append(best)
    return out


def compress(data):
    data = bytes(data)
    n = len(data)
    copies = _longest_copies(data)
    INF = float('inf')
    cost = [INF] * (n + 1)
    choice = [None] * (n + 1)
    cost[n] = 1                                         # $FF
    for p in range(n - 1, -1, -1):
        best, pick = INF, None
        for length in range(1, min(MAX_LITERAL, n - p) + 1):
            c = 1 + length + cost[p + length]
            if c < best:
                best, pick = c, ('literal', length)
        run = 1
        while p + run < n and run < MAX_RUN and data[p + run] == data[p]:
            run += 1
        # Every run length up to 64, and the whole run: trying each length of a
        # long run at every position would make this quadratic in its length.
        for length in list(range(3, min(run, 64) + 1)) + ([run] if run > 64 else []):
            c = (2 if length <= MAX_SHORT_RUN else 3) + cost[p + length]
            if c < best:
                best, pick = c, ('run', length)
        for length, dist in copies[p].items():
            short = length <= MAX_SHORT_COPY and dist <= MAX_SHORT_DISTANCE
            c = (2 if short else 3) + cost[p + length]
            if c < best:
                best, pick = c, ('copy', length, dist)
        k = 0
        while p + 2 * k + 1 < n and k < MAX_DOUBLED and data[p + 2 * k] == data[p + 2 * k + 1]:
            k += 1
            c = 1 + k + cost[p + 2 * k]
            if c < best:
                best, pick = c, ('doubled', k)
        for kind, off in (('before', 0), ('after', 1)):
            v = data[p + off] if p + off < n else None
            k = 0
            while p + 2 * k + 1 < n and k < MAX_AROUND and data[p + 2 * k + off] == v:
                k += 1
                if k >= 2:
                    c = 2 + k + cost[p + 2 * k]
                    if c < best:
                        best, pick = c, (kind, k)
        cost[p], choice[p] = best, pick

    out = bytearray()
    p = 0
    while p < n:
        pick = choice[p]
        kind = pick[0]
        if kind == 'literal':
            length = pick[1]
            out += bytes([length - 1]) + data[p:p + length]
        elif kind == 'run':
            length = pick[1]
            if length <= MAX_SHORT_RUN:
                out += bytes([0xF0 | (length - 3), data[p]])
            else:
                c = length - 3
                out += bytes([0xE0 | c >> 8, c & 0xFF, data[p]])
        elif kind == 'copy':
            length, dist = pick[1], pick[2]
            if length <= MAX_SHORT_COPY and dist <= MAX_SHORT_DISTANCE:
                out += bytes([0x80 | (length - 2) << 2 | dist >> 8, dist & 0xFF])
            else:
                c = length - 2
                out += bytes([0xC0 | c >> 1, (c & 1) << 7 | dist >> 8, dist & 0xFF])
        elif kind == 'doubled':
            k = pick[1]
            length = 2 * k
            out += bytes([0x50 | (k - 1)]) + data[p:p + length:2]
        else:                                           # before / after
            k = pick[1]
            length = 2 * k
            off = 0 if kind == 'before' else 1
            out += bytes([(0x60 if kind == 'before' else 0x70) | (k - 2), data[p + off]])
            out += data[p + 1 - off:p + length:2]
        p += length
    out.append(0xFF)
    return bytes(out)


def self_test():
    import glob
    from decompress import decompress, stream_size
    root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    rom = open(os.path.join(root, 'fe4.sfc'), 'rb').read()
    streams = []
    for path in sorted(glob.glob(os.path.join(root, 'gfx', '**', '*.comp'), recursive=True)):
        buf = bytearray(rom)
        comp = open(path, 'rb').read()
        buf[0x3F0000:0x400000] = comp + b'\xFF' * (0x10000 - len(comp))
        streams.append((decompress(bytes(buf), 0xFF0000)[0], len(comp)))
    bad, ours, theirs = 0, 0, 0
    for data, size in streams:
        packed = compress(data)
        buf = bytearray(rom)
        buf[0x3F0000:0x400000] = packed + b'\xFF' * (0x10000 - len(packed))
        if decompress(bytes(buf), 0xFF0000)[0] != data:
            bad += 1
        ours += len(packed)
        theirs += size
    print(f'{len(streams) - bad} of {len(streams)} streams decompress back to the same bytes; '
          f'{ours:,} bytes against the original {theirs:,} ({ours / theirs:.1%})')
    return 1 if bad else 0


def main():
    if sys.argv[1:] == ['--self-test']:
        return self_test()
    if len(sys.argv) != 3:
        sys.exit(__doc__)
    open(sys.argv[2], 'wb').write(compress(open(sys.argv[1], 'rb').read()))


if __name__ == '__main__':
    sys.exit(main())
