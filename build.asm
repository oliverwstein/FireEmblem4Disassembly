
.cpu "65816"

  crossbankRawMissing   := 0
  crossbankRawRemaining := b""

  crossbankRaw .segment Block
    crossbankRawMissing   := $10000 - (* & $FFFF)
    crossbankRawRemaining := \Block[crossbankRawMissing:]
    .text \Block[:crossbankRawMissing]
  .endsegment

  crossbankRawRemainder .segment
    .text crossbankRawRemaining
  .endsegment

  crossbank .namespace

    Remainder := b""

    start .function Filename: binary, Address=None

      .if ( Address == None )
        Address := *
      .endif

      Remainder ::= Filename[$8000 - (Address & $FFFF):]
      .text Filename[:$8000 - (Address & $FFFF)]

    .endfunction

    end .segment

      .text crossbank.Remainder

    .endsegment

  .endnamespace ; crossbank

  .include "include/fe4.h"

  ; Fill the base ROM in parts to prevent
  ; pc wrap warnings.

  * := $000000

  .for bank in range($000000, $400000, $8000)
    * := bank
    .binary "fe4.sfc", bank, $8000
  .endfor

  ROM = binary("fe4.sfc")
  .include "engine/core/palettes.asm"
  .include "engine/core/header.asm"
  .include "engine/worldmap/chapter_intro.asm"
  .include "engine/epilogue/credits.asm"
  .include "engine/menus/options_menu.asm"
  .include "engine/core/unused_game_state.asm"
  .include "engine/menus/status_screen.asm"
  .include "engine/menus/castle_menu.asm"
  .include "engine/worldmap/world_map.asm"
  .include "engine/menus/game_over.asm"
  .include "engine/core/game_states.asm"
  .include "engine/menus/data_window.asm"
  .include "engine/menus/skill_window.asm"
  .include "engine/menus/item_window.asm"
  .include "engine/core/ppu_buffers.asm"
  .include "engine/core/joypad.asm"
  .include "engine/menus/unit_window.asm"
  .include "engine/core/active_sprites.asm"
  .include "engine/core/decompressor.asm"
  .include "engine/core/dma.asm"
  .include "engine/core/fade.asm"
  .include "engine/core/frame.asm"
  .include "engine/core/hardware.asm"
  .include "engine/core/hdma.asm"
  .include "engine/core/interrupts.asm"
  .include "engine/core/math.asm"
  .include "engine/core/memory.asm"
  .include "engine/core/proc.asm"
  .include "engine/core/ram_structs.asm"
  .include "engine/core/random.asm"
  .include "engine/map/deployment.asm"
  .include "engine/map/locations.asm"
  .include "engine/map/scroll.asm"
  .include "engine/units/classes.asm"
  .include "engine/units/factions.asm"
  .include "engine/units/generations.asm"
  .include "engine/units/inheritance.asm"
  .include "engine/units/join_order.asm"
  .include "engine/units/level_up.asm"
  .include "engine/units/lovers.asm"
  .include "engine/units/skills.asm"
  .include "engine/units/stats.asm"
  .include "engine/units/unit_creation.asm"
  .include "engine/units/unit_data.asm"
  .include "engine/units/unit_info.asm"
  .include "engine/units/unit_state.asm"
  .include "engine/units/units.asm"
  .include "engine/items/inventory.asm"
  .include "engine/items/items.asm"
  .include "engine/battle/battle.asm"
  .include "engine/battle/battle_stats.asm"
  .include "engine/battle/effects.asm"
  .include "engine/battle/banners.asm"
  .include "engine/battle/scripted_crits.asm"
  .include "engine/ai/actions.asm"
  .include "engine/ai/attack.asm"
  .include "engine/ai/engine.asm"
  .include "engine/ai/groups.asm"
  .include "engine/ai/lists.asm"
  .include "engine/ai/maps.asm"
  .include "engine/ai/scripts.asm"
  .include "engine/ai/threat.asm"
  .include "engine/arena/arena.asm"
  .include "engine/battle/map_battle_magic.asm"
  .include "engine/battle_scene/animation_moves.asm"
  .include "engine/battle_scene/animations.asm"
  .include "engine/battle_scene/backgrounds.asm"
  .include "engine/battle_scene/script.asm"
  .include "engine/core/oam.asm"
  .include "engine/core/options.asm"
  .include "engine/core/tilemaps.asm"
  .include "engine/dialogue/death_quotes.asm"
  .include "engine/dialogue/dialogue.asm"
  .include "engine/dialogue/dialogue_box.asm"
  .include "engine/dialogue/portraits.asm"
  .include "engine/events/asmc.asm"
  .include "engine/events/chapter_data.asm"
  .include "engine/events/event_engine.asm"
  .include "engine/events/event_procs.asm"
  .include "engine/events/event_scripts.asm"
  .include "engine/worldmap/highlight.asm"
  .include "engine/worldmap/markers.asm"
  .include "engine/worldmap/portraits.asm"
  .include "engine/epilogue/dialogue.asm"
  .include "engine/epilogue/endings.asm"
  .include "engine/epilogue/movement.asm"
  .include "engine/epilogue/world_map.asm"
  .include "engine/save/save.asm"
  .include "engine/debug/debug_menu.asm"
  .include "engine/dialogue/backgrounds.asm"
  .include "engine/dialogue/dialogue_procs.asm"
  .include "engine/events/cutscenes.asm"
  .include "engine/events/event_movement.asm"
  .include "engine/events/talk_events.asm"
  .include "engine/map/chapter_maps.asm"
  .include "engine/map/input.asm"
  .include "engine/map/map_sprites.asm"
  .include "engine/map/popups.asm"
  .include "engine/map/windows.asm"
  .include "engine/menus/map_menu.asm"
  .include "engine/menus/menu_text.asm"
  .include "engine/menus/revive_screen.asm"
  .include "engine/rankings/rankings.asm"
  .include "engine/sound/music.asm"
  .include "engine/units/turn_start.asm"
  .include "engine/battle_scene/battle_screen.asm"
  .include "engine/map/map_loop.asm"
  .include "engine/core/boot.asm"
  .include "engine/sound/driver.asm"
  .include "engine/unsorted/bank81.asm"
  .include "engine/unsorted/bank84.asm"
  .include "engine/unsorted/bank85.asm"
  .include "engine/unsorted/bank87.asm"
  .include "engine/unsorted/bank88.asm"
  .include "engine/unsorted/bank89.asm"
  .include "engine/unsorted/bank8A.asm"
  .include "engine/unsorted/bank8B.asm"
  .include "engine/unsorted/bank8C.asm"
  .include "engine/unsorted/bank8D.asm"
  .include "engine/unsorted/bank90.asm"
  .include "engine/unsorted/bank91.asm"
  .include "engine/unsorted/bank95.asm"
  .include "engine/unsorted/bank96.asm"
  .include "engine/unsorted/bank97.asm"
  .include "engine/unsorted/bank9B.asm"
  .include "engine/unsorted/bank9E.asm"
  .include "engine/unsorted/bank9F.asm"

  .include "events/ChapterPrologue.asm"
  .include "events/Chapter01.asm"
  .include "events/Chapter02.asm"
  .include "events/Chapter03.asm"
  .include "events/Chapter04.asm"
  .include "events/Chapter05.asm"
  .include "events/Chapter06.asm"
  .include "events/Chapter07.asm"
  .include "events/Chapter08.asm"
  .include "events/Chapter09.asm"
  .include "events/Chapter10.asm"
  .include "events/ChapterFinal.asm"
  .include "events/ChapterEpilogue.asm"
  .include "data/palettes/BackgroundPalettes.asm"
  .include "data/palettes/MapBattleMagicPalettes.asm"
  .include "data/palettes/WindowPalette.asm"
  .include "data/palettes/BattleAnimationPalettes.asm"
  .include "data/battle_animation/frames_98.asm"
  .include "data/battle_animation/frames_99.asm"
  .include "data/battle_animation/frames_9A.asm"
  .include "data/battle_animation/frames_9B.asm"
  .include "data/battle_animation/moves.asm"
  .include "audio/sound_data.asm"
  .include "data/palettes/Unknown8CPalettes.asm"

    ; Compressed streams: generated from gfx/compressed/C00A2B/C00A2B.streams by build.sh.
    .include "gfx/compressed/C00A2B/Layout.asm"

    * = $008002
    .logical $808002

      .dsection Unsorted808002Section

      .dsection DMAPaletteAndOAMBufferSection

      .dsection Unsorted8080C3Section

      .dsection Unsorted8081A8Section

      .dsection Unsorted8081B6Section

      .dsection Unsorted8081FDSection

      .dsection VBlankControlSection

      .dsection Unsorted80823FSection

      .dsection EnableForcedBlankSection

      .dsection Unsorted80825BSection

      .dsection HideSpritesSection

    .here

    * = $0083C7
    .logical $8083C7

      .dsection OAMUpperXBitTableSection

      .dsection Unsorted808875Section

      .dsection Unsorted80889DSection

      .dsection Table8089F1Section

      .dsection Unsorted808A01Section

      .dsection Table808A25Section

      .dsection Unsorted808A35Section

      .dsection Unsorted808A6CSection

      .dsection Unsorted808B48Section

      .dsection Unsorted808C50Section

      .dsection Unsorted808D56Section

      .dsection Unsorted808D6CSection

      .dsection Unsorted808E2DSection

      .dsection SoundInitSection

      .dsection Unsorted808FA3Section

      .dsection Unsorted808FDDSection

      .dsection Unsorted80903DSection

      .dsection Unsorted8090A2Section

      .dsection Unsorted809124Section

      .dsection Table809357Section

      .dsection Unsorted809377Section

      .dsection Unsorted809382Section

      .dsection Unsorted809391Section
      .dsection Unsorted809392Section

      .dsection Unsorted8093B0Section

      .dsection Unsorted8093C6Section

      .dsection Unsorted8094E2Section

      .dsection Unsorted8095CDSection

      .dsection Unsorted809654Section

      .dsection Table809703Section

    .here

    * = $009729
    .logical $809729

      .dsection Unsorted809729Section
      .dsection Unsorted80972ESection

      .dsection Unsorted809733Section

      .dsection Unsorted809759Section

      .dsection Unsorted80975ESection

      .dsection Unsorted8097E0Section

      .dsection Unsorted809801Section
      .dsection Unsorted809810Section
      .dsection Unsorted80981FSection
      .dsection Unsorted80982ESection
      .dsection Unsorted80983CSection

      .dsection Unsorted809846Section

      .dsection Unsorted809903Section

      .dsection Unsorted809933Section

    .here

    * = $009B00
    .logical $809B00

      .dsection Unsorted809B00Section

      .dsection Unsorted809B01Section

      .dsection Unsorted809BEESection

    .here

    * = $009C7A
    .logical $809C7A

      .dsection Unsorted809C7ASection

      .dsection Unsorted809CA0Section

      .dsection InitEngineSection

      .dsection HardwareResetSection

      .dsection FillBG2Page0TilemapBufferSection

    .here

    * = $00A096
    .logical $80A096

      .dsection MathSection

      .dsection Unsorted80A1ABSection

      .dsection FadeInByTimerSection

      .dsection Unsorted80A29ASection

      .dsection HDMAHandlePossibleSection

      .dsection DMAEngineSection

      .dsection Unsorted80A5D9Section

      .dsection DecompressionListSection

      .dsection Unsorted80A678Section

      .dsection FrameSection

      .dsection RandomNumberSection

      .dsection Unknown80A773Section

      .dsection Unsorted80A836Section

      .dsection Table80A859Section
      .dsection Table80A85DSection

      .dsection Unsorted80A861Section

    .here

    * = $00A899
    .logical $80A899

      .dsection RandomChanceSection

      .dsection BlockCopySection

      .dsection Unsorted80A9F2Section

      .dsection DecompressorSection

      .dsection Unsorted80AD24Section

    .here

    * = $00AE25
    .logical $80AE25

      .dsection Unsorted80AE25Section

      .dsection IRQEngineCycleSection

      .dsection MapVBlankAndStartSection

      .dsection Unsorted80AF9BSection

      .dsection Unsorted80B041Section

      ; Entries for rlHandleMapMenuDecompressionDMA.
      aDecompressionDMAEntry80B084 .structDecompressionDMAEntry gcUnknownC02542, $0400, $3600 ; 80/B084

      .dsection Unsorted80B08CSection

      ; Entries for rlHandleMapMenuDecompressionDMA.
      aDecompressionDMAEntry80B09B .structDecompressionDMAEntry gcUnknownC01FBA, $0400, $3400 ; 80/B09B

      .dsection Unsorted80B0A3Section

      ; Entries for rlHandleMapMenuDecompressionDMA.
      aDecompressionDMAEntry80B0CB .structDecompressionDMAEntry gcUnknownC00A2B, $1800, $4000 ; 80/B0CB

      .dsection Unsorted80B0D3Section

      ; Entries for rlHandleMapMenuDecompressionDMA.
      aDecompressionDMAEntry80B0FD .structDecompressionDMAEntry gcUnknownC0197B, $0800, $4C00 ; 80/B0FD

      .dsection Unsorted80B105Section

      .dsection Unsorted80B122Section

      .dsection Unsorted80B1E1Section

      .dsection MapMainLoopSection

    .here

    * = $00B347
    .logical $80B347

      .dsection Unsorted80B347Section

    .here

    * = $00B61E
    .logical $80B61E

      ; Entries for rlHandleMapMenuDecompressionDMA.
      aDecompressionDMAEntry80B61E .structDecompressionDMAEntry gcUnknownD05673, $6000, $0000 ; 80/B61E
      aDecompressionDMAEntry80B626 .structDecompressionDMAEntry gcUnknownD13D09, $1000, $3000 ; 80/B626
      aDecompressionDMAEntry80B62E .structDecompressionDMAEntry gcUnknownD1432E, $0100, $4000 ; 80/B62E
      aDecompressionDMAEntry80B636 .structDecompressionDMAEntry gcUnknownD14375, $0800, $6000 ; 80/B636

    .here

    * = $00B63F
    .logical $80B63F

      .dsection Unsorted80B63FSection

    .here

    * = $00B641
    .logical $80B641

      .dsection Unsorted80B641Section

      .dsection Table80B6ADSection

      .dsection Unsorted80B6B6Section

      .dsection Unsorted80B74BSection

    .here

    * = $00B77F
    .logical $80B77F

      .dsection Unsorted80B77FSection

      .dsection Table80B787Section

      .dsection Unsorted80B793Section

      .dsection Unsorted80B7B1Section
      .dsection Unsorted80B7DESection

      .dsection Unsorted80B81BSection

    .here

    * = $00B99D
    .logical $80B99D

      ; Entries for rlHandleMapMenuDecompressionDMA.
      aDecompressionDMAEntry80B99D .structDecompressionDMAEntry gcUnknownC00A2B, $1800, $4000 ; 80/B99D
      aDecompressionDMAEntry80B9A5 .structDecompressionDMAEntry g4bppcBattleBannerChalphy, $1000, $2000 ; 80/B9A5

      .dsection Unsorted80B9ADSection

      .dsection Unsorted80B9BCSection

      .dsection Unsorted80B9E1Section

      .dsection Unsorted80BA02Section

      .dsection Unsorted80BA52Section

    .here

    * = $00BB45
    .logical $80BB45

      ; Entries for rlHandleMapMenuDecompressionDMA.
      aDecompressionDMAEntry80BB45 .structDecompressionDMAEntry gcUnknownC00A2B, $1800, $4000 ; 80/BB45
      aDecompressionDMAEntry80BB4D .structDecompressionDMAEntry gcUnknownD35B40, $0800, $5400 ; 80/BB4D
      aDecompressionDMAEntry80BB55 .structDecompressionDMAEntry gcUnknownD33EFA, $2000, $1000 ; 80/BB55

      .dsection Unsorted80BB5DSection

      .dsection Unsorted80BB7CSection

      .dsection Unsorted80BB9BSection

      .dsection Data80BEEFSection

      ; Entries for rlHandleMapMenuDecompressionDMA.
      aDecompressionDMAEntry80BEF9 .structDecompressionDMAEntry gcUnknownC00A2B, $1800, $4000 ; 80/BEF9

      .dsection Unsorted80BF01Section

      .dsection BattleSceneVBlankSection

      .dsection Unsorted80C162Section

      .dsection Unsorted80C1A0Section

    .here

    * = $00C1CA
    .logical $80C1CA

      .dsection Unsorted80C1CASection

      .dsection Unsorted80C1CBSection

      .dsection Unsorted80C212Section

      .dsection Unsorted80C32CSection

      .dsection Unsorted80C35DSection

      .dsection Unsorted80C39ASection

      .dsection Table80C3DDSection

      .dsection Unsorted80C3E6Section

      ; Entries for rlHandleMapMenuDecompressionDMA.
      aDecompressionDMAEntry80C5BE .structDecompressionDMAEntry gcUnknownC00A2B, $1800, $4000 ; 80/C5BE

      .dsection Unsorted80C5C6Section

      .dsection Data80C5F8Section

      .dsection Unsorted80C628Section

      .dsection Table80C6CDSection

      .dsection Unsorted80C6D8Section

      .dsection Table80C716Section

      .dsection Unsorted80C723Section

      .dsection Table80C760Section

      .dsection Unsorted80C76DSection

      .dsection Table80C88ASection

      .dsection Unsorted80C897Section

      .dsection Unsorted80C8D5Section

      .dsection Data80CA25Section

      .dsection Unsorted80CBA5Section

      .dsection Data80CC05Section

      .dsection Unsorted80CC35Section

      .dsection Data80CCD3Section

      .dsection Unsorted80CD2ESection

      ; Entries for rlHandleMapMenuDecompressionDMA.
      aDecompressionDMAEntry80CE8E .structDecompressionDMAEntry gcUnknownC00A2B, $1800, $0000 ; 80/CE8E
      aDecompressionDMAEntry80CE96 .structDecompressionDMAEntry gcUnknownDD3F20, $0800, $2800 ; 80/CE96

      .dsection Unsorted80CE9ESection

      .dsection Table80D046Section

      .dsection Unsorted80D089Section

      .dsection Data80D09BSection

      .dsection Unsorted80D0B1Section

      .dsection Unsorted80D0B4Section

      .dsection Unsorted80D143Section
      .dsection Table80D1AESection

      .dsection Unsorted80D2C6Section

      ; Entries for rlHandleMapMenuDecompressionDMA.
      aDecompressionDMAEntry80D41D .structDecompressionDMAEntry gcUnknownC00A2B, $1800, $0000 ; 80/D41D
      aDecompressionDMAEntry80D425 .structDecompressionDMAEntry gcUnknownDD3CE4, $0700, $1800 ; 80/D425
      aDecompressionDMAEntry80D42D .structDecompressionDMAEntry gcUnknownDD3F20, $0800, $2000 ; 80/D42D

      .dsection Unsorted80D435Section

      .dsection Table80D662Section

      .dsection Unsorted80D818Section

      .dsection Table80D8E8Section

      .dsection DataWindowOpenSection

      .dsection ReviveScreenSection

      .dsection ReviveScreenBuildSection

      .dsection Unsorted80E42BSection

      .dsection Table80E586Section

      .dsection Unsorted80E598Section

      ; Entries for rlHandleMapMenuDecompressionDMA.
      aDecompressionDMAEntry80E72E .structDecompressionDMAEntry gcUnknownC00A2B, $1800, $0000 ; 80/E72E
      aDecompressionDMAEntry80E736 .structDecompressionDMAEntry gcUnknownDD3932, $0800, $4200 ; 80/E736
      aDecompressionDMAEntry80E73E .structDecompressionDMAEntry gcUnknownDD3BDE, $0700, $2000 ; 80/E73E

      .dsection Unsorted80E746Section

      .dsection Table80E84ESection

      .dsection Unsorted80E8F0Section

      .dsection Table80E96ESection

      .dsection Unsorted80E979Section

      .dsection Unsorted80E97CSection

      .dsection Data80E98ESection

      .dsection Unsorted80E9AFSection

      .dsection Unsorted80E9B2Section

      .dsection Data80E9F3Section
      .dsection Data80EA80Section
      .dsection Unsorted80EB37Section

      .dsection Unsorted80EE37Section

    .here

    * = $00EFA8
    .logical $80EFA8

      ; Entries for rlHandleMapMenuDecompressionDMA.
      aDecompressionDMAEntry80EFA8 .structDecompressionDMAEntry g4bppcBattleBackgroundThicket, $4000, $0000 ; 80/EFA8
      aDecompressionDMAEntry80EFB0 .structDecompressionDMAEntry gcUnknownD317A0, $2000, $2000 ; 80/EFB0
      aDecompressionDMAEntry80EFB8 .structDecompressionDMAEntry g4bppcDialogueBackgroundFountainForeground, $2000, $3000 ; 80/EFB8
      aDecompressionDMAEntry80EFC0 .structDecompressionDMAEntry gcUnknownD32CCB, $1000, $6000 ; 80/EFC0
      aDecompressionDMAEntry80EFC8 .structDecompressionDMAEntry gcUnknownD33090, $1000, $5000 ; 80/EFC8
      aDecompressionDMAEntry80EFD0 .structDecompressionDMAEntry gcUnknownD335B5, $1000, $5800 ; 80/EFD0

      .dsection Unsorted80EFD8Section

    .here

    * = $00F187
    .logical $80F187

      ; Entries for rlHandleMapMenuDecompressionDMA.
      aDecompressionDMAEntry80F187 .structDecompressionDMAEntry gcUnknownDD20A0, $1200, $3000 ; 80/F187
      aDecompressionDMAEntry80F18F .structDecompressionDMAEntry gcUnknownDD2D90, $0800, $5000 ; 80/F18F
      aDecompressionDMAEntry80F197 .structDecompressionDMAEntry gcUnknownD35EB4, $5800, $0000 ; 80/F197
      aDecompressionDMAEntry80F19F .structDecompressionDMAEntry gcUnknownD42C50, $1000, $5800 ; 80/F19F

      .dsection Unsorted80F1A7Section

      .dsection Unsorted80F1D5Section

      .dsection Unsorted80F222Section

      .dsection Unsorted80F2BESection

    .here

    * = $00F340
    .logical $80F340

      .dsection Unsorted80F340Section

      .dsection Table80F36CSection

      .dsection Unsorted80F377Section

      .dsection Table80F37DSection

      .dsection Unsorted80F38ASection

      .dsection Unsorted80F392Section

      .dsection Table80F413Section

      ; Entries for rlHandleMapMenuDecompressionDMA.
      aDecompressionDMAEntry80F42B .structDecompressionDMAEntry gcUnknownDD3FA6, $4000, $0000 ; 80/F42B
      aDecompressionDMAEntry80F433 .structDecompressionDMAEntry gcUnknownDD20A0, $1200, $4000 ; 80/F433
      aDecompressionDMAEntry80F43B .structDecompressionDMAEntry gcUnknownDD2D90, $0800, $6000 ; 80/F43B

      .dsection Unsorted80F443Section

      .dsection Unsorted80F451Section
      .dsection Unsorted80F45FSection
      .dsection Unsorted80F46DSection
      .dsection Unsorted80F47BSection
      .dsection Unsorted80F489Section
      .dsection Unsorted80F497Section
      .dsection Unsorted80F4A5Section
      .dsection Unsorted80F4B3Section
      .dsection Unsorted80F4C1Section
      .dsection Unsorted80F4CFSection
      .dsection Unsorted80F4DDSection

      .dsection Unsorted80F4EBSection

      .dsection Unsorted80F542Section

      .fill $80FFB0 - *, 0

    .here

    * = $00FFB0
    .logical $80FFB0

      .dsection SNESHeaderSection

    .here

    * = $018000
    .logical $818000

      .dsection ActiveSpriteEngineSection

      ; 8188b0

      .dsection MapSpriteSection

      .dsection MapSpriteCodeSection

      .dsection Unsorted8189F3Section

    .here

    * = $018A4A
    .logical $818A4A

      .dsection Unsorted818A4ASection

      .dsection Unsorted818C5DSection

      .dsection Unsorted818C98Section

      .dsection Unsorted818D23Section

      .dsection Unsorted818D58Section
      .dsection MovingMapSpritePositionRoutinesSection

      .dsection Unsorted818EABSection

      .dsection MapScrollScriptSection

      .dsection Unknown818FA1Section

      .dsection CapSpawnDestinationCoordinates100Section

    .here

    * = $019092
    .logical $819092

      .dsection FillMovingMapSpriteDataSection

      .dsection FillMovingMapSpriteDataPathScriptPointerSection

    .here

    * = $019166
    .logical $819166

      .dsection Unsorted819166Section
      .dsection GetMapPixelScrollDistanceSection

    .here

    * = $01A800
    .logical $81A800

      .dsection Unsorted81A800Section

      .dsection Unsorted81A85CSection

      .dsection Unsorted81A89DSection

      .dsection GetActiveFactionSongIDSection

      .dsection PlayerPhaseChapterSongIDsSection

      .dsection Unknown81AB90Section

      .dsection Unsorted81AC02Section

      .dsection Unsorted81AD28Section

      .dsection Unsorted81AD6ASection

      .dsection Unsorted81AD8ESection

      .dsection Unsorted81ADD8Section

      .dsection Unsorted81AE02Section

      .dsection Unsorted81AE96Section

      .dsection Unsorted81AEAASection

      .dsection Unsorted81AFB7Section

      .dsection Unsorted81AFF8Section

      .dsection Unsorted81AFFESection

      .dsection Unsorted81B016Section

      .dsection Unsorted81B088Section

      .dsection ASMCShowItemPopUpBoxSection

      .dsection ASMCGiveToSupplyMenuIfInventoryFullSection

      .dsection ASMCGiveItemFromSlot8Section

      .dsection Unsorted81B2AASection

      .dsection Unsorted81B301Section

      .dsection Unsorted81B32CSection

      .dsection Unsorted81B3A6Section

      .dsection Table81B42DSection

      .dsection Unsorted81B43FSection

      .dsection Table81B45BSection

      .dsection Unsorted81B461Section

      .dsection Table81B47DSection

      .dsection ChapterDataPointerSection

      .dsection Unsorted81B4C5Section

      .dsection GetChapterTalkEventsPointerSection

      .dsection Unsorted81B503Section

      .dsection Table81B522Section

      .dsection Unsorted81B52ASection

      .dsection Table81B54ASection

      .fill $81C000 - *, 0

    .here

    * = $01C000
    .logical $81C000

      aUNITGroupPointers                  .include "data/eventunit/UNITGroupPointers.csv.asm"
      aUNITGroupDataPrologueStart         .binclude "data/eventunit/UNITGroupDataPrologueStart.csv.asm"
      aUNITGroupDataPrologueEvans         .binclude "data/eventunit/UNITGroupDataPrologueEvans.csv.asm"
      aUNITGroupDataChapter01Start        .binclude "data/eventunit/UNITGroupDataChapter01Start.csv.asm"
      aUNITGroupDataChapter01Marpha       .binclude "data/eventunit/UNITGroupDataChapter01Marpha.csv.asm"
      aUNITGroupDataChapter01Heirhein     .binclude "data/eventunit/UNITGroupDataChapter01Heirhein.csv.asm"
      aUNITGroupDataChapter01Nordion      .binclude "data/eventunit/UNITGroupDataChapter01Nordion.csv.asm"
      aUNITGroupDataChapter01Verdane      .binclude "data/eventunit/UNITGroupDataChapter01Verdane.csv.asm"
      aUNITGroupDataChapter01Brigands     .binclude "data/eventunit/UNITGroupDataChapter01Brigands.csv.asm"
      aUNITGroupDataChapter02Start        .binclude "data/eventunit/UNITGroupDataChapter02Start.csv.asm"
      aUNITGroupDataChapter02Yellows      .binclude "data/eventunit/UNITGroupDataChapter02Yellows.csv.asm"
      aUNITGroupDataChapter02Infini       .binclude "data/eventunit/UNITGroupDataChapter02Infini.csv.asm"
      aUNITGroupDataChapter02Mackily      .binclude "data/eventunit/UNITGroupDataChapter02Mackily.csv.asm"
      aUNITGroupDataChapter02Agusti       .binclude "data/eventunit/UNITGroupDataChapter02Agusti.csv.asm"
      aUNITGroupDataChapter03Start        .binclude "data/eventunit/UNITGroupDataChapter03Start.csv.asm"
      aUNITGroupDataChapter03Sylvale      .binclude "data/eventunit/UNITGroupDataChapter03Sylvale.csv.asm"
      aUNITGroupDataChapter03Thracia      .binclude "data/eventunit/UNITGroupDataChapter03Thracia.csv.asm"
      aUNITGroupDataChapter03Orgahil      .binclude "data/eventunit/UNITGroupDataChapter03Orgahil.csv.asm"
      aUNITGroupDataChapter03DozelFriege  .binclude "data/eventunit/UNITGroupDataChapter03DozelFriege.csv.asm"
      aUNITGroupDataChapter04Start        .binclude "data/eventunit/UNITGroupDataChapter04Start.csv.asm"
      aUNITGroupDataChapter04Donovan      .binclude "data/eventunit/UNITGroupDataChapter04Donovan.csv.asm"
      aUNITGroupDataChapter04Pamela       .binclude "data/eventunit/UNITGroupDataChapter04Pamela.csv.asm"
      aUNITGroupDataChapter04Annand       .binclude "data/eventunit/UNITGroupDataChapter04Annand.csv.asm"
      aUNITGroupDataChapter04Andrey       .binclude "data/eventunit/UNITGroupDataChapter04Andrey.csv.asm"
      aUNITGroupDataChapter04Zaxon        .binclude "data/eventunit/UNITGroupDataChapter04Zaxon.csv.asm"
      aUNITGroupDataChapter05Start        .binclude "data/eventunit/UNITGroupDataChapter05Start.csv.asm"
      aUNITGroupDataChapter05Leonster     .binclude "data/eventunit/UNITGroupDataChapter05Leonster.csv.asm"
      aUNITGroupDataChapter05Phinora      .binclude "data/eventunit/UNITGroupDataChapter05Phinora.csv.asm"
      aUNITGroupDataChapter05Velthomer    .binclude "data/eventunit/UNITGroupDataChapter05Velthomer.csv.asm"
      aUNITGroupDataChapter05Belhalla     .binclude "data/eventunit/UNITGroupDataChapter05Belhalla.csv.asm"
      aUNITGroupDataChapter05Thracia      .binclude "data/eventunit/UNITGroupDataChapter05Thracia.csv.asm"
      aUNITGroupDataChapter06Start        .binclude "data/eventunit/UNITGroupDataChapter06Start.csv.asm"
      aUNITGroupDataChapter06Ganeishire   .binclude "data/eventunit/UNITGroupDataChapter06Ganeishire.csv.asm"
      aUNITGroupDataChapter06Ribaut       .binclude "data/eventunit/UNITGroupDataChapter06Ribaut.csv.asm"
      aUNITGroupDataChapter07Start        .binclude "data/eventunit/UNITGroupDataChapter07Start.csv.asm"
      aUNITGroupDataChapter07Opening      .binclude "data/eventunit/UNITGroupDataChapter07Opening.csv.asm"
      aUNITGroupDataChapter07Melgen       .binclude "data/eventunit/UNITGroupDataChapter07Melgen.csv.asm"
      aUNITGroupDataChapter07Ulster       .binclude "data/eventunit/UNITGroupDataChapter07Ulster.csv.asm"
      aUNITGroupDataChapter08Start        .binclude "data/eventunit/UNITGroupDataChapter08Start.csv.asm"
      aUNITGroupDataChapter08Opening      .binclude "data/eventunit/UNITGroupDataChapter08Opening.csv.asm"
      aUNITGroupDataChapter08Meath        .binclude "data/eventunit/UNITGroupDataChapter08Meath.csv.asm"
      aUNITGroupDataChapter08Febail       .binclude "data/eventunit/UNITGroupDataChapter08Febail.csv.asm"
      aUNITGroupDataChapter09Start        .binclude "data/eventunit/UNITGroupDataChapter09Start.csv.asm"
      aUNITGroupDataChapter09Opening      .binclude "data/eventunit/UNITGroupDataChapter09Opening.csv.asm"
      aUNITGroupDataChapter09Travant      .binclude "data/eventunit/UNITGroupDataChapter09Travant.csv.asm"
      aUNITGroupDataChapter09Grutia       .binclude "data/eventunit/UNITGroupDataChapter09Grutia.csv.asm"
      aUNITGroupDataChapter09Thracia      .binclude "data/eventunit/UNITGroupDataChapter09Thracia.csv.asm"
      aUNITGroupDataChapter10Opening1     .binclude "data/eventunit/UNITGroupDataChapter10Opening1.csv.asm"
      aUNITGroupDataChapter10Opening2     .binclude "data/eventunit/UNITGroupDataChapter10Opening2.csv.asm"
      aUNITGroupDataChapter10Miletos      .binclude "data/eventunit/UNITGroupDataChapter10Miletos.csv.asm"
      aUNITGroupDataChapter10Chalphy      .binclude "data/eventunit/UNITGroupDataChapter10Chalphy.csv.asm"
      aUNITGroupDataChapterFinalOpening   .binclude "data/eventunit/UNITGroupDataChapterFinalOpening.csv.asm"
      aUNITGroupDataChapterFinalDozel     .binclude "data/eventunit/UNITGroupDataChapterFinalDozel.csv.asm"
      aUNITGroupDataChapterFinalYngvi     .binclude "data/eventunit/UNITGroupDataChapterFinalYngvi.csv.asm"
      aUNITGroupDataChapterFinalFriege    .binclude "data/eventunit/UNITGroupDataChapterFinalFriege.csv.asm"
      aUNITGroupDataChapterFinalVelthomer .binclude "data/eventunit/UNITGroupDataChapterFinalVelthomer.csv.asm"
      aUNITGroupDataChapterFinalBelhalla  .binclude "data/eventunit/UNITGroupDataChapterFinalBelhalla.csv.asm"
      aUNITGroupDataChapterFinalThracia   .binclude "data/eventunit/UNITGroupDataChapterFinalThracia.csv.asm"
      aUNITGroupDataChapterFinalUnused    .binclude "data/eventunit/UNITGroupDataChapterFinalUnused.csv.asm"

      ; 81ebbc

    .here

    * = $028000
    .logical $828000

      .dsection ProcEngineSection
      .dsection ProcCodeSection
      .dsection FadeProcsSection

    .here

    * = $0283E3
    .logical $8283E3

      .dsection ProcScript8283E3Section

      .dsection Unsorted8283EBSection

      .dsection Unsorted8283FASection

      .dsection Unsorted82841FSection

      .dsection ProcScript828429Section

      .dsection Unsorted828431Section
      .dsection DialogueSection

      .dsection ProcDialogueInitSection

      .dsection ProcDialogueCycle1Section

      .dsection Unknown82862ESection

      .dsection Unsorted828648Section

      .dsection Unknown828653Section

      .dsection ProcDialogueCodeSection
      .dsection CastleNamePopUpSection

    .here

    * = $028865
    .logical $828865

      .dsection ProcScript828865Section

    .here

    * = $02886F
    .logical $82886F

      .dsection Unsorted82886FSection

      .dsection Unsorted8288B2Section

      .dsection ProcScript8288E7Section

      .dsection ProcDialogueWithBGFromPointerSection

    .here

    * = $0288F3
    .logical $8288F3

      .dsection Unsorted8288F3Section

      .dsection DialogueWithBGSection

      .dsection Unsorted828A30Section

      .dsection Unsorted828B2BSection

      .dsection Unsorted828B35Section

      .dsection Unsorted828B46Section

    .here

    * = $028B50
    .logical $828B50

      .dsection Unsorted828B50Section

      .dsection Unsorted828B5FSection

      .dsection ProcScript828B61Section

    .here

    * = $028B6B
    .logical $828B6B

      .dsection Unsorted828B6BSection

      .dsection ProcScript828BA7Section

      .dsection Unsorted828BA9Section

    .here

    * = $028BB3
    .logical $828BB3

      .dsection Unsorted828BB3Section

      .dsection Unsorted828BC6Section
      .dsection Unsorted828BC8Section

    .here

    * = $028BD2
    .logical $828BD2

      .dsection Unsorted828BD2Section

      .dsection Unsorted828BE8Section

      .dsection Unsorted828BEASection

      .dsection Unsorted828BF4Section

    .here

    * = $028D52
    .logical $828D52

      .dsection Unsorted828D52Section

      .dsection Unsorted828E61Section

      .dsection Unsorted828ECBSection

      .dsection EventScrollFadeProcSection

    .here

    * = $02921E
    .logical $82921E

      .dsection EventPauseProcSection

      .dsection Unsorted829245Section

    .here

    * = $0292A9
    .logical $8292A9

      .dsection Unsorted8292A9Section

      .dsection Unsorted8292B3Section

      .dsection Unsorted82932CSection

      .dsection Unsorted829391Section

    .here

    * = $029478
    .logical $829478

      .dsection EventHaltProcSection

      ; 829487

      .dsection Unsorted829487Section

      .dsection Unsorted829496Section

    .here

    * = $0294C0
    .logical $8294C0

      .dsection Unsorted8294C0Section

      .dsection Unsorted8294CFSection

    .here

    * = $02C000
    .logical $82C000

      .dsection HDMAEngineSection
      .dsection HDMACodeSection

    .here

    * = $02E000
    .logical $82E000

      .dsection Unsorted82E000Section

      .dsection Unsorted82E028Section

    .here

    * = $02E073
    .logical $82E073

      .dsection Unsorted82E073Section

      .dsection Unsorted82E08DSection

      .dsection Unsorted82E0AFSection

      .dsection Unsorted82E0C6Section

    .here

    * = $02E133
    .logical $82E133

      .dsection Unsorted82E133Section

      .dsection Unsorted82E147Section

      .dsection Unsorted82E250Section

      .dsection Unsorted82E283Section

      .dsection Unsorted82E2ADSection

    .here

    * = $02E400
    .logical $82E400

      .dsection Unsorted82E400Section

    .here

    * = $02E41B
    .logical $82E41B

      .dsection RAMStructSection

      .dsection Unsorted82E5FFSection

      .dsection Unsorted82E615Section

      .dsection Unsorted82E62CSection

      .dsection Unsorted82E664Section

      .dsection RAMStructAccessSection

      .dsection Unsorted82EADESection

    .here

    * = $02ECB9
    .logical $82ECB9

      .dsection RAMAreaHeaderSection

    .here

    * = $02EDE7
    .logical $82EDE7

      .dsection RAMAreaSection

    .here

    * = $02F211
    .logical $82F211

      .dsection Unsorted82F211Section

      .dsection Unsorted82F227Section

      .dsection Unsorted82F2E3Section

      .dsection Unsorted82F343Section

      .dsection Unsorted82F3A7Section

      .dsection Unsorted82F3E5Section

      .dsection Unsorted82F4A7Section

    .here

    * = $02F4DE
    .logical $82F4DE

      .dsection UNITGroupPointerSection

    .here

    * = $02F517
    .logical $82F517

      .dsection Unsorted82F517Section

    .here

    * = $02F567
    .logical $82F567

      .dsection OffsetTableSection

    .here

    * = $02F866
    .logical $82F866

      .dsection EpilogueEndingsSection

      .fill $828000 + $8000 - *, $00

    .here

    * = $038000
    .logical $838000

      aMainDataOffsets .block ; 83/8000

        CharacterNameOffsets    .word <>aCharacterNameOffsets     - aMainDataOffsets ; $00
        CharacterDataOffsets    .word <>aCharacterDataOffsets     - aMainDataOffsets ; $02
        ClassNameOffsets        .word <>aClassNameOffsets         - aMainDataOffsets ; $04
        ClassDataOffsets        .word <>aClassDataOffsets         - aMainDataOffsets ; $06
        MovementCostOffsets     .word <>aMovementCostOffsets      - aMainDataOffsets ; $08
        TerrainAvoidOffsets     .word <>aTerrainAvoidOffsets      - aMainDataOffsets ; $0A
        ItemNameOffsets         .word <>aItemNameOffsets          - aMainDataOffsets ; $0C
        ItemDescriptionOffsets  .word <>aItemDescriptionOffsets   - aMainDataOffsets ; $0E
        ItemDataOffsets         .word <>aItemDataOffsets          - aMainDataOffsets ; $10
                                .word <>aUnknown83D8E6            - aMainDataOffsets ; $12
        FactionNameOffsets      .word <>aFactionNameOffsets       - aMainDataOffsets ; $14
      .bend

      aClassWeaknessTable .binclude "data/class/ClassWeakness.asm"                                      ; 83/8016
      aClassMapSpriteAssignmentOffsets .binclude "data/offset/ClassMapSpriteAssignmentOffsets.csv.asm"  ; 83/805E
      aClassMapSpriteAssignment .include "data/class/ClassMapSpriteAssignment.asm"                      ; 83/80EE
      aPromotionTable .binclude "data/character/PromotionTable.asm"                                     ; 83/833C
      aTerrainNameOffsets .include "data/offset/TerrainNameOffsets.csv.asm"                             ; 83/837B
      aTerrainNames .binclude "text/menutext/TerrainNames.asm"                                            ; 83/83AF
      aMaleLoveDataIDs .include "data/character/MaleLoveDataIDs.csv.asm"                                ; 83/848D
        .sint -1
      aFemaleLoveDataIDs .include "data/character/FemaleLoveDataIDs.csv.asm"                            ; 83/84DB
        .sint -1
      aLoveBaseOffsets .include "data/offset/LoveBaseOffsets.csv.asm"                                   ; 83/850F
      aGen1LoveBases .binclude "data/character/Gen1LoveBases.csv.asm"                                   ; 83/8541
      aGen2LoveBases .binclude "data/character/Gen2LoveBases.csv.asm"                                   ; 83/85C8
      aLoveGrowthOffsets  .include "data/offset/LoveGrowthOffsets.csv.asm"                              ; 83/8738
      aGen1LoveGrowths .binclude "data/character/Gen1LoveGrowths.csv.asm"                               ; 83/876A
      aGen2LoveGrowths .binclude "data/character/Gen2LoveGrowths.csv.asm"                               ; 83/87F1
      aUnknown838961 .binclude "data/Unknown838961.asm"                                                 ; 83/8961
      aChildrenDataOffsets .binclude "data/offset/ChildrenDataOffsets.csv.asm"                          ; 83/8993
      aChildrenData .binclude "data/character/ChildrenData.csv.asm"                                     ; 83/89A5
      aHolyBloodGrowthBoostsOffsets .binclude "data/offset/HolyBloodDataOffsets.csv.asm"                ; 83/89C9
      aHolyBloodData .binclude "data/item/HolyBloodData.csv.asm"                                        ; 83/89E3
      aClassNameOffsets .include "data/offset/ClassNameOffsets.csv.asm"                                 ; 83/8AB3
      aClassNames .binclude "text/menutext/ClassNames.asm"                                                ; 83/8B43
      aClassDataOffsets .include "data/offset/ClassDataOffsets.csv.asm"                                 ; 83/8F35
      aClassData .binclude "data/class/ClassData.csv.asm"                                               ; 83/8FC5
      aMovementCostOffsets .include "data/offset/MovementCostOffsets.csv.asm"                           ; 83/987D
      aMovementCost .binclude "data/terrain/MovementCost.csv.asm"                                       ; 83/989B
      aTerrainAvoidOffsets .include "data/offset/TerrainAvoidOffsets.csv.asm"                           ; 83/9A21
      aTerrainAvoid .binclude "data/terrain/TerrainAvoid.csv.asm"                                       ; 83/9A25
      aCharacterNameOffsets .include "data/offset/CharacterNameOffsets.csv.asm"                         ; 83/9A59
      aCharacterNames .binclude "text/menutext/CharacterNames.asm"                                        ; 83/9ECD
      aCharacterDataOffsets .include "data/offset/CharacterDataOffsets.csv.asm"                         ; 83/ADF5
      aCharacterData .binclude "data/character/CharacterData.csv.asm"                                   ; 83/B267
      aUnknown83D8E6 .word 0                                                                              ; 83/D8E6
      aFactionNameOffsets .include "data/offset/FactionNameOffsets.csv.asm"                             ; 83/D8E8
      aFactionNames .binclude "text/menutext/FactionNames.asm"                                            ; 83/D956
      aItemNameOffsets .include "data/offset/ItemNameOffsets.csv.asm"                                   ; 83/DC12
      aItemNames .binclude "text/menutext/ItemNames.asm"                                                  ; 83/DD26
      aItemDescriptionOffsets .include "data/offset/ItemDescriptionOffsets.csv.asm"                     ; 83/E2E8
      aItemDescriptions .binclude "text/menutext/ItemDescriptions.asm"                                    ; 83/E3FC
      aItemDataOffsets .include "data/offset/ItemDataOffsets.csv.asm"                                   ; 83/E9D0
      aItemData .binclude "data/item/ItemData.csv.asm"                                                  ; 83/EAE4
      aPlayerItemTable .include "data/item/PlayerItemTable.csv.asm"                                     ; 83/F489
      .sint -1
      aCastleNameOffsets .include "data/offset/CastleNameOffsets.csv.asm"                               ; 83/F517
      aCastleNames .binclude "text/menutext/CastleNames.asm"                                              ; 83/F573

      rlSwapToMainDataBank ; 83/F7C1

        .al
        .autsiz
        .databank ?

        phk
        plb
        rtl

        .databank 0

        .fill $838000 + $8000 - *, 0

    .here

    * = $048000
    .logical $848000

      .dsection GenerationTransferSection

      .dsection UnitsSection

      .dsection Unsorted8486A0Section

      .dsection FindCharacterByGenerationIDSection

      .dsection GetUnitByCoordinatesSection

      .dsection Unknown8488AESection

      .dsection LoadUNITGroupMapSpritesSection

      .dsection UnitsTable848A0DEntriesSection

      .dsection Unsorted848BFESection

      .dsection LoversSection

      .dsection CalculateTacticsRankingSection

      .dsection FatherChildrenSection

      .dsection Unsorted848E5DSection

      .dsection CheckUnitsMarriedToEachOtherSection
      .dsection EvaluateSpecifiedRankingScoreSection

      .dsection Unsorted848EFBSection

      .dsection UnitCreationSection

      .dsection UnitDataSection

      .dsection Unsorted8499B5Section

      .dsection LoadExtendedCharacterDataFromBufferSection

      .dsection UnitStatsSection

      .dsection Unknown849FB9Section
      .dsection GetSelectedUnitFactionNameIDSection

      .dsection UnitClassInfoSection

      .dsection LoadCharacterROMDataFromBufferSection

      .dsection UnitCharacterInfoSection

      .dsection UnitHPAndDeathSection

      .dsection ActionLevelUpSection

      .dsection Unsorted84ABB0Section

      .dsection Unsorted84AC24Section

      .dsection LevelUpSection

      .dsection Unsorted84AF17Section

      .dsection Unsorted84AF57Section

      .dsection GetTurnStartEffectsByStatusSection

      .dsection GetChurchHealingSection

      .dsection GetCastleHealingAmountSection

      .dsection UnitStateSection

      .dsection Unsorted84B32BSection

      .dsection Unsorted84B349Section

      .dsection UnitInventoryStateSection

      .dsection Unsorted84B508Section

      .dsection Unsorted84B550Section

      .dsection Unsorted84B57ASection

      .dsection Unsorted84B6A6Section

      .dsection Unsorted84B6E2Section

      .dsection Unsorted84B6F6Section

      .dsection UnitDeathSection

      .dsection Unsorted84B9A3Section

      .dsection Unsorted84B9D4Section

      .dsection Unsorted84BA3ESection

      .dsection Unsorted84BA6FSection

      .dsection ChildUnitSection

      .dsection Unsorted84BB54Section
      .dsection CheckIfBattleAnimationOFFSection

      .dsection FactionSection

      .dsection SetFactionSlotLocationIDSection

      .dsection RunTurnStartEffectsForAllUnitsInFactionSection

      .dsection FactionRelationsSection

      .dsection Unsorted84C398Section

      .dsection Unsorted84C412Section

      .dsection FactionUnitsSection

      .dsection Unsorted84C5D7Section

      .dsection Unsorted84C62ESection

      .dsection DeploymentSection

      .dsection Unsorted84CC5DSection

      .dsection UnitCastleSection

      .dsection Unsorted84CD35Section

      .dsection Unsorted84CD8ASection

      .dsection Unsorted84CDA4Section

      .dsection Unsorted84CDD6Section

      .dsection Unsorted84CE21Section

      .dsection Unsorted84CFBFSection

      .dsection Unsorted84D03ESection

      .dsection Unsorted84D0B2Section

      .dsection Unsorted84D0B9Section

      .dsection Unsorted84D16BSection

      .dsection Unsorted84D1CCSection

      .dsection FieldedUnitFactionSection

      .dsection Unsorted84D2BASection

      .dsection ReturnDeploymentToSavedTileSection

      .dsection Unsorted84D483Section

      .dsection Unsorted84D4A2Section

      .dsection BattleSection

      .dsection Unsorted84EB24Section

      .dsection StaffEffectClearStatusSection

      .dsection BattleEffectsSection

      .dsection InventorySection

      .dsection Unsorted84F75CSection

      .dsection Unsorted84F8D9Section

      .dsection BattleStatsSection

      .dsection Unsorted84FE98Section

      .dsection Unsorted84FEACSection

      .dsection Unsorted84FEBESection

      .dsection Unsorted84FED2Section

      .fill $848000 + $8000 - *, $00

    .here

    * = $058000
    .logical $858000

      .dsection Unsorted858000Section

      .dsection LoadMapMenuDataFromProcSection

      .dsection MapMenuSaveMapStateSection

    .here

    * = $0582D4
    .logical $8582D4

      .dsection Unsorted8582D4Section

    .here

    * = $058341
    .logical $858341

      .dsection StallProcUntilMapMenuDataLoadedSection

      .dsection ProcCycleMapMenuWaitForPaletteGraphicFinishSection

    .here

    * = $058398
    .logical $858398

      .dsection ProcScript858398Section

      .dsection Unsorted8583C2Section

      .dsection Unsorted8583D3Section

      .dsection Unsorted8583DASection

      .dsection Unsorted8583F8Section

      .dsection Unsorted8584A1Section

      .dsection ProcScript8584AASection

      .dsection Unsorted8584ACSection

    .here

    * = $0584DC
    .logical $8584DC

      .dsection Unsorted8584DCSection

      .dsection Unsorted858516Section

      .dsection Unsorted85856ESection

    .here

    * = $05860E
    .logical $85860E

      .dsection Unsorted85860ESection

      .dsection Table858647Section

      .dsection Unsorted85864BSection

      .dsection Unsorted858671Section

      .dsection Unsorted858684Section

      .dsection Unsorted858697Section

      .dsection Unsorted8586AASection

      .dsection Unsorted8586FASection

      .dsection Unsorted8586FFSection

      .dsection Unsorted858728Section

      .dsection Unsorted858751Section

      .dsection Unsorted858793Section

      .dsection Unsorted8587A8Section

      .dsection Unsorted8587E1Section

      .dsection Unsorted8587F2Section

    .here

    * = $05884A
    .logical $85884A

      .dsection Unsorted85884ASection

      .dsection MapMenuBuildTilemapSection

      .dsection Unsorted8589C5Section

      .dsection Table8589DESection

      .dsection Unsorted8589E7Section

      .dsection Table858A1BSection

      .dsection Unsorted858A6FSection

      .dsection Table858A95Section

      .dsection Unsorted858AD7Section

      .dsection Table858AFDSection

      .dsection Unsorted858B51Section

      .dsection Table858BD3Section

      .dsection Unsorted858C4ESection

      .dsection Table858C85Section

      .dsection Unsorted858CD3Section

      .dsection Unsorted858D18Section

      .dsection Table858D62Section

      .dsection Unsorted858D83Section

      .dsection Table858EA1Section

      .dsection Unsorted858EC5Section

      .dsection Unsorted858F10Section

      .dsection Unsorted858F28Section

      .dsection Table859078Section

      .dsection Unsorted8590B9Section

      .dsection Unsorted859108Section

      .dsection Unsorted85915ASection

      .dsection Unsorted859281Section

      .dsection Unsorted85928DSection

      .dsection Unsorted8592FASection

      .dsection Unsorted859386Section

      .dsection Unsorted859390Section

      .dsection Unsorted859427Section

      .dsection Unsorted859431Section

      .dsection Unsorted85988ESection

      .dsection Unsorted85989ASection

      .dsection Table859953Section

      .dsection Unsorted859973Section

      .dsection Table859AA8Section

      .dsection Unsorted859AB4Section

      .dsection Unsorted859AFDSection

      .dsection Unsorted859B28Section

      .dsection Unsorted859B2ASection

      .dsection Table859B42Section

      .dsection Unsorted859B48Section

      .dsection CreateUnitWindowAndTerrainWindowProcsSection

      .dsection Unsorted859BBDSection

      .dsection DialogueBoxMapMenuTilemapDataSection

      .dsection DialogueBoxMapMenuDataSection

      .dsection DialogueBoxSection

      .dsection Unsorted859D60Section

      .dsection Table859D88Section

      .dsection Unsorted859D94Section

      .dsection Unsorted859DCDSection

      .dsection Unsorted859E08Section

      .dsection Unsorted859F97Section

      .dsection FreeHDMAEntry0Section

      .dsection Unsorted859FCDSection

    .here

    * = $059FEA
    .logical $859FEA

      .dsection Unsorted859FEASection

      .dsection Unsorted859FFBSection

      .dsection Unsorted85A02ESection

      .dsection Unsorted85A03DSection

    .here

    * = $05A040
    .logical $85A040

      .dsection Unsorted85A040Section

      .dsection Unsorted85A041Section

      .dsection Unsorted85A079Section

      .dsection Unsorted85A0A1Section

      .dsection Unsorted85A0CESection

      .dsection Unsorted85A0D0Section

      .dsection Unsorted85A0F5Section

      .dsection Unsorted85A117Section

      .dsection Unsorted85A1AASection

      .dsection Unsorted85A1E7Section
      .dsection GetMenuTextStringLengthSection

      .dsection Unsorted85A227Section

      .dsection Unsorted85A314Section

      .dsection Unsorted85A320Section

      .dsection Unsorted85A3A6Section

      .dsection Unsorted85A3D5Section

      .dsection ProcScript85A47FSection

      .dsection Unsorted85A48BSection

      .dsection Table85A4E6Section

      .dsection Unsorted85A508Section

      .dsection Unsorted85A509Section

      .dsection ProcScript85A5BDSection

      .dsection Unsorted85A5C5Section

      .dsection Unsorted85A5EFSection

      .dsection Unsorted85A5FBSection

      .dsection Table85A670Section

      .dsection Unsorted85A69ASection

      .dsection Unsorted85A765Section

      .dsection Unsorted85A782Section

      .dsection Unsorted85A78ESection

      .dsection Table85A7CESection

      .dsection Unsorted85A7DESection

      .dsection DialogueBoxHDMASection

      .dsection FreeDialogueBoxHDMAIfFinishedSection

      .dsection Unsorted85AB32Section

      .dsection FreeDialogueBoxesSection

      .dsection Table85AB82Section

      .dsection Unsorted85AB8ESection

      .dsection Unsorted85AB96Section

      .dsection Unsorted85ABF1Section

      .dsection Unsorted85ABF6Section

      .dsection Unsorted85ABFESection

      .dsection Unsorted85AC02Section

      .dsection Unsorted85AC40Section

      .dsection Unsorted85AC89Section

      .dsection Table85AD47Section

      .dsection Unsorted85AD67Section

      .dsection Unsorted85AE8ASection

      .dsection ProcScript85AEACSection

      .dsection Table85AEBBSection

      .dsection Unsorted85AEC7Section

      .dsection Table85AF0DSection

      .dsection Unsorted85AF1BSection

      .dsection Unsorted85AFC5Section

      .dsection Unsorted85B009Section

      .dsection Unsorted85B039Section

    .here

    * = $05B07C
    .logical $85B07C

      .dsection Unsorted85B07CSection

      .dsection Table85B0BFSection

      .dsection Unsorted85B107Section

      .dsection Table85B127Section

      .dsection Unsorted85B14FSection

      .dsection Unsorted85B18FSection

    .here

    * = $05B1B0
    .logical $85B1B0

      .dsection Unsorted85B1B0Section

      .dsection Unsorted85B207Section

      .dsection Unsorted85B282Section

      .dsection ProcScript85B2D8Section

      .dsection Unsorted85B2DASection

      .dsection Unsorted85B367Section

      .dsection Unsorted85B37DSection

      .dsection Unsorted85B3A2Section

      .dsection Unsorted85B3DASection

      .dsection Unsorted85B3FFSection

      .dsection Unsorted85B40ESection

      .dsection Unsorted85B42BSection

      .dsection Unsorted85B43ESection

      .dsection Unsorted85B45CSection

      .dsection Table85B4E9Section

      .dsection Unsorted85B4EDSection

      .dsection Unsorted85B520Section

      .dsection Table85B547Section

      .dsection ProcScript85B63BSection

    .here

    * = $05B65C
    .logical $85B65C

      .dsection Unsorted85B65CSection

      .dsection Table85B6A0Section

      .dsection Unsorted85B6E0Section

      .dsection ProcScript85B6E1Section

      .dsection Table85B6EBSection

      .dsection Unsorted85B725Section

      .dsection Table85B786Section

      .dsection Unsorted85B78ASection

      .dsection ProcScript85B7CFSection

      .dsection Unsorted85B7D1Section

      .dsection Unsorted85B81DSection

      .dsection Unsorted85B8D6Section

      .dsection Table85B8E5Section

      .dsection Unsorted85B8EESection

      .dsection ProcScript85B8FASection

      .dsection Unsorted85B906Section

      .dsection Table85B9BCSection

      .dsection Unsorted85B9D4Section

      .dsection Unsorted85B9F2Section

      .dsection Table85BA2CSection

      .dsection Unsorted85BA41Section

      .dsection Unsorted85BA4DSection

      .dsection Table85BAB3Section

      .dsection Unsorted85BAC7Section

      .dsection Unsorted85BAD9Section

      .dsection Unsorted85BB2ESection

      .dsection ProcScript85BB52Section

      .dsection Unsorted85BB5ESection

      .dsection Unsorted85BBA5Section

      .dsection Unsorted85BC00Section

      .dsection Unsorted85BC0FSection

      .dsection Unsorted85BC1BSection

      .dsection ItemObtainedTextSection

      .dsection Unsorted85BC9ESection

      .dsection Unsorted85BCB8Section

      .dsection Unsorted85BCD4Section

      .dsection Unsorted85BD12Section

      .dsection Table85BD8DSection

      .dsection Unsorted85BD93Section

      .dsection Unsorted85BDA1Section

      .dsection Table85BE76Section
      .dsection Table85BE87Section
      .dsection ProcScript85C01FSection
      .dsection Unsorted85C028Section

      .dsection Unsorted85C0BASection

      .dsection Unsorted85C0C7Section

      .dsection Unsorted85C0CESection

      .dsection Unsorted85C0D5Section

      .dsection Unsorted85C0E2Section

      .dsection Table85C19BSection

      .dsection Unsorted85C1A4Section

    .here

    * = $05C30D
    .logical $85C30D

      .dsection Unsorted85C30DSection

      .dsection ProcScript85C33DSection

      .dsection Unsorted85C347Section

      .dsection Unsorted85C41FSection

      .dsection Unsorted85C4E0Section

      .dsection Data85C51BSection

      .dsection Unsorted85C55BSection

      .dsection ProcScript85C652Section

      .dsection Unsorted85C65ASection

      .dsection Unsorted85C6D2Section

      .dsection Unsorted85C819Section

      .dsection Table85C983Section

      .dsection Unsorted85C99FSection

      .dsection Data85C9B7Section

      .dsection Unsorted85C9BFSection

      .dsection Unsorted85CA4BSection

      .dsection ProcScript85CA85Section

      .dsection Unsorted85CA91Section

      .dsection Unsorted85CAFBSection

      .dsection Unsorted85CAFCSection

      .dsection Unsorted85CB51Section

      .dsection Unsorted85CBBDSection

      .dsection Unsorted85CC3DSection

      .dsection Unsorted85CC3ESection

      .dsection Unsorted85CC4DSection

      .dsection ProcScript85CC62Section

      .dsection Unsorted85CCA8Section

      .dsection ProcScript85CD0CSection

      .dsection ProcScript85CD2DSection

      .dsection Unsorted85CD39Section

    .here

    * = $05CD81
    .logical $85CD81

      .dsection Unsorted85CD81Section

      .dsection Unsorted85CE54Section

      .dsection Unsorted85CE7CSection

      .dsection Unsorted85CEC3Section

      .dsection Unsorted85CEE2Section

      .dsection ProcScript85D064Section

      .dsection Unsorted85D066Section

      .dsection Unsorted85D100Section

      .dsection Unsorted85D17ESection

    .here

    * = $05D385
    .logical $85D385

      .dsection Unsorted85D385Section

    .here

    * = $05D3F5
    .logical $85D3F5

      .dsection Unsorted85D3F5Section

    .here

    * = $05D442
    .logical $85D442

      .dsection Unsorted85D442Section

      .dsection Unsorted85D4B2Section

      .dsection Table85D591Section

      .dsection Unsorted85D5AASection

      .dsection Unsorted85D5CCSection

    .here

    * = $05D606
    .logical $85D606

      .dsection Table85D606Section
      .dsection Table85D626Section
      .dsection Table85D638Section

      .dsection Unsorted85D648Section

      ; Entries for rlHandleMapMenuDecompressionDMA.
      aDecompressionDMAEntry85D669 .structDecompressionDMAEntry gcUnknownC022B6, $0800, $4C00 ; 85/D669

      .dsection Unsorted85D671Section

      .dsection Unsorted85D676Section

      .dsection Table85D6B2Section

      .dsection Unsorted85D766Section

      .dsection Table85D7A0Section

      .dsection Unsorted85D7FASection

      .dsection ProcScript85D8AASection

      .dsection Unsorted85D8B6Section

      .dsection Table85D96DSection

      .dsection Unsorted85D971Section

      .dsection ProcScript85D9FASection

      .dsection Unsorted85D9FCSection

      .dsection Table85DA77Section

      .dsection Unsorted85DA7ESection

      .dsection Table85DAB2Section

      .dsection Unsorted85DABBSection

      .dsection Table85DACBSection

      .dsection ProcScript85DAEASection

    .here

    * = $05DAF6
    .logical $85DAF6

      .dsection Unsorted85DAF6Section

    .here

    * = $05DBDD
    .logical $85DBDD

      .dsection Unsorted85DBDDSection

      .dsection Unsorted85DC26Section

      .dsection Unsorted85DCABSection

      .dsection Unsorted85DCCASection

      .dsection ProcScript85DDDBSection

      .dsection Unsorted85DDF9Section

      .dsection Unsorted85DE34Section

      .dsection Unsorted85DE7CSection

      .dsection Unsorted85DED6Section

      .dsection Unsorted85DF20Section

      .dsection Unsorted85DF3FSection

      .dsection Unsorted85DF61Section

      .dsection Unsorted85DF6FSection

      .dsection Unsorted85DF7DSection

      .dsection Unsorted85DF8ASection

      .dsection Unsorted85DFA6Section

      .dsection Unsorted85DFC2Section

      .dsection Unsorted85DFFDSection

      .dsection Unsorted85E004Section

      .dsection Unsorted85E012Section

      .dsection ProcScript85E1CCSection

      .dsection Unsorted85E1DBSection

      .dsection Table85E27FSection

      .dsection Unsorted85E2DFSection

      .dsection Unsorted85E33DSection

      .dsection Unsorted85E38CSection

      .dsection Unsorted85E44ESection

      .dsection Unsorted85E47FSection

      .dsection Unsorted85E545Section

      .dsection Unsorted85E549Section

      .dsection Unsorted85E57ESection

      .dsection Unsorted85E6D7Section

      .dsection Unsorted85E6E8Section

      .dsection Unsorted85E78ASection

      .dsection Unsorted85E7B3Section

      .dsection Unsorted85E839Section

      .dsection Unsorted85E85DSection

      .dsection Unsorted85E897Section

      .dsection Unsorted85E8A8Section

      .dsection Unsorted85E8EASection

      .dsection Unsorted85E8FBSection

    .here

    * = $05E951
    .logical $85E951

      .dsection Unsorted85E951Section

    .here

    * = $05E960
    .logical $85E960

      .dsection Unsorted85E960Section

    .here

    * = $05E9C7
    .logical $85E9C7

      .dsection Unsorted85E9C7Section

    .here

    * = $05E9D6
    .logical $85E9D6

      .dsection Unsorted85E9D6Section

      .dsection Table85EA3ASection

    .here

    * = $05EA42
    .logical $85EA42

      .dsection Unsorted85EA42Section
      .dsection Unsorted85EA53Section

      .dsection Unsorted85EA64Section

      .fill $858000 + $8000 - *, $00

    .here

    * = $068000
    .logical $868000

      .dsection EventEngineSection

      .dsection Unsorted869CCCSection

      .dsection Unsorted869CE4Section

      .dsection AIEngineCycleSection
      .dsection AIAttackSection
      .dsection AIMovementMapSection

      .dsection Unsorted86AD5ESection

      .dsection Table86AE36Section

      .dsection FillMapBufferSection

      .dsection AIThreatSection

      .dsection Unsorted86B335Section

      .dsection Unsorted86B36ASection

      .dsection Unsorted86B371Section

      .dsection Unsorted86B38FSection

      .dsection Unsorted86B39DSection

      .dsection Unsorted86B3ABSection

      .dsection Unsorted86B3DDSection

      .dsection AIActionSection

      .dsection Unsorted86BA3BSection

      .dsection AIAction86BA86Section

      .dsection Unsorted86BC64Section

      .dsection AIClosestTileSection

      .dsection Unsorted86BFE6Section

      .dsection AILowHPSection
      .dsection AIUnitMapSection

      .dsection Unsorted86C293Section

      .dsection Unsorted86C333Section

      .dsection Table86C359Section

      .dsection Unsorted86C3A0Section

      .dsection Table86C3C6Section

      .dsection Unsorted86C40DSection

      .dsection ChapterEventDataSection

      .dsection Unsorted86C629Section

      .dsection Table86C69ASection

      .dsection ASMCGiveJuliaLightIfNoWeaponSection
      .dsection ApplyMapTileChangeSection

      aChapterEventPointers .include "data/chapter/ChapterEventPointers.csv.asm" ; 86/C739
      aChapterEventDataPointers .include "data/chapter/ChapterEventDataPointers.csv.asm" ; 86/C760
      aFactionGroupPointers .include "data/chapter/FactionGroupPointers.csv.asm" ; 86/C784

      .dsection Chapter01EventsSection
      .dsection Chapter01EventDataSection
      .dsection Chapter02EventsSection
      .dsection Chapter02EventDataSection
      .dsection Chapter03EventsSection
      .dsection Chapter03EventDataSection
      .dsection Chapter04EventsSection
      .dsection Chapter04EventDataSection
      .dsection Chapter05EventsSection
      .dsection Chapter05EventDataSection
      .dsection Chapter07EventsSection
      .dsection Chapter07EventDataSection
      .dsection Chapter08EventsSection
      .dsection Chapter08EventDataSection
      .dsection Chapter09EventsSection
      .dsection Chapter09EventDataSection
      .dsection ChapterEpilogueEventsSection

      .fill $868000 + $8000 - *, 0

    .here

    ; Compressed streams: generated from gfx/compressed/C70C80/C70C80.streams by build.sh.
    .include "gfx/compressed/C70C80/Layout.asm"

    * = $078000
    .logical $878000

      .dsection CodeChecksums878000Section

      .dsection Unsorted878017Section

      .dsection Unsorted8780AASection

      .dsection Unsorted8780DFSection

      .dsection MapMenu8780F9Section

      .dsection Unsorted878148Section

      .dsection Unknown87819ASection

      .dsection LoadMapMenuDataSection

      .dsection LoadMapMenuTilemapDataSection

      .dsection Unsorted878256Section

      .dsection Unsorted87829ASection

      .dsection Unsorted8782D4Section

      .dsection Unsorted878337Section

      .dsection Unsorted8783F8Section

      .dsection Unsorted87840FSection

      .dsection Unsorted878459Section

      .dsection Unsorted878472Section

    .here

    * = $0784E1
    .logical $8784E1

      .dsection Unsorted8784E1Section

      .dsection GetMapMenuYPositionsSection

      .dsection Unsorted878531Section

      .dsection Unsorted8785A4Section

      .dsection HandleMapMenuPaletteGraphicsDataSection

      .dsection Unsorted87872BSection

      .dsection GetMapMenuPositionSection

      .dsection GetMapMenuTilemapRAMEntryPointerSection

    .here

    * = $078852
    .logical $878852

      .dsection Unsorted878852Section

      .dsection GetMapMenuTileIndexSection

      .dsection Unsorted8788F7Section

      .dsection Unsorted878900Section

    .here

    * = $078916
    .logical $878916

      .dsection Unsorted878916Section

      .dsection Unsorted878921Section
      .dsection ApplyMapMenuPaletteDataSection

      .dsection HandleMapMenuDecompressionDMASection

      .dsection Unsorted878AB5Section

      .dsection Unsorted878B1FSection

      .dsection Unsorted878B4ESection

      .dsection RemoveMapMenuTilemapRAMEntrySection

      .dsection Unsorted878BF0Section

      .dsection Unsorted878C8CSection

      .dsection Unsorted878D61Section

      .dsection Unsorted878F6ESection

      .dsection Unsorted878FE7Section

      .dsection Table879076Section

      .dsection Unsorted87913ESection

      .dsection Unsorted8791EESection

      .dsection DrawMenuTextLineSection

      .dsection Table879471Section

      .dsection Table879D77Section

      .dsection CheckTalkEventEntryAvailableSection

      .dsection Unsorted879EE7Section

      .dsection Unsorted879F12Section

      .dsection Unsorted87A006Section

      .dsection Unsorted87A040Section

      .dsection Unsorted87A082Section

      .dsection Unsorted87A18CSection

      .dsection SkillsSection

      .dsection ClassDataSection

      .dsection InheritanceSection

      .dsection LovePointsSection

      .dsection Unsorted87AE88Section

      .dsection Unsorted87AF46Section

      .dsection Unsorted87B01DSection
      .dsection ClearEventMovementTargetMapSection

      .dsection EventMovementTargetDistanceMapSection

      .dsection EventMovementMovementScriptBufferAddressesSection

      .dsection EventMovementDirectionLookupSection

      .dsection EventMovementWriteToMovementScriptBufferSection

      .dsection Unsorted87B512Section

      .dsection Unsorted87B541Section

      .dsection Unsorted87B5DDSection

      .dsection Unsorted87B63FSection

      .dsection Unsorted87B786Section

      .dsection Unsorted87B877Section

      .dsection Unsorted87B8A7Section

      .dsection Table87B8EESection

      .dsection Unsorted87B8FESection

      .dsection Table87BAD1Section

      .dsection Unsorted87BB27Section

      .dsection ScriptedCritsSection

      .dsection CheckIfTerrainWindowSettingOffSection

      .dsection Unsorted87BED7Section

      .dsection GetTextSpeedOptionSection

      .dsection Unsorted87BF01Section

      .dsection Unsorted87BF1BSection

      .dsection Unsorted87BF29Section

      .dsection Unsorted87BF43Section

      .dsection Unsorted87BF52Section

      .dsection Unsorted87BF6FSection

      .dsection Unsorted87BFBFSection

      .dsection Unsorted87BFD9Section

      .dsection Unsorted87BFE9Section

      .dsection AICleverModeSection

      .dsection Unsorted87C015Section

      .dsection Unsorted87C02FSection

      .dsection Unsorted87C03CSection

      .dsection Unsorted87C056Section
      .dsection ProcCycleFlickerUnitsOfFactionSlotSection

      .dsection Unsorted87C38CSection

      .dsection Unsorted87C41BSection

      .dsection Unsorted87C442Section

      .dsection Unsorted87C5AASection

      .dsection Table87C5BFSection

      .dsection Unsorted87C646Section

      .dsection Unsorted87C695Section

    .here

    * = $07C70A
    .logical $87C70A

      .dsection Unsorted87C70ASection

      .dsection Unsorted87C712Section

      .dsection Table87C784Section

      .dsection Unsorted87C7B4Section

      .dsection Unsorted87C7F3Section

      .dsection Unsorted87C81FSection

      .dsection Unsorted87C821Section

      .dsection Table87C866Section

      .dsection Unsorted87C87ASection

      .dsection Table87C8E1Section

      .dsection Unsorted87CBC5Section

      .dsection AITargetListSection
      .dsection AIScriptSection
      .dsection AIRangeMapSection

      .dsection Unsorted87D65ASection

      .dsection AITargetMapSection
      .dsection AIUnitListSection
      .dsection AIGroupSection

      .dsection AIFormationOffsetSection

      .dsection FormationPatternOffsetsSection

      .dsection ItemsSection

      .dsection Unsorted87E6D3Section

    .here

    * = $07E6D7
    .logical $87E6D7

      .dsection Unsorted87E6D7Section

      .dsection Unsorted87E705Section
      .dsection Unsorted87E707Section

      .dsection Unsorted87E709Section

      .dsection Table87E715Section

      .dsection Unsorted87E737Section

    .here

    * = $07E762
    .logical $87E762

      .dsection Unsorted87E762Section

      .dsection Unsorted87E779Section

      .dsection Unsorted87E801Section

      .dsection Table87E811Section

      .dsection Unsorted87E833Section
      .dsection Unsorted87E834Section
      .dsection Unsorted87E83FSection
      .dsection Unsorted87E84ASection
      .dsection Unsorted87E855Section

      .dsection Unsorted87E86ASection

      .dsection LocationEventDataSection

      .dsection Unsorted87E9E0Section

      .dsection Unsorted87EA09Section

      .dsection LocationUpdateSection

      .dsection Unsorted87EBC8Section

      .dsection LocationGettersSection

      .dsection Unsorted87EF46Section

      .dsection LocationModificationSection

      .dsection Unsorted87F321Section

      .dsection Table87F361Section

      .dsection GetEventLocationTypeBaseMoneySection

      .dsection LocationTypeOffsetsSection

      .dsection CheckIfCharacterHasFemaleGenerationIDSection

      .dsection Unsorted87F501Section

      .dsection Unsorted87F515Section

      .dsection Unsorted87F55ASection

      .dsection CreateUnitFromBuffersByTypeSection

      .dsection CompactStaticDynamicUnitBuffer1UnitStatesSection

      .dsection Unsorted87F9F6Section

      .dsection CompactHolyEnemyUnitBuffer1UnitStatesSection

      .dsection Unsorted87FA57Section

      .dsection FillUnitsDeploymentSaveDataSection

      .dsection Unsorted87FABCSection

      .dsection Unsorted87FB5ESection

      .dsection Unsorted87FB94Section

      .dsection FillItemsOwnerAndSlotDataSection

      .dsection FillItemDurabilityDataSection

      .dsection CapItemDurabilitySection

      .dsection Unsorted87FD09Section

      .fill $878000 + $8000 - *, $00

    .here

    * = $088000
    .logical $888000

      .dsection Table888000Section

      .dsection Unsorted888082Section

    .here

    * = $08818A
    .logical $88818A

      .dsection Unsorted88818ASection

      .dsection Unsorted888197Section

      .dsection Unsorted8881B8Section

      .dsection Unsorted8881D7Section

      .dsection Unsorted8881DESection

      .dsection Unsorted8881E5Section

      .dsection Unsorted8881ECSection

    .here

    * = $08821A
    .logical $88821A

      .dsection Unsorted88821ASection

      .dsection Unsorted8883C7Section

      .dsection Unsorted888410Section

      .dsection Unsorted88847DSection

      .dsection Unsorted888560Section

    .here

    * = $0885D3
    .logical $8885D3

      .dsection Unsorted8885D3Section

      .dsection Unsorted8885EFSection

      .dsection Unsorted88860BSection

      .dsection Unsorted88861CSection
      .dsection MapScrollRightSetBGOFSSection

      .dsection Unsorted8887ECSection

      .dsection Unsorted888901Section

      .dsection Unsorted888A14Section

      .dsection Unsorted888BB3Section

      .dsection Unsorted888C5FSection

      .dsection Unsorted888D57Section

      .dsection Unsorted888F32Section

      .dsection ProcScript889396Section

      .dsection Unsorted88939ESection

      .dsection Table8893DBSection

      .dsection Unsorted889400Section

      .dsection Unsorted889411Section

      .dsection Table8894F2Section

      .dsection ProcScript889504Section

      .dsection Unsorted889506Section
      .dsection Table88958FSection

      .dsection Unsorted8896AFSection

      .dsection Data88972FSection

      .dsection Unsorted88973FSection

      .dsection Table8899A4Section

      .dsection Unsorted8899B8Section

    .here

    * = $089AE2
    .logical $889AE2

      .dsection Table889AE2Section

      .dsection Unsorted889B22Section

      .dsection Unsorted889B6DSection

      .dsection Unsorted889BB5Section

      .dsection Unsorted889BF7Section

    .here

    * = $089C52
    .logical $889C52

      .dsection ProcScript889C52Section

      .dsection Unsorted889C5ASection

      .dsection Unsorted889CEESection

      .dsection Unsorted889D20Section

      .dsection Table889D92Section

      .dsection Unsorted889DA6Section

      .dsection ProcScript889E6CSection

    .here

    * = $089FC3
    .logical $889FC3

      .dsection ChapterMapsSection

      .dsection Unsorted88A12BSection

      .dsection Unsorted88A2F5Section

      .dsection Unsorted88A32DSection

    .here

    * = $08A38C
    .logical $88A38C

      .dsection Unsorted88A38CSection

      .dsection Unsorted88A395Section

      .dsection Unsorted88A44CSection

      .dsection Data88A4BCSection

      .dsection Unsorted88A4FCSection

    .here

    * = $08A551
    .logical $88A551

      .dsection Unsorted88A551Section

      .dsection Unsorted88A698Section

    .here

    * = $08A704
    .logical $88A704

      .dsection Unsorted88A704Section

      .dsection Table88A73DSection

      .dsection Unsorted88A754Section

      .dsection Unsorted88A7F5Section

    .here

    * = $08A81D
    .logical $88A81D

      .dsection Unsorted88A81DSection

      .dsection Unsorted88AB2CSection

      .dsection Unsorted88AB47Section

      .dsection Unsorted88AC5BSection

      .dsection Unsorted88ACA6Section

    .here

    * = $08ACF1
    .logical $88ACF1

      .dsection Table88ACF1Section

    .here

    * = $08AD46
    .logical $88AD46

      .dsection Unsorted88AD46Section

      .dsection Unsorted88ADA2Section

      .dsection Unsorted88ADA6Section

      .dsection Unsorted88ADC9Section

      .dsection Unsorted88ADE9Section

      .dsection Unsorted88AF4CSection

      .dsection Unsorted88AF7BSection

      .dsection MapInputHandlerSection

      .dsection Unsorted88B028Section

      .dsection Unsorted88B366Section

      .dsection Unsorted88B3AFSection

    .here

    * = $08B3DF
    .logical $88B3DF

      .dsection Unsorted88B3DFSection

      .dsection Unsorted88B42CSection

      .dsection Unsorted88B46ASection

      .dsection Unsorted88B4DBSection

      .dsection Unsorted88B51ASection

      .dsection Unsorted88B64FSection

      .dsection Unsorted88B6FDSection

      .dsection Unsorted88BC05Section

      .dsection Unsorted88BDA1Section

    .here

    * = $08BF37
    .logical $88BF37

      .dsection Unsorted88BF37Section

      .dsection Unsorted88BF6CSection

      .dsection Unsorted88BF97Section

      .dsection Unsorted88BFFASection

      .dsection Unsorted88C059Section

      .dsection Unsorted88C072Section

      .dsection Unsorted88C085Section

      .dsection GetMapSpriteMovementSoundSection

      .dsection Unsorted88C1BFSection

      .dsection Unsorted88C25DSection

      .dsection Unsorted88C2BASection

      .dsection Unsorted88C355Section

      .dsection Unsorted88C3F0Section

      .dsection Unsorted88C4D9Section

      .dsection Unsorted88C67DSection

      .dsection Unsorted88C6EDSection

      .dsection Unsorted88C71CSection

      .dsection Unsorted88C7CFSection

      .dsection Unsorted88C7D8Section

      .dsection Table88C834Section

      .dsection Data88C83CSection

      .dsection Unsorted88C844Section

      .dsection Data88C990Section

      .dsection Unsorted88C9A6Section

      .dsection Unsorted88CA28Section

      .dsection Unsorted88CA77Section

      .dsection Unsorted88CBE8Section

      .dsection Unsorted88CC75Section

      .dsection Unsorted88CD53Section

      .dsection Unsorted88CD68Section

      .dsection Table88CF8ASection

      .dsection Unsorted88CFBASection

      .dsection Table88D013Section

      .dsection Unsorted88D073Section

      .dsection Unsorted88D084Section

      .dsection Data88D135Section

      aMapMovementShortSpritePointers .binclude "data/class/MapMovementShortSpritePointers.csv.asm" ; 88/D365
      aMapMovementTallSpritePointers  .binclude "data/class/MapMovementTallSpritePointers.csv.asm"  ; 88/D428

      .dsection Table88D488Section
      .dsection Table88D4C6Section
      .dsection Table88D526Section
      .dsection Table88D5E3Section

      .dsection MovingMapSpriteAppendDecompSection

      .dsection SetMovingMapSpriteBufferPointersSection

      .dsection Unsorted88D731Section

      .dsection Table88D7B2Section

      .dsection Unsorted88D7BASection
      .dsection Unsorted88D7C5Section
      .dsection Unsorted88D7D8Section
      .dsection Unsorted88D7EBSection

      .dsection Unsorted88D7FESection

      .dsection Unsorted88D847Section

      .dsection Unsorted88D94BSection

      .dsection Unsorted88D963Section

      .dsection Unsorted88DA6ASection

      .dsection Unsorted88DA82Section

      .dsection Unsorted88DAFCSection

      .dsection Unsorted88DB0CSection

      .dsection Unsorted88DBEESection

      .dsection Unsorted88DC07Section

      .dsection Unsorted88DD0FSection

      .dsection Unsorted88DD9CSection

      .dsection Unsorted88DDFBSection

      .dsection Unsorted88DE0BSection

      .dsection Unsorted88DE1BSection

      .dsection Data88DEFCSection

      .dsection Unsorted88DF8CSection

    .here

    * = $08E02B
    .logical $88E02B

      .dsection Unsorted88E02BSection

      .dsection Unsorted88E033Section

      .dsection Unsorted88E10BSection

      .dsection Unsorted88E179Section

      .dsection Unsorted88E1FESection

      .dsection ProcScript88E200Section

      .dsection Unsorted88E208Section

      .dsection ProcScript88E268Section

      .dsection Unsorted88E272Section

    .here

    * = $08E2DC
    .logical $88E2DC

      .dsection ProcScript88E2DCSection

      .dsection Table88E2DESection

      .dsection Unsorted88E2E9Section

    .here

    * = $08E33D
    .logical $88E33D

      .dsection Unsorted88E33DSection

      .dsection Unsorted88E38ASection

      .dsection Unsorted88E401Section

      .dsection Table88E9E4Section

      .dsection Unsorted88EEB1Section

      .dsection Unsorted88EF0DSection

      .fill $888000 + $8000 - *, $00

    .here

    * = $098000
    .logical $898000

      .dsection Unsorted898000Section

      .dsection Table8980EFSection

      .dsection Unsorted898105Section

      .dsection Unsorted898536Section

      .dsection Unsorted89861BSection

      .dsection Unsorted898734Section

      .dsection Unsorted898755Section

      .dsection Unsorted898768Section

      .dsection Unsorted89876DSection

      .dsection Table898973Section

      .dsection Unsorted8989ADSection

      .dsection Unsorted8989CESection

      .dsection Unsorted8989EASection

      .dsection Unsorted898A41Section

    .here

    * = $098A7E
    .logical $898A7E

      .dsection Unsorted898A7ESection

      .dsection Unsorted898AF5Section

      .dsection Table898B2ASection

      .dsection Unsorted898B3BSection

      .dsection Table898B80Section

      .dsection Data898B88Section

      .dsection Unsorted898B97Section

      .dsection Data898CBCSection

      .dsection Unsorted898D55Section

    .here

    * = $098E6C
    .logical $898E6C

      .dsection Table898E6CSection
      .dsection Table898E90Section

      .dsection Unsorted898EB4Section

      .dsection Unsorted898F16Section

      .dsection Table898F43Section
      .dsection Table898F5BSection

      .dsection Unsorted898F73Section

      .dsection Table898FD4Section
      .dsection Table898FECSection
      .dsection Table899004Section

      .dsection Unsorted899028Section

      .dsection Table899081Section

      .dsection Data899099Section

      .dsection Unsorted8990BDSection

    .here

    * = $0990DA
    .logical $8990DA

      .dsection Unsorted8990DASection

      .dsection Table899140Section

      .dsection Unsorted89914BSection

      .dsection Table899178Section

      .dsection Unsorted899185Section

      .dsection Table8991B9Section

      .dsection Unsorted8991C4Section

    .here

    * = $099200
    .logical $899200

      .dsection Unsorted899200Section

      .dsection Data89923FSection

      .dsection Unsorted8992ADSection

      .dsection Table8992E7Section

      .dsection Unsorted89933CSection

      .dsection Data89935FSection

      .dsection Unsorted89936ESection

      .dsection Unsorted8994B8Section

      .dsection Unsorted899510Section

      .dsection Table899703Section

      .dsection Unsorted89970DSection

      .dsection Data8998D4Section

      .dsection Unsorted8998E1Section

      .dsection Table899B8FSection

      .dsection Unsorted899BA5Section

      .dsection Table899C44Section

      .dsection Unsorted899C7CSection

      .dsection Table899D26Section

      .dsection Unsorted899D72Section

      .dsection Table899F0BSection

      .dsection Unsorted899FA1Section

      .dsection Unsorted899FDCSection

      .dsection Unsorted89A085Section

      .dsection SplitNumberIntoDigitsSection

      .dsection Unsorted89A138Section

      .dsection Unsorted89A150Section

      .dsection DrawMenuTextNumberSection

      .dsection Unsorted89A25ASection

      .dsection Unsorted89A2EDSection

      .dsection Unsorted89A376Section

      .dsection Unsorted89A3C0Section

      .dsection Table89A4C5Section

      .dsection Unsorted89A4E3Section

      .dsection Table89A52DSection
      .dsection Table89A572Section
      .dsection Table89A59ESection

      .dsection Unsorted89A5AASection

      .dsection Unsorted89A5D1Section
      .dsection SpriteArray89A72ESection
      .dsection Table89A76CSection

      .dsection Table89ABF9Section

      .dsection Data89AC56Section

      .dsection Unsorted89ACCESection

      .dsection Table89ACF6Section

      .dsection ReviveMenuSection

      .dsection Unsorted89B058Section
      .dsection Unsorted89B0A9Section

      .dsection Unsorted89B0AASection

      .dsection Table89B0B9Section

      .dsection Unsorted89B0BFSection
      .dsection Unsorted89B0C6Section
      .dsection Unsorted89B0D0Section
      .dsection Unsorted89B0D1Section
      .dsection Unsorted89B10CSection

    .here

    * = $09B20B
    .logical $89B20B

      .dsection Unsorted89B20BSection

      .dsection Data89B225Section

      .dsection Unsorted89B285Section

      .dsection Data89B29ESection

      .dsection Unsorted89B2A2Section
      .dsection Unsorted89B2B6Section

      .dsection Data89B30CSection

      .dsection Unsorted89B344Section

      .dsection Data89B39FSection

      .dsection Unsorted89B3D7Section

      .dsection Table89B3F6Section

      .dsection Unsorted89B400Section

      .dsection Unsorted89B79DSection
      .dsection Unsorted89B838Section

      .dsection Unsorted89B856Section

      .dsection Unsorted89B869Section

      .dsection Unsorted89B883Section

      .dsection Unsorted89B8BDSection

      .dsection Unsorted89B91FSection

      .dsection Table89BAC1Section

      .dsection Unsorted89BAF3Section

      .dsection Unsorted89BBB2Section

      .dsection Table89BCCESection

      .dsection Data89BCE6Section

      .dsection Unsorted89BD00Section

      .dsection Data89BE57Section

      .dsection Unsorted89BEB8Section

      .dsection Unsorted89BECCSection

      .dsection Unsorted89BEEBSection

      .dsection Unsorted89C021Section

      .dsection Unsorted89C119Section

      .dsection Data89C13ESection

      .dsection Unsorted89C144Section

      .dsection Data89C181Section

      .dsection Unsorted89C1A1Section

      .dsection Unsorted89C2CFSection

      .dsection Unsorted89C3F3Section

      .dsection Unsorted89C488Section

      .dsection Unsorted89C5A2Section

      .dsection Data89C5C9Section

      .dsection DebugMenuSection

      .dsection Unsorted89EB26Section

      .dsection Table89EB56Section

      .dsection Unsorted89EB5ESection

      .dsection Unsorted89ECB4Section

      .dsection Unsorted89ECC6Section

      .dsection Unsorted89ECC7Section

      .dsection Unsorted89ED12Section

      .dsection Table89ED58Section

      .dsection Data89ED6ASection

      .dsection Unsorted89EDFDSection

      .dsection Table89EE0ESection

      .dsection Unsorted89EE14Section

      .dsection Unsorted89EE32Section

      .dsection Unsorted89EE50Section
      .dsection Unsorted89EE89Section

      .dsection Table89EE9ASection

      .dsection Unsorted89EEA4Section

      .dsection Unsorted89EEFESection

      .dsection Table89EF0FSection

      .dsection Unsorted89EF13Section

      .dsection Table89EF40Section

      .dsection Unsorted89EF50Section

      .dsection Table89EF61Section

      .dsection Unsorted89EF67Section

      .dsection Unsorted89EFA3Section

      .dsection Table89EFB4Section

      .dsection Unsorted89EFBESection

      .dsection Unsorted89F018Section

      .dsection Table89F029Section

      .dsection Unsorted89F02DSection

      .dsection Table89F051Section

      .dsection Unsorted89F065Section

      .dsection Data89F180Section

      .dsection Unsorted89F246Section
      .dsection Table89F338Section

      .dsection Data89F579Section

      .dsection Unsorted89F620Section

      .dsection Unsorted89F630Section

      .dsection Data89F66ESection

      .dsection Unsorted89F67FSection

      .dsection Data89F6BCSection

      .dsection Unsorted89F713Section

      .dsection Unsorted89F7A6Section

      .dsection Data89F7CDSection

      .dsection Unsorted89F7E6Section

      .dsection Unsorted89F842Section

    .here

    ; The portraits: generated from gfx/portraits/portraits.streams by build.sh.
    .include "gfx/portraits/Layout.asm"
    * = $09F88B
    .logical $89F88B

      .dsection Table89F88BSection

      .fill $898000 + $8000 - *, 0

    .here

    * = $0A8000
    .logical $8A8000

      .dsection Unsorted8A8000Section

      .dsection Unsorted8A800ESection

      .dsection Unsorted8A8061Section

      .dsection Table8A8078Section

      .dsection Unsorted8A80A6Section

      .dsection Unsorted8A80C3Section
      .dsection Unsorted8A80C8Section

      .dsection Unsorted8A80CDSection

      .dsection Unsorted8A80F5Section

      .dsection Unsorted8A80FASection

      .dsection Unsorted8A8208Section

      .dsection Data8A8387Section

      .dsection Unsorted8A8393Section

      .dsection Data8A847ESection

      .dsection Unsorted8A8496Section

      .dsection Table8A85EFSection

      .dsection Unsorted8A8643Section

    .here

    * = $0A869A
    .logical $8A869A

      .dsection Unsorted8A869ASection

      .dsection Unsorted8A870DSection

      .dsection Unsorted8A8783Section

      .dsection Unsorted8A87B8Section

      .dsection Table8A88E0Section

      .dsection Unsorted8A8980Section

      .dsection Unsorted8A8E08Section

    .here

    * = $0A8F58
    .logical $8A8F58

      ; Entries for rlHandleMapMenuDecompressionDMA.
      aDecompressionDMAEntry8A8F58 .structDecompressionDMAEntry gcUnknownC00A2B, $1800, $4000 ; 8A/8F58
      aDecompressionDMAEntry8A8F60 .structDecompressionDMAEntry g4bppcBattleBannerChalphy, $1000, $2000 ; 8A/8F60

      .dsection Unsorted8A8F68Section

      .dsection Unsorted8A8F8FSection

      .dsection Table8A9158Section

      .dsection Unsorted8A918ASection

      .dsection Table8A91D7Section

      .dsection Unsorted8A9209Section

      .dsection Table8A9269Section

      .dsection Unsorted8A929BSection

      .dsection Unsorted8A92AASection

      .dsection Unsorted8A92BBSection

      .dsection Unsorted8A92D6Section

      .dsection Unsorted8A9342Section

      .dsection Unsorted8A9389Section
      .dsection Table8A945ESection
      .dsection Unsorted8A946ASection

      .dsection Unsorted8A94B6Section

    .here

    * = $0A94E2
    .logical $8A94E2

      .dsection Unsorted8A94E2Section

    .here

    * = $0A950E
    .logical $8A950E

      .dsection Unsorted8A950ESection

      .dsection Unsorted8A956FSection

      .dsection Unsorted8A9750Section

      .dsection Unsorted8A9776Section

      .dsection Unsorted8A979CSection

      .dsection Unsorted8A97C2Section

      .dsection Unsorted8A9858Section

      .dsection Table8A9899Section

      .dsection Table8A98ACSection
      .dsection Table8A98B8Section

      .dsection Data8A98C4Section

      .dsection Unsorted8A98D0Section

      .dsection Table8A99DBSection
      .dsection Table8A9A0BSection

      .dsection Unsorted8A9A56Section

      .dsection Table8A9AD4Section
      .dsection Table8A9B04Section
      .dsection Table8A9B94Section
      .dsection Table8A9BC4Section
      .dsection Table8A9BF4Section
      .dsection Table8A9C24Section

      .dsection Unsorted8A9C61Section

      .dsection Unsorted8A9D22Section

      .dsection Unsorted8A9D39Section

      .dsection Data8A9D79Section
      .dsection Table8A9DD5Section
      .dsection Unsorted8A9DDDSection

      .dsection Unsorted8A9DF2Section

      .dsection Unsorted8A9EB7Section

      .dsection Unsorted8A9FCCSection

      .dsection Unsorted8AA013Section

      .dsection Table8AA022Section

      .dsection Unsorted8AA02BSection

      .dsection Table8AA12ESection

      .dsection Unsorted8AA142Section
      .dsection Table8AA241Section
      .dsection Unsorted8AA251Section

      .dsection Unsorted8AA2EDSection

      .dsection Table8AA31CSection

      .dsection Unsorted8AA400Section

      .dsection Data8AA4C6Section

      .dsection Unsorted8AA4C8Section

      .dsection Unsorted8AA5FFSection

      .dsection Data8AA629Section

      .dsection Unsorted8AA63DSection

      .dsection Unsorted8AA6CASection

      .dsection Table8AA7DDSection

      .dsection Unsorted8AA830Section

      .dsection Unsorted8AA83DSection

      .dsection Table8AA8B5Section

      .dsection Unsorted8AA8C9Section

      .dsection Data8AA917Section

      .dsection Unsorted8AA928Section

      .dsection Data8AA975Section

      .dsection Unsorted8AA97FSection

      .dsection Unsorted8AA9A6Section

      .dsection Unsorted8AA9CESection

      .dsection Unsorted8AAA3ASection

      .dsection Table8AAA78Section

      .dsection Unsorted8AAA8ASection

      .dsection Table8AAB40Section

      .dsection Unsorted8AAB48Section

      .dsection Unsorted8AABABSection

      .dsection Table8AABEASection

      .dsection Unsorted8AABFCSection

      .dsection Table8AACA0Section

      .dsection Unsorted8AACA8Section

      .dsection Unsorted8AAD05Section

      .dsection Unsorted8AAD6FSection

      .dsection Table8AADA7Section

      .dsection Unsorted8AADADSection

      .dsection Unsorted8AADC3Section

      .dsection Table8AADCESection

      .dsection Unsorted8AADF4Section

      .dsection Table8AAEDASection

      .dsection Unsorted8AAF0ASection

      .dsection Data8AB033Section

      .dsection Unsorted8AB043Section

      .dsection Data8AB07CSection

      .dsection Unsorted8AB093Section

    .here

    * = $0AB111
    .logical $8AB111

      .dsection Unsorted8AB111Section

      .dsection Table8AB230Section

      .dsection Unsorted8AB23BSection

      .dsection DialoguePortraitSection

      .dsection Unsorted8AB3FESection

      .dsection GetDecompressedPortraitDataPointersSection

      .dsection DecompressWorldMapPortraitToSlotSection

      .dsection PortraitSlotDecompressionPointersSection

      aPortraitGraphicPointers .include "data/PortraitGraphicPointers.csv.asm" ; 8A/B4F9
      aPortraitPalettePointers .include "data/PortraitPalettePointers.csv.asm" ; 8A/B7E1

    .here

    * = $0ABACF
    .logical $8ABACF

      .dsection DialogueBackgroundsSection

      .dsection Unsorted8ABB3ESection

    .here

    * = $0ABE4B
    .logical $8ABE4B

      ; Entries for rlHandleMapMenuDecompressionDMA.
      aDecompressionDMAEntry8ABE4B .structDecompressionDMAEntry gcUnknownC00A2B, $1800, $4000 ; 8A/BE4B
      aDecompressionDMAEntry8ABE53 .structDecompressionDMAEntry gcUnknownD46691, $0800, $2800 ; 8A/BE53
      aDecompressionDMAEntry8ABE5B .structDecompressionDMAEntry gcUnknownD467EF, $0800, $2C00 ; 8A/BE5B

      .dsection Unsorted8ABE63Section

      ; Entries for rlHandleMapMenuDecompressionDMA.
      aDecompressionDMAEntry8ABF0F .structDecompressionDMAEntry gcUnknownD22430, $1000, $0000 ; 8A/BF0F
      aDecompressionDMAEntry8ABF17 .structDecompressionDMAEntry gcUnknownD27F1A, $1000, $0000 ; 8A/BF17
      aDecompressionDMAEntry8ABF1F .structDecompressionDMAEntry gcUnknownD2769C, $1000, $0000 ; 8A/BF1F

      .dsection Unsorted8ABF27Section

      .dsection Data8ABFF3Section

      .dsection Unsorted8AC003Section

      .dsection Table8AC08FSection

      .dsection Unsorted8AC0B9Section

      .dsection Table8AC447Section

      .dsection Unsorted8AC457Section

      .dsection Unsorted8AC50DSection
      .dsection Unsorted8AC524Section
      .dsection Unsorted8AC68ESection
      .dsection Unsorted8AC6BASection
      .dsection Unsorted8AC785Section
      .dsection Unsorted8AC81ESection
      .dsection Unsorted8AC853Section

      .dsection Unsorted8AC8A2Section

      .dsection Unsorted8AC984Section
      .dsection Unsorted8ACA53Section

      .dsection Unsorted8ACAD2Section

      .dsection Unsorted8ACBF2Section

      .dsection Unsorted8ACC43Section

      .dsection Unsorted8ACC58Section
      .dsection Unsorted8ACD53Section
      .dsection Unsorted8ACD94Section
      .dsection Unsorted8ACDABSection

      .dsection Unsorted8ACE2BSection

      .dsection Unsorted8ACE3ASection

    .here

    * = $0ACE50
    .logical $8ACE50

      .dsection Unsorted8ACE50Section

      .dsection Unsorted8ACEB3Section

      .dsection Unsorted8ACFBESection

      .dsection Table8AD071Section

      .dsection Unsorted8AD092Section

      dialogueShop00 .include "text/dialogue/Shops/Shop00.dialogue.txt" ; 8AD0D4
      dialogueShop18 .include "text/dialogue/Shops/Shop18.dialogue.txt" ; 8AD0E3
      dialogueShop1D .include "text/dialogue/Shops/Shop1D.dialogue.txt" ; 8AD0F1
      dialogueShop22 .include "text/dialogue/Shops/Shop22.dialogue.txt" ; 8AD101
      dialogueShop27 .include "text/dialogue/Shops/Shop27.dialogue.txt" ; 8AD110
      dialogueShop2C .include "text/dialogue/Shops/Shop2C.dialogue.txt" ; 8AD121
      dialogueShopUnknown8AD131 .include "text/dialogue/Shops/ShopUnknown8AD131.dialogue.txt" ; 8AD131
      dialogueShop36 .include "text/dialogue/Shops/Shop36.dialogue.txt" ; 8AD154
      dialogueShop0C .include "text/dialogue/Shops/Shop0C.dialogue.txt" ; 8AD17B
      dialogueShop12 .include "text/dialogue/Shops/Shop12.dialogue.txt" ; 8AD18B
      dialogueShop01 .include "text/dialogue/Shops/Shop01.dialogue.txt" ; 8AD195
      dialogueShopUnknown8AD1B5 .include "text/dialogue/Shops/ShopUnknown8AD1B5.dialogue.txt" ; 8AD1B5
      dialogueShop19 .include "text/dialogue/Shops/Shop19.dialogue.txt" ; 8AD1D2
      dialogueShop1E .include "text/dialogue/Shops/Shop1E.dialogue.txt" ; 8AD1E0
      dialogueShop23 .include "text/dialogue/Shops/Shop23.dialogue.txt" ; 8AD1F2
      dialogueShop37 .include "text/dialogue/Shops/Shop37.dialogue.txt" ; 8AD205
      dialogueShop3C .include "text/dialogue/Shops/Shop3C.dialogue.txt" ; 8AD217
      dialogueShop41 .include "text/dialogue/Shops/Shop41.dialogue.txt" ; 8AD224
      dialogueShopUnknown8AD233 .include "text/dialogue/Shops/ShopUnknown8AD233.dialogue.txt" ; 8AD233
      dialogueShopUnknown8AD257 .include "text/dialogue/Shops/ShopUnknown8AD257.dialogue.txt" ; 8AD257
      dialogueShop28 .include "text/dialogue/Shops/Shop28.dialogue.txt" ; 8AD27B
      dialogueShop2D .include "text/dialogue/Shops/Shop2D.dialogue.txt" ; 8AD28A
      dialogueShop31 .include "text/dialogue/Shops/Shop31.dialogue.txt" ; 8AD29F
      dialogueShop0D .include "text/dialogue/Shops/Shop0D.dialogue.txt" ; 8AD2B8
      dialogueShop13 .include "text/dialogue/Shops/Shop13.dialogue.txt" ; 8AD2C8
      dialogueShop02 .include "text/dialogue/Shops/Shop02.dialogue.txt" ; 8AD2D9
      dialogueShop47 .include "text/dialogue/Shops/Shop47.dialogue.txt" ; 8AD2F8
      dialogueShop45 .include "text/dialogue/Shops/Shop45.dialogue.txt" ; 8AD30A
      dialogueShop4A .include "text/dialogue/Shops/Shop4A.dialogue.txt" ; 8AD31C
      dialogueShop54 .include "text/dialogue/Shops/Shop54.dialogue.txt" ; 8AD32E
      dialogueShop4F .include "text/dialogue/Shops/Shop4F.dialogue.txt" ; 8AD351
      dialogueShop29 .include "text/dialogue/Shops/Shop29.dialogue.txt" ; 8AD363
      dialogueShop33 .include "text/dialogue/Shops/Shop33.dialogue.txt" ; 8AD373
      dialogueShop0E .include "text/dialogue/Shops/Shop0E.dialogue.txt" ; 8AD38F
      dialogueShop14 .include "text/dialogue/Shops/Shop14.dialogue.txt" ; 8AD39F
      dialogueShopUnknown8AD3AA .include "text/dialogue/Shops/ShopUnknown8AD3AA.dialogue.txt" ; 8AD3AA
      dialogueShop03 .include "text/dialogue/Shops/Shop03.dialogue.txt" ; 8AD3D3
      dialogueShop39 .include "text/dialogue/Shops/Shop39.dialogue.txt" ; 8AD3EF
      dialogueShop20 .include "text/dialogue/Shops/Shop20.dialogue.txt" ; 8AD401
      dialogueShop43 .include "text/dialogue/Shops/Shop43.dialogue.txt" ; 8AD40B
      dialogueShopUnknown8AD418 .include "text/dialogue/Shops/ShopUnknown8AD418.dialogue.txt" ; 8AD418
      dialogueShop2F .include "text/dialogue/Shops/Shop2F.dialogue.txt" ; 8AD43E
      dialogueShop1B .include "text/dialogue/Shops/Shop1B.dialogue.txt" ; 8AD44E
      dialogueShop25 .include "text/dialogue/Shops/Shop25.dialogue.txt" ; 8AD45D
      dialogueShopUnknown8AD46F .include "text/dialogue/Shops/ShopUnknown8AD46F.dialogue.txt" ; 8AD46F
      dialogueShop0F .include "text/dialogue/Shops/Shop0F.dialogue.txt" ; 8AD48F
      dialogueShop15 .include "text/dialogue/Shops/Shop15.dialogue.txt" ; 8AD4A0
      dialogueShop05 .include "text/dialogue/Shops/Shop05.dialogue.txt" ; 8AD4B0
      dialogueShopUnknown8AD4BC .include "text/dialogue/Shops/ShopUnknown8AD4BC.dialogue.txt" ; 8AD4BC
      dialogueShopUnknown8AD4D7 .include "text/dialogue/Shops/ShopUnknown8AD4D7.dialogue.txt" ; 8AD4D7
      dialogueShopUnknown8AD4E9 .include "text/dialogue/Shops/ShopUnknown8AD4E9.dialogue.txt" ; 8AD4E9
      dialogueShopUnknown8AD507 .include "text/dialogue/Shops/ShopUnknown8AD507.dialogue.txt" ; 8AD507
      dialogueShopUnknown8AD53C .include "text/dialogue/Shops/ShopUnknown8AD53C.dialogue.txt" ; 8AD53C
      dialogueShopUnknown8AD553 .include "text/dialogue/Shops/ShopUnknown8AD553.dialogue.txt" ; 8AD553
      dialogueShopUnknown8AD574 .include "text/dialogue/Shops/ShopUnknown8AD574.dialogue.txt" ; 8AD574
      dialogueShopUnknown8AD5A5 .include "text/dialogue/Shops/ShopUnknown8AD5A5.dialogue.txt" ; 8AD5A5
      dialogueShopUnknown8AD5B7 .include "text/dialogue/Shops/ShopUnknown8AD5B7.dialogue.txt" ; 8AD5B7
      dialogueShopUnknown8AD5C5 .include "text/dialogue/Shops/ShopUnknown8AD5C5.dialogue.txt" ; 8AD5C5
      dialogueShopUnknown8AD5F0 .include "text/dialogue/Shops/ShopUnknown8AD5F0.dialogue.txt" ; 8AD5F0
      dialogueShop17 .include "text/dialogue/Shops/Shop17.dialogue.txt" ; 8AD5F9
      dialogueShop06 .include "text/dialogue/Shops/Shop06.dialogue.txt" ; 8AD60D
      dialogueShopUnknown8AD616 .include "text/dialogue/Shops/ShopUnknown8AD616.dialogue.txt" ; 8AD616
      dialogueShopUnknown8AD648 .include "text/dialogue/Shops/ShopUnknown8AD648.dialogue.txt" ; 8AD648
      dialogueShopUnknown8AD65E .include "text/dialogue/Shops/ShopUnknown8AD65E.dialogue.txt" ; 8AD65E
      dialogueShopUnknown8AD678 .include "text/dialogue/Shops/ShopUnknown8AD678.dialogue.txt" ; 8AD678
      dialogueShopUnknown8AD68E .include "text/dialogue/Shops/ShopUnknown8AD68E.dialogue.txt" ; 8AD68E
      dialogueShopUnknown8AD6A8 .include "text/dialogue/Shops/ShopUnknown8AD6A8.dialogue.txt" ; 8AD6A8
      dialogueShopUnknown8AD6BE .include "text/dialogue/Shops/ShopUnknown8AD6BE.dialogue.txt" ; 8AD6BE
      dialogueShopUnknown8AD6DA .include "text/dialogue/Shops/ShopUnknown8AD6DA.dialogue.txt" ; 8AD6DA
      dialogueShopUnknown8AD6E7 .include "text/dialogue/Shops/ShopUnknown8AD6E7.dialogue.txt" ; 8AD6E7
      dialogueShopUnknown8AD70D .include "text/dialogue/Shops/ShopUnknown8AD70D.dialogue.txt" ; 8AD70D
      dialogueShop04 .include "text/dialogue/Shops/Shop04.dialogue.txt" ; 8AD727
      dialogueShop4E .include "text/dialogue/Shops/Shop4E.dialogue.txt" ; 8AD728
      dialogueShopUnknown8AD756 .include "text/dialogue/Shops/ShopUnknown8AD756.dialogue.txt" ; 8AD756
      dialogueShopUnknown8AD785 .include "text/dialogue/Shops/ShopUnknown8AD785.dialogue.txt" ; 8AD785
      dialogueShopUnknown8AD7A4 .include "text/dialogue/Shops/ShopUnknown8AD7A4.dialogue.txt" ; 8AD7A4
      dialogueShopUnknown8AD7D0 .include "text/dialogue/Shops/ShopUnknown8AD7D0.dialogue.txt" ; 8AD7D0
      dialogueShopUnknown8AD7FC .include "text/dialogue/Shops/ShopUnknown8AD7FC.dialogue.txt" ; 8AD7FC
      dialogueShop10 .include "text/dialogue/Shops/Shop10.dialogue.txt" ; 8AD81A

      .dsection Unsorted8AD81BSection

    .here

    * = $0AD952
    .logical $8AD952

      ; Entries for rlHandleMapMenuDecompressionDMA.
      aDecompressionDMAEntry8AD952 .structDecompressionDMAEntry gcUnknownC00A2B, $1800, $4000 ; 8A/D952

      .dsection Unsorted8AD95ASection

      .dsection Unsorted8AD975Section

      .dsection Unsorted8AD9FESection

      .dsection Unsorted8ADA16Section

      .dsection Unsorted8ADA83Section

      .dsection Unsorted8ADB04Section

      .dsection Unsorted8ADB37Section

      .dsection DisplayDialogueAPressArrowsSection

      .dsection Table8ADB9FSection

      .dsection Unsorted8ADBBDSection

      .dsection Unsorted8ADBFFSection

      .dsection Unsorted8ADC25Section

      .dsection Unsorted8ADCDDSection

      .dsection Unsorted8ADCDESection

      .dsection Unsorted8ADCF9Section

    .here

    * = $0AE05E
    .logical $8AE05E

      .dsection Unsorted8AE05ESection

      .dsection Table8AE0C7Section

      .dsection ProcScript8AE147Section

      .dsection Unsorted8AE14FSection

      .dsection ProcScript8AE197Section

      .dsection Unsorted8AE199Section

      .dsection ProcUnknown8AE199InitSection

      .dsection Unsorted8AE1C1Section

      .dsection Unsorted8AE1EBSection

      .dsection Unsorted8AE1F3Section

      .dsection ProcScript8AE243Section

      .dsection Unsorted8AE245Section

      .dsection Unsorted8AE29FSection

      .dsection Unsorted8AE2F8Section

      .dsection ArenaMenuSection

      .dsection Unsorted8AECEFSection

      ; Entries for rlHandleMapMenuDecompressionDMA.
      aDecompressionDMAEntry8AEE89 .structDecompressionDMAEntry gcUnknownC00A2B, $1800, $4000 ; 8A/EE89
      aDecompressionDMAEntry8AEE91 .structDecompressionDMAEntry gcUnknownD240B0, $1000, $0000 ; 8A/EE91
      aDecompressionDMAEntry8AEE99 .structDecompressionDMAEntry g4bppcBattleBackgroundUnknown17, $2000, $1000 ; 8A/EE99
      aDecompressionDMAEntry8AEEA1 .structDecompressionDMAEntry gcUnknownD24914, $0800, $2800 ; 8A/EEA1
      aDecompressionDMAEntry8AEEA9 .structDecompressionDMAEntry gcUnknownD467EF, $0800, $2C00 ; 8A/EEA9

      .dsection Unsorted8AEEB1Section

      .dsection Table8AEEF2Section

      .dsection Unsorted8AEEFESection

    .here

    * = $0AF048
    .logical $8AF048

      .dsection Unsorted8AF048Section
      .dsection Unsorted8AF0B4Section

      .dsection Unsorted8AF0D7Section

    .here

    * = $0AF263
    .logical $8AF263

      ; Entries for rlHandleMapMenuDecompressionDMA.
      aDecompressionDMAEntry8AF263 .structDecompressionDMAEntry gcUnknownC00A2B, $1800, $4000 ; 8A/F263
      aDecompressionDMAEntry8AF26B .structDecompressionDMAEntry gcUnknownD30F54, $1000, $0000 ; 8A/F26B
      aDecompressionDMAEntry8AF273 .structDecompressionDMAEntry gcUnknownD46691, $0800, $2800 ; 8A/F273
      aDecompressionDMAEntry8AF27B .structDecompressionDMAEntry gcUnknownD467EF, $0800, $2C00 ; 8A/F27B

      .dsection Unsorted8AF283Section

      .dsection Table8AF2C7Section

      .dsection Unsorted8AF2E1Section

      .dsection Table8AF475Section

      .dsection Unsorted8AF4A1Section
      .dsection Unsorted8AF4B8Section
      .dsection Unsorted8AF556Section
      .dsection Unsorted8AF634Section
      .dsection Unsorted8AF6A1Section
      .dsection Unsorted8AF6D5Section
      .dsection Unsorted8AF6ECSection
      .dsection Unsorted8AF791Section
      .dsection Unsorted8AF818Section

      .dsection Unsorted8AF885Section

    .here

    * = $0AFA0C
    .logical $8AFA0C

      ; Entries for rlHandleMapMenuDecompressionDMA.
      aDecompressionDMAEntry8AFA0C .structDecompressionDMAEntry gcUnknownC00A2B, $1800, $4000 ; 8A/FA0C
      aDecompressionDMAEntry8AFA14 .structDecompressionDMAEntry gcUnknownD269F9, $1000, $0000 ; 8A/FA14
      aDecompressionDMAEntry8AFA1C .structDecompressionDMAEntry gcUnknownD24CA4, $2000, $1000 ; 8A/FA1C
      aDecompressionDMAEntry8AFA24 .structDecompressionDMAEntry gcUnknownD272B9, $0800, $2800 ; 8A/FA24
      aDecompressionDMAEntry8AFA2C .structDecompressionDMAEntry gcUnknownD467EF, $0800, $2C00 ; 8A/FA2C

      .dsection Unsorted8AFA34Section

      .dsection Table8AFA6FSection

      .dsection Unsorted8AFA7FSection

      .dsection Unsorted8AFC52Section

      .dsection Unsorted8AFC78Section

      .dsection Unsorted8AFCD5Section

      .fill $8A8000 + $8000 - *, $00

    .here

    * = $0B8000
    .logical $8B8000

      .dsection Unsorted8B8000Section

      .dsection Unsorted8B806DSection

      .dsection Unsorted8B80CBSection

    .here

    * = $0B818D
    .logical $8B818D

      .dsection Unsorted8B818DSection

    .here

    * = $0B821F
    .logical $8B821F

      .dsection FadeInWorldMapPortraitSlotSection

      .dsection WorldMapPortraitSection

      ; 8b83a7

    .here


    * = $0B84E5
    .logical $8B84E5

      .dsection WorldMapMarkers1Section

      .dsection Unsorted8B87E5Section

      .dsection WorldMapHighlightCodeSection

      ; 8b8a58

    .here

    * = $0B8A84
    .logical $8B8A84

      .dsection ClearHighlightWorldMapPartSection

      .dsection Unsorted8B8AABSection

      .dsection WorldMapMarkerShadowFadeInSection

    .here

    * = $0B8BB5
    .logical $8B8BB5

      .dsection Unsorted8B8BB5Section

    .here

    * = $0B8BF4
    .logical $8B8BF4

      .dsection WorldMapMarkerShadowFadeOutSection

      .dsection Unsorted8B8C3ASection

      .dsection Unsorted8B8C42Section

    .here

    * = $0B8C81
    .logical $8B8C81

      .dsection Unsorted8B8C81Section

      .dsection FadeInWorldMapPortraitSlot8B8C83Section

      .dsection ProcFadeInWorldMapPortraitSlotCycleSection

      .dsection ProcFadeInWorldMapPortraitSlotCodeSection

      .dsection Table8B911FSection

      .dsection Unsorted8B912ASection

      .dsection Unsorted8B91F6Section

      .dsection Table8B9449Section

      .dsection Unsorted8B9451Section

      .dsection Unsorted8B9458Section

      .dsection Table8B9594Section

      .dsection Unsorted8B959CSection

      .dsection Unsorted8B95A3Section

      .dsection Unsorted8B96CFSection

      .dsection Table8B9726Section

      .dsection Unsorted8B972CSection

      .dsection Unsorted8B973CSection

      .dsection Unsorted8B9759Section

      .dsection WorldMapMarkers2Section

      aPortraitDataIDs .include "data/character/PortraitDataIDs.csv.asm" ; 8B/9A88
      aClassPortraitDataIDs .include "data/class/ClassPortraitDataIDs.csv.asm" ; 8B/9FF8
      ; 4 different HDMA structs

    .here

    * = $0BA0B4
    .logical $8BA0B4

      .dsection Unsorted8BA0B4Section

      .dsection Unsorted8BA7CBSection

    .here

    * = $0BA7F2
    .logical $8BA7F2

      .dsection Unsorted8BA7F2Section

      .dsection Table8BA845Section

      .dsection Unsorted8BA851Section

      .dsection Unsorted8BAC7FSection

      .dsection UnitWindowUnknown8BACADSection

      .dsection Unsorted8BADF1Section

      .dsection UnitWindowPageDrawersSection

      .dsection Unsorted8BAE1ESection

      .dsection UnitWindowDrawPagesSection

      .dsection Unsorted8BB45DSection

      .dsection Unsorted8BB469Section

      .dsection Data8BB4C7Section

      .dsection Unsorted8BB50DSection

    .here

    * = $0BB53B
    .logical $8BB53B

      .dsection Data8BB53BSection

      .dsection Unsorted8BB54FSection

    .here

    * = $0BB596
    .logical $8BB596

      .dsection Unsorted8BB596Section

      .dsection Data8BB61BSection

      .dsection Unsorted8BB63BSection

      .dsection Data8BB70BSection

      .dsection Unsorted8BB71FSection

    .here

    * = $0BB811
    .logical $8BB811

      .dsection Data8BB811Section

      .dsection Unsorted8BB871Section

    .here

    * = $0BB8B6
    .logical $8BB8B6

      .dsection Unsorted8BB8B6Section

      .dsection Data8BB9FCSection

      .dsection Unsorted8BBAA4Section

      .dsection Unsorted8BBAE9Section

      .dsection Data8BBD40Section

      .dsection Unsorted8BBDA7Section

      .dsection UnitWindowDrawWeaponRankSection

      .dsection Unsorted8BBE68Section

      aItemIconOffsets .binclude "data/item/ItemIconOffsets.asm" ; 8B/BED5

      .dsection Table8BBFEDSection

      .dsection Unsorted8BC030Section

      .dsection Table8BC08FSection

      .dsection Data8BC0B0Section

      .dsection Unsorted8BC0F0Section

      .dsection Data8BC127Section

      .dsection Unsorted8BC21FSection

      .dsection Data8BC385Section

      .dsection Unsorted8BC391Section

      .dsection Unsorted8BC43ASection

      .dsection Table8BC457Section

      .dsection Unsorted8BC467Section

      .dsection Unsorted8BC484Section

    .here

    * = $0BC518
    .logical $8BC518

      .dsection Table8BC518Section

      .dsection Unsorted8BC52ASection

      .dsection Unsorted8BC5C6Section

      .dsection Table8BC61CSection

      .dsection Unsorted8BC668Section

      .dsection UnitWindowUnknown8BC67FSection

      .dsection Table8BC96ASection

      .dsection UnitWindowUnknown8BC972Section

      .dsection Unsorted8BC9B6Section

      .dsection Unsorted8BCA1ASection

      .dsection Table8BCA31Section

      .dsection Unsorted8BCA7FSection

      .dsection Unsorted8BCAB4Section

      .dsection UnitWindowUnknown8BCAE5Section

      .dsection UnitWindowUnknown8BCBBASection

      .dsection Unsorted8BCD20Section

      .dsection Unsorted8BCD89Section

      .dsection JoinOrderSection

      .dsection Unsorted8BCE29Section

      .dsection Unsorted8BCE71Section

      .dsection Data8BCECASection

      .dsection DataWindowShowSection

      .dsection Unsorted8BD794Section

      .dsection Table8BD7B9Section

      .dsection Unsorted8BD7BDSection

      .dsection Unsorted8BD8FESection

      .dsection Unsorted8BD90BSection

      .dsection Data8BDA9CSection

      .dsection Unsorted8BDAB4Section

      .dsection Unsorted8BDB54Section

      .dsection Data8BDB7ESection

      .dsection Unsorted8BDBA2Section
      .dsection Table8BDC22Section
      .dsection Unsorted8BDC49Section

      .dsection Unsorted8BDC92Section

      .dsection Data8BDE9DSection

      .dsection Unsorted8BDECDSection

    .here

    ; Compressed streams: generated from gfx/compressed/8BE03C/8BE03C.streams by build.sh.
    .include "gfx/compressed/8BE03C/Layout.asm"

    * = $0BDFBF
    .logical $8BDFBF

      .dsection Data8BDFBFSection

      .dsection BattleAnimationPalettes8BE000Section

      .dsection BattleAnimationPalettes8BE01ESection

    .here

    * = $0C9400
    .logical $8C9400

      .dsection Data8C9400Section

      .dsection Unknown8CPalettes8C9800Section

      .dsection Data8C9D00Section

      .dsection BackgroundPalettes8C9E00Section

      .dsection Unknown8CPalettes8CA000Section

      .include "data/PortraitPalettes.asm"

      .dsection BackgroundPalettes8CC500Section

      .dsection Data8CCB00Section

      .dsection BackgroundPalettes8CCC00Section

      .dsection Unknown8CPalettes8CD000Section

      .dsection Table8CDC00Section

      .dsection Table8CDC30Section

      .dsection Table8CDE00Section

      .dsection Data8CDE20Section

      .dsection BackgroundPalettes8CDF00Section

    .here

    * = $0CE000
    .logical $8CE000

      .dsection BackgroundPalettes8CE000Section

    .here

    * = $0CE100
    .logical $8CE100

      .dsection BackgroundPalettes8CE100Section

    .here

    * = $0CE200
    .logical $8CE200

      .dsection BackgroundPalettes8CE200Section

    .here

    * = $0CE300
    .logical $8CE300

      .dsection BackgroundPalettes8CE300Section

    .here

    * = $0CE400
    .logical $8CE400

      .dsection BackgroundPalettes8CE400Section

    .here

    * = $0CE500
    .logical $8CE500

      .dsection BackgroundPalettes8CE500Section

    .here

    * = $0CE600
    .logical $8CE600

      .dsection BackgroundPalettes8CE600Section

    .here

    * = $0CE700
    .logical $8CE700

      .dsection BackgroundPalettes8CE700Section

    .here

    * = $0CE800
    .logical $8CE800

      .dsection BackgroundPalettes8CE800Section

    .here

    * = $0CE900
    .logical $8CE900

      .dsection BackgroundPalettes8CE900Section

    .here

    * = $0CEA00
    .logical $8CEA00

      .dsection BackgroundPalettes8CEA00Section

    .here

    * = $0CEB00
    .logical $8CEB00

      .dsection Unknown8CPalettes8CEB00Section

      .dsection Unsorted8CED00Section

      .dsection Unsorted8CED4FSection

      .dsection Unsorted8CEDD0Section

      .dsection Data8CEEE8Section

      .dsection Unsorted8CF06ASection

    .here

    * = $0D8000
    .logical $8D8000

      .dsection DemoBattlesSection

      .include "events/Chapter10/EventChapter10Opening.asm"
      .include "events/Chapter10/EventChapter10RiddellLeisurelyCharge.asm"
      .include "events/Chapter10/EventChapter10CivilianRescued1.asm"
      .include "events/Chapter10/EventChapter10CivilianRescued2.asm"
      .include "events/Chapter10/EventChapter10CivilianRescued3.asm"
      .include "events/Chapter10/EventChapter10CivilianRescued4.asm"
      .include "events/Chapter10/EventChapter10CivilianRescued5.asm"
      .include "events/Chapter10/EventChapter10CivilianRescued6.asm"
      .include "events/Chapter10/EventChapter10ChronosSeized.asm"
      .include "events/Chapter10/EventChapter10RadosSeized.asm"
      .include "events/Chapter10/EventChapter10MiletosSpawn.asm"
      .include "events/Chapter10/EventChapter10MiletosSeized.asm"
      .include "events/Chapter10/EventChapter10ChalphySpawn.asm"
      .include "events/Chapter10/EventChapter10SeliphPalmarchTalk.asm"
      .include "events/Chapter10/EventChapter10Ending.asm"
      .include "events/Chapter10/EventChapter10JuliusKilledUnit.asm"
      .include "events/Chapter10/EventChapter10IshtarKilledUnit.asm"
      .include "events/Chapter10/EventChapter10JuliusDied.asm"
      .include "events/Chapter10/EventChapter10IshtarDied.asm"
      .include "events/Chapter10/EventChapter10Village1.asm"
      .include "events/Chapter10/EventChapter10Village2.asm"
      .include "events/Chapter10/EventChapter10Village3.asm"
      .include "events/Chapter10/EventChapter10VillageMagicRing.asm"
      .include "events/Chapter10/EventChapter10Village4.asm"
      .include "events/Chapter10/EventChapter10Village5.asm"
      .include "events/Chapter10/EventChapter10HildaDied.asm"
      .include "events/Chapter10/EventChapter10_185.asm"
      .include "events/Chapter10/EventChapter10SeliphAtSea.asm"
      .include "events/Chapter10/EventChapter10_18A.asm"

      dialogueChapter10WorldMap1 .include "text/dialogue/Chapter10/WorldMap1.dialogue.txt" ; 8D8DC4
      dialogueChapter10WorldMap2 .include "text/dialogue/Chapter10/WorldMap2.dialogue.txt" ; 8D8E19

      dialogueEventDebug8D9093 .include "text/dialogue/General/EventDebug8D9093.dialogue.txt" ; 8D9093
      dialogueEventDebug8D90A6 .include "text/dialogue/General/EventDebug8D90A6.dialogue.txt" ; 8D90A6

      dialogueCastleNameMadino .include "text/dialogue/CastleNames/Madino.dialogue.txt"
      dialogueCastleNameSylvale .include "text/dialogue/CastleNames/Sylvale.dialogue.txt"
      dialogueCastleNameInfini .include "text/dialogue/CastleNames/Infini.dialogue.txt"
      dialogueCastleNameAgusti .include "text/dialogue/CastleNames/Agusti.dialogue.txt"
      dialogueCastleNameHeirhein .include "text/dialogue/CastleNames/Heirhein.dialogue.txt"
      dialogueCastleNameMackily .include "text/dialogue/CastleNames/Mackily.dialogue.txt"
      dialogueCastleNameNordion .include "text/dialogue/CastleNames/Nordion.dialogue.txt"
      dialogueCastleNameVelthomer .include "text/dialogue/CastleNames/Velthomer.dialogue.txt"
      dialogueCastleNameFriege .include "text/dialogue/CastleNames/Friege.dialogue.txt"
      dialogueCastleNameBelhalla .include "text/dialogue/CastleNames/Belhalla.dialogue.txt"
      dialogueCastleNameDozel .include "text/dialogue/CastleNames/Dozel.dialogue.txt"
      dialogueCastleNameEdda .include "text/dialogue/CastleNames/Edda.dialogue.txt" ; Unused.
      dialogueCastleNameChalphy .include "text/dialogue/CastleNames/Chalphy.dialogue.txt"
      dialogueCastleNameYngvi .include "text/dialogue/CastleNames/Yngvi.dialogue.txt"
      dialogueCastleNameLeonster .include "text/dialogue/CastleNames/Leonster.dialogue.txt"
      dialogueCastleNameConnacht .include "text/dialogue/CastleNames/Connacht.dialogue.txt"
      dialogueCastleNameMunster .include "text/dialogue/CastleNames/Munster.dialogue.txt"
      dialogueCastleNameMelgen .include "text/dialogue/CastleNames/Melgen.dialogue.txt"
      dialogueCastleNameUlster .include "text/dialogue/CastleNames/Ulster.dialogue.txt"
      dialogueCastleNameOrgahil .include "text/dialogue/CastleNames/Orgahil.dialogue.txt"
      dialogueCastleNameTofa .include "text/dialogue/CastleNames/Tofa.dialogue.txt"
      dialogueCastleNameSailane .include "text/dialogue/CastleNames/Sailane.dialogue.txt"
      dialogueCastleNameZaxon .include "text/dialogue/CastleNames/Zaxon.dialogue.txt"
      dialogueCastleNameSilesse .include "text/dialogue/CastleNames/Silesse.dialogue.txt"
      dialogueCastleNameLubeck .include "text/dialogue/CastleNames/Lubeck.dialogue.txt"
      dialogueCastleNameTirnanog .include "text/dialogue/CastleNames/Tirnanog.dialogue.txt"
      dialogueCastleNameGaneishire .include "text/dialogue/CastleNames/Ganeishire.dialogue.txt"
      dialogueCastleNameSofala .include "text/dialogue/CastleNames/Sofala.dialogue.txt" ; Unused.
      dialogueCastleNameIsaach .include "text/dialogue/CastleNames/Isaach.dialogue.txt" ; Unused.
      dialogueCastleNameRibaut .include "text/dialogue/CastleNames/Ribaut.dialogue.txt"
      dialogueCastleNamePhinora .include "text/dialogue/CastleNames/Phinora.dialogue.txt"
      dialogueCastleNameAed .include "text/dialogue/CastleNames/Aed.dialogue.txt"
      dialogueCastleNameDahna .include "text/dialogue/CastleNames/Dahna.dialogue.txt"
      dialogueCastleNameVerdane .include "text/dialogue/CastleNames/Verdane.dialogue.txt"
      dialogueCastleNameEvans .include "text/dialogue/CastleNames/Evans.dialogue.txt"
      dialogueCastleNameGenoa .include "text/dialogue/CastleNames/Genoa.dialogue.txt"
      dialogueCastleNameMarpha .include "text/dialogue/CastleNames/Marpha.dialogue.txt"
      dialogueCastleNameMiletos .include "text/dialogue/CastleNames/Miletos.dialogue.txt"
      dialogueCastleNamePeruluke .include "text/dialogue/CastleNames/Peruluke.dialogue.txt"
      dialogueCastleNameChronos .include "text/dialogue/CastleNames/Chronos.dialogue.txt"
      dialogueCastleNameRados .include "text/dialogue/CastleNames/Rados.dialogue.txt"
      dialogueCastleNameMeath .include "text/dialogue/CastleNames/Meath.dialogue.txt"
      dialogueCastleNameKapathogia .include "text/dialogue/CastleNames/Kapathogia.dialogue.txt"
      dialogueCastleNameLuthecia .include "text/dialogue/CastleNames/Luthecia.dialogue.txt"
      dialogueCastleNameThracia .include "text/dialogue/CastleNames/Thracia.dialogue.txt"
      dialogueCastleNameGrutia .include "text/dialogue/CastleNames/Grutia.dialogue.txt"

      aDialogueCharacterNames .binclude "data/dialogue/DialogueCharacterNames.csv.asm"

      dialogueCharacterNameSigurd .include "text/dialogue/CharacterNames/Sigurd.dialogue.txt" ; 8D928B
      dialogueCharacterNameNaoise .include "text/dialogue/CharacterNames/Naoise.dialogue.txt" ; 8D9291
      dialogueCharacterNameAlec .include "text/dialogue/CharacterNames/Alec.dialogue.txt" ; 8D9298
      dialogueCharacterNameArden .include "text/dialogue/CharacterNames/Arden.dialogue.txt" ; 8D929D
      dialogueCharacterNameFinn .include "text/dialogue/CharacterNames/Finn.dialogue.txt" ; 8D92A3
      dialogueCharacterNameQuan .include "text/dialogue/CharacterNames/Quan.dialogue.txt" ; 8D92A8
      dialogueCharacterNameMidir .include "text/dialogue/CharacterNames/Midir.dialogue.txt" ; 8D92AE
      dialogueCharacterNameLewyn .include "text/dialogue/CharacterNames/Lewyn.dialogue.txt" ; 8D92B5
      dialogueCharacterNameChulainn .include "text/dialogue/CharacterNames/Chulainn.dialogue.txt" ; 8D92BB
      dialogueCharacterNameAzelle .include "text/dialogue/CharacterNames/Azelle.dialogue.txt" ; 8D92C0
      dialogueCharacterNameJamke .include "text/dialogue/CharacterNames/Jamke.dialogue.txt" ; 8D92C5
      dialogueCharacterNameClaud .include "text/dialogue/CharacterNames/Claud.dialogue.txt" ; 8D92CB
      dialogueCharacterNameBeowulf .include "text/dialogue/CharacterNames/Beowulf.dialogue.txt" ; 8D92D1
      dialogueCharacterNameLex .include "text/dialogue/CharacterNames/Lex.dialogue.txt" ; 8D92DB
      dialogueCharacterNameDew .include "text/dialogue/CharacterNames/Dew.dialogue.txt" ; 8D92E1
      dialogueCharacterNameDeirdre .include "text/dialogue/CharacterNames/Deirdre.dialogue.txt" ; 8D92E6
      dialogueCharacterNameEthlyn .include "text/dialogue/CharacterNames/Ethlyn.dialogue.txt" ; 8D92ED
      dialogueCharacterNameLachesis .include "text/dialogue/CharacterNames/Lachesis.dialogue.txt" ; 8D92F3
      dialogueCharacterNameAyra .include "text/dialogue/CharacterNames/Ayra.dialogue.txt" ; 8D92F9
      dialogueCharacterNameErinys .include "text/dialogue/CharacterNames/Erinys.dialogue.txt" ; 8D92FE
      dialogueCharacterNameTailtiu .include "text/dialogue/CharacterNames/Tailtiu.dialogue.txt" ; 8D9304
      dialogueCharacterNameSilvia .include "text/dialogue/CharacterNames/Silvia.dialogue.txt" ; 8D930B
      dialogueCharacterNameEdain .include "text/dialogue/CharacterNames/Edain.dialogue.txt" ; 8D9312
      dialogueCharacterNameBrigid .include "text/dialogue/CharacterNames/Brigid.dialogue.txt" ; 8D9319
      dialogueCharacterNameSeliph .include "text/dialogue/CharacterNames/Seliph.dialogue.txt" ; 8D9320
      dialogueCharacterNameShannan .include "text/dialogue/CharacterNames/Shannan.dialogue.txt" ; 8D9325
      dialogueCharacterNameDalvin .include "text/dialogue/CharacterNames/Dalvin.dialogue.txt" ; 8D932B
      dialogueCharacterNameAsaello .include "text/dialogue/CharacterNames/Asaello.dialogue.txt" ; 8D9332
      dialogueCharacterNameLeif .include "text/dialogue/CharacterNames/Leif.dialogue.txt" ; 8D9338
      dialogueCharacterNameIuchar .include "text/dialogue/CharacterNames/Iuchar.dialogue.txt" ; 8D933D
      dialogueCharacterNameCharlot .include "text/dialogue/CharacterNames/Charlot.dialogue.txt" ; 8D9342
      dialogueCharacterNameHawk .include "text/dialogue/CharacterNames/Hawk.dialogue.txt" ; 8D9349
      dialogueCharacterNameTristan .include "text/dialogue/CharacterNames/Tristan.dialogue.txt" ; 8D934E
      dialogueCharacterNameAdultFinn .include "text/dialogue/CharacterNames/AdultFinn.dialogue.txt" ; 8D9355
      dialogueCharacterNameDeimne .include "text/dialogue/CharacterNames/Deimne.dialogue.txt" ; 8D935A
      dialogueCharacterNameHannibal .include "text/dialogue/CharacterNames/Hannibal.dialogue.txt" ; 8D9360
      dialogueCharacterNameAres .include "text/dialogue/CharacterNames/Ares.dialogue.txt" ; 8D9367
      dialogueCharacterNameAmid .include "text/dialogue/CharacterNames/Amid.dialogue.txt" ; 8D936C
      dialogueCharacterNameOifey .include "text/dialogue/CharacterNames/Oifey.dialogue.txt" ; 8D9375
      dialogueCharacterNameDaisy .include "text/dialogue/CharacterNames/Daisy.dialogue.txt" ; 8D937B
      dialogueCharacterNameCreidne .include "text/dialogue/CharacterNames/Creidne.dialogue.txt" ; 8D9381
      dialogueCharacterNameMuirne .include "text/dialogue/CharacterNames/Muirne.dialogue.txt" ; 8D9387
      dialogueCharacterNameJulia .include "text/dialogue/CharacterNames/Julia.dialogue.txt" ; 8D938B
      dialogueCharacterNameAltena .include "text/dialogue/CharacterNames/Altena.dialogue.txt" ; 8D9390
      dialogueCharacterNameHermina .include "text/dialogue/CharacterNames/Hermina.dialogue.txt" ; 8D9396
      dialogueCharacterNameLinda .include "text/dialogue/CharacterNames/Linda.dialogue.txt" ; 8D939C
      dialogueCharacterNameLaylea .include "text/dialogue/CharacterNames/Laylea.dialogue.txt" ; 8D93A1
      dialogueCharacterNameJeanne .include "text/dialogue/CharacterNames/Jeanne.dialogue.txt" ; 8D93A7
      dialogueCharacterNameScathach .include "text/dialogue/CharacterNames/Scathach.dialogue.txt" ; 8D93AD
      dialogueCharacterNameFebail .include "text/dialogue/CharacterNames/Febail.dialogue.txt" ; 8D93B4
      dialogueCharacterNameIucharba .include "text/dialogue/CharacterNames/Iucharba.dialogue.txt" ; 8D93BA
      dialogueCharacterNameCoirpre .include "text/dialogue/CharacterNames/Coirpre.dialogue.txt" ; 8D93C0
      dialogueCharacterNameCed .include "text/dialogue/CharacterNames/Ced.dialogue.txt" ; 8D93C6
      dialogueCharacterNameDiarmuid .include "text/dialogue/CharacterNames/Diarmuid.dialogue.txt" ; 8D93CB
      dialogueCharacterNameLester .include "text/dialogue/CharacterNames/Lester.dialogue.txt" ; 8D93D2
      dialogueCharacterNameArthur .include "text/dialogue/CharacterNames/Arthur.dialogue.txt" ; 8D93D8
      dialogueCharacterNamePatty .include "text/dialogue/CharacterNames/Patty.dialogue.txt" ; 8D93DE
      dialogueCharacterNameLarcei .include "text/dialogue/CharacterNames/Larcei.dialogue.txt" ; 8D93E3
      dialogueCharacterNameLana .include "text/dialogue/CharacterNames/Lana.dialogue.txt" ; 8D93E9
      dialogueCharacterNameFee .include "text/dialogue/CharacterNames/Fee.dialogue.txt" ; 8D93ED
      dialogueCharacterNameTine .include "text/dialogue/CharacterNames/Tine.dialogue.txt" ; 8D93F2
      dialogueCharacterNameLene .include "text/dialogue/CharacterNames/Lene.dialogue.txt" ; 8D93F8
      dialogueCharacterNameNanna .include "text/dialogue/CharacterNames/Nanna.dialogue.txt" ; 8D93FD

      aDialogueItemNames .binclude "data/dialogue/DialogueItemNames.csv.asm"

      dialogueItemNameIronSword .include "text/dialogue/ItemNames/IronSword.dialogue.txt" ; 8D9514
      dialogueItemNameSteelSword .include "text/dialogue/ItemNames/SteelSword.dialogue.txt" ; 8D951B
      dialogueItemNameSilverSword .include "text/dialogue/ItemNames/SilverSword.dialogue.txt" ; 8D9523
      dialogueItemNameIronBlade .include "text/dialogue/ItemNames/IronBlade.dialogue.txt" ; 8D952A
      dialogueItemNameSteelBlade .include "text/dialogue/ItemNames/SteelBlade.dialogue.txt" ; 8D9532
      dialogueItemNameSilverBlade .include "text/dialogue/ItemNames/SilverBlade.dialogue.txt" ; 8D953B
      dialogueItemNameMiracleSword .include "text/dialogue/ItemNames/MiracleSword.dialogue.txt" ; 8D9543
      dialogueItemNameThiefSword .include "text/dialogue/ItemNames/ThiefSword.dialogue.txt" ; 8D954B
      dialogueItemNameBarrierBlade .include "text/dialogue/ItemNames/BarrierBlade.dialogue.txt" ; 8D9554
      dialogueItemNameBerserkSword .include "text/dialogue/ItemNames/BerserkSword.dialogue.txt" ; 8D955C
      dialogueItemNameBraveSword .include "text/dialogue/ItemNames/BraveSword.dialogue.txt" ; 8D9565
      dialogueItemNameSilenceSword .include "text/dialogue/ItemNames/SilenceSword.dialogue.txt" ; 8D956E
      dialogueItemNameSleepSword .include "text/dialogue/ItemNames/SleepSword.dialogue.txt" ; 8D957A
      dialogueItemNameSlimSword .include "text/dialogue/ItemNames/SlimSword.dialogue.txt" ; 8D9583
      dialogueItemNameSafeguard .include "text/dialogue/ItemNames/Safeguard.dialogue.txt" ; 8D958B
      dialogueItemNameFireSword .include "text/dialogue/ItemNames/FireSword.dialogue.txt" ; 8D9593
      dialogueItemNameEarthSword .include "text/dialogue/ItemNames/EarthSword.dialogue.txt" ; 8D959B
      dialogueItemNameThunderSword .include "text/dialogue/ItemNames/ThunderSword.dialogue.txt" ; 8D95A3
      dialogueItemNameWindSword .include "text/dialogue/ItemNames/WindSword.dialogue.txt" ; 8D95AC
      dialogueItemNameLightBrand .include "text/dialogue/ItemNames/LightBrand.dialogue.txt" ; 8D95B3
      dialogueItemNameMystletainn .include "text/dialogue/ItemNames/Mystletainn.dialogue.txt" ; 8D95BE
      dialogueItemNameTyrfing .include "text/dialogue/ItemNames/Tyrfing.dialogue.txt" ; 8D95C7
      dialogueItemNameBalmung .include "text/dialogue/ItemNames/Balmung.dialogue.txt" ; 8D95D0
      dialogueItemNameArmorslayer .include "text/dialogue/ItemNames/Armorslayer.dialogue.txt" ; 8D95D7
      dialogueItemNameWingclipper .include "text/dialogue/ItemNames/Wingclipper.dialogue.txt" ; 8D95E0
      dialogueItemNameBrokenSword .include "text/dialogue/ItemNames/BrokenSword.dialogue.txt" ; 8D95E8
      dialogueItemNameIronLance .include "text/dialogue/ItemNames/IronLance.dialogue.txt" ; 8D95F0
      dialogueItemNameSteelLance .include "text/dialogue/ItemNames/SteelLance.dialogue.txt" ; 8D95F7
      dialogueItemNameSilverLance .include "text/dialogue/ItemNames/SilverLance.dialogue.txt" ; 8D95FF
      dialogueItemNameJavelin .include "text/dialogue/ItemNames/Javelin.dialogue.txt" ; 8D9606
      dialogueItemNameRidersbane .include "text/dialogue/ItemNames/Ridersbane.dialogue.txt" ; 8D960B
      dialogueItemNameBraveLance .include "text/dialogue/ItemNames/BraveLance.dialogue.txt" ; 8D9613
      dialogueItemNameSlimLance .include "text/dialogue/ItemNames/SlimLance.dialogue.txt" ; 8D961C
      dialogueItemNameGungnir .include "text/dialogue/ItemNames/Gungnir.dialogue.txt" ; 8D9624
      dialogueItemNameGaeBolg .include "text/dialogue/ItemNames/GaeBolg.dialogue.txt" ; 8D962B
      dialogueItemNameBrokenLance .include "text/dialogue/ItemNames/BrokenLance.dialogue.txt" ; 8D9632
      dialogueItemNameIronAxe .include "text/dialogue/ItemNames/IronAxe.dialogue.txt" ; 8D963A
      dialogueItemNameSteelAxe .include "text/dialogue/ItemNames/SteelAxe.dialogue.txt" ; 8D9641
      dialogueItemNameSilverAxe .include "text/dialogue/ItemNames/SilverAxe.dialogue.txt" ; 8D9649
      dialogueItemNameBraveAxe .include "text/dialogue/ItemNames/BraveAxe.dialogue.txt" ; 8D9650
      dialogueItemNameHelswath .include "text/dialogue/ItemNames/Helswath.dialogue.txt" ; 8D9659
      dialogueItemNameHandAxe .include "text/dialogue/ItemNames/HandAxe.dialogue.txt" ; 8D9660
      dialogueItemNameBrokenAxe .include "text/dialogue/ItemNames/BrokenAxe.dialogue.txt" ; 8D9665
      dialogueItemNameIronBow .include "text/dialogue/ItemNames/IronBow.dialogue.txt" ; 8D966D
      dialogueItemNameSteelBow .include "text/dialogue/ItemNames/SteelBow.dialogue.txt" ; 8D9674
      dialogueItemNameSilverBow .include "text/dialogue/ItemNames/SilverBow.dialogue.txt" ; 8D967C
      dialogueItemNameBraveBow .include "text/dialogue/ItemNames/BraveBow.dialogue.txt" ; 8D9683
      dialogueItemNameKillerBow .include "text/dialogue/ItemNames/KillerBow.dialogue.txt" ; 8D968C
      dialogueItemNameYewfelle .include "text/dialogue/ItemNames/Yewfelle.dialogue.txt" ; 8D9693
      dialogueItemNameBrokenBow .include "text/dialogue/ItemNames/BrokenBow.dialogue.txt" ; 8D969A
      dialogueItemNameBallista .include "text/dialogue/ItemNames/Ballista.dialogue.txt" ; 8D96A2
      dialogueItemNameIronBallista .include "text/dialogue/ItemNames/IronBallista.dialogue.txt" ; 8D96AA
      dialogueItemNameKillerBallista .include "text/dialogue/ItemNames/KillerBallista.dialogue.txt" ; 8D96B3
      dialogueItemNameGreatBallista .include "text/dialogue/ItemNames/GreatBallista.dialogue.txt" ; 8D96BB
      dialogueItemNameFire .include "text/dialogue/ItemNames/Fire.dialogue.txt" ; 8D96C4
      dialogueItemNameElfire .include "text/dialogue/ItemNames/Elfire.dialogue.txt" ; 8D96CB
      dialogueItemNameBolganone .include "text/dialogue/ItemNames/Bolganone.dialogue.txt" ; 8D96D4
      dialogueItemNameValflame .include "text/dialogue/ItemNames/Valflame.dialogue.txt" ; 8D96DB
      dialogueItemNameMeteor .include "text/dialogue/ItemNames/Meteor.dialogue.txt" ; 8D96E4
      dialogueItemNameThunder .include "text/dialogue/ItemNames/Thunder.dialogue.txt" ; 8D96EA
      dialogueItemNameElthunder .include "text/dialogue/ItemNames/Elthunder.dialogue.txt" ; 8D96F3
      dialogueItemNameThoron .include "text/dialogue/ItemNames/Thoron.dialogue.txt" ; 8D96FE
      dialogueItemNameMjolnir .include "text/dialogue/ItemNames/Mjolnir.dialogue.txt" ; 8D9704
      dialogueItemNameBolting .include "text/dialogue/ItemNames/Bolting.dialogue.txt" ; 8D970D
      dialogueItemNameWind .include "text/dialogue/ItemNames/Wind.dialogue.txt" ; 8D9716
      dialogueItemNameElwind .include "text/dialogue/ItemNames/Elwind.dialogue.txt" ; 8D971C
      dialogueItemNameTornado .include "text/dialogue/ItemNames/Tornado.dialogue.txt" ; 8D9724
      dialogueItemNameForseti .include "text/dialogue/ItemNames/Forseti.dialogue.txt" ; 8D972B
      dialogueItemNameBlizzard .include "text/dialogue/ItemNames/Blizzard.dialogue.txt" ; 8D9733
      dialogueItemNameLight .include "text/dialogue/ItemNames/Light.dialogue.txt" ; 8D973A
      dialogueItemNameNosferatu .include "text/dialogue/ItemNames/Nosferatu.dialogue.txt" ; 8D9742
      dialogueItemNameAura .include "text/dialogue/ItemNames/Aura.dialogue.txt" ; 8D9748
      dialogueItemNameNaga .include "text/dialogue/ItemNames/Naga.dialogue.txt" ; 8D974D
      dialogueItemNameJormungandr .include "text/dialogue/ItemNames/Jormungandr.dialogue.txt" ; 8D9752
      dialogueItemNameFenrir .include "text/dialogue/ItemNames/Fenrir.dialogue.txt" ; 8D975B
      dialogueItemNameHel .include "text/dialogue/ItemNames/Hel.dialogue.txt" ; 8D9762
      dialogueItemNameLoptous .include "text/dialogue/ItemNames/Loptous.dialogue.txt" ; 8D9766
      dialogueItemNameBrokenTome .include "text/dialogue/ItemNames/BrokenTome.dialogue.txt" ; 8D976D
      dialogueItemNameHealStaff .include "text/dialogue/ItemNames/HealStaff.dialogue.txt" ; 8D9777
      dialogueItemNameMendStaff .include "text/dialogue/ItemNames/MendStaff.dialogue.txt" ; 8D977F
      dialogueItemNameRecoverStaff .include "text/dialogue/ItemNames/RecoverStaff.dialogue.txt" ; 8D9788
      dialogueItemNamePhysicStaff .include "text/dialogue/ItemNames/PhysicStaff.dialogue.txt" ; 8D9791
      dialogueItemNameFortify .include "text/dialogue/ItemNames/Fortify.dialogue.txt" ; 8D979A
      dialogueItemNameReturnStaff .include "text/dialogue/ItemNames/ReturnStaff.dialogue.txt" ; 8D97A3
      dialogueItemNameWarpStaff .include "text/dialogue/ItemNames/WarpStaff.dialogue.txt" ; 8D97AC
      dialogueItemNameRescueStaff .include "text/dialogue/ItemNames/RescueStaff.dialogue.txt" ; 8D97B4
      dialogueItemNameCharmStaff .include "text/dialogue/ItemNames/CharmStaff.dialogue.txt" ; 8D97BE
      dialogueItemNameRestoreStaff .include "text/dialogue/ItemNames/RestoreStaff.dialogue.txt" ; 8D97C7
      dialogueItemNameValkyrieStaff .include "text/dialogue/ItemNames/ValkyrieStaff.dialogue.txt" ; 8D97CF
      dialogueItemNameSilenceStaff .include "text/dialogue/ItemNames/SilenceStaff.dialogue.txt" ; 8D97D9
      dialogueItemNameSleepStaff .include "text/dialogue/ItemNames/SleepStaff.dialogue.txt" ; 8D97E5
      dialogueItemNameBerserkStaff .include "text/dialogue/ItemNames/BerserkStaff.dialogue.txt" ; 8D97EE
      dialogueItemNameThiefStaff .include "text/dialogue/ItemNames/ThiefStaff.dialogue.txt" ; 8D97F7
      dialogueItemNameBrokenStaff .include "text/dialogue/ItemNames/BrokenStaff.dialogue.txt" ; 8D97FF
      dialogueItemNameRenewalBand .include "text/dialogue/ItemNames/RenewalBand.dialogue.txt" ; 8D9807
      dialogueItemNameParagonBand .include "text/dialogue/ItemNames/ParagonBand.dialogue.txt" ; 8D9810
      dialogueItemNameThiefBand .include "text/dialogue/ItemNames/ThiefBand.dialogue.txt" ; 8D9819
      dialogueItemNameMiracleBand .include "text/dialogue/ItemNames/MiracleBand.dialogue.txt" ; 8D9822
      dialogueItemNamePursuitRing .include "text/dialogue/ItemNames/PursuitRing.dialogue.txt" ; 8D982B
      dialogueItemNameRecoverRing .include "text/dialogue/ItemNames/RecoverRing.dialogue.txt" ; 8D9834
      dialogueItemNameBargainBand .include "text/dialogue/ItemNames/BargainBand.dialogue.txt" ; 8D983D
      dialogueItemNameKnightRing .include "text/dialogue/ItemNames/KnightRing.dialogue.txt" ; 8D9846
      dialogueItemNameReturnBand .include "text/dialogue/ItemNames/ReturnBand.dialogue.txt" ; 8D984E
      dialogueItemNameSpeedRing .include "text/dialogue/ItemNames/SpeedRing.dialogue.txt" ; 8D9857
      dialogueItemNameMagicRing .include "text/dialogue/ItemNames/MagicRing.dialogue.txt" ; 8D9860
      dialogueItemNamePowerRing .include "text/dialogue/ItemNames/PowerRing.dialogue.txt" ; 8D9869
      dialogueItemNameShieldRing .include "text/dialogue/ItemNames/ShieldRing.dialogue.txt" ; 8D9871
      dialogueItemNameBarrierRing .include "text/dialogue/ItemNames/BarrierRing.dialogue.txt" ; 8D987A
      dialogueItemNameLegRing .include "text/dialogue/ItemNames/LegRing.dialogue.txt" ; 8D9882
      dialogueItemNameSkillRing .include "text/dialogue/ItemNames/SkillRing.dialogue.txt" ; 8D988A

      aDialogueClassNames .binclude "data/dialogue/DialogueClassNames.csv.asm"

      dialogueClassNameCavalier .include "text/dialogue/ClassNames/Cavalier.dialogue.txt" ; 8D9922
      dialogueClassNameLanceKnight .include "text/dialogue/ClassNames/LanceKnight.dialogue.txt" ; 8D992B
      dialogueClassNameBowKnight .include "text/dialogue/ClassNames/BowKnight.dialogue.txt" ; 8D9933
      dialogueClassNameAxeKnight .include "text/dialogue/ClassNames/AxeKnight.dialogue.txt" ; 8D993B
      dialogueClassNameFreeKnight .include "text/dialogue/ClassNames/FreeKnight.dialogue.txt" ; 8D9943
      dialogueClassNameTroubadour .include "text/dialogue/ClassNames/Troubadour.dialogue.txt" ; 8D994B
      dialogueClassNameKnightLord .include "text/dialogue/ClassNames/KnightLord.dialogue.txt" ; 8D9953
      dialogueClassNameDukeKnight .include "text/dialogue/ClassNames/DukeKnight.dialogue.txt" ; 8D995B
      dialogueClassNameMasterKnight .include "text/dialogue/ClassNames/MasterKnight.dialogue.txt" ; 8D9964
      dialogueClassNamePaladin .include "text/dialogue/ClassNames/Paladin.dialogue.txt" ; 8D996D
      dialogueClassNameArchKnight .include "text/dialogue/ClassNames/ArchKnight.dialogue.txt" ; 8D9974
      dialogueClassNameRanger .include "text/dialogue/ClassNames/Ranger.dialogue.txt" ; 8D997B
      dialogueClassNameMageKnight .include "text/dialogue/ClassNames/MageKnight.dialogue.txt" ; 8D9985
      dialogueClassNameGreatKnight .include "text/dialogue/ClassNames/GreatKnight.dialogue.txt" ; 8D998D
      dialogueClassNamePegasusRider .include "text/dialogue/ClassNames/PegasusRider.dialogue.txt" ; 8D9996
      dialogueClassNamePegasusKnight .include "text/dialogue/ClassNames/PegasusKnight.dialogue.txt" ; 8D99A0
      dialogueClassNameFalconKnight .include "text/dialogue/ClassNames/FalconKnight.dialogue.txt" ; 8D99A9
      dialogueClassNameDragonrider .include "text/dialogue/ClassNames/Dragonrider.dialogue.txt" ; 8D99B3
      dialogueClassNameDragonknight .include "text/dialogue/ClassNames/Dragonknight.dialogue.txt" ; 8D99BD
      dialogueClassNameDragonmaster .include "text/dialogue/ClassNames/Dragonmaster.dialogue.txt" ; 8D99C6
      dialogueClassNameArcher .include "text/dialogue/ClassNames/Archer.dialogue.txt" ; 8D99D0
      dialogueClassNameMyrmidon .include "text/dialogue/ClassNames/Myrmidon.dialogue.txt" ; 8D99D9
      dialogueClassNameSwordmaster .include "text/dialogue/ClassNames/Swordmaster.dialogue.txt" ; 8D99E3
      dialogueClassNameSniper .include "text/dialogue/ClassNames/Sniper.dialogue.txt" ; 8D99EC
      dialogueClassNameHero .include "text/dialogue/ClassNames/Hero.dialogue.txt" ; 8D99F3
      dialogueClassNameGeneral .include "text/dialogue/ClassNames/General.dialogue.txt" ; 8D99FB
      dialogueClassNameEmperor .include "text/dialogue/ClassNames/Emperor.dialogue.txt" ; 8D9A02
      dialogueClassNameBaron .include "text/dialogue/ClassNames/Baron.dialogue.txt" ; 8D9A09
      dialogueClassNameSoldier .include "text/dialogue/ClassNames/Soldier.dialogue.txt" ; 8D9A0E
      dialogueClassNameSpearSoldier .include "text/dialogue/ClassNames/SpearSoldier.dialogue.txt" ; 8D9A15
      dialogueClassNameAxeSoldier .include "text/dialogue/ClassNames/AxeSoldier.dialogue.txt" ; 8D9A1F
      dialogueClassNameBowSoldier .include "text/dialogue/ClassNames/BowSoldier.dialogue.txt" ; 8D9A29
      dialogueClassNameSwordSoldier .include "text/dialogue/ClassNames/SwordSoldier.dialogue.txt" ; 8D9A30
      dialogueClassNameLanceArmor .include "text/dialogue/ClassNames/LanceArmor.dialogue.txt" ; 8D9A3A
      dialogueClassNameAxeArmor .include "text/dialogue/ClassNames/AxeArmor.dialogue.txt" ; 8D9A40
      dialogueClassNameBowArmor .include "text/dialogue/ClassNames/BowArmor.dialogue.txt" ; 8D9A49
      dialogueClassNameSwordArmor .include "text/dialogue/ClassNames/SwordArmor.dialogue.txt" ; 8D9A51
      dialogueClassNameBarbarian .include "text/dialogue/ClassNames/Barbarian.dialogue.txt" ; 8D9A5A
      dialogueClassNameFighter .include "text/dialogue/ClassNames/Fighter.dialogue.txt" ; 8D9A62
      dialogueClassNameBrigand .include "text/dialogue/ClassNames/Brigand.dialogue.txt" ; 8D9A6C
      dialogueClassNameWarrior .include "text/dialogue/ClassNames/Warrior.dialogue.txt" ; 8D9A76
      dialogueClassNameHunter .include "text/dialogue/ClassNames/Hunter.dialogue.txt" ; 8D9A7D
      dialogueClassNamePirate .include "text/dialogue/ClassNames/Pirate.dialogue.txt" ; 8D9A83
      dialogueClassNameJuniorLord .include "text/dialogue/ClassNames/JuniorLord.dialogue.txt" ; 8D9A8A
      dialogueClassNameWarMage .include "text/dialogue/ClassNames/WarMage.dialogue.txt" ; 8D9A93
      dialogueClassNamePrince .include "text/dialogue/ClassNames/Prince.dialogue.txt" ; 8D9A9D
      dialogueClassNamePrincess .include "text/dialogue/ClassNames/Princess.dialogue.txt" ; 8D9AA3
      dialogueClassNameWarMageF .include "text/dialogue/ClassNames/WarMageF.dialogue.txt" ; 8D9AAA
      dialogueClassNameQueen .include "text/dialogue/ClassNames/Queen.dialogue.txt" ; 8D9AB4
      dialogueClassNameDancer .include "text/dialogue/ClassNames/Dancer.dialogue.txt" ; 8D9ABA
      dialogueClassNamePriest .include "text/dialogue/ClassNames/Priest.dialogue.txt" ; 8D9AC3
      dialogueClassNameMage .include "text/dialogue/ClassNames/Mage.dialogue.txt" ; 8D9ACA
      dialogueClassNameFireMage .include "text/dialogue/ClassNames/FireMage.dialogue.txt" ; 8D9ACF
      dialogueClassNameThunderMage .include "text/dialogue/ClassNames/ThunderMage.dialogue.txt" ; 8D9AD8
      dialogueClassNameWindMage .include "text/dialogue/ClassNames/WindMage.dialogue.txt" ; 8D9AE4
      dialogueClassNameHighPriest .include "text/dialogue/ClassNames/HighPriest.dialogue.txt" ; 8D9AED
      dialogueClassNameBishop .include "text/dialogue/ClassNames/Bishop.dialogue.txt" ; 8D9AF6
      dialogueClassNameSage .include "text/dialogue/ClassNames/Sage.dialogue.txt" ; 8D9AFD
      dialogueClassNameBard .include "text/dialogue/ClassNames/Bard.dialogue.txt" ; 8D9B02
      dialogueClassNamePriestess .include "text/dialogue/ClassNames/Priestess.dialogue.txt" ; 8D9B07
      dialogueClassNameDarkMage .include "text/dialogue/ClassNames/DarkMage.dialogue.txt" ; 8D9B0E
      dialogueClassNameDarkBishop .include "text/dialogue/ClassNames/DarkBishop.dialogue.txt" ; 8D9B16
      dialogueClassNameThief .include "text/dialogue/ClassNames/Thief.dialogue.txt" ; 8D9B1D
      dialogueClassNameRogue .include "text/dialogue/ClassNames/Rogue.dialogue.txt" ; 8D9B22
      dialogueClassNameCivilian .include "text/dialogue/ClassNames/Civilian.dialogue.txt" ; 8D9B2C
      dialogueClassNameChild .include "text/dialogue/ClassNames/Child.dialogue.txt" ; 8D9B33
      dialogueClassNameBallistician .include "text/dialogue/ClassNames/Ballistician.dialogue.txt" ; 8D9B3A
      dialogueClassNameIronBallistician .include "text/dialogue/ClassNames/IronBallistician.dialogue.txt" ; 8D9B42
      dialogueClassNameKillerBallistician .include "text/dialogue/ClassNames/KillerBallistician.dialogue.txt" ; 8D9B4B
      dialogueClassNameGreatBallistician .include "text/dialogue/ClassNames/GreatBallistician.dialogue.txt" ; 8D9B53
      dialogueClassNameDarkPrince .include "text/dialogue/ClassNames/DarkPrince.dialogue.txt" ; 8D9B5C

      ; 8d9b65

      .dsection Table8D9B65Section
      .dsection Table8D9BF6Section

      dialogueGen1HomeCastleSeized .include "text/dialogue/General/Gen1HomeCastleSeized.dialogue.txt" ; 8D9FB1
      dialogueGen2HomeCastleSeized .include "text/dialogue/General/Gen2HomeCastleSeized.dialogue.txt" ; 8D9FED
      dialogueSigurdDeathReaction .include "text/dialogue/General/SigurdDeathReaction.dialogue.txt" ; 8DA022
      dialogueSeliphDeathReaction .include "text/dialogue/General/SeliphDeathReaction.dialogue.txt" ; 8DA047

      ; 8da06a

      .dsection Unsorted8DA06ASection

      .dsection Unsorted8DA0C6Section

      .dsection Unsorted8DA288Section

      .dsection Unsorted8DA2AASection
      .dsection Unsorted8DA34DSection

      .dsection Unsorted8DA372Section

      .dsection Unsorted8DA3DESection

      .dsection Unsorted8DA449Section

      .dsection Unsorted8DA4B3Section

      .dsection Table8DA502Section

      .dsection Unsorted8DA50FSection

    .here

    * = $0DA624
    .logical $8DA624

      .dsection Unsorted8DA624Section

      .dsection Data8DA737Section

      .dsection Unsorted8DA755Section

      .dsection Unsorted8DA810Section

      .dsection Unsorted8DAA96Section

      .dsection Unsorted8DAA9ESection

      .dsection Unsorted8DAAFBSection

    .here

    * = $0DAD73
    .logical $8DAD73

      .dsection Unsorted8DAD73Section

      .dsection Unsorted8DAD9ESection

      .dsection Table8DADFASection

      .dsection Unsorted8DAE85Section

    .here

    * = $0DAEC2
    .logical $8DAEC2

      .dsection Unsorted8DAEC2Section
      .dsection Unsorted8DAF33Section

      ; Entries for rlHandleMapMenuDecompressionDMA.
      aDecompressionDMAEntry8DAF95 .structDecompressionDMAEntry gcUnknownD35EB4, $3000, $0000 ; 8D/AF95
      aDecompressionDMAEntry8DAF9D .structDecompressionDMAEntry gcUnknownD421EE, $0800, $5800 ; 8D/AF9D

      .dsection Unsorted8DAFA5Section

      ; Entries for rlHandleMapMenuDecompressionDMA.
      aDecompressionDMAEntry8DB056 .structDecompressionDMAEntry gcUnknownD429F6, $0800, $5800 ; 8D/B056
      aDecompressionDMAEntry8DB05E .structDecompressionDMAEntry gcUnknownD428B8, $0800, $6800 ; 8D/B05E
      aDecompressionDMAEntry8DB066 .structDecompressionDMAEntry gcUnknownD42273, $1000, $4000 ; 8D/B066

      .dsection Unsorted8DB06ESection
      .dsection Unsorted8DB150Section
      .dsection Unsorted8DB1DDSection
      .dsection Unsorted8DB217Section
      .dsection Unsorted8DB252Section
      .dsection Unsorted8DB276Section

      .dsection Unsorted8DB2B8Section

      .dsection Unsorted8DB4F1Section

      .dsection Unsorted8DB4F6Section

    .here

    * = $0DB53A
    .logical $8DB53A

      .dsection Unsorted8DB53ASection

      .dsection Data8DB5C8Section

      .dsection EpilogueDialogueWorldMapCodeSection

      .dsection Table8DC964Section

      .dsection Data8DCF88Section

      .dsection Unsorted8DD041Section

      dialogueChapterEpilogueWorldMapSilesse .include "text/dialogue/EpilogueWorldMap/WorldMapSilesse.dialogue.txt" ; 8DDCA7
      dialogueChapterEpilogueWorldMap_Silesse_NoInheritors .include "text/dialogue/EpilogueWorldMap/WorldMap_Silesse_NoInheritors.dialogue.txt" ; 8DDCB3
      dialogueChapterEpilogueWorldMap_Silesse_Inherited .include "text/dialogue/EpilogueWorldMap/WorldMap_Silesse_Inherited.dialogue.txt" ; 8DDE0C
      dialogueChapterEpilogueWorldMap_Silesse_Piece_Start .include "text/dialogue/EpilogueWorldMap/WorldMap_Silesse_Piece_Start.dialogue.txt" ; 8DDEE5
      dialogueChapterEpilogueWorldMap_Silesse_Piece_End .include "text/dialogue/EpilogueWorldMap/WorldMap_Silesse_Piece_End.dialogue.txt" ; 8DDEF0
      dialogueChapterEpilogueWorldMap_Silesse_Piece_RulerNoLover .include "text/dialogue/EpilogueWorldMap/WorldMap_Silesse_Piece_RulerNoLover.dialogue.txt" ; 8DDF0B
      dialogueChapterEpilogueWorldMap_Silesse_Piece_RulersLover .include "text/dialogue/EpilogueWorldMap/WorldMap_Silesse_Piece_RulersLover.dialogue.txt" ; 8DDF15
      dialogueChapterEpilogueWorldMap_Silesse_Piece_RulersSister .include "text/dialogue/EpilogueWorldMap/WorldMap_Silesse_Piece_RulersSister.dialogue.txt" ; 8DDF36
      dialogueChapterEpilogueWorldMap_Silesse_Piece_CedHawk .include "text/dialogue/EpilogueWorldMap/WorldMap_Silesse_Piece_CedHawk.dialogue.txt" ; 8DDF4E
      dialogueChapterEpilogueWorldMap_Silesse_Piece_CedHawksLover .include "text/dialogue/EpilogueWorldMap/WorldMap_Silesse_Piece_CedHawksLover.dialogue.txt" ; 8DDF73
      dialogueChapterEpilogueWorldMap_Silesse_Piece_FeeHermina .include "text/dialogue/EpilogueWorldMap/WorldMap_Silesse_Piece_FeeHermina.dialogue.txt" ; 8DDF86

      dialogueChapterEpilogueWorldMapNewThracia .include "text/dialogue/EpilogueWorldMap/WorldMapNewThracia.dialogue.txt" ; 8DDFA2
      dialogueChapterEpilogueWorldMap_NewThracia_NoInheritors .include "text/dialogue/EpilogueWorldMap/WorldMap_NewThracia_NoInheritors.dialogue.txt" ; 8DDFAE
      dialogueChapterEpilogueWorldMap_NewThracia_Inherited .include "text/dialogue/EpilogueWorldMap/WorldMap_NewThracia_Inherited.dialogue.txt" ; 8DE0E8
      dialogueChapterEpilogueWorldMap_Piece_NewThracia_EndLeifAndAltenaAlive .include "text/dialogue/EpilogueWorldMap/WorldMap_Piece_NewThracia_EndLeifAndAltenaAlive.dialogue.txt" ; 8DE1FE
      dialogueChapterEpilogueWorldMap_Piece_NewThracia_LeifNoLover .include "text/dialogue/EpilogueWorldMap/WorldMap_Piece_NewThracia_LeifNoLover.dialogue.txt" ; 8DE285
      dialogueChapterEpilogueWorldMap_Piece_NewThracia_Start .include "text/dialogue/EpilogueWorldMap/WorldMap_Piece_NewThracia_Start.dialogue.txt" ; 8DE28F
      dialogueChapterEpilogueWorldMap_Piece_NewThracia_LeifsLover .include "text/dialogue/EpilogueWorldMap/WorldMap_Piece_NewThracia_LeifsLover.dialogue.txt" ; 8DE295
      dialogueChapterEpilogueWorldMap_Piece_NewThracia_Finn .include "text/dialogue/EpilogueWorldMap/WorldMap_Piece_NewThracia_Finn.dialogue.txt" ; 8DE2B6
      dialogueChapterEpilogueWorldMap_Piece_NewThracia_Hannibal .include "text/dialogue/EpilogueWorldMap/WorldMap_Piece_NewThracia_Hannibal.dialogue.txt" ; 8DE2D2
      dialogueChapterEpilogueWorldMap_Piece_NewThracia_CharlotCoirpre .include "text/dialogue/EpilogueWorldMap/WorldMap_Piece_NewThracia_CharlotCoirpre.dialogue.txt" ; 8DE2EE
      dialogueChapterEpilogueWorldMap_Piece_NewThracia_CharlotCoirpresLover .include "text/dialogue/EpilogueWorldMap/WorldMap_Piece_NewThracia_CharlotCoirpresLover.dialogue.txt" ; 8DE312
      dialogueChapterEpilogueWorldMap_Piece_NewThracia_Asaello .include "text/dialogue/EpilogueWorldMap/WorldMap_Piece_NewThracia_Asaello.dialogue.txt" ; 8DE325
      dialogueChapterEpilogueWorldMap_Piece_NewThracia_AsaellosLover .include "text/dialogue/EpilogueWorldMap/WorldMap_Piece_NewThracia_AsaellosLover.dialogue.txt" ; 8DE34A
      dialogueChapterEpilogueWorldMap_Piece_NewThracia_Daisy .include "text/dialogue/EpilogueWorldMap/WorldMap_Piece_NewThracia_Daisy.dialogue.txt" ; 8DE35D
      dialogueChapterEpilogueWorldMap_Piece_NewThracia_EndNoInheritors .include "text/dialogue/EpilogueWorldMap/WorldMap_Piece_NewThracia_EndNoInheritors.dialogue.txt" ; 8DE381
      dialogueChapterEpilogueWorldMap_Piece_NewThracia_EndInherited .include "text/dialogue/EpilogueWorldMap/WorldMap_Piece_NewThracia_EndInherited.dialogue.txt" ; 8DE39F

      dialogueChapterEpilogueWorldMapIsaach .include "text/dialogue/EpilogueWorldMap/WorldMapIsaach.dialogue.txt" ; 8DE3C7
      dialogueChapterEpilogueWorldMap_Isaach_NoInheritors .include "text/dialogue/EpilogueWorldMap/WorldMap_Isaach_NoInheritors.dialogue.txt" ; 8DE3D3
      dialogueChapterEpilogueWorldMap_Isaach_Inherited .include "text/dialogue/EpilogueWorldMap/WorldMap_Isaach_Inherited.dialogue.txt" ; 8DE517
      dialogueChapterEpilogueWorldMap_Isaach_Piece_NoInheritorsSubstitutes .include "text/dialogue/EpilogueWorldMap/WorldMap_Isaach_Piece_NoInheritorsSubstitutes.dialogue.txt" ; 8DE686
      dialogueChapterEpilogueWorldMap_Isaach_Piece_NoInheritorsChildren .include "text/dialogue/EpilogueWorldMap/WorldMap_Isaach_Piece_NoInheritorsChildren.dialogue.txt" ; 8DE6A4
      dialogueChapterEpilogueWorldMap_Isaach_Piece_RulerNoLover .include "text/dialogue/EpilogueWorldMap/WorldMap_Isaach_Piece_RulerNoLover.dialogue.txt" ; 8DE6D3
      dialogueChapterEpilogueWorldMap_Isaach_Piece_RulersLover .include "text/dialogue/EpilogueWorldMap/WorldMap_Isaach_Piece_RulersLover.dialogue.txt" ; 8DE6DD
      dialogueChapterEpilogueWorldMap_Isaach_Piece_ScathachDalvin .include "text/dialogue/EpilogueWorldMap/WorldMap_Isaach_Piece_ScathachDalvin.dialogue.txt" ; 8DE6FE
      dialogueChapterEpilogueWorldMap_Isaach_Piece_ScathachDalvinsLover .include "text/dialogue/EpilogueWorldMap/WorldMap_Isaach_Piece_ScathachDalvinsLover.dialogue.txt" ; 8DE71B
      dialogueChapterEpilogueWorldMap_Isaach_Piece_LarceiCreidne .include "text/dialogue/EpilogueWorldMap/WorldMap_Isaach_Piece_LarceiCreidne.dialogue.txt" ; 8DE730
      dialogueChapterEpilogueWorldMap_Isaach_Piece_EndNoInheritors .include "text/dialogue/EpilogueWorldMap/WorldMap_Isaach_Piece_EndNoInheritors.dialogue.txt" ; 8DE745
      dialogueChapterEpilogueWorldMap_Isaach_Piece_EndInherited .include "text/dialogue/EpilogueWorldMap/WorldMap_Isaach_Piece_EndInherited.dialogue.txt" ; 8DE755
      dialogueChapterEpilogueWorldMap_Isaach_Piece_Deimne .include "text/dialogue/EpilogueWorldMap/WorldMap_Isaach_Piece_Deimne.dialogue.txt" ; 8DE75D
      dialogueChapterEpilogueWorldMap_Isaach_Piece_DeimnesLover .include "text/dialogue/EpilogueWorldMap/WorldMap_Isaach_Piece_DeimnesLover.dialogue.txt" ; 8DE77D
      dialogueChapterEpilogueWorldMap_Isaach_Piece_Muirne .include "text/dialogue/EpilogueWorldMap/WorldMap_Isaach_Piece_Muirne.dialogue.txt" ; 8DE792

      dialogueChapterEpilogueWorldMapAgustria .include "text/dialogue/EpilogueWorldMap/WorldMapAgustria.dialogue.txt" ; 8DE7A8
      dialogueChapterEpilogueWorldMap_Agustria_NoInheritors .include "text/dialogue/EpilogueWorldMap/WorldMap_Agustria_NoInheritors.dialogue.txt" ; 8DE7EE
      dialogueChapterEpilogueWorldMap_Agustria_Inherited .include "text/dialogue/EpilogueWorldMap/WorldMap_Agustria_Inherited.dialogue.txt" ; 8DE90C
      dialogueChapterEpilogueWorldMap_Agustria_Piece_RulerNoLover .include "text/dialogue/EpilogueWorldMap/WorldMap_Agustria_Piece_RulerNoLover.dialogue.txt" ; 8DEA1B
      dialogueChapterEpilogueWorldMap_Agustria_Piece_Start .include "text/dialogue/EpilogueWorldMap/WorldMap_Agustria_Piece_Start.dialogue.txt" ; 8DEA25
      dialogueChapterEpilogueWorldMap_Agustria_Piece_RulersLover .include "text/dialogue/EpilogueWorldMap/WorldMap_Agustria_Piece_RulersLover.dialogue.txt" ; 8DEA36
      dialogueChapterEpilogueWorldMap_Agustria_Piece_LayleaLene .include "text/dialogue/EpilogueWorldMap/WorldMap_Agustria_Piece_LayleaLene.dialogue.txt" ; 8DEA52
      dialogueChapterEpilogueWorldMap_Agustria_Piece_DiarmuidTristan .include "text/dialogue/EpilogueWorldMap/WorldMap_Agustria_Piece_DiarmuidTristan.dialogue.txt" ; 8DEA67
      dialogueChapterEpilogueWorldMap_Agustria_Piece_DiarmuidTristansLover .include "text/dialogue/EpilogueWorldMap/WorldMap_Agustria_Piece_DiarmuidTristansLover.dialogue.txt" ; 8DEA87
      dialogueChapterEpilogueWorldMap_Agustria_Piece_NannaJeanne .include "text/dialogue/EpilogueWorldMap/WorldMap_Agustria_Piece_NannaJeanne.dialogue.txt" ; 8DEA9C
      dialogueChapterEpilogueWorldMap_Agustria_Piece_End .include "text/dialogue/EpilogueWorldMap/WorldMap_Agustria_Piece_End.dialogue.txt" ; 8DEAB1

      dialogueChapterEpilogueWorldMapVerdane .include "text/dialogue/EpilogueWorldMap/WorldMapVerdane.dialogue.txt" ; 8DEAD6
      dialogueChapterEpilogueWorldMap_Verdane_NoInheritors .include "text/dialogue/EpilogueWorldMap/WorldMap_Verdane_NoInheritors.dialogue.txt" ; 8DEBAE
      dialogueChapterEpilogueWorldMap_Verdane_Inherited .include "text/dialogue/EpilogueWorldMap/WorldMap_Verdane_Inherited.dialogue.txt" ; 8DECAA
      dialogueChapterEpilogueWorldMap_Verdane_Piece_JamkesSonNoLover .include "text/dialogue/EpilogueWorldMap/WorldMap_Verdane_Piece_JamkesSonNoLover.dialogue.txt" ; 8DED99
      dialogueChapterEpilogueWorldMap_Verdane_Piece_JamkesSonLover .include "text/dialogue/EpilogueWorldMap/WorldMap_Verdane_Piece_JamkesSonLover.dialogue.txt" ; 8DEDA3

      dialogueChapterEpilogueWorldMapGrannvale .include "text/dialogue/EpilogueWorldMap/WorldMapGrannvale.dialogue.txt" ; 8DEDC4
      dialogueChapterEpilogueWorldMap_Grannvale_Piece_PrepareQueen .include "text/dialogue/EpilogueWorldMap/WorldMap_Grannvale_Piece_PrepareQueen.dialogue.txt" ; 8DEF0A
      dialogueChapterEpilogueWorldMap_Grannvale_Piece_SoloQueen .include "text/dialogue/EpilogueWorldMap/WorldMap_Grannvale_Piece_SoloQueen.dialogue.txt" ; 8DEF1A
      dialogueChapterEpilogueWorldMap_Grannvale_Piece_QueenAndJulia .include "text/dialogue/EpilogueWorldMap/WorldMap_Grannvale_Piece_QueenAndJulia.dialogue.txt" ; 8DEF52
      dialogueChapterEpilogueWorldMap_Grannvale_Piece_NoQueenAndJulia .include "text/dialogue/EpilogueWorldMap/WorldMap_Grannvale_Piece_NoQueenAndJulia.dialogue.txt" ; 8DEFBD
      dialogueChapterEpilogueWorldMap_Grannvale_Piece_Start .include "text/dialogue/EpilogueWorldMap/WorldMap_Grannvale_Piece_Start.dialogue.txt" ; 8DEFFB
      dialogueChapterEpilogueWorldMap_Grannvale_Piece_Velthomer_Ruler .include "text/dialogue/EpilogueWorldMap/WorldMap_Grannvale_Piece_Velthomer_Ruler.dialogue.txt" ; 8DF062
      dialogueChapterEpilogueWorldMap_Grannvale_Piece_Velthomer_AzellesSonLover .include "text/dialogue/EpilogueWorldMap/WorldMap_Grannvale_Piece_Velthomer_AzellesSonLover.dialogue.txt" ; 8DF08D
      dialogueChapterEpilogueWorldMap_Grannvale_Piece_Velthomer_AzellesChildren .include "text/dialogue/EpilogueWorldMap/WorldMap_Grannvale_Piece_Velthomer_AzellesChildren.dialogue.txt" ; 8DF0A2
      dialogueChapterEpilogueWorldMap_Grannvale_Piece_Friege_Ruler .include "text/dialogue/EpilogueWorldMap/WorldMap_Grannvale_Piece_Friege_Ruler.dialogue.txt" ; 8DF0BC
      dialogueChapterEpilogueWorldMap_Grannvale_Piece_Friege_RulersLover .include "text/dialogue/EpilogueWorldMap/WorldMap_Grannvale_Piece_Friege_RulersLover.dialogue.txt" ; 8DF0E8
      dialogueChapterEpilogueWorldMap_Grannvale_Piece_Friege_RulersSister .include "text/dialogue/EpilogueWorldMap/WorldMap_Grannvale_Piece_Friege_RulersSister.dialogue.txt" ; 8DF0FD
      dialogueChapterEpilogueWorldMap_Grannvale_Piece_Edda_Ruler .include "text/dialogue/EpilogueWorldMap/WorldMap_Grannvale_Piece_Edda_Ruler.dialogue.txt" ; 8DF117
      dialogueChapterEpilogueWorldMap_Grannvale_Piece_Edda_RulersLover .include "text/dialogue/EpilogueWorldMap/WorldMap_Grannvale_Piece_Edda_RulersLover.dialogue.txt" ; 8DF142
      dialogueChapterEpilogueWorldMap_Grannvale_Piece_Edda_RulersSister .include "text/dialogue/EpilogueWorldMap/WorldMap_Grannvale_Piece_Edda_RulersSister.dialogue.txt" ; 8DF157
      dialogueChapterEpilogueWorldMap_Grannvale_Piece_Dozel_Ruler .include "text/dialogue/EpilogueWorldMap/WorldMap_Grannvale_Piece_Dozel_Ruler.dialogue.txt" ; 8DF171
      dialogueChapterEpilogueWorldMap_Grannvale_Piece_Dozel_RulersLover .include "text/dialogue/EpilogueWorldMap/WorldMap_Grannvale_Piece_Dozel_RulersLover.dialogue.txt" ; 8DF19C
      dialogueChapterEpilogueWorldMap_Grannvale_Piece_Dozel_RulersSister .include "text/dialogue/EpilogueWorldMap/WorldMap_Grannvale_Piece_Dozel_RulersSister.dialogue.txt" ; 8DF1B1
      dialogueChapterEpilogueWorldMap_Grannvale_Piece_Dozel_Iuchar .include "text/dialogue/EpilogueWorldMap/WorldMap_Grannvale_Piece_Dozel_Iuchar.dialogue.txt" ; 8DF1CB
      dialogueChapterEpilogueWorldMap_Grannvale_Piece_Dozel_IucharsLover .include "text/dialogue/EpilogueWorldMap/WorldMap_Grannvale_Piece_Dozel_IucharsLover.dialogue.txt" ; 8DF1EA
      dialogueChapterEpilogueWorldMap_Grannvale_Piece_Dozel_Iucharba .include "text/dialogue/EpilogueWorldMap/WorldMap_Grannvale_Piece_Dozel_Iucharba.dialogue.txt" ; 8DF1FF
      dialogueChapterEpilogueWorldMap_Grannvale_Piece_Dozel_IucharbasLover .include "text/dialogue/EpilogueWorldMap/WorldMap_Grannvale_Piece_Dozel_IucharbasLover.dialogue.txt" ; 8DF220
      dialogueChapterEpilogueWorldMap_Grannvale_Piece_Yngvi_Ruler .include "text/dialogue/EpilogueWorldMap/WorldMap_Grannvale_Piece_Yngvi_Ruler.dialogue.txt" ; 8DF235
      dialogueChapterEpilogueWorldMap_Grannvale_Piece_Yngvi_RulersLover .include "text/dialogue/EpilogueWorldMap/WorldMap_Grannvale_Piece_Yngvi_RulersLover.dialogue.txt" ; 8DF262
      dialogueChapterEpilogueWorldMap_Grannvale_Piece_Yngvi_RulersSister .include "text/dialogue/EpilogueWorldMap/WorldMap_Grannvale_Piece_Yngvi_RulersSister.dialogue.txt" ; 8DF277
      dialogueChapterEpilogueWorldMap_Grannvale_Piece_Yngvi_Lester .include "text/dialogue/EpilogueWorldMap/WorldMap_Grannvale_Piece_Yngvi_Lester.dialogue.txt" ; 8DF291
      dialogueChapterEpilogueWorldMap_Grannvale_Piece_Yngvi_LestersLover .include "text/dialogue/EpilogueWorldMap/WorldMap_Grannvale_Piece_Yngvi_LestersLover.dialogue.txt" ; 8DF2B1
      dialogueChapterEpilogueWorldMap_Grannvale_Piece_Yngvi_Lana .include "text/dialogue/EpilogueWorldMap/WorldMap_Grannvale_Piece_Yngvi_Lana.dialogue.txt" ; 8DF2C6
      dialogueChapterEpilogueWorldMap_Grannvale_Piece_Chalphy_Oifey .include "text/dialogue/EpilogueWorldMap/WorldMap_Grannvale_Piece_Chalphy_Oifey.dialogue.txt" ; 8DF2E0
      dialogueChapterEpilogueWorldMap_Grannvale_Piece_Chalphy_OifeysLover .include "text/dialogue/EpilogueWorldMap/WorldMap_Grannvale_Piece_Chalphy_OifeysLover.dialogue.txt" ; 8DF314
      dialogueChapterEpilogueWorldMap_Grannvale_Piece_Unknown8DF329 .include "text/dialogue/EpilogueWorldMap/WorldMap_Grannvale_Piece_Unknown8DF329.dialogue.txt" ; 8DF329

      dialogueChapter07LeifSeliphTalk .include "text/dialogue/Chapter07/LeifSeliphTalk.dialogue.txt" ; 8DF32D
      dialogueChapter07DiarmuidNannaTalk .include "text/dialogue/Chapter07/DiarmuidNannaTalk.dialogue.txt" ; 8DF6F8
      dialogueChapter07TristanJeanneTalk .include "text/dialogue/Chapter07/TristanJeanneTalk.dialogue.txt" ; 8DF8FB
      dialogueChapter07TineLinda_SeliphTalk .include "text/dialogue/Chapter07/TineLinda_SeliphTalk.dialogue.txt" ; 8DFAFB

      aWorldMapEvents .binclude "data/chapter/WorldMapEvents.csv.asm"

      .include "events/ChapterPrologue/EventPrologueWorldMap.asm"
      .include "events/Chapter01/EventChapter01WorldMap.asm"
      .include "events/Chapter02/EventChapter02WorldMap.asm"
      .include "events/Chapter03/EventChapter03WorldMap.asm"
      .include "events/Chapter04/EventChapter04WorldMap.asm"
      .include "events/Chapter05/EventChapter05WorldMap.asm"
      .include "events/Chapter06/EventChapter06WorldMap.asm"
      .include "events/Chapter07/EventChapter07WorldMap.asm"
      .include "events/Chapter08/EventChapter08WorldMap.asm"
      .include "events/Chapter09/EventChapter09WorldMap.asm"
      .include "events/Chapter10/EventChapter10WorldMap.asm"
      .include "events/ChapterFinal/EventChapterFinalWorldMap.asm"
      .include "events/ChapterEpilogue/EventChapterEpilogueWorldMap.asm"

      .fill $8D8000 + $8000 - *, 0

    .here

    * = $0E8000
    .logical $8E8000

      .include "events/Chapter02/EventChapter02Opening.asm"
      .include "events/Chapter02/EventChapter02InfiniBrigandsSpawn.asm"
      .include "events/Chapter02/EventChapter02ElliotCharge.asm"
      .include "events/Chapter02/EventChapter02PhilipDefend.asm"
      .include "events/Chapter02/EventChapter02LewynSilviaSpawn.asm"
      .include "events/Chapter02/EventChapter02InfiniSpawn.asm"
      .include "events/Chapter02/EventChapter02WaltzCharge.asm"
      .include "events/Chapter02/EventChapter02SigurdLachesisTalk.asm"
      .include "events/Chapter02/EventChapter02BeowulfTalkNoMoney.asm"
      .include "events/Chapter02/EventChapter02BeowulfTalkSuccess.asm"
      .include "events/Chapter02/EventChapter02MackilySpawn.asm"
      .include "events/Chapter02/EventChapter02ChulainnRecruitmentEvans.asm"
      .include "events/Chapter02/EventChapter02AgustiSpawn.asm"
      .include "events/Chapter02/EventChapter02LewynErinysTalk.asm"
      .include "events/Chapter02/EventChapter02Ending.asm"
      .include "events/Chapter02/EventChapter02Village8.asm"
      .include "events/Chapter02/EventChapter02VillageBargainBand.asm"
      .include "events/Chapter02/EventChapter02VillageArmorslayer.asm"
      .include "events/Chapter02/EventChapter02Village5.asm"
      .include "events/Chapter02/EventChapter02Village2.asm"
      .include "events/Chapter02/EventChapter02Village4.asm"
      .include "events/Chapter02/EventChapter02Village6.asm"
      .include "events/Chapter02/EventChapter02Village7.asm"
      .include "events/Chapter02/EventChapter02_05B.asm"
      .include "events/Chapter02/EventChapter02_05C.asm"
      .include "events/Chapter02/EventChapter02ChulainnRecruitmentHeirhein.asm"
      .include "events/Chapter02/EventChapter02ChulainnRecruitmentInfini.asm"
      .include "events/Chapter02/EventChapter02ChulainnRecruitmentMackily.asm"
      .include "events/Chapter02/EventChapter02ChulainnRecruitmentNordion.asm"
      .include "events/Chapter02/EventChapter02HeirheinSeized.asm"
      .include "events/Chapter02/EventChapter02ErinysGroupArrive.asm"
      .include "events/Chapter02/EventChapter02InfiniSeized.asm"
      .include "events/Chapter02/EventChapter02_064.asm"
      .include "events/Chapter02/EventChapter02MackilyWorried.asm"
      .include "events/Chapter02/EventChapter02Village1.asm"
      .include "events/Chapter02/EventChapter02Village3.asm"
      .include "events/Chapter02/EventChapter02QuanDied.asm"
      .include "events/Chapter02/EventChapter02EthlynDied.asm"
      .include "events/Chapter02/EventChapter02FinnDied.asm"
      .include "events/Chapter02/EventChapter02MackilySeized.asm"
      .include "events/Chapter02/EventChapter02_06C.asm"
      .include "events/Chapter02/EventChapter02_06D.asm"
      .include "events/Chapter02/EventChapter02_06E.asm"
      .include "events/Chapter02/EventChapter02_06F.asm"
      .include "events/Chapter02/EventChapter02MountainArmorTalk.asm"
      .include "events/Chapter02/EventChapter02ArdenPursuitRing.asm"

      dialogueChapter02WorldMap1 .include "text/dialogue/Chapter02/WorldMap1.dialogue.txt" ; 8E8AC1
      dialogueChapter02WorldMap2 .include "text/dialogue/Chapter02/WorldMap2.dialogue.txt" ; 8E8B27
      dialogueChapter02WorldMap3 .include "text/dialogue/Chapter02/WorldMap3.dialogue.txt" ; 8E8B84
      dialogueChapter02WorldMap4 .include "text/dialogue/Chapter02/WorldMap4.dialogue.txt" ; 8E8C1B

      dialogueChapter03WorldMap1 .include "text/dialogue/Chapter03/WorldMap1.dialogue.txt" ; 8E8CB7
      dialogueChapter03WorldMap2 .include "text/dialogue/Chapter03/WorldMap2.dialogue.txt" ; 8E8D17
      dialogueChapter03WorldMap3 .include "text/dialogue/Chapter03/WorldMap3.dialogue.txt" ; 8E8DAB
      dialogueChapter03WorldMap4 .include "text/dialogue/Chapter03/WorldMap4.dialogue.txt" ; 8E8E3F
      dialogueChapter03WorldMap5 .include "text/dialogue/Chapter03/WorldMap5.dialogue.txt" ; 8E8EA5

      .include "events/Chapter04/EventChapter04Opening.asm"
      .include "events/Chapter04/EventChapter04CuvuliCharge.asm"
      .include "events/Chapter04/EventChapter04DaccarAndreyPreparing.asm"
      .include "events/Chapter04/EventChapter04RaiseBridge.asm"
      .include "events/Chapter04/EventChapter04LowerBridge.asm"
      .include "events/Chapter04/EventChapter04PamelaSpawn.asm"
      .include "events/Chapter04/EventChapter04AnnandSpawn.asm"
      .include "events/Chapter04/EventChapter04AnnandPamelaCloseByTalk.asm"
      .include "events/Chapter04/EventChapter04_09E.asm"
      .include "events/Chapter04/EventChapter04AndreySpawn.asm"
      .include "events/Chapter04/EventChapter04AnnandDeathAndreyResponse.asm"
      .include "events/Chapter04/EventChapter04AnnandDeathPlayerResponses.asm"
      .include "events/Chapter04/EventChapter04AndreyLeave.asm"
      .include "events/Chapter04/EventChapter04ZaxonSpawn.asm"
      .include "events/Chapter04/EventChapter04DonovanSpawn.asm"
      .include "events/Chapter04/EventChapter04SilesseSeized.asm"
      .include "events/Chapter04/EventChapter04SilesseSeizedDaccarResponse.asm"
      .include "events/Chapter04/EventChapter04LewynSilesseVisit.asm"
      .include "events/Chapter04/EventChapter04Ending.asm"
      .include "events/Chapter04/EventChapter04CivilianRescuedA.asm"
      .include "events/Chapter04/EventChapter04CivilianRescuedB.asm"
      .include "events/Chapter04/EventChapter04Village7.asm"
      .include "events/Chapter04/EventChapter04Village4.asm"
      .include "events/Chapter04/EventChapter04Village5.asm"
      .include "events/Chapter04/EventChapter04Village3.asm"
      .include "events/Chapter04/EventChapter04Village2.asm"
      .include "events/Chapter04/EventChapter04VillageSafeguardAnyone.asm"
      .include "events/Chapter04/EventChapter04Village6.asm"
      .include "events/Chapter04/EventChapter04Village1.asm"
      .include "events/Chapter04/EventChapter04TofaSeized.asm"
      .include "events/Chapter04/EventChapter04_0B4.asm"
      .include "events/Chapter04/EventChapter04LamiaCharge.asm"
      .include "events/Chapter04/EventChapter04VillageSafeguardSilvia.asm"
      .include "events/Chapter04/EventChapter04ErinysSilviaAdjacent.asm"
      .include "events/Chapter04/EventChapter04_0B8.asm"
      .include "events/Chapter04/EventChapter04_0B9.asm"

      .sint -1

      dialogueChapter04OpeningLewynDead .include "text/dialogue/Chapter04/OpeningLewynDead.dialogue.txt" ; 8E9B61
      dialogueChapter04OpeningErinysDead .include "text/dialogue/Chapter04/OpeningErinysDead.dialogue.txt" ; 8EA228
      dialogueChapter04OpeningLewynErinysAlive .include "text/dialogue/Chapter04/OpeningLewynErinysAlive.dialogue.txt" ; 8EA432
      dialogueChapter04OpeningQuanEthlynFinnLeave .include "text/dialogue/Chapter04/OpeningQuanEthlynFinnLeave.dialogue.txt" ; 8EA626
      dialogueChapter04OpeningQuanEthlynLeave .include "text/dialogue/Chapter04/OpeningQuanEthlynLeave.dialogue.txt" ; 8EA793
      dialogueChapter04OpeningFinnLeave .include "text/dialogue/Chapter04/OpeningFinnLeave.dialogue.txt" ; 8EA88A
      dialogueChapter04Opening2 .include "text/dialogue/Chapter04/Opening2.dialogue.txt" ; 8EA962
      dialogueChapter04CuvuliCharge .include "text/dialogue/Chapter04/CuvuliCharge.dialogue.txt" ; 8EAA84
      dialogueChapter04CuvuliBattleQuote .include "text/dialogue/Chapter04/CuvuliBattleQuote.dialogue.txt" ; 8EAADC
      dialogueChapter04DithorbaBattleQuote .include "text/dialogue/Chapter04/DithorbaBattleQuote.dialogue.txt" ; 8EAAF7
      dialogueChapter04DaccarAndreyPreparing .include "text/dialogue/Chapter04/DaccarAndreyPreparing.dialogue.txt" ; 8EAB32
      dialogueChapter04RaiseBridge .include "text/dialogue/Chapter04/RaiseBridge.dialogue.txt" ; 8EAC65
      dialogueChapter04LowerBridge .include "text/dialogue/Chapter04/LowerBridge.dialogue.txt" ; 8EACDD
      dialogueChapter04MyosBattleQuote .include "text/dialogue/Chapter04/MyosBattleQuote.dialogue.txt" ; 8EAD16
      dialogueChapter04PamelaSpawn .include "text/dialogue/Chapter04/PamelaSpawn.dialogue.txt" ; 8EAD46
      dialogueChapter04AnnandSpawn .include "text/dialogue/Chapter04/AnnandSpawn.dialogue.txt" ; 8EADF1
      dialogueChapter04AnnandPamelaCloseByTalk .include "text/dialogue/Chapter04/AnnandPamelaCloseByTalk.dialogue.txt" ; 8EAF8D
      dialogueChapter04AndreySpawn .include "text/dialogue/Chapter04/AndreySpawn.dialogue.txt" ; 8EB0C6
      dialogueChapter04ZaxonAnnandBattleQuote .include "text/dialogue/Chapter04/ZaxonAnnandBattleQuote.dialogue.txt" ; 8EB1AE
      dialogueChapter04PamelaBattleQuote .include "text/dialogue/Chapter04/PamelaBattleQuote.dialogue.txt" ; 8EB1D3
      dialogueChapter04SilesseAndreyBattleQuote .include "text/dialogue/Chapter04/SilesseAndreyBattleQuote.dialogue.txt" ; 8EB1EB
      dialogueChapter04AnnandDeathAndreyResponse .include "text/dialogue/Chapter04/AnnandDeathAndreyResponse.dialogue.txt" ; 8EB220
      dialogueChapter04AnnandDeathLahnaResponse .include "text/dialogue/Chapter04/AnnandDeathLahnaResponse.dialogue.txt" ; 8EB2A2
      dialogueChapter04AnnandDeathLewynResponse .include "text/dialogue/Chapter04/AnnandDeathLewynResponse.dialogue.txt" ; 8EB2DD
      dialogueChapter04AnnandDeathErinysResponse .include "text/dialogue/Chapter04/AnnandDeathErinysResponse.dialogue.txt" ; 8EB305
      dialogueChapter04AndreyLeave .include "text/dialogue/Chapter04/AndreyLeave.dialogue.txt" ; 8EB352
      dialogueChapter04ZaxonSpawn1 .include "text/dialogue/Chapter04/ZaxonSpawn1.dialogue.txt" ; 8EB38E
      dialogueChapter04ZaxonSpawn2 .include "text/dialogue/Chapter04/ZaxonSpawn2.dialogue.txt" ; 8EB44F
      dialogueChapter04ZaxonSpawn3 .include "text/dialogue/Chapter04/ZaxonSpawn3.dialogue.txt" ; 8EB4D2
      dialogueChapter04ZaxonSpawn4 .include "text/dialogue/Chapter04/ZaxonSpawn4.dialogue.txt" ; 8EB5BD
      dialogueChapter04DonovanSpawn .include "text/dialogue/Chapter04/DonovanSpawn.dialogue.txt" ; 8EB714
      dialogueChapter04DonovanBattleQuote .include "text/dialogue/Chapter04/DonovanBattleQuote.dialogue.txt" ; 8EB77E
      dialogueChapter04SilesseSeizedDaccarAlive .include "text/dialogue/Chapter04/SilesseSeizedDaccarAlive.dialogue.txt" ; 8EB793
      dialogueChapter04SilesseSeizedDaccarDead .include "text/dialogue/Chapter04/SilesseSeizedDaccarDead.dialogue.txt" ; 8EB97A
      dialogueChapter04DaccarResponsePamelaDeadLamiaDead .include "text/dialogue/Chapter04/DaccarResponsePamelaDeadLamiaDead.dialogue.txt" ; 8EBAD4
      dialogueChapter04DaccarResponsePamelaDeadLamiaAlive .include "text/dialogue/Chapter04/DaccarResponsePamelaDeadLamiaAlive.dialogue.txt" ; 8EBB20
      dialogueChapter04DaccarResponsePamelaAliveLamiaDead .include "text/dialogue/Chapter04/DaccarResponsePamelaAliveLamiaDead.dialogue.txt" ; 8EBB2C
      dialogueChapter04DaccarResponsePamelaAliveLamiaAlive .include "text/dialogue/Chapter04/DaccarResponsePamelaAliveLamiaAlive.dialogue.txt" ; 8EBB38
      dialogueChapter04Piece_LamiaChargeOrder .include "text/dialogue/Chapter04/Piece_LamiaChargeOrder.dialogue.txt" ; 8EBB4A
      dialogueChapter04Piece_PamelaChargeOrder .include "text/dialogue/Chapter04/Piece_PamelaChargeOrder.dialogue.txt" ; 8EBB7D
      dialogueChapter04LamiaCharge .include "text/dialogue/Chapter04/LamiaCharge.dialogue.txt" ; 8EBBB1
      dialogueChapter04LewynSilesseVisit .include "text/dialogue/Chapter04/LewynSilesseVisit.dialogue.txt" ; 8EBBE2
      dialogueChapter04DaccarBattleQuote .include "text/dialogue/Chapter04/DaccarBattleQuote.dialogue.txt" ; 8EC033
      dialogueChapter04LamiaBattleQuote .include "text/dialogue/Chapter04/LamiaBattleQuote.dialogue.txt" ; 8EC06A
      dialogueChapter04Ending .include "text/dialogue/Chapter04/Ending.dialogue.txt" ; 8EC086
      dialogueChapter04CivilianRescuedA .include "text/dialogue/Chapter04/CivilianRescuedA.dialogue.txt" ; 8EC3B5
      dialogueChapter04CivilianRescuedB .include "text/dialogue/Chapter04/CivilianRescuedB.dialogue.txt" ; 8EC3D0
      dialogueChapter04Village7 .include "text/dialogue/Chapter04/Village7.dialogue.txt" ; 8EC3F8
      dialogueChapter04Village4 .include "text/dialogue/Chapter04/Village4.dialogue.txt" ; 8EC476
      dialogueChapter04Village5 .include "text/dialogue/Chapter04/Village5.dialogue.txt" ; 8EC537
      dialogueChapter04Village3 .include "text/dialogue/Chapter04/Village3.dialogue.txt" ; 8EC5B5
      dialogueChapter04Village2 .include "text/dialogue/Chapter04/Village2.dialogue.txt" ; 8EC643
      dialogueChapter04VillageSafeguardAnyone .include "text/dialogue/Chapter04/VillageSafeguardAnyone.dialogue.txt" ; 8EC6B0
      dialogueChapter04Village6 .include "text/dialogue/Chapter04/Village6.dialogue.txt" ; 8EC731
      dialogueChapter04Village1Default .include "text/dialogue/Chapter04/Village1Default.dialogue.txt" ; 8EC798
      dialogueChapter04Village1BridgeLowered .include "text/dialogue/Chapter04/Village1BridgeLowered.dialogue.txt" ; 8EC81E
      
      dialogueChapter04TofaSeized .include "text/dialogue/Chapter04/TofaSeized.dialogue.txt" ; 8EC84D
      dialogueChapter04WorldMap1 .include "text/dialogue/Chapter04/WorldMap1.dialogue.txt" ; 8ECA72
      dialogueChapter04WorldMap2 .include "text/dialogue/Chapter04/WorldMap2.dialogue.txt" ; 8ECAE4
      dialogueChapter04WorldMapUnused .include "text/dialogue/Chapter04/WorldMapUnused.dialogue.txt" ; 8ECD3D
      
      dialogueChapter05WorldMap .include "text/dialogue/Chapter05/WorldMap.dialogue.txt" ; 8ECD41
      
      dialogueChapter06WorldMap1 .include "text/dialogue/Chapter06/WorldMap1.dialogue.txt" ; 8ED010
      dialogueChapter06WorldMap2 .include "text/dialogue/Chapter06/WorldMap2.dialogue.txt" ; 8ED0D7
      dialogueChapter06WorldMap3 .include "text/dialogue/Chapter06/WorldMap3.dialogue.txt" ; 8ED160
      dialogueChapter06WorldMap4 .include "text/dialogue/Chapter06/WorldMap4.dialogue.txt" ; 8ED21D
      dialogueChapter06WorldMap5 .include "text/dialogue/Chapter06/WorldMap5.dialogue.txt" ; 8ED24F
      dialogueChapter06WorldMap6 .include "text/dialogue/Chapter06/WorldMap6.dialogue.txt" ; 8ED3A3

      dialogueChapter07WorldMap1 .include "text/dialogue/Chapter07/WorldMap1.dialogue.txt" ; 8ED4BD
      dialogueChapter07WorldMap2 .include "text/dialogue/Chapter07/WorldMap2.dialogue.txt" ; 8ED67D
      dialogueChapter07WorldMap3 .include "text/dialogue/Chapter07/WorldMap3.dialogue.txt" ; 8ED72E

      dialogueDeathQuoteGen1PlayerSigurd .include "text/dialogue/DeathQuote/Gen1Player/Sigurd.dialogue.txt" ; 8ED7DE
      dialogueDeathQuoteGen1PlayerNaoise .include "text/dialogue/DeathQuote/Gen1Player/Naoise.dialogue.txt" ; 8ED7FF
      dialogueDeathQuoteGen1PlayerAlec .include "text/dialogue/DeathQuote/Gen1Player/Alec.dialogue.txt" ; 8ED835
      dialogueDeathQuoteGen1PlayerArden .include "text/dialogue/DeathQuote/Gen1Player/Arden.dialogue.txt" ; 8ED863
      dialogueDeathQuoteGen1PlayerFinn .include "text/dialogue/DeathQuote/Gen1Player/Finn.dialogue.txt" ; 8ED897
      dialogueDeathQuoteGen1PlayerQuan .include "text/dialogue/DeathQuote/Gen1Player/Quan.dialogue.txt" ; 8ED8D4
      dialogueDeathQuoteGen1PlayerQuanLeave .include "text/dialogue/DeathQuote/Gen1Player/QuanLeave.dialogue.txt" ; 8ED8F0
      dialogueDeathQuoteLoverMidirUnused .include "text/dialogue/DeathQuote/Lover/MidirUnused.dialogue.txt" ; 8ED946
      dialogueDeathQuoteGen1PlayerMidir .include "text/dialogue/DeathQuote/Gen1Player/Midir.dialogue.txt" ; 8ED977
      dialogueDeathQuoteGen1PlayerLewyn .include "text/dialogue/DeathQuote/Gen1Player/Lewyn.dialogue.txt" ; 8ED99C
      dialogueDeathQuoteGen1PlayerChulainn .include "text/dialogue/DeathQuote/Gen1Player/Chulainn.dialogue.txt" ; 8ED9D8
      dialogueDeathQuoteLoverAzelle .include "text/dialogue/DeathQuote/Lover/Azelle.dialogue.txt" ; 8ED9FB
      dialogueDeathQuoteGen1PlayerAzelle .include "text/dialogue/DeathQuote/Gen1Player/Azelle.dialogue.txt" ; 8EDA2C
      dialogueDeathQuoteLoverJamke .include "text/dialogue/DeathQuote/Lover/Jamke.dialogue.txt" ; 8EDA51
      dialogueDeathQuoteGen1PlayerJamke .include "text/dialogue/DeathQuote/Gen1Player/Jamke.dialogue.txt" ; 8EDA76
      dialogueDeathQuoteGen1PlayerClaud .include "text/dialogue/DeathQuote/Gen1Player/Claud.dialogue.txt" ; 8EDA8F
      dialogueDeathQuoteGen1PlayerBeowulf .include "text/dialogue/DeathQuote/Gen1Player/Beowulf.dialogue.txt" ; 8EDABE
      dialogueDeathQuoteGen1PlayerLex .include "text/dialogue/DeathQuote/Gen1Player/Lex.dialogue.txt" ; 8EDAE6
      dialogueDeathQuoteGen1PlayerDew .include "text/dialogue/DeathQuote/Gen1Player/Dew.dialogue.txt" ; 8EDB25
      dialogueDeathQuoteGen1PlayerDeirdre .include "text/dialogue/DeathQuote/Gen1Player/Deirdre.dialogue.txt" ; 8EDB48
      dialogueDeathQuoteGen1PlayerDeirdreReturn .include "text/dialogue/DeathQuote/Gen1Player/DeirdreReturn.dialogue.txt" ; 8EDB6D
      dialogueDeathQuoteGen1PlayerEthlyn .include "text/dialogue/DeathQuote/Gen1Player/Ethlyn.dialogue.txt" ; 8EDBD1
      dialogueDeathQuoteGen1PlayerEthlynLeave .include "text/dialogue/DeathQuote/Gen1Player/EthlynLeave.dialogue.txt" ; 8EDBF5
      dialogueDeathQuoteGen1PlayerLachesis .include "text/dialogue/DeathQuote/Gen1Player/Lachesis.dialogue.txt" ; 8EDC48
      dialogueDeathQuoteLoverAyra .include "text/dialogue/DeathQuote/Lover/Ayra.dialogue.txt" ; 8EDC63
      dialogueDeathQuoteGen1PlayerAyra .include "text/dialogue/DeathQuote/Gen1Player/Ayra.dialogue.txt" ; 8EDC92
      dialogueDeathQuoteGen1PlayerErinys .include "text/dialogue/DeathQuote/Gen1Player/Erinys.dialogue.txt" ; 8EDCAB
      dialogueDeathQuoteLoverTailtiu .include "text/dialogue/DeathQuote/Lover/Tailtiu.dialogue.txt" ; 8EDCCC
      dialogueDeathQuoteGen1PlayerTailtiu .include "text/dialogue/DeathQuote/Gen1Player/Tailtiu.dialogue.txt" ; 8EDCEC
      dialogueDeathQuoteLoverSilvia .include "text/dialogue/DeathQuote/Lover/Silvia.dialogue.txt" ; 8EDD02
      dialogueDeathQuoteGen1PlayerSilvia .include "text/dialogue/DeathQuote/Gen1Player/Silvia.dialogue.txt" ; 8EDD2D
      dialogueDeathQuoteLoverEdain .include "text/dialogue/DeathQuote/Lover/Edain.dialogue.txt" ; 8EDD46
      dialogueDeathQuoteGen1PlayerEdain .include "text/dialogue/DeathQuote/Gen1Player/Edain.dialogue.txt" ; 8EDD78
      dialogueDeathQuoteGen1PlayerBrigid .include "text/dialogue/DeathQuote/Gen1Player/Brigid.dialogue.txt" ; 8EDD9E

      dialogueDeathQuoteGen2PlayerSeliph .include "text/dialogue/DeathQuote/Gen2Player/Seliph.dialogue.txt" ; 8EDDB7

      dialogueDeathQuoteGen1EnemyNPCJamke .include "text/dialogue/DeathQuote/Gen1EnemyNPC/Jamke.dialogue.txt" ; 8EDDCE

      dialogueDeathQuoteGen2PlayerShannan .include "text/dialogue/DeathQuote/Gen2Player/Shannan.dialogue.txt" ; 8EDDDF
      dialogueDeathQuoteGen2PlayerDalvin .include "text/dialogue/DeathQuote/Gen2Player/Dalvin.dialogue.txt" ; 8EDDF9
      dialogueDeathQuoteGen2PlayerAsaello .include "text/dialogue/DeathQuote/Gen2Player/Asaello.dialogue.txt" ; 8EDE0D
      dialogueDeathQuoteGen2PlayerLeif .include "text/dialogue/DeathQuote/Gen2Player/Leif.dialogue.txt" ; 8EDE21
      dialogueDeathQuoteGen2PlayerIuchar .include "text/dialogue/DeathQuote/Gen2Player/Iuchar.dialogue.txt" ; 8EDE37
      dialogueDeathQuoteGen2PlayerCharlot .include "text/dialogue/DeathQuote/Gen2Player/Charlot.dialogue.txt" ; 8EDE5C
      dialogueDeathQuoteGen2PlayerHawk .include "text/dialogue/DeathQuote/Gen2Player/Hawk.dialogue.txt" ; 8EDE6F
      dialogueDeathQuoteGen2PlayerTristan .include "text/dialogue/DeathQuote/Gen2Player/Tristan.dialogue.txt" ; 8EDE9B
      dialogueDeathQuoteGen2PlayerAdultFinn .include "text/dialogue/DeathQuote/Gen2Player/AdultFinn.dialogue.txt" ; 8EDEB9
      dialogueDeathQuoteGen2PlayerDeimne .include "text/dialogue/DeathQuote/Gen2Player/Deimne.dialogue.txt" ; 8EDEEB
      dialogueDeathQuoteGen2PlayerHannibal .include "text/dialogue/DeathQuote/Gen2Player/Hannibal.dialogue.txt" ; 8EDF0A
      dialogueDeathQuoteGen2PlayerAres .include "text/dialogue/DeathQuote/Gen2Player/Ares.dialogue.txt" ; 8EDF2C
      dialogueDeathQuoteGen2PlayerAmid .include "text/dialogue/DeathQuote/Gen2Player/Amid.dialogue.txt" ; 8EDF48
      dialogueDeathQuoteGen2PlayerOifey .include "text/dialogue/DeathQuote/Gen2Player/Oifey.dialogue.txt" ; 8EDF63
      dialogueDeathQuoteGen2PlayerDaisy .include "text/dialogue/DeathQuote/Gen2Player/Daisy.dialogue.txt" ; 8EDF94
      dialogueDeathQuoteGen2PlayerCreidne .include "text/dialogue/DeathQuote/Gen2Player/Creidne.dialogue.txt" ; 8EDFAB
      dialogueDeathQuoteLoverMuirne .include "text/dialogue/DeathQuote/Lover/Muirne.dialogue.txt" ; 8EDFC3
      dialogueDeathQuoteGen2PlayerMuirne .include "text/dialogue/DeathQuote/Gen2Player/Muirne.dialogue.txt" ; 8EDFD8
      dialogueDeathQuoteLoverJulia .include "text/dialogue/DeathQuote/Lover/Julia.dialogue.txt" ; 8EDFEE
      dialogueDeathQuoteGen2PlayerJulia .include "text/dialogue/DeathQuote/Gen2Player/Julia.dialogue.txt" ; 8EE004
      dialogueDeathQuoteGen1PlayerJuliaReturn .include "text/dialogue/DeathQuote/Gen2Player/JuliaReturn.dialogue.txt" ; 8EE02E
      dialogueDeathQuoteGen2PlayerJuliaEvil .include "text/dialogue/DeathQuote/Gen2Player/JuliaEvil.dialogue.txt" ; 8EE091
      dialogueDeathQuoteGen2PlayerAltena .include "text/dialogue/DeathQuote/Gen2Player/Altena.dialogue.txt" ; 8EE0C8
      dialogueDeathQuoteLoverHermina .include "text/dialogue/DeathQuote/Lover/Hermina.dialogue.txt" ; 8EE0DA
      dialogueDeathQuoteGen2PlayerHermina .include "text/dialogue/DeathQuote/Gen2Player/Hermina.dialogue.txt" ; 8EE0ED
      dialogueDeathQuoteGen2PlayerLinda .include "text/dialogue/DeathQuote/Gen2Player/Linda.dialogue.txt" ; 8EE105
      dialogueDeathQuoteLoverLaylea .include "text/dialogue/DeathQuote/Lover/Laylea.dialogue.txt" ; 8EE118
      dialogueDeathQuoteGen2PlayerLaylea .include "text/dialogue/DeathQuote/Gen2Player/Laylea.dialogue.txt" ; 8EE12C
      dialogueDeathQuoteGen2PlayerJeanne .include "text/dialogue/DeathQuote/Gen2Player/Jeanne.dialogue.txt" ; 8EE141
      dialogueDeathQuoteGen2PlayerIucharba .include "text/dialogue/DeathQuote/Gen2Player/Iucharba.dialogue.txt" ; 8EE161
      dialogueDeathQuoteGen2PlayerScathach .include "text/dialogue/DeathQuote/Gen2Player/Scathach.dialogue.txt" ; 8EE177
      dialogueDeathQuoteGen2PlayerFebail .include "text/dialogue/DeathQuote/Gen2Player/Febail.dialogue.txt" ; 8EE19C
      dialogueDeathQuoteGen2PlayerCoirpre .include "text/dialogue/DeathQuote/Gen2Player/Coirpre.dialogue.txt" ; 8EE1B4
      dialogueDeathQuoteGen2PlayerCed .include "text/dialogue/DeathQuote/Gen2Player/Ced.dialogue.txt" ; 8EE1E0
      dialogueDeathQuoteGen2PlayerDiarmuid .include "text/dialogue/DeathQuote/Gen2Player/Diarmuid.dialogue.txt" ; 8EE209
      dialogueDeathQuoteGen2PlayerLester .include "text/dialogue/DeathQuote/Gen2Player/Lester.dialogue.txt" ; 8EE227
      dialogueDeathQuoteGen2PlayerArthur .include "text/dialogue/DeathQuote/Gen2Player/Arthur.dialogue.txt" ; 8EE245
      dialogueDeathQuoteGen2PlayerPatty .include "text/dialogue/DeathQuote/Gen2Player/Patty.dialogue.txt" ; 8EE25F
      dialogueDeathQuoteLoverLarcei .include "text/dialogue/DeathQuote/Lover/Larcei.dialogue.txt" ; 8EE279
      dialogueDeathQuoteGen2PlayerLarcei .include "text/dialogue/DeathQuote/Gen2Player/Larcei.dialogue.txt" ; 8EE295
      dialogueDeathQuoteLoverLana .include "text/dialogue/DeathQuote/Lover/Lana.dialogue.txt" ; 8EE2AB
      dialogueDeathQuoteGen2PlayerLana .include "text/dialogue/DeathQuote/Gen2Player/Lana.dialogue.txt" ; 8EE2CE
      dialogueDeathQuoteLoverFee .include "text/dialogue/DeathQuote/Lover/Fee.dialogue.txt" ; 8EE2E8
      dialogueDeathQuoteGen2PlayerFee .include "text/dialogue/DeathQuote/Gen2Player/Fee.dialogue.txt" ; 8EE304
      dialogueDeathQuoteLoverTine .include "text/dialogue/DeathQuote/Lover/Tine.dialogue.txt" ; 8EE31A
      dialogueDeathQuoteGen2PlayerTine .include "text/dialogue/DeathQuote/Gen2Player/Tine.dialogue.txt" ; 8EE337
      dialogueDeathQuoteLoverLene .include "text/dialogue/DeathQuote/Lover/Lene.dialogue.txt" ; 8EE34E
      dialogueDeathQuoteGen2PlayerLene .include "text/dialogue/DeathQuote/Gen2Player/Lene.dialogue.txt" ; 8EE362
      dialogueDeathQuoteGen2PlayerNanna .include "text/dialogue/DeathQuote/Gen2Player/Nanna.dialogue.txt" ; 8EE377

      dialogueDeathQuoteGen1EnemyNPCDiMaggio .include "text/dialogue/DeathQuote/Gen1EnemyNPC/DiMaggio.dialogue.txt" ; 8EE397
      dialogueDeathQuoteGen1EnemyNPCGerrard .include "text/dialogue/DeathQuote/Gen1EnemyNPC/Gerrard.dialogue.txt" ; 8EE3AF
      dialogueDeathQuoteGen1EnemyNPCCimbaeth .include "text/dialogue/DeathQuote/Gen1EnemyNPC/Cimbaeth.dialogue.txt" ; 8EE3EA
      dialogueDeathQuoteGen1EnemyNPCMunnir .include "text/dialogue/DeathQuote/Gen1EnemyNPC/Munnir.dialogue.txt" ; 8EE403
      dialogueDeathQuoteGen1EnemyNPCSandima .include "text/dialogue/DeathQuote/Gen1EnemyNPC/Sandima.dialogue.txt" ; 8EE426
      dialogueDeathQuoteGen1EnemyNPCAyra .include "text/dialogue/DeathQuote/Gen1EnemyNPC/Ayra.dialogue.txt" ; 8EE453
      dialogueDeathQuoteGen1EnemyNPCElliotCh01 .include "text/dialogue/DeathQuote/Gen1EnemyNPC/ElliotCh01.dialogue.txt" ; 8EE46B
      dialogueDeathQuoteGen1EnemyNPCElliotCh02 .include "text/dialogue/DeathQuote/Gen1EnemyNPC/ElliotCh02.dialogue.txt" ; 8EE4A0
      dialogueDeathQuoteGen1EnemyNPCPhilip .include "text/dialogue/DeathQuote/Gen1EnemyNPC/Philip.dialogue.txt" ; 8EE4CB
      dialogueDeathQuoteGen1EnemyNPCBordeaux .include "text/dialogue/DeathQuote/Gen1EnemyNPC/Bordeaux.dialogue.txt" ; 8EE4F2
      dialogueDeathQuoteGen1EnemyNPCMacBeth .include "text/dialogue/DeathQuote/Gen1EnemyNPC/MacBeth.dialogue.txt" ; 8EE50F
      dialogueDeathQuoteGen1EnemyNPCWaltz .include "text/dialogue/DeathQuote/Gen1EnemyNPC/Waltz.dialogue.txt" ; 8EE52C
      dialogueDeathQuoteGen1EnemyNPCBeowulf .include "text/dialogue/DeathQuote/Gen1EnemyNPC/Beowulf.dialogue.txt" ; 8EE556
      dialogueDeathQuoteGen1EnemyNPCClement .include "text/dialogue/DeathQuote/Gen1EnemyNPC/Clement.dialogue.txt" ; 8EE572
      dialogueDeathQuoteGen1EnemyNPCErinys .include "text/dialogue/DeathQuote/Gen1EnemyNPC/Erinys.dialogue.txt" ; 8EE58D
      dialogueDeathQuoteGen1EnemyNPCZane .include "text/dialogue/DeathQuote/Gen1EnemyNPC/Zane.dialogue.txt" ; 8EE5B6
      dialogueDeathQuoteGen1EnemyNPCChagallCh02 .include "text/dialogue/DeathQuote/Gen1EnemyNPC/ChagallCh02.dialogue.txt" ; 8EE5DC
      dialogueDeathQuoteGen1EnemyNPCJacobi .include "text/dialogue/DeathQuote/Gen1EnemyNPC/Jacobi.dialogue.txt" ; 8EE603
      dialogueDeathQuoteGen1EnemyNPCEldiganCh03 .include "text/dialogue/DeathQuote/Gen1EnemyNPC/EldiganCh03.dialogue.txt" ; 8EE61A
      dialogueDeathQuoteGen1EnemyNPCPapilio .include "text/dialogue/DeathQuote/Gen1EnemyNPC/Papilio.dialogue.txt" ; 8EE63D
      dialogueDeathQuoteGen1EnemyNPCChagallCh03 .include "text/dialogue/DeathQuote/Gen1EnemyNPC/ChagallCh03.dialogue.txt" ; 8EE664
      dialogueDeathQuoteGen1EnemyNPCPizare .include "text/dialogue/DeathQuote/Gen1EnemyNPC/Pizare.dialogue.txt" ; 8EE688
      dialogueDeathQuoteGen1EnemyNPCDuvall .include "text/dialogue/DeathQuote/Gen1EnemyNPC/Duvall.dialogue.txt" ; 8EE6B1
      dialogueDeathQuoteGen1EnemyNPCCuvuli .include "text/dialogue/DeathQuote/Gen1EnemyNPC/Cuvuli.dialogue.txt" ; 8EE6C6
      dialogueDeathQuoteGen1EnemyNPCDithorba .include "text/dialogue/DeathQuote/Gen1EnemyNPC/Dithorba.dialogue.txt" ; 8EE6E9
      dialogueDeathQuoteGen1EnemyNPCMyos .include "text/dialogue/DeathQuote/Gen1EnemyNPC/Myos.dialogue.txt" ; 8EE707
      dialogueDeathQuoteGen1EnemyNPCAnnand .include "text/dialogue/DeathQuote/Gen1EnemyNPC/Annand.dialogue.txt" ; 8EE722
      dialogueDeathQuoteGen1EnemyNPCPamela .include "text/dialogue/DeathQuote/Gen1EnemyNPC/Pamela.dialogue.txt" ; 8EE748
      dialogueDeathQuoteGen1EnemyNPCDonovan .include "text/dialogue/DeathQuote/Gen1EnemyNPC/Donovan.dialogue.txt" ; 8EE75D
      dialogueDeathQuoteGen1EnemyNPCDaccar .include "text/dialogue/DeathQuote/Gen1EnemyNPC/Daccar.dialogue.txt" ; 8EE77F
      dialogueDeathQuoteGen1EnemyNPCLamia .include "text/dialogue/DeathQuote/Gen1EnemyNPC/Lamia.dialogue.txt" ; 8EE7A4
      dialogueDeathQuoteGen1EnemyNPCByron .include "text/dialogue/DeathQuote/Gen1EnemyNPC/Byron.dialogue.txt" ; 8EE7B9
      dialogueDeathQuoteGen1EnemyNPCSlayder .include "text/dialogue/DeathQuote/Gen1EnemyNPC/Slayder.dialogue.txt" ; 8EE7D3
      dialogueDeathQuoteGen1EnemyNPCAndreyCh05 .include "text/dialogue/DeathQuote/Gen1EnemyNPC/AndreyCh05.dialogue.txt" ; 8EE7EC
      dialogueDeathQuoteGen1EnemyNPCLombardCh05 .include "text/dialogue/DeathQuote/Gen1EnemyNPC/LombardCh05.dialogue.txt" ; 8EE81B
      dialogueDeathQuoteGen1EnemyNPCVaja .include "text/dialogue/DeathQuote/Gen1EnemyNPC/Vaja.dialogue.txt" ; 8EE851
      dialogueDeathQuoteGen1EnemyNPCMagorn .include "text/dialogue/DeathQuote/Gen1EnemyNPC/Magorn.dialogue.txt" ; 8EE877
      dialogueDeathQuoteGen1EnemyNPCReptorCh05 .include "text/dialogue/DeathQuote/Gen1EnemyNPC/ReptorCh05.dialogue.txt" ; 8EE895
      dialogueDeathQuoteGen1EnemyNPCReptorCh05PreBetrayal .include "text/dialogue/DeathQuote/Gen1EnemyNPC/ReptorCh05PreBetrayal.dialogue.txt" ; 8EE8BE
      dialogueDeathQuoteGen1EnemyNPCEthlyn .include "text/dialogue/DeathQuote/Gen1EnemyNPC/Ethlyn.dialogue.txt" ; 8EE8DB
      dialogueDeathQuoteGen1EnemyNPCQuan .include "text/dialogue/DeathQuote/Gen1EnemyNPC/Quan.dialogue.txt" ; 8EE909

      dialogueDeathQuoteGen2EnemyNPCHarold .include "text/dialogue/DeathQuote/Gen2EnemyNPC/Harold.dialogue.txt" ; 8EE935
      dialogueDeathQuoteGen2EnemyNPCIucharba .include "text/dialogue/DeathQuote/Gen2EnemyNPC/Iucharba.dialogue.txt" ; 8EE96D
      dialogueDeathQuoteGen2EnemyNPCIuchar .include "text/dialogue/DeathQuote/Gen2EnemyNPC/Iuchar.dialogue.txt" ; 8EE98E
      dialogueDeathQuoteGen2EnemyNPCSchmidt .include "text/dialogue/DeathQuote/Gen2EnemyNPC/Schmidt.dialogue.txt" ; 8EE9C8
      dialogueDeathQuoteGen2EnemyNPCDanann .include "text/dialogue/DeathQuote/Gen2EnemyNPC/Danann.dialogue.txt" ; 8EE9E5
      dialogueDeathQuoteGen2EnemyNPCKutuzov .include "text/dialogue/DeathQuote/Gen2EnemyNPC/Kutuzov.dialogue.txt" ; 8EEA05
      dialogueDeathQuoteGen2EnemyNPCLiza .include "text/dialogue/DeathQuote/Gen2EnemyNPC/Liza.dialogue.txt" ; 8EEA27
      dialogueDeathQuoteGen2EnemyNPCIshtoreLizaDead .include "text/dialogue/DeathQuote/Gen2EnemyNPC/IshtoreLizaDead.dialogue.txt" ; 8EEA40
      dialogueDeathQuoteGen2EnemyNPCIshtoreLizaAlive .include "text/dialogue/DeathQuote/Gen2EnemyNPC/IshtoreLizaAlive.dialogue.txt" ; 8EEA5A
      dialogueDeathQuoteGen2EnemyNPCJavarro .include "text/dialogue/DeathQuote/Gen2EnemyNPC/Javarro.dialogue.txt" ; 8EEA7C
      dialogueDeathQuoteGen2EnemyNPCBramsel .include "text/dialogue/DeathQuote/Gen2EnemyNPC/Bramsel.dialogue.txt" ; 8EEA96
      dialogueDeathQuoteGen2EnemyNPCBanbaCh07 .include "text/dialogue/DeathQuote/Gen2EnemyNPC/BanbaCh07.dialogue.txt" ; 8EEABF
      dialogueDeathQuoteGen2EnemyNPCFotlaCh07 .include "text/dialogue/DeathQuote/Gen2EnemyNPC/FotlaCh07.dialogue.txt" ; 8EEADC
      dialogueDeathQuoteGen2EnemyNPCEriuCh07 .include "text/dialogue/DeathQuote/Gen2EnemyNPC/EriuCh07.dialogue.txt" ; 8EEAF9
      dialogueDeathQuoteGen2EnemyNPCTine .include "text/dialogue/DeathQuote/Gen2EnemyNPC/Tine.dialogue.txt" ; 8EEB16
      dialogueDeathQuoteGen2EnemyNPCBloomCh07 .include "text/dialogue/DeathQuote/Gen2EnemyNPC/BloomCh07.dialogue.txt" ; 8EEB28
      dialogueDeathQuoteGen2EnemyNPCIshtarCh08 .include "text/dialogue/DeathQuote/Gen2EnemyNPC/IshtarCh08.dialogue.txt" ; 8EEB5E
      dialogueDeathQuoteGen2EnemyNPCFebail .include "text/dialogue/DeathQuote/Gen2EnemyNPC/Febail.dialogue.txt" ; 8EEB7A
      dialogueDeathQuoteGen2EnemyNPCMuhammad .include "text/dialogue/DeathQuote/Gen2EnemyNPC/Muhammad.dialogue.txt" ; 8EEB9C
      dialogueDeathQuoteGen2EnemyNPCOvo .include "text/dialogue/DeathQuote/Gen2EnemyNPC/Ovo.dialogue.txt" ; 8EEBD2
      dialogueDeathQuoteGen2EnemyNPCBanbaCh08 .include "text/dialogue/DeathQuote/Gen2EnemyNPC/BanbaCh08.dialogue.txt" ; 8EEBE7
      dialogueDeathQuoteGen2EnemyNPCFotlaCh08 .include "text/dialogue/DeathQuote/Gen2EnemyNPC/FotlaCh08.dialogue.txt" ; 8EEC0C
      dialogueDeathQuoteGen2EnemyNPCEriuCh08 .include "text/dialogue/DeathQuote/Gen2EnemyNPC/EriuCh08.dialogue.txt" ; 8EEC28
      dialogueDeathQuoteGen2EnemyNPCBloomCh08 .include "text/dialogue/DeathQuote/Gen2EnemyNPC/BloomCh08.dialogue.txt" ; 8EEC4B
      dialogueDeathQuoteGen2EnemyNPCCoulter .include "text/dialogue/DeathQuote/Gen2EnemyNPC/Coulter.dialogue.txt" ; 8EEC67
      dialogueDeathQuoteGen2EnemyNPCMaykov .include "text/dialogue/DeathQuote/Gen2EnemyNPC/Maykov.dialogue.txt" ; 8EEC87
      dialogueDeathQuoteGen2EnemyNPCAltena .include "text/dialogue/DeathQuote/Gen2EnemyNPC/Altena.dialogue.txt" ; 8EECA4
      dialogueDeathQuoteGen2EnemyNPCHannibal .include "text/dialogue/DeathQuote/Gen2EnemyNPC/Hannibal.dialogue.txt" ; 8EECC5
      dialogueDeathQuoteGen2EnemyNPCKanatz .include "text/dialogue/DeathQuote/Gen2EnemyNPC/Kanatz.dialogue.txt" ; 8EECE6
      dialogueDeathQuoteGen2EnemyNPCDistler .include "text/dialogue/DeathQuote/Gen2EnemyNPC/Distler.dialogue.txt" ; 8EED08
      dialogueDeathQuoteGen2EnemyNPCMusar .include "text/dialogue/DeathQuote/Gen2EnemyNPC/Musar.dialogue.txt" ; 8EED2E
      dialogueDeathQuoteGen2EnemyNPCJudah .include "text/dialogue/DeathQuote/Gen2EnemyNPC/Judah.dialogue.txt" ; 8EED4C
      dialogueDeathQuoteGen2EnemyNPCArionCh09 .include "text/dialogue/DeathQuote/Gen2EnemyNPC/ArionCh09.dialogue.txt" ; 8EED7E
      dialogueDeathQuoteGen2EnemyNPCTravantCh09 .include "text/dialogue/DeathQuote/Gen2EnemyNPC/TravantCh09.dialogue.txt" ; 8EEDAF
      dialogueDeathQuoteGen2EnemyNPCRiddell .include "text/dialogue/DeathQuote/Gen2EnemyNPC/Riddell.dialogue.txt" ; 8EEDD7
      dialogueDeathQuoteGen2EnemyNPCHildaCh10 .include "text/dialogue/DeathQuote/Gen2EnemyNPC/HildaCh10.dialogue.txt" ; 8EEDF4
      dialogueDeathQuoteGen2EnemyNPCMorrigan .include "text/dialogue/DeathQuote/Gen2EnemyNPC/Morrigan.dialogue.txt" ; 8EEE24
      dialogueDeathQuoteGen2EnemyNPCJuliusCh10 .include "text/dialogue/DeathQuote/Gen2EnemyNPC/JuliusCh10.dialogue.txt" ; 8EEE4A
      dialogueDeathQuoteGen2EnemyNPCIshtarCh10 .include "text/dialogue/DeathQuote/Gen2EnemyNPC/IshtarCh10.dialogue.txt" ; 8EEE67
      dialogueDeathQuoteGen2EnemyNPCZagam .include "text/dialogue/DeathQuote/Gen2EnemyNPC/Zagam.dialogue.txt" ; 8EEE7C
      dialogueDeathQuoteGen2EnemyNPCArvisCh10 .include "text/dialogue/DeathQuote/Gen2EnemyNPC/ArvisCh10.dialogue.txt" ; 8EEEA1
      dialogueDeathQuoteGen2EnemyNPCArvisCh10Unused .include "text/dialogue/DeathQuote/Gen2EnemyNPC/ArvisCh10Unused.dialogue.txt" ; 8EEEBF
      dialogueDeathQuoteGen2EnemyNPCRoberto .include "text/dialogue/DeathQuote/Gen2EnemyNPC/Roberto.dialogue.txt" ; 8EEEE9
      dialogueDeathQuoteGen2EnemyNPCBoyce .include "text/dialogue/DeathQuote/Gen2EnemyNPC/Boyce.dialogue.txt" ; 8EEF05
      dialogueDeathQuoteGen2EnemyNPCRodan .include "text/dialogue/DeathQuote/Gen2EnemyNPC/Rodan.dialogue.txt" ; 8EEF22
      dialogueDeathQuoteGen2EnemyNPCJuphiel .include "text/dialogue/DeathQuote/Gen2EnemyNPC/Juphiel.dialogue.txt" ; 8EEF3F
      dialogueDeathQuoteGen2EnemyNPCFisher .include "text/dialogue/DeathQuote/Gen2EnemyNPC/Fisher.dialogue.txt" ; 8EEF66
      dialogueDeathQuoteGen2EnemyNPCBrian .include "text/dialogue/DeathQuote/Gen2EnemyNPC/Brian.dialogue.txt" ; 8EEF7E
      dialogueDeathQuoteGen2EnemyNPCDagon .include "text/dialogue/DeathQuote/Gen2EnemyNPC/Dagon.dialogue.txt" ; 8EEFBA
      dialogueDeathQuoteGen2EnemyNPCHildaChFinal .include "text/dialogue/DeathQuote/Gen2EnemyNPC/HildaChFinal.dialogue.txt" ; 8EEFE1
      dialogueDeathQuoteGen2EnemyNPCScipio .include "text/dialogue/DeathQuote/Gen2EnemyNPC/Scipio.dialogue.txt" ; 8EF012
      dialogueDeathQuoteGen2EnemyNPCBaran .include "text/dialogue/DeathQuote/Gen2EnemyNPC/Baran.dialogue.txt" ; 8EF02D
      dialogueDeathQuoteGen2EnemyNPCMeng .include "text/dialogue/DeathQuote/Gen2EnemyNPC/Meng.dialogue.txt" ; 8EF054
      dialogueDeathQuoteGen2EnemyNPCMabel .include "text/dialogue/DeathQuote/Gen2EnemyNPC/Mabel.dialogue.txt" ; 8EF073
      dialogueDeathQuoteGen2EnemyNPCBleg .include "text/dialogue/DeathQuote/Gen2EnemyNPC/Bleg.dialogue.txt" ; 8EF096
      dialogueDeathQuoteGen2EnemyNPCArionChFinal .include "text/dialogue/DeathQuote/Gen2EnemyNPC/ArionChFinal.dialogue.txt" ; 8EF0B5
      dialogueDeathQuoteGen2EnemyNPCIshtarChFinal .include "text/dialogue/DeathQuote/Gen2EnemyNPC/IshtarChFinal.dialogue.txt" ; 8EF0CD
      dialogueDeathQuoteGen2EnemyNPCManfroy .include "text/dialogue/DeathQuote/Gen2EnemyNPC/Manfroy.dialogue.txt" ; 8EF0EB
      dialogueDeathQuoteGen2EnemyNPCJuliusChFinalDefault .include "text/dialogue/DeathQuote/Gen2EnemyNPC/JuliusChFinalDefault.dialogue.txt" ; 8EF111
      dialogueDeathQuoteGen2EnemyNPCJuliusChFinalJulia .include "text/dialogue/DeathQuote/Gen2EnemyNPC/JuliusChFinalJulia.dialogue.txt" ; 8EF134
      dialogueDeathQuoteGen2EnemyNPCJuliusChFinalSeliph .include "text/dialogue/DeathQuote/Gen2EnemyNPC/JuliusChFinalSeliph.dialogue.txt" ; 8EF165

      aGen1PlayerDeathQuotes .binclude "data/character/Gen1PlayerDeathQuoteTable.csv.asm" ; 8E/F1DA
      .word 0
      aGen2PlayerDeathQuotes .binclude "data/character/Gen2PlayerDeathQuoteTable.csv.asm" ; 8E/F248
      .word 0
      aLoverDeathQuotes .binclude "data/character/LoverDeathQuoteTable.csv.asm" ; 8E/F2E6
      .word 0
      aGen1EnemyNPCDeathQuotes .binclude "data/character/Gen1EnemyNPCDeathQuoteTable.csv.asm" ; 8E/F328
      .word 0
      aGen2EnemyNPCDeathQuotes .binclude "data/character/Gen2EnemyNPCDeathQuoteTable.csv.asm" ; 8E/F3CE
      .word 0

      .fill $8E8000 + $8000 - *, 0

    .here

    * = $0F8000
    .logical $8F8000

      .dsection Unsorted8F8000Section

      dialogueChapter02Opening1 .include "text/dialogue/Chapter02/Opening1.dialogue.txt" ; 8F806B
      dialogueChapter02Opening2 .include "text/dialogue/Chapter02/Opening2.dialogue.txt" ; 8F823F
      dialogueChapter02Opening3 .include "text/dialogue/Chapter02/Opening3.dialogue.txt" ; 8F8543
      dialogueChapter02Opening5 .include "text/dialogue/Chapter02/Opening5.dialogue.txt" ; 8F881B
      dialogueChapter02Opening4 .include "text/dialogue/Chapter02/Opening4.dialogue.txt" ; 8F8AC8
      dialogueChapter02InfiniBrigandsSpawn .include "text/dialogue/Chapter02/InfiniBrigandsSpawn.dialogue.txt" ; 8F8B5A
      dialogueChapter02MackilyWorried .include "text/dialogue/Chapter02/MackilyWorried.dialogue.txt" ; 8F8BFA
      dialogueChapter02ElliotCharge .include "text/dialogue/Chapter02/ElliotCharge.dialogue.txt" ; 8F8C6C
      dialogueChapter02PhilipDefend .include "text/dialogue/Chapter02/PhilipDefend.dialogue.txt" ; 8F8D0E
      dialogueChapter02ElliotBattleQuote .include "text/dialogue/Chapter02/ElliotBattleQuote.dialogue.txt" ; 8F8D5E
      dialogueChapter02PhilipBattleQuote .include "text/dialogue/Chapter02/PhilipBattleQuote.dialogue.txt" ; 8F8D95
      dialogueChapter02BordeauxBattleQuote .include "text/dialogue/Chapter02/BordeauxBattleQuote.dialogue.txt" ; 8F8DCA
      dialogueChapter02LewynSilviaSpawn .include "text/dialogue/Chapter02/LewynSilviaSpawn.dialogue.txt" ; 8F8E12
      dialogueChapter02InfiniSpawn1 .include "text/dialogue/Chapter02/InfiniSpawn1.dialogue.txt" ; 8F91EA
      dialogueChapter02AgustiSpawn2 .include "text/dialogue/Chapter02/AgustiSpawn2.dialogue.txt" ; 8F928A
      dialogueChapter02InfiniSpawn2 .include "text/dialogue/Chapter02/InfiniSpawn2.dialogue.txt" ; 8F92B6
      dialogueChapter02WaltzCharge .include "text/dialogue/Chapter02/WaltzCharge.dialogue.txt" ; 8F9439
      dialogueChapter02SigurdLachesisTalk .include "text/dialogue/Chapter02/SigurdLachesisTalk.dialogue.txt" ; 8F9478
      dialogueChapter02BeowulfTalkSuccess .include "text/dialogue/Chapter02/BeowulfTalkSuccess.dialogue.txt" ; 8F9678
      dialogueChapter02BeowulfTalkNoMoney .include "text/dialogue/Chapter02/BeowulfTalkNoMoney.dialogue.txt" ; 8F96D5
      dialogueChapter02WaltzBattleQuote .include "text/dialogue/Chapter02/WaltzBattleQuote.dialogue.txt" ; 8F9712
      dialogueChapter02BeowulfBattleQuote .include "text/dialogue/Chapter02/BeowulfBattleQuote.dialogue.txt" ; 8F9731
      dialogueChapter02InfiniSeized .include "text/dialogue/Chapter02/InfiniSeized.dialogue.txt" ; 8F975A
      dialogueChapter02MackilySpawn1 .include "text/dialogue/Chapter02/MackilySpawn1.dialogue.txt" ; 8F9DE1
      dialogueChapter02MacBethBattleQuote .include "text/dialogue/Chapter02/MacBethBattleQuote.dialogue.txt" ; 8F9E61
      dialogueChapter02MackilySpawn2 .include "text/dialogue/Chapter02/MackilySpawn2.dialogue.txt" ; 8F9EB2
      dialogueChapter02MackilySpawn3 .include "text/dialogue/Chapter02/MackilySpawn3.dialogue.txt" ; 8FA0BC
      dialogueChapter02HeirheinSeized .include "text/dialogue/Chapter02/HeirheinSeized.dialogue.txt" ; 8FA101
      dialogueChapter02ClementBattleQuote .include "text/dialogue/Chapter02/ClementBattleQuote.dialogue.txt" ; 8FA22A
      dialogueChapter02MackilySeized .include "text/dialogue/Chapter02/MackilySeized.dialogue.txt" ; 8FA261
      dialogueChapter02AgustiSpawn1 .include "text/dialogue/Chapter02/AgustiSpawn1.dialogue.txt" ; 8FA301
      dialogueChapter02ZaneBattleQuote .include "text/dialogue/Chapter02/ZaneBattleQuote.dialogue.txt" ; 8FA722
      dialogueChapter02ChulainnRecruitment .include "text/dialogue/Chapter02/ChulainnRecruitment.dialogue.txt" ; 8FA75D
      dialogueChapter02ChagallBattleQuote .include "text/dialogue/Chapter02/ChagallBattleQuote.dialogue.txt" ; 8FA851
      dialogueChapter02LewynErinysTalk .include "text/dialogue/Chapter02/LewynErinysTalk.dialogue.txt" ; 8FA878
      dialogueChapter02ErinysBattleQuote .include "text/dialogue/Chapter02/ErinysBattleQuote.dialogue.txt" ; 8FAE18
      dialogueChapter02LewynErinysBattleQuote .include "text/dialogue/Chapter02/LewynErinysBattleQuote.dialogue.txt" ; 8FAE41
      dialogueChapter02ErinysGroupArrive .include "text/dialogue/Chapter02/ErinysGroupArrive.dialogue.txt" ; 8FAE64
      dialogueChapter02Ending .include "text/dialogue/Chapter02/Ending.dialogue.txt" ; 8FAEB4
      dialogueChapter02Village8 .include "text/dialogue/Chapter02/Village8.dialogue.txt" ; 8FB2D7
      dialogueChapter02VillageBargainBand .include "text/dialogue/Chapter02/VillageBargainBand.dialogue.txt" ; 8FB31A
      dialogueChapter02VillageArmorslayer .include "text/dialogue/Chapter02/VillageArmorslayer.dialogue.txt" ; 8FB379
      dialogueChapter02Village5 .include "text/dialogue/Chapter02/Village5.dialogue.txt" ; 8FB40D
      dialogueChapter02Village2 .include "text/dialogue/Chapter02/Village2.dialogue.txt" ; 8FB461
      dialogueChapter02Village4 .include "text/dialogue/Chapter02/Village4.dialogue.txt" ; 8FB4FE
      dialogueChapter02Village6 .include "text/dialogue/Chapter02/Village6.dialogue.txt" ; 8FB59B
      dialogueChapter02Village7 .include "text/dialogue/Chapter02/Village7.dialogue.txt" ; 8FB623
      dialogueChapter02Village1 .include "text/dialogue/Chapter02/Village1.dialogue.txt" ; 8FB6AD
      dialogueChapter02Village3 .include "text/dialogue/Chapter02/Village3.dialogue.txt" ; 8FB728
      dialogueChapter02EndingKnightRing .include "text/dialogue/Chapter02/EndingKnightRing.dialogue.txt" ; 8FB77F

      .include "events/Chapter08/EventChapter08Opening.asm"
      .include "events/Chapter08/EventChapter08MuhammadCharge.asm"
      .include "events/Chapter08/EventChapter08OvoCharge.asm"
      .include "events/Chapter08/EventChapter08BanbaCharge.asm"
      .include "events/Chapter08/EventChapter08FebailAsaello_Spawn.asm"
      .include "events/Chapter08/EventChapter08IshtarSpawn.asm"
      .include "events/Chapter08/EventChapter08IshtarLeave.asm"
      .include "events/Chapter08/EventChapter08ConnachtSeized.asm"
      .include "events/Chapter08/EventChapter08_12C.asm"
      .include "events/Chapter08/EventChapter08MeathSpawn.asm"
      .include "events/Chapter08/EventChapter08CoulterCharge.asm"
      .include "events/Chapter08/EventChapter08MunsterSavedMaykovReaction.asm"
      .include "events/Chapter08/EventChapter08Ending.asm"
      .include "events/Chapter08/EventChapter08PattyDaisy_FebailAsaelloTalk.asm"
      .include "events/Chapter08/EventChapter08Seliph_CedHawkTalk.asm"
      .include "events/Chapter08/EventChapter08Village1.asm"
      .include "events/Chapter08/EventChapter08VillagePowerRing.asm"
      .include "events/Chapter08/EventChapter08Village2.asm"
      .include "events/Chapter08/EventChapter08Village3.asm"
      .include "events/Chapter08/EventChapter08Village4.asm"
      .include "events/Chapter08/EventChapter08VillageThiefBand.asm"
      .include "events/Chapter08/EventChapter08IshtarDied.asm"
      .include "events/Chapter08/EventChapter08CivilianRescued1.asm"
      .include "events/Chapter08/EventChapter08CivilianRescued2.asm"
      .include "events/Chapter08/EventChapter08CivilianRescued3.asm"
      .include "events/Chapter08/EventChapter08CivilianRescued4.asm"
      .include "events/Chapter08/EventChapter08CivilianRescued5.asm"
      .include "events/Chapter08/EventChapter08CivilianRescued6.asm"
      .include "events/Chapter08/EventChapter08_140.asm"
      .include "events/Chapter08/EventChapter08Village3Asaello.asm"
      .include "events/Chapter08/EventChapter08LeifNearMountain.asm"
      .include "events/Chapter08/EventChapter08FeeOnMountain.asm"
      .include "events/Chapter08/EventChapter08MuirneSeliphAdjacent.asm"
      .include "events/Chapter08/EventChapter08LindaOnTree.asm"
      .include "events/Chapter08/EventChapter08AmidOnTree.asm"

      dialogueChapter08Opening1 .include "text/dialogue/Chapter08/Opening1.dialogue.txt" ; 8FC115
      dialogueChapter08Opening2 .include "text/dialogue/Chapter08/Opening2.dialogue.txt" ; 8FC2E9
      dialogueChapter08Opening3 .include "text/dialogue/Chapter08/Opening3.dialogue.txt" ; 8FC3B8
      dialogueChapter08Opening4 .include "text/dialogue/Chapter08/Opening4.dialogue.txt" ; 8FC660
      dialogueChapter08MuhammadCharge .include "text/dialogue/Chapter08/MuhammadCharge.dialogue.txt" ; 8FC741
      dialogueChapter08OvoCharge .include "text/dialogue/Chapter08/OvoCharge.dialogue.txt" ; 8FC79D
      dialogueChapter08BanbaCharge .include "text/dialogue/Chapter08/BanbaCharge.dialogue.txt" ; 8FC7E3
      dialogueChapter08FebailAsaello_Spawn .include "text/dialogue/Chapter08/FebailAsaello_Spawn.dialogue.txt" ; 8FC817
      dialogueChapter08IshtarSpawn .include "text/dialogue/Chapter08/IshtarSpawn.dialogue.txt" ; 8FCA0D
      dialogueChapter08IshtarLeave .include "text/dialogue/Chapter08/IshtarLeave.dialogue.txt" ; 8FCBB2
      dialogueChapter08ConnachtSeized .include "text/dialogue/Chapter08/ConnachtSeized.dialogue.txt" ; 8FCC47

      .word $02C5

      dialogueChapter08MeathSpawn1 .include "text/dialogue/Chapter08/MeathSpawn1.dialogue.txt" ; 8FCD86
      dialogueChapter08MeathSpawn2 .include "text/dialogue/Chapter08/MeathSpawn2.dialogue.txt" ; 8FCF81
      dialogueChapter08MeathSpawn3 .include "text/dialogue/Chapter08/MeathSpawn3.dialogue.txt" ; 8FD0A0
      dialogueChapter08CoulterCharge .include "text/dialogue/Chapter08/CoulterCharge.dialogue.txt" ; 8FD254
      dialogueChapter08MunsterSavedMaykovReaction .include "text/dialogue/Chapter08/MunsterSavedMaykovReaction.dialogue.txt" ; 8FD3CD
      dialogueChapter08Ending .include "text/dialogue/Chapter08/Ending.dialogue.txt" ; 8FD44D
      dialogueChapter08EndingAltena .include "text/dialogue/Chapter08/EndingAltena.dialogue.txt" ; 8FD69C
      dialogueChapter08PattyDaisy_FebailAsaelloTalk .include "text/dialogue/Chapter08/PattyDaisy_FebailAsaelloTalk.dialogue.txt" ; 8FD6D2
      dialogueChapter08Seliph_CedHawkTalk .include "text/dialogue/Chapter08/Seliph_CedHawkTalk.dialogue.txt" ; 8FD86E
      dialogueChapter08CivilianRescued1 .include "text/dialogue/Chapter08/CivilianRescued1.dialogue.txt" ; 8FD9FF
      dialogueChapter08CivilianRescued2 .include "text/dialogue/Chapter08/CivilianRescued2.dialogue.txt" ; 8FDA24
      dialogueChapter08CivilianRescued3 .include "text/dialogue/Chapter08/CivilianRescued3.dialogue.txt" ; 8FDA3C
      dialogueChapter08CivilianRescued4 .include "text/dialogue/Chapter08/CivilianRescued4.dialogue.txt" ; 8FDA53
      dialogueChapter08CivilianRescued5 .include "text/dialogue/Chapter08/CivilianRescued5.dialogue.txt" ; 8FDA76
      dialogueChapter08CivilianRescued6 .include "text/dialogue/Chapter08/CivilianRescued6.dialogue.txt" ; 8FDA98
      dialogueChapter08VillagePowerRing .include "text/dialogue/Chapter08/VillagePowerRing.dialogue.txt" ; 8FDAC4
      dialogueChapter08Village1 .include "text/dialogue/Chapter08/Village1.dialogue.txt" ; 8FDB4F
      dialogueChapter08Village2 .include "text/dialogue/Chapter08/Village2.dialogue.txt" ; 8FDBE2
      dialogueChapter08Village3 .include "text/dialogue/Chapter08/Village3.dialogue.txt" ; 8FDC92
      dialogueChapter08Village4 .include "text/dialogue/Chapter08/Village4.dialogue.txt" ; 8FDCF4
      dialogueChapter08VillageThiefBand .include "text/dialogue/Chapter08/VillageThiefBand.dialogue.txt" ; 8FDD74
      dialogueChapter08IshtarBattleQuote .include "text/dialogue/Chapter08/IshtarBattleQuote.dialogue.txt" ; 8FDE09
      dialogueChapter08FebailAsaello_BattleQuote .include "text/dialogue/Chapter08/FebailAsaello_BattleQuote.dialogue.txt" ; 8FDE2E
      dialogueChapter08PattyDaisy_FebailAsaelloBattleQuote .include "text/dialogue/Chapter08/PattyDaisy_FebailAsaelloBattleQuote.dialogue.txt" ; 8FDE4E
      dialogueChapter08MuhammadBattleQuote .include "text/dialogue/Chapter08/MuhammadBattleQuote.dialogue.txt" ; 8FDE71
      dialogueChapter08OvoBattleQuote .include "text/dialogue/Chapter08/OvoBattleQuote.dialogue.txt" ; 8FDE8B
      dialogueChapter08BanbaTriangleAttack .include "text/dialogue/Chapter08/BanbaTriangleAttack.dialogue.txt" ; 8FDEAE
      dialogueChapter08BanbaBattleQuote .include "text/dialogue/Chapter08/BanbaBattleQuote.dialogue.txt" ; 8FDEDB
      dialogueChapter08FotlaTriangleAttack .include "text/dialogue/Chapter08/FotlaTriangleAttack.dialogue.txt" ; 8FDEF4
      dialogueChapter08FotlaBattleQuote .include "text/dialogue/Chapter08/FotlaBattleQuote.dialogue.txt" ; 8FDF21
      dialogueChapter08EriuTriangleAttack .include "text/dialogue/Chapter08/EriuTriangleAttack.dialogue.txt" ; 8FDF39
      dialogueChapter08EriuBattleQuote .include "text/dialogue/Chapter08/EriuBattleQuote.dialogue.txt" ; 8FDF68
      dialogueChapter08BloomBattleQuote .include "text/dialogue/Chapter08/BloomBattleQuote.dialogue.txt" ; 8FDF83
      dialogueChapter08CoulterBattleQuote .include "text/dialogue/Chapter08/CoulterBattleQuote.dialogue.txt" ; 8FDFAF
      dialogueChapter08MaykovBattleQuote .include "text/dialogue/Chapter08/MaykovBattleQuote.dialogue.txt" ; 8FDFD0
      dialogueChapter08PlaceholderTitle .include "text/dialogue/Chapter08/PlaceholderTitle.dialogue.txt" ; 8FDFFA
      dialogueChapter08WorldMap1 .include "text/dialogue/Chapter08/WorldMap1.dialogue.txt" ; 8FDFFF
      dialogueChapter08WorldMap2 .include "text/dialogue/Chapter08/WorldMap2.dialogue.txt" ; 8FE046
      dialogueChapter08WorldMap3 .include "text/dialogue/Chapter08/WorldMap3.dialogue.txt" ; 8FE0DA

      dialogueChapter09WorldMap1 .include "text/dialogue/Chapter09/WorldMap1.dialogue.txt" ; 8FE3DF
      dialogueChapter09WorldMap2 .include "text/dialogue/Chapter09/WorldMap2.dialogue.txt" ; 8FE4C5

      dialogueChapterFinalWorldMap1 .include "text/dialogue/ChapterFinal/WorldMap1.dialogue.txt" ; 8FE65F
      dialogueChapterFinalWorldMap2 .include "text/dialogue/ChapterFinal/WorldMap2.dialogue.txt" ; 8FE6CC
      dialogueChapterFinalWorldMap3 .include "text/dialogue/ChapterFinal/WorldMap3.dialogue.txt" ; 8FE6F5
      dialogueChapterFinalWorldMap4 .include "text/dialogue/ChapterFinal/WorldMap4.dialogue.txt" ; 8FE728

      aEventPointers .include "data/chapter/EventPointers.csv.asm"

      .include "events/General/EventDebug8FEF78.asm"
      .include "events/General/EventSigurdDeathReaction.asm"
      .include "events/General/EventGen1HomeCastleSeized.asm"
      .include "events/General/EventSeliphDeathReaction.asm"
      .include "events/General/EventGen2HomeCastleSeized.asm"

      .include "events/Chapter06/EventChapter06OifeySeliphTalk.asm"
      .include "events/Chapter06/EventChapter06LesterLanaTalk.asm"
      .include "events/Chapter06/EventChapter06FeeSeliphTalk.asm"
      .include "events/Chapter06/EventChapter06LanaMuirne_JuliaTalk.asm"
      .include "events/Chapter06/EventChapter06ScathachLarceiTalk.asm"
      .include "events/Chapter06/EventChapter06ArthurAmid_SeliphTalk.asm"
      .include "events/Chapter06/EventChapter06DeimneMuirneTalk.asm"
      .include "events/Chapter06/EventChapter06DalvinCreidneTalk.asm"
      .include "events/Chapter06/EventChapter06Seliph_LanaMuirneTalk.asm"
      .include "events/Chapter06/EventChapter06JuliaSeliphTalk.asm"

      .include "events/Chapter07/EventChapter07Shannan_PattyDaisyTalk.asm"
      .include "events/Chapter07/EventChapter07SeliphShannanTalk.asm"
      .include "events/Chapter07/EventChapter07Oifey_DiarmuidTristanTalk.asm"
      .include "events/Chapter07/EventChapter07LarceiCreidne_ShannanTalk.asm"
      .include "events/Chapter07/EventChapter07PattyDaisy_SeliphTalk.asm"
      .include "events/Chapter07/EventChapter07AresSeliphTalk.asm"
      .include "events/Chapter07/EventChapter07LeifSeliphTalk.asm"
      .include "events/Chapter07/EventChapter07DiarmuidNannaTalk.asm"
      .include "events/Chapter07/EventChapter07TristanJeanneTalk.asm"
      .include "events/Chapter07/EventChapter07TineLinda_SeliphTalk.asm"
      .include "events/Chapter07/EventChapter07LeneLaylea_SeliphTalk.asm"
      .include "events/Chapter07/EventChapter07FinnNannaTalk.asm"
      .include "events/Chapter07/EventChapter07FinnLanaTalk.asm"
      .include "events/Chapter07/EventChapter07FinnLarceiTalk.asm"

      .include "events/Chapter08/EventChapter08FebailAsaello_SeliphTalk.asm"
      .include "events/Chapter08/EventChapter08HerminaHawkTalk.asm"
      .include "events/Chapter08/EventChapter08FeeCedTalk.asm"
      .include "events/Chapter08/EventChapter08NannaAresTalk.asm"
      .include "events/Chapter08/EventChapter08CedSeliphTalk.asm"
      .include "events/Chapter08/EventChapter08Seliph_TineLindaTalk.asm"
      .include "events/Chapter08/EventChapter08JuliaSeliphTalk.asm"
      .include "events/Chapter08/EventChapter08ArthurAmid_FeeHerminaTalk.asm"
      .include "events/Chapter08/EventChapter08FinnLeifTalk.asm"

      .include "events/Chapter09/EventChapter09FebailPattyTalk.asm"
      .include "events/Chapter09/EventChapter09SeliphHannibalTalk.asm"
      .include "events/Chapter09/EventChapter09LeneCoirpreTalk.asm"
      .include "events/Chapter09/EventChapter09FinnAltenaTalk.asm"
      .include "events/Chapter09/EventChapter09HannibalAltenaTalk.asm"
      .include "events/Chapter09/EventChapter09PattyDaisy_CoirpreCharlotTalk.asm"
      .include "events/Chapter09/EventChapter09JuliaSeliphTalk.asm"

      .include "events/Chapter10/EventChapter10LeifAltenaTalk.asm"
      .include "events/Chapter10/EventChapter10ShannanSeliphTalk.asm"
      .include "events/Chapter10/EventChapter10OifeySeliphTalk.asm"
      .include "events/Chapter10/EventChapter10CoirpreCharlot_AltenaTalk.asm"
      .include "events/Chapter10/EventChapter10LesterDeimne_PattyDaisyTalk.asm"
      .include "events/Chapter10/EventChapter10NannaJeanne_LeifTalk.asm"
      .include "events/Chapter10/EventChapter10FebailAsaello_LanaMuirneTalk.asm"
      .include "events/Chapter10/EventChapter10SeliphLeneTalk.asm"
      .include "events/Chapter10/EventChapter10SeliphFeeTalk.asm"
      .include "events/Chapter10/EventChapter10SeliphTineTalk.asm"

      .include "events/ChapterFinal/EventChapterFinalTineLinda_SeliphTalk.asm"
      .include "events/ChapterFinal/EventChapterFinalTineLinda_CedHawkTalk.asm"
      .include "events/ChapterFinal/EventChapterFinalTineLinda_LeifTalk.asm"
      .include "events/ChapterFinal/EventChapterFinalDaisyDeimneTalk.asm"
      .include "events/ChapterFinal/EventChapterFinalJeanneLeifTalk.asm"
      .include "events/ChapterFinal/EventChapterFinalMuirneAsaelloTalk.asm"
      .include "events/ChapterFinal/EventChapterFinalLanaMuirne_SeliphTalk.asm"
      .include "events/ChapterFinal/EventChapterFinalLanaFebailTalk.asm"
      .include "events/ChapterFinal/EventChapterFinalLanaMuirne_ScathachDalvinTalk.asm"
      .include "events/ChapterFinal/EventChapterFinalLarceiCreidne_SeliphTalk.asm"
      .include "events/ChapterFinal/EventChapterFinalLarceiCreidne_IucharTalk.asm"
      .include "events/ChapterFinal/EventChapterFinalLarceiCreidne_IucharbaTalk.asm"
      .include "events/ChapterFinal/EventChapterFinalLarceiCreidne_ShannanTalk.asm"
      .include "events/ChapterFinal/EventChapterFinalPattyDaisy_SeliphTalk.asm"
      .include "events/ChapterFinal/EventChapterFinalPattyDaisy_ShannanTalk.asm"
      .include "events/ChapterFinal/EventChapterFinalPattyLesterTalk.asm"
      .include "events/ChapterFinal/EventChapterFinalNannaJeanne_SeliphTalk.asm"
      .include "events/ChapterFinal/EventChapterFinalNannaAresTalk.asm"
      .include "events/ChapterFinal/EventChapterFinalNannaLeifTalk.asm"
      .include "events/ChapterFinal/EventChapterFinalFeeHermina_SeliphTalk.asm"
      .include "events/ChapterFinal/EventChapterFinalFeeHermina_ArthurAmidTalk.asm"
      .include "events/ChapterFinal/EventChapterFinalFeeOifeyTalk.asm"

      .include "events/Chapter09/EventChapter09AsaelloDaisyTalk.asm"

      .include "events/ChapterFinal/EventChapterFinalArthurTineTalk.asm"
      .include "events/ChapterFinal/EventChapterFinalAmidLindaTalk.asm"

      .include "events/Chapter09/EventChapter09LayleaCharlotTalk.asm"
      .include "events/Chapter06/EventChapter06HerminaSeliphTalk.asm"

      .fill $8F8000 + $8000 - *, 0

    .here

    ; Compressed streams: generated from gfx/compressed/D05673/D05673.streams by build.sh.
    .include "gfx/compressed/D05673/Layout.asm"

    * = $108000
    .logical $908000

      .dsection ChapterPrologueEventsSection
      .dsection ChapterPrologueEventDataSection

      .include "events/Chapter01/EventChapter01Opening.asm"
      .include "events/Chapter01/EventChapter01_021.asm"
      .include "events/Chapter01/EventChapter01EdainGroupSpawn.asm"
      .include "events/Chapter01/EventChapter01GenoaSeized.asm"
      .include "events/Chapter01/EventChapter01SigurdAyraTalk.asm"
      .include "events/Chapter01/EventChapter01EdainJamkeTalk.asm"
      .include "events/Chapter01/EventChapter01HeirheinSpawn.asm"
      .include "events/Chapter01/EventChapter01NordionSpawn.asm"
      .include "events/Chapter01/EventChapter01MarphaSeized.asm"
      .include "events/Chapter01/EventChapter01VerdaneSpawn.asm"
      .include "events/Chapter01/EventChapter01DeirdreSpawn.asm"
      .include "events/Chapter01/EventChapter01Ending.asm"
      .include "events/Chapter01/EventChapter01_02C.asm"
      .include "events/Chapter01/EventChapter01_02D.asm"
      .include "events/Chapter01/EventChapter01_02E.asm"
      .include "events/Chapter01/EventChapter01_02F.asm"
      .include "events/Chapter01/EventChapter01_030.asm"
      .include "events/Chapter01/EventChapter01_031.asm"
      .include "events/Chapter01/EventChapter01_032.asm"
      .include "events/Chapter01/EventChapter01_033.asm"
      .include "events/Chapter01/EventChapter01Village1.asm"
      .include "events/Chapter01/EventChapter01Village2.asm"
      .include "events/Chapter01/EventChapter01Village3.asm"
      .include "events/Chapter01/EventChapter01EldiganRetreat.asm"
      .include "events/Chapter01/EventChapter01MunnirRallyVanguard.asm"
      .include "events/Chapter01/EventChapter01AyraDestroysGenoa.asm"
      .include "events/Chapter01/EventChapter01AyraStartsMoving.asm"
      .include "events/Chapter01/EventChapter01GenoaSeizedAyraResponse.asm"
      .include "events/Chapter01/EventChapter01_03C.asm"
      .include "events/Chapter01/EventChapter01QuanDied.asm"
      .include "events/Chapter01/EventChapter01EthlynDied.asm"
      .include "events/Chapter01/EventChapter01FinnDied.asm"
      .include "events/Chapter01/EventChapter01ElliotRetreats.asm"
      .include "events/Chapter01/EventChapter01LexBraveAxe.asm"
      .include "events/Chapter01/EventChapter01CrossknightTalk.asm"
      .include "events/Chapter01/EventChapter01_043.asm"

      dialogueChapter01Opening2 .include "text/dialogue/Chapter01/Opening2.dialogue.txt" ; 908D0A
      dialogueChapter01Opening1 .include "text/dialogue/Chapter01/Opening1.dialogue.txt" ; 908E8D
      dialogueChapter01Opening3 .include "text/dialogue/Chapter01/Opening3.dialogue.txt" ; 908ECC
      dialogueChapter01Opening4 .include "text/dialogue/Chapter01/Opening4.dialogue.txt" ; 909106
      dialogueChapter01EdainGroupSpawn1 .include "text/dialogue/Chapter01/EdainGroupSpawn1.dialogue.txt" ; 909132
      dialogueChapter01EdainGroupSpawn2 .include "text/dialogue/Chapter01/EdainGroupSpawn2.dialogue.txt" ; 909361
      dialogueChapter01EdainGroupSpawn3 .include "text/dialogue/Chapter01/EdainGroupSpawn3.dialogue.txt" ; 90938A
      dialogueChapter01SigurdAyraTalk .include "text/dialogue/Chapter01/SigurdAyraTalk.dialogue.txt" ; 909403
      dialogueChapter01AyraBattleQuote .include "text/dialogue/Chapter01/AyraBattleQuote.dialogue.txt" ; 90967E
      dialogueChapter01CimbaethBattleQuote .include "text/dialogue/Chapter01/CimbaethBattleQuote.dialogue.txt" ; 9096AC
      dialogueChapter01GenoaSeizedAyraAlive .include "text/dialogue/Chapter01/GenoaSeizedAyraAlive.dialogue.txt" ; 9096e0
      dialogueChapter01GenoaSeizedAyraDead .include "text/dialogue/Chapter01/GenoaSeizedAyraDead.dialogue.txt" ; 9099E1
      dialogueChapter01HeirheinSpawn1 .include "text/dialogue/Chapter01/HeirheinSpawn1.dialogue.txt" ; 909CCC
      dialogueChapter01HeirheinSpawn2 .include "text/dialogue/Chapter01/HeirheinSpawn2.dialogue.txt" ; 909D2D
      dialogueChapter01NordionSpawn1 .include "text/dialogue/Chapter01/NordionSpawn1.dialogue.txt" ; 909D60
      dialogueChapter01NordionSpawn2 .include "text/dialogue/Chapter01/NordionSpawn2.dialogue.txt" ; 909E43
      dialogueChapter01ElliotBattleQuote .include "text/dialogue/Chapter01/ElliotBattleQuote.dialogue.txt" ; 90A07D
      dialogueChapter01MunnirRallyVanguard .include "text/dialogue/Chapter01/MunnirRallyVanguard.dialogue.txt" ; 90a0c1
      dialogueChapter01MunnirBattleQuote .include "text/dialogue/Chapter01/MunnirBattleQuote.dialogue.txt" ; 90A113
      dialogueChapter01MarphaSeized1 .include "text/dialogue/Chapter01/MarphaSeized1.dialogue.txt" ; 90a151
      dialogueChapter01MarphaSeized2 .include "text/dialogue/Chapter01/MarphaSeized2.dialogue.txt" ; 90A437
      dialogueChapter01VerdaneSpawn1 .include "text/dialogue/Chapter01/VerdaneSpawn1.dialogue.txt" ; 90A640
      dialogueChapter01VerdaneSpawn2 .include "text/dialogue/Chapter01/VerdaneSpawn2.dialogue.txt" ; 90A8A9
      dialogueChapter01DeirdreSpawnSandimaAlive .include "text/dialogue/Chapter01/DeirdreSpawnSandimaAlive.dialogue.txt" ; 90AD08
      dialogueChapter01DeirdreSpawnSandimaDead .include "text/dialogue/Chapter01/DeirdreSpawnSandimaDead.dialogue.txt" ; 90AFA6
      dialogueChapter01SandimaBattleQuote .include "text/dialogue/Chapter01/SandimaBattleQuote.dialogue.txt" ; 90B3CE
      dialogueChapter01Ending .include "text/dialogue/Chapter01/Ending.dialogue.txt" ; 90B3FA
      dialogueChapter01UnusedEnding .include "text/dialogue/Chapter01/UnusedEnding.dialogue.txt" ; 90B6A0 - This one is very slightly different. Just 'protect the people', leaving out 'of this country'.
      dialogueChapter01EdainJamkeTalk .include "text/dialogue/Chapter01/EdainJamkeTalk.dialogue.txt" ; 90B93D
      dialogueChapter01Village1 .include "text/dialogue/Chapter01/Village1.dialogue.txt" ; 90BB5A
      dialogueChapter01Village2 .include "text/dialogue/Chapter01/Village2.dialogue.txt" ; 90BBFA
      dialogueChapter01Village3 .include "text/dialogue/Chapter01/Village3.dialogue.txt" ; 90BCD6
      dialogueChapter01EldiganRetreat .include "text/dialogue/Chapter01/EldiganRetreat.dialogue.txt" ; 90BEC5
      dialogueChapter01JamkeBattleQuote .include "text/dialogue/Chapter01/JamkeBattleQuote.dialogue.txt" ; 90BEFF
      dialogueChapter01UnusedJamkeEdainBattleQuote .include "text/dialogue/Chapter01/UnusedJamkeEdainBattleQuote.dialogue.txt" ; 90BF2D
      dialogueChapter01AyraDestroysGenoa .include "text/dialogue/Chapter01/AyraDestroysGenoa.dialogue.txt" ; 90BF4E
      dialogueChapter01AyraStartsMoving .include "text/dialogue/Chapter01/AyraStartsMoving.dialogue.txt" ; 90BF91
      dialogueChapter01GenoaSeizedAyraResponse .include "text/dialogue/Chapter01/GenoaSeizedAyraResponse.dialogue.txt" ; 90BFB9
      dialogueChapter01LexBraveAxe .include "text/dialogue/Chapter01/LexBraveAxe.dialogue.txt" ; 90BFF2

      dialogueChapter06Opening1 .include "text/dialogue/Chapter06/Opening1.dialogue.txt" ; 90C0E8
      dialogueChapter06Opening2 .include "text/dialogue/Chapter06/Opening2.dialogue.txt" ; 90C3C0
      dialogueChapter06OifeyGroupSpawn .include "text/dialogue/Chapter06/OifeyGroupSpawn.dialogue.txt" ; 90C970
      dialogueChapter06GaneishireSeized1 .include "text/dialogue/Chapter06/GaneishireSeized1.dialogue.txt" ; 90CA9D
      dialogueChapter06GaneishireSeized2 .include "text/dialogue/Chapter06/GaneishireSeized2.dialogue.txt" ; 90CF79
      dialogueChapter06FeeArthurSpawn .include "text/dialogue/Chapter06/FeeArthurSpawn.dialogue.txt" ; 90D04D
      dialogueChapter06SchmidtSpawn1 .include "text/dialogue/Chapter06/SchmidtSpawn1.dialogue.txt" ; 90D4DB
      dialogueChapter06SchmidtSpawn2 .include "text/dialogue/Chapter06/SchmidtSpawn2.dialogue.txt" ; 90D53E
      dialogueChapter06SchmidtSpawn3 .include "text/dialogue/Chapter06/SchmidtSpawn3.dialogue.txt" ; 90D583
      dialogueChapter06LarceiCreidne_IucharbaTalk .include "text/dialogue/Chapter06/LarceiCreidne_IucharbaTalk.dialogue.txt" ; 90D5DF
      dialogueChapter06LarceiCreidne_IucharbaTalkIucharResponse .include "text/dialogue/Chapter06/LarceiCreidne_IucharbaTalkIucharResponse.dialogue.txt" ; 90D7F5
      dialogueChapter06LarceiCreidne_IucharTalk .include "text/dialogue/Chapter06/LarceiCreidne_IucharTalk.dialogue.txt" ; 90D843
      dialogueChapter06LarceiCreidne_IucharTalkIucharbaResponse .include "text/dialogue/Chapter06/LarceiCreidne_IucharTalkIucharbaResponse.dialogue.txt" ; 90D9B4
      dialogueChapter06IsaachSeizedDanannAlive .include "text/dialogue/Chapter06/IsaachSeizedDanannAlive.dialogue.txt" ; 90DA0E
      dialogueChapter06IsaachSeizedDanannDead .include "text/dialogue/Chapter06/IsaachSeizedDanannDead.dialogue.txt" ; 90DC01
      dialogueChapter06SofalaSeizedDanannAlive .include "text/dialogue/Chapter06/SofalaSeizedDanannAlive.dialogue.txt" ; 90DC35
      dialogueChapter06SofalaSeizedDanannDead .include "text/dialogue/Chapter06/SofalaSeizedDanannDead.dialogue.txt" ; 90DD57
      dialogueChapter06BrotherRecruitedDanannResponse .include "text/dialogue/Chapter06/BrotherRecruitedDanannResponse.dialogue.txt" ; 90DD8B
      dialogueChapter06Ending .include "text/dialogue/Chapter06/Ending.dialogue.txt" ; 90DE0C
      dialogueChapter06Village1 .include "text/dialogue/Chapter06/Village1.dialogue.txt" ; 90E4A8
      dialogueChapter06Village2 .include "text/dialogue/Chapter06/Village2.dialogue.txt" ; 90E585
      dialogueChapter06VillageSkillRing .include "text/dialogue/Chapter06/VillageSkillRing.dialogue.txt" ; 90E5E0
      dialogueChapter06Village4 .include "text/dialogue/Chapter06/Village4.dialogue.txt" ; 90E659
      dialogueChapter06Village3 .include "text/dialogue/Chapter06/Village3.dialogue.txt" ; 90E6CE
      dialogueChapter06Village5 .include "text/dialogue/Chapter06/Village5.dialogue.txt" ; 90E735
      dialogueChapter06HaroldBattleQuote .include "text/dialogue/Chapter06/HaroldBattleQoute.dialogue.txt" ; 90E7E2
      dialogueChapter06IucharbaBattleQuote .include "text/dialogue/Chapter06/IucharbaBattleQuote.dialogue.txt" ; 90E800
      dialogueChapter06IucharBattleQuote .include "text/dialogue/Chapter06/IucharBattleQuote.dialogue.txt" ; 90E82E
      dialogueChapter06SchmidtBattleQuote .include "text/dialogue/Chapter06/SchmidtBattleQuote.dialogue.txt" ; 90E871
      dialogueChapter06DanannBattleQuote .include "text/dialogue/Chapter06/DanannBattleQuote.dialogue.txt" ; 90E8A1

      .dsection Data90E8CESection

      .dsection Unsorted90EBCASection

    .here

    * = $118000
    .logical $918000

      .dsection DialogueEngineSection

      .dsection Unsorted91A3ABSection

      .dsection Unsorted91A3D9Section

      .dsection Unsorted91A3DESection

      .dsection Data91A405Section

      .dsection EventScriptEngineSection
      .dsection FadeProcClearSection

      ; 91a7bc

      .dsection Unsorted91A7BCSection

      .dsection Unsorted91A7DFSection

    .here

    * = $11A80D
    .logical $91A80D

      .dsection Unsorted91A80DSection

      .dsection DialogueEventCommandSection

    .here

    * = $11A928
    .logical $91A928

      .dsection Unsorted91A928Section

      .dsection DialogueUnknownSection

      .dsection Unsorted91A9BBSection

    .here

    * = $11AA15
    .logical $91AA15

      .dsection Unsorted91AA15Section

      .dsection Unsorted91AA6FSection

      .dsection Unsorted91AAE2Section

      .dsection Unsorted91AB91Section

      .dsection Unsorted91ABEESection

      .dsection Unsorted91AC79Section

      .dsection Unsorted91AC96Section

      .dsection Unsorted91ACE2Section

      .dsection DeathQuoteSection

      ; 91b11c

    .here

    * = $11B131
    .logical $91B131

      .dsection Unsorted91B131Section

      .dsection Unsorted91B164Section

      .dsection Table91B1E3Section

    .here

    * = $11B1FC
    .logical $91B1FC

      .dsection Unsorted91B1FCSection

      .dsection Data91B2D3Section

      .dsection Unsorted91B2E5Section
      .dsection Table91B34CSection

      .dsection Unsorted91B496Section
      .dsection Table91B546Section

      .dsection Unsorted91BA46Section

      .dsection Data91BA6CSection

      .dsection EpilogueDialogueCodeSection

      ; 91bd42

    .here

    * = $11BD94
    .logical $91BD94

      .dsection ASMCStatUpDisplaySection

      .dsection EventCommandSection

      .include "events/Chapter06/EventChapter06Opening.asm"
      .include "events/Chapter06/EventChapter06OifeyGroupSpawn.asm"
      .include "events/Chapter06/EventChapter06GaneishireSeized.asm"
      .include "events/Chapter06/EventChapter06FeeArthurSpawn.asm"
      .include "events/Chapter06/EventChapter06SchmidtSpawn.asm"
      .include "events/Chapter06/EventChapter06LarceiCreidne_IucharbaTalk.asm"
      .include "events/Chapter06/EventChapter06LarceiCreidne_IucharTalk.asm"
      .include "events/Chapter06/EventChapter06IsaachSeized.asm"
      .include "events/Chapter06/EventChapter06SofalaSeized.asm"
      .include "events/Chapter06/EventChapter06BrotherRecruitedDanannResponse.asm"
      .include "events/Chapter06/EventChapter06Ending.asm"
      .include "events/Chapter06/EventChapter06Village1.asm"
      .include "events/Chapter06/EventChapter06Village2.asm"
      .include "events/Chapter06/EventChapter06Village3.asm"
      .include "events/Chapter06/EventChapter06Village4.asm"
      .include "events/Chapter06/EventChapter06VillageSkillRing.asm"
      .include "events/Chapter06/EventChapter06Village5.asm"
      .include "events/Chapter06/EventChapter06_0EA.asm"
      .include "events/Chapter06/EventChapter06CreidneIucharbaAdjacent.asm"
      .include "events/Chapter06/EventChapter06CreidneIucharAdjacent.asm"
      .include "events/Chapter06/EventChapter06Village2Seliph.asm"
      .include "events/Chapter06/EventChapter06SofalaArmyTalk.asm"
      .include "events/Chapter06/EventChapter06IsaachArmyTalk.asm"
      .include "events/Chapter06/EventChapter06DeimneIsaachVisit.asm"
      .include "events/Chapter06/EventChapter06_0F5.asm"

      ; 91d616

      .dsection Unsorted91D616Section

      .dsection Table91D62ASection

      .dsection Unsorted91D682Section

      .dsection Unsorted91D683Section

      .dsection Unsorted91D69BSection

      .dsection Unsorted91D6BBSection

      .dsection Unsorted91D6E3Section

      .dsection Unsorted91D6ECSection

      g2bppBlankTile .binary "gfx/ui/BlankTile.2bpp" ; 91D7E8

      .dsection Unsorted91D7F8Section

      .dsection Unsorted91D7F9Section

      .dsection Unsorted91D839Section

      .dsection Unsorted91D844Section

      .dsection Data91D899Section

      .dsection Unsorted91D8A0Section

      .dsection Unsorted91D90DSection

      .dsection Unsorted91D921Section

      .dsection Unsorted91D945Section
      .dsection Unsorted91D995Section

      .dsection SaveFileSection

      .dsection Unsorted91D9FASection

      .dsection Unsorted91DA25Section

      .dsection Unsorted91DA64Section

      .dsection Unsorted91DB17Section

      .dsection Unsorted91DB6DSection

      .dsection Unsorted91DBA8Section

      .dsection Unsorted91DBD0Section

      .dsection Unsorted91DBEESection

      .dsection Unsorted91DC13Section
      .dsection Unsorted91DC1ASection
      .dsection Unsorted91DC37Section
      .dsection Unsorted91DC50Section

      .dsection Unsorted91DC6DSection

      .dsection Unsorted91DC92Section

      .dsection Unsorted91DCDESection

      .dsection Unsorted91DCF8Section

      .dsection Unsorted91DD9BSection

      .dsection Table91DDD5Section

      .dsection Unsorted91DDF1Section

      .dsection Unsorted91DE4CSection

      .dsection Table91DE9FSection

      .dsection Unsorted91DEA1Section

    .here

    * = $11DF32
    .logical $91DF32

      .dsection Unsorted91DF32Section

      .dsection Unsorted91DF6DSection

    .here

    * = $11E07A
    .logical $91E07A

      .dsection Unsorted91E07ASection

      .dsection Table91E089Section

      .dsection Unsorted91E095Section

      .dsection Table91E09ESection

      .dsection Unsorted91E275Section

      .dsection Unsorted91E2AASection

      .dsection Table91E397Section

      .dsection Unsorted91E405Section

    .here

    * = $11E4B3
    .logical $91E4B3

      .dsection Table91E4B3Section

      .dsection Data91E4F3Section

      .dsection Unsorted91E52BSection

      .dsection Unsorted91E55ASection

      .dsection Unsorted91E583Section

      .dsection Unsorted91E780Section

      .dsection Unsorted91E793Section

    .here

    * = $11E915
    .logical $91E915

      .dsection Unsorted91E915Section

      .dsection Unsorted91E92ESection

      .dsection Unsorted91E932Section

      .dsection Unsorted91E940Section

      .dsection SaveSlotSection

      .dsection Unsorted91F748Section

      .dsection Unsorted91F759Section

      .dsection Unsorted91F813Section

      .dsection Data91F872Section

      .dsection Unsorted91F88ASection

      .dsection Table91F89BSection

      .dsection Unsorted91F89FSection

      .dsection Unsorted91F907Section

      .dsection Unsorted91F935Section

      .dsection Unsorted91F959Section

      .dsection Table91F9ADSection

      .dsection Unsorted91F9DDSection

      .dsection Table91FA27Section

      .dsection Unsorted91FA57Section

      .dsection Unsorted91FA9ASection

      .fill $918000 + $8000 - *, $00

    .here

    * = $128000
    .logical $928000

      g2bppDialogueFont .binary "gfx/font/DialogueFont.2bpp" ; 92/8000

    .here

    * = $138000
    .logical $938000

      g2bppDialogueFont2 .binary "gfx/font/DialogueFont2.2bpp" ; 93/8000

    .here

    * = $148000
    .logical $948000

      g2bppDialogueFont3 .binary "gfx/font/DialogueFont3.2bpp" ; 94/8000

      .dsection BackgroundPalettes94C000Section

    .here

    ; Compressed streams: generated from gfx/compressed/94C140/94C140.streams by build.sh.
    .include "gfx/compressed/94C140/Layout.asm"

    ; Compressed streams: generated from gfx/compressed/D50000/D50000.streams by build.sh.
    .include "gfx/compressed/D50000/Layout.asm"

    * = $158000
    .logical $958000

      .dsection Unsorted958000Section

      .dsection Unsorted9582D8Section

      .dsection Unsorted9582F7Section

      .dsection Unsorted958B07Section

      .dsection Unsorted958CB9Section

      .dsection Unsorted9590F2Section

      .dsection Data95937CSection

      .dsection Unsorted95938CSection

      .dsection Unsorted9594F8Section

      .dsection Unsorted9595CASection

    .here

    * = $15968E
    .logical $95968E

      .dsection Unsorted95968ESection

      .dsection Unsorted9597FASection

      .dsection Table959890Section

      .dsection Data959894Section

      .dsection Unsorted959895Section

      .dsection Unsorted9598E7Section

      .dsection Unsorted959902Section

      .dsection Unsorted9599E7Section

      .dsection Unsorted959B49Section

      .dsection Unsorted959B84Section

      .dsection Unsorted959BC1Section

    .here

    * = $159C14
    .logical $959C14

      .dsection Unsorted959C14Section

      .dsection Unsorted959C3ESection

      .dsection Unsorted959C64Section

      .dsection Unsorted959DACSection

      .dsection Unsorted959E22Section

    .here

    * = $159F43
    .logical $959F43

      .dsection Unsorted959F43Section

    .here

    * = $15A086
    .logical $95A086

      .dsection Unsorted95A086Section

      .dsection Unsorted95A0F7Section

      .dsection Unsorted95A114Section

    .here

    * = $15A167
    .logical $95A167

      .dsection Unsorted95A167Section

      .dsection DecompressSingleSection

      .dsection Unsorted95A414Section

      .dsection Unsorted95A481Section

      .dsection Unsorted95A53ESection

      .dsection Unsorted95A65FSection

    .here

    * = $15AAFF
    .logical $95AAFF

      .dsection Unsorted95AAFFSection
      .dsection Unsorted95AB80Section

      .dsection Unsorted95ABBBSection

      .dsection Data95AC3BSection

      .dsection Unsorted95AC41Section

      .dsection Data95ACA8Section

      .dsection Unsorted95ACAESection

      .dsection Data95ACF0Section

      .dsection Unsorted95ACF6Section

      .dsection Data95AD64Section
      .dsection Unsorted95AD8CSection

      .dsection Unsorted95ADD6Section

      .dsection Unsorted95AE8BSection

      .dsection Unsorted95AEA2Section

    .here

    * = $15B184
    .logical $95B184

      .dsection Unsorted95B184Section

      .dsection BattleAnimationMoves95B250Section

      .dsection BattleAnimationMoves95B2DFSection

      .dsection BattleAnimationMoves95B332Section

      .dsection BattleAnimationMoves95B362Section

      .dsection BattleAnimationMoves95B3AFSection

      .dsection BattleAnimationMoves95B475Section

      .dsection BattleAnimationMoves95B48DSection

      .dsection Unsorted95B530Section

      .dsection Unsorted95B554Section

      .dsection Unsorted95B5D0Section

    .here

    * = $15B6D0
    .logical $95B6D0

      .dsection Unsorted95B6D0Section

    .here

    * = $15B7F8
    .logical $95B7F8

      .dsection Unsorted95B7F8Section

      .dsection Unsorted95B81BSection

      .dsection Unsorted95B884Section

      .dsection Unsorted95B96FSection

      .dsection Unsorted95B993Section

    .here

    * = $15C368
    .logical $95C368

      .dsection Unsorted95C368Section

      .dsection Unsorted95C43ESection

      .dsection Unsorted95CA81Section

      .dsection Unsorted95CA88Section

      .dsection Unsorted95CEBFSection

      .dsection BattleAnimationMoves95CF2ESection

      .dsection Unsorted95CFA0Section

      .dsection BattleAnimationMoves95D007Section

      .dsection Unsorted95D078Section

      .dsection BattleAnimationMoves95D0E7Section

      .dsection Unsorted95D1C5Section

    .here

    * = $15D23C
    .logical $95D23C

      .dsection BattleAnimationMoves95D23CSection

    .here

    * = $15D2A4
    .logical $95D2A4

      .dsection Unsorted95D2A4Section

      .dsection Unsorted95DA0BSection

      .dsection Unsorted95DA1DSection

      .dsection Table95DC4CSection

      .dsection Unsorted95DC54Section

      .dsection Unsorted95DC90Section

      .dsection Unsorted95DCA3Section

      .dsection Table95DE84Section

      .dsection Unsorted95DE8CSection

      .dsection Unsorted95DF76Section

    .here

    * = $15E0C5
    .logical $95E0C5

      .dsection Unsorted95E0C5Section

      .dsection Unsorted95E1C9Section

      .dsection Unsorted95E372Section

      .dsection Unsorted95E3DFSection

      .dsection Table95E69ESection

      .dsection Unsorted95E6AASection

      .dsection Table95E6ACSection

      .dsection Unsorted95E7B3Section

    .here

    * = $15E834
    .logical $95E834

      .dsection Unsorted95E834Section

    .here

    * = $15E888
    .logical $95E888

      .dsection Unsorted95E888Section

      .dsection Unsorted95EA47Section

      .dsection Table95EA91Section

      .dsection Unsorted95ED4ESection

    .here

    * = $15EE73
    .logical $95EE73

      .dsection Unsorted95EE73Section

      .dsection Unsorted95EF54Section

      .dsection Unsorted95F0E9Section

      .dsection Unsorted95F12ASection

      .dsection Unsorted95F248Section

      .dsection Unsorted95F256Section

    .here

    * = $15F426
    .logical $95F426

      .dsection Unsorted95F426Section

    .here

    * = $15F741
    .logical $95F741

      .dsection Unsorted95F741Section

    .here

    * = $15F7B7
    .logical $95F7B7

      .dsection Unsorted95F7B7Section

      .dsection Unsorted95F7F7Section

    .here

    * = $15F87F
    .logical $95F87F

      .dsection Unsorted95F87FSection

    .here

    * = $15FCA4
    .logical $95FCA4

      .dsection Unsorted95FCA4Section

    .here

    * = $15FD44
    .logical $95FD44

      .dsection Unsorted95FD44Section

    .here

    * = $15FF51
    .logical $95FF51

      .dsection Unsorted95FF51Section

    .here

    * = $168000
    .logical $968000

      .dsection Table968000Section

      .dsection Unsorted968008Section

      .dsection Table96800DSection

      .dsection Unsorted968017Section

      .dsection Table96804ESection

      .dsection Unsorted968058Section

      .dsection Table968076Section

      .dsection Unsorted968080Section

      .dsection Table968093Section

      .dsection Unsorted96809DSection

      .dsection Table9680A2Section

      .dsection Unsorted9680ACSection

      .dsection Table9680B1Section

      .dsection Unsorted9680BBSection

      .dsection Unsorted9680C2Section

    .here

    * = $16881F
    .logical $96881F

      .dsection Unsorted96881FSection

      .dsection Unsorted96890ESection

    .here

    * = $168DBD
    .logical $968DBD

      .dsection Unsorted968DBDSection

    .here

    * = $168E4C
    .logical $968E4C

      .dsection Unsorted968E4CSection

    .here

    * = $168F50
    .logical $968F50

      .dsection Unsorted968F50Section

    .here

    * = $169398
    .logical $969398

      .dsection Unsorted969398Section

      .dsection Unsorted96941CSection

      .dsection Unsorted96947DSection

      .dsection Unsorted9694C7Section

      .dsection Unsorted96957DSection

      .dsection Unsorted969603Section

      .dsection Unsorted969617Section

      .dsection Unsorted96961FSection

      .dsection Unsorted969665Section

      .dsection Table9696A0Section

      .dsection Unsorted9696AASection

      .dsection Unsorted9696E6Section
      .dsection Unsorted969707Section
      .dsection Unsorted969727Section
      .dsection Unsorted969735Section
      .dsection Unsorted969765Section

    .here

    * = $1697FA
    .logical $9697FA

      .dsection Unsorted9697FASection

      .dsection Unsorted969861Section

      .dsection Unsorted969872Section

      .dsection Unsorted96989ESection

      .dsection Unsorted96994BSection

    .here

    * = $1699DD
    .logical $9699DD

      .dsection Unsorted9699DDSection

      .dsection Data969BE3Section

      .dsection Unsorted969C63Section

      .dsection Unsorted969EF9Section

      .dsection Unsorted969F7DSection

      .dsection Unsorted96A05CSection

    .here

    * = $16A20E
    .logical $96A20E

      .dsection Unsorted96A20ESection

      .dsection BattleSceneScriptSection

      .dsection Unsorted96A4B2Section

      .dsection Unsorted96A4FCSection

      .dsection Unsorted96A532Section

      .dsection BattleSceneCommand96ABF6Section

      .dsection Unsorted96AC1FSection

      .dsection Unsorted96ACABSection

    .here

    * = $16AD07
    .logical $96AD07

      .dsection Unsorted96AD07Section

    .here

    * = $16AD39
    .logical $96AD39

      .dsection Unsorted96AD39Section

      .dsection Unsorted96ADE9Section

    .here

    * = $16B0E1
    .logical $96B0E1

      .dsection Unsorted96B0E1Section

    .here

    * = $16B852
    .logical $96B852

      .dsection Unsorted96B852Section

      .dsection Unsorted96B945Section

      .dsection BattleSceneCommand96BA68Section

      .dsection Unsorted96BB0CSection

      .dsection BattleSceneCommand96BB70Section

      .dsection Unsorted96BBC2Section

      .dsection Unsorted96BBE2Section

      .dsection Unsorted96BC4CSection

      .dsection BattleSceneCommand96BCAFSection

      .dsection Unsorted96BCECSection

      .dsection Unsorted96BCF1Section

      .dsection Unsorted96BD1ASection

      .dsection Unsorted96BD74Section

      .dsection Unsorted96BE28Section

    .here

    * = $16BFE5
    .logical $96BFE5

      .dsection Unsorted96BFE5Section

    .here

    * = $16C7DB
    .logical $96C7DB

      .dsection Unsorted96C7DBSection

      .dsection Unsorted96C8A1Section

      .dsection Unsorted96C942Section

      .dsection Unsorted96C9ADSection

      .dsection Unsorted96C9D9Section

      .dsection Unsorted96CB44Section

    .here

    * = $16CD23
    .logical $96CD23

      .dsection Unsorted96CD23Section

      .dsection BattleSceneCommand96CDB7Section

      .dsection Unsorted96CECESection

    .here

    * = $16D256
    .logical $96D256

      .dsection Unsorted96D256Section

    .here

    * = $16D2D7
    .logical $96D2D7

      .dsection Unsorted96D2D7Section

    .here

    * = $16D3ED
    .logical $96D3ED

      .dsection Unsorted96D3EDSection

    .here

    * = $16D402
    .logical $96D402

      .dsection Unsorted96D402Section

    .here

    * = $16D417
    .logical $96D417

      .dsection Unsorted96D417Section

    .here

    * = $16D42C
    .logical $96D42C

      .dsection Unsorted96D42CSection

      .dsection Unsorted96D5DBSection

      .dsection Unsorted96D659Section

      .dsection Unsorted96D67BSection

      .dsection Unsorted96D695Section

      .dsection Table96D6DDSection

      .dsection Unsorted96D6F7Section

      .dsection Unsorted96D774Section

      .dsection Unsorted96D89FSection
      .dsection Unsorted96D8D7Section

      .dsection Unsorted96D912Section

      .dsection Unsorted96D938Section

      .dsection Unsorted96D95ESection

      .dsection Unsorted96D990Section
      .dsection Unsorted96D9B4Section
      .dsection Unsorted96D9D8Section
      .dsection Unsorted96DA0FSection
      .dsection Unsorted96DA34Section
      .dsection Unsorted96DACBSection

      .dsection Unsorted96DB20Section

      .dsection Unsorted96DB58Section

      .dsection Unsorted96DB94Section

      .dsection Unsorted96DC7CSection

    .here

    * = $16DD39
    .logical $96DD39

      .dsection Unsorted96DD39Section

      .dsection Unsorted96DD6ESection

      .dsection Table96DEAASection

      .dsection Unsorted96DEC0Section

      .dsection Table96DF60Section

    .here

    * = $16DFBB
    .logical $96DFBB

      .dsection Unsorted96DFBBSection

      .dsection Unsorted96DFC7Section

      .dsection Unsorted96E01FSection

      .dsection Unsorted96E077Section
      .dsection Unsorted96E0CFSection
      .dsection Unsorted96E127Section
      .dsection Unsorted96E17BSection
      .dsection Unsorted96E1D3Section
      .dsection Unsorted96E20ASection
      .dsection Unsorted96E245Section
      .dsection Unsorted96E275Section
      .dsection Unsorted96E2CESection
      .dsection Unsorted96E312Section
      .dsection Unsorted96E356Section
      .dsection Unsorted96E38DSection
      .dsection Unsorted96E3CASection
      .dsection Unsorted96E3E5Section
      .dsection Unsorted96E42DSection
      .dsection Unsorted96E463Section
      .dsection Unsorted96E49CSection
      .dsection Unsorted96E49DSection
      .dsection Unsorted96E4D8Section

      .dsection Unsorted96E50ESection

      .dsection Unsorted96E50FSection
      .dsection Unsorted96E558Section
      .dsection Unsorted96E58ESection
      .dsection Unsorted96E5DASection
      .dsection Unsorted96E5F6Section

      .dsection Unsorted96E612Section

      .dsection Unsorted96E6D7Section
      .dsection Unsorted96E712Section

      .dsection Unsorted96E716Section

      .dsection Unsorted96E798Section

      .dsection Unsorted96E803Section

      .dsection Unsorted96E8E1Section
      .dsection Unsorted96E91CSection
      .dsection Unsorted96E92FSection
      .dsection Unsorted96E936Section

      .dsection Unsorted96E9B8Section

      .dsection Unsorted96EA7ASection

      .dsection Unsorted96EA99Section

      .dsection Unsorted96EBE3Section

      .dsection BattleSceneCommand96EC4ASection

      .dsection Unsorted96EC91Section

      .dsection Unsorted96ECABSection

      .dsection Table96ECCCSection

      .dsection Unsorted96ECDCSection
      .dsection Unsorted96ED0BSection
      .dsection Unsorted96ED23Section

      .dsection Data96ED67Section

      .dsection Unsorted96EDA7Section

      .dsection Unsorted96EDC0Section

      .dsection Data96EDF2Section

      .dsection Unsorted96EE32Section

      .dsection Unsorted96EE4ASection
      .dsection Unsorted96EE5ESection
      .dsection Unsorted96EE71Section

      .dsection Unsorted96EE8ASection

      .dsection Unsorted96EE95Section

      .dsection Table96EEBDSection

      .dsection Unsorted96EEC5Section
      .dsection Unsorted96EEC6Section
      .dsection Unsorted96EFC3Section
      .dsection Unsorted96F0C4Section

      .dsection BattleSceneCommand96F1C2Section

      .dsection Unsorted96F275Section

    .here

    * = $16F28D
    .logical $96F28D

      .dsection Unsorted96F28DSection

      .dsection Unsorted96F315Section

    .here

    * = $16F558
    .logical $96F558

      .dsection Unsorted96F558Section

      .dsection Unsorted96F676Section

      .dsection Unsorted96F697Section

      .dsection Unsorted96F7A8Section

      .dsection Unsorted96F7D4Section

    .here

    * = $16F915
    .logical $96F915

      .dsection Unsorted96F915Section

    .here

    * = $16FAB6
    .logical $96FAB6

      .dsection Unsorted96FAB6Section

    .here

    * = $16FBF9
    .logical $96FBF9

      .dsection Unsorted96FBF9Section

    .here

    * = $16FD54
    .logical $96FD54

      .dsection Unsorted96FD54Section

      .dsection DemoBattles96Section

      .fill $968000 + $8000 - *, 0

    .here

    * = $170000
    .logical $D70000

      g4bppStandingMapSprites1 .binary "gfx/map/StandingMapSprites1.4bpp" ; D70000

    .here

    * = $176000
    .logical $D76000

      g2bppItemStatLabels .binary "gfx/ui/ItemStatLabels.2bpp" ; D76000

      g2bppShopLabels .binary "gfx/ui/ShopLabels.2bpp" ; D76800

      aUnknownD77000 .binary "gfx/ui/tilemaps/UnknownD77000.bin" ; D77000

      gUnknownD77800 .binary "gfx/ui/tilemaps/UnknownD77800.bin" ; D77800

    .here

    * = $178000
    .logical $978000

      .dsection Unsorted978000Section

    .here

    * = $17802C
    .logical $97802C

      .dsection Unsorted97802CSection

      .dsection BattleAnimationSheetsSection

      .dsection BattleAnimationExtrasSection

      .dsection BattleAnimationFramesSection
      .dsection Data978F3ASection

      .dsection BattleSceneDecompressionTablesSection

      .dsection Data97BDD4Section
      .dsection Data97BEACSection

      .dsection Data97C828Section

      .dsection BattleAnimationProgramsSection

      .dsection BattleAnimationMoveDataSection
      .dsection Table97E8FBSection
      .dsection Data97F19BSection
      .dsection Data97F48BSection
      .dsection Unsorted97FDC1Section

    .here

    * = $180000
    .logical $D80000

      g4bppShopScreen .binary "gfx/ui/ShopScreen.4bpp" ; D80000

      g4bppItemIcons .binary "gfx/ItemIcons.4bpp" ; D84000

    .here

    * = $188000
    .logical $988000

      .dsection Data988000Section

      .dsection BattleBackgroundsSection

      .dsection Data98AAA1Section

      .dsection BattleAnimationSoundEffectsSection

      .dsection Data98AD04Section
      .dsection Data98AD65Section
      .dsection Data98AFFDSection
      .dsection Table98B231Section

      .dsection Data98B388Section

      .dsection BattleAnimationFrameData98Section

      .dsection DemoBattles98Section

      .fill $988000 + $8000 - *, 0

    .here

    * = $190000
    .logical $D90000

      g4bppMapTiles .binary "gfx/map/MapTiles.4bpp" ; D90000

      aUnknownD95000 .binary "gfx/map/UnknownD95000.bin" ; D95000

    .here

    * = $196C00
    .logical $D96C00

      gUnknownD96C00 .binary "gfx/ui/tilemaps/UnknownD96C00.bin" ; D96C00

    .here

    * = $197940
    .logical $D97940

      gUnknownD97940 .binary "gfx/ui/tilemaps/UnknownD97940.bin" ; D97940

    .here

    * = $197C00
    .logical $D97C00

      aUnknownD97C00 .binary "gfx/ui/tilemaps/UnknownD97C00.bin" ; D97C00

    .here

    * = $198000
    .logical $998000

      .dsection Data998000Section

      .dsection BattleCharacterPiecesSection

      .dsection Data9982E3Section

      .dsection BattleWeaponGraphicsSection

      .dsection Data99892ASection
      .dsection Data998944Section
      .dsection BattleBannerTableSection
      .dsection Data998DD8Section

      .dsection Data998F02Section

      .dsection BattleAnimationFrameData99Section
      .dsection Data99F6C1Section

      .dsection Data99FFE7Section

    .here

    * = $1A0000
    .logical $DA0000

      g4bppStandingMapSprites2 .binary "gfx/map/StandingMapSprites2.4bpp" ; DA0000

    .here

    * = $1A6500
    .logical $DA6500

      .dsection DataDA6500Section

    .here

    * = $1A6800
    .logical $DA6800

      gUnknownDA6800 .binary "gfx/ui/tilemaps/UnknownDA6800.bin" ; DA6800

      gUnknownDA6A40 .binary "gfx/ui/tilemaps/UnknownDA6A40.bin" ; DA6A40

    .here

    * = $1A6D00
    .logical $DA6D00

      gUnknownDA6D00 .binary "gfx/ui/tilemaps/UnknownDA6D00.bin" ; DA6D00

    .here

    * = $1A7000
    .logical $DA7000

      aUnknownDA7000 .binary "gfx/ui/tilemaps/UnknownDA7000.bin" ; DA7000

    .here

    * = $1A7A00
    .logical $DA7A00

      g4bppUnknownDA7A00 .binary "gfx/ui/UnknownDA7A00.4bpp" ; DA7A00

    .here

    * = $1A8000
    .logical $9A8000

      .dsection Data9A8000Section

      .dsection BattleAnimationFrameData9ASection

      .dsection DemoBattles9ASection

      .fill $9A8000 + $8000 - *, 0

    .here

    * = $1B0000
    .logical $DB0000

      g4bppMapTileAnimations1 .binary "gfx/map/MapTileAnimations1.4bpp" ; DB0000

    .here

    * = $1B8000
    .logical $9B8000

      .dsection BattleAnimationFrameData9BSection
      .dsection BattleAnimationEffectData9BSection

      .dsection Unsorted9BDC24Section

      .dsection Table9BDF09Section

      .dsection Unsorted9BDFAASection

    .here

    * = $1BE179
    .logical $9BE179

      .dsection Unsorted9BE179Section

    .here

    * = $1BE5B2
    .logical $9BE5B2

      .dsection Unsorted9BE5B2Section

    .here

    * = $1BEAA5
    .logical $9BEAA5

      .dsection Unsorted9BEAA5Section

      .dsection Unsorted9BEAB1Section

      .dsection Unsorted9BEAE8Section

      .dsection Unsorted9BEDD7Section

      .dsection Unsorted9BEEB4Section

      .dsection Unsorted9BF179Section

    .here

    * = $1BF23C
    .logical $9BF23C

      .dsection Unsorted9BF23CSection

      .dsection Unsorted9BF297Section

      .dsection Unsorted9BF2AASection

      .dsection Unsorted9BF3F3Section

    .here

    * = $1BF651
    .logical $9BF651

      .dsection Unsorted9BF651Section

      .dsection Table9BF69DSection

      .dsection Unsorted9BF6B1Section

      .dsection Table9BF715Section

      .dsection Unsorted9BF726Section

    .here

    * = $1BFA58
    .logical $9BFA58

      .dsection Unsorted9BFA58Section

      .dsection Table9BFA69Section

      .dsection Unsorted9BFA6ESection

      .dsection Table9BFA7FSection

      .dsection Unsorted9BFA85Section

      .dsection Table9BFA96Section

      .dsection Unsorted9BFAA1Section

      .dsection Table9BFAB2Section

      .dsection Unsorted9BFAB7Section

      .dsection Table9BFB46Section

      .dsection Unsorted9BFB5DSection

    .here

    * = $1BFB7E
    .logical $9BFB7E

      .dsection Unsorted9BFB7ESection

      .dsection Unsorted9BFB9FSection

      .dsection Unsorted9BFBA9Section

    .here

    * = $1BFBC0
    .logical $9BFBC0

      .dsection Unsorted9BFBC0Section

      .dsection Unsorted9BFC8DSection

      .dsection Unsorted9BFD71Section

    .here

    * = $1C0000
    .logical $DC0000

      g4bppMapTileAnimations2 .binary "gfx/map/MapTileAnimations2.4bpp" ; DC0000

    .here

    ; Compressed streams: generated from gfx/compressed/9C8000/9C8000.streams by build.sh.
    .include "gfx/compressed/9C8000/Layout.asm"

    ; Compressed streams: generated from gfx/compressed/DD0000/DD0000.streams by build.sh.
    .include "gfx/compressed/DD0000/Layout.asm"

    * = $1CF000
    .logical $9CF000

      g4bppUnknown9CF000 .binary "gfx/ui/Unknown9CF000.4bpp" ; 9CF000

      g4bppUnknown9CF600 .binary "gfx/ui/Unknown9CF600.4bpp" ; 9CF600

      .dsection Data9CFC00Section

    .here

    * = $1D6730
    .logical $DD6730

      gUnknownDD6730 .binary "gfx/ui/tilemaps/UnknownDD6730.bin" ; DD6730

      gUnknownDD69F0 .binary "gfx/ui/tilemaps/UnknownDD69F0.bin" ; DD69F0

      g4bppWindowFrames .binary "gfx/ui/WindowFrames.4bpp" ; DD72B0

      .dsection TableDD7EB0Section
      .dsection TableDD7FB0Section

    .here

    * = $1D8000
    .logical $9D8000

      dialogueChapterPrologueWorldMap1 .include "text/dialogue/ChapterPrologue/WorldMap1.dialogue.txt" ; 9D8000
      dialogueChapterPrologueWorldMap2 .include "text/dialogue/ChapterPrologue/WorldMap2.dialogue.txt" ; 9D833B
      dialogueChapterPrologueWorldMap3 .include "text/dialogue/ChapterPrologue/WorldMap3.dialogue.txt" ; 9D839C
      dialogueChapterPrologueWorldMap4 .include "text/dialogue/ChapterPrologue/WorldMap4.dialogue.txt" ; 9D8490
      dialogueChapterPrologueWorldMap5 .include "text/dialogue/ChapterPrologue/WorldMap5.dialogue.txt" ; 9D84BA
      dialogueChapterPrologueWorldMap6 .include "text/dialogue/ChapterPrologue/WorldMap6.dialogue.txt" ; 9D8504
      dialogueChapterPrologueWorldMapUnknown .include "text/dialogue/ChapterPrologue/WorldMapUnknown.dialogue.txt" ; 9D8702

      .include "events/Chapter03/EventChapter03Opening.asm"
      .include "events/Chapter03/EventChapter03MadinoSeized.asm"
      .include "events/Chapter03/EventChapter03SylvaleSpawn.asm"
      .include "events/Chapter03/EventChapter03_075.asm"
      .include "events/Chapter03/EventChapter03EldiganApproachesSigurd.asm"
      .include "events/Chapter03/EventChapter03SigurdApproachesEldigan.asm"
      .include "events/Chapter03/EventChapter03LachesisEldiganTalk.asm"
      .include "events/Chapter03/EventChapter03_079.asm"
      .include "events/Chapter03/EventChapter03EldiganDeathSigurdResponse.asm"
      .include "events/Chapter03/EventChapter03ThraciaSpawn.asm"
      .include "events/Chapter03/EventChapter03_07C.asm"
      .include "events/Chapter03/EventChapter03TravantLeave.asm"
      .include "events/Chapter03/EventChapter03SylvaleSeized.asm"
      .include "events/Chapter03/EventChapter03ClaudTailtiuSpawn.asm"
      .include "events/Chapter03/EventChapter03OrgahilSpawn.asm"
      .include "events/Chapter03/EventChapter03_081.asm"
      .include "events/Chapter03/EventChapter03Ending.asm"
      .include "events/Chapter03/EventChapter03_083.asm"
      .include "events/Chapter03/EventChapter03_084.asm"
      .include "events/Chapter03/EventChapter03Village2.asm"
      .include "events/Chapter03/EventChapter03VillageWingclipper.asm"
      .include "events/Chapter03/EventChapter03VillageRestore.asm"
      .include "events/Chapter03/EventChapter03VillageDefense.asm"
      .include "events/Chapter03/EventChapter03Village4.asm"
      .include "events/Chapter03/EventChapter03Village3.asm"
      .include "events/Chapter03/EventChapter03VillageStrength.asm"
      .include "events/Chapter03/EventChapter03Village1.asm"
      .include "events/Chapter03/EventChapter03QuanDied.asm"
      .include "events/Chapter03/EventChapter03EthlynDied.asm"
      .include "events/Chapter03/EventChapter03FinnDied.asm"
      .include "events/Chapter03/EventChapter03_090.asm"
      .include "events/Chapter03/EventChapter03_091.asm"
      .include "events/Chapter03/EventChapter03_092.asm"
      .include "events/Chapter03/EventChapter03SylvaleCommanderTalk.asm"
      .include "events/Chapter03/EventChapter03DewBragiTower.asm"
      .include "events/Chapter03/EventChapter03_095.asm"

      dialogueChapter03Opening1 .include "text/dialogue/Chapter03/Opening1.dialogue.txt" ; 9D9381
      dialogueChapter03Opening2 .include "text/dialogue/Chapter03/Opening2.dialogue.txt" ; 9D9505
      dialogueChapter03Opening3 .include "text/dialogue/Chapter03/Opening3.dialogue.txt" ; 9D95AB
      dialogueChapter03Opening4 .include "text/dialogue/Chapter03/Opening4.dialogue.txt" ; 9D96B8
      dialogueChapter03MadinoSeized2 .include "text/dialogue/Chapter03/MadinoSeized2.dialogue.txt" ; 9D97B1
      dialogueChapter03Opening5 .include "text/dialogue/Chapter03/Opening5.dialogue.txt" ; 9D9D8D
      dialogueChapter03JacobiBattleQuote .include "text/dialogue/Chapter03/JacobiBattleQuote.dialogue.txt" ; 9D9FE0
      dialogueChapter03MadinoSeized1 .include "text/dialogue/Chapter03/MadinoSeized1.dialogue.txt" ; 9D9FFC
      dialogueChapter03SylvaleSpawn1 .include "text/dialogue/Chapter03/SylvaleSpawn1.dialogue.txt" ; 9DA0A2
      dialogueChapter03SylvaleSpawn2 .include "text/dialogue/Chapter03/SylvaleSpawn2.dialogue.txt" ; 9DA20F
      dialogueChapter03SylvaleSpawn3 .include "text/dialogue/Chapter03/SylvaleSpawn3.dialogue.txt" ; 9DA2B0
      dialogueChapter03SigurdEldiganCloseByTalk .include "text/dialogue/Chapter03/SigurdEldiganCloseByTalk.dialogue.txt" ; 9DA312
      dialogueChapter03LachesisEldiganTalk1 .include "text/dialogue/Chapter03/LachesisEldiganTalk1.dialogue.txt" ; 9DA412
      dialogueChapter03LachesisEldiganTalk2 .include "text/dialogue/Chapter03/LachesisEldiganTalk2.dialogue.txt" ; 9DA692
      dialogueChapter03EldiganDeathSigurdResponse .include "text/dialogue/Chapter03/EldiganDeathSigurdResponse.dialogue.txt" ; 9DA7D5
      dialogueChapter03ThraciaSpawn1 .include "text/dialogue/Chapter03/ThraciaSpawn1.dialogue.txt" ; 9DA894
      dialogueChapter03ThraciaSpawn2 .include "text/dialogue/Chapter03/ThraciaSpawn2.dialogue.txt" ; 9DA92D
      dialogueChapter03EldiganBattleQuote .include "text/dialogue/Chapter03/EldiganBattleQuote.dialogue.txt" ; 9DA98B
      dialogueChapter03LachesisEldiganBattleQuote .include "text/dialogue/Chapter03/LachesisEldiganBattleQuote.dialogue.txt" ; 9DA9CF
      dialogueChapter03PapilioBattleQuote .include "text/dialogue/Chapter03/PapilioBattleQuote.dialogue.txt" ; 9DA9F1
      dialogueChapter03ChagallBattleQuote .include "text/dialogue/Chapter03/ChagallBattleQuote.dialogue.txt" ; 9DAA21
      dialogueChapter03TravantLeave .include "text/dialogue/Chapter03/TravantLeave.dialogue.txt" ; 9DAA70
      dialogueChapter03SylvaleSeized .include "text/dialogue/Chapter03/SylvaleSeized.dialogue.txt" ; 9DAAC9
      dialogueChapter03ClaudTailtiuSpawn .include "text/dialogue/Chapter03/ClaudTailtiuSpawn.dialogue.txt" ; 9DACCF
      dialogueChapter03OrgahilSpawn1 .include "text/dialogue/Chapter03/OrgahilSpawn1.dialogue.txt" ; 9DAF38
      dialogueChapter03OrgahilSpawn2 .include "text/dialogue/Chapter03/OrgahilSpawn2.dialogue.txt" ; 9DB0CA
      dialogueChapter03OrgahilSpawn3 .include "text/dialogue/Chapter03/OrgahilSpawn3.dialogue.txt" ; 9DB142
      dialogueChapter03UnusedEdainBrigidTalk .include "text/dialogue/Chapter03/UnusedEdainBrigidTalk.dialogue.txt" ; 9DB16A - Has one more space and kana instead of one kanji.
      dialogueChapter03PizareBattleQuote .include "text/dialogue/Chapter03/PizareBattleQuote.dialogue.txt" ; 9DB454
      dialogueChapter03Ending1 .include "text/dialogue/Chapter03/Ending1.dialogue.txt" ; 9DB48D
      dialogueChapter03DuvallBattleQuote .include "text/dialogue/Chapter03/DuvallBattleQuote.dialogue.txt" ; 9DB4ED
      dialogueChapter03Ending2 .include "text/dialogue/Chapter03/Ending2.dialogue.txt" ; 9DB514
      dialogueChapter03Ending3 .include "text/dialogue/Chapter03/Ending3.dialogue.txt" ; 9DB5A3
      dialogueChapter03MadinoSeized3 .include "text/dialogue/Chapter03/MadinoSeized3.dialogue.txt" ; 9DB6B8
      dialogueChapter03MadinoSeized4 .include "text/dialogue/Chapter03/MadinoSeized4.dialogue.txt" ; 9DB7E0
      dialogueChapter03Ending4 .include "text/dialogue/Chapter03/Ending4.dialogue.txt" ; 9DB8CF
      dialogueChapter03Ending5 .include "text/dialogue/Chapter03/Ending5.dialogue.txt" ; 9DBA12
      dialogueChapter03VillageWingclipper .include "text/dialogue/Chapter03/VillageWingclipper.dialogue.txt" ; 9DBB4A
      dialogueChapter03VillageRestore .include "text/dialogue/Chapter03/VillageRestore.dialogue.txt" ; 9DBBB8
      dialogueChapter03Village2 .include "text/dialogue/Chapter03/Village2.dialogue.txt" ; 9DBC5C
      dialogueChapter03Village4SylvaleNotSeized .include "text/dialogue/Chapter03/Village4SylvaleNotSeized.dialogue.txt" ; 9DBCB2
      dialogueChapter03Village1 .include "text/dialogue/Chapter03/Village1.dialogue.txt" ; 9DBD1D
      dialogueChapter03Village3 .include "text/dialogue/Chapter03/Village3.dialogue.txt" ; 9DBD81
      dialogueChapter03VillageStrength .include "text/dialogue/Chapter03/VillageStrength.dialogue.txt" ; 9DBE06
      dialogueChapter03VillageDefense .include "text/dialogue/Chapter03/VillageDefense.dialogue.txt" ; 9DBE7E

      .include "events/Chapter05/EventChapter05Opening.asm"
      .include "events/Chapter05/EventChapter05SigurdByronTalk.asm"
      .include "events/Chapter05/EventChapter05AndreyCharge.asm"
      .include "events/Chapter05/EventChapter05BelhallaConversation.asm"
      .include "events/Chapter05/EventChapter05LubeckSeized.asm"
      .include "events/Chapter05/EventChapter05PhinoraSpawn.asm"
      .include "events/Chapter05/EventChapter05LeonsterSpawn.asm"
      .include "events/Chapter05/EventChapter05ThraciaSpawn.asm"
      .include "events/Chapter05/EventChapter05EthlynDied.asm"
      .include "events/Chapter05/EventChapter05QuanAndEthlynDead.asm"
      .include "events/Chapter05/EventChapter05PhinoraSeized.asm"
      .include "events/Chapter05/EventChapter05ReptorCharge.asm"
      .include "events/Chapter05/EventChapter05AidaBetrayal.asm"
      .include "events/Chapter05/EventChapter05ReptorBetrayalResponse.asm"
      .include "events/Chapter05/EventChapter05Ending.asm"
      .include "events/Chapter05/EventChapter05AnyoneAidaTalk.asm"
      .include "events/Chapter05/EventChapter05Village1.asm"
      .include "events/Chapter05/EventChapter05Village2.asm"
      .include "events/Chapter05/EventChapter05Village3.asm"
      .include "events/Chapter05/EventChapter05Village4.asm"
      .include "events/Chapter05/EventChapter05Village5.asm"
      .include "events/Chapter05/EventChapter05Village6.asm"
      .include "events/Chapter05/EventChapter05VelthomerSeized.asm"
      .include "events/Chapter05/EventChapter05Village7.asm"
      .include "events/Chapter05/EventChapter05ReptorDied.asm"
      .include "events/Chapter05/EventChapter05ArdenOnCliff.asm"
      .include "events/Chapter05/EventChapter05_0D7.asm"
      .include "events/Chapter05/EventChapter05_0D8.asm"

      dialogueEpilogue_Seliph_JuliaDead .include "text/dialogue/Epilogue/Seliph_JuliaDead.dialogue.txt" ; 9DCB04
      dialogueEpilogue_Seliph_JuliaDead_WithLover .include "text/dialogue/Epilogue/Seliph_JuliaDead_WithLover.dialogue.txt" ; 9DCB0F
      dialogueEpilogue_Seliph_JuliaAlive .include "text/dialogue/Epilogue/Seliph_JuliaAlive.dialogue.txt" ; 9DCB1F
      dialogueEpilogue_Seliph_JuliaAlive_WithLover .include "text/dialogue/Epilogue/Seliph_JuliaAlive_WithLover.dialogue.txt" ; 9DCB39
      dialogueEpilogue_Piece_Seliph_Start .include "text/dialogue/Epilogue/Piece_Seliph_Start.dialogue.txt" ; 9DCB49
      dialogueEpilogue_Piece_Seliph_JuliaDead .include "text/dialogue/Epilogue/Piece_Seliph_JuliaDead.dialogue.txt" ; 9DCCF4
      dialogueEpilogue_Piece_Seliph_JuliaDead_WithLover_Unused .include "text/dialogue/Epilogue/Piece_Seliph_JuliaDead_WithLover_Unused.dialogue.txt" ; 9DCE93
      dialogueEpilogue_Piece_Seliph_JuliaAlive .include "text/dialogue/Epilogue/Piece_Seliph_JuliaAlive.dialogue.txt" ; 9DCF22
      dialogueEpilogue_Piece_Seliph_JuliaAlive_WithLover_Unused .include "text/dialogue/Epilogue/Piece_Seliph_JuliaAlive_WithLover_Unused.dialogue.txt" ; 9DD054
      dialogueEpilogue_BelhallaEnd .include "text/dialogue/Epilogue/BelhallaEnd.dialogue.txt" ; 9DD0F8
      dialogueEpilogue_Shannan .include "text/dialogue/Epilogue/Shannan.dialogue.txt" ; 9DD14D
      dialogueEpilogue_Shannan_WithLover .include "text/dialogue/Epilogue/Shannan_WithLover.dialogue.txt" ; 9DD158
      dialogueEpilogue_Piece_Shannan_Start .include "text/dialogue/Epilogue/Piece_Shannan_Start.dialogue.txt" ; 9DD168
      dialogueEpilogue_Piece_Shannan_WithLover_Unused .include "text/dialogue/Epilogue/Piece_Shannan_WithLover_Unused.dialogue.txt" ; 9DD2F5
      dialogueEpilogue_Piece_Shannan_End .include "text/dialogue/Epilogue/Piece_Shannan_End.dialogue.txt" ; 9DD400
      dialogueEpilogue_Scathach_ShannanDead .include "text/dialogue/Epilogue/Scathach_ShannanDead.dialogue.txt" ; 9DD462
      dialogueEpilogue_Scathach_ShannanDead_WithLover .include "text/dialogue/Epilogue/Scathach_ShannanDead_WithLover.dialogue.txt" ; 9DD468
      dialogueEpilogue_Scathach_ShannanAlive .include "text/dialogue/Epilogue/Scathach_ShannanAlive.dialogue.txt" ; 9DD473
      dialogueEpilogue_Scathach_ShannanAlive_WithLover .include "text/dialogue/Epilogue/Scathach_ShannanAlive_WithLover.dialogue.txt" ; 9DD479
      dialogueEpilogue_Piece_Scathach_ShannanDead .include "text/dialogue/Epilogue/Piece_Scathach_ShannanDead.dialogue.txt" ; 9DD484
      dialogueEpilogue_Piece_Scathach_ShannanDead_WithLover_Unused .include "text/dialogue/Epilogue/Piece_Scathach_ShannanDead_WithLover_Unused.dialogue.txt" ; 9DD538
      dialogueEpilogue_Piece_Scathach_ShannanAlive .include "text/dialogue/Epilogue/Piece_Scathach_ShannanAlive.dialogue.txt" ; 9DD5FF
      dialogueEpilogue_Piece_Scathach_ShannanAlive_WithLover_Unused .include "text/dialogue/Epilogue/Piece_Scathach_ShannanAlive_WithLover_Unused.dialogue.txt" ; 9DD6BB
      dialogueEpilogue_Dalvin_ShannanDead .include "text/dialogue/Epilogue/Dalvin_ShannanDead.dialogue.txt" ; 9DD789
      dialogueEpilogue_Dalvin_ShannanDead_WithLover .include "text/dialogue/Epilogue/Dalvin_ShannanDead_WithLover.dialogue.txt" ; 9DD78F
      dialogueEpilogue_Dalvin_ShannanAlive .include "text/dialogue/Epilogue/Dalvin_ShannanAlive.dialogue.txt" ; 9DD79A
      dialogueEpilogue_Dalvin_ShannanAlive_WithLover .include "text/dialogue/Epilogue/Dalvin_ShannanAlive_WithLover.dialogue.txt" ; 9DD7A0
      dialogueEpilogue_Piece_Dalvin_ShannanDead .include "text/dialogue/Epilogue/Piece_Dalvin_ShannanDead.dialogue.txt" ; 9DD7AB
      dialogueEpilogue_Piece_Dalvin_ShannanAlive .include "text/dialogue/Epilogue/Piece_Dalvin_ShannanAlive.dialogue.txt" ; 9DD87E
      dialogueEpilogue_Larcei_ShannanDead .include "text/dialogue/Epilogue/Larcei_ShannanDead.dialogue.txt" ; 9DD92B
      dialogueEpilogue_CreidneLarcei_LoverDead .include "text/dialogue/Epilogue/CreidneLarcei_LoverDead.dialogue.txt" ; 9DD9FC
      dialogueEpilogue_Larcei_ShannanAlive_ScathachDead .include "text/dialogue/Epilogue/Larcei_ShannanAlive_ScathachDead.dialogue.txt" ; 9DDA8C
      dialogueEpilogue_CreidneLarcei_ShannanAlive_BrotherAlive .include "text/dialogue/Epilogue/CreidneLarcei_ShannanAlive_BrotherAlive.dialogue.txt" ; 9DDB14
      dialogueEpilogue_Piece_CreidneLarcei_End .include "text/dialogue/Epilogue/Piece_CreidneLarcei_End.dialogue.txt" ; 9DDB49
      dialogueEpilogue_Creidne_LoverDead .include "text/dialogue/Epilogue/Creidne_LoverDead.dialogue.txt" ; 9DDB77
      dialogueEpilogue_Creidne_ShannanAlive_DalvinDead .include "text/dialogue/Epilogue/Creidne_ShannanAlive_DalvinDead.dialogue.txt" ; 9DDB7D
      dialogueEpilogue_Creidne_ShannanAlive_DalvinAlive .include "text/dialogue/Epilogue/Creidne_ShannanAlive_DalvinAlive.dialogue.txt" ; 9DDC0D
      dialogueEpilogue_Deimne_MuirneDead .include "text/dialogue/Epilogue/Deimne_MuirneDead.dialogue.txt" ; 9DDC13
      dialogueEpilogue_Deimne_MuirneDead_WithLover .include "text/dialogue/Epilogue/Deimne_MuirneDead_WithLover.dialogue.txt" ; 9DDC19
      dialogueEpilogue_Deimne_MuirneAlive .include "text/dialogue/Epilogue/Deimne_MuirneAlive.dialogue.txt" ; 9DDC24
      dialogueEpilogue_Deimne_MuirneAlive_WithLover .include "text/dialogue/Epilogue/Deimne_MuirneAlive_WithLover.dialogue.txt" ; 9DDC2A
      dialogueEpilogue_Piece_Deimne_MuirneDead .include "text/dialogue/Epilogue/Piece_Deimne_MuirneDead.dialogue.txt" ; 9DDC35
      dialogueEpilogue_Piece_Deimne_MuirneDead_WithLover_Unused .include "text/dialogue/Epilogue/Piece_Deimne_MuirneDead_WithLover_Unused.dialogue.txt" ; 9DDCFF
      dialogueEpilogue_Piece_Deimne_MuirneAlive .include "text/dialogue/Epilogue/Piece_Deimne_MuirneAlive.dialogue.txt" ; 9DDDBA
      dialogueEpilogue_Piece_Deimne_MuirneAlive_WithLover_Unused .include "text/dialogue/Epilogue/Piece_Deimne_MuirneAlive_WithLover_Unused.dialogue.txt" ; 9DDE3F
      dialogueEpilogue_Muirne_LoverDead .include "text/dialogue/Epilogue/Muirne_LoverDead.dialogue.txt" ; 9DDEB7
      dialogueEpilogue_Muirne_DeimneDead .include "text/dialogue/Epilogue/Muirne_DeimneDead.dialogue.txt" ; 9DDF52
      dialogueEpilogue_Muirne_DeimneAlive .include "text/dialogue/Epilogue/Muirne_DeimneAlive.dialogue.txt" ; 9DDFD3

      dialogueEpilogue_IsaachEnd_Multiple .include "text/dialogue/Epilogue/IsaachEnd_Multiple.dialogue.txt" ; 9DE067
      dialogueEpilogue_IsaachEnd_Solo .include "text/dialogue/Epilogue/IsaachEnd_Solo.dialogue.txt" ; 9DE07E
      dialogueEpilogue_Piece_IsaachEnd_Start .include "text/dialogue/Epilogue/Piece_IsaachEnd_Start.dialogue.txt" ; 9DE089
      dialogueEpilogue_Piece_IsaachEnd_End .include "text/dialogue/Epilogue/Piece_IsaachEnd_End.dialogue.txt" ; 9DE0A4

      dialogueEpilogue_Piece_Region_Start .include "text/dialogue/Epilogue/Piece_Region_Start.dialogue.txt" ; 9DE0B3

      dialogueEpilogue_Leif_AltenaDead .include "text/dialogue/Epilogue/Leif_AltenaDead.dialogue.txt" ; 9DE0BB
      dialogueEpilogue_Leif_AltenaDead_WithLover .include "text/dialogue/Epilogue/Leif_AltenaDead_WithLover.dialogue.txt" ; 9DE0E4
      dialogueEpilogue_Leif_AltenaAlive .include "text/dialogue/Epilogue/Leif_AltenaAlive.dialogue.txt" ; 9DE112
      dialogueEpilogue_Leif_AltenaAlive_WithLover .include "text/dialogue/Epilogue/Leif_AltenaAlive_WithLover.dialogue.txt" ; 9DE138
      dialogueEpilogue_Piece_Leif_Start .include "text/dialogue/Epilogue/Piece_Leif_Start.dialogue.txt" ; 9DE163
      dialogueEpilogue_Piece_Leif_End .include "text/dialogue/Epilogue/Piece_Leif_End.dialogue.txt" ; 9DE1C5
      dialogueEpilogue_Piece_Leif_WithLover_Unused .include "text/dialogue/Epilogue/Piece_Leif_WithLover_Unused.dialogue.txt" ; 9DE2C5
      dialogueEpilogue_Altena_LeifDead_ArionDead .include "text/dialogue/Epilogue/Altena_LeifDead_ArionDead.dialogue.txt" ; 9DE34F
      dialogueEpilogue_Altena_LeifDead_ArionAlive .include "text/dialogue/Epilogue/Altena_LeifDead_ArionAlive.dialogue.txt" ; 9DE386
      dialogueEpilogue_Altena_LeifAlive_ArionDead .include "text/dialogue/Epilogue/Altena_LeifAlive_ArionDead.dialogue.txt" ; 9DE391
      dialogueEpilogue_Altena_LeifAlive_ArionAlive .include "text/dialogue/Epilogue/Altena_LeifAlive_ArionAlive.dialogue.txt" ; 9DE3EE
      dialogueEpilogue_Piece_Altena_LeifDead .include "text/dialogue/Epilogue/Piece_Altena_LeifDead.dialogue.txt" ; 9DE3F9
      dialogueEpilogue_Piece_Altena_ArionAlive .include "text/dialogue/Epilogue/Piece_Altena_ArionAlive.dialogue.txt" ; 9DE4FF
      dialogueEpilogue_Piece_Altena_LeifAlive .include "text/dialogue/Epilogue/Piece_Altena_LeifAlive.dialogue.txt" ; 9DE547
      dialogueEpilogue_Finn_LeifDead .include "text/dialogue/Epilogue/Finn_LeifDead.dialogue.txt" ; 9DE5D5
      dialogueEpilogue_Finn_LeifAlive .include "text/dialogue/Epilogue/Finn_LeifAlive.dialogue.txt" ; 9DE6D0
      dialogueEpilogue_Piece_Finn .include "text/dialogue/Epilogue/Piece_Finn.dialogue.txt" ; 9DE786
      dialogueEpilogue_Hannibal_CharlotDead .include "text/dialogue/Epilogue/Hannibal_CharlotDead.dialogue.txt" ; 9DE812
      dialogueEpilogue_Hannibal_CharlotAlive .include "text/dialogue/Epilogue/Hannibal_CharlotAlive.dialogue.txt" ; 9DE823
      dialogueEpilogue_Hannibal_CoirpreDead .include "text/dialogue/Epilogue/Hannibal_CoirpreDead.dialogue.txt" ; 9DE82E
      dialogueEpilogue_Hannibal_CoirpreAlive .include "text/dialogue/Epilogue/Hannibal_CoirpreAlive.dialogue.txt" ; 9DE83E
      dialogueEpilogue_Piece_Hannibal_Start .include "text/dialogue/Epilogue/Piece_Hannibal_Start.dialogue.txt" ; 9DE849
      dialogueEpilogue_Piece_Hannibal_CharlotCoirpreDead .include "text/dialogue/Epilogue/Piece_Hannibal_CharlotCoirpreDead.dialogue.txt" ; 9DE897
      dialogueEpilogue_Piece_Hannibal_CharlotCoirpreAlive .include "text/dialogue/Epilogue/Piece_Hannibal_CharlotCoirpreAlive.dialogue.txt" ; 9DE8F8
      dialogueEpilogue_CharlotCoirpre_HannibalDead .include "text/dialogue/Epilogue/CharlotCoirpre_HannibalDead.dialogue.txt" ; 9DE960
      dialogueEpilogue_CharlotCoirpre_HannibalDead_WithLover .include "text/dialogue/Epilogue/CharlotCoirpre_HannibalDead_WithLover.dialogue.txt" ; 9DE966
      dialogueEpilogue_CharlotCoirpre_HannibalAlive .include "text/dialogue/Epilogue/CharlotCoirpre_HannibalAlive.dialogue.txt" ; 9DE971
      dialogueEpilogue_CharlotCoirpre_HannibalAlive_WithLover .include "text/dialogue/Epilogue/CharlotCoirpre_HannibalAlive_WithLover.dialogue.txt" ; 9DE977
      dialogueEpilogue_Piece_CharlotCoirpre_HannibalDead .include "text/dialogue/Epilogue/Piece_CharlotCoirpre_HannibalDead.dialogue.txt" ; 9DE982
      dialogueEpilogue_Piece_CharlotCoirpre_HannibalAlive .include "text/dialogue/Epilogue/Piece_CharlotCoirpre_HannibalAlive.dialogue.txt" ; 9DEA83
      dialogueEpilogue_Asaello_DaisyDead .include "text/dialogue/Epilogue/Asaello_DaisyDead.dialogue.txt" ; 9DEB28
      dialogueEpilogue_Asaello_DaisyDead_WithLover .include "text/dialogue/Epilogue/Asaello_DaisyDead_WithLover.dialogue.txt" ; 9DEB2E
      dialogueEpilogue_Asaello_DaisyAlive .include "text/dialogue/Epilogue/Asaello_DaisyAlive.dialogue.txt" ; 9DEB39
      dialogueEpilogue_Asaello_DaisyAlive_WithLover .include "text/dialogue/Epilogue/Asaello_DaisyAlive_WithLover.dialogue.txt" ; 9DEB3F
      dialogueEpilogue_Piece_Asaello_Start .include "text/dialogue/Epilogue/Piece_Asaello_Start.dialogue.txt" ; 9DEB4A
      dialogueEpilogue_Piece_Asaello_DaisyDead .include "text/dialogue/Epilogue/Piece_Asaello_DaisyDead.dialogue.txt" ; 9DEBCE
      dialogueEpilogue_Piece_Asaello_DaisyDead_WithLover_Unused .include "text/dialogue/Epilogue/Piece_Asaello_DaisyDead_WithLover_Unused.dialogue.txt" ; 9DEC4F
      dialogueEpilogue_Piece_Asaello_DaisyAlive .include "text/dialogue/Epilogue/Piece_Asaello_DaisyAlive.dialogue.txt" ; 9DEC7D
      dialogueEpilogue_Daisy_LoverDead .include "text/dialogue/Epilogue/Daisy_LoverDead.dialogue.txt" ; 9DECDB
      dialogueEpilogue_Daisy_AsaelloDead .include "text/dialogue/Epilogue/Daisy_AsaelloDead.dialogue.txt" ; 9DECE1
      dialogueEpilogue_Daisy_AsaelloAlive .include "text/dialogue/Epilogue/Daisy_AsaelloAlive.dialogue.txt" ; 9DED32
      dialogueEpilogue_Piece_DaisyPatty_LoverDead .include "text/dialogue/Epilogue/Piece_DaisyPatty_LoverDead.dialogue.txt" ; 9DED84
      dialogueEpilogue_Piece_Daisy_End .include "text/dialogue/Epilogue/Piece_Daisy_End.dialogue.txt" ; 9DEEAB

      dialogueEpilogue_NewThraciaEnd_Multiple .include "text/dialogue/Epilogue/NewThraciaEnd_Multiple.dialogue.txt" ; 9DEF37
      dialogueEpilogue_NewThraciaEnd_Solo .include "text/dialogue/Epilogue/NewThraciaEnd_Solo.dialogue.txt" ; 9DEF6E
      dialogueEpilogue_Piece_NewThraciaEnd_End .include "text/dialogue/Epilogue/Piece_NewThraciaEnd_End.dialogue.txt" ; 9DEF8F

      dialogueEpilogueLover_Seliph_JuliaDead_Peppy .include "text/dialogue/Epilogue/Lover_Seliph_JuliaDead_Peppy.dialogue.txt" ; 9DEFB6
      dialogueEpilogueLover_Seliph_JuliaDead_Noble .include "text/dialogue/Epilogue/Lover_Seliph_JuliaDead_Noble.dialogue.txt" ; 9DF042
      dialogueEpilogueLover_Seliph_JuliaAlive_All .include "text/dialogue/Epilogue/Lover_Seliph_JuliaAlive_All.dialogue.txt" ; 9DF0D0
      dialogueEpilogueLover_Shannan_Peppy .include "text/dialogue/Epilogue/Lover_Shannan_Peppy.dialogue.txt" ; 9DF173
      dialogueEpilogueLover_Shannan_Noble .include "text/dialogue/Epilogue/Lover_Shannan_Noble.dialogue.txt" ; 9DF27E
      dialogueEpilogueLover_DalvinScathach_ShannanDead_Peppy .include "text/dialogue/Epilogue/Lover_DalvinScathach_ShannanDead_Peppy.dialogue.txt" ; 9DF38D
      dialogueEpilogueLover_DalvinScathach_ShannanDead_Noble .include "text/dialogue/Epilogue/Lover_DalvinScathach_ShannanDead_Noble.dialogue.txt" ; 9DF448
      dialogueEpilogueLover_DalvinScathach_ShannanDead_JeanneNanna .include "text/dialogue/Epilogue/Lover_DalvinScathach_ShannanDead_JeanneNanna.dialogue.txt" ; 9DF4FF
      dialogueEpilogueLover_DalvinScathach_ShannanAlive_All .include "text/dialogue/Epilogue/Lover_DalvinScathach_ShannanAlive_All.dialogue.txt" ; 9DF5B7
      dialogueEpilogueLover_DalvinScathach_ShannanAlive_MuirneLana .include "text/dialogue/Epilogue/Lover_DalvinScathach_ShannanAlive_MuirneLana.dialogue.txt" ; 9DF685
      dialogueEpilogueLover_Deimne_MuirneDead_Peppy .include "text/dialogue/Epilogue/Lover_Deimne_MuirneDead_Peppy.dialogue.txt" ; 9DF737
      dialogueEpilogueLover_Deimne_MuirneDead_Noble .include "text/dialogue/Epilogue/Lover_Deimne_MuirneDead_Noble.dialogue.txt" ; 9DF7EA
      dialogueEpilogueLover_Deimne_MuirneDead_CreidneLarcei .include "text/dialogue/Epilogue/Lover_Deimne_MuirneDead_CreidneLarcei.dialogue.txt" ; 9DF89F
      dialogueEpilogueLover_Deimne_MuirneAlive_All .include "text/dialogue/Epilogue/Lover_Deimne_MuirneAlive_All.dialogue.txt" ; 9DF966
      dialogueEpilogueLover_Deimne_MuirneAlive_LindaTine .include "text/dialogue/Epilogue/Lover_Deimne_MuirneAlive_LindaTine.dialogue.txt" ; 9DF9FC
      dialogueEpilogueLover_Deimne_MuirneAlive_CreidneLarcei .include "text/dialogue/Epilogue/Lover_Deimne_MuirneAlive_CreidneLarcei.dialogue.txt" ; 9DFA95
      dialogueEpilogueLover_Leif_Peppy .include "text/dialogue/Epilogue/Lover_Leif_Peppy.dialogue.txt" ; 9DFB4E
      dialogueEpilogueLover_Leif_AltenaDead_CreidneLarcei .include "text/dialogue/Epilogue/Lover_Leif_AltenaDead_CreidneLarcei.dialogue.txt" ; 9DFBE3
      dialogueEpilogueLover_Leif_AltenaAlive_CreidneLarcei .include "text/dialogue/Epilogue/Lover_Leif_AltenaAlive_CreidneLarcei.dialogue.txt" ; 9DFC84
      dialogueEpilogueLover_Leif_Noble .include "text/dialogue/Epilogue/Lover_Leif_Noble.dialogue.txt" ; 9DFD1A
      dialogueEpilogueLover_CharlotCoirpre_HannibalDead_Peppy .include "text/dialogue/Epilogue/Lover_CharlotCoirpre_HannibalDead_Peppy.dialogue.txt" ; 9DFDA4
      dialogueEpilogueLover_CharlotCoirpre_HannibalDead_CreidneLarcei .include "text/dialogue/Epilogue/Lover_CharlotCoirpre_HannibalDead_CreidneLarcei.dialogue.txt" ; 9DFE4A
      dialogueEpilogueLover_CharlotCoirpre_HannibalDead_Noble .include "text/dialogue/Epilogue/Lover_CharlotCoirpre_HannibalDead_Noble.dialogue.txt" ; 9DFED4

      .fill $9D8000 + $8000 - *, 0

    .here

    ; Compressed streams: generated from gfx/compressed/DE6230/DE6230.streams by build.sh.
    .include "gfx/compressed/DE6230/Layout.asm"

    * = $1E0000
    .logical $DE0000

      .dsection WindowPaletteDE0000Section

      g4bppWeaponTypeIcons .binary "gfx/ui/WeaponTypeIcons.4bpp" ; DE0200

      g4bppUnknownDE0A00 .binary "gfx/ui/UnknownDE0A00.4bpp" ; DE0A00

      gUnknownDE1600 .binary "gfx/ui/tilemaps/UnknownDE1600.bin" ; DE1600

      gUnknownDE1A40 .binary "gfx/ui/tilemaps/UnknownDE1A40.bin" ; DE1A40

      gUnknownDE1E80 .binary "gfx/ui/tilemaps/UnknownDE1E80.bin" ; DE1E80

      gUnknownDE22C0 .binary "gfx/ui/tilemaps/UnknownDE22C0.bin" ; DE22C0

      gUnknownDE2480 .binary "gfx/ui/tilemaps/UnknownDE2480.bin" ; DE2480

      gUnknownDE25C0 .binary "gfx/ui/tilemaps/UnknownDE25C0.bin" ; DE25C0

      gUnknownDE2700 .binary "gfx/ui/tilemaps/UnknownDE2700.bin" ; DE2700

      gUnknownDE2840 .binary "gfx/ui/tilemaps/UnknownDE2840.bin" ; DE2840

      gUnknownDE2980 .binary "gfx/ui/tilemaps/UnknownDE2980.bin" ; DE2980

      .dsection WindowPaletteDE2AC0Section

      g4bppDialogueBoxFrames .binary "gfx/ui/DialogueBoxFrames.4bpp" ; DE2CC0

      g4bppSkillIcons .binary "gfx/ui/SkillIcons.4bpp" ; DE34C0

      g4bppCursorSprites .binary "gfx/ui/CursorSprites.4bpp" ; DE40C0

      g4bppMenuCursorSprites .binary "gfx/ui/MenuCursorSprites.4bpp" ; DE44C0

      g2bppMenuLabels .binary "gfx/ui/MenuLabels.2bpp" ; DE48C0

      gUnknownDE60C0 .binary "gfx/ui/tilemaps/UnknownDE60C0.bin" ; DE60C0

      .dsection DataDE6200Section

    .here

    * = $1E8000
    .logical $9E8000

      .dsection Unsorted9E8000Section

      .dsection Unsorted9E800CSection

    .here

    * = $1E805E
    .logical $9E805E

      .dsection Unsorted9E805ESection

      .dsection Table9E80CBSection

      .dsection Unsorted9E80F2Section

      .dsection Unsorted9E811FSection

      .dsection Table9E826BSection

      .dsection Unsorted9E8271Section

      .dsection Unsorted9E82AASection

      .dsection Unsorted9E832CSection

      .dsection Unsorted9E838BSection

      .dsection Unsorted9E85A4Section

      .dsection Unsorted9E85DFSection

      .dsection Unsorted9E86CFSection

      .dsection Table9E8792Section
      .dsection Table9E879CSection

      .dsection Unsorted9E87A4Section

      .dsection Unsorted9E87CASection

      .dsection Table9E8863Section

      .dsection Unsorted9E8867Section

      .dsection Unsorted9E88CESection

      .dsection Unsorted9E88F4Section

      .dsection Unsorted9E88FASection

      .dsection Unsorted9E89F1Section

      .dsection Unsorted9E8D25Section

      .dsection Unsorted9E8D6CSection

      .dsection Table9E8EC4Section
      .dsection Table9E8F3ESection

      .dsection Unsorted9E8F6ASection

      .dsection Table9E8FB2Section

      .dsection Unsorted9E8FB3Section

      .dsection Table9E9123Section
      .dsection Table9E914BSection

      .dsection Unsorted9E915BSection

      .dsection Unsorted9E9320Section

      .dsection Unsorted9E9342Section

      .dsection Table9E9480Section
      .dsection Table9E94B6Section
      .dsection Table9E94EASection
      .dsection Table9E9504Section

      .dsection Unsorted9E950ASection

      .dsection Table9E964CSection

      .dsection Unsorted9E965ESection

      .dsection Table9E973DSection
      .dsection Table9E9787Section

      .dsection Unsorted9E978DSection

      .dsection Table9E98B0Section

      .dsection Unsorted9E98C4Section

      .dsection Table9E9910Section

      .dsection Unsorted9E9928Section

      .dsection Table9E994FSection

      .dsection Unsorted9E9967Section

      .dsection Table9E998ESection

      .dsection Unsorted9E99A4Section

      .dsection Unsorted9E99F7Section

      .dsection Unsorted9E9A34Section

      .dsection ProcScript9E9A43Section

      .dsection Unsorted9E9A4BSection

      .dsection Table9E9B50Section

      .dsection Unsorted9E9B68Section

      .dsection Unsorted9E9B82Section

      .dsection ProcScript9E9BE1Section

      .dsection Unsorted9E9C70Section

    .here

    * = $1E9CB9
    .logical $9E9CB9

      .dsection Unsorted9E9CB9Section

      .dsection Unsorted9E9D3BSection

      .dsection Unsorted9E9D76Section

      .dsection Table9E9DB9Section

      .dsection Unsorted9E9DD9Section

      .dsection Unsorted9E9E61Section

    .here

    * = $1E9F26
    .logical $9E9F26

      .dsection Unsorted9E9F26Section

      .dsection Table9EA085Section

      .dsection Unsorted9EA096Section

      .dsection Unsorted9EA1D7Section

      .dsection Unsorted9EA238Section

      .dsection ProcScript9EA334Section

      .dsection Unsorted9EA33CSection

      .dsection ProcScript9EA404Section

      .dsection Unsorted9EA417Section

      .dsection Table9EA50FSection
      .dsection Table9EA513Section
      .dsection Unsorted9EA523Section

      .dsection Unsorted9EA67CSection

      .dsection Table9EA84ASection

      .dsection Unsorted9EA850Section

      .dsection Table9EA873Section

      .dsection Unsorted9EA89FSection

      .dsection Table9EAA5CSection

      .dsection Table9EAA61Section

      .dsection Unsorted9EAB21Section

      .dsection Table9EABBDSection

      .dsection Unsorted9EABE9Section

      .dsection Unsorted9EAC49Section

      .dsection Unsorted9EAC5ASection

      .dsection Unsorted9EACAFSection

      .dsection Unsorted9EAD7BSection

      .dsection Unsorted9EADB4Section

      .dsection Unsorted9EADD1Section

      .dsection Table9EAEAFSection

      .dsection Unsorted9EAECFSection

      .dsection Table9EAF24Section

      .dsection Unsorted9EAF44Section

      .dsection ProcScript9EAF98Section

      .dsection Unsorted9EAFA0Section

      .dsection ProcScript9EAFF8Section

      .dsection Unsorted9EB01BSection

      .dsection Table9EB0ECSection

      .dsection Unsorted9EB0F2Section

      .dsection Table9EB15ASection

      .dsection Unsorted9EB160Section

      .dsection Unsorted9EB2BASection

      .dsection Unsorted9EB345Section

    .here

    * = $1EB3DE
    .logical $9EB3DE

      .dsection Unsorted9EB3DESection

    .here

    * = $1EB491
    .logical $9EB491

      .dsection Unsorted9EB491Section

      .dsection Unsorted9EB4BBSection

      .dsection Table9EB4C9Section
      .dsection Table9EB4CDSection
      .dsection Table9EB4D7Section
      .dsection Table9EB4DBSection
      .dsection Table9EB4DFSection

      .dsection BattleMapSpriteDataSection

      .dsection Unsorted9EC70BSection

      .dsection Unsorted9EC776Section

      .dsection Unsorted9EC79BSection

      .dsection Unsorted9EC7B3Section

      .dsection Unsorted9EC899Section

      .dsection Unsorted9EC8B3Section

      .dsection Unsorted9EC91ASection

      .dsection Unsorted9EC98ASection

      .dsection Unsorted9EC9FDSection

      .dsection Unsorted9ECABBSection

      .dsection ProcScript9ECAD2Section

      .dsection Unsorted9ECEA0Section

    .here

    * = $1ECEDD
    .logical $9ECEDD

      .dsection ProcScript9ECEDDSection

      .dsection Unsorted9ECEE5Section

      .dsection Table9ECF72Section

      .dsection Unsorted9ECF7ASection

      .dsection ProcScript9ECF7BSection

      .dsection Unsorted9ECFCDSection

    .here

    * = $1ED07A
    .logical $9ED07A

      .dsection Unsorted9ED07ASection

      .dsection Unsorted9ED089Section

      .dsection Unsorted9ED1A1Section

      .dsection Unsorted9ED1F4Section

      .dsection Unsorted9ED2B5Section

      .dsection Unsorted9ED337Section

      .dsection Unsorted9ED372Section

      .dsection Unsorted9ED3C1Section

      .dsection Unsorted9ED401Section

    .here

    * = $1ED42A
    .logical $9ED42A

      .dsection Unsorted9ED42ASection

      .dsection Unsorted9ED449Section

    .here

    * = $1ED535
    .logical $9ED535

      .dsection Unsorted9ED535Section

      .dsection Unsorted9ED609Section

      .dsection Unsorted9ED68BSection

      .dsection Unsorted9ED6BASection

    .here

    * = $1ED742
    .logical $9ED742

      .dsection Unsorted9ED742Section

      .dsection ProcScript9ED78BSection

      .dsection Unsorted9ED793Section

      .dsection ProcScript9ED79FSection

      .dsection Unsorted9ED7B7Section

      .dsection Table9ED7E8Section

      .dsection Unsorted9ED808Section

      .dsection Data9ED900Section

      .dsection Unsorted9EDAE7Section

      .dsection ProcScript9EDAF6Section

      .dsection Unsorted9EDAFESection

      .dsection ProcScript9EDC15Section

      .dsection Unsorted9EDCD2Section

      .dsection Table9EDDC8Section

      .dsection Unsorted9EDDE8Section

      .dsection Data9EDE89Section

      .dsection Unsorted9EDF7FSection

      .dsection ProcScript9EDF8ESection

      .dsection Unsorted9EDF96Section

      .dsection Unsorted9EDFF8Section

      .dsection ProcScript9EE011Section

      .dsection Unsorted9EE021Section

      .dsection Unsorted9EE02DSection

      .dsection ProcScript9EE03CSection

      .dsection Unsorted9EE044Section

      .dsection ProcScript9EE092Section

      .dsection Unsorted9EE0F1Section

      .dsection Table9EE11BSection

      .dsection Unsorted9EE127Section

    .here

    * = $1EE228
    .logical $9EE228

      .dsection Unsorted9EE228Section

      .dsection Table9EE2B2Section

      .dsection Unsorted9EE2BESection

    .here

    * = $1EEC95
    .logical $9EEC95

      .dsection Unsorted9EEC95Section

      .dsection ProcScript9EECA4Section

      .dsection Unsorted9EECACSection

      .dsection ProcScript9EED31Section

      .dsection Unsorted9EED7CSection

      .dsection Unsorted9EEDB5Section

      .dsection Unsorted9EEFF1Section

      .dsection Unsorted9EF1B5Section

      .dsection Unsorted9EF1D9Section

      .dsection Unsorted9EF1FASection

      .dsection Unsorted9EF353Section

      .dsection Unsorted9EF37FSection

      .dsection Unsorted9EF49ESection

      .dsection Unsorted9EF55BSection

      .dsection Unsorted9EF5D0Section

      .dsection Unsorted9EF60FSection
      .dsection BelhallaMagesAttackSection

      .dsection Unknown9EF791Section

      .dsection Unsorted9EF79DSection

      .dsection BelhallaAttackingMagePositionsSection

      .dsection BelhallaAttackingMageDirectionsSection

      .dsection ProcUnknown9EF837InitSection

      .dsection Unsorted9EF9DFSection

      .dsection Unsorted9EF9E0Section

      .dsection Unsorted9EFA17Section

      .dsection Unsorted9EFC47Section

      .fill $9E8000 + $8000 - *, $00

    .here

    ; Compressed streams: generated from gfx/compressed/DF0000/DF0000.streams by build.sh.
    .include "gfx/compressed/DF0000/Layout.asm"

    * = $1F8020
    .logical $9F8020

      .dsection Unsorted9F8020Section

      .dsection ProcScript9F805DSection

      .dsection Unsorted9F8065Section

      .dsection MapBattleMagicBackgroundsSection

      .dsection Unsorted9F8253Section

      .dsection Unsorted9F82A7Section

      .dsection Unsorted9F82D7Section

      .dsection Unsorted9F8349Section

    .here

    * = $1F83D0
    .logical $9F83D0

      .dsection Unsorted9F83D0Section

      .dsection Unsorted9F83F1Section

      .dsection Unsorted9F8414Section

      .dsection Unsorted9F86B0Section

      .dsection Unsorted9F86BFSection

      .dsection MapBattleMagicSpritesSection

    .here

    * = $1F8800
    .logical $9F8800

      .dsection MapBattleMagicPalettes9F8800Section

    .here

    * = $1F8900
    .logical $9F8900

      .dsection Unsorted9F8900Section

      .dsection Unsorted9F8943Section

      .dsection Unsorted9F8999Section

      .dsection Unsorted9F8A34Section

      .dsection Unsorted9F8A97Section

      .dsection Unsorted9F8B7ASection
      .dsection Table9F8C3ASection
      .dsection Unsorted9F8E3ASection

      .dsection SavePaletteBufferColorsToRAMSection

      .dsection Unsorted9F8EC0Section

      .dsection FadePaletteToColorsSection

      .dsection FadePaletteToBlackSection

      .dsection FadeFromToColorByStepSection

      .dsection Unsorted9F9090Section

      .dsection Unsorted9F90F2Section

    .here

    * = $1F910A
    .logical $9F910A

      .dsection Unsorted9F910ASection

      .dsection Unsorted9F9217Section

      .dsection Unsorted9F924BSection

      .dsection Unsorted9F9253Section

      .dsection Unsorted9F926ESection

      .dsection Unsorted9F92D2Section

      .dsection Unsorted9F92F3Section

      .dsection Unsorted9F9341Section

      .dsection Table9F936CSection

      .dsection Unsorted9F9378Section

      .dsection Unsorted9F94FESection

      .dsection Unsorted9F9570Section

    .here

    * = $1F95E1
    .logical $9F95E1

      .dsection Unsorted9F95E1Section

      .dsection Unsorted9F9691Section

      .dsection Unsorted9F9954Section

    .here

    * = $1F9976
    .logical $9F9976

      .dsection Unsorted9F9976Section

    .here

    * = $1F999E
    .logical $9F999E

      .dsection Unsorted9F999ESection

      .dsection Unsorted9F99CESection

    .here

    * = $1F9ABF
    .logical $9F9ABF

      .dsection Unsorted9F9ABFSection

      .dsection Unsorted9FDB68Section

      .dsection Unsorted9FDB8BSection

      .dsection Unsorted9FDBC4Section

      .dsection Unsorted9FDBFDSection

      .dsection Unsorted9FDC40Section

      .dsection Unsorted9FDC83Section

      .dsection Unsorted9FDEE3Section

      .dsection Unsorted9FE006Section

      .dsection Unsorted9FE824Section

      .dsection Unsorted9FEA0CSection

      .dsection Unsorted9FEA52Section

      .dsection Unsorted9FEBA7Section

    .here

    * = $1FEBA9
    .logical $9FEBA9

      .dsection ProcScript9FEBA9Section

      .dsection Unsorted9FECB2Section

    .here

    * = $1FED5A
    .logical $9FED5A

      .dsection Unsorted9FED5ASection

    .here

    * = $1FF060
    .logical $9FF060

      .dsection Unsorted9FF060Section

    .here

    * = $1FF100
    .logical $9FF100

      .dsection Unsorted9FF100Section

    .here

    * = $1FF250
    .logical $9FF250

      .dsection Unsorted9FF250Section

      .dsection Unsorted9FF376Section

      .dsection Unsorted9FF3EDSection

      .dsection Table9FF448Section

      .dsection Unsorted9FF450Section

      .dsection Unsorted9FF487Section
      .dsection Unsorted9FF495Section
      .dsection Unsorted9FF4A6Section
      .dsection Unsorted9FF4B7Section

      .dsection Unsorted9FF4C5Section

      .dsection Unsorted9FF4D6Section

      .dsection Unsorted9FF4DESection

      .dsection Unsorted9FF59DSection

      .dsection Unsorted9FF65ASection

      .dsection Unsorted9FF67DSection

      .dsection Data9FF729Section

      .dsection Unsorted9FF749Section

    .here

    * = $1FF9A8
    .logical $9FF9A8

      .dsection Unsorted9FF9A8Section

      .dsection Unsorted9FF9B9Section

      .dsection Unsorted9FF9C1Section

      .dsection Data9FFA78Section

      .dsection Unsorted9FFA98Section

      .dsection Unsorted9FFA9ASection

      .dsection Unsorted9FFAB4Section

    .here

    * = $1FFC00
    .logical $9FFC00

      g4bppUnknown9FFC00 .binary "gfx/ui/Unknown9FFC00.4bpp", 0, $0400 ; 9F/FC00

    .here

    * = $200000
    .logical $E00000

      .dsection BackgroundPalettesE00000Section

      .dsection DataE00060Section

      .dsection BattleAnimationPalettesE001B8Section

      .dsection BattleAnimationPalettesE001D6Section

      .dsection BattleAnimationPalettesE001F4Section

      .dsection BattleAnimationPalettesE00212Section

      .dsection BattleAnimationPalettesE00230Section

      .dsection BattleAnimationPalettesE0024ESection

      .dsection BattleAnimationPalettesE0026CSection

      .dsection BattleAnimationPalettesE0028ASection

      .dsection BattleAnimationPalettesE002A8Section

      .dsection BattleAnimationPalettesE002C6Section

      .dsection BattleAnimationPalettesE002E4Section

      .dsection BattleAnimationPalettesE00302Section

      .dsection BattleAnimationPalettesE00320Section

      .dsection BattleAnimationPalettesE0037ASection

      .dsection BattleAnimationPalettesE003D4Section

      .dsection BattleAnimationPalettesE003F2Section

      .dsection BattleAnimationPalettesE00410Section

      .dsection BattleAnimationPalettesE0042ESection

      .dsection BattleAnimationPalettesE0044CSection

      .dsection BattleAnimationPalettesE0046ASection

      .dsection BattleAnimationPalettesE00488Section

      .dsection BattleAnimationPalettesE004A6Section

      .dsection BattleAnimationPalettesE004C4Section

      .dsection BattleAnimationPalettesE004E2Section

      .dsection BattleAnimationPalettesE00500Section

      .dsection BattleAnimationPalettesE0051ESection

      .dsection BattleAnimationPalettesE0053CSection

      .dsection BattleAnimationPalettesE0055ASection

      .dsection BattleAnimationPalettesE00578Section

      .dsection BattleAnimationPalettesE00596Section

      .dsection BattleAnimationPalettesE005B4Section

      .dsection BattleAnimationPalettesE005D2Section

      .dsection BattleAnimationPalettesE005F0Section

      .dsection BattleAnimationPalettesE0060ESection

      .dsection BattleAnimationPalettesE0062CSection

      .dsection BattleAnimationPalettesE0064ASection

      .dsection BattleAnimationPalettesE00668Section

      .dsection BattleAnimationPalettesE00686Section

      .dsection BattleAnimationPalettesE006A4Section

      .dsection BattleAnimationPalettesE006C2Section

      .dsection BattleAnimationPalettesE006E0Section

      .dsection BattleAnimationPalettesE006FESection

      .dsection BattleAnimationPalettesE0071CSection

      .dsection BattleAnimationPalettesE00778Section

      .dsection BattleAnimationPalettesE007B6Section

      .dsection BattleAnimationPalettesE00832Section

      .dsection BattleAnimationPalettesE00870Section

      .dsection BattleAnimationPalettesE008AESection

      .dsection BattleAnimationPalettesE008ECSection

      .dsection BattleAnimationPalettesE0092ASection

      .dsection BattleAnimationPalettesE00B68Section

      .dsection BattleAnimationPalettesE00B86Section

      .dsection BattleAnimationPalettesE00BA4Section

      .dsection BattleAnimationPalettesE00BC2Section

      .dsection BattleAnimationPalettesE00BE0Section

      .dsection BattleAnimationPalettesE00BFESection

      .dsection BattleAnimationPalettesE00C1CSection

      .dsection BattleAnimationPalettesE00C5ASection

      .dsection BattleAnimationPalettesE00C98Section

      .dsection BattleAnimationPalettesE00CD6Section

      .dsection BattleAnimationPalettesE00D14Section

      .dsection BattleAnimationPalettesE00D32Section

      .fill $E00F30 - *, 0

    .here

    * = $200F30
    .logical $E00F30

      .dsection BattleAnimationPalettesE00F30Section

      .dsection BattleAnimationPalettesE0155ASection

      .dsection BattleAnimationPalettesE01578Section

      .dsection BattleAnimationPalettesE01596Section

      .dsection BattleAnimationPalettesE015B4Section

      .dsection BattleAnimationPalettesE015D2Section

      .dsection BattleAnimationPalettesE015F0Section

      .dsection BattleAnimationPalettesE0160ESection

      .dsection BattleAnimationPalettesE0162CSection

      .dsection BattleAnimationPalettesE0164ASection

      .dsection BattleAnimationPalettesE01668Section

      .dsection BattleAnimationPalettesE01686Section

      .dsection BattleAnimationPalettesE016C2Section

      .dsection BattleAnimationPalettesE016E0Section

      .dsection BattleAnimationPalettesE016FESection

      .dsection BattleAnimationPalettesE0171CSection

      .dsection BattleAnimationPalettesE01758Section

      .dsection BattleAnimationPalettesE01796Section

      .dsection BattleAnimationPalettesE017D4Section

      .dsection BattleAnimationPalettesE01812Section

      .dsection BattleAnimationPalettesE0188ESection

      .dsection BattleAnimationPalettesE018CCSection

      .dsection BattleAnimationPalettesE0190ASection

      .dsection BattleAnimationPalettesE01948Section

      .dsection BattleAnimationPalettesE01986Section

      .dsection BattleAnimationPalettesE019C4Section

      .dsection BattleAnimationPalettesE01A02Section

      .dsection BattleAnimationPalettesE01A40Section

      .dsection BattleAnimationPalettesE01A7ESection

      .dsection BattleAnimationPalettesE01ABCSection

      .dsection BattleAnimationPalettesE01AFASection

      .dsection BattleAnimationPalettesE01B38Section

      .dsection BattleAnimationPalettesE01B76Section

      .dsection BattleAnimationPalettesE01BB4Section

      .dsection BattleAnimationPalettesE01BF2Section

      .dsection BattleAnimationPalettesE01C30Section

      .dsection BattleAnimationPalettesE01C6ESection

      .dsection BattleAnimationPalettesE01C8CSection

      .dsection BattleAnimationPalettesE01CAASection

      .dsection BattleAnimationPalettesE01CC8Section

      .dsection BattleAnimationPalettesE01CE6Section

      .dsection BattleAnimationPalettesE01D04Section

      .dsection BattleAnimationPalettesE01D22Section

      .dsection BattleAnimationPalettesE01D40Section

      .dsection BattleAnimationPalettesE01D5ESection

      .dsection BattleAnimationPalettesE01D7CSection

      .dsection BattleAnimationPalettesE01D9ASection

      .dsection BattleAnimationPalettesE01DB8Section

      .dsection BattleAnimationPalettesE01DD6Section

      .dsection BattleAnimationPalettesE01DF4Section

      .dsection BattleAnimationPalettesE01E12Section

      .dsection BattleAnimationPalettesE01E30Section

      .dsection BattleAnimationPalettesE01E4ESection

      .dsection BattleAnimationPalettesE01E8CSection

      .dsection BattleAnimationPalettesE01ECASection

      .dsection BattleAnimationPalettesE01F08Section

      .dsection BattleAnimationPalettesE01F46Section

      .dsection BattleAnimationPalettesE01F84Section

      .dsection BattleAnimationPalettesE01FC2Section

      .dsection BattleAnimationPalettesE02000Section

      .dsection BattleAnimationPalettesE0203ESection

      .dsection DataE0205CSection

      .dsection DataE02667Section

      .dsection BackgroundPalettesE027FFSection

      .dsection TableE0283FSection

    .here

    ; Compressed streams: generated from gfx/compressed/A08000/A08000.streams by build.sh.
    .include "gfx/compressed/A08000/Layout.asm"

    * = $20285D
    .logical $E0285D

      .dsection DataE0285DSection

      .dsection BattleAnimationPalettesE0287BSection

      .dsection BattleAnimationPalettesE02AE5Section

      .dsection BattleAnimationPalettesE02B05Section

      .dsection BattleAnimationPalettesE02B23Section

      .dsection BattleAnimationPalettesE02B43Section

      .dsection BattleAnimationPalettesE02C35Section

      .dsection BattleAnimationPalettesE02C55Section

      .dsection BattleAnimationPalettesE02C73Section

      .dsection BattleAnimationPalettesE02C93Section

      .dsection BattleAnimationPalettesE02CB1Section

      .dsection BattleAnimationPalettesE02CD1Section

    .here

    ; Compressed streams: generated from gfx/compressed/E02EBD/E02EBD.streams by build.sh.
    .include "gfx/compressed/E02EBD/Layout.asm"

    * = $2DFF80
    .logical $ADFF80

      g4bppUnknownADFF80 .binary "gfx/ui/UnknownADFF80.4bpp", 0, $0080 ; AD/FF80

    .here

    * = $2E8000
    .logical $AE8000

      dialogueChapterPrologueEthlynSigurdTalk .include "text/dialogue/ChapterPrologue/EthlynSigurdTalk.dialogue.txt" ; AE8272
      dialogueChapterPrologueAzelleSigurdTalk .include "text/dialogue/ChapterPrologue/AzelleSigurdTalk.dialogue.txt" ; AE8272
      dialogueChapterPrologueLexSigurdTalk .include "text/dialogue/ChapterPrologue/LexSigurdTalk.dialogue.txt" ; AE/84B7
      dialogueChapterPrologueUnusedAlecEthlynTalk .include "text/dialogue/ChapterPrologue/UnusedAlecEthlynTalk.dialogue.txt" ; AE/865F
      dialogueChapterPrologueQuanSigurdTalk .include "text/dialogue/ChapterPrologue/QuanSigurdTalk.dialogue.txt" ; AE/87E0
      dialogueChapterPrologueUnusedQuanSigurdTalkExpanded .include "text/dialogue/ChapterPrologue/UnusedQuanSigurdTalkExpanded.dialogue.txt" ; AE/8A14
      dialogueChapterPrologueUnusedMidirAzelleTalk .include "text/dialogue/ChapterPrologue/UnusedMidirAzelleTalk.dialogue.txt" ; AE/8AAB
      dialogueChapterPrologueUnusedNaoiseAlecTalk .include "text/dialogue/ChapterPrologue/UnusedNaoiseAlecTalk.dialogue.txt" ; AE/8BC8
      
      dialogueChapter01QuanFinnTalk .include "text/dialogue/Chapter01/QuanFinnTalk.dialogue.txt" ; AE8D28
      dialogueChapter01MidirEdainTalk .include "text/dialogue/Chapter01/MidirEdainTalk.dialogue.txt" ; AE8E25
      dialogueChapter01SigurdEdainTalk .include "text/dialogue/Chapter01/SigurdEdainTalk.dialogue.txt" ; AE8F3C
      dialogueChapter01AzelleEdainTalk .include "text/dialogue/Chapter01/AzelleEdainTalk.dialogue.txt" ; AE9169
      dialogueChapter01EdainEthlynTalk .include "text/dialogue/Chapter01/EdainEthlynTalk.dialogue.txt" ; AE92B8
      dialogueChapter01DewEdainTalk .include "text/dialogue/Chapter01/DewEdainTalk.dialogue.txt" ; AE938F
      dialogueChapter01AyraQuanTalk .include "text/dialogue/Chapter01/AyraQuanTalk.dialogue.txt" ; AE9488
      
      dialogueChapter02DewLachesisTalk .include "text/dialogue/Chapter02/DewLachesisTalk.dialogue.txt" ; AE98F4
      dialogueChapter02DeirdreEthlynTalk .include "text/dialogue/Chapter02/DeirdreEthlynTalk.dialogue.txt" ; AE9A14
      dialogueChapter02QuanFinnTalk .include "text/dialogue/Chapter02/QuanFinnTalk.dialogue.txt" ; AE9B71
      dialogueChapter02SigurdLewynTalk .include "text/dialogue/Chapter02/SigurdLewynTalk.dialogue.txt" ; AE9C8C
      dialogueChapter02BeowulfLachesisTalk .include "text/dialogue/Chapter02/BeowulfLachesisTalk.dialogue.txt" ; AE9F70
      dialogueChapter02AlecSilviaTalk .include "text/dialogue/Chapter02/AlecSilviaTalk.dialogue.txt" ; AEA173
      dialogueChapter02SilviaSigurdTalk .include "text/dialogue/Chapter02/SilviaSigurdTalk.dialogue.txt" ; AEA297
      dialogueChapter02ErinysSigurdTalk .include "text/dialogue/Chapter02/ErinysSigurdTalk.dialogue.txt" ; AEA3FA

      dialogueChapter03LexAyraTalk .include "text/dialogue/Chapter03/LexAyraTalk.dialogue.txt" ; AEA5C2
      dialogueChapter03ChulainnAyraTalk .include "text/dialogue/Chapter03/ChulainnAyraTalk.dialogue.txt" ; AEA74A
      dialogueChapter03SigurdBrigidTalk .include "text/dialogue/Chapter03/SigurdBrigidTalk.dialogue.txt" ; AEA838
      dialogueChapter03ClaudSigurdTalk .include "text/dialogue/Chapter03/ClaudSigurdTalk.dialogue.txt" ; AEA99E
      dialogueChapter03MidirBrigidTalk .include "text/dialogue/Chapter03/MidirBrigidTalk.dialogue.txt" ; AEACEC
      dialogueChapter03EthlynQuanTalk .include "text/dialogue/Chapter03/EthlynQuanTalk.dialogue.txt" ; AEAE09
      dialogueChapter03EdainBrigidTalk .include "text/dialogue/Chapter03/EdainBrigidTalk.dialogue.txt" ; AEB0D3

      dialogueChapter04SigurdClaudTalk .include "text/dialogue/Chapter04/SigurdClaudTalk.dialogue.txt" ; AEB3BD
      dialogueChapter04TailtiuAzelleTalk .include "text/dialogue/Chapter04/TailtiuAzelleTalk.dialogue.txt" ; AEB568
      dialogueChapter04EdainJamkeTalk .include "text/dialogue/Chapter04/EdainJamkeTalk.dialogue.txt" ; AEB7AD
      dialogueChapter04EdainMidirTalk .include "text/dialogue/Chapter04/EdainMidirTalk.dialogue.txt" ; AEB8A6
      dialogueChapter04EdainAzelleTalk .include "text/dialogue/Chapter04/EdainAzelleTalk.dialogue.txt" ; AEB9F0
      dialogueChapter04SilviaClaudTalk .include "text/dialogue/Chapter04/SilviaClaudTalk.dialogue.txt" ; AEBBFB
      dialogueChapter04LewynSigurdTalk .include "text/dialogue/Chapter04/LewynSigurdTalk.dialogue.txt" ; AEBF7F
      dialogueChapter04ErinysLewynTalk .include "text/dialogue/Chapter04/ErinysLewynTalk.dialogue.txt" ; AEC0F6
 
      dialogueChapter05EdainBrigidTalk .include "text/dialogue/Chapter05/EdainBrigidTalk.dialogue.txt" ; AEC1E7
      dialogueChapter05ClaudEdainTalk .include "text/dialogue/Chapter05/ClaudEdainTalk.dialogue.txt" ; AEC32E
      dialogueChapter05DewJamkeTalk .include "text/dialogue/Chapter05/DewJamkeTalk.dialogue.txt" ; AEC66C
      dialogueChapter05AlecNaoiseTalk .include "text/dialogue/Chapter05/AlecNaoiseTalk.dialogue.txt" ; AEC7D6
      dialogueChapter05LexAzelleTalk .include "text/dialogue/Chapter05/LexAzelleTalk.dialogue.txt" ; AEC858
      dialogueChapter05SigurdAyraTalk .include "text/dialogue/Chapter05/SigurdAyraTalk.dialogue.txt" ; AECA23
      dialogueChapter05TailtiuAzelleTalk .include "text/dialogue/Chapter05/TailtiuAzelleTalk.dialogue.txt" ; AECB70
      dialogueChapter05TailtiuClaudTalk .include "text/dialogue/Chapter05/TailtiuClaudTalk.dialogue.txt" ; AECC71
      dialogueChapter05TailtiuLexTalk .include "text/dialogue/Chapter05/TailtiuLexTalk.dialogue.txt" ; AECD78
      dialogueChapter05ErinysLewynTalk .include "text/dialogue/Chapter05/ErinysLewynTalk.dialogue.txt" ; AECEAD
      dialogueChapter05ErinysArdenTalk .include "text/dialogue/Chapter05/ErinysArdenTalk.dialogue.txt" ; AECFF4
      dialogueChapter05ErinysNaoiseTalk .include "text/dialogue/Chapter05/ErinysNaoiseTalk.dialogue.txt" ; AED100
      dialogueChapter05SilviaClaudTalk .include "text/dialogue/Chapter05/SilviaClaudTalk.dialogue.txt" ; AED1F8
      dialogueChapter05SilviaLewynTalk .include "text/dialogue/Chapter05/SilviaLewynTalk.dialogue.txt" ; AED2ED
      dialogueChapter05SilviaAlecTalk .include "text/dialogue/Chapter05/SilviaAlecTalk.dialogue.txt" ; AED3BA
      dialogueChapter05LachesisBeowulfTalk .include "text/dialogue/Chapter05/LachesisBeowulfTalk.dialogue.txt" ; AED4E4
      dialogueChapter05LachesisNaoiseTalk .include "text/dialogue/Chapter05/LachesisNaoiseTalk.dialogue.txt" ; AED611
      dialogueChapter05LachesisDewTalk .include "text/dialogue/Chapter05/LachesisDewTalk.dialogue.txt" ; AED799
      dialogueChapter05AyraLexTalk .include "text/dialogue/Chapter05/AyraLexTalk.dialogue.txt" ; AED8CA
      dialogueChapter05AyraChulainnTalk .include "text/dialogue/Chapter05/AyraChulainnTalk.dialogue.txt" ; AEDA62
      dialogueChapter05AyraArdenTalk .include "text/dialogue/Chapter05/AyraArdenTalk.dialogue.txt" ; AEDB64
      dialogueChapter05BrigidAlecTalk .include "text/dialogue/Chapter05/BrigidAlecTalk.dialogue.txt" ; AEDC86
      dialogueChapter05BrigidJamkeTalk .include "text/dialogue/Chapter05/BrigidJamkeTalk.dialogue.txt" ; AEDDC9
      dialogueChapter05BrigidMidirTalk .include "text/dialogue/Chapter05/BrigidMidirTalk.dialogue.txt" ; AEDF1E

      dialogueChapter06OifeySeliphTalk .include "text/dialogue/Chapter06/OifeySeliphTalk.dialogue.txt" ; AEE07D
      dialogueChapter06LesterLanaTalk .include "text/dialogue/Chapter06/LesterLanaTalk.dialogue.txt" ; AEE2C2
      dialogueChapter06FeeSeliphTalk .include "text/dialogue/Chapter06/FeeSeliphTalk.dialogue.txt" ; AEE472
      dialogueChapter06LanaMuirne_JuliaTalk .include "text/dialogue/Chapter06/LanaMuirne_JuliaTalk.dialogue.txt" ; AEE626
      dialogueChapter06ScathachLarceiTalk .include "text/dialogue/Chapter06/ScathachLarceiTalk.dialogue.txt" ; AEE76F
      dialogueChapter06ArthurAmid_SeliphTalk .include "text/dialogue/Chapter06/ArthurAmid_SeliphTalk.dialogue.txt" ; AEE93A
      dialogueChapter06DeimneMuirneTalk .include "text/dialogue/Chapter06/DeimneMuirneTalk.dialogue.txt" ; AEEA90
      dialogueChapter06DalvinCreidneTalk .include "text/dialogue/Chapter06/DalvinCreidneTalk.dialogue.txt" ; AEEC0D
      dialogueChapter06Seliph_LanaMuirneTalk .include "text/dialogue/Chapter06/Seliph_LanaMuirneTalk.dialogue.txt" ; AEED93
      dialogueChapter06JuliaSeliphTalkIsaachSeized .include "text/dialogue/Chapter06/JuliaSeliphTalkIsaachSeized.dialogue.txt" ; AEEE3D
      dialogueChapter06JuliaSeliphTalkSofalaSeized .include "text/dialogue/Chapter06/JuliaSeliphTalkSofalaSeized.dialogue.txt" ; AEEF0E

      dialogueChapter07Shannan_PattyDaisyTalk .include "text/dialogue/Chapter07/Shannan_PattyDaisyTalk.dialogue.txt" ; AEEFCC
      dialogueChapter07SeliphShannanTalk .include "text/dialogue/Chapter07/SeliphShannanTalk.dialogue.txt" ; AEF22F
      dialogueChapter07Oifey_DiarmuidTristanTalk .include "text/dialogue/Chapter07/Oifey_DiarmuidTristanTalk.dialogue.txt" ; AEF36C
      dialogueChapter07LarceiCreidne_ShannanTalk .include "text/dialogue/Chapter07/LarceiCreidne_ShannanTalk.dialogue.txt" ; AEF452
      dialogueChapter07PattyDaisy_SeliphTalk .include "text/dialogue/Chapter07/PattyDaisy_SeliphTalk.dialogue.txt" ; AEF550
      dialogueChapter07AresSeliphTalk .include "text/dialogue/Chapter07/AresSeliphTalk.dialogue.txt" ; AEF7E0

      .fill $AE8000 + $8000 - *, 0

    .here

    * = $2F8000
    .logical $AF8000

      dialogueChapter09SeliphHannibalTalk .include "text/dialogue/Chapter09/SeliphHannibalTalk.dialogue.txt" ; AF8000
      dialogueChapter09LeneCoirpreTalk .include "text/dialogue/Chapter09/LeneCoirpreTalk.dialogue.txt" ; AF818B
      dialogueChapter09FinnAltenaTalk .include "text/dialogue/Chapter09/FinnAltenaTalk.dialogue.txt" ; AF8379
      dialogueChapter09HannibalAltenaTalk .include "text/dialogue/Chapter09/HannibalAltenaTalk.dialogue.txt" ; AF853B
      dialogueChapter09PattyDaisy_CoirpreCharlotTalk .include "text/dialogue/Chapter09/PattyDaisy_CoirpreCharlotTalk.dialogue.txt" ; AF86DF
      dialogueChapter09JuliaSeliphTalk .include "text/dialogue/Chapter09/JuliaSeliphTalk.dialogue.txt" ; AF879F

      dialogueChapter10LeifAltenaTalk .include "text/dialogue/Chapter10/LeifAltenaTalk.dialogue.txt" ; AF8AF2
      dialogueChapter10ShannanSeliphTalk .include "text/dialogue/Chapter10/ShannanSeliphTalk.dialogue.txt" ; AF8DA4
      dialogueChapter10OifeySeliphTalk .include "text/dialogue/Chapter10/OifeySeliphTalk.dialogue.txt" ; AF8EE2
      dialogueChapter10CoirpreCharlot_AltenaTalk .include "text/dialogue/Chapter10/CoirpreCharlot_AltenaTalk.dialogue.txt" ; AF9321
      dialogueChapter10LesterDeimne_PattyDaisyTalk .include "text/dialogue/Chapter10/LesterDeimne_PattyDaisyTalk.dialogue.txt" ; AF955C
      dialogueChapter10NannaJeanne_LeifTalk .include "text/dialogue/Chapter10/NannaJeanne_LeifTalk.dialogue.txt" ; AF96BF
      dialogueChapter10FebailAsaello_LanaMuirneTalk .include "text/dialogue/Chapter10/FebailAsaello_LanaMuirneTalk.dialogue.txt" ; AF98F8
      dialogueChapter10SeliphLeneTalk .include "text/dialogue/Chapter10/SeliphLeneTalk.dialogue.txt" ; AF9ABD
      dialogueChapter10SeliphFeeTalk .include "text/dialogue/Chapter10/SeliphFeeTalk.dialogue.txt" ; AF9CF4
      dialogueChapter10SeliphTineTalk .include "text/dialogue/Chapter10/SeliphTineTalk.dialogue.txt" ; AF9F99

      dialogueChapterFinalTineLinda_SeliphTalk .include "text/dialogue/ChapterFinal/TineLinda_SeliphTalk.dialogue.txt" ; AFA258
      dialogueChapterFinalTineLinda_CedHawkTalk .include "text/dialogue/ChapterFinal/TineLinda_CedHawkTalk.dialogue.txt" ; AFA38E
      dialogueChapterFinalTineLinda_LeifTalk .include "text/dialogue/ChapterFinal/TineLinda_LeifTalk.dialogue.txt" ; AFA4AD
      dialogueChapterFinalDaisyDeimneTalk .include "text/dialogue/ChapterFinal/DaisyDeimneTalk.dialogue.txt" ; AFA5E7
      dialogueChapterFinalJeanneLeifTalk .include "text/dialogue/ChapterFinal/JeanneLeifTalk.dialogue.txt" ; AFA6DA
      dialogueChapterFinalMuirneAsaelloTalk .include "text/dialogue/ChapterFinal/MuirneAsaelloTalk.dialogue.txt" ; AFA7F9
      dialogueChapterFinalLanaMuirne_SeliphTalk .include "text/dialogue/ChapterFinal/LanaMuirne_SeliphTalk.dialogue.txt" ; AFA97A
      dialogueChapterFinalLanaFebailTalk .include "text/dialogue/ChapterFinal/LanaFebailTalk.dialogue.txt" ; AFAAEC
      dialogueChapterFinalLanaMuirne_ScathachDalvinTalk .include "text/dialogue/ChapterFinal/LanaMuirne_ScathachDalvinTalk.dialogue.txt" ; AFAB91
      dialogueChapterFinalLarceiCreidne_SeliphTalk .include "text/dialogue/ChapterFinal/LarceiCreidne_SeliphTalk.dialogue.txt" ; AFAC38
      dialogueChapterFinalLarceiCreidne_IucharTalk .include "text/dialogue/ChapterFinal/LarceiCreidne_IucharTalk.dialogue.txt" ; AFAD11
      dialogueChapterFinalLarceiCreidne_IucharbaTalk .include "text/dialogue/ChapterFinal/LarceiCreidne_IucharbaTalk.dialogue.txt" ; AFADF0
      dialogueChapterFinalLarceiCreidne_ShannanTalk .include "text/dialogue/ChapterFinal/LarceiCreidne_ShannanTalk.dialogue.txt" ; AFAF23
      dialogueChapterFinalPattyDaisy_SeliphTalk .include "text/dialogue/ChapterFinal/PattyDaisy_SeliphTalk.dialogue.txt" ; AFB03E
      dialogueChapterFinalPattyDaisy_ShannanTalk .include "text/dialogue/ChapterFinal/PattyDaisy_ShannanTalk.dialogue.txt" ; AFB119
      dialogueChapterFinalPattyLesterTalk .include "text/dialogue/ChapterFinal/PattyLesterTalk.dialogue.txt" ; AFB28A
      dialogueChapterFinalNannaJeanne_SeliphTalk .include "text/dialogue/ChapterFinal/NannaJeanne_SeliphTalk.dialogue.txt" ; AFB326
      dialogueChapterFinalNannaAresTalk .include "text/dialogue/ChapterFinal/NannaAresTalk.dialogue.txt" ; AFB437
      dialogueChapterFinalNannaLeifTalk .include "text/dialogue/ChapterFinal/NannaLeifTalk.dialogue.txt" ; AFB5F6
      dialogueChapterFinalFeeHermina_SeliphTalk .include "text/dialogue/ChapterFinal/FeeHermina_SeliphTalk.dialogue.txt" ; AFB719
      dialogueChapterFinalFeeHermina_ArthurAmidTalk .include "text/dialogue/ChapterFinal/FeeHermina_ArthurAmidTalk.dialogue.txt" ; AFB8A4
      dialogueChapterFinalFeeOifeyTalk .include "text/dialogue/ChapterFinal/FeeOifeyTalk.dialogue.txt" ; AFB9FC
      dialogueChapter09AsaelloDaisyTalk .include "text/dialogue/Chapter09/AsaelloDaisyTalk.dialogue.txt" ; AFBC4C
      dialogueChapterFinalArthurTineTalk .include "text/dialogue/ChapterFinal/ArthurTineTalk.dialogue.txt" ; AFBDB1
      dialogueChapterFinalAmidLindaTalk .include "text/dialogue/ChapterFinal/AmidLindaTalk.dialogue.txt" ; AFBF2E
      dialogueChapter09LayleaCharlotTalk .include "text/dialogue/Chapter09/LayleaCharlotTalk.dialogue.txt" ; AFC07C
      dialogueChapter06HerminaSeliphTalk .include "text/dialogue/Chapter06/HerminaSeliphTalk.dialogue.txt" ; AFC12D

      ; afc293

    .here

    * = $2FC400
    .logical $AFC400

      g4bppUnknownAFC400 .binary "gfx/ui/UnknownAFC400.4bpp", 0, $0400 ; AF/C400

      .dsection BackgroundPalettesAFC800Section

    .here

    ; Compressed streams: generated from gfx/compressed/AFC8C0/AFC8C0.streams by build.sh.
    .include "gfx/compressed/AFC8C0/Layout.asm"

    * = $308000
    .logical $B08000

      .dsection Chapter10EventsSection
      .dsection Chapter10EventDataSection

      dialogueChapter05Opening1 .include "text/dialogue/Chapter05/Opening1.dialogue.txt" ; B084C7
      dialogueChapter05Opening2 .include "text/dialogue/Chapter05/Opening2.dialogue.txt" ; B0850C
      dialogueChapter05Opening3 .include "text/dialogue/Chapter05/Opening3.dialogue.txt" ; B086C4
      dialogueChapter05Opening4 .include "text/dialogue/Chapter05/Opening4.dialogue.txt" ; B087C1
      dialogueChapter05Opening5 .include "text/dialogue/Chapter05/Opening5.dialogue.txt" ; B0880F
      dialogueChapter05SigurdByronTalk .include "text/dialogue/Chapter05/SigurdByronTalk.dialogue.txt" ; B08903
      dialogueChapter05AndreyCharge .include "text/dialogue/Chapter05/AndreyCharge.dialogue.txt" ; B08B67
      dialogueChapter05BelhallaConversation .include "text/dialogue/Chapter05/BelhallaConversation.dialogue.txt" ; B08B98
      dialogueChapter05LubeckSeized1 .include "text/dialogue/Chapter05/LubeckSeized1.dialogue.txt" ; B09297
      dialogueChapter05LubeckSeized2 .include "text/dialogue/Chapter05/LubeckSeized2.dialogue.txt" ; B09817
      dialogueChapter05PhinoraSpawn1 .include "text/dialogue/Chapter05/PhinoraSpawn1.dialogue.txt" ; B09849
      dialogueChapter05PhinoraSpawn2 .include "text/dialogue/Chapter05/PhinoraSpawn2.dialogue.txt" ; B09DAE
      dialogueChapter05LeonsterSpawn .include "text/dialogue/Chapter05/LeonsterSpawn.dialogue.txt" ; B09E06
      dialogueChapter05ThraciaSpawn1 .include "text/dialogue/Chapter05/ThraciaSpawn1.dialogue.txt" ; B0A25F
      dialogueChapter05ThraciaSpawn2 .include "text/dialogue/Chapter05/ThraciaSpawn2.dialogue.txt" ; B0A2FF
      dialogueChapter05EthlynDiedQuanAlive1 .include "text/dialogue/Chapter05/EthlynDiedQuanAlive1.dialogue.txt" ; B0A487
      dialogueChapter05EthlynDiedQuanDead .include "text/dialogue/Chapter05/EthlynDiedQuanDead.dialogue.txt" ; B0A50E
      dialogueChapter05EthlynDiedQuanAlive2 .include "text/dialogue/Chapter05/EthlynDiedQuanAlive2.dialogue.txt" ; B0A624
      dialogueChapter05QuanAndEthlynDead .include "text/dialogue/Chapter05/QuanAndEthlynDead.dialogue.txt" ; B0A682
      dialogueChapter05PhinoraSeized1 .include "text/dialogue/Chapter05/PhinoraSeized1.dialogue.txt" ; B0A811
      dialogueChapter05PhinoraSeized2 .include "text/dialogue/Chapter05/PhinoraSeized2.dialogue.txt" ; B0A9E9
      dialogueChapter05PhinoraSeized3 .include "text/dialogue/Chapter05/PhinoraSeized3.dialogue.txt" ; B0AAD3
      dialogueChapter05PhinoraSeized4 .include "text/dialogue/Chapter05/PhinoraSeized4.dialogue.txt" ; B0AAFE
      dialogueChapter05ReptorCharge .include "text/dialogue/Chapter05/ReptorCharge.dialogue.txt" ; B0AB41
      dialogueChapter05AidaBetrayal .include "text/dialogue/Chapter05/AidaBetrayal.dialogue.txt" ; B0AB82
      dialogueChapter05ReptorBetrayalResponse .include "text/dialogue/Chapter05/ReptorBetrayalResponse.dialogue.txt" ; B0ABD0
      dialogueChapter05Ending1 .include "text/dialogue/Chapter05/Ending1.dialogue.txt" ; B0AC0B
      dialogueChapter05AnyoneAidaTalk .include "text/dialogue/Chapter05/AnyoneAidaTalk.dialogue.txt" ; B0AE59
      dialogueChapter05Ending2 .include "text/dialogue/Chapter05/Ending2.dialogue.txt" ; B0AE99
      dialogueChapter05Ending3 .include "text/dialogue/Chapter05/Ending3.dialogue.txt" ; B0B117
      dialogueChapter05Ending4SigurdAndParty .include "text/dialogue/Chapter05/Ending4SigurdAndParty.dialogue.txt" ; B0B2C7
      dialogueChapter05Ending4SigurdAlone .include "text/dialogue/Chapter05/Ending4SigurdAlone.dialogue.txt" ; B0B378
      dialogueChapter05Village1 .include "text/dialogue/Chapter05/Village1.dialogue.txt" ; B0B422
      dialogueChapter05Village2 .include "text/dialogue/Chapter05/Village2.dialogue.txt" ; B0B468
      dialogueChapter05Village3 .include "text/dialogue/Chapter05/Village3.dialogue.txt" ; B0B4B1
      dialogueChapter05Village4 .include "text/dialogue/Chapter05/Village4.dialogue.txt" ; B0B51F
      dialogueChapter05Village5 .include "text/dialogue/Chapter05/Village5.dialogue.txt" ; B0B588
      dialogueChapter05Village6 .include "text/dialogue/Chapter05/Village6.dialogue.txt" ; B0B5FC
      dialogueChapter05Village7 .include "text/dialogue/Chapter05/Village7.dialogue.txt" ; B0B66A
      dialogueChapter05LubeckSeizedByronDies .include "text/dialogue/Chapter05/LubeckSeizedByronDies.dialogue.txt" ; B0B726
      dialogueChapter05EdainAndreyBattleQuote .include "text/dialogue/Chapter05/EdainAndreyBattleQuote.dialogue.txt" ; B0B76E
      dialogueChapter05BrigidAndreyBattleQuote .include "text/dialogue/Chapter05/BrigidAndreyBattleQuote.dialogue.txt" ; B0B7E9
      dialogueChapter05SigurdLombardBattleQuote .include "text/dialogue/Chapter05/SigurdLombardBattleQuote.dialogue.txt" ; B0B8AE
      dialogueChapter05ByronSlayderBattleQuote .include "text/dialogue/Chapter05/ByronSlayderBattleQuote.dialogue.txt" ; B0B933
      dialogueChapter05ByronLubeckBattleQuote .include "text/dialogue/Chapter05/ByronLubeckBattleQuote.dialogue.txt" ; B0B968
      dialogueChapter05SlayderBattleQuote .include "text/dialogue/Chapter05/SlayderBattleQuote.dialogue.txt" ; B0B981
      dialogueChapter05AndreyBattleQuote .include "text/dialogue/Chapter05/AndreyBattleQuote.dialogue.txt" ; B0B9BA
      dialogueChapter05LombardBattleQuote .include "text/dialogue/Chapter05/LombardBattleQuote.dialogue.txt" ; B0B9DC
      dialogueChapter05VajaBattleQuote .include "text/dialogue/Chapter05/VajaBattleQuote.dialogue.txt" ; B0BA33
      dialogueChapter05EthlynThraciaBattleQuote .include "text/dialogue/Chapter05/EthlynThraciaBattleQuote.dialogue.txt" ; B0BA52
      dialogueChapter05QuanBattleQuoteEthlynAlive .include "text/dialogue/Chapter05/QuanBattleQuoteEthlynAlive.dialogue.txt" ; B0BA77
      dialogueChapter05QuanBattleQuoteEthlynDead .include "text/dialogue/Chapter05/QuanBattleQuoteEthlynDead.dialogue.txt" ; B0BAAC
      dialogueChapter05TravantBattleQuote .include "text/dialogue/Chapter05/TravantBattleQuote.dialogue.txt" ; B0BAC4
      dialogueChapter05MagornBattleQuote .include "text/dialogue/Chapter05/MagornBattleQuote.dialogue.txt" ; B0BB0C
      dialogueChapter05ReptorBattleQuotePostBetrayal .include "text/dialogue/Chapter05/ReptorBattleQuotePostBetrayal.dialogue.txt" ; B0BB36
      dialogueChapter05ReptorBattleQuotePreBetrayal .include "text/dialogue/Chapter05/ReptorBattleQuotePreBetrayal.dialogue.txt" ; B0BB5B

      dialogueEpilogue_Ares .include "text/dialogue/Epilogue/Ares.dialogue.txt" ; B0BB8B
      dialogueEpilogue_Ares_WithLover .include "text/dialogue/Epilogue/Ares_WithLover.dialogue.txt" ; B0BB91
      dialogueEpilogue_Piece_Ares .include "text/dialogue/Epilogue/Piece_Ares.dialogue.txt" ; B0BB9C
      dialogueEpilogue_LayleaLene_LoverDead .include "text/dialogue/Epilogue/LayleaLene_LoverDead.dialogue.txt" ; B0BD13
      dialogueEpilogue_LayleaLene_AresDead .include "text/dialogue/Epilogue/LayleaLene_AresDead.dialogue.txt" ; B0BDD5
      dialogueEpilogue_LayleaLene_AresAlive .include "text/dialogue/Epilogue/LayleaLene_AresAlive.dialogue.txt" ; B0BE2D
      dialogueEpilogue_Piece_LayleaLene_End .include "text/dialogue/Epilogue/Piece_LayleaLene_End.dialogue.txt" ; B0BE73
      dialogueEpilogue_Diarmuid_AresDead .include "text/dialogue/Epilogue/Diarmuid_AresDead.dialogue.txt" ; B0BF1B
      dialogueEpilogue_Diarmuid_AresDead_WithLover .include "text/dialogue/Epilogue/Diarmuid_AresDead_WithLover.dialogue.txt" ; B0BF21
      dialogueEpilogue_Diarmuid_AresAlive .include "text/dialogue/Epilogue/Diarmuid_AresAlive.dialogue.txt" ; B0BF2C
      dialogueEpilogue_Diarmuid_AresAlive_WithLover .include "text/dialogue/Epilogue/Diarmuid_AresAlive_WithLover.dialogue.txt" ; B0BF32
      dialogueEpilogue_Piece_Diarmuid_AresDead .include "text/dialogue/Epilogue/Piece_Diarmuid_AresDead.dialogue.txt" ; B0BF3D
      dialogueEpilogue_Piece_DiarmuidNanna_Mother .include "text/dialogue/Epilogue/Piece_DiarmuidNanna_Mother.dialogue.txt" ; B0BFA8
      dialogueEpilogue_Piece_DiarmuidNanna_End .include "text/dialogue/Epilogue/Piece_DiarmuidNanna_End.dialogue.txt" ; B0BFD9
      dialogueEpilogue_Piece_Diarmuid_WithLover_Unused .include "text/dialogue/Epilogue/Piece_Diarmuid_WithLover_Unused.dialogue.txt" ; B0C043
      dialogueEpilogue_Piece_Diarmuid_AresAlive .include "text/dialogue/Epilogue/Piece_Diarmuid_AresAlive.dialogue.txt" ; B0C0E8
      dialogueEpilogue_Tristan_AresDead .include "text/dialogue/Epilogue/Tristan_AresDead.dialogue.txt" ; B0C15F
      dialogueEpilogue_Tristan_AresDead_WithLover .include "text/dialogue/Epilogue/Tristan_AresDead_WithLover.dialogue.txt" ; B0C165
      dialogueEpilogue_Tristan_AresAlive .include "text/dialogue/Epilogue/Tristan_AresAlive.dialogue.txt" ; B0C170
      dialogueEpilogue_Tristan_AresAlive_WithLover .include "text/dialogue/Epilogue/Tristan_AresAlive_WithLover.dialogue.txt" ; B0C176
      dialogueEpilogue_Piece_Tristan_AresDead .include "text/dialogue/Epilogue/Piece_Tristan_AresDead.dialogue.txt" ; B0C181
      dialogueEpilogue_Piece_Tristan_WithLover_Unused .include "text/dialogue/Epilogue/Piece_Tristan_WithLover_Unused.dialogue.txt" ; B0C223
      dialogueEpilogue_Piece_Tristan_AresAlive .include "text/dialogue/Epilogue/Piece_Tristan_AresAlive.dialogue.txt" ; B0C2BB
      dialogueEpilogue_Nanna_AresDead .include "text/dialogue/Epilogue/Nanna_AresDead.dialogue.txt" ; B0C352
      dialogueEpilogue_Nanna_LoverDead .include "text/dialogue/Epilogue/Nanna_LoverDead.dialogue.txt" ; B0C3C5
      dialogueEpilogue_Piece_JeanneNanna_LoverDead .include "text/dialogue/Epilogue/Piece_JeanneNanna_LoverDead.dialogue.txt" ; B0C41A
      dialogueEpilogue_Nanna_AresAlive_DiarmuidDead .include "text/dialogue/Epilogue/Nanna_AresAlive_DiarmuidDead.dialogue.txt" ; B0C488
      dialogueEpilogue_Nanna_AresAlive_DiarmuidAlive .include "text/dialogue/Epilogue/Nanna_AresAlive_DiarmuidAlive.dialogue.txt" ; B0C50E
      dialogueEpilogue_Jeanne_LoverDead .include "text/dialogue/Epilogue/Jeanne_LoverDead.dialogue.txt" ; B0C5E2
      dialogueEpilogue_Jeanne_TristanDead .include "text/dialogue/Epilogue/Jeanne_TristanDead.dialogue.txt" ; B0C62B
      dialogueEpilogue_Jeanne_TristanAlive .include "text/dialogue/Epilogue/Jeanne_TristanAlive.dialogue.txt" ; B0C76B

      dialogueEpilogue_AgustriaEnd_Multiple .include "text/dialogue/Epilogue/AgustriaEnd_Multiple.dialogue.txt" ; B0C825
      dialogueEpilogue_AgustriaEnd_Solo .include "text/dialogue/Epilogue/AgustriaEnd_Solo.dialogue.txt" ; B0C862
      dialogueEpilogue_Piece_AgustriaEnd_Start .include "text/dialogue/Epilogue/Piece_AgustriaEnd_Start.dialogue.txt" ; B0C887
      dialogueEpilogue_Piece_AgustriaEnd_End .include "text/dialogue/Epilogue/Piece_AgustriaEnd_End.dialogue.txt" ; B0C8C1

      dialogueEpilogue_JamkesSon .include "text/dialogue/Epilogue/JamkesSon.dialogue.txt" ; B0C8D1
      dialogueEpilogue_JamkesSon_WithLover .include "text/dialogue/Epilogue/JamkesSon_WithLover.dialogue.txt" ; B0C8D7
      dialogueEpilogue_Piece_JamkesChild .include "text/dialogue/Epilogue/Piece_JamkesChild.dialogue.txt" ; B0C8E2
      dialogueEpilogue_JamkesDaughter_BrotherDead .include "text/dialogue/Epilogue/JamkesDaughter_BrotherDead.dialogue.txt" ; B0CA2D
      dialogueEpilogue_JamkesDaughter_BrotherAlive .include "text/dialogue/Epilogue/JamkesDaughter_BrotherAlive.dialogue.txt" ; B0CA33
      dialogueEpilogue_JamkesDaughter_BrotherAlive_LoverDead .include "text/dialogue/Epilogue/JamkesDaughter_BrotherAlive_LoverDead.dialogue.txt" ; B0CABE

      .include "events/Chapter03/EventChapter03LexAyraTalk.asm"
      .include "events/Chapter03/EventChapter03ChulainnAyraTalk.asm"
      .include "events/Chapter03/EventChapter03SigurdBrigidTalk.asm"
      .include "events/Chapter03/EventChapter03ClaudSigurdTalk.asm"
      .include "events/Chapter03/EventChapter03MidirBrigidTalk.asm"
      .include "events/Chapter03/EventChapter03EthlynQuanTalk.asm"
      .include "events/Chapter03/EventChapter03EdainBrigidTalk.asm"

      .include "events/Chapter04/EventChapter04SigurdClaudTalk.asm"
      .include "events/Chapter04/EventChapter04TailtiuAzelleTalk.asm"
      .include "events/Chapter04/EventChapter04EdainJamkeTalk.asm"
      .include "events/Chapter04/EventChapter04EdainMidirTalk.asm"
      .include "events/Chapter04/EventChapter04EdainAzelleTalk.asm"
      .include "events/Chapter04/EventChapter04SilviaClaudTalk.asm"
      .include "events/Chapter04/EventChapter04LewynSigurdTalk.asm"
      .include "events/Chapter04/EventChapter04ErinysLewynTalk.asm"

      .include "events/Chapter05/EventChapter05EdainBrigidTalk.asm"
      .include "events/Chapter05/EventChapter05ClaudEdainTalk.asm"
      .include "events/Chapter05/EventChapter05DewJamkeTalk.asm"
      .include "events/Chapter05/EventChapter05AlecNaoiseTalk.asm"
      .include "events/Chapter05/EventChapter05LexAzelleTalk.asm"
      .include "events/Chapter05/EventChapter05SigurdAyraTalk.asm"
      .include "events/Chapter05/EventChapter05_1CE.asm"
      .include "events/Chapter05/EventChapter05TailtiuAzelleTalk.asm"
      .include "events/Chapter05/EventChapter05TailtiuClaudTalk.asm"
      .include "events/Chapter05/EventChapter05TailtiuLexTalk.asm"
      .include "events/Chapter05/EventChapter05ErinysLewynTalk.asm"
      .include "events/Chapter05/EventChapter05ErinysArdenTalk.asm"
      .include "events/Chapter05/EventChapter05ErinysNaoiseTalk.asm"
      .include "events/Chapter05/EventChapter05SilviaClaudTalk.asm"
      .include "events/Chapter05/EventChapter05SilviaLewynTalk.asm"
      .include "events/Chapter05/EventChapter05SilviaAlecTalk.asm"
      .include "events/Chapter05/EventChapter05LachesisBeowulfTalk.asm"
      .include "events/Chapter05/EventChapter05LachesisNaoiseTalk.asm"
      .include "events/Chapter05/EventChapter05LachesisDewTalk.asm"
      .include "events/Chapter05/EventChapter05AyraLexTalk.asm"
      .include "events/Chapter05/EventChapter05AyraChulainnTalk.asm"
      .include "events/Chapter05/EventChapter05AyraArdenTalk.asm"
      .include "events/Chapter05/EventChapter05BrigidAlecTalk.asm"
      .include "events/Chapter05/EventChapter05BrigidJamkeTalk.asm"
      .include "events/Chapter05/EventChapter05BrigidMidirTalk.asm"

      dialogueChapterPrologueMidirGerrardBattleQuote .include "text/dialogue/ChapterPrologue/MidirGerrardBattleQuote.dialogue.txt" ; B0CFE7
      
      dialogueChapter01MidirMunnirBattleQuote .include "text/dialogue/Chapter01/MidirMunnirBattleQuote.dialogue.txt" ; B0D03A
      dialogueChapter01AzelleMunnirBattleQuote .include "text/dialogue/Chapter01/AzelleMunnirBattleQuote.dialogue.txt" ; B0D09B
      dialogueChapter01DeirdreSandimaBattleQuote .include "text/dialogue/Chapter01/DeirdreSandimaBattleQuote.dialogue.txt" ; B0D0EB
      dialogueChapter01JamkeSandimaBattleQuote .include "text/dialogue/Chapter01/JamkeSandimaBattleQuote.dialogue.txt" ; B0D128
      dialogueChapter01UnusedEdainJamkeBattleQuote .include "text/dialogue/Chapter01/UnusedEdainJamkeBattleQuote.dialogue.txt" ; B0D17A

      dialogueChapter02ErinysChagallBattleQuote .include "text/dialogue/Chapter02/ErinysChagallBattleQuote.dialogue.txt" ; B0D1B5
      dialogueChapter02LachesisChagallBattleQuote .include "text/dialogue/Chapter02/LachesisChagallBattleQuote.dialogue.txt" ; B0D218
      dialogueChapter02LachesisElliotBattleQuote .include "text/dialogue/Chapter02/LachesisElliotBattleQuote.dialogue.txt" ; B0D280
      dialogueChapter02BeowulfWaltzBattleQuote .include "text/dialogue/Chapter02/BeowulfWaltzBattleQuote.dialogue.txt" ; B0D2F9
      dialogueChapter02LewynMacBethBattleQuote .include "text/dialogue/Chapter02/LewynMacBethBattleQuote.dialogue.txt" ; B0D362
      dialogueChapter02UnusedLewynErinysBattleQuote .include "text/dialogue/Chapter02/UnusedLewynErinysBattleQuote.dialogue.txt" ; B0D3B0

      dialogueChapter03SigurdEldiganBattleQuote .include "text/dialogue/Chapter03/SigurdEldiganBattleQuote.dialogue.txt" ; B0D3D2
      dialogueChapter03BrigidDuvallBattleQuote .include "text/dialogue/Chapter03/BrigidDuvallBattleQuote.dialogue.txt" ; B0D440
      dialogueChapter03LachesisChagallBattleQuote .include "text/dialogue/Chapter03/LachesisChagallBattleQuote.dialogue.txt" ; B0D48A
      dialogueChapter03SigurdChagallBattleQuote .include "text/dialogue/Chapter03/SigurdChagallBattleQuote.dialogue.txt" ; B0D4DB
      dialogueChapter03UnusedLachesisEldiganBattleQuote .include "text/dialogue/Chapter03/UnusedLachesisEldiganBattleQuote.dialogue.txt" ; B0D572

      dialogueChapter04LewynMyosBattleQuote .include "text/dialogue/Chapter04/LewynMyosBattleQuote.dialogue.txt" ; B0D59A
      dialogueChapter04LewynDaccarBattleQuote .include "text/dialogue/Chapter04/LewynDaccarBattleQuote.dialogue.txt" ; B0D602
      dialogueChapter04ErinysDithorbaBattleQuote .include "text/dialogue/Chapter04/ErinysDithorbaBattleQuote.dialogue.txt" ; B0D66D
      dialogueChapter04ErinysPamelaBattleQuote .include "text/dialogue/Chapter04/ErinysPamelaBattleQuote.dialogue.txt" ; B0D722
      dialogueChapter04LewynPamelaBattleQuote .include "text/dialogue/Chapter04/LewynPamelaBattleQuote.dialogue.txt" ; B0D7B0

      dialogueChapter05LexLombardBattleQuote .include "text/dialogue/Chapter05/LexLombardBattleQuote.dialogue.txt" ; B0D83C
      dialogueChapter05TailtiuReptorBattleQuote .include "text/dialogue/Chapter05/TailtiuReptorBattleQuote.dialogue.txt" ; B0D8B6
      dialogueChapter05SigurdMagornBattleQuote .include "text/dialogue/Chapter05/SigurdMagornBattleQuote.dialogue.txt" ; B0D990
      dialogueChapter05SigurdReptorBattleQuote .include "text/dialogue/Chapter05/SigurdReptorBattleQuote.dialogue.txt" ; B0D9B9
      dialogueChapter05AidaReptorBattleQuote .include "text/dialogue/Chapter05/AidaReptorBattleQuote.dialogue.txt" ; B0DB71

      dialogueChapter06IucharDanannBattleQuote .include "text/dialogue/Chapter06/IucharDanannBattleQuote.dialogue.txt" ; B0DBD0
      dialogueChapter06IucharbaDanannBattleQuote .include "text/dialogue/Chapter06/IucharbaDanannBattleQuote.dialogue.txt" ; B0DC39
      dialogueChapter06IucharIucharbaBattleQuote .include "text/dialogue/Chapter06/IucharIucharbaBattleQuote.dialogue.txt" ; B0DCBE
      dialogueChapter06LarceiCreidne_IucharBattleQuote .include "text/dialogue/Chapter06/LarceiCreidne_IucharBattleQuote.dialogue.txt" ; B0DD49
      dialogueChapter06LarceiCreidne_IucharbaBattleQuote .include "text/dialogue/Chapter06/LarceiCreidne_IucharbaBattleQuote.dialogue.txt" ; B0DD77
      dialogueChapter06SeliphDanannBattleQuote .include "text/dialogue/Chapter06/SeliphDanannBattleQuote.dialogue.txt" ; B0DDA2

      dialogueChapter07ArthurAmid_TineLindaBattleQuote .include "text/dialogue/Chapter07/ArthurAmid_TineLindaBattleQuote.dialogue.txt" ; B0DE30
      dialogueChapter07AresBramselBattleQuote .include "text/dialogue/Chapter07/AresBramselBattleQuote.dialogue.txt" ; B0DE78
      dialogueChapter07AresJavarroBattleQuote .include "text/dialogue/Chapter07/AresJavarroBattleQuote.dialogue.txt" ; B0DEFA
      dialogueChapter07TineLinda_BloomBattleQuote .include "text/dialogue/Chapter07/TineLinda_BloomBattleQuote.dialogue.txt" ; B0DF4C
      dialogueChapter07ArthurAmid_BloomBattleQuote .include "text/dialogue/Chapter07/ArthurAmid_BloomBattleQuote.dialogue.txt" ; B0DF90
      dialogueChapter07LeifBloomBattleQuote .include "text/dialogue/Chapter07/LeifBloomBattleQuote.dialogue.txt" ; B0E01A

      dialogueChapter08FebailAsaello_BloomBattleQuote .include "text/dialogue/Chapter08/FebailAsaello_BloomBattleQuote.dialogue.txt" ; B0E09C
      dialogueChapter08TineLinda_IshtarBattleQuote .include "text/dialogue/Chapter08/TineLinda_IshtarBattleQuote.dialogue.txt" ; B0E115
      dialogueChapter08TineLinda_BloomBattleQuote .include "text/dialogue/Chapter08/TineLinda_BloomBattleQuote.dialogue.txt" ; B0E181
      dialogueChapter08SeliphBloomBattleQuote .include "text/dialogue/Chapter08/SeliphBloomBattleQuote.dialogue.txt" ; B0E1E8
      dialogueChapter08UnusedPattyFebailBattleQuote .include "text/dialogue/Chapter08/UnusedPattyFebailBattleQuote.dialogue.txt" ; B0E27D

      dialogueChapter09LeifAltenaBattleQuote .include "text/dialogue/Chapter09/LeifAltenaBattleQuote.dialogue.txt" ; B0E2A8
      dialogueChapter09FinnAltenaBattleQuote .include "text/dialogue/Chapter09/FinnAltenaBattleQuote.dialogue.txt" ; B0E317
      dialogueChapter09UnusedAltenaArionBattleQuote .include "text/dialogue/Chapter09/UnusedAltenaArionBattleQuote.dialogue.txt" ; B0E363
      dialogueChapter09LeifTravantBattleQuote .include "text/dialogue/Chapter09/LeifTravantBattleQuote.dialogue.txt" ; B0E3EC
      dialogueChapter09FinnTravantBattleQuote .include "text/dialogue/Chapter09/FinnTravantBattleQuote.dialogue.txt" ; B0E4F7
      dialogueChapter09SeliphArionBattleQuote .include "text/dialogue/Chapter09/SeliphArionBattleQuote.dialogue.txt" ; B0E58E
      dialogueChapter10TineLinda_HildaBattleQuote .include "text/dialogue/Chapter10/TineLinda_HildaBattleQuote.dialogue.txt" ; B0E61E
      dialogueChapter10SeliphHildaBattleQuote .include "text/dialogue/Chapter10/SeliphHildaBattleQuote.dialogue.txt" ; B0E72D

      dialogueChapterFinalIuchar_BrianBattleQuote .include "text/dialogue/ChapterFinal/Iuchar_BrianBattleQuote.dialogue.txt" ; B0E769
      dialogueChapterFinalIucharba_BrianBattleQuote .include "text/dialogue/ChapterFinal/Iucharba_BrianBattleQuote.dialogue.txt" ; B0E7F7
      dialogueChapterFinalTineLinda_HildaBattleQuote .include "text/dialogue/ChapterFinal/TineLinda_HildaBattleQuote.dialogue.txt" ; B0E889
      dialogueChapterFinalArthur_HildaBattleQuote .include "text/dialogue/ChapterFinal/Arthur_HildaBattleQuote.dialogue.txt" ; B0E906
      dialogueChapterFinalFebail_ScipioBattleQuote .include "text/dialogue/ChapterFinal/Febail_ScipioBattleQuote.dialogue.txt" ; B0E99D
      dialogueChapterFinalLester_ScipioBattleQuote .include "text/dialogue/ChapterFinal/Lester_ScipioBattleQuote.dialogue.txt" ; B0EA3C
      dialogueChapterFinalTineLinda_IshtarBattleQuote .include "text/dialogue/ChapterFinal/TineLinda_IshtarBattleQuote.dialogue.txt" ; B0EADE
      dialogueChapterFinalSeliph_ManfroyBattleQuote .include "text/dialogue/ChapterFinal/Seliph_ManfroyBattleQuote.dialogue.txt" ; B0EB80
      dialogueChapterFinalAltena_ArionBattleQuote .include "text/dialogue/ChapterFinal/Altena_ArionBattleQuote.dialogue.txt" ; B0ED61

      dialogueEpilogueLover_Diarmuid_Peppy .include "text/dialogue/Epilogue/Lover_Diarmuid_Peppy.dialogue.txt" ; B0EDB3
      dialogueEpilogueLover_Diarmuid_Noble .include "text/dialogue/Epilogue/Lover_Diarmuid_Noble.dialogue.txt" ; B0EE5A
      dialogueEpilogueLover_Tristan_Peppy .include "text/dialogue/Epilogue/Lover_Tristan_Peppy.dialogue.txt" ; B0EF04
      dialogueEpilogueLover_Tristan_Noble .include "text/dialogue/Epilogue/Lover_Tristan_Noble.dialogue.txt" ; B0EFB1
      dialogueEpilogueLover_JamkesSon_Peppy .include "text/dialogue/Epilogue/Lover_JamkesSon_Peppy.dialogue.txt" ; B0F049
      dialogueEpilogueLover_JamkesSon_CreidneLarcei .include "text/dialogue/Epilogue/Lover_JamkesSon_CreidneLarcei.dialogue.txt" ; B0F0F5
      dialogueEpilogueLover_JamkesSon_Noble .include "text/dialogue/Epilogue/Lover_JamkesSon_Noble.dialogue.txt" ; B0F1F1
      dialogueEpilogueLover_Febail_Peppy .include "text/dialogue/Epilogue/Lover_Febail_Peppy.dialogue.txt" ; B0F2E5
      dialogueEpilogueLover_Febail_CreidneLarcei .include "text/dialogue/Epilogue/Lover_Febail_CreidneLarcei.dialogue.txt" ; B0F36D
      dialogueEpilogueLover_Febail_MuirneLana .include "text/dialogue/Epilogue/Lover_Febail_MuirneLana.dialogue.txt" ; B0F3FA
      dialogueEpilogueLover_Febail_Noble .include "text/dialogue/Epilogue/Lover_Febail_Noble.dialogue.txt" ; B0F486
      dialogueEpilogueLover_Lester_BrigidsChildrenDead_Peppy .include "text/dialogue/Epilogue/Lover_Lester_BrigidsChildrenDead_Peppy.dialogue.txt" ; B0F513
      dialogueEpilogueLover_Lester_BrigidsChildrenDead_Noble .include "text/dialogue/Epilogue/Lover_Lester_BrigidsChildrenDead_Noble.dialogue.txt" ; B0F598
      dialogueEpilogueLover_Lester_BrigidsChildrenAlive_Peppy .include "text/dialogue/Epilogue/Lover_Lester_BrigidsChildrenAlive_Peppy.dialogue.txt" ; B0F60D
      dialogueEpilogueLover_Lester_BrigidsChildrenAlive_Noble .include "text/dialogue/Epilogue/Lover_Lester_BrigidsChildrenAlive_Noble.dialogue.txt" ; B0F64E
      dialogueEpilogueLover_AmidArthur_Peppy .include "text/dialogue/Epilogue/Lover_AmidArthur_Peppy.dialogue.txt" ; B0F694
      dialogueEpilogueLover_AmidArthur_NobleA .include "text/dialogue/Epilogue/Lover_AmidArthur_NobleA.dialogue.txt" ; B0F6FF
      dialogueEpilogueLover_AmidArthur_NobleB .include "text/dialogue/Epilogue/Lover_AmidArthur_NobleB.dialogue.txt" ; B0F779
      dialogueEpilogueLover_LexSon_Peppy .include "text/dialogue/Epilogue/Lover_LexSon_Peppy.dialogue.txt" ; B0F7F4
      dialogueEpilogueLover_LexSon_CreidneLarcei .include "text/dialogue/Epilogue/Lover_LexSon_CreidneLarcei.dialogue.txt" ; B0F86D
      dialogueEpilogueLover_LexSon_Noble .include "text/dialogue/Epilogue/Lover_LexSon_Noble.dialogue.txt" ; B0F8F1
      dialogueEpilogueLover_Iuchar_Peppy .include "text/dialogue/Epilogue/Lover_Iuchar_Peppy.dialogue.txt" ; B0F96A
      dialogueEpilogueLover_Iuchar_CreidneLarcei .include "text/dialogue/Epilogue/Lover_Iuchar_CreidneLarcei.dialogue.txt" ; B0F9E5
      dialogueEpilogueLover_Iuchar_Noble .include "text/dialogue/Epilogue/Lover_Iuchar_Noble.dialogue.txt" ; B0FA6C
      dialogueEpilogueLover_Iucharba_Peppy .include "text/dialogue/Epilogue/Lover_Iucharba_Peppy.dialogue.txt" ; B0FADF
      dialogueEpilogueLover_Iucharba_Noble .include "text/dialogue/Epilogue/Lover_Iucharba_Noble.dialogue.txt" ; B0FB80
      dialogueEpilogueLover_ClaudsSon_Peppy .include "text/dialogue/Epilogue/Lover_ClaudsSon_Peppy.dialogue.txt" ; B0FC20
      dialogueEpilogueLover_ClaudsSon_CreidneLarcei .include "text/dialogue/Epilogue/Lover_ClaudsSon_CreidneLarcei.dialogue.txt" ; B0FCA1
      dialogueEpilogueLover_ClaudsSon_MuirneLana .include "text/dialogue/Epilogue/Lover_ClaudsSon_MuirneLana.dialogue.txt" ; B0FD27
      dialogueEpilogueLover_ClaudsSon_LindaTine .include "text/dialogue/Epilogue/Lover_ClaudsSon_LindaTine.dialogue.txt" ; B0FDB0
      dialogueEpilogueLover_ClaudsSon_JeanneNanna .include "text/dialogue/Epilogue/Lover_ClaudsSon_JeanneNanna.dialogue.txt" ; B0FE32

      .fill $B08000 + $8000 - *, 0

    .here

    * = $318000
    .logical $B18000

      .include "events/ChapterPrologue/EventPrologueOpening.asm"
      .include "events/ChapterPrologue/EventPrologueEdainAbduction.asm"
      .include "events/ChapterPrologue/EventPrologueQuanGroupSpawn.asm"
      .include "events/ChapterPrologue/EventPrologueLexAzelleSpawn.asm"
      .include "events/ChapterPrologue/EventPrologueYngviSeized.asm"
      .include "events/ChapterPrologue/EventPrologueEvansSpawn.asm"
      .include "events/ChapterPrologue/EventPrologueArvisSpawn.asm"
      .include "events/ChapterPrologue/EventPrologueEnding.asm"
      .include "events/ChapterPrologue/EventPrologueSigurdHomeCastle.asm"
      .include "events/ChapterPrologue/EventPrologue00A.asm"
      .include "events/ChapterPrologue/EventPrologue00B.asm"
      .include "events/ChapterPrologue/EventPrologue00C.asm"
      .include "events/ChapterPrologue/EventPrologue00D.asm"
      .include "events/ChapterPrologue/EventPrologue00E.asm"
      .include "events/ChapterPrologue/EventPrologue00F.asm"
      .include "events/ChapterPrologue/EventPrologue010.asm"
      .include "events/ChapterPrologue/EventPrologue011.asm"
      .include "events/ChapterPrologue/EventPrologue012.asm"
      .include "events/ChapterPrologue/EventPrologueSigurdArvisTalk.asm"
      .include "events/ChapterPrologue/EventPrologueVillage1.asm"
      .include "events/ChapterPrologue/EventPrologueVillage2.asm"
      .include "events/ChapterPrologue/EventPrologueVillage4.asm"
      .include "events/ChapterPrologue/EventPrologueVillage3.asm"
      .include "events/ChapterPrologue/EventPrologueVillageSpeedRing.asm"
      .include "events/ChapterPrologue/EventPrologueQuanDied.asm"
      .include "events/ChapterPrologue/EventPrologueEthlynDied.asm"
      .include "events/ChapterPrologue/EventPrologueFinnDied.asm"
      .include "events/ChapterPrologue/EventPrologue01C.asm"
      .include "events/ChapterPrologue/EventPrologue01D.asm"
      .include "events/ChapterPrologue/EventPrologue01E.asm"
      .include "events/ChapterPrologue/EventPrologue01F.asm"

      dialogueChapterPrologueOpening1 .include "text/dialogue/ChapterPrologue/Opening1.dialogue.txt" ; B18771
      dialogueChapterPrologueOpening2 .include "text/dialogue/ChapterPrologue/Opening2.dialogue.txt" ; B18874
      dialogueChapterPrologueMunnirMidirBattleQuote .include "text/dialogue/ChapterPrologue/MunnirMidirBattleQuote.dialogue.txt" ; B18E93
      dialogueChapterPrologueMidirCutsceneDeath .include "text/dialogue/ChapterPrologue/MidirCutsceneDeath.dialogue.txt" ; B18ECD
      dialogueChapterPrologueMunnirEdainCaptured .include "text/dialogue/ChapterPrologue/MunnirEdainCaptured.dialogue.txt" ; B18EF7
      dialogueChapterPrologueMunnirLowerBridge .include "text/dialogue/ChapterPrologue/MunnirLowerBridge.dialogue.txt" ; B1901C
      dialogueChapterPrologueMunnirHurryUp .include "text/dialogue/ChapterPrologue/MunnirHurryUp.dialogue.txt" ; B19067
      dialogueChapterPrologueDiMaggioYngviTakeover .include "text/dialogue/ChapterPrologue/DiMaggioYngviTakeover.dialogue.txt" ; B190A5
      dialogueChapterPrologueQuanGroupSpawn .include "text/dialogue/ChapterPrologue/QuanGroupSpawn.dialogue.txt" ; B190DC
      dialogueChapterPrologueDiMaggioBattleQuote .include "text/dialogue/ChapterPrologue/DiMaggioBattleQuote.dialogue.txt" ; B19291
      dialogueChapterPrologueYngviSeized .include "text/dialogue/ChapterPrologue/YngviSeized.dialogue.txt" ; B192C5
      dialogueChapterPrologueEvansSpawn .include "text/dialogue/ChapterPrologue/EvansSpawn.dialogue.txt" ; B19403
      dialogueChapterPrologueEnding2 .include "text/dialogue/ChapterPrologue/Ending2.dialogue.txt" ; B1946F
      dialogueChapterPrologueMunnirAttackCastle .include "text/dialogue/ChapterPrologue/MunnirAttackCastle.dialogue.txt" ; B195BC
      dialogueChapterPrologueGerrardBattleQuote .include "text/dialogue/ChapterPrologue/GerrardBattleQuote.dialogue.txt" ; B195FA
      dialogueChapterPrologueMunnirGerrardConversation .include "text/dialogue/ChapterPrologue/MunnirGerrardConversation.dialogue.txt" ; B19616
      dialogueChapterPrologueLexAzelleSpawn .include "text/dialogue/ChapterPrologue/LexAzelleSpawn.dialogue.txt" ; B1978A
      dialogueChapterPrologueEnding1 .include "text/dialogue/ChapterPrologue/Ending1.dialogue.txt" ; B1998E
      dialogueChapterPrologueUnusedEnding1Copy .include "text/dialogue/ChapterPrologue/UnusedEnding1Copy.dialogue.txt" ; B19A5C

      dialogueChapterPrologueSigurdHomeCastle .include "text/dialogue/ChapterPrologue/SigurdHomeCastle.dialogue.txt" ; B19B2A
      dialogueChapterPrologueVillage1 .include "text/dialogue/ChapterPrologue/Village1.dialogue.txt" ; B19B9B
      dialogueChapterPrologueVillage2 .include "text/dialogue/ChapterPrologue/Village2.dialogue.txt" ; B19C32
      dialogueChapterPrologueVillage4 .include "text/dialogue/ChapterPrologue/Village4.dialogue.txt" ; B19CED
      dialogueChapterPrologueVillage3 .include "text/dialogue/ChapterPrologue/Village3.dialogue.txt" ; B19D8D
      dialogueChapterPrologueVillageSpeedRing .include "text/dialogue/ChapterPrologue/VillageSpeedRing.dialogue.txt" ; B19E87
      dialogueChapterPrologueArvisSpawn .include "text/dialogue/ChapterPrologue/ArvisSpawn.dialogue.txt" ; B19F26
      dialogueChapterPrologueArvisSigurdTalkAzelleAlive .include "text/dialogue/ChapterPrologue/ArvisSigurdTalkAzelleAlive.dialogue.txt" ; B19F88
      dialogueChapterPrologueArvisSigurdTalkAzelleDead .include "text/dialogue/ChapterPrologue/ArvisSigurdTalkAzelleDead.dialogue.txt" ; B1A1F1

      .dsection ChapterFinalEventsSection
      .dsection ChapterFinalEventDataSection

      dialogueChapter07Opening1 .include "text/dialogue/Chapter07/Opening1.dialogue.txt" ; B1AC01
      dialogueChapter07Opening2 .include "text/dialogue/Chapter07/Opening2.dialogue.txt" ; B1AE96
      dialogueChapter07Opening3 .include "text/dialogue/Chapter07/Opening3.dialogue.txt" ; B1AF75
      dialogueChapter07Opening4 .include "text/dialogue/Chapter07/Opening4.dialogue.txt" ; B1AFD0
      dialogueChapter07Opening5 .include "text/dialogue/Chapter07/Opening5.dialogue.txt" ; B1B061
      dialogueChapter07Opening6 .include "text/dialogue/Chapter07/Opening6.dialogue.txt" ; B1B18D
      dialogueChapter07BramselWaiting1 .include "text/dialogue/Chapter07/BramselWaiting1.dialogue.txt" ; B1B302
      dialogueChapter07BramselWaiting2 .include "text/dialogue/Chapter07/BramselWaiting2.dialogue.txt" ; B1B400
      dialogueChapter07AedSeized .include "text/dialogue/Chapter07/AedSeized.dialogue.txt" ; B1B609
      dialogueChapter07MelgenSpawn1 .include "text/dialogue/Chapter07/MelgenSpawn1.dialogue.txt" ; B1B7DE
      dialogueChapter07AresThreatensBramsel .include "text/dialogue/Chapter07/AresThreatensBramsel.dialogue.txt" ; B1B8C7
      dialogueChapter07MelgenSpawn2 .include "text/dialogue/Chapter07/MelgenSpawn2.dialogue.txt" ; B1BB67
      dialogueChapter07MelgenSeized .include "text/dialogue/Chapter07/MelgenSeized.dialogue.txt" ; B1BD20
      dialogueChapter07UlsterSpawn1 .include "text/dialogue/Chapter07/UlsterSpawn1.dialogue.txt" ; B1BEA3
      dialogueChapter07UlsterSpawn2 .include "text/dialogue/Chapter07/UlsterSpawn2.dialogue.txt" ; B1BF42
      dialogueChapter07UlsterSpawn3 .include "text/dialogue/Chapter07/UlsterSpawn3.dialogue.txt" ; B1C02F
      dialogueChapter07UlsterSpawn4 .include "text/dialogue/Chapter07/UlsterSpawn4.dialogue.txt" ; B1C058
      dialogueChapter07BloomCharge .include "text/dialogue/Chapter07/BloomCharge.dialogue.txt" ; B1C1FF
      dialogueChapter07AresRecruitment1 .include "text/dialogue/Chapter07/AresRecruitment1.dialogue.txt" ; B1C22C
      dialogueChapter07AresRecruitment2 .include "text/dialogue/Chapter07/AresRecruitment2.dialogue.txt" ; B1C321
      dialogueChapter07BanbaDialogue .include "text/dialogue/Chapter07/BanbaDialogue.dialogue.txt" ; B1C4F2
      dialogueChapter07TineLinda_Dialogue .include "text/dialogue/Chapter07/TineLinda_Dialogue.dialogue.txt" ; B1C557
      dialogueChapter07DahnaSeized1 .include "text/dialogue/Chapter07/DahnaSeized1.dialogue.txt" ; B1C5BF
      dialogueChapter07DahnaSeized2 .include "text/dialogue/Chapter07/DahnaSeized2.dialogue.txt" ; B1C776
      dialogueChapter07AresDahnaVisit .include "text/dialogue/Chapter07/AresDahnaVisit.dialogue.txt" ; B1C7A4
      dialogueChapter07ArthurAmid_TineLindaTalk .include "text/dialogue/Chapter07/ArthurAmid_TineLindaTalk.dialogue.txt" ; B1C8CB
      dialogueChapter07LeonsterSeized .include "text/dialogue/Chapter07/LeonsterSeized.dialogue.txt" ; B1CB51
      dialogueChapter07Ending .include "text/dialogue/Chapter07/Ending.dialogue.txt" ; B1CB9A
      dialogueChapter07KutuzovFenrirFound .include "text/dialogue/Chapter07/KutuzovFenrirFound.dialogue.txt" ; B1CCFF
      dialogueChapter07BanbaTriangleAttack .include "text/dialogue/Chapter07/BanbaTriangleAttack.dialogue.txt" ; B1CD7C

      .word $02C5

      dialogueChapter07FotlaTriangleAttack .include "text/dialogue/Chapter07/FotlaTriangleAttack.dialogue.txt" ; B1CDA8
      dialogueChapter07EriuTriangleAttack .include "text/dialogue/Chapter07/EriuTriangleAttack.dialogue.txt" ; B1CDD0
      dialogueChapter07VillageSpeedRing .include "text/dialogue/Chapter07/VillageSpeedRing.dialogue.txt" ; B1CDF9
      dialogueChapter07VillageBarrierBladeAnyone .include "text/dialogue/Chapter07/VillageBarrierBladeAnyone.dialogue.txt" ; B1CE7C
      dialogueChapter07Village1 .include "text/dialogue/Chapter07/Village1.dialogue.txt" ; B1CEBB
      dialogueChapter07Village2 .include "text/dialogue/Chapter07/Village2.dialogue.txt" ; B1CF4C
      dialogueChapter07Village3 .include "text/dialogue/Chapter07/Village3.dialogue.txt" ; B1CFFB
      dialogueChapter07VillageShieldRing .include "text/dialogue/Chapter07/VillageShieldRing.dialogue.txt" ; B1D08A
      dialogueChapter07KutuzovBattleQuote .include "text/dialogue/Chapter07/KutuzovBattleQuote.dialogue.txt" ; B1D216
      dialogueChapter07LizaBattleQuote .include "text/dialogue/Chapter07/LizaBattleQuote.dialogue.txt" ; B1D25B
      dialogueChapter07IshtoreBattleQuoteLizaDead .include "text/dialogue/Chapter07/IshtoreBattleQuoteLizaDead.dialogue.txt" ; B1D2AA
      dialogueChapter07IshtoreBattleQuoteLizaAlive .include "text/dialogue/Chapter07/IshtoreBattleQuoteLizaAlive.dialogue.txt" ; B1D2CC
      dialogueChapter07JavarroBattleQuote .include "text/dialogue/Chapter07/JavarroBattleQuote.dialogue.txt" ; B1D2EB
      dialogueChapter07BramselBattleQuote .include "text/dialogue/Chapter07/BramselBattleQuote.dialogue.txt" ; B1D307
      dialogueChapter07BanbaBattleQuote .include "text/dialogue/Chapter07/BanbaBattleQuote.dialogue.txt" ; B1D342
      dialogueChapter07FotlaBattleQuote .include "text/dialogue/Chapter07/FotlaBattleQuote.dialogue.txt" ; B1D35B
      dialogueChapter07EriuBattleQuote .include "text/dialogue/Chapter07/EriuBattleQuote.dialogue.txt" ; B1D372
      dialogueChapter07TineLinda_BattleQuote .include "text/dialogue/Chapter07/TineLinda_BattleQuote.dialogue.txt" ; B1D38C
      dialogueChapter07BloomBattleQuote .include "text/dialogue/Chapter07/BloomBattleQuote.dialogue.txt" ; B1D3A0

      .include "events/Chapter09/EventChapter09Opening.asm"
      .include "events/Chapter09/EventChapter09AltenaCharge.asm"
      .include "events/Chapter09/EventChapter09HannibalDefend.asm"
      .include "events/Chapter09/EventChapter09CoirpreHostage.asm"
      .include "events/Chapter09/EventChapter09LeifAltenaTalk.asm"
      .include "events/Chapter09/EventChapter09AltenaRespawn.asm"
      .include "events/Chapter09/EventChapter09TravantSpawnAltenaDead.asm"
      .include "events/Chapter09/EventChapter09HannibalCharge.asm"
      .include "events/Chapter09/EventChapter09SeliphAltenaTalk.asm"
      .include "events/Chapter09/EventChapter09HannibalNotRecruited.asm"
      .include "events/Chapter09/EventChapter09LutheciaSeized.asm"
      .include "events/Chapter09/EventChapter09CoirpreCharlot_HannibalTalk.asm"
      .include "events/Chapter09/EventChapter09GrutiaSpawn.asm"
      .include "events/Chapter09/EventChapter09GrutiaSeized.asm"
      .include "events/Chapter09/EventChapter09ThraciaSpawn.asm"
      .include "events/Chapter09/EventChapter09ArionCharge.asm"
      .include "events/Chapter09/EventChapter09ArionDied.asm"
      .include "events/Chapter09/EventChapter09ThraciaSeized.asm"
      .include "events/Chapter09/EventChapter09Village1.asm"
      .include "events/Chapter09/EventChapter09Village2.asm"
      .include "events/Chapter09/EventChapter09Village3.asm"
      .include "events/Chapter09/EventChapter09Village4.asm"
      .include "events/Chapter09/EventChapter09VillageBarrierRing.asm"
      .include "events/Chapter09/EventChapter09Village5.asm"
      .include "events/Chapter09/EventChapter09_161.asm"
      .include "events/Chapter09/EventChapter09CharlotHannibalAdjacent.asm"
      .include "events/Chapter09/EventChapter09Village4Special.asm"
      .include "events/Chapter09/EventChapter09HawkLutheciaVisit.asm"
      .include "events/Chapter09/EventChapter09_168.asm"

      .include "events/ChapterFinal/EventChapterFinalOpening.asm"
      .include "events/ChapterFinal/EventChapterFinalEddaSeized.asm"
      .include "events/ChapterFinal/EventChapterFinalDozelSpawn.asm"
      .include "events/ChapterFinal/EventChapterFinalDozelSeized.asm"
      .include "events/ChapterFinal/EventChapterFinalFriegeSpawn.asm"
      .include "events/ChapterFinal/EventChapterFinalYngviSpawn.asm"
      .include "events/ChapterFinal/EventChapterFinalFriegeSeized.asm"
      .include "events/ChapterFinal/EventChapterFinalBelhallaSpawn.asm"
      .include "events/ChapterFinal/EventChapterFinalThraciaSpawn.asm"
      .include "events/ChapterFinal/EventChapterFinal_197.asm"
      .include "events/ChapterFinal/EventChapterFinalSeliphJuliaTalkManfroyDead.asm"
      .include "events/ChapterFinal/EventChapterFinalAltenaArionTalk.asm"
      .include "events/ChapterFinal/EventChapterFinalVelthomerSeized.asm"
      .include "events/ChapterFinal/EventChapterFinalJuliaVelthomerVisit.asm"
      .include "events/ChapterFinal/EventChapterFinalEnding.asm"
      .include "events/ChapterFinal/EventChapterFinalVillage1.asm"
      .include "events/ChapterFinal/EventChapterFinalVillage2.asm"
      .include "events/ChapterFinal/EventChapterFinalSeliphJuliaTalkManfroyAlive.asm"
      .include "events/ChapterFinal/EventChapterFinalJuliusDied.asm"
      .include "events/ChapterFinal/EventChapterFinal_1A1.asm"
      .include "events/ChapterFinal/EventChapterFinal_1A2.asm"

      .dsection FinalChapterJuliaRecruitmentASMCSection

      dialogueEpilogue_Febail .include "text/dialogue/Epilogue/Febail.dialogue.txt" ; B1E8EF
      dialogueEpilogue_Febail_WithLover .include "text/dialogue/Epilogue/Febail_WithLover.dialogue.txt" ; B1E8F5
      dialogueEpilogue_Piece_Febail .include "text/dialogue/Epilogue/Piece_Febail.dialogue.txt" ; B1E900
      dialogueEpilogue_Patty_FebailDead .include "text/dialogue/Epilogue/Patty_FebailDead.dialogue.txt" ; B1E9E6
      dialogueEpilogue_Patty_FebailAlive .include "text/dialogue/Epilogue/Patty_FebailAlive.dialogue.txt" ; B1EAC3
      dialogueEpilogue_Patty_LoverDead .include "text/dialogue/Epilogue/Patty_LoverDead.dialogue.txt" ; B1EBB3
      dialogueEpilogue_Lester_BrigidsChildrenDead .include "text/dialogue/Epilogue/Lester_BrigidsChildrenDead.dialogue.txt" ; B1EBB9
      dialogueEpilogue_Lester_BrigidsChildrenDead_WithLover .include "text/dialogue/Epilogue/Lester_BrigidsChildrenDead_WithLover.dialogue.txt" ; B1EBBF
      dialogueEpilogue_Lester_BrigidsChildrenAlive .include "text/dialogue/Epilogue/Lester_BrigidsChildrenAlive.dialogue.txt" ; B1EBCA
      dialogueEpilogue_Lester_BrigidsChildrenAlive_WithLover .include "text/dialogue/Epilogue/Lester_BrigidsChildrenAlive_WithLover.dialogue.txt" ; B1EBD0
      dialogueEpilogue_Piece_Lester_BrigidsChildrenDead .include "text/dialogue/Epilogue/Piece_Lester_BrigidsChildrenDead.dialogue.txt" ; B1EBDB
      dialogueEpilogue_Piece_Lester_BrigidsChildrenAlive .include "text/dialogue/Epilogue/Piece_Lester_BrigidsChildrenAlive.dialogue.txt" ; B1ECB7
      dialogueEpilogue_Lana_YngviChildrenDead .include "text/dialogue/Epilogue/Lana_YngviChildrenDead.dialogue.txt" ; B1ED4E
      dialogueEpilogue_Lana_YngviChildrenAlive_LoverDead .include "text/dialogue/Epilogue/Lana_YngviChildrenAlive_LoverDead.dialogue.txt" ; B1EE15
      dialogueEpilogue_Lana_YngviChildrenAlive_LesterDead .include "text/dialogue/Epilogue/Lana_YngviChildrenAlive_LesterDead.dialogue.txt" ; B1EEB6
      dialogueEpilogue_Lana_YngviChildrenAlive_LesterAlive .include "text/dialogue/Epilogue/Lana_YngviChildrenAlive_LesterAlive.dialogue.txt" ; B1EED0
      dialogueEpilogue_Piece_Lana_Start .include "text/dialogue/Epilogue/Piece_Lana_Start.dialogue.txt" ; B1EEF3
      dialogueEpilogue_Piece_Lana_End .include "text/dialogue/Epilogue/Piece_Lana_End.dialogue.txt" ; B1EF23
      dialogueEpilogue_AmidArthur .include "text/dialogue/Epilogue/AmidArthur.dialogue.txt" ; B1EF75
      dialogueEpilogue_AmidArthur_WithLover .include "text/dialogue/Epilogue/AmidArthur_WithLover.dialogue.txt" ; B1EF7B
      dialogueEpilogue_Piece_AmidArthur .include "text/dialogue/Epilogue/Piece_AmidArthur.dialogue.txt" ; B1EF86
      dialogueEpilogue_LindaTine_BrotherDead .include "text/dialogue/Epilogue/LindaTine_BrotherDead.dialogue.txt" ; B1F069
      dialogueEpilogue_LindaTine_BrotherAlive_LoverDead .include "text/dialogue/Epilogue/LindaTine_BrotherAlive_LoverDead.dialogue.txt" ; B1F0FC
      dialogueEpilogue_LindaTine_BrotherAlive .include "text/dialogue/Epilogue/LindaTine_BrotherAlive.dialogue.txt" ; B1F178
      dialogueEpilogue_LexSon .include "text/dialogue/Epilogue/LexSon.dialogue.txt" ; B1F1F0
      dialogueEpilogue_LexSon_WithLover .include "text/dialogue/Epilogue/LexSon_WithLover.dialogue.txt" ; B1F1F6
      dialogueEpilogue_Piece_LexChild .include "text/dialogue/Epilogue/Piece_LexChild.dialogue.txt" ; B1F201
      dialogueEpilogue_LexDaughter_BrotherDead .include "text/dialogue/Epilogue/LexDaughter_BrotherDead.dialogue.txt" ; B1F2FF
      dialogueEpilogue_LexDaughter_BrotherAlive .include "text/dialogue/Epilogue/LexDaughter_BrotherAlive.dialogue.txt" ; B1F305
      dialogueEpilogue_LexDaughter_BrotherAlive_LoverDead .include "text/dialogue/Epilogue/LexDaughter_BrotherAlive_LoverDead.dialogue.txt" ; B1F3A9
      dialogueEpilogue_Iuchar .include "text/dialogue/Epilogue/Iuchar.dialogue.txt" ; B1F45C
      dialogueEpilogue_Iuchar_WithLover .include "text/dialogue/Epilogue/Iuchar_WithLover.dialogue.txt" ; B1F462
      dialogueEpilogue_Piece_Iuchar .include "text/dialogue/Epilogue/Piece_Iuchar.dialogue.txt" ; B1F46D
      dialogueEpilogue_Iucharba .include "text/dialogue/Epilogue/Iucharba.dialogue.txt" ; B1F5CF
      dialogueEpilogue_Iucharba_WithLover .include "text/dialogue/Epilogue/Iucharba_WithLover.dialogue.txt" ; B1F5D5
      dialogueEpilogue_Piece_Iucharba .include "text/dialogue/Epilogue/Piece_Iucharba.dialogue.txt" ; B1F5E0
      dialogueEpilogue_ClaudsSon .include "text/dialogue/Epilogue/ClaudsSon.dialogue.txt" ; B1F6C8
      dialogueEpilogue_ClaudsSon_WithLover .include "text/dialogue/Epilogue/ClaudsSon_WithLover.dialogue.txt" ; B1F6CE
      dialogueEpilogue_Piece_ClaudsChild .include "text/dialogue/Epilogue/Piece_ClaudsChild.dialogue.txt" ; B1F6D9
      dialogueEpilogue_ClaudsDaughter_BrotherDead .include "text/dialogue/Epilogue/ClaudsDaughter_BrotherDead.dialogue.txt" ; B1F775
      dialogueEpilogue_ClaudsDaughter_BrotherAlive .include "text/dialogue/Epilogue/ClaudsDaughter_BrotherAlive.dialogue.txt" ; B1F77B
      dialogueEpilogue_ClaudsDaughter_BrotherAlive_LoverDead .include "text/dialogue/Epilogue/ClaudsDaughter_BrotherAlive_LoverDead.dialogue.txt" ; B1F786
      dialogueEpilogue_Piece_ClaudsDaughter_BrotherAlive .include "text/dialogue/Epilogue/Piece_ClaudsDaughter_BrotherAlive.dialogue.txt" ; B1F7A1
      dialogueEpilogue_Piece_ClaudsDaughter_End .include "text/dialogue/Epilogue/Piece_ClaudsDaughter_End.dialogue.txt" ; B1F7E8
      dialogueEpilogueLover_AzellesSon_Peppy .include "text/dialogue/Epilogue/Lover_AzellesSon_Peppy.dialogue.txt" ; B1F82E
      dialogueEpilogueLover_AzellesSon_CreidneLarcei .include "text/dialogue/Epilogue/Lover_AzellesSon_CreidneLarcei.dialogue.txt" ; B1F89B
      dialogueEpilogueLover_AzellesSon_MuirneLana .include "text/dialogue/Epilogue/Lover_AzellesSon_MuirneLana.dialogue.txt" ; B1F915
      dialogueEpilogueLover_AzellesSon_LindaTine .include "text/dialogue/Epilogue/Lover_AzellesSon_LindaTine.dialogue.txt" ; B1F985
      dialogueEpilogueLover_AzellesSon_JeanneNanna .include "text/dialogue/Epilogue/Lover_AzellesSon_JeanneNanna.dialogue.txt" ; B1F9F1
      dialogueEpilogueLover_Oifey_Peppy .include "text/dialogue/Epilogue/Lover_Oifey_Peppy.dialogue.txt" ; B1FA5E
      dialogueEpilogueLover_Oifey_Noble .include "text/dialogue/Epilogue/Lover_Oifey_Noble.dialogue.txt" ; B1FB1F
      dialogueEpilogueLover_Ced_Peppy .include "text/dialogue/Epilogue/Lover_Ced_Peppy.dialogue.txt" ; B1FBE0
      dialogueEpilogueLover_Ced_Noble .include "text/dialogue/Epilogue/Lover_Ced_Noble.dialogue.txt" ; B1FC4B
      dialogueEpilogueLover_LewynsSon_Peppy .include "text/dialogue/Epilogue/Lover_LewynsSon_Peppy.dialogue.txt" ; B1FCB9
      dialogueEpilogueLover_LewynsSon_Noble .include "text/dialogue/Epilogue/Lover_LewynsSon_Noble.dialogue.txt" ; B1FD2B

      .fill $B18000 + $8000 - *, 0

    .here

    * = $328000
    .logical $B28000

      .dsection Chapter06EventsSection
      .dsection Chapter06EventDataSection

      dialogueChapter01WorldMap1 .include "text/dialogue/Chapter01/WorldMap1.dialogue.txt" ; B284FB
      dialogueChapter01WorldMap2 .include "text/dialogue/Chapter01/WorldMap2.dialogue.txt" ; B28517
      dialogueChapter01WorldMap3 .include "text/dialogue/Chapter01/WorldMap3.dialogue.txt" ; B28543
      dialogueChapter01WorldMap4 .include "text/dialogue/Chapter01/WorldMap4.dialogue.txt" ; B28592
      dialogueChapter01WorldMap5 .include "text/dialogue/Chapter01/WorldMap5.dialogue.txt" ; B28639
      dialogueChapter01WorldMap6 .include "text/dialogue/Chapter01/WorldMap6.dialogue.txt" ; B286E8
      dialogueChapter01WorldMapUnused .include "text/dialogue/Chapter01/WorldMapUnused.dialogue.txt" ; B2876C

      .include "events/Chapter07/EventChapter07Opening.asm"
      .include "events/Chapter07/EventChapter07BramselWaiting.asm"
      .include "events/Chapter07/EventChapter07AedSeized.asm"
      .include "events/Chapter07/EventChapter07MelgenSpawn.asm"
      .include "events/Chapter07/EventChapter07AresThreatensBramsel.asm"
      .include "events/Chapter07/EventChapter07_0FB.asm"
      .include "events/Chapter07/EventChapter07MelgenSeized.asm"
      .include "events/Chapter07/EventChapter07UlsterSpawn.asm"
      .include "events/Chapter07/EventChapter07BloomCharge.asm"
      .include "events/Chapter07/EventChapter07AresRecruitment.asm"
      .include "events/Chapter07/EventChapter07BanbaDialogue.asm"
      .include "events/Chapter07/EventChapter07DahnaSeized.asm"
      .include "events/Chapter07/EventChapter07_102.asm"
      .include "events/Chapter07/EventChapter07Ending.asm"
      .include "events/Chapter07/EventChapter07ArthurAmid_TineLindaTalk.asm"
      .include "events/Chapter07/EventChapter07AresDahnaVisit.asm"
      .include "events/Chapter07/EventChapter07TineLinda_Dialogue.asm"
      .include "events/Chapter07/EventChapter07VillageSpeedRing.asm"
      .include "events/Chapter07/EventChapter07VillageBarrierBladeAnyone.asm"
      .include "events/Chapter07/EventChapter07Village1.asm"
      .include "events/Chapter07/EventChapter07Village2.asm"
      .include "events/Chapter07/EventChapter07Village3.asm"
      .include "events/Chapter07/EventChapter07VillageShieldRing.asm"
      .include "events/Chapter07/EventChapter07_10E.asm"
      .include "events/Chapter07/EventChapter07BanbaDied.asm"
      .include "events/Chapter07/EventChapter07FotlaDied.asm"
      .include "events/Chapter07/EventChapter07EriuDied.asm"
      .include "events/Chapter07/EventChapter07BloomDied.asm"
      .include "events/Chapter07/EventChapter07KutuzovFenrirFound.asm"
      .include "events/Chapter07/EventChapter07LeonsterSeized.asm"
      .include "events/Chapter07/EventChapter07_117.asm"
      .include "events/Chapter07/EventChapter07DahnaArmyTalk.asm"
      .include "events/Chapter07/EventChapter07VillageBarrierBladeLaylea.asm"
      .include "events/Chapter07/EventChapter07DaisyShannanAdjacent.asm"
      .include "events/Chapter07/EventChapter07DalvinTristanAdjacent.asm"

      .dsection EpilogueMovementSection

      dialogueChapterFinalOpening1 .include "text/dialogue/ChapterFinal/Opening1.dialogue.txt" ; B29916
      dialogueChapterFinalOpening2 .include "text/dialogue/ChapterFinal/Opening2.dialogue.txt" ; B29DC3
      dialogueChapterFinalOpening3 .include "text/dialogue/ChapterFinal/Opening3.dialogue.txt" ; B29E1D
      dialogueChapterFinalEddaSeized .include "text/dialogue/ChapterFinal/EddaSeized.dialogue.txt" ; B2A1B4
      dialogueChapterFinalEddaSeizedClaudsChildren .include "text/dialogue/ChapterFinal/EddaSeizedClaudsChildren.dialogue.txt" ; B2A22A
      dialogueChapterFinalEddaSeizedNoInheritor .include "text/dialogue/ChapterFinal/EddaSeizedNoInheritor.dialogue.txt" ; B2A275
      dialogueChapterFinalDozelSpawn .include "text/dialogue/ChapterFinal/DozelSpawn.dialogue.txt" ; B2A2BF
      dialogueChapterFinalDozelSeized .include "text/dialogue/ChapterFinal/DozelSeized.dialogue.txt" ; B2A344
      dialogueChapterFinalFriegeSpawn .include "text/dialogue/ChapterFinal/FriegeSpawn.dialogue.txt" ; B2A872
      dialogueChapterFinalYngviSpawn .include "text/dialogue/ChapterFinal/YngviSpawn.dialogue.txt" ; B2A963
      dialogueChapterFinalFriegeSeized .include "text/dialogue/ChapterFinal/FriegeSeized.dialogue.txt" ; B2A9C5
      dialogueChapterFinalBelhallaSpawn1 .include "text/dialogue/ChapterFinal/BelhallaSpawn1.dialogue.txt" ; B2ADBD
      dialogueChapterFinalThraciaSpawn .include "text/dialogue/ChapterFinal/ThraciaSpawn.dialogue.txt" ; B2B03B
      dialogueChapterFinalBelhallaSpawn2 .include "text/dialogue/ChapterFinal/BelhallaSpawn2.dialogue.txt" ; B2B0BD
      dialogueChapterFinalSeliphJuliaTalkManfroyDead .include "text/dialogue/ChapterFinal/SeliphJuliaTalkManfroyDead.dialogue.txt" ; B2B120
      dialogueChapterFinalAltenaArionTalk .include "text/dialogue/ChapterFinal/AltenaArionTalk.dialogue.txt" ; B2B2D1
      dialogueChapterFinalVelthomerSeized .include "text/dialogue/ChapterFinal/VelthomerSeized.dialogue.txt" ; B2B4AE
      dialogueChapterFinalJuliaVelthomerVisit .include "text/dialogue/ChapterFinal/JuliaVelthomerVisit.dialogue.txt" ; B2B5E6
      dialogueChapterFinalUnusedSeliphLewynTalk .include "text/dialogue/ChapterFinal/UnusedSeliphLewynTalk.dialogue.txt" ; B2B6B6
      dialogueChapterFinalSeliphJuliaTalkManfroyAlive .include "text/dialogue/ChapterFinal/SeliphJuliaTalkManfroyAlive.dialogue.txt" ; B2B6E8
      dialogueChapterFinalJuliusDiedManfroyDeath .include "text/dialogue/ChapterFinal/JuliusDiedManfroyDeath.dialogue.txt" ; B2B78B
      dialogueChapterFinalJuliusDiedJuliaRecruitment .include "text/dialogue/ChapterFinal/JuliusDiedJuliaRecruitment.dialogue.txt" ; B2B7E3
      dialogueChapterFinalRobertoBattleQuote .include "text/dialogue/ChapterFinal/RobertoBattleQuote.dialogue.txt" ; B2B84B
      dialogueChapterFinalBoyceBattleQuote .include "text/dialogue/ChapterFinal/BoyceBattleQuote.dialogue.txt" ; B2B878
      dialogueChapterFinalRodanBattleQuote .include "text/dialogue/ChapterFinal/RodanBattleQuote.dialogue.txt" ; B2B899
      dialogueChapterFinalJuphielBattleQuote .include "text/dialogue/ChapterFinal/JuphielBattleQuote.dialogue.txt" ; B2B8B6
      dialogueChapterFinalFisherBattleQuote .include "text/dialogue/ChapterFinal/FisherBattleQuote.dialogue.txt" ; B2B8E5
      dialogueChapterFinalBrianBattleQuote .include "text/dialogue/ChapterFinal/BrianBattleQuote.dialogue.txt" ; B2B908
      dialogueChapterFinalDagonBattleQuote .include "text/dialogue/ChapterFinal/DagonBattleQuote.dialogue.txt" ; B2B93E
      dialogueChapterFinalHildaBattleQuote .include "text/dialogue/ChapterFinal/HildaBattleQuote.dialogue.txt" ; B2B96D
      dialogueChapterFinalScipioBattleQuote .include "text/dialogue/ChapterFinal/ScipioBattleQuote.dialogue.txt" ; B2B98E
      dialogueChapterFinalBaranBattleQuote .include "text/dialogue/ChapterFinal/BaranBattleQuote.dialogue.txt" ; B2B9B9
      dialogueChapterFinalMengBattleQuote .include "text/dialogue/ChapterFinal/MengBattleQuote.dialogue.txt" ; B2B9E8
      dialogueChapterFinalMabelBattleQuote .include "text/dialogue/ChapterFinal/MabelBattleQuote.dialogue.txt" ; B2BA02
      dialogueChapterFinalBlegBattleQuote .include "text/dialogue/ChapterFinal/BlegBattleQuote.dialogue.txt" ; B2BA1C
      dialogueChapterFinalArionBattleQuote .include "text/dialogue/ChapterFinal/ArionBattleQuote.dialogue.txt" ; B2BA2F
      dialogueChapterFinalIshtarBattleQuote .include "text/dialogue/ChapterFinal/IshtarBattleQuote.dialogue.txt" ; B2BA41
      dialogueChapterFinalManfroyBattleQuote .include "text/dialogue/ChapterFinal/ManfroyBattleQuote.dialogue.txt" ; B2BA83
      dialogueChapterFinalJuliusBattleQuote .include "text/dialogue/ChapterFinal/JuliusBattleQuote.dialogue.txt" ; B2BABF
      dialogueChapterFinalJulia_JuliusBattleQuote .include "text/dialogue/ChapterFinal/Julia_JuliusBattleQuote.dialogue.txt" ; B2BAE9
      dialogueChapterFinalSeliph_JuliusBattleQuote .include "text/dialogue/ChapterFinal/Seliph_JuliusBattleQuote.dialogue.txt" ; B2BB14
      dialogueChapterFinalJuliaBattleQuote .include "text/dialogue/ChapterFinal/JuliaBattleQuote.dialogue.txt" ; B2BB68
      dialogueChapterFinalVillage1 .include "text/dialogue/ChapterFinal/Village1.dialogue.txt" ; B2BB7D
      dialogueChapterFinalVillage2 .include "text/dialogue/ChapterFinal/Village2.dialogue.txt" ; B2BD6F

      dialogueEpilogue_AzellesSon .include "text/dialogue/Epilogue/AzellesSon.dialogue.txt" ; B2BE13
      dialogueEpilogue_AzellesSon_WithLover .include "text/dialogue/Epilogue/AzellesSon_WithLover.dialogue.txt" ; B2BE19
      dialogueEpilogue_Piece_AzellesChild .include "text/dialogue/Epilogue/Piece_AzellesChild.dialogue.txt" ; B2BE24
      dialogueEpilogue_AzellesDaughter_BrotherDead .include "text/dialogue/Epilogue/AzellesDaughter_BrotherDead.dialogue.txt" ; B2BFA5
      dialogueEpilogue_AzellesDaughter_BrotherAlive .include "text/dialogue/Epilogue/AzellesDaughter_BrotherAlive.dialogue.txt" ; B2BFAB
      dialogueEpilogue_AzellesDaughter_BrotherAlive_LoverDead .include "text/dialogue/Epilogue/AzellesDaughter_BrotherAlive_LoverDead.dialogue.txt" ; B2BFFC
      dialogueEpilogue_Piece_AzellesDaughter_BrotherAlive .include "text/dialogue/Epilogue/Piece_AzellesDaughter_BrotherAlive.dialogue.txt" ; B2C07C
      dialogueEpilogue_Oifey .include "text/dialogue/Epilogue/Oifey.dialogue.txt" ; B2C0E0
      dialogueEpilogue_Oifey_WithLover .include "text/dialogue/Epilogue/Oifey_WithLover.dialogue.txt" ; B2C0E6
      dialogueEpilogue_Piece_Oifey .include "text/dialogue/Epilogue/Piece_Oifey.dialogue.txt" ; B2C0F1
      dialogueEpilogue_HawkCed .include "text/dialogue/Epilogue/HawkCed.dialogue.txt" ; B2C3E5
      dialogueEpilogue_HawkCed_WithLover .include "text/dialogue/Epilogue/HawkCed_WithLover.dialogue.txt" ; B2C3EB
      dialogueEpilogue_Piece_HawkCed .include "text/dialogue/Epilogue/Piece_HawkCed.dialogue.txt" ; B2C3F6
      dialogueEpilogue_HerminaFee_LoverDead .include "text/dialogue/Epilogue/HerminaFee_LoverDead.dialogue.txt" ; B2C4CD
      dialogueEpilogue_HerminaFee .include "text/dialogue/Epilogue/HerminaFee.dialogue.txt" ; B2C55F
      dialogueEpilogue_HerminaFee_LoverDead_Start .include "text/dialogue/Epilogue/HerminaFee_LoverDead_Start.dialogue.txt" ; B2C654
      dialogueEpilogue_LewynsSon_SisterDead .include "text/dialogue/Epilogue/LewynsSon_SisterDead.dialogue.txt" ; B2C6B7
      dialogueEpilogue_LewynsSon_SisterDead_WithLover .include "text/dialogue/Epilogue/LewynsSon_SisterDead_WithLover.dialogue.txt" ; B2C769
      dialogueEpilogue_LewynsSon_SisterAlive .include "text/dialogue/Epilogue/LewynsSon_SisterAlive.dialogue.txt" ; B2C90C
      dialogueEpilogue_LewynsSon_SisterAlive_WithLover .include "text/dialogue/Epilogue/LewynsSon_SisterAlive_WithLover.dialogue.txt" ; B2C9EE
      dialogueEpilogue_Piece_LewnysSon_Start2 .include "text/dialogue/Epilogue/Piece_LewnysSon_Start2.dialogue.txt" ; B2CA24
      dialogueEpilogue_Piece_LewnysSon_Start1 .include "text/dialogue/Epilogue/Piece_LewnysSon_Start1.dialogue.txt" ; B2CA64
      dialogueEpilogue_Piece_LewnysSon_NoLover .include "text/dialogue/Epilogue/Piece_LewnysSon_NoLover.dialogue.txt" ; B2CAD2
      dialogueEpilogue_LewynsDaughter_Priority .include "text/dialogue/Epilogue/LewynsDaughter_Priority.dialogue.txt" ; B2CBA1
      dialogueEpilogue_LewynsDaughter_NoPriority .include "text/dialogue/Epilogue/LewynsDaughter_NoPriority.dialogue.txt" ; B2CD8D
      dialogueEpilogue_Piece_LewynsDaughter_NoPriority_End .include "text/dialogue/Epilogue/Piece_LewynsDaughter_NoPriority_End.dialogue.txt" ; B2CE45
      dialogueEpilogue_Ending .include "text/dialogue/Epilogue/Ending.dialogue.txt" ; B2CE76

      aEpiloguePointers .include "data/system/EpiloguePointers.csv.asm"
      aEpilogueRegionEndDialoguePointers .include "data/system/EpilogueRegionEndDialoguePointers.csv.asm"
      .dsection EpilogueDialoguePointersSection

      dialogueChapter03Village4SylvaleSeized .include "text/dialogue/Chapter03/Village4SylvaleSeized.dialogue.txt" ; B2D2AA
      dialogueChapter04VillageSafeguardSilvia1 .include "text/dialogue/Chapter04/VillageSafeguardSilvia1.dialogue.txt" ; B2D2FB
      dialogueChapter04VillageSafeguardSilvia2 .include "text/dialogue/Chapter04/VillageSafeguardSilvia2.dialogue.txt" ; B2D3C4
      dialogueChapter04VillageSafeguardSilvia3 .include "text/dialogue/Chapter04/VillageSafeguardSilvia3.dialogue.txt" ; B2D3D6
      dialogueChapter04VillageSafeguardSilvia4 .include "text/dialogue/Chapter04/VillageSafeguardSilvia4.dialogue.txt" ; B2D3E8
      dialogueChapter04VillageSafeguardSilvia5 .include "text/dialogue/Chapter04/VillageSafeguardSilvia5.dialogue.txt" ; B2D3F9
      dialogueChapter06CreidneIucharAdjacent .include "text/dialogue/Chapter06/CreidneIucharAdjacent.dialogue.txt" ; B2D497
      dialogueChapter06CreidneIucharbaAdjacent .include "text/dialogue/Chapter06/CreidneIucharbaAdjacent.dialogue.txt" ; B2D4B5
      dialogueChapter06Piece_CreidneBrotherAdjacent1 .include "text/dialogue/Chapter06/Piece_CreidneBrotherAdjacent1.dialogue.txt" ; B2D4D3
      dialogueChapter06Piece_CreidneIucharAdjacent .include "text/dialogue/Chapter06/Piece_CreidneIucharAdjacent.dialogue.txt" ; B2D4F7
      dialogueChapter06Piece_CreidneIucharbaAdjacent .include "text/dialogue/Chapter06/Piece_CreidneIucharbaAdjacent.dialogue.txt" ; B2D547
      dialogueChapter06Piece_CreidneBrotherAdjacent3 .include "text/dialogue/Chapter06/Piece_CreidneBrotherAdjacent3.dialogue.txt" ; B2D56F
      dialogueChapter06Village2Seliph .include "text/dialogue/Chapter06/Village2Seliph.dialogue.txt" ; B2D578
      dialogueChapter03DewBragiTower1 .include "text/dialogue/Chapter03/DewBragiTower1.dialogue.txt" ; B2D726
      dialogueChapter03DewBragiTower2 .include "text/dialogue/Chapter03/DewBragiTower2.dialogue.txt" ; B2D766
      dialogueChapter03DewBragiTower3 .include "text/dialogue/Chapter03/DewBragiTower3.dialogue.txt" ; B2D81C
      dialogueChapter02MountainArmorTalk .include "text/dialogue/Chapter02/MountainArmorTalk.dialogue.txt" ; B2D862
      dialogueChapter01CrossknightTalk .include "text/dialogue/Chapter01/CrossknightTalk.dialogue.txt" ; B2D8D3
      dialogueChapter03SylvaleCommanderTalk .include "text/dialogue/Chapter03/SylvaleCommanderTalk.dialogue.txt" ; B2D8D3
      dialogueChapter06SofalaArmyTalk .include "text/dialogue/Chapter06/SofalaArmyTalk.dialogue.txt" ; B2D92F
      dialogueChapter06IsaachArmyTalk .include "text/dialogue/Chapter06/IsaachArmyTalk.dialogue.txt" ; B2D998
      dialogueChapter07DahnaArmyTalk .include "text/dialogue/Chapter07/DahnaArmyTalk.dialogue.txt" ; B2DA08
      dialogueChapter07VillageBarrierBladeLaylea .include "text/dialogue/Chapter07/VillageBarrierBladeLaylea.dialogue.txt" ; B2DA44
      dialogueChapter08LeifNearMountain .include "text/dialogue/Chapter08/LeifNearMountain.dialogue.txt" ; B2DB86
      dialogueChapter05ArdenOnCliff .include "text/dialogue/Chapter05/ArdenOnCliff.dialogue.txt" ; B2DBC9
      dialogueChapter07DaisyShannanAdjacent .include "text/dialogue/Chapter07/DaisyShannanAdjacent.dialogue.txt" ; B2DC78
      dialogueChapter10SeliphAtSea .include "text/dialogue/Chapter10/SeliphAtSea.dialogue.txt" ; B2DDDC
      dialogueChapter08FeeOnMountain .include "text/dialogue/Chapter08/FeeOnMountain.dialogue.txt" ; B2E093
      dialogueChapter04ErinysSilviaAdjacent .include "text/dialogue/Chapter04/ErinysSilviaAdjacent.dialogue.txt" ; B2E187
      dialogueChapter09CharlotHannibalAdjacent .include "text/dialogue/Chapter09/CharlotHannibalAdjacent.dialogue.txt" ; B2E359
      dialogueChapter08MuirneSeliphAdjacent .include "text/dialogue/Chapter08/MuirneSeliphAdjacent.dialogue.txt" ; B2E53C
      dialogueChapter09Village4Special .include "text/dialogue/Chapter09/Village4Special.dialogue.txt" ; B2E7DA
      dialogueChapter08LindaOnTree .include "text/dialogue/Chapter08/LindaOnTree.dialogue.txt" ; B2EA49
      dialogueChapter09HawkLutheciaVisit .include "text/dialogue/Chapter09/HawkLutheciaVisit.dialogue.txt" ; B2EC7F
      dialogueChapter08Village3Asaello .include "text/dialogue/Chapter08/Village3Asaello.dialogue.txt" ; B2ED67
      dialogueChapter06DeimneIsaachVisit .include "text/dialogue/Chapter06/DeimneIsaachVisit.dialogue.txt" ; B2EE5F
      dialogueChapter07DalvinTristanAdjacent1 .include "text/dialogue/Chapter07/DalvinTristanAdjacent1.dialogue.txt" ; B2F174
      dialogueChapter07DalvinTristanAdjacent2 .include "text/dialogue/Chapter07/DalvinTristanAdjacent2.dialogue.txt" ; B2F3FF
      dialogueChapter07DalvinTristanAdjacent3 .include "text/dialogue/Chapter07/DalvinTristanAdjacent3.dialogue.txt" ; B2F40E
      dialogueChapter08AmidOnTree .include "text/dialogue/Chapter08/AmidOnTree.dialogue.txt" ; B2F41E
      dialogueChapter02ArdenPursuitRing .include "text/dialogue/Chapter02/ArdenPursuitRing.dialogue.txt" ; B2F6C3
      dialogueChapter02UnusedTired .include "text/dialogue/Chapter02/UnusedTired.dialogue.txt" ; B2F7BE

      .include "events/ChapterPrologue/EventPrologueEthlynSigurdTalk.asm"
      .include "events/ChapterPrologue/EventPrologueAzelleSigurdTalk.asm"
      .include "events/ChapterPrologue/EventPrologueLexSigurdTalk.asm"
      .include "events/ChapterPrologue/EventPrologueUnusedAlecEthlynTalk.asm"
      .include "events/ChapterPrologue/EventPrologueQuanSigurdTalk.asm"
      .include "events/ChapterPrologue/EventPrologueUnusedMidirAzelleTalk.asm"
      .include "events/ChapterPrologue/EventPrologueUnusedNaoiseAlecTalk.asm"
      .include "events/Chapter01/EventChapter01QuanFinnTalk.asm"
      .include "events/Chapter01/EventChapter01MidirEdainTalk.asm"
      .include "events/Chapter01/EventChapter01SigurdEdainTalk.asm"
      .include "events/Chapter01/EventChapter01AzelleEdainTalk.asm"
      .include "events/Chapter01/EventChapter01EdainEthlynTalk.asm"
      .include "events/Chapter01/EventChapter01DewEdainTalk.asm"
      .include "events/Chapter01/EventChapter01AyraQuanTalk.asm"
      .include "events/Chapter02/EventChapter02DewLachesisTalk.asm"
      .include "events/Chapter02/EventChapter02DeirdreEthlynTalk.asm"
      .include "events/Chapter02/EventChapter02QuanFinnTalk.asm"
      .include "events/Chapter02/EventChapter02SigurdLewynTalk.asm"
      .include "events/Chapter02/EventChapter02BeowulfLachesisTalk.asm"
      .include "events/Chapter02/EventChapter02AlecSilviaTalk.asm"
      .include "events/Chapter02/EventChapter02SilviaSigurdTalk.asm"
      .include "events/Chapter02/EventChapter02ErinysSigurdTalk.asm"

      dialogueEpilogueLover_CharlotCoirpre_HannibalAlive_Peppy .include "text/dialogue/Epilogue/Lover_CharlotCoirpre_HannibalAlive_Peppy.dialogue.txt" ; B2FA8D
      dialogueEpilogueLover_CharlotCoirpre_HannibalAlive_CreidneLarcei .include "text/dialogue/Epilogue/Lover_CharlotCoirpre_HannibalAlive_CreidneLarcei.dialogue.txt" ; B2FB06
      dialogueEpilogueLover_CharlotCoirpre_HannibalAlive_MuirneLana .include "text/dialogue/Epilogue/Lover_CharlotCoirpre_HannibalAlive_MuirneLana.dialogue.txt" ; B2FB7A
      dialogueEpilogueLover_CharlotCoirpre_HannibalAlive_LindaTine .include "text/dialogue/Epilogue/Lover_CharlotCoirpre_HannibalAlive_LindaTine.dialogue.txt" ; B2FBF3
      dialogueEpilogueLover_CharlotCoirpre_HannibalAlive_JeanneNanna .include "text/dialogue/Epilogue/Lover_CharlotCoirpre_HannibalAlive_JeanneNanna.dialogue.txt" ; B2FC69
      dialogueEpilogueLover_Asaello_DaisyDead_Peppy .include "text/dialogue/Epilogue/Lover_Asaello_DaisyDead_Peppy.dialogue.txt" ; B2FCE0
      dialogueEpilogueLover_Asaello_DaisyDead_CreidneLarcei .include "text/dialogue/Epilogue/Lover_Asaello_DaisyDead_CreidneLarcei.dialogue.txt" ; B2FD85
      dialogueEpilogueLover_Asaello_DaisyDead_Noble .include "text/dialogue/Epilogue/Lover_Asaello_DaisyDead_Noble.dialogue.txt" ; B2FE52

      .fill $B28000 + $8000 - *, 0

    .here

    * = $338000
    .logical $B38000

      dialogueChapter09Opening1 .include "text/dialogue/Chapter09/Opening1.dialogue.txt" ; B38000
      dialogueChapter09Opening2 .include "text/dialogue/Chapter09/Opening2.dialogue.txt" ; B38294
      dialogueChapter09Opening3 .include "text/dialogue/Chapter09/Opening3.dialogue.txt" ; B38396
      dialogueChapter09Opening4 .include "text/dialogue/Chapter09/Opening4.dialogue.txt" ; B386C6
      dialogueChapter09Opening5 .include "text/dialogue/Chapter09/Opening5.dialogue.txt" ; B38804
      dialogueChapter09Opening6 .include "text/dialogue/Chapter09/Opening6.dialogue.txt" ; B388CA
      dialogueChapter09Opening6OifeyAlive .include "text/dialogue/Chapter09/Opening6OifeyAlive.dialogue.txt" ; B38A1E
      dialogueChapter09Opening7LeifFinn .include "text/dialogue/Chapter09/Opening7LeifFinn.dialogue.txt" ; B38B6E
      dialogueChapter09AltenaCharge .include "text/dialogue/Chapter09/AltenaCharge.dialogue.txt" ; B38ED5
      dialogueChapter09HannibalDefend .include "text/dialogue/Chapter09/HannibalDefend.dialogue.txt" ; B38F07
      dialogueChapter09CoirpreHostage .include "text/dialogue/Chapter09/CoirpreHostage.dialogue.txt" ; B38FF6
      dialogueChapter09LeifAltenaTalk1 .include "text/dialogue/Chapter09/LeifAltenaTalk1.dialogue.txt" ; B390CE
      dialogueChapter09LeifAltenaTalk2 .include "text/dialogue/Chapter09/LeifAltenaTalk2.dialogue.txt" ; B392F5
      dialogueChapter09AltenaRespawn .include "text/dialogue/Chapter09/AltenaRespawn.dialogue.txt" ; B39744
      dialogueChapter09TravantSpawnAltenaDead .include "text/dialogue/Chapter09/TravantSpawnAltenaDead.dialogue.txt" ; B3999D
      dialogueChapter09HannibalCharge .include "text/dialogue/Chapter09/HannibalCharge.dialogue.txt" ; B39B4B
      dialogueChapter09SeliphAltenaTalk .include "text/dialogue/Chapter09/SeliphAltenaTalk.dialogue.txt" ; B39BA6
      dialogueChapter09HannibalNotRecruited .include "text/dialogue/Chapter09/HannibalNotRecruited.dialogue.txt" ; B39EE2
      dialogueChapter09LutheciaSeized .include "text/dialogue/Chapter09/LutheciaSeized.dialogue.txt" ; B39F67
      dialogueChapter09LutheciaSeizedNoCoirpre .include "text/dialogue/Chapter09/LutheciaSeizedNoCoirpre.dialogue.txt" ; B3A11B
      dialogueChapter09CoirpreCharlot_HannibalTalk .include "text/dialogue/Chapter09/CoirpreCharlot_HannibalTalk.dialogue.txt" ; B3A1E1
      dialogueChapter09UnusedJudahKapathogiaSeizedResponse .include "text/dialogue/Chapter09/UnusedJudahKapathogiaSeizedResponse.dialogue.txt" ; B3A303
      dialogueChapter09UnusedMusarCharge .include "text/dialogue/Chapter09/UnusedMusarCharge.dialogue.txt" ; B3A37C
      dialogueChapter09GrutiaSeized .include "text/dialogue/Chapter09/GrutiaSeized.dialogue.txt" ; B3A406
      dialogueChapter09GrutiaSeizedAltenaRecruited .include "text/dialogue/Chapter09/GrutiaSeizedAltenaRecruited.dialogue.txt" ; B3A4E8
      dialogueChapter09ThraciaSpawn .include "text/dialogue/Chapter09/ThraciaSpawn.dialogue.txt" ; B3A512
      dialogueChapter09ArionCharge .include "text/dialogue/Chapter09/ArionCharge.dialogue.txt" ; B3A591
      dialogueChapter09ArionDied .include "text/dialogue/Chapter09/ArionDied.dialogue.txt" ; B3A5E9
      dialogueChapter09Ending .include "text/dialogue/Chapter09/Ending.dialogue.txt" ; B3A622
      dialogueChapter09AltenaArionBattleQuote .include "text/dialogue/Chapter09/AltenaArionBattleQuote.dialogue.txt" ; B3A779
      dialogueChapter09UnusedAltenaArionDeathQuote .include "text/dialogue/Chapter09/UnusedAltenaArionDeathQuote.dialogue.txt" ; B3A803
      dialogueChapter09Village1 .include "text/dialogue/Chapter09/Village1.dialogue.txt" ; B3A82C
      dialogueChapter09Village2 .include "text/dialogue/Chapter09/Village2.dialogue.txt" ; B3A893
      dialogueChapter09Village3 .include "text/dialogue/Chapter09/Village3.dialogue.txt" ; B3A907
      dialogueChapter09Village4 .include "text/dialogue/Chapter09/Village4.dialogue.txt" ; B3A9A1
      dialogueChapter09VillageBarrierRing .include "text/dialogue/Chapter09/VillageBarrierRing.dialogue.txt" ; B3A9F1
      dialogueChapter09Village5MusarAlive .include "text/dialogue/Chapter09/Village5MusarAlive.dialogue.txt" ; B3AAAE
      dialogueChapter09Village5MusarDead .include "text/dialogue/Chapter09/Village5MusarDead.dialogue.txt" ; B3AB26
      dialogueChapter09AltenaBattleQuote .include "text/dialogue/Chapter09/AltenaBattleQuote.dialogue.txt" ; B3AB56
      dialogueChapter09HannibalBattleQuote .include "text/dialogue/Chapter09/HannibalBattleQuote.dialogue.txt" ; B3AB7A
      dialogueChapter09KanatzBattleQuote .include "text/dialogue/Chapter09/KanatzBattleQuote.dialogue.txt" ; B3ABAE
      dialogueChapter09DistlerBattleQuote .include "text/dialogue/Chapter09/DistlerBattleQuote.dialogue.txt" ; B3ABEE
      dialogueChapter09MusarBattleQuote .include "text/dialogue/Chapter09/MusarBattleQuote.dialogue.txt" ; B3AC14
      dialogueChapter09JudahBattleQuote .include "text/dialogue/Chapter09/JudahBattleQuote.dialogue.txt" ; B3AC45
      dialogueChapter09ArionBattleQuote .include "text/dialogue/Chapter09/ArionBattleQuote.dialogue.txt" ; B3AC94
      dialogueChapter09TravantBattleQuote .include "text/dialogue/Chapter09/TravantBattleQuote.dialogue.txt" ; B3ACCC

      dialogueChapter10Opening1 .include "text/dialogue/Chapter10/Opening1.dialogue.txt" ; B3AD0A
      dialogueChapter10Opening2 .include "text/dialogue/Chapter10/Opening2.dialogue.txt" ; B3B1EB
      dialogueChapter10CivilianRescued1 .include "text/dialogue/Chapter10/CivilianRescued1.dialogue.txt" ; B3B297
      dialogueChapter10CivilianRescued2 .include "text/dialogue/Chapter10/CivilianRescued2.dialogue.txt" ; B3B2BB
      dialogueChapter10CivilianRescued3 .include "text/dialogue/Chapter10/CivilianRescued3.dialogue.txt" ; B3B2DB
      dialogueChapter10CivilianRescued4 .include "text/dialogue/Chapter10/CivilianRescued4.dialogue.txt" ; B3B2FF
      dialogueChapter10CivilianRescued5 .include "text/dialogue/Chapter10/CivilianRescued5.dialogue.txt" ; B3B325
      dialogueChapter10CivilianRescued6 .include "text/dialogue/Chapter10/CivilianRescued6.dialogue.txt" ; B3B348
      dialogueChapter10Opening3 .include "text/dialogue/Chapter10/Opening3.dialogue.txt" ; B3B35F
      dialogueChapter10RiddellLeisurelyCharge .include "text/dialogue/Chapter10/RiddellLeisurelyCharge.dialogue.txt" ; B3B4BB
      dialogueChapter10Opening4 .include "text/dialogue/Chapter10/Opening4.dialogue.txt" ; B3B4EA
      dialogueChapter10Opening5 .include "text/dialogue/Chapter10/Opening5.dialogue.txt" ; B3B5A0
      dialogueChapter10ChronosSeized .include "text/dialogue/Chapter10/ChronosSeized.dialogue.txt" ; B3B6C0
      dialogueChapter10ChronosSeizedBeforeRados .include "text/dialogue/Chapter10/ChronosSeizedBeforeRados.dialogue.txt" ; B3B728
      dialogueChapter10RadosSeized .include "text/dialogue/Chapter10/RadosSeized.dialogue.txt" ; B3B78A
      dialogueChapter10RadosSeizedAfterChronos .include "text/dialogue/Chapter10/RadosSeizedAfterChronos.dialogue.txt" ; B3B859
      dialogueChapter10MiletosSpawn .include "text/dialogue/Chapter10/MiletosSpawn.dialogue.txt" ; B3B8D6
      dialogueChapter10MiletosSeized .include "text/dialogue/Chapter10/MiletosSeized.dialogue.txt" ; B3BFB2
      dialogueChapter10ChalphySpawn1 .include "text/dialogue/Chapter10/ChalphySpawn1.dialogue.txt" ; B3C0AB
      dialogueChapter10ChalphySpawn2 .include "text/dialogue/Chapter10/ChalphySpawn2.dialogue.txt" ; B3C5D9
      dialogueChapter10SeliphPalmarchTalk .include "text/dialogue/Chapter10/SeliphPalmarchTalk.dialogue.txt" ; B3C673
      dialogueChapter10Ending .include "text/dialogue/Chapter10/Ending.dialogue.txt" ; B3C837
      dialogueChapter10SeliphArvisBattleQuote .include "text/dialogue/Chapter10/SeliphArvisBattleQuote.dialogue.txt" ; B3CA04
      dialogueChapter10RiddellBattleQuote .include "text/dialogue/Chapter10/RiddellBattleQuote.dialogue.txt" ; B3CA88
      dialogueChapter10HildaBattleQuote .include "text/dialogue/Chapter10/HildaBattleQuote.dialogue.txt" ; B3CAAE
      dialogueChapter10MorriganBattleQuote .include "text/dialogue/Chapter10/MorriganBattleQuote.dialogue.txt" ; B3CADE
      dialogueChapter10JuliusBattleQuote .include "text/dialogue/Chapter10/JuliusBattleQuote.dialogue.txt" ; B3CB05
      dialogueChapter10IshtarBattleQuote .include "text/dialogue/Chapter10/IshtarBattleQuote.dialogue.txt" ; B3CB28
      dialogueChapter10IshtarDied .include "text/dialogue/Chapter10/IshtarDied.dialogue.txt" ; B3CB49
      dialogueChapter10IshtarKilledUnit .include "text/dialogue/Chapter10/IshtarKilledUnit.dialogue.txt" ; B3CB70
      dialogueChapter10JuliusKilledUnit .include "text/dialogue/Chapter10/JuliusKilledUnit.dialogue.txt" ; B3CBB1
      dialogueChapter10MiletosSeizedJuliusLeave .include "text/dialogue/Chapter10/MiletosSeizedJuliusLeave.dialogue.txt" ; B3CBED
      dialogueChapter10ZagamBattleQuote .include "text/dialogue/Chapter10/ZagamBattleQuote.dialogue.txt" ; B3CC23
      dialogueChapter10ArvisBattleQuote .include "text/dialogue/Chapter10/ArvisBattleQuote.dialogue.txt" ; B3CC48
      dialogueChapter10Village1 .include "text/dialogue/Chapter10/Village1.dialogue.txt" ; B3CC76
      dialogueChapter10Village2 .include "text/dialogue/Chapter10/Village2.dialogue.txt" ; B3CCD1
      dialogueChapter10VillageMagicRing .include "text/dialogue/Chapter10/VillageMagicRing.dialogue.txt" ; B3CD54
      dialogueChapter10Village3 .include "text/dialogue/Chapter10/Village3.dialogue.txt" ; B3CDE6
      dialogueChapter10Village4 .include "text/dialogue/Chapter10/Village4.dialogue.txt" ; B3CEAF
      dialogueChapter10Village5 .include "text/dialogue/Chapter10/Village5.dialogue.txt" ; B3CF42

      dialogueEpilogue_Belhalla .include "text/dialogue/Epilogue/Belhalla.dialogue.txt" ; B3CF9D
      dialogueEpilogue_Isaach .include "text/dialogue/Epilogue/Isaach.dialogue.txt" ; B3CFA8
      dialogueEpilogue_NewThracia .include "text/dialogue/Epilogue/NewThracia.dialogue.txt" ; B3CFB3
      dialogueEpilogue_Agustria .include "text/dialogue/Epilogue/Agustria.dialogue.txt" ; B3CFBE
      dialogueEpilogue_Verdane .include "text/dialogue/Epilogue/Verdane.dialogue.txt" ; B3CFC9
      dialogueEpilogue_Yngvi .include "text/dialogue/Epilogue/Yngvi.dialogue.txt" ; B3CFD4
      dialogueEpilogue_Friege .include "text/dialogue/Epilogue/Friege.dialogue.txt" ; B3CFDF
      dialogueEpilogue_Dozel .include "text/dialogue/Epilogue/Dozel.dialogue.txt" ; B3CFEA
      dialogueEpilogue_Edda .include "text/dialogue/Epilogue/Edda.dialogue.txt" ; B3CFF5
      dialogueEpilogue_Velthomer .include "text/dialogue/Epilogue/Velthomer.dialogue.txt" ; B3D000
      dialogueEpilogue_Chalphy .include "text/dialogue/Epilogue/Chalphy.dialogue.txt" ; B3D00B
      dialogueEpilogue_Silesse .include "text/dialogue/Epilogue/Silesse.dialogue.txt" ; B3D016

      dialogueChapter07LeneLaylea_SeliphTalk .include "text/dialogue/Chapter07/LeneLaylea_SeliphTalk.dialogue.txt" ; B3D021
      dialogueChapter07FinnNannaTalk .include "text/dialogue/Chapter07/FinnNannaTalk.dialogue.txt" ; B3D0CB
      dialogueChapter07FinnLanaTalk .include "text/dialogue/Chapter07/FinnLanaTalk.dialogue.txt" ; B3D1F5
      dialogueChapter07FinnLarceiTalk .include "text/dialogue/Chapter07/FinnLarceiTalk.dialogue.txt" ; B3D385

      dialogueChapter08FebailAsaello_SeliphTalk .include "text/dialogue/Chapter08/FebailAsaello_SeliphTalk.dialogue.txt" ; B3D507
      dialogueChapter08HerminaHawkTalk .include "text/dialogue/Chapter08/HerminaHawkTalk.dialogue.txt" ; B3D5E1
      dialogueChapter08FeeCedTalk .include "text/dialogue/Chapter08/FeeCedTalk.dialogue.txt" ; B3D79A
      dialogueChapter08NannaAresTalk .include "text/dialogue/Chapter08/NannaAresTalk.dialogue.txt" ; B3D982
      dialogueChapter08CedSeliphTalk .include "text/dialogue/Chapter08/CedSeliphTalk.dialogue.txt" ; B3DCCE
      dialogueChapter08Seliph_TineLindaTalk .include "text/dialogue/Chapter08/Seliph_TineLindaTalk.dialogue.txt" ; B3DF3B
      dialogueChapter08JuliaSeliphTalk .include "text/dialogue/Chapter08/JuliaSeliphTalk.dialogue.txt" ; B3E0B4
      dialogueChapter08ArthurAmid_FeeHerminaTalk .include "text/dialogue/Chapter08/ArthurAmid_FeeHerminaTalk.dialogue.txt" ; B3E1B7
      dialogueChapter08FinnLeifTalk .include "text/dialogue/Chapter08/FinnLeifTalk.dialogue.txt" ; B3E2C1

      dialogueChapter09FebailPattyTalk .include "text/dialogue/Chapter09/FebailPattyTalk.dialogue.txt" ; B3E4F6
      
      dialogueEpilogueLover_Asaello_DaisyAlive_Peppy .include "text/dialogue/Epilogue/Lover_Asaello_DaisyAlive_Peppy.dialogue.txt" ; B3E7BA
      dialogueEpilogueLover_Asaello_DaisyAlive_CreidneLarcei .include "text/dialogue/Epilogue/Lover_Asaello_DaisyAlive_CreidneLarcei.dialogue.txt" ; B3E86B
      dialogueEpilogueLover_Asaello_DaisyAlive_MuirneLana .include "text/dialogue/Epilogue/Lover_Asaello_DaisyAlive_MuirneLana.dialogue.txt" ; B3EA1B
      dialogueEpilogueLover_Asaello_DaisyAlive_LindaTine .include "text/dialogue/Epilogue/Lover_Asaello_DaisyAlive_LindaTine.dialogue.txt" ; B3EAA4
      dialogueEpilogueLover_Asaello_DaisyAlive_JeanneNanna .include "text/dialogue/Epilogue/Lover_Asaello_DaisyAlive_JeanneNanna.dialogue.txt" ; B3EB37
      dialogueEpilogueLover_Ares_Peppy .include "text/dialogue/Epilogue/Lover_Ares_Peppy.dialogue.txt" ; B3EBD1
      dialogueEpilogueLover_Ares_CreidneLarcei .include "text/dialogue/Epilogue/Lover_Ares_CreidneLarcei.dialogue.txt" ; B3EC75
      dialogueEpilogueLover_Ares_Noble .include "text/dialogue/Epilogue/Lover_Ares_Noble.dialogue.txt" ; B3ED26

      aEpilogueLoverGroups .binclude "data/system/EpilogueLoverGroups.csv.asm"
      aEpilogueLoverPointersPeppy .binclude "data/system/EpilogueLoverPointersPeppy.csv.asm" ; Daisy, Patty, Hermina, Fee, Laylea, Lene
      aEpilogueLoverPointersCreidneLarcei .binclude "data/system/EpilogueLoverPointersCreidneLarcei.csv.asm"
      aEpilogueLoverPointersMuirneLana .binclude "data/system/EpilogueLoverPointersMuirneLana.csv.asm"
      aEpilogueLoverPointersLindaTine .binclude "data/system/EpilogueLoverPointersLindaTine.csv.asm"
      aEpilogueLoverPointersJeanneNanna .binclude "data/system/EpilogueLoverPointersJeanneNanna.csv.asm"

      .fill $B38000 + $8000 - *, 0

    .here

    ; The map movement sprites: generated from gfx/MapMovementSprites/sprites.streams by build.sh.
    .include "gfx/MapMovementSprites/Layout.asm"

    * = $348000
    .logical $B48000

      .dsection BackgroundPalettesB48000Section

    .here

    ; Compressed streams: generated from gfx/compressed/B48720/B48720.streams by build.sh.
    .include "gfx/compressed/B48720/Layout.asm"

    * = $377C00
    .logical $F77C00

      .dsection SoundDataSection

    .here

    ; The rest of the last bank is free.
    .fill $400000 - *, 0
