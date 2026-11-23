# ROM bytes not built from source

Made by `tools/gaps.py`; do not edit. Every run of bytes the build still copies from
`fe4.sfc`, with the evidence of what it is. Classes, strongest evidence first:
`code` (a call or jump in the source targets it), `table` (built code reads it at its
first byte), `inside` (built code points into it, not at its start), `log` (read in
`fe4.cdl` only), `none` (no evidence). Addresses are given where the game reads them:
upper halves in banks `$80`-`$BF`, lower halves in `$C0`-`$FF`.

82,362 bytes in 131 runs: 58 runs of padding (42,204 bytes) and 73 pieces (40,158 bytes).

| Class | Pieces | Bytes | Read in the log |
|---|---|---|---|
| `code` | 3 | 118 | 0 |
| `table` | 2 | 73 | 0 |
| `inside` | 0 | 0 | 0 |
| `log` | 0 | 0 | 0 |
| `none` | 68 | 39,967 | 0 |

## `code` (3)

| Piece | Bytes | Log reads | Between | Evidence |
|---|---|---|---|---|
| $80/9C77-$80/9C79 | 3 | 0 | `rlUnknown809C3E` / `rlRunVBlankHooks` | **at start** number `engine/core/game_states.asm:324`: `jsl $809C77` |
| $82/E048-$82/E072 | 43 | 0 | `rsUnknown82E030` / `rlResetIRQEngine` | **at start** number `engine/core/interrupts.asm:459`: `jsl $82E048` |
| $96/9995-$96/99DC | 72 | 0 | `rlUnknown969964` / `rlUnknown9699DD` | **at start** number `engine/battle_scene/hud.asm:3215`: `jsr ($969995,x)` |

## `table` (2)

| Piece | Bytes | Log reads | Between | Evidence |
|---|---|---|---|---|
| $91/BD51-$91/BD93 | 67 | 0 | `rlUnknown91BD42` / `rlASMCStatUpDisplay` | **at start** halves `engine/epilogue/dialogue.asm:674`: `long pointer in lR44` |
| $9E/D074-$9E/D079 | 6 | 0 | `rlUnknown9ED00F` / `rlStartReturnHomeAnimation` | **at start** number `engine/battle/map_battle_hud.asm:3846`: `adc $9ED074`; +2 number `engine/battle/map_battle_hud.asm:3861`: `sbc $9ED076`; +4 number `engine/battle/map_battle_hud.asm:3874`: `adc $9ED078` |

## `inside` (0)

| Piece | Bytes | Log reads | Between | Evidence |
|---|---|---|---|---|

## `log` (0)

| Piece | Bytes | Log reads | Between | Evidence |
|---|---|---|---|---|

## `none` (68)

