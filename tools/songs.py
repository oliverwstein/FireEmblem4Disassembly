#!/usr/bin/env python3
"""Write audio/SONGS.md: every song script, what it does and where the game asks for it.

usage: tools/songs.py

A song is a script in aSoundScripts, picked by its number in wMusicID (the
script's ID; bit 15 only says to upload with VBlank off). This collects every
place that number comes from:

  - PLAY_SONG in events/ and DIALOGUE_PLAY_SONG in text/dialogue/, with the
    file they are in (the file names say which chapter and scene);
  - the tables of song numbers in the source, each with what indexes it
    (chapter, faction name, castle name), read by label;
  - immediates stored into wMusicID or wBattleSong (rlUnknown9695F5 plays
    wBattleSong when a battle scene starts), with the routine and the label
    or comment just before them;
  - its place in the debug menu's sound test (aDebugSongList).

and decodes each script from fe4.sfc with tools/sound.py: its steps, the upload
lists it sends and the chunks they name. Nothing is named from this; it is the
evidence to name songs from. Run it again after naming tables or routines.
"""
import datetime
import collections
import csv
import glob
import os
import re
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from sound import Sound, FIRST_CHUNK

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def song_constants():
    out = {}
    for l in open(os.path.join(ROOT, 'include/Sound.h'), encoding='utf-8'):
        m = re.match(r'\s+(SONG_\w+)\s*=\s*\$([0-9A-Fa-f]+)', l)
        if m:
            out[m.group(1)] = int(m.group(2), 16)
    return out


CONSTANTS = song_constants()


def value(token):
    token = token.strip()
    return CONSTANTS[token] if token in CONSTANTS else int(token.lstrip('$'), 16)


CHAPTERS = ['Prologue'] + [f'Chapter {i}' for i in range(1, 11)] + ['Final chapter']
SCRIPT_COMMANDS = {1: 'sound effect', 2: 'sound effect', 3: 'sound effect 2', 4: 'sound effect 2',
                   5: 'send command', 6: 'queue command', 7: 'upload FD', 8: 'upload FC', 9: 'upload FB',
                   10: 'upload FA', 11: 'deferred upload FD', 12: 'deferred upload FC',
                   13: 'deferred upload FB', 14: 'deferred upload FA', 15: 'wait for APU status',
                   16: 'wait for deferred upload', 17: 'queue command (checked)', 18: 'battle terrain command'}


def names_from_csv(path):
    rows = list(csv.reader(open(os.path.join(ROOT, path))))[1:]
    return [r[0].removeprefix('Faction').removesuffix('Name') for r in rows]


def table(label):
    """The .word values after `label` in engine/, up to the next label or section end."""
    for p in glob.glob(os.path.join(ROOT, 'engine/**/*.asm'), recursive=True):
        lines = open(p, encoding='utf-8').read().split('\n')
        for i, l in enumerate(lines):
            if re.match(rf'\s+{label} ; ', l):
                vals = []
                for m in lines[i + 1:]:
                    s = m.split(';')[0].strip()
                    if re.match(r'(\w+ ;|\.endsection|[a-z]\w* \.)', m.strip()) or (s and not s.startswith('.word')):
                        if vals:
                            break
                        continue
                    if s.startswith('.word'):
                        vals += [value(v) for v in s[5:].split(',')]
                return vals, os.path.relpath(p, ROOT)
    raise SystemExit(f'{label} not found')


