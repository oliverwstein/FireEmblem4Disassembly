#!/usr/bin/env python3
"""Cross-platform incremental build driver for the Fire Emblem 4 disassembly.

Usage:
  python3 build.py             build FE4Disassembly.sfc and compare it to fe4.sfc
  python3 build.py mod [--disable-checks]
                               build FE4Disassembly.sfc and update code/header
                               checksums without comparing to fe4.sfc
  python3 build.py coverage    also report how much of the ROM is built from source
  python3 build.py pad SECTION N [--fix-checksums|--disable-checks]
                               padding test: build FE4Padded.sfc with N bytes
                               inserted at the start of SECTION
  python3 build.py test [--full]
                               run static checks and tool self-tests
  python3 build.py clean       remove generated files
"""
import argparse
import datetime
import glob
import hashlib
import os
import re
import shutil
import subprocess
import sys
import tempfile

ROOT = os.path.dirname(os.path.abspath(__file__))
ROM = 'fe4.sfc'
OUT = 'FE4Disassembly.sfc'
EXPECTED_SHA1 = '90f0bdeaf0151899f96281258fcb30899fbd0d44'
ASFLAGS = ['-x', '-f', '-C', '-a', '-Wall', '-Wno-portable', '-Wno-shadow', '-Wno-deprecated']

ASSET_COMPILERS = [
    'tools/portrait_pack.py',
    'tools/map_sprites.py',
    'tools/map_battle_sprites.py',
    'tools/battle_animations.py',
    'tools/battle_effects.py',
    'tools/palettes.py',
    'tools/scene_pack.py',
    'tools/item_icons.py',
    'tools/chapter_maps.py',
    'tools/map_battle_layouts.py',
]

STREAMS_ENTRY_RE = re.compile(r'^([A-Za-z_]\w*)\s+([A-Za-z0-9_./-]+)')


def find_64tass():
    """Return path to 64tass executable or exit with instructions."""
    found = shutil.which('64tass')
    if found:
        return found
    for candidate in (os.path.join(ROOT, 'tools', '64tass.exe'),
                      os.path.join(ROOT, 'tools', '64tass')):
        if os.path.isfile(candidate):
            return candidate
    sys.exit('Missing 64tass (on macOS: brew install tass64; on Windows: put 64tass.exe in tools/)')


def run_tool(rel_path, *args, cwd=None, check=True, capture=False):
    """Run a Python tool under tools/ with sys.executable."""
    cmd = [sys.executable, os.path.join(ROOT, rel_path), *args]
    return subprocess.run(
        cmd,
        cwd=cwd or ROOT,
        check=check,
        text=True,
        capture_output=capture,
    )


def stamp(out_path, tool_rel, src_rel):
    """Prepend a generated-file header comment to out_path."""
    today = datetime.date.today().isoformat()
    header = f'; Made by {tool_rel} from {src_rel} on {today}; do not edit.\n'
    content = open(out_path, 'r', encoding='utf-8').read()
    with open(out_path, 'w', encoding='utf-8') as f:
        f.write(header + content)


def is_newer(src_paths, out_path):
    """Return True if out_path is missing or any existing src_path is newer than out_path."""
    if not os.path.exists(out_path):
        return True
    out_mtime = os.path.getmtime(out_path)
    return any(os.path.exists(s) and os.path.getmtime(s) > out_mtime for s in src_paths)


def _iter_streams_entries(streams_path):
    """Yield (label, name) pairs from a .streams manifest."""
    with open(streams_path, encoding='utf-8') as f:
        for line in f:
            code = line.split(';', 1)[0].split('#', 1)[0].split()
            if not code or code[0] in ('start', 'end'):
                continue
            yield code[0], code[1]


