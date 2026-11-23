# ROM bytes not built from source

Made by `tools/gaps.py`; do not edit. Every run of bytes the build still copies from
`fe4.sfc`, with the evidence of what it is. Classes, strongest evidence first:
`code` (a call or jump in the source targets it), `table` (built code reads it at its
first byte), `inside` (built code points into it, not at its start), `log` (read in
`fe4.cdl` only), `none` (no evidence). Addresses are given where the game reads them:
upper halves in banks `$80`-`$BF`, lower halves in `$C0`-`$FF`.

94,283 bytes in 196 runs: 57 runs of padding (42,147 bytes) and 139 pieces (52,136 bytes).

| Class | Pieces | Bytes | Read in the log |
|---|---|---|---|
| `code` | 0 | 0 | 0 |
| `table` | 0 | 0 | 0 |
| `inside` | 0 | 0 | 0 |
| `log` | 0 | 0 | 0 |
| `none` | 139 | 52,136 | 0 |

## `code` (0)

| Piece | Bytes | Log reads | Between | Evidence |
|---|---|---|---|---|

## `table` (0)

| Piece | Bytes | Log reads | Between | Evidence |
|---|---|---|---|---|

## `inside` (0)

| Piece | Bytes | Log reads | Between | Evidence |
|---|---|---|---|---|

## `log` (0)

| Piece | Bytes | Log reads | Between | Evidence |
|---|---|---|---|---|

## `none` (139)