def immediates():
    """(value, routine, context, file:line, target) for immediates stored into
    wMusicID or wBattleSong."""
    out = []
    for p in sorted(glob.glob(os.path.join(ROOT, 'engine/**/*.asm'), recursive=True)):
        lines = open(p, encoding='utf-8').read().split('\n')
        routine = None
        starts = {}
        for i, l in enumerate(lines):
            m = re.match(r'\s{6}(r[sl]\w+|proc\w+) ; ', l)
            if m:
                routine = m.group(1)
            starts[i] = routine
        for i, l in enumerate(lines):
            m = re.search(r'st[az] (?:@l )?(wMusicID|wBattleSong)\b', l)
            if not m:
                continue
            target = m.group(1)
            # Walk back through the routine: every lda # that reaches this store
            # directly or by a bra to a label just above it.
            labels_here = set()
            j = i - 1
            while j >= 0 and not lines[j].strip().startswith(('lda', 'jsl', 'jsr', 'bra', 'rts', 'rtl')):
                t = lines[j].strip()
                if re.match(r'^[_+]\w*$|^\+$', t):
                    labels_here.add(t)
                j -= 1
            for k in range(i - 1, max(0, i - 120), -1):
                if starts[k] != starts[i]:
                    break
                mm = re.match(r'\s+lda #(\$[0-9A-Fa-f]{4}|SONG_\w+)\s*$', lines[k])
                if not mm:
                    continue
                nxt = next((lines[x].strip() for x in range(k + 1, i + 1) if lines[x].strip()), '')
                reaches = (k == j or nxt.startswith(('sta ' + target, 'sta @l ' + target)) or
                           (nxt.startswith('bra ') and nxt.split()[1] in labels_here))
                if not reaches:
                    continue
                ctx = ''
                for x in range(k - 1, max(0, k - 5), -1):
                    t = lines[x].strip()
                    if t.startswith(';'):
                        ctx = t.lstrip('; ')
                        break
                    if re.match(r'^_\w+$', t):
                        ctx = t
                        break
                    if t and not t.startswith('bra'):
                        break
                out.append((value(mm.group(1)), starts[i], ctx, f'{os.path.relpath(p, ROOT)}:{k + 1}', target))
    return out


def describe(s, script):
    steps = []
    chunks = []
    for word, arg in s.script_lists[script]:
        cmd, wait = word >> 10, word & 0x3FF
        text = SCRIPT_COMMANDS.get(cmd, f'command {cmd}') if cmd else 'wait'
        if 7 <= cmd <= 14:
            ul = s.bank << 16 | arg
            ids = upload_ids(s, ul)
            chunks += [i for i in ids if isinstance(i, int)]
            text += f' `aSoundUpload{ul:06X}` ({" ".join(map(str, (f"${i:03X}" if isinstance(i, int) else i for i in ids)))})'
        elif cmd:
            text += f' ${arg:04X}'
        if wait:
            text += f', wait {wait}'
        steps.append(text)
    return steps, chunks


def upload_ids(s, ul):
    out = []
    for word, arg in s.upload_lists[ul]:
        if word >> 12 == 0xC:
            out.append(f'@{arg:04X}')
        elif word >> 12:
            out.append(f'cmd {word >> 12:X}')
        elif word < FIRST_CHUNK:
            out.append(f'indirect {word:02X}')
        else:
            out.append(word & 0x7FF)
    return out


