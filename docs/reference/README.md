# The reference set

Documentation of every part of the engine, at every level, so that any piece can be understood by reading instead of investigating. It is not meant to be read front to back; the [guide](../guide/) is.

## What is here

| Level | Where | Written by |
|---|---|---|
| System | `docs/reference/<system>.md`: one page per system, its files, data, entry points, how control flows through it and what it depends on | hand |
| File | the comment at the top of each source file: what it is responsible for | hand |
| Routine | the comment under each routine's label: what it does, its inputs and outputs, side effects | hand |
| Data | the comments in `include/` (structs, `WRAM.h`, constants) | hand |
| Index | [routines/](routines/), [ram.md](ram.md), [INDEX.md](INDEX.md): every named routine and table with its comment, callers and callees; every RAM name | `tools/reference.py` |

The generated pages are rebuilt from the source by `python3 tools/reference.py`, so they never go stale: run it after renaming or commenting, and commit the result. `--check` reports whether they are out of date. A page under `routines/` covers one folder of `engine/`; `Unknown` routines are counted there but not listed.

## Systems written so far

- [core.md](core.md): the frame, boot, game states, the engines that run every frame, procs.
- [ai.md](ai.md): the enemy (and allied) AI.

The other systems get their page as Phase 3 names and sorts them (see [PLAN.md](../../PLAN.md)).
