# Engine guide: style guide

> Temporary working document for authoring chapters in `docs/guide/`. Delete this file once the guide is complete.

## Voice and perspective

- **Third person throughout.** Refer to *the game*, *the engine*, *the player*, *the reader*, and *the developers*. Avoid first and second person (*we*, *I*, *you*).
- **American English.** Use American spelling (`behavior`, `color`, `flavored`, `initialized`, `neighbor`, `serializing`) and serial commas (`units, items, and events`).
- **Timeless prose.** Describe the codebase as it stands. Leave out disassembly-project history (*"formerly unsorted"*, *"built earlier in the project"*) and unresolved WIP hedges.

## Prose craft

- **Omit needless words.** Prefer active verbs and concrete nouns over filler or throat-clearing.
- **Put statements in positive form.** Say what a routine does rather than what it avoids.
- **Lead with the concrete.** Introduce a mechanism through a visible game moment or data structure before generalizing.
- **Vary the cadence.** Keep paragraphs short and focused, and avoid ending every section with a neat two-beat aphorism. Let some sections end on an example or a concrete limit.

## Chapter structure

- **Problem → solution → trade-offs → source.** Open every chapter with the hardware or design constraint the developers faced, explain the data and control flow that solve it, note the costs and hard limits, and point to where the pieces live.
- **Name patterns directly.** Use standard vocabulary (*Game Loop*, *State*, *Update Method*, *Bytecode*, *Flyweight*, *Structure of Arrays*) as plain technical terms. Do not cite *Game Programming Patterns* or Robert Nystrom inline.
- **Ground plumbing in gameplay.** Even hardware-level chapters should anchor their examples in real FE4 moments (a screen fade, a castle banner, a dialogue box unfolding).
- **Rust-flavored pseudocode.** Translate assembly logic into short, readable pseudocode annotated with the real routine and variable names (`// rlMapStep`). Readers should never need to read 65816 assembly to follow the explanation.
- **Use diagrams where layout matters.** Include compact ASCII diagrams for frame timelines, memory pools, pointer relationships, and state transitions.

## Conventions and accuracy

- **Formatting:** Use backticks for symbol names, constants, and paths; use `$12` and `$80/9B01` for hex values and 24-bit ROM addresses; use relative markdown links to source files and `docs/reference/` pages.
- **Verify against the source.** Check every routine name, struct field, pool size, and gameplay rule against the disassembly or `docs/reference/`. Never assume behavior from later Fire Emblem games.