def main():
    s = Sound(open(os.path.join(ROOT, 'fe4.sfc'), 'rb').read())
    uses = collections.defaultdict(list)

    for p in sorted(glob.glob(os.path.join(ROOT, 'events/**/*.asm'), recursive=True)):
        for m in re.finditer(r'PLAY_SONG (SONG_\w+|\$[0-9A-Fa-f]+)', open(p, encoding='utf-8').read()):
            uses[value(m.group(1)) & 0xFF].append(('event', os.path.basename(p)[:-4]))
    for p in sorted(glob.glob(os.path.join(ROOT, 'text/dialogue/**/*.txt'), recursive=True)):
        if p.endswith('.dialogue.txt'):
            continue
        for m in re.finditer(r'DIALOGUE_PLAY_SONG (SONG_\w+|\$[0-9A-Fa-f]+)', open(p, encoding='utf-8').read()):
            uses[value(m.group(1)) & 0xFF].append(('dialogue', os.path.relpath(p, os.path.join(ROOT, 'text/dialogue'))[:-4]))

    factions = names_from_csv('data/offset/FactionNameOffsets.csv')
    castles = names_from_csv('data/offset/CastleNameOffsets.csv')
    tables = [('aPlayerPhaseChapterSongIDs', 'player phase', lambda i: CHAPTERS[i]),
              ('aChapterFirstPhaseSongIDs', 'first phase of the chapter (rsStartChapterFirstPhaseSong)', lambda i: CHAPTERS[i]),
              ('aNonPlayerFactionPhaseSongIDs', 'phase of the faction', lambda i: factions[i]),
              ('aUnknown91F7B7', 'per chapter (rlUnknown91F75F)', lambda i: CHAPTERS[i]),
              ('aUnknown8A9D79', 'castle (rlUnknown8A9D39)', lambda i: castles[i])]
    for label, what, key in tables:
        vals, path = table(label)
        for i, v in enumerate(vals):
            if v:
                uses[v & 0xFF].append(('table', f'`{label}` {what}: {key(i)}'))
    debug, _ = table('aDebugSongList')
    debug_pos = {}
    for i, v in enumerate(debug):
        if v:
            debug_pos.setdefault(v & 0xFF, i)
    seen = set()
    for v, routine, ctx, where, target in immediates():
        what = 'battle song' if target == 'wBattleSong' else 'music'
        uses[v & 0xFF].append(('code', f'`{routine}` {what}' + (f' ({ctx})' if ctx else '') + f', {where}'))
        seen.add(where)
    # Any other use of a SONG_ constant in code (such as rsGetActiveFactionSongID's,
    # which return the number rather than store it).
    for p in sorted(glob.glob(os.path.join(ROOT, 'engine/**/*.asm'), recursive=True)):
        routine = None
        for i, l in enumerate(open(p, encoding='utf-8').read().split('\n')):
            m = re.match(r'\s{6}(r[sl]\w+|proc\w+) ; ', l)
            if m:
                routine = m.group(1)
            m = re.match(r'\s+(?:lda|cmp) #(SONG_\w+)', l)
            where = f'{os.path.relpath(p, ROOT)}:{i + 1}'
            if m and where not in seen:
                uses[CONSTANTS[m.group(1)]].append(('code', f'`{routine}`, {where}'))

    out = ['# Song scripts', '',
           f'Made by `tools/songs.py` on {datetime.date.today().isoformat()}; do not edit. A song is a script in `aSoundScripts`',
           '(`audio/sound_data.asm`), asked for by its number in `wMusicID`. For each number:',
           'where the game asks for it, its place in the debug sound test, and what the script',
           'does (upload lists with their chunk IDs; `@xxxx` sets the SPC address). Nothing',
           'here names a song; it is the evidence to name them from.', '']
    counts = collections.Counter()
    used = sorted(k for k in uses if uses[k])
    out.append(f'{len(s.scripts)} script numbers; {len(used)} asked for somewhere in the source; '
               f'{len(debug_pos)} in the sound test.')
    out.append('')
    for n in range(1, len(s.scripts) + 1):
        script = s.scripts[n - 1]
        steps, chunks = describe(s, script)
        names = [k for k, v in CONSTANTS.items() if v == n]
        head = f'## ${n:02X} (`aSoundScript{script:06X}`)' + ''.join(f' `{k}`' for k in names)
        if n in debug_pos:
            head += f', sound test {debug_pos[n]}'
        out.append(head)
        out.append('')
        groups = collections.OrderedDict()
        for kind, what in uses.get(n, []):
            groups.setdefault(kind, []).append(what)
        if not groups:
            out.append('- Not asked for by number anywhere in the source.')
        for kind, items in groups.items():
            counts[kind] += len(items)
            c = collections.Counter(items)
            text = ', '.join(f'{w} (x{c[w]})' if c[w] > 1 else w for w in dict.fromkeys(items))
            out.append(f'- **{kind}** ({len(items)}): {text}')
        out.append('- **script**: ' + '; '.join(steps))
        out.append('')
    path = os.path.join(ROOT, 'audio/SONGS.md')
    open(path, 'w', encoding='utf-8').write('\n'.join(out))
    print(f'audio/SONGS.md: {len(s.scripts)} scripts, {len(used)} with uses '
          f'({", ".join(f"{k} {v}" for k, v in counts.items())}), {len(debug_pos)} in the sound test')


if __name__ == '__main__':
    main()