def generate():
    """Convert dialogue, CSV tables, graphics, and stream layouts incrementally."""
    sys.path.insert(0, os.path.join(ROOT, 'tools'))
    import gfx

    # 1. Dialogue text -> *.dialogue.txt
    proc_dialogue = os.path.join(ROOT, 'tools', 'process_dialogue.py')
    font = os.path.join(ROOT, 'text', 'dialogue', 'DialogueFont.txt')
    if not os.path.exists(proc_dialogue):
        sys.exit('Missing tools/process_dialogue.py (see README.md)')
    for t in sorted(glob.glob(os.path.join(ROOT, 'text', 'dialogue', '**', '*.txt'), recursive=True)):
        if t == font or t.endswith('.dialogue.txt'):
            continue
        out = t[:-4] + '.dialogue.txt'
        if is_newer([t, font], out):
            run_tool('tools/process_dialogue.py', t, font, out)
            stamp(out, 'tools/process_dialogue.py', os.path.relpath(t, ROOT).replace(os.sep, '/'))

    # 2. CSV tables -> *.csv.asm (except CharacterData.csv and ItemData.csv)
    c2a_path = os.path.join(ROOT, 'tools', 'c2a.py')
    if not os.path.exists(c2a_path):
        sys.exit('Missing tools/c2a.py (see README.md)')
    skip_csvs = {
        os.path.join(ROOT, 'data', 'character', 'CharacterData.csv'),
        os.path.join(ROOT, 'data', 'item', 'ItemData.csv'),
    }
    for t in sorted(glob.glob(os.path.join(ROOT, 'data', '**', '*.csv'), recursive=True)):
        if t in skip_csvs:
            continue
        out = t[:-4] + '.csv.asm'
        if is_newer([t], out):
            run_tool('tools/c2a.py', t, out)
            stamp(out, 'tools/c2a.py', os.path.relpath(t, ROOT).replace(os.sep, '/'))

    # 3. Direct PNG -> .4bpp / .2bpp (excluding gfx/effects/, handled by battle_effects.py)
    effects_dir = os.path.join(ROOT, 'gfx', 'effects') + os.sep
    for t in sorted(glob.glob(os.path.join(ROOT, 'gfx', '**', '*.[24]bpp.png'), recursive=True)):
        if t.startswith(effects_dir):
            continue
        out = t[:-4]
        if is_newer([t], out):
            data = gfx.png_to_bpp(t, gfx.depth_of(t))
            with open(out, 'wb') as f:
                f.write(data)

    # 4. Asset compilers (before .4bpp/.2bpp/.bin LZ compression)
    for compiler in ASSET_COMPILERS:
        if os.path.exists(os.path.join(ROOT, compiler)):
            run_tool(compiler, 'build')

    # 5. LZ compression for .comp files and any new streams declared in *.streams
    lz_targets = {}  # (uncompressed_path, comp_path, lz_path)
    for comp_path in sorted(
        glob.glob(os.path.join(ROOT, 'gfx', '**', '*.4bpp.comp'), recursive=True)
        + glob.glob(os.path.join(ROOT, 'gfx', '**', '*.2bpp.comp'), recursive=True)
        + glob.glob(os.path.join(ROOT, 'gfx', '**', '*.bin.comp'), recursive=True)
        + glob.glob(os.path.join(ROOT, 'audio', '**', '*.bin.comp'), recursive=True)
    ):
        raw_path = comp_path[:-5]
        if os.path.exists(raw_path):
            lz_targets[raw_path] = (raw_path, comp_path, raw_path + '.lz')

    streams_files = sorted(glob.glob(os.path.join(ROOT, 'gfx', '**', '*.streams'), recursive=True))
    for sp in streams_files:
        folder = os.path.dirname(sp)
        for _label, name in _iter_streams_entries(sp):
            for ext in ('.4bpp', '.2bpp', '.bin'):
                raw_path = os.path.join(folder, name + ext)
                comp_path = raw_path + '.comp'
                if os.path.exists(raw_path) and raw_path not in lz_targets:
                    lz_targets[raw_path] = (raw_path, comp_path, raw_path + '.lz')
                    break

    for raw_path, comp_path, lz_path in sorted(lz_targets.values()):
        deps = [raw_path] + ([comp_path] if os.path.exists(comp_path) else [])
        if is_newer(deps, lz_path):
            raw_bytes = open(raw_path, 'rb').read()
            lz_bytes = gfx.lz(raw_bytes, comp_path)
            with open(lz_path, 'wb') as f:
                f.write(lz_bytes)

    # 6. Stream layouts across bank halves
    stream_layout_tool = os.path.join(ROOT, 'tools', 'stream_layout.py')
    for sp in streams_files:
        folder = os.path.dirname(sp)
        out_asm = os.path.join(folder, 'Layout.asm')
        deps = [sp, stream_layout_tool] + glob.glob(os.path.join(folder, '*.lz')) + glob.glob(os.path.join(folder, '*.comp'))
        if is_newer(deps, out_asm):
            run_tool('tools/stream_layout.py', sp, out_asm)

    # 7. CharacterData.csv & ItemData.csv (FE4c2a.py) + auto-generated offset tables
    for rel_dir, csv_name, helper_name in [
        ('data/character', 'CharacterData.csv', 'CharacterDataHelper.h'),
        ('data/item', 'ItemData.csv', 'ItemDataHelper.h'),
    ]:
        d = os.path.join(ROOT, rel_dir)
        csv_p = os.path.join(d, csv_name)
        helper_p = os.path.join(d, helper_name)
        out_p = os.path.join(d, csv_name[:-4] + '.csv.asm')
        if is_newer([csv_p, helper_p], out_p):
            run_tool('tools/FE4c2a.py', csv_name, helper_name, os.path.basename(out_p), cwd=d)
            stamp(out_p, 'tools/FE4c2a.py', f'{rel_dir}/{csv_name}')

    run_tool('tools/gen_offsets.py')


