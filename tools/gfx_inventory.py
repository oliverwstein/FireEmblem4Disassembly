#!/usr/bin/env python3
"""Inventory every graphics stream and uncompressed gfx/ binary in FE4.

usage: tools/gfx_inventory.py [--write] [--summary] [--self-test]

Scans:
- Every gfx/**/*.streams file (all compressed streams)
- Every .binary "gfx/..." include in build.asm and engine/ (uncompressed assets)

Classifies each asset by:
- form, checked in this order:
  - authored: built from an author-facing source: an assembled PNG or grid CSV
    (scene_pack.py manifests), a portrait PNG, a chapter map CSV, map battle
    sprite data assembly, or a tile sheet whose tile order is already the
    asset's own order (the font glyph sheets, in character-code order; the item
    icon grid, with ItemIcons.json), or a map sprite frame-grid PNG
    (map_sprites.py: walking streams and both standing sheets);
  - unused: nothing in engine/, data/, include/, events/ or build.asm names the
    label outside a comment and its own definition (no reader);
  - sheet: an indexed .4bpp.png/.2bpp.png tile sheet in VRAM order;
  - raw: a committed .comp/.bin with no source.
- system and phase: from the tool or folder that builds an authored asset;
  for the rest, from words in the label (a heuristic: check odd ones by hand).

With --write, generates docs/reference/gfx_inventory.md.
"""
import argparse
import datetime
import glob
import json
import os
import re
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import map_sprites

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OUT_MD = os.path.join(ROOT, 'docs', 'reference', 'gfx_inventory.md')

STREAMS_RE = re.compile(r'^([A-Za-z_]\w*)\s+([A-Za-z0-9_./-]+)')
BINARY_RE = re.compile(r'^\s*([A-Za-z_]\w*)\s+\.binary\s+"(gfx/[^"]+)"')


def _load_scene_index():
    """Map output relative paths (.bin and .4bpp/.2bpp) to (manifest_rel, phase)."""
    out = {}
    mps = sorted(
        glob.glob(os.path.join(ROOT, 'gfx', 'scenes', '**', '*.scene.json'), recursive=True)
        + glob.glob(os.path.join(ROOT, 'gfx', 'ui', 'layouts', '**', '*.scene.json'), recursive=True)
    )
    for mp in mps:
        rel_mp = os.path.relpath(mp, ROOT).replace(os.sep, '/')
        m = json.load(open(mp, encoding='utf-8'))
        is_p4 = rel_mp.startswith('gfx/ui/layouts/') or os.path.basename(mp) in (
            'WorldMapHighlights.scene.json', 'EpilogueRankingBG1.scene.json', 'EpilogueRankingBG2.scene.json'
        )
        phase = 'Phase 4' if is_p4 else 'Phase 3'
        for s in m['sheets']:
            if s.get('writable', False):
                bpp = (s['png'][:-4] if 'png' in s else s['comp'][:-5]).replace('\\', '/')
                out[bpp] = (rel_mp, phase, 'scenes')
        for l in m['layers']:
            tm = l['tilemap'].replace('\\', '/')
            sys_name = 'ui' if rel_mp.startswith('gfx/ui/layouts/') else 'scenes'
            out[tm] = (rel_mp, phase, sys_name)
    return out


