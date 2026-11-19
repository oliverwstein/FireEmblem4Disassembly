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
    0x82824E: ('PROC_SET_UNK_TIMER', 2, 'next'),
    0x828257: ('PROC_JUMP_WHILE_UNK_TIMER', 2, 'branch'),
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
