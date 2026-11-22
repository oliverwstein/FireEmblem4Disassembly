#!/usr/bin/env python3
"""Replace raw RAM addresses in built code with the names include/ gives them.

usage: tools/name_ram.py [--dry-run] [--report N]

Builds the ROM with --dump-labels to get every name defined in include/, nested
ones (aProcSystem.aHeaderBitfield) included. Then each operand in engine/ that
is a raw RAM address ($0F37,b,x or $7E46EB) gets the name at that address:

  - if exactly one name is there, it is used;
  - if a struct and its first field are both there (a name and the same name with
    a field after it), the field is used, since that is what is read;
  - names that have nothing to do with each other (unions) are left alone;
  - an address one or two bytes into a word (w...) or long (l...) variable is
    written name+1 or name+2.

Bank $00 addresses and their bank $7E mirror ($7E0000-$7E1FFF) count as the same.
SCOPED lists RAM that other code reuses for other values: a name in that range
with one of the given prefixes is only written in the files listed for it, and in
those files it is used over any other name at the same address.
A name of the same value cannot change how an operand assembles. --report N lists
the N raw addresses used most that still have no name.
"""
import argparse, collections, glob, os, re, subprocess, sys, tempfile

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from asmlib import ASFLAGS

# (first address, last address, name prefixes, the only files where those names are written)
SCOPED = [
    # The unit window's variables; bank $89 reuses the area. The debug menu's names there are not scoped.
    (0x7F82C7, 0x7F8438, ('wUnitWindow', 'aUnitWindow'), ('engine/menus/unit_window.asm',)),
    (0x7F8185, 0x7F92B4, ('wSkillWindow', 'aSkillWindow'), ('engine/menus/skill_window.asm',)),
    (0x7F8183, 0x7F8505, ('wDataWindow', 'aDataWindow'), ('engine/menus/data_window.asm',)),
    # The item window's variables; the map buffers (aTargetDistanceMap...) share the area.
    (0x7F8467, 0x7FAF4F, ('wItemWindow', 'aItemWindow'), ('engine/menus/item_window.asm',)),
    # The status screen's variables, written by the screens that open it too; the skill and data windows reuse the area.
    (0x7F8183, 0x7F82C4, ('wStatusScreen', 'aStatusScreen'),
     ('engine/menus/status_screen.asm', 'engine/menus/revive_screen.asm', 'engine/menus/unit_window.asm',
      'engine/castle/courtyard.asm', 'engine/map/input.asm')),
    (0x7FAF4E, 0x7FB167, ('aStatusScreen',), ('engine/menus/status_screen.asm',)),
    # The options menu's variables; the debug menu uses the area.
    (0x7F8400, 0x7F8810, ('wOptionsMenu', 'aOptionsMenu'), ('engine/menus/options_menu.asm',)),
    # The revive screen's draw mode (inside the options menu's area) and its variables.
    (0x7F8403, 0x7F8404, ('wReviveScreen',), ('engine/menus/revive_screen.asm',)),
    (0x7FB014, 0x7FB019, ('wReviveScreen',), ('engine/menus/revive_screen.asm',)),
    # The castle screen's variables; they reuse the map buffers and the world map reuses $7F8089-$7F808F.
    (0x7F757A, 0x7F8092, ('aCastle', 'wCastle', 'wKeeper', 'lKeeper', 'wConversation', 'wAugury'),
     ('engine/castle/castle_screen.asm', 'engine/castle/courtyard.asm', 'engine/castle/unit_commands.asm',
      'engine/castle/keepers.asm', 'engine/castle/lists.asm', 'engine/castle/shop.asm', 'engine/castle/depot.asm',
      'engine/castle/augury.asm', 'engine/castle/class_change.asm', 'engine/castle/conversation.asm',
      'engine/arena/arena.asm')),
    # The unit menu's slot lists; the AI uses the area for its own variables.
    (0x7E2000, 0x7E202F, ('aUnitMenu',), ('engine/menus/unit_menu.asm', 'engine/menus/item_list.asm',
     'engine/items/staves.asm')),
    # The battle animation combatants' motion; a few other screens reuse the area.
    (0x7E0AF3, 0x7E0B78, ('wBattleAnimation', 'bBattleAnimation', 'lBattleAnimation'),
     ('engine/unsorted/bank95.asm', 'engine/unsorted/bank96.asm', 'engine/unsorted/bank97.asm',
      'engine/battle_scene/animation_moves.asm', 'engine/battle_scene/script.asm',
      'engine/battle_scene/animations.asm')),
]