def _system_for_name(label, path):
    p = path.replace('\\', '/')
    if 'Portrait' in label or '/portraits/' in p:
        return 'portraits', 'Phase 2'
    if 'ChapterMap' in label or p.startswith('gfx/maps/'):
        return 'chapter_maps', 'Phase 1'
    if 'MapBattle' in label and 'Layout' in label:
        return 'map_battle', 'Phase 1'
    if 'MapBattleMagic' in label or 'MapMagic' in label or 'MapActionEffect' in label:
        return 'battle_effects', 'Phase 7'
    if 'MapBattle' in label:
        if 'LevelUp' in label or 'StatNames' in label or 'Pavise' in label or 'Shadow' in label or 'HUD' in label:
            return 'ui', 'Phase 4'
        return 'map_battle', 'Phase 5'
    if 'GiveGoldSprites' in label:
        return 'ui', 'Phase 4'
    if 'BattleAnimation' in label or 'BattleSprite' in label or 'BattleWeapon' in label or 'BattleCharacterPiece' in label:
        return 'battle_animation', 'Phase 6'
    if 'BattleSceneEffect' in label or 'BattleSceneDecomp' in label or 'BattleSceneUnused' in label:
        return 'battle_effects', 'Phase 7'
    if 'BattleScene' in label:
        return 'ui', 'Phase 4'
    if 'Title' in label or 'OpeningSky' in label or 'OpeningLogoSub' in label:
        return 'title', 'Unassigned'
    if 'WorldMap' in label or 'MapHighlight' in label:
        return 'worldmap', 'Unassigned'
    if 'DialogueFont' in label or '/fonts/' in p:
        return 'fonts', 'Phase 4'
    if 'ItemIcons' in label or '/icons/' in p:
        return 'icons', 'Phase 4'
    if 'MapMovementSprite' in p or 'StandingMapSprite' in label:
        return 'map_sprites', 'Phase 5'
    if '/map/' in p:
        return 'map', 'Unassigned'
    if 'BattleBanner' in label:
        return 'ui', 'Phase 4'
    if '/ui/' in p or any(k in label for k in (
        'Menu', 'Window', 'StatusScreen', 'Genealogy', 'UnitWindow', 'Castle', 'Augury',
        'ClassChange', 'Revive', 'SaveMenu', 'OptionsMenu', 'ChapterIntro', 'Hiragana',
        'Ranking', 'DialogueBox', 'Conversation', 'Shop', 'Depot', 'Arena', 'BlankTile',
        'FirstGenerationEnding',
    )):
        return 'ui', 'Phase 4'
    if 'Epilogue' in label or 'Opening' in label or 'GameOver' in label or 'Warning' in label or 'BattleBackground' in label or 'BattleForeground' in label or 'DialogueBackground' in label:
        return 'scenes', 'Phase 3'
    if 'Unused' in label:
        return 'unused', 'Unassigned'
    return 'misc', 'Unassigned'


SOURCE_GLOBS = ('engine/**/*.asm', 'data/**/*.asm', 'data/**/*.csv', 'include/**/*.h',
                'events/**/*.asm', 'build.asm')
WORD_RE = re.compile(r'[A-Za-z_]\w*')


def reference_counts():
    """How many times each identifier appears in the sources, outside comments."""
    counts = {}
    for g in SOURCE_GLOBS:
        for path in glob.glob(os.path.join(ROOT, g), recursive=True):
            with open(path, encoding='utf-8', errors='replace') as f:
                for line in f:
                    for w in WORD_RE.findall(line.split(';', 1)[0]):
                        counts[w] = counts.get(w, 0) + 1
    return counts