| Piece | Bytes | Log reads | Between | Evidence |
|---|---|---|---|---|
| $C0/3C05-$80/8001 | 17,405 | 0 | `gcUnknownC0365A` / `rlGetJoypadInput` | 99% $00/$FF |
| $80/9727-$80/9728 | 2 | 0 | `aSoundScriptCommands` / `rsSoundScriptPlaySoundEffect` |  |
| $80/ADFF-$80/AE24 | 38 | 0 | `rsSetupOpeningLogoScreen` / `rsOpeningLogoVBlank` |  |
| $80/B63E-$80/B63E | 1 | 0 | `aDecompressionDMAEntry80B636` / `rlUnknown80B63F` |  |
| $80/B640-$80/B640 | 1 | 0 | `rlUnknown80B63F` / `rsRunCastleScreenVBlank` |  |
| $80/B77D-$80/B77E | 2 | 0 | `rlReturnToCastleFromArena` / `rlDispatchCastleState` |  |
| $80/F337-$80/F33F | 9 | 0 | `rsOpenChapterIntroScreen` / `rsCreateChapterIntroHDMA` |  |
| $81/EBBC-$81/FFFF | 5,188 | 0 | `aUNITGroupDataChapterFinalUnused` / `` | 92% $00/$FF |
| $82/83B5-$82/83E2 | 46 | 0 | `aProcMainLoopChangeFadeByTimerCode` / `procFadeOutAndChangeSong` |  |
| $82/8816-$82/8864 | 79 | 0 | `aProcCastleNamePopUpCode` / `procDemoSkipFadeOut` |  |
| $82/8D21-$82/8D51 | 49 | 0 | `aProcUnknown828CA3Code` / `procUnknown828D52` |  |
| $82/90B0-$82/921D | 366 | 0 | `aProcEventFadeOutByTimerCode` / `procEventPause` |  |
| $82/9285-$82/92A8 | 36 | 0 | `aProcUnknown82925ECode` / `procUnknown8292A9` |  |
| $82/E41A-$82/E41A | 1 | 0 | `rlResetRAMStructAndAreaVariables` / `rlBuildRAMStructHeader` |  |
| $82/EB77-$82/EC6F | 249 | 0 | `rlUnknown82EB4C` / `rlUnknown82EC70` |  |
| $82/EC81-$82/ECB8 | 56 | 0 | `rlUnknown82EC70` / `rlBuildRAMAreaHeaderAndGuidingEntry` |  |
| $88/9AC4-$88/9AE1 | 30 | 0 | `rlMinimapAnimateViewColors` / `aMinimapViewColorCycle` |  |
| $88/9C38-$88/9C51 | 26 | 0 | `rlDrawMinimapUnits` / `procMinimapClose` |  |
| $88/A505-$88/A550 | 76 | 0 | `rlLoadMapWindowPalettes` / `rsGetMapCursorMove` |  |
| $88/A6CA-$88/A703 | 58 | 0 | `rsSetCursorScrollSpeedUnused` / `rlDrawHandCursor` |  |
| $88/ACBB-$88/ACF0 | 54 | 0 | `rsGetTargetAtSearchIndexUnused` / `aNearTargetOffsets` | 64% $00/$FF |
| $88/E2D6-$88/E2DB | 6 | 0 | `rlProcFirstGenerationEndingPortraitFadeOutCycle` / `aProcFirstGenerationEndingPortraitFadeOutCode` | 66% $00/$FF |
| $88/E33B-$88/E33C | 2 | 0 | `rlFirstGenerationEndingHDMA` / `rlLoadFirstGenerationEndingPortrait` |  |
| $8A/8682-$8A/8699 | 24 | 0 | `rsCastleGridMoveToTarget` / `rsCastleGridFindPreviousTarget` | 54% $00/$FF |
| $8A/B10A-$8A/B110 | 7 | 0 | `rlPushStockListScrollArrows` / `rlDrawCastleNumber` |  |
| $8A/BAC9-$8A/BACE | 6 | 0 | `PortraitPaletteGhostDeirdrePortraitPalettePointersEntry` / `aDialogueBackgroundPointers` |  |
| $8A/CE4F-$8A/CE4F | 1 | 0 | `rsShopLeaveToCourtyard` / `rlSetupKeeperDialogueBox` |  |
| $8A/DD98-$8A/E05D | 710 | 0 | `rsConversationSetupSlots` / `rsAnimateConversationBackground` | 73% $00/$FF |
| $8A/F045-$8A/F047 | 3 | 0 | `rsClassChangeCheck` / `rsClassChangeConfirm` |  |
| $8A/F259-$8A/F262 | 10 | 0 | `rlDepotScreenSetup` / `aDecompressionDMAEntry8AF263` | 60% $00/$FF |
| $8B/8A58-$8B/8A83 | 44 | 0 | `WMH_UnifiedThraciaPointer` / `rlClearHighlightWorldMapPart` | 56% $00/$FF |
| $8B/A7CE-$8B/A7F1 | 36 | 0 | `rlUnusedGameState15` / `rlUnitWindowShow` |  |
| $8B/B882-$8B/B8B5 | 52 | 0 | `rsUnitWindowRenderWeaponRankIcons` / `rsUnitWindowCopyLineHighlightColors` |  |
| $8D/A612-$8D/A623 | 18 | 0 | `rlEpilogueCreditsWaveHDMACycle` / `rsDrawEpilogueCreditsSprite` |  |
| $8D/AEC0-$8D/AEC1 | 2 | 0 | `rlEpilogueRecordLayerHDMACycle` / `rlSetUpEpilogueRecordTextWindow` |  |
| $8D/B539-$8D/B539 | 1 | 0 | `rlShowNextEpilogueCharacterEnding` / `rsStartEpilogueCharacterScene` |  |
| $D0/5639-$D0/5672 | 58 | 0 | `PortraitDataClassCardGreatBallistaPointer` / `gcUnknownD05673` |  |
| $91/A8E4-$91/A927 | 68 | 0 | `rsDialogueEventCommand07` / `rlSetupConversationDialogueBoxes` |  |
| $91/A9F2-$91/AA14 | 35 | 0 | `aUnknown91A9E4` / `rsSplitNumberIntoFiveDigits` |  |
| $91/B1FB-$91/B1FB | 1 | 0 | `aJugdralHistoryLineSteps` / `rsJugdralHistoryDrawEntry` |  |
| $91/E006-$91/E079 | 116 | 0 | `rsSetSaveMenuScreenRegisters` / `rlCreateSaveMenuHDMA` |  |
| $91/E4A3-$91/E4B2 | 16 | 0 | `rlDrawSaveMenuHand` / `aSaveMenuHandFrames` | 87% $00/$FF |
| $91/E913-$91/E914 | 2 | 0 | `rlFadeInAndHang` / `rsClearRAMAndResetHardware` |  |
| $95/A166-$95/A166 | 1 | 0 | `rlUnknown95A165` / `rlUnknown95A167` |  |
| $96/8DBB-$96/8DBC | 2 | 0 | `rlUnknown968DAA` / `rlUnknown968DBD` |  |
| $96/AD05-$96/AD06 | 2 | 0 | `rsUnknown96ACE5` / `rsUnknown96AD07` |  |
| $96/AD37-$96/AD38 | 2 | 0 | `rsUnknown96AD07` / `rlUnknown96AD39` |  |
| $96/BE68-$96/BFE4 | 381 | 0 | `rlUnknown96BE53` / `rlUnknown96BFE5` |  |
| $96/D254-$96/D255 | 2 | 0 | `rlUnknown96D1EC` / `rlUnknown96D256` |  |
| $96/D2D5-$96/D2D6 | 2 | 0 | `rlUnknown96D256` / `rlUnknown96D2D7` |  |
| $96/D3EB-$96/D3EC | 2 | 0 | `rlUnknown96D2D7` / `rsUnknown96D3ED` |  |
| $96/D400-$96/D401 | 2 | 0 | `rsUnknown96D3ED` / `rsUnknown96D402` |  |
| $96/D415-$96/D416 | 2 | 0 | `rsUnknown96D402` / `rsUnknown96D417` |  |
| $96/D42A-$96/D42B | 2 | 0 | `rsUnknown96D417` / `rsUnknown96D42C` |  |
| $96/F28B-$96/F28C | 2 | 0 | `rlUnknown96F275` / `rlUnknown96F28D` |  |
| $96/F50D-$96/F557 | 75 | 0 | `rlUnknown96F4BA` / `rlBattleSceneEndStepType2Script` |  |
| $D9/6800-$D9/6BFF | 1,024 | 0 | `aUnknownD95000` / `gUnknownD96C00` |  |
| $D9/7400-$D9/793F | 1,344 | 0 | `gUnknownD96C00` / `gUnknownD97940` |  |
| $D9/7B00-$D9/7BFF | 256 | 0 | `gUnknownD97940` / `aUnknownD97C00` |  |
| $DA/45C0-$DA/64FF | 8,000 | 0 | `g4bppStandingMapSprites2` / `aUnknownDA6500` | 92% $00/$FF |
| $DA/6700-$DA/67FF | 256 | 0 | `aUnknownDA65B2` / `gUnknownDA6800` |  |
| $DA/6C80-$DA/6CFF | 128 | 0 | `gUnknownDA6A40` / `gUnknownDA6D00` |  |
| $DA/6F40-$DA/6FFF | 192 | 0 | `gUnknownDA6D00` / `aUnknownDA7000` |  |
| $DA/7800-$DA/79FF | 512 | 0 | `aUnknownDA7000` / `g4bppUnknownDA7A00` |  |
| $9E/B433-$9E/B490 | 94 | 0 | `rlMapBattleRestoreMusic` / `rlPlayGoldObtainedJingle` |  |
| $9E/CEB9-$9E/CEDC | 36 | 0 | `rlUnknown9ECEA0` / `procMapExperienceWindowEffect` |  |
| $9E/E177-$9E/E227 | 177 | 0 | `rlUnknown9EE156` / `rlUnknown9EE228` |  |
| $9E/E2E4-$9E/EC94 | 2,481 | 0 | `rlUnknown9EE2D1` / `rlUnknown9EEC95` |  |
