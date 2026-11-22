#!/usr/bin/env python3
"""Verify or update FE4's internal code checksums and SNES header checksum.

usage:
  python3 tools/checksums.py --verify ROM [--labels labels.txt]
  python3 tools/checksums.py --update ROM [--labels labels.txt] [--disable-checks]
"""
import argparse
import os
import re
import struct
import sys

# Default CPU addresses from the original Japanese 1.0 ROM layout, used when
# labels.txt is omitted or does not contain a symbol.
DEFAULTS = {
    'aCodeChecksumRanges': 0x878000,
    'aCodeChecksums': 0x8F8000,
    'aCodeChecksumsCopy87': 0x878008,
    'aCodeChecksumsCopy88': 0x888000,
}

CHECKSUM_TABLE_NAMES = (
    'aCodeChecksums',
    'aCodeChecksumsCopy87',
    'aCodeChecksumsCopy88',
)

HEADER_CHECKSUM_OFFSET = 0xFFDC


def rom_offset(addr):
    """Map a HiROM CPU address ($80-$FF) to a file offset."""
    bank = addr >> 16
    if 0x80 <= bank <= 0xBF or 0xC0 <= bank <= 0xFF:
        return addr & 0x3FFFFF
    raise ValueError(f'Not a ROM address: ${addr:06X}')


def load_labels(path):
    """Read symbol addresses from a 64tass VICE label file if it exists."""
    labels = dict(DEFAULTS)
    if path and os.path.exists(path):
        with open(path, encoding='utf-8') as f:
            for line in f:
                m = re.match(r'al ([0-9a-fA-F]+) \.(\S+)', line)
                if m:
                    name = m.group(2)
                    if name in labels:
                        labels[name] = int(m.group(1), 16)
    return labels


def word_sum(rom, start_off, end_off_excl):
    """16-bit sum of little-endian words starting at start_off while < end_off_excl."""
    return sum(
        struct.unpack_from('<H', rom, off)[0]
        for off in range(start_off, end_off_excl, 2)
    ) & 0xFFFF


def compute_code_sums(rom, labels):
    """Compute (bank80_sum, bank87_sum) using ranges stored at aCodeChecksumRanges."""
    ranges_off = rom_offset(labels['aCodeChecksumRanges'])
    s80, e80, s87, e87 = struct.unpack_from('<4H', rom, ranges_off)
    off80_start = rom_offset(0x800000 | s80)
    off80_end = rom_offset(0x800000 | e80)
    off87_start = rom_offset(0x870000 | s87)
    off87_end = rom_offset(0x870000 | e87)
    return word_sum(rom, off80_start, off80_end), word_sum(rom, off87_start, off87_end)


def compute_header_checksum(rom):
    """Compute SNES internal header (complement, checksum) bytes."""
    total = (
        sum(rom[:HEADER_CHECKSUM_OFFSET])
        + 0xFF + 0xFF + 0x00 + 0x00
        + sum(rom[HEADER_CHECKSUM_OFFSET + 4:])
    ) & 0xFFFF
    return (~total) & 0xFFFF, total


def verify_rom(rom, labels):
    """Check code checksum tables and SNES header checksum; return list of errors."""
    errors = []
    sum80, sum87 = compute_code_sums(rom, labels)
    for name in CHECKSUM_TABLE_NAMES:
        off = rom_offset(labels[name])
        stored80, stored87, enabled = struct.unpack_from('<3H', rom, off)
        if stored80 != sum80 or stored87 != sum87:
            errors.append(
                f'{name} (${labels[name]:06X}): stored (${stored80:04X}, ${stored87:04X}), '
                f'expected (${sum80:04X}, ${sum87:04X})'
            )

    comp, total = compute_header_checksum(rom)
    stored_comp, stored_total = struct.unpack_from('<2H', rom, HEADER_CHECKSUM_OFFSET)
    if stored_comp != comp or stored_total != total:
        errors.append(
            f'SNES header checksum ($00/FFDC): stored (${stored_comp:04X}, ${stored_total:04X}), '
            f'expected (${comp:04X}, ${total:04X})'
        )
    return errors, (sum80, sum87, comp, total)


def update_rom(rom, labels, disable_checks=False):
    """Patch all three structCodeChecksums tables and the SNES header checksum."""
    sum80, sum87 = compute_code_sums(rom, labels)
    for name in CHECKSUM_TABLE_NAMES:
        off = rom_offset(labels[name])
        _, _, enabled = struct.unpack_from('<3H', rom, off)
        if disable_checks:
            enabled = 0
        struct.pack_into('<3H', rom, off, sum80, sum87, enabled)

    comp, total = compute_header_checksum(rom)
    struct.pack_into('<2H', rom, HEADER_CHECKSUM_OFFSET, comp, total)
    return sum80, sum87, comp, total


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    mode = ap.add_mutually_exclusive_group(required=True)
    mode.add_argument('--verify', metavar='ROM', help='verify code and header checksums')
    mode.add_argument('--update', metavar='ROM', help='recompute and write checksums in-place')
    ap.add_argument('--labels', default='labels.txt', help='VICE labels file (default labels.txt)')
    ap.add_argument('--disable-checks', action='store_true',
                    help='set ChecksEnabled = 0 in all structCodeChecksums copies (with --update)')
    args = ap.parse_args()

    if args.disable_checks and not args.update:
        ap.error('--disable-checks requires --update')

    path = args.verify or args.update
    labels = load_labels(args.labels)
    with open(path, 'rb') as f:
        rom = bytearray(f.read())

    if args.verify:
        errors, (sum80, sum87, comp, total) = verify_rom(rom, labels)
        if errors:
            for e in errors:
                print('ERROR: ' + e, file=sys.stderr)
            return 1
        print(f'Checksums OK: Bank80=${sum80:04X}, Bank87=${sum87:04X}, '
              f'Header=${comp:04X}/${total:04X}')
        return 0

    sum80, sum87, comp, total = update_rom(rom, labels, disable_checks=args.disable_checks)
    with open(path, 'wb') as f:
        f.write(rom)
    state = 'disabled' if args.disable_checks else 'preserved'
    print(f'Updated {path}: Bank80=${sum80:04X}, Bank87=${sum87:04X} (checks {state}), '
          f'Header=${comp:04X}/${total:04X}')
    return 0


if __name__ == '__main__':
    sys.exit(main())