def collect_inventory():
    scene_idx = _load_scene_index()
    refs = reference_counts()
    entries = []

    # 1. Compressed streams from every .streams file
    map_sprite_src = {f: os.path.relpath(map_sprites.src_path(kind, n), ROOT)
                      for kind, _, n, f in map_sprites.sprites()}
    for spath in sorted(glob.glob(os.path.join(ROOT, 'gfx', '**', '*.streams'), recursive=True)):
        sdir = os.path.dirname(spath)
        rel_dir = os.path.relpath(sdir, ROOT).replace(os.sep, '/')
        with open(spath, encoding='utf-8') as f:
            for line in f:
                code = line.split(';', 1)[0].strip()
                if not code:
                    continue
                m = STREAMS_RE.match(code)
                if not m:
                    continue
                label, name = m.group(1), m.group(2)
                stem = os.path.join(rel_dir, name).replace('\\', '/')
                kind = None
                for ext in ('.4bpp.comp', '.2bpp.comp', '.bin.comp'):
                    if os.path.exists(os.path.join(ROOT, stem + ext)):
                        kind = ext[:-5]  # .4bpp, .2bpp, .bin
                        break
                assert kind is not None, f'missing .comp for {stem}'
                out_rel = stem + kind

                if rel_dir == 'gfx/build/portraits':
                    form, system, phase, src = 'authored', 'portraits', 'Phase 2', f'gfx/portraits/{name}.png'
                elif rel_dir == 'gfx/build/MapMovementSprites':
                    form, system, phase, src = 'authored', 'map_sprites', 'Phase 5', map_sprite_src[name]
                elif out_rel in scene_idx:
                    src, phase, system = scene_idx[out_rel]
                    form = 'authored'
                elif os.path.exists(os.path.join(ROOT, 'gfx/maps', f'{name}.csv')):
                    form, system, phase, src = 'authored', 'chapter_maps', 'Phase 1', f'gfx/maps/{name}.csv'
                elif os.path.exists(os.path.join(ROOT, 'gfx/map_battle', f'{name}.asm')):
                    form, system, phase, src = 'authored', 'map_battle', 'Phase 1', f'gfx/map_battle/{name}.asm'
                elif refs.get(label, 0) == 0:
                    system, phase = _system_for_name(label, out_rel)
                    form, src = 'unused', out_rel + '.comp'
                elif kind in ('.4bpp', '.2bpp') and os.path.exists(os.path.join(ROOT, out_rel + '.png')):
                    system, phase = _system_for_name(label, out_rel)
                    form, src = 'sheet', out_rel + '.png'
                else:
                    system, phase = _system_for_name(label, out_rel)
                    form, src = 'raw', out_rel + '.comp'

                entries.append({
                    'kind': 'compressed', 'label': label, 'output': out_rel,
                    'form': form, 'system': system, 'phase': phase, 'source': src,
                })

    # 2. Uncompressed .binary "gfx/..." includes in build.asm and engine/
    asm_files = [os.path.join(ROOT, 'build.asm')] + sorted(
        glob.glob(os.path.join(ROOT, 'engine', '**', '*.asm'), recursive=True)
    )
    for af in asm_files:
        with open(af, encoding='utf-8') as f:
            for line in f:
                m = BINARY_RE.match(line)
                if not m:
                    continue
                label, rel_out = m.group(1), m.group(2)
                if rel_out.startswith('gfx/build/map_sprites/'):
                    kind_dir = 'short' if rel_out.endswith('1.4bpp') else 'tall'
                    form, system, phase, src = ('authored', 'map_sprites', 'Phase 5',
                                                f'gfx/map_sprites/{kind_dir}/*.png')
                elif rel_out == 'gfx/icons/ItemIcons.4bpp':
                    form, system, phase, src = 'authored', 'icons', 'Phase 4', 'gfx/icons/ItemIcons.json'
                elif rel_out.startswith('gfx/fonts/'):
                    form, system, phase, src = 'authored', 'fonts', 'Phase 4', rel_out + '.png'
                elif rel_out in scene_idx:
                    src, phase, system = scene_idx[rel_out]
                    form = 'authored'
                elif refs.get(label, 0) <= 1:
                    system, phase = _system_for_name(label, rel_out)
                    form, src = 'unused', rel_out
                elif rel_out.endswith(('.4bpp', '.2bpp')) and os.path.exists(os.path.join(ROOT, rel_out + '.png')):
                    system, phase = _system_for_name(label, rel_out)
                    form, src = 'sheet', rel_out + '.png'
                else:
                    system, phase = _system_for_name(label, rel_out)
                    form, src = 'raw', rel_out

                entries.append({
                    'kind': 'uncompressed', 'label': label, 'output': rel_out,
                    'form': form, 'system': system, 'phase': phase, 'source': src,
                })

    return entries


def summarize(entries):
    comp = [e for e in entries if e['kind'] == 'compressed']
    uncomp = [e for e in entries if e['kind'] == 'uncompressed']
    forms = ('authored', 'sheet', 'raw', 'unused')
    return {
        'total': len(entries),
        'compressed': len(comp),
        'uncompressed': len(uncomp),
        'comp_by_form': {k: sum(1 for e in comp if e['form'] == k) for k in forms},
        'uncomp_by_form': {k: sum(1 for e in uncomp if e['form'] == k) for k in forms},
        'total_by_form': {k: sum(1 for e in entries if e['form'] == k) for k in forms},
    }