def assemble(out_name, log_name):
    """Assemble build.asm with 64tass into out_name, writing output to log_name."""
    tass = find_64tass()
    cmd = [tass, *ASFLAGS, '-o', out_name, '--vice-labels', '-l', 'labels.txt', 'build.asm']
    res = subprocess.run(cmd, cwd=ROOT, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)
    with open(os.path.join(ROOT, log_name), 'w', encoding='utf-8') as f:
        f.write(res.stdout)
    if res.returncode != 0:
        err_lines = [l for l in res.stdout.splitlines() if 'error' in l.lower()]
        for l in err_lines[:20]:
            print(l, file=sys.stderr)
        sys.exit(f'Assembly failed; see {log_name}')


def verify():
    """Verify FE4Disassembly.sfc SHA-1 and internal code checksums against fe4.sfc."""
    out_path = os.path.join(ROOT, OUT)
    rom_path = os.path.join(ROOT, ROM)
    sha = hashlib.sha1(open(out_path, 'rb').read()).hexdigest()
    if sha == EXPECTED_SHA1:
        print(f'OK: {OUT} matches the original ROM')
        run_tool('tools/checksums.py', '--verify', OUT)
        return
    print(f'MISMATCH: {OUT} differs from the original ROM', file=sys.stderr)
    a = open(rom_path, 'rb').read()
    b = open(out_path, 'rb').read()
    if len(a) != len(b):
        print(f'  size differs: original {len(a):,} bytes, built {len(b):,} bytes', file=sys.stderr)
    diffs = [i for i, (x, y) in enumerate(zip(a, b)) if x != y]
    for i in diffs[:10]:
        print(f'  {0xC00000 + i:06X}: original {a[i]:02X}, built {b[i]:02X}', file=sys.stderr)
    print(f'  {len(diffs):,} bytes differ', file=sys.stderr)
    sys.exit(1)


def cmd_clean():
    """Remove generated build artifacts."""
    patterns = [
        os.path.join(ROOT, 'text', '**', '*.dialogue.txt'),
        os.path.join(ROOT, 'data', '**', '*.csv.asm'),
        os.path.join(ROOT, 'gfx', '**', '*.4bpp'),
        os.path.join(ROOT, 'gfx', '**', '*.2bpp'),
        os.path.join(ROOT, 'gfx', '**', '*.4bpp.lz'),
        os.path.join(ROOT, 'gfx', '**', '*.2bpp.lz'),
        os.path.join(ROOT, 'gfx', '**', '*.bin.lz'),
        os.path.join(ROOT, 'gfx', '**', 'Layout.asm'),
        os.path.join(ROOT, 'audio', '**', '*.bin.lz'),
    ]
    for pat in patterns:
        for p in glob.glob(pat, recursive=True):
            if os.path.isfile(p):
                os.remove(p)
    for compiler in ASSET_COMPILERS:
        if os.path.exists(os.path.join(ROOT, compiler)):
            run_tool(compiler, 'clean')
    for fname in (OUT, 'FE4Padded.sfc', 'log.txt', 'labels.txt'):
        p = os.path.join(ROOT, fname)
        if os.path.exists(p):
            os.remove(p)


def cmd_coverage():
    """Build with $00 and $FF base ROMs to prove 100% source coverage."""
    tass = find_64tass()
    with tempfile.TemporaryDirectory() as tmp:
        src = os.path.join(tmp, 'src')
        shutil.copytree(
            ROOT,
            src,
            ignore=shutil.ignore_patterns('.git', '*.smc', OUT),
        )
        for fill in (0x00, 0xFF):
            with open(os.path.join(src, ROM), 'wb') as f:
                f.write(bytes([fill]) * 0x400000)
            out_file = os.path.join(tmp, f'{fill:02X}.sfc')
            subprocess.run(
                [tass, *ASFLAGS, '-o', out_file, 'build.asm'],
                cwd=src,
                check=True,
                stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL,
            )
        a = open(os.path.join(tmp, '00.sfc'), 'rb').read()
        b = open(os.path.join(tmp, 'FF.sfc'), 'rb').read()
        n = sum(x == y for x, y in zip(a, b))
        print(f'Coverage: {n:,} of {len(a):,} bytes built from source ({n / len(a) * 100:.2f}%)')