| Piece | Bytes | Log reads | Between | Evidence |
|---|---|---|---|---|
| $C0/3C05-$80/8001 | 17,405 | 0 | `gcUnknownC0365A` / `rlGetJoypadInput` | 99% $00/$FF |
| $80/8372-$80/83C6 | 85 | 0 | `rlClearSpriteExtBuffer` / `aOAMUpperXBitTable` |  |
| $80/9727-$80/9728 | 2 | 0 | `aSoundScriptCommands` / `rsSoundScriptPlaySoundEffect` |  |
| $80/9C3E-$80/9C79 | 60 | 0 | `rlRunVBlankHookInit` / `rlRunVBlankHooks` |  |
| $80/9FB2-$80/A095 | 228 | 0 | `rlSetLayerPositionsAndSizes` / `rlUnsignedMultiply16By16High` |  |
| $80/ADFF-$80/AE24 | 38 | 0 | `rsSetupOpeningLogoScreen` / `rsOpeningLogoVBlank` |  |
| $80/B316-$80/B346 | 49 | 0 | `rsMapMainLoop` / `rsWorldMapVBlank` |  |
| $80/B63E-$80/B63E | 1 | 0 | `aDecompressionDMAEntry80B636` / `rlUnknown80B63F` |  |
| $80/B640-$80/B640 | 1 | 0 | `rlUnknown80B63F` / `rsRunCastleScreenVBlank` |  |
| $80/B77D-$80/B77E | 2 | 0 | `rlReturnToCastleFromArena` / `rlDispatchCastleState` |  |
| $80/C1BA-$80/C1C9 | 16 | 0 | `rlUnusedScreenSetup` / `rlUnusedScreenStep` |  |
| $80/F337-$80/F33F | 9 | 0 | `rsOpenChapterIntroScreen` / `rsCreateChapterIntroHDMA` |  |
| $81/9062-$81/9091 | 48 | 0 | `rsCapSpawnDestinationCoordinates100` / `rsFillMovingMapSpriteData` |  |
| $81/90CC-$81/9165 | 154 | 0 | `rsFillMovingMapSpriteDataPathScriptPointer` / `rlUnknown819166` |  |
| $81/EBBC-$81/FFFF | 5,188 | 0 | `aUNITGroupDataChapterFinalUnused` / `` | 92% $00/$FF |
| $82/83B5-$82/83E2 | 46 | 0 | `aProcMainLoopChangeFadeByTimerCode` / `procFadeOutAndChangeSong` |  |
| $82/8816-$82/8864 | 79 | 0 | `aProcCastleNamePopUpCode` / `procDemoSkipFadeOut` |  |
| $82/8D21-$82/8D51 | 49 | 0 | `aProcUnknown828CA3Code` / `procUnknown828D52` |  |
| $82/90B0-$82/921D | 366 | 0 | `aProcEventFadeOutByTimerCode` / `procEventPause` |  |
| $82/9285-$82/92A8 | 36 | 0 | `aProcUnknown82925ECode` / `procUnknown8292A9` |  |
| $82/9469-$82/9477 | 15 | 0 | `aProcUnknown8293AECode` / `rlCreateProcHaltEvent` |  |
| $82/94B1-$82/94BF | 15 | 0 | `rlFreeMapBattleProcAndClearSprites` / `rlCreateProcEventWaitBattleSceneEnd` |  |
| $82/E030-$82/E072 | 67 | 0 | `rsIRQCodeHalt` / `rlResetIRQEngine` |  |
| $82/E120-$82/E132 | 19 | 0 | `rlUnknown82E0C6` / `rlIRQEngineStub` |  |
| $82/E41A-$82/E41A | 1 | 0 | `rlResetRAMStructAndAreaVariables` / `rlBuildRAMStructHeader` |  |
| $82/EB4C-$82/ECB8 | 365 | 0 | `rsSaveRAMStructEntryFromScratch` / `rlBuildRAMAreaHeaderAndGuidingEntry` |  |
| $82/EDBB-$82/EDE6 | 44 | 0 | `rlAllocateRAMAreaWithHandle` / `rlAllocateRAMArea` |  |
| $82/F207-$82/F210 | 10 | 0 | `rsUpdateRAMAreaHandle` / `rlResetMenuOptionStack` |  |
| $82/F4BF-$82/F4DD | 31 | 0 | `rlGetSelectedMenuOptionCoordinates` / `rlGetUNITGroupPointer` |  |
| $82/F4F9-$82/F516 | 30 | 0 | `rlGetUNITGroupPointer` / `rlCopyOffsetTableEntry` |  |
| $82/F54F-$82/F566 | 24 | 0 | `rlCopyOffsetTableEntry` / `rlAddOffsetTableEntry` |  |
| $82/F7A2-$82/F865 | 196 | 0 | `rlUpdateOffsetTable` / `rlSetParentsPermanentFlags` |  |
| $88/857E-$88/85D2 | 85 | 0 | `rlContinueMapScroll` / `rlStartMapScrollUp` |  |
| $88/9AC4-$88/9AE1 | 30 | 0 | `rlMinimapAnimateViewColors` / `aMinimapViewColorCycle` |  |
| $88/9C38-$88/9C51 | 26 | 0 | `rlDrawMinimapUnits` / `procMinimapClose` |  |
| $88/9E6E-$88/9FC2 | 341 | 0 | `aProcMinimapCloseCode` / `aChapterMapPointers` |  |
| $88/A383-$88/A38B | 9 | 0 | `rsUpdateMapSystemFlags` / `rlCheckMapCursorResting` |  |
| $88/A505-$88/A550 | 76 | 0 | `rlLoadMapWindowPalettes` / `rsGetMapCursorMove` |  |
| $88/A6CA-$88/A703 | 58 | 0 | `rsSetCursorScrollSpeedUnused` / `rlDrawHandCursor` |  |
| $88/A816-$88/A81C | 7 | 0 | `rsSetUnitWalkSpeed` / `rlMapChooseTargetStep` |  |
| $88/ACBB-$88/ACF0 | 54 | 0 | `rsGetTargetAtSearchIndexUnused` / `aNearTargetOffsets` | 64% $00/$FF |
| $88/AD09-$88/AD45 | 61 | 0 | `aNearTargetOffsets` / `rlStartChoosingTarget` |  |
| $88/B3C2-$88/B3DE | 29 | 0 | `rlSaveMapCameraAndLockCursor` / `rlGetTileEntriesAtCursor` |  |
| $88/BEFF-$88/BF36 | 56 | 0 | `rsPlayMapCursorMoveSound` / `rlGetMapDataIndex` |  |
| $88/E00E-$88/E02A | 29 | 0 | `rsAnimateUnitWindowTallSprite` / `procFirstGenerationEnding` |  |
| $88/E2D6-$88/E2DB | 6 | 0 | `rlProcFirstGenerationEndingPortraitFadeOutCycle` / `aProcFirstGenerationEndingPortraitFadeOutCode` | 66% $00/$FF |
| $88/E33B-$88/E33C | 2 | 0 | `rlFirstGenerationEndingHDMA` / `rlLoadFirstGenerationEndingPortrait` |  |
| $8A/8682-$8A/8699 | 24 | 0 | `rsCastleGridMoveToTarget` / `rsCastleGridFindPreviousTarget` | 54% $00/$FF |
| $8A/B10A-$8A/B110 | 7 | 0 | `rlPushStockListScrollArrows` / `rlDrawCastleNumber` |  |
| $8A/BAC9-$8A/BACE | 6 | 0 | `PortraitPaletteGhostDeirdrePortraitPalettePointersEntry` / `aDialogueBackgroundPointers` |  |
| $8A/CE4F-$8A/CE4F | 1 | 0 | `rsShopLeaveToCourtyard` / `rlSetupKeeperDialogueBox` |  |
| $8A/DD98-$8A/E05D | 710 | 0 | `rsConversationSetupSlots` / `rsAnimateConversationBackground` | 73% $00/$FF |
| $8A/F045-$8A/F047 | 3 | 0 | `rsClassChangeCheck` / `rsClassChangeConfirm` |  |
| $8A/F259-$8A/F262 | 10 | 0 | `rlDepotScreenSetup` / `aDecompressionDMAEntry8AF263` | 60% $00/$FF |
| $8B/812A-$8B/818C | 99 | 0 | `rsCycleWorldMapSpriteColors` / `rsUnusedWorldMapTestShowPortraits` |  |
| $8B/81EC-$8B/821E | 51 | 0 | `rsUnusedWorldMapTestShowPortraits` / `rlFadeInWorldMapPortraitSlot` |  |
| $8B/83A7-$8B/84E4 | 318 | 0 | `aPortraitSlotVRAMOffsets` / `rlLoadWorldMapMarkerData` |  |
| $8B/8A58-$8B/8A83 | 44 | 0 | `WMH_UnifiedThraciaPointer` / `rlClearHighlightWorldMapPart` | 56% $00/$FF |
| $8B/A7CE-$8B/A7F1 | 36 | 0 | `rlUnusedGameState15` / `rlUnitWindowShow` |  |
| $8B/B882-$8B/B8B5 | 52 | 0 | `rsUnitWindowRenderWeaponRankIcons` / `rsUnitWindowCopyLineHighlightColors` |  |
| $8C/F09B-$8C/FFFF | 3,941 | 0 | `rlUnknown8CF07F` / `` |  |
| $8D/A612-$8D/A623 | 18 | 0 | `rlEpilogueCreditsWaveHDMACycle` / `rsDrawEpilogueCreditsSprite` |  |
| $8D/AEC0-$8D/AEC1 | 2 | 0 | `rlEpilogueRecordLayerHDMACycle` / `rlSetUpEpilogueRecordTextWindow` |  |
| $8D/B539-$8D/B539 | 1 | 0 | `rlShowNextEpilogueCharacterEnding` / `rsStartEpilogueCharacterScene` |  |
| $D0/5639-$D0/5672 | 58 | 0 | `PortraitDataClassCardGreatBallistaPointer` / `gcUnknownD05673` |  |
| $91/A7EA-$91/A80C | 35 | 0 | `rlUnknown91A7DF` / `rlPlanQueuedMapSpriteMovement` |  |
| $91/A8E4-$91/A927 | 68 | 0 | `rsDialogueEventCommand07` / `rlSetupConversationDialogueBoxes` |  |
| $91/A9F2-$91/AA14 | 35 | 0 | `aUnknown91A9E4` / `rsSplitNumberIntoFiveDigits` |  |
| $91/B1FB-$91/B1FB | 1 | 0 | `aJugdralHistoryLineSteps` / `rsJugdralHistoryDrawEntry` |  |
| $91/BD42-$91/BD93 | 82 | 0 | `aEpilogueLoverPartners` / `rlASMCStatUpDisplay` |  |
| $91/DF08-$91/DF31 | 42 | 0 | `rsSaveMenuClearSlotTextTiles` / `rlStartTextToTiles` |  |
| $91/E006-$91/E079 | 116 | 0 | `rsSetSaveMenuScreenRegisters` / `rlCreateSaveMenuHDMA` |  |
| $91/E4A3-$91/E4B2 | 16 | 0 | `rlDrawSaveMenuHand` / `aSaveMenuHandFrames` | 87% $00/$FF |
| $91/E913-$91/E914 | 2 | 0 | `rlFadeInAndHang` / `rsClearRAMAndResetHardware` |  |
| $95/9650-$95/968D | 62 | 0 | `rlUnknown9595CA` / `rlUnknown95968E` |  |
| $95/9BFE-$95/9C13 | 22 | 0 | `rsUnknown959BC1` / `rsUnknown959C14` |  |
| $95/9E71-$95/9F42 | 210 | 0 | `rlUnknown959E22` / `rlUnknown959F43` |  |
| $95/9FEA-$95/A085 | 156 | 0 | `rlUnknown959F43` / `rlBattleSceneRunQueuedCopies` |  |
| $95/A166-$95/A166 | 1 | 0 | `rlUnknown95A165` / `rlUnknown95A167` |  |
| $95/AA8D-$95/AAFE | 114 | 0 | `rsBattleSceneStartNextRound` / `rlUnknown95AAFF` |  |
| $95/B114-$95/B183 | 112 | 0 | `rlUnknown95B0D7` / `rlBattleAnimationCompareCombatantX` |  |
| $95/B6A7-$95/B6CF | 41 | 0 | `rsBattleAnimationGetSpeedB` / `rlUnknown95B6D0` |  |
| $95/B7CF-$95/B7F7 | 41 | 0 | `rlUnknown95B7AE` / `rlUnknown95B7F8` |  |
| $95/C306-$95/C367 | 98 | 0 | `rsUnknown95C2C0` / `rlUnknown95C368` |  |
| $95/D200-$95/D23B | 60 | 0 | `rlBattleAnimationGetPathMeasures` / `rsBattleAnimationSetYPathToOpponent` |  |
| $95/D280-$95/D2A3 | 36 | 0 | `rsBattleAnimationSetYPathToOpponent` / `rsUnknown95D2A4` |  |
| $95/E08C-$95/E0C4 | 57 | 0 | `rsUnknown95DF76` / `rsUnknown95E0C5` |  |
| $95/E80D-$95/E833 | 39 | 0 | `rlUnknown95E7EC` / `rsUnknown95E834` |  |
| $95/E877-$95/E887 | 17 | 0 | `rsUnknown95E834` / `rlUnknown95E888` |  |
| $96/87B3-$96/881E | 108 | 0 | `rlUnknown96878D` / `rlUnknown96881F` |  |
| $96/8DBB-$96/8DBC | 2 | 0 | `rlUnknown968DAA` / `rlUnknown968DBD` |  |
| $96/8DE1-$96/8E4B | 107 | 0 | `rlUnknown968DC8` / `rlUnknown968E4C` |  |
| $96/8E8F-$96/8F4F | 193 | 0 | `rlUnknown968E7E` / `rlUnknown968F50` |  |
| $96/92F8-$96/9397 | 160 | 0 | `rlUnknown9691C8` / `rlUnknown969398` |  |
| $96/9766-$96/97F9 | 148 | 0 | `rsUnknown969765` / `rlUnknown9697FA` |  |
| $96/9964-$96/99DC | 121 | 0 | `rlUnknown96994B` / `rlUnknown9699DD` |  |
| $96/A0EB-$96/A20D | 291 | 0 | `rlUnknown96A0E2` / `rlBattleSceneEndStepJulius` |  |
| $96/ACC5-$96/AD06 | 66 | 0 | `rsUnknown96ACAB` / `rsUnknown96AD07` |  |
| $96/AD37-$96/AD38 | 2 | 0 | `rsUnknown96AD07` / `rlUnknown96AD39` |  |
| $96/B08D-$96/B0E0 | 84 | 0 | `rlUnknown96AFCF` / `rsUnknown96B0E1` |  |
| $96/B7E2-$96/B851 | 112 | 0 | `rsUnknown96B794` / `rsUnknown96B852` |  |
| $96/BE68-$96/BFE4 | 381 | 0 | `rlUnknown96BE53` / `rlUnknown96BFE5` |  |
| $96/C07F-$96/C7DA | 1,884 | 0 | `rlUnknown96C008` / `rlUnknown96C7DB` |  |
| $96/CD0E-$96/CD22 | 21 | 0 | `rsUnknown96CCAF` / `rsUnknown96CD23` |  |
| $96/D254-$96/D255 | 2 | 0 | `rlUnknown96D1EC` / `rlUnknown96D256` |  |
| $96/D2D5-$96/D2D6 | 2 | 0 | `rlUnknown96D256` / `rlUnknown96D2D7` |  |
| $96/D3EB-$96/D3EC | 2 | 0 | `rlUnknown96D2D7` / `rsUnknown96D3ED` |  |
| $96/D400-$96/D401 | 2 | 0 | `rsUnknown96D3ED` / `rsUnknown96D402` |  |
| $96/D415-$96/D416 | 2 | 0 | `rsUnknown96D402` / `rsUnknown96D417` |  |
| $96/D42A-$96/D42B | 2 | 0 | `rsUnknown96D417` / `rsUnknown96D42C` |  |
| $96/DCC8-$96/DD38 | 113 | 0 | `rlUnknown96DC7C` / `rlUnknown96DD39` |  |
| $96/DF98-$96/DFBA | 35 | 0 | `aUnknown96DF60` / `rsUnknown96DFBB` |  |
| $96/F28B-$96/F28C | 2 | 0 | `rlUnknown96F275` / `rlUnknown96F28D` |  |
| $96/F41A-$96/F557 | 318 | 0 | `rsUnknown96F3FE` / `rlBattleSceneEndStepType2Script` |  |
| $96/F89B-$96/F914 | 122 | 0 | `rsUnknown96F7EB` / `rsUnknown96F915` |  |
| $96/FA92-$96/FAB5 | 36 | 0 | `rlUnknown96F9BF` / `rsUnknown96FAB6` |  |
| $96/FADA-$96/FBF8 | 287 | 0 | `rsUnknown96FAB6` / `rlUnknown96FBF9` |  |
| $96/FC49-$96/FD53 | 267 | 0 | `rlUnknown96FBF9` / `rlUnknown96FD54` |  |
| $97/8024-$97/802B | 8 | 0 | `rlBattleScenePlayHolyWeaponSound` / `rlUnknown97802C` |  |
| $D9/6800-$D9/6BFF | 1,024 | 0 | `aUnknownD95000` / `gUnknownD96C00` |  |
| $D9/7400-$D9/793F | 1,344 | 0 | `gUnknownD96C00` / `gUnknownD97940` |  |
| $D9/7B00-$D9/7BFF | 256 | 0 | `gUnknownD97940` / `aUnknownD97C00` |  |
| $DA/45C0-$DA/64FF | 8,000 | 0 | `g4bppStandingMapSprites2` / `aUnknownDA6500` | 92% $00/$FF |
| $DA/6700-$DA/67FF | 256 | 0 | `aUnknownDA65B2` / `gUnknownDA6800` |  |
| $DA/6C80-$DA/6CFF | 128 | 0 | `gUnknownDA6A40` / `gUnknownDA6D00` |  |
| $DA/6F40-$DA/6FFF | 192 | 0 | `gUnknownDA6D00` / `aUnknownDA7000` |  |
| $DA/7800-$DA/79FF | 512 | 0 | `aUnknownDA7000` / `g4bppUnknownDA7A00` |  |
| $9E/8035-$9E/805D | 41 | 0 | `rlStartMapBattleAnimation` / `rlGetMapBattleFacing` |  |
| $9E/9C94-$9E/9CB8 | 37 | 0 | `rlUnknown9E9C70` / `rlProcUnknown9E9A43Cycle1` |  |
| $9E/9ECF-$9E/9F25 | 87 | 0 | `rlUnknown9E9E61` / `rlUnknown9E9F26` |  |
| $9E/B3C8-$9E/B3DD | 22 | 0 | `rlUnknown9EB39F` / `rlUnknown9EB3DE` |  |
| $9E/B433-$9E/B490 | 94 | 0 | `rlMapBattleRestoreMusic` / `rlPlayGoldObtainedJingle` |  |
| $9E/CEB9-$9E/CEDC | 36 | 0 | `rlUnknown9ECEA0` / `procMapExperienceWindowEffect` |  |
| $9E/D006-$9E/D079 | 116 | 0 | `rlUnknown9ECFEB` / `rlStartReturnHomeAnimation` |  |
| $9E/D412-$9E/D429 | 24 | 0 | `rlUnknown9ED401` / `rlStartHolyWeaponShine` |  |
| $9E/D528-$9E/D534 | 13 | 0 | `rlProcHolyWeaponShineInit` / `rlProcUnknown9ED441Cycle2` |  |
| $9E/D72A-$9E/D741 | 24 | 0 | `rlUnknown9ED71E` / `rlUnknown9ED742` |  |
| $9E/E177-$9E/E227 | 177 | 0 | `rlUnknown9EE156` / `rlUnknown9EE228` |  |
| $9E/E2E4-$9E/EC94 | 2,481 | 0 | `rlUnknown9EE2D1` / `rlUnknown9EEC95` |  |
