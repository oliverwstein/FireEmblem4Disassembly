"""The proc script format, for tools that read proc definitions from the ROM.

A proc definition starts with a header (include/Procs.h, structProcInfo):

    +0  name (2 bytes)
    +2  init routine       (word, in the definition's bank)
    +4  on-cycle routine   (word, in the definition's bank)
    +6  script             (word, in the definition's bank)

A script is a list of words. A word below $8000 makes the proc sleep for that many
frames. Any other word is the address of a command routine in bank $82
(engine/core/proc.asm), followed by that command's arguments.
"""

# address: (name, argument bytes, how control continues)
#   'next'   go on to the next command
#   'stop'   the script ends or halts here
#   'jump'   go to the position in the first argument word
#   'branch' either go to that position or go on
COMMANDS = {
    0x8281D5: ('PROC_END', 0, 'stop'),
    0x8281E3: ('PROC_HALT_SLEEP', 0, 'stop'),
    0x8281E9: ('PROC_HALT', 0, 'stop'),
    0x8281F1: ('PROC_CALL', 3, 'next'),
    0x82820C: ('PROC_CALL_ARGS', None, 'next'),        # 3 + 1 + the count in that byte
    0x828237: ('PROC_SET_ONCYCLE', 2, 'next'),
    0x828249: ('PROC_JUMP', 2, 'jump'),
    0x82824E: ('PROC_SET_LOOP_COUNTER', 2, 'next'),
    0x828257: ('PROC_JUMP_WHILE_LOOP_COUNTER', 2, 'branch'),
    0x82825F: ('PROC_JUMP_IF_BITS_UNSET', 4, 'branch'),
    0x82826C: ('PROC_JUMP_IF_BITS_SET', 4, 'branch'),
    0x828279: ('PROC_CREATE_ACTIVE_SPRITE', 7, 'next'),
}


def word(rom, a):
    o = a & 0x3FFFFF
    return rom[o] | rom[o + 1] << 8


def long(rom, a):
    o = a & 0x3FFFFF
    return rom[o] | rom[o + 1] << 8 | rom[o + 2] << 16


def header(rom, definition):
    """(init, on-cycle, script) as full addresses, or None for a pointer below $8000."""
    bank = definition & 0xFF0000
    out = []
    for field in (2, 4, 6):
        w = word(rom, definition + field)
        out.append(bank | w if w >= 0x8000 else None)
    return tuple(out)


def walk(rom, script):
    """Decode the script at script, following its jumps.

    Returns (commands, refs, problems):
      commands  {address: (name, argument bytes as bytes, size in bytes)} for every
                command reached, including sleeps (name 'PROC_YIELD')
      refs      [(kind, address, at)]: 'routine' for routines it calls or sets as
                its on-cycle routine, 'sprite' for active sprite definitions
      problems  [(address, word)] for words that are not a known command
    """
    bank = script & 0xFF0000
    commands, refs, problems = {}, [], []
    todo = [script]
    while todo:
        pc = todo.pop()
        while pc not in commands:
            w = word(rom, pc)
            if w < 0x8000:
                commands[pc] = ('PROC_YIELD', w.to_bytes(2, 'little'), 2)
                pc += 2
                continue
            cmd = COMMANDS.get(0x820000 | w)
            if cmd is None:
                problems.append((pc, w))
                break
            name, n, flow = cmd
            if n is None:
                n = 4 + rom[(pc + 5) & 0x3FFFFF]
            args = bytes(rom[(pc + 2 + i) & 0x3FFFFF] for i in range(n))
            commands[pc] = (name, args, 2 + n)
            if name in ('PROC_CALL', 'PROC_CALL_ARGS'):
                refs.append(('routine', int.from_bytes(args[:3], 'little'), pc))
            elif name == 'PROC_SET_ONCYCLE':
                refs.append(('routine', bank | int.from_bytes(args[:2], 'little'), pc))
            elif name == 'PROC_CREATE_ACTIVE_SPRITE':
                refs.append(('sprite', int.from_bytes(args[:3], 'little'), pc))
            if flow in ('jump', 'branch'):
                todo.append(bank | int.from_bytes(args[:2], 'little'))
            if flow in ('stop', 'jump'):
                break
            pc += 2 + n
    return commands, refs, problems