def cmd_test(full=False):
    """Run static validation checks and tool self-tests."""
    failures = []

    def check(label, rel_tool, *args, check_stdout=None):
        print(f'==> {label} ...', flush=True)
        res = run_tool(rel_tool, *args, check=False, capture=True)
        ok = res.returncode == 0
        if ok and check_stdout is not None:
            ok = check_stdout(res.stdout)
        if ok:
            print(f'PASS: {label}')
        else:
            print(f'FAIL: {label}', file=sys.stderr)
            if res.stdout.strip():
                print(res.stdout.strip(), file=sys.stderr)
            if res.stderr.strip():
                print(res.stderr.strip(), file=sys.stderr)
            failures.append(label)

    # Static checks
    check('check_paths', 'tools/check_paths.py')
    check('stale_notes', 'tools/stale_notes.py',
          check_stdout=lambda s: '0 are reached now' in s)
    check('bank_addresses', 'tools/bank_addresses.py',
          check_stdout=lambda s: s.strip() == '')
    check('raw_addresses', 'tools/raw_addresses.py',
          check_stdout=lambda s: '0 label, 0 entry, 0 offset; 0 local labels to add' in s)
    check('code_pointers', 'tools/code_pointers.py',
          check_stdout=lambda s: 'Raw stores: 0.' in s)
    check('sound_kinds', 'tools/sound_kinds.py')

    fast_selftests = [
        'tools/gfx_inventory.py',
        'tools/gfx.py',
        'tools/chapter_maps.py',
        'tools/map_battle_layouts.py',
        'tools/portrait_pack.py',
        'tools/scene_pack.py',
        'tools/item_icons.py',
        'tools/font_preview.py',
        'tools/map_sprites.py',
        'tools/map_battle_sprites.py',
        'tools/battle_animations.py',
        'tools/battle_effects.py',
        'tools/battle_scene_palettes.py',
        'tools/palettes.py',
        'tools/decompress.py',
    ]
    for tool in fast_selftests:
        if os.path.exists(os.path.join(ROOT, tool)):
            check(f'{os.path.basename(tool)} --self-test', tool, '--self-test')

    if full:
        slow_selftests = [
            ('tools/backgrounds.py', '--self-test'),
            ('tools/battle_frames.py', '--self-test'),
            ('tools/battle_moves.py', '--self-test'),
            ('tools/sound.py', '--self-test'),
            ('tools/dialogue.py', '--self-test'),
            ('tools/compress.py', '--self-test'),
            ('tools/disasm.py', '--selftest'),
        ]
        for tool, flag in slow_selftests:
            if os.path.exists(os.path.join(ROOT, tool)):
                check(f'{os.path.basename(tool)} {flag}', tool, flag)

    if failures:
        sys.exit(f'\n{len(failures)} check(s) failed: {", ".join(failures)}')
    print('\nAll checks passed.')


def main():
    os.chdir(ROOT)
    ap = argparse.ArgumentParser(add_help=True, description='FE4 Disassembly build driver')
    sub = ap.add_subparsers(dest='cmd')

    sub.add_parser('build', help='Build FE4Disassembly.sfc and compare against fe4.sfc')

    p_mod = sub.add_parser('mod', help='Build FE4Disassembly.sfc without fe4.sfc and update checksums')
    p_mod.add_argument('--disable-checks', action='store_true')

    sub.add_parser('coverage', help='Build and verify 100%% source coverage')
    sub.add_parser('clean', help='Remove generated files')

    p_pad = sub.add_parser('pad', help='Run padding/shiftability test on SECTION')
    p_pad.add_argument('section')
    p_pad.add_argument('n')
    p_pad.add_argument('--fix-checksums', action='store_true')
    p_pad.add_argument('--disable-checks', action='store_true')

    p_test = sub.add_parser('test', help='Run static checks and tool self-tests')
    p_test.add_argument('--full', action='store_true', help='Also run slower end-to-end self-tests')

    args = ap.parse_args()
    cmd = args.cmd or 'build'

    if cmd == 'clean':
        cmd_clean()
        return

    if cmd == 'test':
        cmd_test(full=args.full)
        return

    if cmd in ('build', 'coverage', 'pad'):
        if not os.path.isfile(os.path.join(ROOT, ROM)):
            sys.exit(f'Missing {ROM}')

    generate()
    run_tool('tools/check_paths.py')
    assemble(OUT, 'log.txt')

    if cmd == 'mod':
        cs_args = ['--update', OUT]
        if args.disable_checks:
            cs_args.append('--disable-checks')
        run_tool('tools/checksums.py', *cs_args)
        return

    verify()

    if cmd == 'coverage':
        cmd_coverage()
    elif cmd == 'pad':
        pad_args = [args.section, args.n]
        if args.fix_checksums:
            pad_args.append('--fix-checksums')
        if args.disable_checks:
            pad_args.append('--disable-checks')
        run_tool('tools/pad_test.py', *pad_args, '--', *ASFLAGS)


if __name__ == '__main__':
    main()