OPERAND = re.compile(r'^(\s+[a-z]{3} (?:@l )?)\$([0-9A-F]{4}|[0-9A-F]{6})\b((?:,b)?(?:,[xy])?)(\s*)$')


def ram_names():
    with tempfile.TemporaryDirectory() as tmp:
        out = os.path.join(tmp, 'all.txt')
        subprocess.run(['64tass', *ASFLAGS, '-o', os.path.join(tmp, 'x.sfc'), '--dump-labels', '-l', out,
                        'build.asm'], capture_output=True, text=True)
        text = open(out, encoding='utf-8').read()
    names = collections.defaultdict(set)
    for m in re.finditer(r'^include/[^:]+:\d+:\d+: ([A-Za-z_][\w.]*) = \$([0-9a-f]+)$', text, re.M):
        name, v = m.group(1), int(m.group(2), 16)
        if v < 0x2000:
            v |= 0x7E0000
        if 0x7E0000 <= v < 0x800000:
            names[v].add(name)
    return names


def pick(names):
    names = sorted(names, key=len)
    if len(names) == 1:
        return names[0]
    longest = names[-1]
    if all(longest.startswith(n + '.') or longest == n for n in names):
        return longest
    return None


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    ap.add_argument('--dry-run', action='store_true')
    ap.add_argument('--report', type=int, default=0)
    a = ap.parse_args()

    names = ram_names()

    def scope(n, v):
        """The files a name at v may be written in, or None for any file."""
        for lo, hi, prefixes, files in SCOPED:
            if lo <= v <= hi and n.startswith(prefixes):
                return files
        return None

    def allowed(v, f):
        """The names at v that file f may use: its own scoped names if it has any."""
        here = {n for n in names.get(v, ()) if scope(n, v) is None or f in scope(n, v)}
        own = {n for n in here if scope(n, v)}
        return own or here

    def name_for(v, f):
        if allowed(v, f):
            return pick(allowed(v, f))
        for k in (1, 2):
            if allowed(v - k, f):
                n = pick(allowed(v - k, f))
                if n and n.split('.')[-1][:1] in ('w', 'l') and (k == 1 or n.split('.')[-1][:1] == 'l'):
                    return f'{n}+{k}'
        return None

    total, missing = 0, collections.Counter()
    for f in sorted(glob.glob('engine/**/*.asm', recursive=True)):
        lines = open(f, encoding='utf-8').read().split('\n')
        changed = 0
        for i, line in enumerate(lines):
            code, sep, comment = line.partition(';')
            m = OPERAND.match(code)
            if not m:
                continue
            text, rest = m.group(2), m.group(3)
            v = int(text, 16)
            if len(text) == 4:
                if v >= 0x2000 or (v < 0x100 and (',x' in rest or ',y' in rest or not rest.startswith(',b'))):
                    continue    # a small offset from an index register is a struct field
                full = 0x7E0000 | v
            else:
                full = v
                if not 0x7E0000 <= full < 0x800000:
                    continue
            n = name_for(full, f)
            if not n:
                missing[f'${text}'] += 1
                continue
            lines[i] = f'{m.group(1)}{n}{rest}{m.group(4)}' + (sep + comment if sep else '')
            changed += 1
        if changed:
            total += changed
            if not a.dry_run:
                open(f, 'w', encoding='utf-8').write('\n'.join(lines))
    print(f'{total} operands now use names; {sum(missing.values())} raw RAM operands '
          f'({len(missing)} addresses) have no name')
    for addr, n in missing.most_common(a.report):
        print(f'{n:5} {addr}')


if __name__ == '__main__':
    main()