def runs(commands):
    """Split decoded commands into contiguous runs: [(start, end, [addresses])]."""
    out = []
    for a in sorted(commands):
        size = commands[a][2]
        if out and out[-1][1] == a:
            out[-1][1] = a + size
            out[-1][2].append(a)
        else:
            out.append([a, a + size, [a]])
    return [tuple(r) for r in out]


def render(rom, commands, start, end, label, run_labels, name_of):
    """Source for the commands in [start, end) as a routines-file entry.

    run_labels maps the start of each run of this script to its label, so that jumps
    into another run can use it; name_of(address) gives a label or None."""
    bank = start & 0xFF0000
    inside = [a for a in sorted(commands) if start <= a < end]
    targets = set()
    for a in inside:
        name, args, _ = commands[a]
        flow = next(c[2] for c in COMMANDS.values() if c[0] == name) if name != 'PROC_YIELD' else 'next'
        if flow in ('jump', 'branch'):
            targets.add(bank | int.from_bytes(args[:2], 'little'))

    def position(t):
        if start <= t < end and t != start:
            return f'_{t & 0xFFFF:04X}'
        if t in run_labels:
            return run_labels[t]
        return name_of(t) or f'${t:06X}'

    def routine(t):
        return name_of(t) or f'${t:06X}'

    out = [f'      {label} ; {start >> 16:02X}/{start & 0xFFFF:04X}', '']
    for a in inside:
        name, args, size = commands[a]
        if a in targets and a != start:
            out.append(f'        _{a & 0xFFFF:04X}')
        if name == 'PROC_YIELD':
            line = f'PROC_YIELD {int.from_bytes(args, "little")}'
        elif name in ('PROC_CALL',):
            line = f'PROC_CALL {routine(int.from_bytes(args[:3], "little"))}'
        elif name == 'PROC_CALL_ARGS':
            n = args[3]
            line = f'PROC_CALL_ARGS {routine(int.from_bytes(args[:3], "little"))}, {n}'
            if n:
                line += '\n          .byte ' + ', '.join(f'${b:02X}' for b in args[4:])
        elif name == 'PROC_SET_ONCYCLE':
            line = f'PROC_SET_ONCYCLE {routine(bank | int.from_bytes(args, "little"))}'
        elif name in ('PROC_JUMP', 'PROC_JUMP_WHILE_LOOP_COUNTER'):
            line = f'{name} {position(bank | int.from_bytes(args[:2], "little"))}'
        elif name in ('PROC_JUMP_IF_BITS_UNSET', 'PROC_JUMP_IF_BITS_SET'):
            bits = int.from_bytes(args[2:4], 'little')
            line = f'{name} {position(bank | int.from_bytes(args[:2], "little"))}, ${bits:04X}'
        elif name == 'PROC_SET_LOOP_COUNTER':
            line = f'PROC_SET_LOOP_COUNTER {int.from_bytes(args, "little")}'
        elif name == 'PROC_CREATE_ACTIVE_SPRITE':
            sprite = int.from_bytes(args[:3], 'little')
            xv, yv = int.from_bytes(args[3:5], 'little'), int.from_bytes(args[5:7], 'little')
            line = f'PROC_CREATE_ACTIVE_SPRITE {routine(sprite)}, ${xv:04X}, ${yv:04X}'
        else:
            line = name
        out.append('        ' + line)
        if name in ('PROC_END', 'PROC_HALT', 'PROC_HALT_SLEEP', 'PROC_JUMP'):
            out.append('')
    out += ['', f'        ; {end >> 16:02X}/{end & 0xFFFF:04X}', '']
    return '\n'.join(out)