def render_markdown(entries):
    s = summarize(entries)
    today = datetime.date.today().isoformat()
    lines = [
        f'<!-- Made by tools/gfx_inventory.py on {today}; do not edit. -->',
        '',
        '# Graphics Asset Inventory',
        '',
        f'Total tracked assets: **{s["total"]}** (**{s["compressed"]}** compressed streams, **{s["uncompressed"]}** uncompressed `.binary` includes).',
        '',
        '## Summary by Form',
        '',
        '| Form | Compressed | Uncompressed | Total |',
        '|---|---:|---:|---:|',
    ]
    for form in ('authored', 'sheet', 'raw', 'unused'):
        lines.append(
            f'| `{form}` | {s["comp_by_form"][form]} | {s["uncomp_by_form"][form]} | {s["total_by_form"][form]} |'
        )
    lines += [
        f'| **Total** | **{s["compressed"]}** | **{s["uncompressed"]}** | **{s["total"]}** |',
        '',
        '## Summary by System and Form',
        '',
        '| System | Authored | Sheet | Raw | Unused | Total |',
        '|---|---:|---:|---:|---:|---:|',
    ]
    systems = sorted({e['system'] for e in entries})
    for sys_name in systems:
        sub = [e for e in entries if e['system'] == sys_name]
        c = {k: sum(1 for e in sub if e['form'] == k) for k in ('authored', 'sheet', 'raw', 'unused')}
        lines.append(f'| `{sys_name}` | {c["authored"]} | {c["sheet"]} | {c["raw"]} | {c["unused"]} | {len(sub)} |')

    lines += [
        '',
        '## All Assets',
        '',
        '| Kind | Label | Form | System | Phase | Source | Output |',
        '|---|---|---|---|---|---|---|',
    ]
    for e in entries:
        lines.append(
            f'| {e["kind"]} | `{e["label"]}` | `{e["form"]}` | `{e["system"]}` | {e["phase"]} | `{e["source"]}` | `{e["output"]}` |'
        )
    return '\n'.join(lines) + '\n'


def self_test():
    entries = collect_inventory()
    s = summarize(entries)
    assert s['compressed'] == 1647, f'expected 1647 compressed streams, got {s["compressed"]}'
    assert s['uncompressed'] > 0
    assert all(e['form'] in ('authored', 'sheet', 'raw', 'unused') for e in entries)
    assert all(e['system'] != 'misc' for e in entries), \
        f'misc entries: {[e for e in entries if e["system"] == "misc"][:5]}'
    strip = lambda t: t.split('\n', 1)[1]
    with open(OUT_MD, encoding='utf-8') as f:
        assert strip(f.read()) == strip(render_markdown(entries)), \
            f'{OUT_MD} is out of date: run tools/gfx_inventory.py --write'
    named = [e['label'] for e in entries if 'Unused' in e['label'] and e['form'] != 'unused']
    if named:
        print(f'note: {len(named)} labels named Unused have a reader: {", ".join(named[:8])}')
    print(f'Inventory verified: {s["compressed"]} compressed + {s["uncompressed"]} uncompressed = '
          f'{s["total"]} total ({s["total_by_form"]})')


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    ap.add_argument('--write', action='store_true')
    ap.add_argument('--summary', action='store_true')
    ap.add_argument('--self-test', action='store_true')
    args = ap.parse_args()

    if args.self_test:
        self_test()
        return
    entries = collect_inventory()
    if args.summary:
        s = summarize(entries)
        print(json.dumps(s, indent=2))
    if args.write:
        os.makedirs(os.path.dirname(OUT_MD), exist_ok=True)
        with open(OUT_MD, 'w', encoding='utf-8') as f:
            f.write(render_markdown(entries))
        print(f'Wrote {OUT_MD}')
    if not (args.summary or args.write):
        ap.print_help()


if __name__ == '__main__':
    main()
