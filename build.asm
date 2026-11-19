
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
  .include "engine/dialogue/dialogue_procs.asm"
  .include "engine/events/cutscenes.asm"
  .include "engine/events/event_movement.asm"
  .include "engine/events/talk_events.asm"
  .include "engine/map/input.asm"
  .include "engine/map/map_sprites.asm"
  .include "engine/map/popups.asm"
  .include "engine/map/windows.asm"
  .include "engine/menus/map_menu.asm"
  .include "engine/menus/menu_text.asm"
  .include "engine/rankings/rankings.asm"
  .include "engine/sound/music.asm"
  .include "engine/units/turn_start.asm"
  .include "engine/unsorted/bank80.asm"
  .include "engine/unsorted/bank81.asm"
  .include "engine/unsorted/bank82.asm"
  .include "engine/unsorted/bank84.asm"
  .include "engine/unsorted/bank85.asm"
  .include "engine/unsorted/bank86.asm"
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

    * = $008002
    .logical $808002

      .dsection Unsorted808002Section

    .here

    * = $00807C
    .logical $80807C

      .dsection DMAPaletteAndOAMBufferSection

    .here

    * = $0080C3
    .logical $8080C3

      .dsection Unsorted8080C3Section

    .here

    * = $0081A8
    .logical $8081A8

      .dsection Unsorted8081A8Section

    .here

    * = $0081B6
    .logical $8081B6

      .dsection Unsorted8081B6Section

    .here

    * = $0081FD
    .logical $8081FD

      .dsection Unsorted8081FDSection

    .here

    * = $008223
    .logical $808223

      .dsection VBlankControlSection

      ; 80/823F

    .here

    * = $00823F
    .logical $80823F

      .dsection Unsorted80823FSection

    .here

    * = $008248
    .logical $808248

      .dsection EnableForcedBlankSection

    .here

    * = $00825B
    .logical $80825B

      .dsection Unsorted80825BSection

    .here

    * = $00826E
    .logical $80826E

      .dsection HideSpritesSection

    .here

    * = $0083C7
    .logical $8083C7

      .dsection OAMUpperXBitTableSection

    .here

    * = $008875
    .logical $808875

      .dsection Unsorted808875Section

    .here

    * = $00889D
    .logical $80889D

      .dsection Unsorted80889DSection

    .here

    * = $0089F1
    .logical $8089F1

      .dsection Table8089F1Section

    .here

    * = $008A01
    .logical $808A01

      .dsection Unsorted808A01Section

    .here

    * = $008A25
    .logical $808A25

      .dsection Table808A25Section

    .here

    * = $008A35
    .logical $808A35

      .dsection Unsorted808A35Section

    .here

    * = $008A6C
    .logical $808A6C

      .dsection Unsorted808A6CSection

    .here

    * = $008B48
    .logical $808B48

      .dsection Unsorted808B48Section

    .here

    * = $008C50
    .logical $808C50

      .dsection Unsorted808C50Section

    .here

    * = $008D56
    .logical $808D56

      .dsection Unsorted808D56Section

    .here

    * = $008D6C
    .logical $808D6C

      .dsection Unsorted808D6CSection

    .here

    * = $008E2D
    .logical $808E2D

      .dsection Unsorted808E2DSection

    .here

    * = $008FA3
    .logical $808FA3

      .dsection Unsorted808FA3Section

    .here

    * = $008FDD
    .logical $808FDD

      .dsection Unsorted808FDDSection

    .here

    * = $00903D
    .logical $80903D

      .dsection Unsorted80903DSection

    .here

    * = $0090A2
    .logical $8090A2

      .dsection Unsorted8090A2Section

    .here

    * = $009124
    .logical $809124

      .dsection Unsorted809124Section

    .here

    * = $009382
    .logical $809382

      .dsection Unsorted809382Section

    .here

    * = $0093B0
    .logical $8093B0

      .dsection Unsorted8093B0Section

    .here

    * = $0093C6
    .logical $8093C6

      .dsection Unsorted8093C6Section

    .here

    * = $0094E2
    .logical $8094E2

      .dsection Unsorted8094E2Section

    .here

    * = $0095CD
    .logical $8095CD

      .dsection Unsorted8095CDSection

    .here

    * = $009654
    .logical $809654

      .dsection Unsorted809654Section

    .here

    * = $009733
    .logical $809733

      .dsection Unsorted809733Section

    .here

    * = $0097E0
    .logical $8097E0

      .dsection Unsorted8097E0Section

    .here

    * = $009846
    .logical $809846

      .dsection Unsorted809846Section

    .here

    * = $009903
    .logical $809903

      .dsection Unsorted809903Section

    .here

    * = $009933
    .logical $809933

      .dsection Unsorted809933Section

    .here

    * = $009B00
    .logical $809B00

      .dsection Unsorted809B00Section

    .here

    * = $009B01
    .logical $809B01

      .dsection Unsorted809B01Section

    .here

    * = $009BEE
    .logical $809BEE

      .dsection Unsorted809BEESection

    .here

    * = $009C7A
    .logical $809C7A

      .dsection Unsorted809C7ASection

    .here

    * = $009CA0
    .logical $809CA0

      .dsection Unsorted809CA0Section

    .here

    * = $009D4F
    .logical $809D4F

      .dsection HardwareResetSection

      ; 80/9DD9

    .here

    * = $009ED9
    .logical $809ED9

      .dsection FillBG2Page0TilemapBufferSection

    .here

    * = $00A096
    .logical $80A096

      .dsection MathSection

      ; 80/A1AB

    .here

    * = $00A1AB
    .logical $80A1AB

      .dsection Unsorted80A1ABSection

    .here

    * = $00A21C
    .logical $80A21C

      .dsection FadeInByTimerSection

    .here

    * = $00A29A
    .logical $80A29A

      .dsection Unsorted80A29ASection

    .here

    * = $00A34F
    .logical $80A34F

      .dsection DMAEngineSection

      ; 80/A5D9

    .here

    * = $00A5D9
    .logical $80A5D9

      .dsection Unsorted80A5D9Section

    .here

    * = $00A5E9
    .logical $80A5E9

      .dsection DecompressionListSection

      ; 80/A678

    .here

    * = $00A6C3
    .logical $80A6C3

      .dsection FrameSection

      .dsection RandomNumberSection

      ; 80/A773

    .here

    * = $00A773
    .logical $80A773

      .dsection Unknown80A773Section

    .here

    * = $00A836
    .logical $80A836

      .dsection Unsorted80A836Section

    .here

    * = $00A859
    .logical $80A859

      .dsection Table80A859Section
      .dsection Table80A85DSection

    .here

    * = $00A861
    .logical $80A861

      .dsection Unsorted80A861Section

    .here

    * = $00A899
    .logical $80A899

      .dsection RandomChanceSection

      .dsection BlockCopySection

      ; 80/A9F2

    .here

    * = $00A9F2
    .logical $80A9F2

      .dsection Unsorted80A9F2Section

    .here

    * = $00AA02
    .logical $80AA02

      .dsection DecompressorSection

      ; 80/AD24

    .here

    * = $00AD24
    .logical $80AD24

      .dsection Unsorted80AD24Section

    .here

    * = $00AE25
    .logical $80AE25

      .dsection Unsorted80AE25Section

    .here

    * = $00AF9B
    .logical $80AF9B

      .dsection Unsorted80AF9BSection

    .here

    * = $00B041
    .logical $80B041

      .dsection Unsorted80B041Section

    .here

    * = $00B08C
    .logical $80B08C

      .dsection Unsorted80B08CSection

    .here

    * = $00B0A3
    .logical $80B0A3

      .dsection Unsorted80B0A3Section

    .here

    * = $00B0D3
    .logical $80B0D3

      .dsection Unsorted80B0D3Section

    .here

    * = $00B105
    .logical $80B105

      .dsection Unsorted80B105Section

    .here

    * = $00B122
    .logical $80B122

      .dsection Unsorted80B122Section

    .here

    * = $00B1E1
    .logical $80B1E1

      .dsection Unsorted80B1E1Section

    .here

    * = $00B347
    .logical $80B347

      .dsection Unsorted80B347Section

    .here

    * = $00B63F
    .logical $80B63F

      .dsection Unsorted80B63FSection

    .here

    * = $00B641
    .logical $80B641

      .dsection Unsorted80B641Section

    .here

    * = $00B6B6
    .logical $80B6B6

      .dsection Unsorted80B6B6Section

    .here

    * = $00B74B
    .logical $80B74B

      .dsection Unsorted80B74BSection

    .here

    * = $00B77F
    .logical $80B77F

      .dsection Unsorted80B77FSection

    .here

    * = $00B793
    .logical $80B793

      .dsection Unsorted80B793Section

    .here

    * = $00B81B
    .logical $80B81B

      .dsection Unsorted80B81BSection

    .here

    * = $00B9AD
    .logical $80B9AD

      .dsection Unsorted80B9ADSection

    .here

    * = $00B9BC
    .logical $80B9BC

      .dsection Unsorted80B9BCSection

    .here

    * = $00B9E1
    .logical $80B9E1

      .dsection Unsorted80B9E1Section

    .here

    * = $00BA02
    .logical $80BA02

      .dsection Unsorted80BA02Section

    .here

    * = $00BA52
    .logical $80BA52

      .dsection Unsorted80BA52Section

    .here

    * = $00BB5D
    .logical $80BB5D

      .dsection Unsorted80BB5DSection

    .here

    * = $00BB7C
    .logical $80BB7C

      .dsection Unsorted80BB7CSection

    .here

    * = $00BB9B
    .logical $80BB9B

      .dsection Unsorted80BB9BSection

    .here

    * = $00BF01
    .logical $80BF01

      .dsection Unsorted80BF01Section

    .here

    * = $00C1A0
    .logical $80C1A0

      .dsection Unsorted80C1A0Section

    .here

    * = $00C1CA
    .logical $80C1CA

      .dsection Unsorted80C1CASection

    .here

    * = $00C1CB
    .logical $80C1CB

      .dsection Unsorted80C1CBSection

      ; 80/C212

    .here

    * = $00C212
    .logical $80C212

      .dsection Unsorted80C212Section

    .here

    * = $00C32C
    .logical $80C32C

      .dsection Unsorted80C32CSection

    .here

    * = $00C35D
    .logical $80C35D

      .dsection Unsorted80C35DSection

    .here

    * = $00C39A
    .logical $80C39A

      .dsection Unsorted80C39ASection

    .here

    * = $00C3E6
    .logical $80C3E6

      .dsection Unsorted80C3E6Section

    .here

    * = $00C5C6
    .logical $80C5C6

      .dsection Unsorted80C5C6Section

    .here

    * = $00C628
    .logical $80C628

      .dsection Unsorted80C628Section

    .here

    * = $00C6D8
    .logical $80C6D8

      .dsection Unsorted80C6D8Section

    .here

    * = $00C723
    .logical $80C723

      .dsection Unsorted80C723Section

    .here

    * = $00C76D
    .logical $80C76D

      .dsection Unsorted80C76DSection

    .here

    * = $00C897
    .logical $80C897

      .dsection Unsorted80C897Section

    .here

    * = $00C8D5
    .logical $80C8D5

      .dsection Unsorted80C8D5Section

    .here

    * = $00CBA5
    .logical $80CBA5

      .dsection Unsorted80CBA5Section

    .here

    * = $00CC35
    .logical $80CC35

      .dsection Unsorted80CC35Section

    .here

    * = $00CD2E
    .logical $80CD2E

      .dsection Unsorted80CD2ESection

    .here

    * = $00CE9E
    .logical $80CE9E

      .dsection Unsorted80CE9ESection

    .here

    * = $00D089
    .logical $80D089

      .dsection Unsorted80D089Section

    .here

    * = $00D0B1
    .logical $80D0B1

      .dsection Unsorted80D0B1Section

    .here

    * = $00D0B4
    .logical $80D0B4

      .dsection Unsorted80D0B4Section

    .here

    * = $00D143
    .logical $80D143

      .dsection Unsorted80D143Section

    .here

    * = $00D2C6
    .logical $80D2C6

      .dsection Unsorted80D2C6Section

    .here

    * = $00D435
    .logical $80D435

      .dsection Unsorted80D435Section

    .here

    * = $00D818
    .logical $80D818

      .dsection Unsorted80D818Section

    .here

    * = $00D90C
    .logical $80D90C

      .dsection DataWindowOpenSection

    .here







    * = $00E42B
    .logical $80E42B

      .dsection Unsorted80E42BSection

      ; 80/E586

    .here

    * = $00E598
    .logical $80E598

      .dsection Unsorted80E598Section

    .here

    * = $00E746
    .logical $80E746

      .dsection Unsorted80E746Section

    .here

    * = $00E8F0
    .logical $80E8F0

      .dsection Unsorted80E8F0Section

    .here

    * = $00E979
    .logical $80E979

      .dsection Unsorted80E979Section

    .here

    * = $00E97C
    .logical $80E97C

      .dsection Unsorted80E97CSection

    .here

    * = $00E9AF
    .logical $80E9AF

      .dsection Unsorted80E9AFSection

    .here

    * = $00E9B2
    .logical $80E9B2

      .dsection Unsorted80E9B2Section

    .here

    * = $00EE37
    .logical $80EE37

      .dsection Unsorted80EE37Section

    .here

    * = $00EFD8
    .logical $80EFD8

      .dsection Unsorted80EFD8Section

    .here

    * = $00F1A7
    .logical $80F1A7

      .dsection Unsorted80F1A7Section

    .here

    * = $00F222
    .logical $80F222

      .dsection Unsorted80F222Section

    .here

    * = $00F2BE
    .logical $80F2BE

      .dsection Unsorted80F2BESection

    .here

    * = $00F340
    .logical $80F340

      .dsection Unsorted80F340Section

    .here

    * = $00F377
    .logical $80F377

      .dsection Unsorted80F377Section

    .here

    * = $00F38A
    .logical $80F38A

      .dsection Unsorted80F38ASection

    .here

    * = $00F392
    .logical $80F392

      .dsection Unsorted80F392Section

    .here

    * = $00F443
    .logical $80F443

      .dsection Unsorted80F443Section

    .here

    * = $00F4EB
    .logical $80F4EB

      .dsection Unsorted80F4EBSection

    .here

    * = $00F542
    .logical $80F542

      .dsection Unsorted80F542Section

    .here

    * = $018000
    .logical $818000

      .dsection ActiveSpriteEngineSection

      ; 8188b0

    .here

    * = $0188B0
    .logical $8188B0

      .dsection MapSpriteSection

    .here

    * = $0189E0
    .logical $8189E0

      .dsection MapSpriteCodeSection

    .here

    * = $0189F3
    .logical $8189F3

      .dsection Unsorted8189F3Section

    .here

    * = $018A4A
    .logical $818A4A

      .dsection Unsorted818A4ASection

    .here

    * = $018C5D
    .logical $818C5D

      .dsection Unsorted818C5DSection

    .here

    * = $018C98
    .logical $818C98

      .dsection Unsorted818C98Section

    .here

    * = $018D23
    .logical $818D23

      .dsection Unsorted818D23Section

    .here

    * = $018D58
    .logical $818D58

      .dsection Unsorted818D58Section
      .dsection MovingMapSpritePositionRoutinesSection

    .here

    * = $018EAB
    .logical $818EAB

      .dsection Unsorted818EABSection

    .here

    * = $018ECB
    .logical $818ECB

      .dsection MapScrollScriptSection

      ; 81/8FA1

    .here

    * = $018FA1
    .logical $818FA1

      .dsection Unknown818FA1Section

    .here

    * = $019031
    .logical $819031

      .dsection CapSpawnDestinationCoordinates100Section

    .here

    * = $019092
    .logical $819092

      .dsection FillMovingMapSpriteDataSection

    .here

    * = $0190BF
    .logical $8190BF

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

    .here

    * = $01A85C
    .logical $81A85C

      .dsection Unsorted81A85CSection

    .here

    * = $01A89D
    .logical $81A89D

      .dsection Unsorted81A89DSection

    .here

    * = $01AA00
    .logical $81AA00

      .dsection GetActiveFactionSongIDSection

    .here

    * = $01AA4D
    .logical $81AA4D

      .dsection PlayerPhaseChapterSongIDsSection

    .here

    * = $01AB90
    .logical $81AB90

      .dsection Unknown81AB90Section

    .here

    * = $01AC02
    .logical $81AC02

      .dsection Unsorted81AC02Section

    .here

    * = $01AD28
    .logical $81AD28

      .dsection Unsorted81AD28Section

    .here

    * = $01AD6A
    .logical $81AD6A

      .dsection Unsorted81AD6ASection

    .here

    * = $01AD8E
    .logical $81AD8E

      .dsection Unsorted81AD8ESection

    .here

    * = $01ADD8
    .logical $81ADD8

      .dsection Unsorted81ADD8Section

    .here

    * = $01AE02
    .logical $81AE02

      .dsection Unsorted81AE02Section

    .here

    * = $01AE96
    .logical $81AE96

      .dsection Unsorted81AE96Section

    .here

    * = $01AEAA
    .logical $81AEAA

      .dsection Unsorted81AEAASection

    .here

    * = $01AFB7
    .logical $81AFB7

      .dsection Unsorted81AFB7Section

    .here

    * = $01AFF8
    .logical $81AFF8

      .dsection Unsorted81AFF8Section

    .here

    * = $01AFFE
    .logical $81AFFE

      .dsection Unsorted81AFFESection

    .here

    * = $01B016
    .logical $81B016

      .dsection Unsorted81B016Section

    .here

    * = $01B088
    .logical $81B088

      .dsection Unsorted81B088Section

    .here

    * = $01B223
    .logical $81B223

      .dsection ASMCShowItemPopUpBoxSection

    .here

    * = $01B259
    .logical $81B259

      .dsection ASMCGiveToSupplyMenuIfInventoryFullSection

    .here

    * = $01B270
    .logical $81B270

      .dsection ASMCGiveItemFromSlot8Section

    .here

    * = $01B2AA
    .logical $81B2AA

      .dsection Unsorted81B2AASection

    .here

    * = $01B301
    .logical $81B301

      .dsection Unsorted81B301Section

    .here

    * = $01B32C
    .logical $81B32C

      .dsection Unsorted81B32CSection

    .here

    * = $01B3A6
    .logical $81B3A6

      .dsection Unsorted81B3A6Section

    .here

    * = $01B43F
    .logical $81B43F

      .dsection Unsorted81B43FSection

    .here

    * = $01B45B
    .logical $81B45B

      .dsection Table81B45BSection

    .here

    * = $01B461
    .logical $81B461

      .dsection Unsorted81B461Section

    .here

    * = $01B47D
    .logical $81B47D

      .dsection Table81B47DSection

    .here

    * = $01B483
    .logical $81B483

      .dsection ChapterDataPointerSection

      ; 81/B4C5

    .here

    * = $01B4C5
    .logical $81B4C5

      .dsection Unsorted81B4C5Section

    .here

    * = $01B4E4
    .logical $81B4E4

      .dsection GetChapterTalkEventsPointerSection

    .here

    * = $01B503
    .logical $81B503

      .dsection Unsorted81B503Section

    .here

    * = $01B52A
    .logical $81B52A

      .dsection Unsorted81B52ASection

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

      ; 82/83B5

    .here

    * = $0283E3
    .logical $8283E3

      .dsection ProcScript8283E3Section

    .here

    * = $0283EB
    .logical $8283EB

      .dsection Unsorted8283EBSection

    .here

    * = $0283FA
    .logical $8283FA

      .dsection Unsorted8283FASection

    .here

    * = $02841F
    .logical $82841F

      .dsection Unsorted82841FSection

    .here

    * = $028429
    .logical $828429

      .dsection ProcScript828429Section

    .here

    * = $028431
    .logical $828431

      .dsection Unsorted828431Section
      .dsection DialogueSection

    .here

    * = $028469
    .logical $828469

      .dsection ProcDialogueInitSection

    .here

    * = $0284EA
    .logical $8284EA

      .dsection ProcDialogueCycle1Section

    .here

    * = $02862E
    .logical $82862E

      .dsection Unknown82862ESection

    .here

    * = $028648
    .logical $828648

      .dsection Unsorted828648Section

    .here

    * = $028653
    .logical $828653

      .dsection Unknown828653Section

    .here

    * = $028694
    .logical $828694

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

    .here

    * = $0288B2
    .logical $8288B2

      .dsection Unsorted8288B2Section

    .here

    * = $0288E7
    .logical $8288E7

      .dsection ProcScript8288E7Section

    .here

    * = $0288F3
    .logical $8288F3

      .dsection Unsorted8288F3Section

    .here

    * = $028906
    .logical $828906

      .dsection DialogueWithBGSection

    .here

    * = $028A30
    .logical $828A30

      .dsection Unsorted828A30Section

      ; 82/8B2B

    .here

    * = $028B2B
    .logical $828B2B

      .dsection Unsorted828B2BSection

    .here

    * = $028B35
    .logical $828B35

      .dsection Unsorted828B35Section

    .here

    * = $028B61
    .logical $828B61

      .dsection ProcScript828B61Section

    .here

    * = $028B6B
    .logical $828B6B

      .dsection Unsorted828B6BSection

    .here

    * = $028BA7
    .logical $828BA7

      .dsection ProcScript828BA7Section

    .here

    * = $028BB3
    .logical $828BB3

      .dsection Unsorted828BB3Section

    .here

    * = $028BEA
    .logical $828BEA

      .dsection Unsorted828BEASection

    .here

    * = $028BF4
    .logical $828BF4

      .dsection Unsorted828BF4Section

    .here

    * = $028D52
    .logical $828D52

      .dsection Unsorted828D52Section

    .here

    * = $028E61
    .logical $828E61

      .dsection Unsorted828E61Section

    .here

    * = $028ECB
    .logical $828ECB

      .dsection Unsorted828ECBSection

    .here

    * = $028F3F
    .logical $828F3F

      .dsection EventScrollFadeProcSection

      ; 82/90B0

    .here

    * = $02921E
    .logical $82921E

      .dsection EventPauseProcSection

      ; 82/9245

    .here

    * = $029245
    .logical $829245

      .dsection Unsorted829245Section

    .here

    * = $0292A9
    .logical $8292A9

      .dsection Unsorted8292A9Section

    .here

    * = $0292B3
    .logical $8292B3

      .dsection Unsorted8292B3Section

    .here

    * = $02932C
    .logical $82932C

      .dsection Unsorted82932CSection

    .here

    * = $029391
    .logical $829391

      .dsection Unsorted829391Section

    .here

    * = $029478
    .logical $829478

      .dsection EventHaltProcSection

      ; 829487

    .here


    * = $029496
    .logical $829496

      .dsection Unsorted829496Section

    .here

    * = $0294C0
    .logical $8294C0

      .dsection Unsorted8294C0Section

    .here

    * = $02C000
    .logical $82C000

      .dsection HDMAEngineSection
      .dsection HDMACodeSection

      ; 82/C26D

    .here

    * = $02E028
    .logical $82E028

      .dsection Unsorted82E028Section

    .here

    * = $02E073
    .logical $82E073

      .dsection Unsorted82E073Section

    .here

    * = $02E08D
    .logical $82E08D

      .dsection Unsorted82E08DSection

    .here

    * = $02E0AF
    .logical $82E0AF

      .dsection Unsorted82E0AFSection

    .here

    * = $02E0C6
    .logical $82E0C6

      .dsection Unsorted82E0C6Section

    .here

    * = $02E133
    .logical $82E133

      .dsection Unsorted82E133Section

    .here

    * = $02E147
    .logical $82E147

      .dsection Unsorted82E147Section

    .here

    * = $02E250
    .logical $82E250

      .dsection Unsorted82E250Section

    .here

    * = $02E283
    .logical $82E283

      .dsection Unsorted82E283Section

    .here

    * = $02E2AD
    .logical $82E2AD

      .dsection Unsorted82E2ADSection

    .here

    * = $02E400
    .logical $82E400

      .dsection Unsorted82E400Section

    .here

    * = $02E41B
    .logical $82E41B

      .dsection RAMStructSection

      ; 82/E5FF

    .here

    * = $02E5FF
    .logical $82E5FF

      .dsection Unsorted82E5FFSection

    .here

    * = $02E615
    .logical $82E615

      .dsection Unsorted82E615Section

    .here

    * = $02E62C
    .logical $82E62C

      .dsection Unsorted82E62CSection

    .here

    * = $02E664
    .logical $82E664

      .dsection Unsorted82E664Section

    .here

    * = $02E747
    .logical $82E747

      .dsection RAMStructAccessSection

      ; 82/EA43

    .here

    * = $02EADE
    .logical $82EADE

      .dsection Unsorted82EADESection

    .here

    * = $02ECB9
    .logical $82ECB9

      .dsection RAMAreaHeaderSection

      ; 82/ED1D

    .here

    * = $02EDE7
    .logical $82EDE7

      .dsection RAMAreaSection

      ; 82/F207

    .here

    * = $02F211
    .logical $82F211

      .dsection Unsorted82F211Section

    .here

    * = $02F227
    .logical $82F227

      .dsection Unsorted82F227Section

    .here

    * = $02F2E3
    .logical $82F2E3

      .dsection Unsorted82F2E3Section

    .here

    * = $02F343
    .logical $82F343

      .dsection Unsorted82F343Section

    .here

    * = $02F3A7
    .logical $82F3A7

      .dsection Unsorted82F3A7Section

    .here

    * = $02F3E5
    .logical $82F3E5

      .dsection Unsorted82F3E5Section

    .here

    * = $02F4A7
    .logical $82F4A7

      .dsection Unsorted82F4A7Section

    .here

    * = $02F4DE
    .logical $82F4DE

      .dsection UNITGroupPointerSection

      ; 82/F4F9

    .here

    * = $02F517
    .logical $82F517

      .dsection Unsorted82F517Section

    .here

    * = $02F567
    .logical $82F567

      .dsection OffsetTableSection

      ; 82/F7A2

    .here

    * = $02F866
    .logical $82F866

      .dsection EpilogueEndingsSection

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

    .here

    * = $058280
    .logical $858280

      .dsection LoadMapMenuDataFromProcSection

    .here

    * = $0582A2
    .logical $8582A2

      .dsection MapMenuSaveMapStateSection

    .here

    * = $0582D4
    .logical $8582D4

      .dsection Unsorted8582D4Section

    .here

    * = $058341
    .logical $858341

      .dsection StallProcUntilMapMenuDataLoadedSection

    .here

    * = $058366
    .logical $858366

      .dsection ProcCycleMapMenuWaitForPaletteGraphicFinishSection

    .here

    * = $058398
    .logical $858398

      .dsection ProcScript858398Section

    .here

    * = $0583C2
    .logical $8583C2

      .dsection Unsorted8583C2Section

    .here

    * = $0583D3
    .logical $8583D3

      .dsection Unsorted8583D3Section

    .here

    * = $0583DA
    .logical $8583DA

      .dsection Unsorted8583DASection

    .here

    * = $0583F8
    .logical $8583F8

      .dsection Unsorted8583F8Section

    .here

    * = $0584A1
    .logical $8584A1

      .dsection Unsorted8584A1Section

    .here

    * = $0584AA
    .logical $8584AA

      .dsection ProcScript8584AASection

    .here

    * = $0584AC
    .logical $8584AC

      .dsection Unsorted8584ACSection

    .here

    * = $0584DC
    .logical $8584DC

      .dsection Unsorted8584DCSection

    .here

    * = $058516
    .logical $858516

      .dsection Unsorted858516Section

    .here

    * = $05856E
    .logical $85856E

      .dsection Unsorted85856ESection

    .here

    * = $05860E
    .logical $85860E

      .dsection Unsorted85860ESection

    .here

    * = $05864B
    .logical $85864B

      .dsection Unsorted85864BSection

    .here

    * = $058671
    .logical $858671

      .dsection Unsorted858671Section

    .here

    * = $058684
    .logical $858684

      .dsection Unsorted858684Section

    .here

    * = $058697
    .logical $858697

      .dsection Unsorted858697Section

    .here

    * = $0586AA
    .logical $8586AA

      .dsection Unsorted8586AASection

    .here

    * = $0586FA
    .logical $8586FA

      .dsection Unsorted8586FASection

    .here

    * = $0586FF
    .logical $8586FF

      .dsection Unsorted8586FFSection

    .here

    * = $058728
    .logical $858728

      .dsection Unsorted858728Section

    .here

    * = $058751
    .logical $858751

      .dsection Unsorted858751Section

    .here

    * = $058793
    .logical $858793

      .dsection Unsorted858793Section

    .here

    * = $0587A8
    .logical $8587A8

      .dsection Unsorted8587A8Section

    .here

    * = $0587E1
    .logical $8587E1

      .dsection Unsorted8587E1Section

    .here

    * = $0587F2
    .logical $8587F2

      .dsection Unsorted8587F2Section

    .here

    * = $05884A
    .logical $85884A

      .dsection Unsorted85884ASection

    .here

    * = $05895C
    .logical $85895C

      .dsection MapMenuBuildTilemapSection

    .here

    * = $0589C5
    .logical $8589C5

      .dsection Unsorted8589C5Section

    .here

    * = $0589E7
    .logical $8589E7

      .dsection Unsorted8589E7Section

    .here

    * = $058A6F
    .logical $858A6F

      .dsection Unsorted858A6FSection

    .here

    * = $058AD7
    .logical $858AD7

      .dsection Unsorted858AD7Section

    .here

    * = $058B51
    .logical $858B51

      .dsection Unsorted858B51Section

    .here

    * = $058C4E
    .logical $858C4E

      .dsection Unsorted858C4ESection

    .here

    * = $058CD3
    .logical $858CD3

      .dsection Unsorted858CD3Section

    .here

    * = $058D18
    .logical $858D18

      .dsection Unsorted858D18Section

    .here

    * = $058D83
    .logical $858D83

      .dsection Unsorted858D83Section

    .here

    * = $058EC5
    .logical $858EC5

      .dsection Unsorted858EC5Section

    .here

    * = $058F10
    .logical $858F10

      .dsection Unsorted858F10Section

    .here

    * = $058F28
    .logical $858F28

      .dsection Unsorted858F28Section

    .here

    * = $0590B9
    .logical $8590B9

      .dsection Unsorted8590B9Section

    .here

    * = $059108
    .logical $859108

      .dsection Unsorted859108Section

    .here

    * = $05915A
    .logical $85915A

      .dsection Unsorted85915ASection

    .here

    * = $05928D
    .logical $85928D

      .dsection Unsorted85928DSection

    .here

    * = $0592FA
    .logical $8592FA

      .dsection Unsorted8592FASection

    .here

    * = $059386
    .logical $859386

      .dsection Unsorted859386Section

    .here

    * = $059390
    .logical $859390

      .dsection Unsorted859390Section

    .here

    * = $059427
    .logical $859427

      .dsection Unsorted859427Section

    .here

    * = $059431
    .logical $859431

      .dsection Unsorted859431Section

    .here

    * = $05989A
    .logical $85989A

      .dsection Unsorted85989ASection

    .here

    * = $059973
    .logical $859973

      .dsection Unsorted859973Section

    .here

    * = $059AB4
    .logical $859AB4

      .dsection Unsorted859AB4Section

    .here

    * = $059AFD
    .logical $859AFD

      .dsection Unsorted859AFDSection

    .here

    * = $059B2A
    .logical $859B2A

      .dsection Unsorted859B2ASection

    .here

    * = $059B42
    .logical $859B42

      .dsection Table859B42Section

    .here

    * = $059B48
    .logical $859B48

      .dsection Unsorted859B48Section

    .here

    * = $059B59
    .logical $859B59

      .dsection CreateUnitWindowAndTerrainWindowProcsSection

    .here

    * = $059BBD
    .logical $859BBD

      .dsection Unsorted859BBDSection

    .here

    * = $059BD1
    .logical $859BD1

      .dsection DialogueBoxMapMenuTilemapDataSection

    .here

    * = $059BDA
    .logical $859BDA

      .dsection DialogueBoxMapMenuDataSection

    .here

    * = $059BE6
    .logical $859BE6

      .dsection DialogueBoxSection

    .here

    * = $059D60
    .logical $859D60

      .dsection Unsorted859D60Section

    .here

    * = $059D94
    .logical $859D94

      .dsection Unsorted859D94Section

    .here

    * = $059DCD
    .logical $859DCD

      .dsection Unsorted859DCDSection

    .here

    * = $059E08
    .logical $859E08

      .dsection Unsorted859E08Section

    .here

    * = $059F97
    .logical $859F97

      .dsection Unsorted859F97Section

    .here

    * = $059FC5
    .logical $859FC5

      .dsection FreeHDMAEntry0Section

    .here

    * = $059FCD
    .logical $859FCD

      .dsection Unsorted859FCDSection

    .here

    * = $059FEA
    .logical $859FEA

      .dsection Unsorted859FEASection

    .here

    * = $05A004
    .logical $85A004

      .dsection Unsorted85A004Section

    .here

    * = $05A02E
    .logical $85A02E

      .dsection Unsorted85A02ESection

    .here

    * = $05A040
    .logical $85A040

      .dsection Unsorted85A040Section

    .here

    * = $05A041
    .logical $85A041

      .dsection Unsorted85A041Section

    .here

    * = $05A079
    .logical $85A079

      .dsection Unsorted85A079Section

    .here

    * = $05A0A1
    .logical $85A0A1

      .dsection Unsorted85A0A1Section

    .here

    * = $05A0D0
    .logical $85A0D0

      .dsection Unsorted85A0D0Section

    .here

    * = $05A117
    .logical $85A117

      .dsection Unsorted85A117Section

    .here

    * = $05A1AA
    .logical $85A1AA

      .dsection Unsorted85A1AASection

    .here

    * = $05A1E7
    .logical $85A1E7

      .dsection Unsorted85A1E7Section
      .dsection GetMenuTextStringLengthSection

    .here

    * = $05A227
    .logical $85A227

      .dsection Unsorted85A227Section

    .here

    * = $05A320
    .logical $85A320

      .dsection Unsorted85A320Section

    .here

    * = $05A3A6
    .logical $85A3A6

      .dsection Unsorted85A3A6Section

    .here

    * = $05A3D5
    .logical $85A3D5

      .dsection Unsorted85A3D5Section

    .here

    * = $05A47F
    .logical $85A47F

      .dsection ProcScript85A47FSection

    .here

    * = $05A48B
    .logical $85A48B

      .dsection Unsorted85A48BSection

    .here

    * = $05A508
    .logical $85A508

      .dsection Unsorted85A508Section

    .here

    * = $05A509
    .logical $85A509

      .dsection Unsorted85A509Section

    .here

    * = $05A5BD
    .logical $85A5BD

      .dsection ProcScript85A5BDSection

    .here

    * = $05A5C5
    .logical $85A5C5

      .dsection Unsorted85A5C5Section

    .here

    * = $05A5FB
    .logical $85A5FB

      .dsection Unsorted85A5FBSection

    .here

    * = $05A69A
    .logical $85A69A

      .dsection Unsorted85A69ASection

    .here

    * = $05A78E
    .logical $85A78E

      .dsection Unsorted85A78ESection

    .here

    * = $05A7DE
    .logical $85A7DE

      .dsection Unsorted85A7DESection

    .here

    * = $05A895
    .logical $85A895

      .dsection DialogueBoxHDMASection

      ; 85/AB19

    .here

    * = $05AB19
    .logical $85AB19

      .dsection FreeDialogueBoxHDMAIfFinishedSection

    .here

    * = $05AB32
    .logical $85AB32

      .dsection Unsorted85AB32Section

    .here

    * = $05AB3F
    .logical $85AB3F

      .dsection FreeDialogueBoxesSection

    .here

    * = $05AB8E
    .logical $85AB8E

      .dsection Unsorted85AB8ESection

    .here

    * = $05AB96
    .logical $85AB96

      .dsection Unsorted85AB96Section

    .here

    * = $05ABF1
    .logical $85ABF1

      .dsection Unsorted85ABF1Section

    .here

    * = $05ABF6
    .logical $85ABF6

      .dsection Unsorted85ABF6Section

    .here

    * = $05ABFE
    .logical $85ABFE

      .dsection Unsorted85ABFESection

    .here

    * = $05AC02
    .logical $85AC02

      .dsection Unsorted85AC02Section

    .here

    * = $05AC40
    .logical $85AC40

      .dsection Unsorted85AC40Section

    .here

    * = $05AC89
    .logical $85AC89

      .dsection Unsorted85AC89Section

    .here

    * = $05AD67
    .logical $85AD67

      .dsection Unsorted85AD67Section

    .here

    * = $05AE8A
    .logical $85AE8A

      .dsection Unsorted85AE8ASection

    .here

    * = $05AEAC
    .logical $85AEAC

      .dsection ProcScript85AEACSection

    .here

    * = $05AEC7
    .logical $85AEC7

      .dsection Unsorted85AEC7Section

    .here

    * = $05AF1B
    .logical $85AF1B

      .dsection Unsorted85AF1BSection

    .here

    * = $05AFC5
    .logical $85AFC5

      .dsection Unsorted85AFC5Section

    .here

    * = $05B009
    .logical $85B009

      .dsection Unsorted85B009Section

    .here

    * = $05B039
    .logical $85B039

      .dsection Unsorted85B039Section

    .here

    * = $05B07C
    .logical $85B07C

      .dsection Unsorted85B07CSection

    .here

    * = $05B0BF
    .logical $85B0BF

      .dsection Table85B0BFSection

    .here

    * = $05B107
    .logical $85B107

      .dsection Unsorted85B107Section

    .here

    * = $05B127
    .logical $85B127

      .dsection Table85B127Section

    .here

    * = $05B14F
    .logical $85B14F

      .dsection Unsorted85B14FSection

    .here

    * = $05B18F
    .logical $85B18F

      .dsection Unsorted85B18FSection

    .here

    * = $05B1B0
    .logical $85B1B0

      .dsection Unsorted85B1B0Section

    .here

    * = $05B207
    .logical $85B207

      .dsection Unsorted85B207Section

    .here

    * = $05B282
    .logical $85B282

      .dsection Unsorted85B282Section

    .here

    * = $05B2D8
    .logical $85B2D8

      .dsection ProcScript85B2D8Section

    .here

    * = $05B2DA
    .logical $85B2DA

      .dsection Unsorted85B2DASection

    .here

    * = $05B367
    .logical $85B367

      .dsection Unsorted85B367Section

    .here

    * = $05B37D
    .logical $85B37D

      .dsection Unsorted85B37DSection

    .here

    * = $05B3A2
    .logical $85B3A2

      .dsection Unsorted85B3A2Section

    .here

    * = $05B3DA
    .logical $85B3DA

      .dsection Unsorted85B3DASection

    .here

    * = $05B3FF
    .logical $85B3FF

      .dsection Unsorted85B3FFSection

    .here

    * = $05B40E
    .logical $85B40E

      .dsection Unsorted85B40ESection

    .here

    * = $05B42B
    .logical $85B42B

      .dsection Unsorted85B42BSection

    .here

    * = $05B43E
    .logical $85B43E

      .dsection Unsorted85B43ESection

    .here

    * = $05B45C
    .logical $85B45C

      .dsection Unsorted85B45CSection

    .here

    * = $05B4ED
    .logical $85B4ED

      .dsection Unsorted85B4EDSection

    .here

    * = $05B520
    .logical $85B520

      .dsection Unsorted85B520Section

    .here

    * = $05B63B
    .logical $85B63B

      .dsection ProcScript85B63BSection

    .here

    * = $05B65C
    .logical $85B65C

      .dsection Unsorted85B65CSection

    .here

    * = $05B6E0
    .logical $85B6E0

      .dsection Unsorted85B6E0Section

    .here

    * = $05B6E1
    .logical $85B6E1

      .dsection ProcScript85B6E1Section

    .here

    * = $05B725
    .logical $85B725

      .dsection Unsorted85B725Section

    .here

    * = $05B78A
    .logical $85B78A

      .dsection Unsorted85B78ASection

    .here

    * = $05B7CF
    .logical $85B7CF

      .dsection ProcScript85B7CFSection

    .here

    * = $05B7D1
    .logical $85B7D1

      .dsection Unsorted85B7D1Section

    .here

    * = $05B81D
    .logical $85B81D

      .dsection Unsorted85B81DSection

    .here

    * = $05B8D6
    .logical $85B8D6

      .dsection Unsorted85B8D6Section

    .here

    * = $05B8EE
    .logical $85B8EE

      .dsection Unsorted85B8EESection

    .here

    * = $05B8FA
    .logical $85B8FA

      .dsection ProcScript85B8FASection

    .here

    * = $05B906
    .logical $85B906

      .dsection Unsorted85B906Section

    .here

    * = $05B9D4
    .logical $85B9D4

      .dsection Unsorted85B9D4Section

    .here

    * = $05B9F2
    .logical $85B9F2

      .dsection Unsorted85B9F2Section

    .here

    * = $05BA41
    .logical $85BA41

      .dsection Unsorted85BA41Section

    .here

    * = $05BA4D
    .logical $85BA4D

      .dsection Unsorted85BA4DSection

    .here

    * = $05BAC7
    .logical $85BAC7

      .dsection Unsorted85BAC7Section

    .here

    * = $05BAD9
    .logical $85BAD9

      .dsection Unsorted85BAD9Section

    .here

    * = $05BB2E
    .logical $85BB2E

      .dsection Unsorted85BB2ESection

    .here

    * = $05BB52
    .logical $85BB52

      .dsection ProcScript85BB52Section

    .here

    * = $05BB5E
    .logical $85BB5E

      .dsection Unsorted85BB5ESection

    .here

    * = $05BBA5
    .logical $85BBA5

      .dsection Unsorted85BBA5Section

    .here

    * = $05BC00
    .logical $85BC00

      .dsection Unsorted85BC00Section

    .here

    * = $05BC0F
    .logical $85BC0F

      .dsection Unsorted85BC0FSection

    .here

    * = $05BC1B
    .logical $85BC1B

      .dsection Unsorted85BC1BSection

    .here

    * = $05BC8C
    .logical $85BC8C

      .dsection ItemObtainedTextSection

    .here

    * = $05BC9E
    .logical $85BC9E

      .dsection Unsorted85BC9ESection

    .here

    * = $05BCB8
    .logical $85BCB8

      .dsection Unsorted85BCB8Section

    .here

    * = $05BCD4
    .logical $85BCD4

      .dsection Unsorted85BCD4Section

    .here

    * = $05BD12
    .logical $85BD12

      .dsection Unsorted85BD12Section

    .here

    * = $05BD8D
    .logical $85BD8D

      .dsection Table85BD8DSection

    .here

    * = $05BD93
    .logical $85BD93

      .dsection Unsorted85BD93Section

    .here

    * = $05BDA1
    .logical $85BDA1

      .dsection Unsorted85BDA1Section

    .here

    * = $05BE76
    .logical $85BE76

      .dsection Table85BE76Section

    .here

    * = $05C0BA
    .logical $85C0BA

      .dsection Unsorted85C0BASection

    .here

    * = $05C0C7
    .logical $85C0C7

      .dsection Unsorted85C0C7Section

    .here

    * = $05C0CE
    .logical $85C0CE

      .dsection Unsorted85C0CESection

    .here

    * = $05C0D5
    .logical $85C0D5

      .dsection Unsorted85C0D5Section

    .here

    * = $05C0E2
    .logical $85C0E2

      .dsection Unsorted85C0E2Section

    .here

    * = $05C1A4
    .logical $85C1A4

      .dsection Unsorted85C1A4Section

    .here

    * = $05C30D
    .logical $85C30D

      .dsection Unsorted85C30DSection

    .here

    * = $05C347
    .logical $85C347

      .dsection Unsorted85C347Section

    .here

    * = $05C41F
    .logical $85C41F

      .dsection Unsorted85C41FSection

    .here

    * = $05C4E0
    .logical $85C4E0

      .dsection Unsorted85C4E0Section

    .here

    * = $05C55B
    .logical $85C55B

      .dsection Unsorted85C55BSection

    .here

    * = $05C65A
    .logical $85C65A

      .dsection Unsorted85C65ASection

    .here

    * = $05C6D2
    .logical $85C6D2

      .dsection Unsorted85C6D2Section

    .here

    * = $05C819
    .logical $85C819

      .dsection Unsorted85C819Section

    .here

    * = $05C99F
    .logical $85C99F

      .dsection Unsorted85C99FSection

    .here

    * = $05C9BF
    .logical $85C9BF

      .dsection Unsorted85C9BFSection

    .here

    * = $05CA4B
    .logical $85CA4B

      .dsection Unsorted85CA4BSection

    .here

    * = $05CA85
    .logical $85CA85

      .dsection ProcScript85CA85Section

    .here

    * = $05CA91
    .logical $85CA91

      .dsection Unsorted85CA91Section

    .here

    * = $05CAFB
    .logical $85CAFB

      .dsection Unsorted85CAFBSection

    .here

    * = $05CAFC
    .logical $85CAFC

      .dsection Unsorted85CAFCSection

    .here

    * = $05CB51
    .logical $85CB51

      .dsection Unsorted85CB51Section

    .here

    * = $05CBBD
    .logical $85CBBD

      .dsection Unsorted85CBBDSection

    .here

    * = $05CC3D
    .logical $85CC3D

      .dsection Unsorted85CC3DSection

    .here

    * = $05CC3E
    .logical $85CC3E

      .dsection Unsorted85CC3ESection

    .here

    * = $05CC4D
    .logical $85CC4D

      .dsection Unsorted85CC4DSection

    .here

    * = $05CC62
    .logical $85CC62

      .dsection ProcScript85CC62Section

    .here

    * = $05CCA8
    .logical $85CCA8

      .dsection Unsorted85CCA8Section

    .here

    * = $05CD0C
    .logical $85CD0C

      .dsection ProcScript85CD0CSection

    .here

    * = $05CD2D
    .logical $85CD2D

      .dsection ProcScript85CD2DSection

    .here

    * = $05CD39
    .logical $85CD39

      .dsection Unsorted85CD39Section

    .here

    * = $05CD81
    .logical $85CD81

      .dsection Unsorted85CD81Section

    .here

    * = $05CE54
    .logical $85CE54

      .dsection Unsorted85CE54Section

    .here

    * = $05CE7C
    .logical $85CE7C

      .dsection Unsorted85CE7CSection

    .here

    * = $05CEC3
    .logical $85CEC3

      .dsection Unsorted85CEC3Section

    .here

    * = $05CEE2
    .logical $85CEE2

      .dsection Unsorted85CEE2Section

    .here

    * = $05D064
    .logical $85D064

      .dsection ProcScript85D064Section

    .here

    * = $05D066
    .logical $85D066

      .dsection Unsorted85D066Section

    .here

    * = $05D100
    .logical $85D100

      .dsection Unsorted85D100Section

    .here

    * = $05D17E
    .logical $85D17E

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

    .here

    * = $05D4B2
    .logical $85D4B2

      .dsection Unsorted85D4B2Section

    .here

    * = $05D591
    .logical $85D591

      .dsection Table85D591Section

    .here

    * = $05D5AA
    .logical $85D5AA

      .dsection Unsorted85D5AASection

    .here

    * = $05D5CC
    .logical $85D5CC

      .dsection Unsorted85D5CCSection

    .here

    * = $05D606
    .logical $85D606

      .dsection Table85D606Section
      .dsection Table85D626Section
      .dsection Table85D638Section

    .here

    * = $05D648
    .logical $85D648

      .dsection Unsorted85D648Section

    .here

    * = $05D671
    .logical $85D671

      .dsection Unsorted85D671Section

    .here

    * = $05D676
    .logical $85D676

      .dsection Unsorted85D676Section

    .here

    * = $05D6B2
    .logical $85D6B2

      .dsection Table85D6B2Section

    .here

    * = $05D766
    .logical $85D766

      .dsection Unsorted85D766Section

    .here

    * = $05D7A0
    .logical $85D7A0

      .dsection Table85D7A0Section

    .here

    * = $05D7FA
    .logical $85D7FA

      .dsection Unsorted85D7FASection

    .here

    * = $05D8AA
    .logical $85D8AA

      .dsection ProcScript85D8AASection

    .here

    * = $05D8B6
    .logical $85D8B6

      .dsection Unsorted85D8B6Section

    .here

    * = $05D971
    .logical $85D971

      .dsection Unsorted85D971Section

    .here

    * = $05D9FA
    .logical $85D9FA

      .dsection ProcScript85D9FASection

    .here

    * = $05D9FC
    .logical $85D9FC

      .dsection Unsorted85D9FCSection

    .here

    * = $05DA77
    .logical $85DA77

      .dsection Table85DA77Section

    .here

    * = $05DA7E
    .logical $85DA7E

      .dsection Unsorted85DA7ESection

    .here

    * = $05DAB2
    .logical $85DAB2

      .dsection Table85DAB2Section

    .here

    * = $05DABB
    .logical $85DABB

      .dsection Unsorted85DABBSection

    .here

    * = $05DACB
    .logical $85DACB

      .dsection Table85DACBSection

    .here

    * = $05DAEA
    .logical $85DAEA

      .dsection ProcScript85DAEASection

    .here

    * = $05DAF6
    .logical $85DAF6

      .dsection Unsorted85DAF6Section

    .here

    * = $05DBDD
    .logical $85DBDD

      .dsection Unsorted85DBDDSection

    .here

    * = $05DC26
    .logical $85DC26

      .dsection Unsorted85DC26Section

    .here

    * = $05DCAB
    .logical $85DCAB

      .dsection Unsorted85DCABSection

    .here

    * = $05DCCA
    .logical $85DCCA

      .dsection Unsorted85DCCASection

    .here

    * = $05DDDB
    .logical $85DDDB

      .dsection ProcScript85DDDBSection

    .here

    * = $05DDF9
    .logical $85DDF9

      .dsection Unsorted85DDF9Section

    .here

    * = $05DE34
    .logical $85DE34

      .dsection Unsorted85DE34Section

    .here

    * = $05DE7C
    .logical $85DE7C

      .dsection Unsorted85DE7CSection

    .here

    * = $05DED6
    .logical $85DED6

      .dsection Unsorted85DED6Section

    .here

    * = $05DF20
    .logical $85DF20

      .dsection Unsorted85DF20Section

    .here

    * = $05DF3F
    .logical $85DF3F

      .dsection Unsorted85DF3FSection

    .here

    * = $05DF61
    .logical $85DF61

      .dsection Unsorted85DF61Section

    .here

    * = $05DF6F
    .logical $85DF6F

      .dsection Unsorted85DF6FSection

    .here

    * = $05DF7D
    .logical $85DF7D

      .dsection Unsorted85DF7DSection

    .here

    * = $05DF8A
    .logical $85DF8A

      .dsection Unsorted85DF8ASection

    .here

    * = $05DFA6
    .logical $85DFA6

      .dsection Unsorted85DFA6Section

    .here

    * = $05DFC2
    .logical $85DFC2

      .dsection Unsorted85DFC2Section

    .here

    * = $05DFFD
    .logical $85DFFD

      .dsection Unsorted85DFFDSection

    .here

    * = $05E004
    .logical $85E004

      .dsection Unsorted85E004Section

    .here

    * = $05E012
    .logical $85E012

      .dsection Unsorted85E012Section

    .here

    * = $05E1CC
    .logical $85E1CC

      .dsection ProcScript85E1CCSection

    .here

    * = $05E1DB
    .logical $85E1DB

      .dsection Unsorted85E1DBSection

    .here

    * = $05E2DF
    .logical $85E2DF

      .dsection Unsorted85E2DFSection

    .here

    * = $05E33D
    .logical $85E33D

      .dsection Unsorted85E33DSection

    .here

    * = $05E38C
    .logical $85E38C

      .dsection Unsorted85E38CSection

    .here

    * = $05E44E
    .logical $85E44E

      .dsection Unsorted85E44ESection

    .here

    * = $05E47F
    .logical $85E47F

      .dsection Unsorted85E47FSection

    .here

    * = $05E545
    .logical $85E545

      .dsection Unsorted85E545Section

    .here

    * = $05E549
    .logical $85E549

      .dsection Unsorted85E549Section

    .here

    * = $05E57E
    .logical $85E57E

      .dsection Unsorted85E57ESection

    .here

    * = $05E6D7
    .logical $85E6D7

      .dsection Unsorted85E6D7Section

    .here

    * = $05E6E8
    .logical $85E6E8

      .dsection Unsorted85E6E8Section

    .here

    * = $05E78A
    .logical $85E78A

      .dsection Unsorted85E78ASection

    .here

    * = $05E7B3
    .logical $85E7B3

      .dsection Unsorted85E7B3Section

    .here

    * = $05E839
    .logical $85E839

      .dsection Unsorted85E839Section

    .here

    * = $05E85D
    .logical $85E85D

      .dsection Unsorted85E85DSection

    .here

    * = $05E897
    .logical $85E897

      .dsection Unsorted85E897Section

    .here

    * = $05E8A8
    .logical $85E8A8

      .dsection Unsorted85E8A8Section

    .here

    * = $05E8EA
    .logical $85E8EA

      .dsection Unsorted85E8EASection

    .here

    * = $05E8FB
    .logical $85E8FB

      .dsection Unsorted85E8FBSection

    .here

    * = $05E960
    .logical $85E960

      .dsection Unsorted85E960Section

    .here

    * = $05E9D6
    .logical $85E9D6

      .dsection Unsorted85E9D6Section

    .here

    * = $05EA64
    .logical $85EA64

      .dsection Unsorted85EA64Section

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

    * = $078000
    .logical $878000

      .dsection CodeChecksums878000Section

    .here

    * = $078017
    .logical $878017

      .dsection Unsorted878017Section

    .here

    * = $0780AA
    .logical $8780AA

      .dsection Unsorted8780AASection

    .here

    * = $0780DF
    .logical $8780DF

      .dsection Unsorted8780DFSection

    .here

    * = $0780F9
    .logical $8780F9

      .dsection MapMenu8780F9Section

    .here

    * = $078148
    .logical $878148

      .dsection Unsorted878148Section

    .here

    * = $07819A
    .logical $87819A

      .dsection Unknown87819ASection

    .here

    * = $0781EA
    .logical $8781EA

      .dsection LoadMapMenuDataSection

    .here

    * = $078232
    .logical $878232

      .dsection LoadMapMenuTilemapDataSection

    .here

    * = $078256
    .logical $878256

      .dsection Unsorted878256Section

    .here

    * = $07829A
    .logical $87829A

      .dsection Unsorted87829ASection

    .here

    * = $0782D4
    .logical $8782D4

      .dsection Unsorted8782D4Section

    .here

    * = $078337
    .logical $878337

      .dsection Unsorted878337Section

    .here

    * = $0783F8
    .logical $8783F8

      .dsection Unsorted8783F8Section

    .here

    * = $07840F
    .logical $87840F

      .dsection Unsorted87840FSection

    .here

    * = $078459
    .logical $878459

      .dsection Unsorted878459Section

    .here

    * = $078472
    .logical $878472

      .dsection Unsorted878472Section

    .here

    * = $0784E1
    .logical $8784E1

      .dsection Unsorted8784E1Section

    .here

    * = $078517
    .logical $878517

      .dsection GetMapMenuYPositionsSection

    .here

    * = $078531
    .logical $878531

      .dsection Unsorted878531Section

    .here

    * = $0785A4
    .logical $8785A4

      .dsection Unsorted8785A4Section

    .here

    * = $0786BA
    .logical $8786BA

      .dsection HandleMapMenuPaletteGraphicsDataSection

    .here

    * = $07872B
    .logical $87872B

      .dsection Unsorted87872BSection

    .here

    * = $078749
    .logical $878749

      .dsection GetMapMenuPositionSection

    .here

    * = $0787B5
    .logical $8787B5

      .dsection GetMapMenuTilemapRAMEntryPointerSection

    .here

    * = $078852
    .logical $878852

      .dsection Unsorted878852Section

    .here

    * = $0788B3
    .logical $8788B3

      .dsection GetMapMenuTileIndexSection

    .here

    * = $0788F7
    .logical $8788F7

      .dsection Unsorted8788F7Section

    .here

    * = $078900
    .logical $878900

      .dsection Unsorted878900Section

    .here

    * = $078916
    .logical $878916

      .dsection Unsorted878916Section

    .here

    * = $078921
    .logical $878921

      .dsection Unsorted878921Section
      .dsection ApplyMapMenuPaletteDataSection

    .here

    * = $078979
    .logical $878979

      .dsection HandleMapMenuDecompressionDMASection

    .here

    * = $078AB5
    .logical $878AB5

      .dsection Unsorted878AB5Section

    .here

    * = $078B1F
    .logical $878B1F

      .dsection Unsorted878B1FSection

    .here

    * = $078B4E
    .logical $878B4E

      .dsection Unsorted878B4ESection

    .here

    * = $078B83
    .logical $878B83

      .dsection RemoveMapMenuTilemapRAMEntrySection

    .here

    * = $078BF0
    .logical $878BF0

      .dsection Unsorted878BF0Section

    .here

    * = $078C8C
    .logical $878C8C

      .dsection Unsorted878C8CSection

    .here

    * = $078D61
    .logical $878D61

      .dsection Unsorted878D61Section

    .here

    * = $078F6E
    .logical $878F6E

      .dsection Unsorted878F6ESection

    .here

    * = $078FE7
    .logical $878FE7

      .dsection Unsorted878FE7Section

    .here

    * = $079076
    .logical $879076

      .dsection Table879076Section

    .here

    * = $07913E
    .logical $87913E

      .dsection Unsorted87913ESection

    .here

    * = $0791EE
    .logical $8791EE

      .dsection Unsorted8791EESection

    .here

    * = $079354
    .logical $879354

      .dsection DrawMenuTextLineSection

    .here

    * = $079471
    .logical $879471

      .dsection Table879471Section

    .here

    * = $079D77
    .logical $879D77

      .dsection Table879D77Section

    .here

    * = $079E42
    .logical $879E42

      .dsection CheckTalkEventEntryAvailableSection

    .here

    * = $079EE7
    .logical $879EE7

      .dsection Unsorted879EE7Section

    .here

    * = $079F12
    .logical $879F12

      .dsection Unsorted879F12Section

    .here

    * = $07A006
    .logical $87A006

      .dsection Unsorted87A006Section

    .here

    * = $07A040
    .logical $87A040

      .dsection Unsorted87A040Section

    .here

    * = $07A082
    .logical $87A082

      .dsection Unsorted87A082Section

    .here

    * = $07A18C
    .logical $87A18C

      .dsection Unsorted87A18CSection

    .here

    * = $07A19D
    .logical $87A19D

      .dsection SkillsSection

      .dsection ClassDataSection

      .dsection InheritanceSection

      .dsection LovePointsSection

      ; 87/AE88

    .here

    * = $07AE88
    .logical $87AE88

      .dsection Unsorted87AE88Section

    .here

    * = $07AF46
    .logical $87AF46

      .dsection Unsorted87AF46Section

    .here

    * = $07B01D
    .logical $87B01D

      .dsection Unsorted87B01DSection
      .dsection ClearEventMovementTargetMapSection

    .here

    * = $07B197
    .logical $87B197

      .dsection EventMovementTargetDistanceMapSection

    .here

    * = $07B4ED
    .logical $87B4ED

      .dsection EventMovementMovementScriptBufferAddressesSection

    .here

    * = $07B4FD
    .logical $87B4FD

      .dsection EventMovementDirectionLookupSection

    .here

    * = $07B505
    .logical $87B505

      .dsection EventMovementWriteToMovementScriptBufferSection

    .here

    * = $07B512
    .logical $87B512

      .dsection Unsorted87B512Section

    .here

    * = $07B541
    .logical $87B541

      .dsection Unsorted87B541Section

    .here

    * = $07B5DD
    .logical $87B5DD

      .dsection Unsorted87B5DDSection

    .here

    * = $07B63F
    .logical $87B63F

      .dsection Unsorted87B63FSection

    .here

    * = $07B786
    .logical $87B786

      .dsection Unsorted87B786Section

    .here

    * = $07B877
    .logical $87B877

      .dsection Unsorted87B877Section

    .here

    * = $07B8A7
    .logical $87B8A7

      .dsection Unsorted87B8A7Section

    .here

    * = $07B8EE
    .logical $87B8EE

      .dsection Table87B8EESection

    .here

    * = $07B8FE
    .logical $87B8FE

      .dsection Unsorted87B8FESection

    .here

    * = $07BAD1
    .logical $87BAD1

      .dsection Table87BAD1Section

    .here

    * = $07BB27
    .logical $87BB27

      .dsection Unsorted87BB27Section

    .here

    * = $07BB50
    .logical $87BB50

      .dsection ScriptedCritsSection

      ; 87/BE98

    .here

    * = $07BE98
    .logical $87BE98

      .dsection CheckIfTerrainWindowSettingOffSection

    .here

    * = $07BED7
    .logical $87BED7

      .dsection Unsorted87BED7Section

    .here

    * = $07BEF1
    .logical $87BEF1

      .dsection GetTextSpeedOptionSection

    .here

    * = $07BF01
    .logical $87BF01

      .dsection Unsorted87BF01Section

    .here

    * = $07BF1B
    .logical $87BF1B

      .dsection Unsorted87BF1BSection

    .here

    * = $07BF29
    .logical $87BF29

      .dsection Unsorted87BF29Section

    .here

    * = $07BF43
    .logical $87BF43

      .dsection Unsorted87BF43Section

    .here

    * = $07BF52
    .logical $87BF52

      .dsection Unsorted87BF52Section

    .here

    * = $07BF6F
    .logical $87BF6F

      .dsection Unsorted87BF6FSection

    .here

    * = $07BFBF
    .logical $87BFBF

      .dsection Unsorted87BFBFSection

    .here

    * = $07BFD9
    .logical $87BFD9

      .dsection Unsorted87BFD9Section

    .here

    * = $07BFE9
    .logical $87BFE9

      .dsection Unsorted87BFE9Section

    .here

    * = $07C003
    .logical $87C003

      .dsection AICleverModeSection

    .here

    * = $07C015
    .logical $87C015

      .dsection Unsorted87C015Section

    .here

    * = $07C02F
    .logical $87C02F

      .dsection Unsorted87C02FSection

    .here

    * = $07C03C
    .logical $87C03C

      .dsection Unsorted87C03CSection

    .here

    * = $07C056
    .logical $87C056

      .dsection Unsorted87C056Section
      .dsection ProcCycleFlickerUnitsOfFactionSlotSection

    .here

    * = $07C398
    .logical $87C398

      .dsection Unsorted87C398Section

    .here

    * = $07C41B
    .logical $87C41B

      .dsection Unsorted87C41BSection

    .here

    * = $07C442
    .logical $87C442

      .dsection Unsorted87C442Section

    .here

    * = $07C5AA
    .logical $87C5AA

      .dsection Unsorted87C5AASection

    .here

    * = $07C646
    .logical $87C646

      .dsection Unsorted87C646Section

    .here

    * = $07C695
    .logical $87C695

      .dsection Unsorted87C695Section

    .here

    * = $07CBC5
    .logical $87CBC5

      .dsection Unsorted87CBC5Section

    .here

    * = $07CBC6
    .logical $87CBC6

      .dsection AITargetListSection
      .dsection AIScriptSection
      .dsection AIRangeMapSection

    .here

    * = $07D65A
    .logical $87D65A

      .dsection Unsorted87D65ASection

    .here

    * = $07D711
    .logical $87D711

      .dsection AITargetMapSection
      .dsection AIUnitListSection
      .dsection AIGroupSection

    .here

    * = $07DC71
    .logical $87DC71

      .dsection AIFormationOffsetSection

    .here

    * = $07DCD8
    .logical $87DCD8

      .dsection FormationPatternOffsetsSection

    .here

    * = $07DF12
    .logical $87DF12

      .dsection ItemsSection

      ; 87/E6D3

    .here

    * = $07E6D3
    .logical $87E6D3

      .dsection Unsorted87E6D3Section

    .here

    * = $07E6D7
    .logical $87E6D7

      .dsection Unsorted87E6D7Section

    .here

    * = $07E709
    .logical $87E709

      .dsection Unsorted87E709Section

    .here

    * = $07E762
    .logical $87E762

      .dsection Unsorted87E762Section

    .here

    * = $07E779
    .logical $87E779

      .dsection Unsorted87E779Section

    .here

    * = $07E801
    .logical $87E801

      .dsection Unsorted87E801Section

    .here

    * = $07E86A
    .logical $87E86A

      .dsection Unsorted87E86ASection

    .here

    * = $07E98D
    .logical $87E98D

      .dsection LocationEventDataSection

      ; 87/E9E0

    .here

    * = $07E9E0
    .logical $87E9E0

      .dsection Unsorted87E9E0Section

    .here

    * = $07EA09
    .logical $87EA09

      .dsection Unsorted87EA09Section

    .here

    * = $07EA87
    .logical $87EA87

      .dsection LocationUpdateSection

      ; 87/EBC8

    .here

    * = $07EBC8
    .logical $87EBC8

      .dsection Unsorted87EBC8Section

    .here

    * = $07EC42
    .logical $87EC42

      .dsection LocationGettersSection

      ; 87/EF46

    .here

    * = $07EF46
    .logical $87EF46

      .dsection Unsorted87EF46Section

    .here

    * = $07EF61
    .logical $87EF61

      .dsection LocationModificationSection

      ; 87/F321

    .here

    * = $07F321
    .logical $87F321

      .dsection Unsorted87F321Section

    .here

    * = $07F361
    .logical $87F361

      .dsection Table87F361Section

    .here

    * = $07F391
    .logical $87F391

      .dsection GetEventLocationTypeBaseMoneySection

    .here

    * = $07F3A7
    .logical $87F3A7

      .dsection LocationTypeOffsetsSection

      ; 87/F4A7

    .here

    * = $07F4CF
    .logical $87F4CF

      .dsection CheckIfCharacterHasFemaleGenerationIDSection

    .here

    * = $07F501
    .logical $87F501

      .dsection Unsorted87F501Section

    .here

    * = $07F515
    .logical $87F515

      .dsection Unsorted87F515Section

      ; 87/F559

    .here

    * = $07F55A
    .logical $87F55A

      .dsection Unsorted87F55ASection

    .here

    * = $07F574
    .logical $87F574

      .dsection CreateUnitFromBuffersByTypeSection

    .here

    * = $07F9CE
    .logical $87F9CE

      .dsection CompactStaticDynamicUnitBuffer1UnitStatesSection

    .here

    * = $07F9F6
    .logical $87F9F6

      .dsection Unsorted87F9F6Section

    .here

    * = $07FA1E
    .logical $87FA1E

      .dsection CompactHolyEnemyUnitBuffer1UnitStatesSection

    .here

    * = $07FA57
    .logical $87FA57

      .dsection Unsorted87FA57Section

    .here

    * = $07FA83
    .logical $87FA83

      .dsection FillUnitsDeploymentSaveDataSection

    .here

    * = $07FABC
    .logical $87FABC

      .dsection Unsorted87FABCSection

    .here

    * = $07FB5E
    .logical $87FB5E

      .dsection Unsorted87FB5ESection

    .here

    * = $07FB94
    .logical $87FB94

      .dsection Unsorted87FB94Section

    .here

    * = $07FBC5
    .logical $87FBC5

      .dsection FillItemsOwnerAndSlotDataSection

    .here

    * = $07FC51
    .logical $87FC51

      .dsection FillItemDurabilityDataSection

    .here

    * = $07FCC3
    .logical $87FCC3

      .dsection CapItemDurabilitySection

    .here

    * = $07FD09
    .logical $87FD09

      .dsection Unsorted87FD09Section

    .here

    * = $088000
    .logical $888000

      .dsection Table888000Section

    .here

    * = $088082
    .logical $888082

      .dsection Unsorted888082Section

    .here

    * = $08818A
    .logical $88818A

      .dsection Unsorted88818ASection

    .here

    * = $088197
    .logical $888197

      .dsection Unsorted888197Section

    .here

    * = $0881B8
    .logical $8881B8

      .dsection Unsorted8881B8Section

    .here

    * = $0881D7
    .logical $8881D7

      .dsection Unsorted8881D7Section

    .here

    * = $0881DE
    .logical $8881DE

      .dsection Unsorted8881DESection

    .here

    * = $0881E5
    .logical $8881E5

      .dsection Unsorted8881E5Section

    .here

    * = $0881EC
    .logical $8881EC

      .dsection Unsorted8881ECSection

    .here

    * = $08821A
    .logical $88821A

      .dsection Unsorted88821ASection

    .here

    * = $0883C7
    .logical $8883C7

      .dsection Unsorted8883C7Section

    .here

    * = $088410
    .logical $888410

      .dsection Unsorted888410Section

    .here

    * = $08847D
    .logical $88847D

      .dsection Unsorted88847DSection

    .here

    * = $088560
    .logical $888560

      .dsection Unsorted888560Section

    .here

    * = $0885D3
    .logical $8885D3

      .dsection Unsorted8885D3Section

    .here

    * = $0885EF
    .logical $8885EF

      .dsection Unsorted8885EFSection

    .here

    * = $08860B
    .logical $88860B

      .dsection Unsorted88860BSection

    .here

    * = $08861C
    .logical $88861C

      .dsection Unsorted88861CSection
      .dsection MapScrollRightSetBGOFSSection

    .here

    * = $0887EC
    .logical $8887EC

      .dsection Unsorted8887ECSection

    .here

    * = $088901
    .logical $888901

      .dsection Unsorted888901Section

    .here

    * = $088A14
    .logical $888A14

      .dsection Unsorted888A14Section

    .here

    * = $088BB3
    .logical $888BB3

      .dsection Unsorted888BB3Section

    .here

    * = $088C5F
    .logical $888C5F

      .dsection Unsorted888C5FSection

    .here

    * = $088D57
    .logical $888D57

      .dsection Unsorted888D57Section

    .here

    * = $088F32
    .logical $888F32

      .dsection Unsorted888F32Section

    .here

    * = $089396
    .logical $889396

      .dsection ProcScript889396Section

    .here

    * = $08939E
    .logical $88939E

      .dsection Unsorted88939ESection

    .here

    * = $089400
    .logical $889400

      .dsection Unsorted889400Section

    .here

    * = $089411
    .logical $889411

      .dsection Unsorted889411Section

    .here

    * = $089504
    .logical $889504

      .dsection ProcScript889504Section

    .here

    * = $089506
    .logical $889506

      .dsection Unsorted889506Section

    .here

    * = $0896AF
    .logical $8896AF

      .dsection Unsorted8896AFSection

    .here

    * = $08973F
    .logical $88973F

      .dsection Unsorted88973FSection

    .here

    * = $0899B8
    .logical $8899B8

      .dsection Unsorted8899B8Section

    .here

    * = $089AE2
    .logical $889AE2

      .dsection Table889AE2Section

    .here

    * = $089B22
    .logical $889B22

      .dsection Unsorted889B22Section

    .here

    * = $089B6D
    .logical $889B6D

      .dsection Unsorted889B6DSection

    .here

    * = $089BB5
    .logical $889BB5

      .dsection Unsorted889BB5Section

    .here

    * = $089BF7
    .logical $889BF7

      .dsection Unsorted889BF7Section

    .here

    * = $089C52
    .logical $889C52

      .dsection ProcScript889C52Section

    .here

    * = $089C5A
    .logical $889C5A

      .dsection Unsorted889C5ASection

    .here

    * = $089CEE
    .logical $889CEE

      .dsection Unsorted889CEESection

    .here

    * = $089D20
    .logical $889D20

      .dsection Unsorted889D20Section

    .here

    * = $089DA6
    .logical $889DA6

      .dsection Unsorted889DA6Section

    .here

    * = $089E6C
    .logical $889E6C

      .dsection ProcScript889E6CSection

    .here

    * = $08A12B
    .logical $88A12B

      .dsection Unsorted88A12BSection

    .here

    * = $08A2F5
    .logical $88A2F5

      .dsection Unsorted88A2F5Section

    .here

    * = $08A32D
    .logical $88A32D

      .dsection Unsorted88A32DSection

    .here

    * = $08A38C
    .logical $88A38C

      .dsection Unsorted88A38CSection

    .here

    * = $08A395
    .logical $88A395

      .dsection Unsorted88A395Section

    .here

    * = $08A44C
    .logical $88A44C

      .dsection Unsorted88A44CSection

    .here

    * = $08A4FC
    .logical $88A4FC

      .dsection Unsorted88A4FCSection

    .here

    * = $08A551
    .logical $88A551

      .dsection Unsorted88A551Section

    .here

    * = $08A698
    .logical $88A698

      .dsection Unsorted88A698Section

    .here

    * = $08A704
    .logical $88A704

      .dsection Unsorted88A704Section

    .here

    * = $08A73D
    .logical $88A73D

      .dsection Table88A73DSection

    .here

    * = $08A754
    .logical $88A754

      .dsection Unsorted88A754Section

    .here

    * = $08A7F5
    .logical $88A7F5

      .dsection Unsorted88A7F5Section

    .here

    * = $08A81D
    .logical $88A81D

      .dsection Unsorted88A81DSection

    .here

    * = $08AB2C
    .logical $88AB2C

      .dsection Unsorted88AB2CSection

    .here

    * = $08AB47
    .logical $88AB47

      .dsection Unsorted88AB47Section

    .here

    * = $08ACF1
    .logical $88ACF1

      .dsection Table88ACF1Section

    .here

    * = $08AD46
    .logical $88AD46

      .dsection Unsorted88AD46Section

    .here

    * = $08ADA2
    .logical $88ADA2

      .dsection Unsorted88ADA2Section

    .here

    * = $08ADA6
    .logical $88ADA6

      .dsection Unsorted88ADA6Section

    .here

    * = $08ADC9
    .logical $88ADC9

      .dsection Unsorted88ADC9Section

    .here

    * = $08ADE9
    .logical $88ADE9

      .dsection Unsorted88ADE9Section

    .here

    * = $08AF4C
    .logical $88AF4C

      .dsection Unsorted88AF4CSection

    .here

    * = $08AF7B
    .logical $88AF7B

      .dsection Unsorted88AF7BSection

    .here

    * = $08AFB6
    .logical $88AFB6

      .dsection MapInputHandlerSection

    .here

    * = $08B028
    .logical $88B028

      .dsection Unsorted88B028Section

    .here

    * = $08B366
    .logical $88B366

      .dsection Unsorted88B366Section

    .here

    * = $08B3AF
    .logical $88B3AF

      .dsection Unsorted88B3AFSection

    .here

    * = $08B3DF
    .logical $88B3DF

      .dsection Unsorted88B3DFSection

    .here

    * = $08B42C
    .logical $88B42C

      .dsection Unsorted88B42CSection

    .here

    * = $08B46A
    .logical $88B46A

      .dsection Unsorted88B46ASection

    .here

    * = $08B4DB
    .logical $88B4DB

      .dsection Unsorted88B4DBSection

    .here

    * = $08B51A
    .logical $88B51A

      .dsection Unsorted88B51ASection

    .here

    * = $08B64F
    .logical $88B64F

      .dsection Unsorted88B64FSection

    .here

    * = $08B6FD
    .logical $88B6FD

      .dsection Unsorted88B6FDSection

    .here

    * = $08BC05
    .logical $88BC05

      .dsection Unsorted88BC05Section

    .here

    * = $08BDA1
    .logical $88BDA1

      .dsection Unsorted88BDA1Section

    .here

    * = $08BF37
    .logical $88BF37

      .dsection Unsorted88BF37Section

    .here

    * = $08BF6C
    .logical $88BF6C

      .dsection Unsorted88BF6CSection

    .here

    * = $08BF97
    .logical $88BF97

      .dsection Unsorted88BF97Section

    .here

    * = $08BFFA
    .logical $88BFFA

      .dsection Unsorted88BFFASection

    .here

    * = $08C059
    .logical $88C059

      .dsection Unsorted88C059Section

    .here

    * = $08C072
    .logical $88C072

      .dsection Unsorted88C072Section

    .here

    * = $08C085
    .logical $88C085

      .dsection Unsorted88C085Section

    .here

    * = $08C13E
    .logical $88C13E

      .dsection GetMapSpriteMovementSoundSection

    .here

    * = $08C1BF
    .logical $88C1BF

      .dsection Unsorted88C1BFSection

    .here

    * = $08C25D
    .logical $88C25D

      .dsection Unsorted88C25DSection

    .here

    * = $08C2BA
    .logical $88C2BA

      .dsection Unsorted88C2BASection

    .here

    * = $08C355
    .logical $88C355

      .dsection Unsorted88C355Section

    .here

    * = $08C3F0
    .logical $88C3F0

      .dsection Unsorted88C3F0Section

    .here

    * = $08C4D9
    .logical $88C4D9

      .dsection Unsorted88C4D9Section

    .here

    * = $08C67D
    .logical $88C67D

      .dsection Unsorted88C67DSection

    .here

    * = $08C71C
    .logical $88C71C

      .dsection Unsorted88C71CSection

    .here

    * = $08C7CF
    .logical $88C7CF

      .dsection Unsorted88C7CFSection

    .here

    * = $08C7D8
    .logical $88C7D8

      .dsection Unsorted88C7D8Section

    .here

    * = $08C834
    .logical $88C834

      .dsection Table88C834Section

    .here

    * = $08C844
    .logical $88C844

      .dsection Unsorted88C844Section

    .here

    * = $08C9A6
    .logical $88C9A6

      .dsection Unsorted88C9A6Section

    .here

    * = $08CA28
    .logical $88CA28

      .dsection Unsorted88CA28Section

    .here

    * = $08CA77
    .logical $88CA77

      .dsection Unsorted88CA77Section

    .here

    * = $08CBE8
    .logical $88CBE8

      .dsection Unsorted88CBE8Section

    .here

    * = $08CC75
    .logical $88CC75

      .dsection Unsorted88CC75Section

    .here

    * = $08CD53
    .logical $88CD53

      .dsection Unsorted88CD53Section

    .here

    * = $08CD68
    .logical $88CD68

      .dsection Unsorted88CD68Section

    .here

    * = $08CF8A
    .logical $88CF8A

      .dsection Table88CF8ASection

    .here

    * = $08CFBA
    .logical $88CFBA

      .dsection Unsorted88CFBASection

    .here

    * = $08D013
    .logical $88D013

      .dsection Table88D013Section

    .here

    * = $08D073
    .logical $88D073

      .dsection Unsorted88D073Section

    .here

    * = $08D084
    .logical $88D084

      .dsection Unsorted88D084Section

    .here

    * = $08D365
    .logical $88D365

      aMapMovementShortSpritePointers .binclude "data/class/MapMovementShortSpritePointers.csv.asm" ; 88/D365
      aMapMovementTallSpritePointers  .binclude "data/class/MapMovementTallSpritePointers.csv.asm"  ; 88/D428

      ; 88/D488

    .here

    * = $08D488
    .logical $88D488

      .dsection Table88D488Section
      .dsection Table88D4C6Section
      .dsection Table88D526Section
      .dsection Table88D5E3Section

    .here

    * = $08D67C
    .logical $88D67C

      .dsection MovingMapSpriteAppendDecompSection

    .here

    * = $08D6E5
    .logical $88D6E5

      .dsection SetMovingMapSpriteBufferPointersSection

    .here

    * = $08D731
    .logical $88D731

      .dsection Unsorted88D731Section

    .here

    * = $08D7FE
    .logical $88D7FE

      .dsection Unsorted88D7FESection

    .here

    * = $08D847
    .logical $88D847

      .dsection Unsorted88D847Section

    .here

    * = $08D94B
    .logical $88D94B

      .dsection Unsorted88D94BSection

    .here

    * = $08D963
    .logical $88D963

      .dsection Unsorted88D963Section

    .here

    * = $08DA6A
    .logical $88DA6A

      .dsection Unsorted88DA6ASection

    .here

    * = $08DA82
    .logical $88DA82

      .dsection Unsorted88DA82Section

    .here

    * = $08DAFC
    .logical $88DAFC

      .dsection Unsorted88DAFCSection

    .here

    * = $08DB0C
    .logical $88DB0C

      .dsection Unsorted88DB0CSection

    .here

    * = $08DBEE
    .logical $88DBEE

      .dsection Unsorted88DBEESection

    .here

    * = $08DC07
    .logical $88DC07

      .dsection Unsorted88DC07Section

    .here

    * = $08DD9C
    .logical $88DD9C

      .dsection Unsorted88DD9CSection

    .here

    * = $08DDFB
    .logical $88DDFB

      .dsection Unsorted88DDFBSection

    .here

    * = $08DE0B
    .logical $88DE0B

      .dsection Unsorted88DE0BSection

    .here

    * = $08DE1B
    .logical $88DE1B

      .dsection Unsorted88DE1BSection

    .here

    * = $08DF8C
    .logical $88DF8C

      .dsection Unsorted88DF8CSection

    .here

    * = $08E200
    .logical $88E200

      .dsection ProcScript88E200Section

    .here

    * = $08E208
    .logical $88E208

      .dsection Unsorted88E208Section

    .here

    * = $08E268
    .logical $88E268

      .dsection ProcScript88E268Section

    .here

    * = $08E272
    .logical $88E272

      .dsection Unsorted88E272Section

    .here

    * = $08E2DC
    .logical $88E2DC

      .dsection ProcScript88E2DCSection

    .here

    * = $08E33D
    .logical $88E33D

      .dsection Unsorted88E33DSection

    .here

    * = $08E401
    .logical $88E401

      .dsection Unsorted88E401Section

    .here

    * = $08EEB1
    .logical $88EEB1

      .dsection Unsorted88EEB1Section

    .here

    * = $08EF0D
    .logical $88EF0D

      .dsection Unsorted88EF0DSection

    .here

    * = $098000
    .logical $898000

      .dsection Unsorted898000Section

    .here

    * = $098105
    .logical $898105

      .dsection Unsorted898105Section

    .here

    * = $098536
    .logical $898536

      .dsection Unsorted898536Section

    .here

    * = $09861B
    .logical $89861B

      .dsection Unsorted89861BSection

    .here

    * = $098755
    .logical $898755

      .dsection Unsorted898755Section

    .here

    * = $09876D
    .logical $89876D

      .dsection Unsorted89876DSection

    .here

    * = $0989AD
    .logical $8989AD

      .dsection Unsorted8989ADSection

    .here

    * = $0989CE
    .logical $8989CE

      .dsection Unsorted8989CESection

    .here

    * = $0989EA
    .logical $8989EA

      .dsection Unsorted8989EASection

    .here

    * = $098A41
    .logical $898A41

      .dsection Unsorted898A41Section

    .here

    * = $098A7E
    .logical $898A7E

      .dsection Unsorted898A7ESection

    .here

    * = $098AF5
    .logical $898AF5

      .dsection Unsorted898AF5Section

    .here

    * = $098B2A
    .logical $898B2A

      .dsection Table898B2ASection

    .here

    * = $098B3B
    .logical $898B3B

      .dsection Unsorted898B3BSection

    .here

    * = $098B80
    .logical $898B80

      .dsection Table898B80Section

    .here

    * = $098B97
    .logical $898B97

      .dsection Unsorted898B97Section

    .here

    * = $098D55
    .logical $898D55

      .dsection Unsorted898D55Section

    .here

    * = $098E6C
    .logical $898E6C

      .dsection Table898E6CSection
      .dsection Table898E90Section

    .here

    * = $098EB4
    .logical $898EB4

      .dsection Unsorted898EB4Section

    .here

    * = $098F16
    .logical $898F16

      .dsection Unsorted898F16Section

    .here

    * = $098F43
    .logical $898F43

      .dsection Table898F43Section
      .dsection Table898F5BSection

    .here

    * = $098F73
    .logical $898F73

      .dsection Unsorted898F73Section

    .here

    * = $098FD4
    .logical $898FD4

      .dsection Table898FD4Section
      .dsection Table898FECSection
      .dsection Table899004Section

    .here

    * = $099028
    .logical $899028

      .dsection Unsorted899028Section

    .here

    * = $099081
    .logical $899081

      .dsection Table899081Section

    .here

    * = $0990BD
    .logical $8990BD

      .dsection Unsorted8990BDSection

    .here

    * = $0990DA
    .logical $8990DA

      .dsection Unsorted8990DASection

      ; 89/9140

    .here

    * = $09914B
    .logical $89914B

      .dsection Unsorted89914BSection

    .here

    * = $099185
    .logical $899185

      .dsection Unsorted899185Section

    .here

    * = $0991C4
    .logical $8991C4

      .dsection Unsorted8991C4Section

    .here

    * = $099200
    .logical $899200

      .dsection Unsorted899200Section

    .here

    * = $0992AD
    .logical $8992AD

      .dsection Unsorted8992ADSection

    .here

    * = $0992E7
    .logical $8992E7

      .dsection Table8992E7Section

    .here

    * = $09933C
    .logical $89933C

      .dsection Unsorted89933CSection

    .here

    * = $09936E
    .logical $89936E

      .dsection Unsorted89936ESection

    .here

    * = $0994B8
    .logical $8994B8

      .dsection Unsorted8994B8Section

    .here

    * = $099510
    .logical $899510

      .dsection Unsorted899510Section

    .here

    * = $09970D
    .logical $89970D

      .dsection Unsorted89970DSection

    .here

    * = $0998E1
    .logical $8998E1

      .dsection Unsorted8998E1Section

    .here

    * = $099BA5
    .logical $899BA5

      .dsection Unsorted899BA5Section

    .here

    * = $099C7C
    .logical $899C7C

      .dsection Unsorted899C7CSection

    .here

    * = $099D72
    .logical $899D72

      .dsection Unsorted899D72Section

    .here

    * = $099FA1
    .logical $899FA1

      .dsection Unsorted899FA1Section

    .here

    * = $099FDC
    .logical $899FDC

      .dsection Unsorted899FDCSection

      ; 89/A085

    .here

    * = $09A085
    .logical $89A085

      .dsection Unsorted89A085Section

    .here

    * = $09A107
    .logical $89A107

      .dsection SplitNumberIntoDigitsSection

    .here

    * = $09A138
    .logical $89A138

      .dsection Unsorted89A138Section

    .here

    * = $09A150
    .logical $89A150

      .dsection Unsorted89A150Section

      ; 89/A18C

    .here

    * = $09A18C
    .logical $89A18C

      .dsection DrawMenuTextNumberSection

    .here

    * = $09A25A
    .logical $89A25A

      .dsection Unsorted89A25ASection

    .here

    * = $09A2ED
    .logical $89A2ED

      .dsection Unsorted89A2EDSection

    .here

    * = $09A376
    .logical $89A376

      .dsection Unsorted89A376Section

    .here

    * = $09A3C0
    .logical $89A3C0

      .dsection Unsorted89A3C0Section

    .here

    * = $09A4E3
    .logical $89A4E3

      .dsection Unsorted89A4E3Section

    .here

    * = $09A52D
    .logical $89A52D

      .dsection Table89A52DSection
      .dsection Table89A572Section
      .dsection Table89A59ESection

    .here

    * = $09A5AA
    .logical $89A5AA

      .dsection Unsorted89A5AASection

    .here

    * = $09A5D1
    .logical $89A5D1

      .dsection Unsorted89A5D1Section

    .here

    * = $09ABF9
    .logical $89ABF9

      .dsection Table89ABF9Section

    .here

    * = $09ACCE
    .logical $89ACCE

      .dsection Unsorted89ACCESection

    .here

    * = $09B0AA
    .logical $89B0AA

      .dsection Unsorted89B0AASection

    .here

    * = $09B3D7
    .logical $89B3D7

      .dsection Unsorted89B3D7Section

    .here

    * = $09B400
    .logical $89B400

      .dsection Unsorted89B400Section

    .here

    * = $09B856
    .logical $89B856

      .dsection Unsorted89B856Section

    .here

    * = $09B883
    .logical $89B883

      .dsection Unsorted89B883Section

    .here

    * = $09B8BD
    .logical $89B8BD

      .dsection Unsorted89B8BDSection

    .here

    * = $09B91F
    .logical $89B91F

      .dsection Unsorted89B91FSection

    .here

    * = $09BAF3
    .logical $89BAF3

      .dsection Unsorted89BAF3Section

    .here

    * = $09BBB2
    .logical $89BBB2

      .dsection Unsorted89BBB2Section

    .here

    * = $09BCCE
    .logical $89BCCE

      .dsection Table89BCCESection

    .here

    * = $09BD00
    .logical $89BD00

      .dsection Unsorted89BD00Section

    .here

    * = $09BEB8
    .logical $89BEB8

      .dsection Unsorted89BEB8Section

    .here

    * = $09BECC
    .logical $89BECC

      .dsection Unsorted89BECCSection

    .here

    * = $09BEEB
    .logical $89BEEB

      .dsection Unsorted89BEEBSection

    .here

    * = $09C021
    .logical $89C021

      .dsection Unsorted89C021Section

    .here

    * = $09C144
    .logical $89C144

      .dsection Unsorted89C144Section

    .here

    * = $09C1A1
    .logical $89C1A1

      .dsection Unsorted89C1A1Section

    .here

    * = $09C2CF
    .logical $89C2CF

      .dsection Unsorted89C2CFSection

    .here

    * = $09C3F3
    .logical $89C3F3

      .dsection Unsorted89C3F3Section

    .here

    * = $09C488
    .logical $89C488

      .dsection Unsorted89C488Section

    .here

    * = $09C5A2
    .logical $89C5A2

      .dsection Unsorted89C5A2Section

    .here

    * = $09C6F9
    .logical $89C6F9

      .dsection DebugMenuSection

      ; 89/EB26

    .here

    * = $09EB26
    .logical $89EB26

      .dsection Unsorted89EB26Section

    .here

    * = $09EB5E
    .logical $89EB5E

      .dsection Unsorted89EB5ESection

    .here

    * = $09ECC6
    .logical $89ECC6

      .dsection Unsorted89ECC6Section

    .here

    * = $09ECC7
    .logical $89ECC7

      .dsection Unsorted89ECC7Section

    .here

    * = $09ED12
    .logical $89ED12

      .dsection Unsorted89ED12Section

    .here

    * = $09EDFD
    .logical $89EDFD

      .dsection Unsorted89EDFDSection

    .here

    * = $09EE32
    .logical $89EE32

      .dsection Unsorted89EE32Section

    .here

    * = $09F065
    .logical $89F065

      .dsection Unsorted89F065Section

    .here

    * = $09F246
    .logical $89F246

      .dsection Unsorted89F246Section

    .here

    * = $09F620
    .logical $89F620

      .dsection Unsorted89F620Section

    .here

    * = $09F630
    .logical $89F630

      .dsection Unsorted89F630Section

    .here

    * = $09F67F
    .logical $89F67F

      .dsection Unsorted89F67FSection

    .here

    * = $09F713
    .logical $89F713

      .dsection Unsorted89F713Section

    .here

    * = $09F7A6
    .logical $89F7A6

      .dsection Unsorted89F7A6Section

    .here

    * = $09F7E6
    .logical $89F7E6

      .dsection Unsorted89F7E6Section

    .here

    * = $09F842
    .logical $89F842

      .dsection Unsorted89F842Section

    .here

    * = $0A8000
    .logical $8A8000

      .dsection Unsorted8A8000Section

    .here

    * = $0A800E
    .logical $8A800E

      .dsection Unsorted8A800ESection

    .here

    * = $0A8061
    .logical $8A8061

      .dsection Unsorted8A8061Section

    .here

    * = $0A8078
    .logical $8A8078

      .dsection Table8A8078Section

    .here

    * = $0A80A6
    .logical $8A80A6

      .dsection Unsorted8A80A6Section

    .here

    * = $0A80C3
    .logical $8A80C3

      .dsection Unsorted8A80C3Section
      .dsection Unsorted8A80C8Section

    .here

    * = $0A80CD
    .logical $8A80CD

      .dsection Unsorted8A80CDSection

    .here

    * = $0A80F5
    .logical $8A80F5

      .dsection Unsorted8A80F5Section

    .here

    * = $0A80FA
    .logical $8A80FA

      .dsection Unsorted8A80FASection

    .here

    * = $0A8208
    .logical $8A8208

      .dsection Unsorted8A8208Section

    .here

    * = $0A8393
    .logical $8A8393

      .dsection Unsorted8A8393Section

    .here

    * = $0A8496
    .logical $8A8496

      .dsection Unsorted8A8496Section

    .here

    * = $0A8643
    .logical $8A8643

      .dsection Unsorted8A8643Section

    .here

    * = $0A869A
    .logical $8A869A

      .dsection Unsorted8A869ASection

    .here

    * = $0A870D
    .logical $8A870D

      .dsection Unsorted8A870DSection

    .here

    * = $0A8783
    .logical $8A8783

      .dsection Unsorted8A8783Section

    .here

    * = $0A87B8
    .logical $8A87B8

      .dsection Unsorted8A87B8Section

    .here

    * = $0A8980
    .logical $8A8980

      .dsection Unsorted8A8980Section

    .here

    * = $0A8E08
    .logical $8A8E08

      .dsection Unsorted8A8E08Section

    .here

    * = $0A8F68
    .logical $8A8F68

      .dsection Unsorted8A8F68Section

    .here

    * = $0A8F8F
    .logical $8A8F8F

      .dsection Unsorted8A8F8FSection

    .here

    * = $0A918A
    .logical $8A918A

      .dsection Unsorted8A918ASection

    .here

    * = $0A9209
    .logical $8A9209

      .dsection Unsorted8A9209Section

    .here

    * = $0A929B
    .logical $8A929B

      .dsection Unsorted8A929BSection

    .here

    * = $0A92BB
    .logical $8A92BB

      .dsection Unsorted8A92BBSection

    .here

    * = $0A92D6
    .logical $8A92D6

      .dsection Unsorted8A92D6Section

    .here

    * = $0A9342
    .logical $8A9342

      .dsection Unsorted8A9342Section

    .here

    * = $0A9389
    .logical $8A9389

      .dsection Unsorted8A9389Section

    .here

    * = $0A94B6
    .logical $8A94B6

      .dsection Unsorted8A94B6Section

    .here

    * = $0A94E2
    .logical $8A94E2

      .dsection Unsorted8A94E2Section

    .here

    * = $0A950E
    .logical $8A950E

      .dsection Unsorted8A950ESection

    .here

    * = $0A956F
    .logical $8A956F

      .dsection Unsorted8A956FSection

    .here

    * = $0A9750
    .logical $8A9750

      .dsection Unsorted8A9750Section

    .here

    * = $0A9776
    .logical $8A9776

      .dsection Unsorted8A9776Section

    .here

    * = $0A979C
    .logical $8A979C

      .dsection Unsorted8A979CSection

    .here

    * = $0A97C2
    .logical $8A97C2

      .dsection Unsorted8A97C2Section

    .here

    * = $0A9858
    .logical $8A9858

      .dsection Unsorted8A9858Section

    .here

    * = $0A98AC
    .logical $8A98AC

      .dsection Table8A98ACSection
      .dsection Table8A98B8Section

    .here

    * = $0A98D0
    .logical $8A98D0

      .dsection Unsorted8A98D0Section

    .here

    * = $0A99DB
    .logical $8A99DB

      .dsection Table8A99DBSection
      .dsection Table8A9A0BSection

    .here

    * = $0A9A56
    .logical $8A9A56

      .dsection Unsorted8A9A56Section

    .here

    * = $0A9AD4
    .logical $8A9AD4

      .dsection Table8A9AD4Section
      .dsection Table8A9B04Section
      .dsection Table8A9B94Section
      .dsection Table8A9BC4Section
      .dsection Table8A9BF4Section
      .dsection Table8A9C24Section

    .here

    * = $0A9C61
    .logical $8A9C61

      .dsection Unsorted8A9C61Section

    .here

    * = $0A9D22
    .logical $8A9D22

      .dsection Unsorted8A9D22Section

    .here

    * = $0A9D39
    .logical $8A9D39

      .dsection Unsorted8A9D39Section

    .here

    * = $0A9DF2
    .logical $8A9DF2

      .dsection Unsorted8A9DF2Section

    .here

    * = $0A9EB7
    .logical $8A9EB7

      .dsection Unsorted8A9EB7Section

    .here

    * = $0A9FCC
    .logical $8A9FCC

      .dsection Unsorted8A9FCCSection

    .here

    * = $0AA013
    .logical $8AA013

      .dsection Unsorted8AA013Section

    .here

    * = $0AA02B
    .logical $8AA02B

      .dsection Unsorted8AA02BSection

    .here

    * = $0AA142
    .logical $8AA142

      .dsection Unsorted8AA142Section

    .here

    * = $0AA2ED
    .logical $8AA2ED

      .dsection Unsorted8AA2EDSection

    .here

    * = $0AA400
    .logical $8AA400

      .dsection Unsorted8AA400Section

    .here

    * = $0AA4C8
    .logical $8AA4C8

      .dsection Unsorted8AA4C8Section

    .here

    * = $0AA5FF
    .logical $8AA5FF

      .dsection Unsorted8AA5FFSection

    .here

    * = $0AA63D
    .logical $8AA63D

      .dsection Unsorted8AA63DSection

    .here

    * = $0AA6CA
    .logical $8AA6CA

      .dsection Unsorted8AA6CASection

    .here

    * = $0AA830
    .logical $8AA830

      .dsection Unsorted8AA830Section

    .here

    * = $0AA83D
    .logical $8AA83D

      .dsection Unsorted8AA83DSection

    .here

    * = $0AA8C9
    .logical $8AA8C9

      .dsection Unsorted8AA8C9Section

    .here

    * = $0AA928
    .logical $8AA928

      .dsection Unsorted8AA928Section

    .here

    * = $0AA97F
    .logical $8AA97F

      .dsection Unsorted8AA97FSection

    .here

    * = $0AA9A6
    .logical $8AA9A6

      .dsection Unsorted8AA9A6Section

    .here

    * = $0AA9CE
    .logical $8AA9CE

      .dsection Unsorted8AA9CESection

    .here

    * = $0AAA3A
    .logical $8AAA3A

      .dsection Unsorted8AAA3ASection

    .here

    * = $0AAA8A
    .logical $8AAA8A

      .dsection Unsorted8AAA8ASection

    .here

    * = $0AAB48
    .logical $8AAB48

      .dsection Unsorted8AAB48Section

    .here

    * = $0AABAB
    .logical $8AABAB

      .dsection Unsorted8AABABSection

    .here

    * = $0AABFC
    .logical $8AABFC

      .dsection Unsorted8AABFCSection

    .here

    * = $0AACA8
    .logical $8AACA8

      .dsection Unsorted8AACA8Section

    .here

    * = $0AAD05
    .logical $8AAD05

      .dsection Unsorted8AAD05Section

    .here

    * = $0AAD6F
    .logical $8AAD6F

      .dsection Unsorted8AAD6FSection

    .here

    * = $0AADA7
    .logical $8AADA7

      .dsection Table8AADA7Section

    .here

    * = $0AADAD
    .logical $8AADAD

      .dsection Unsorted8AADADSection

    .here

    * = $0AADC3
    .logical $8AADC3

      .dsection Unsorted8AADC3Section

    .here

    * = $0AADF4
    .logical $8AADF4

      .dsection Unsorted8AADF4Section

    .here

    * = $0AAF0A
    .logical $8AAF0A

      .dsection Unsorted8AAF0ASection

    .here

    * = $0AB043
    .logical $8AB043

      .dsection Unsorted8AB043Section

    .here

    * = $0AB093
    .logical $8AB093

      .dsection Unsorted8AB093Section

    .here

    * = $0AB111
    .logical $8AB111

      .dsection Unsorted8AB111Section

    .here

    * = $0AB23B
    .logical $8AB23B

      .dsection Unsorted8AB23BSection

    .here

    * = $0AB317
    .logical $8AB317

      .dsection DialoguePortraitSection

      ; 8A/B3FE

    .here

    * = $0AB3FE
    .logical $8AB3FE

      .dsection Unsorted8AB3FESection

    .here

    * = $0AB452
    .logical $8AB452

      .dsection GetDecompressedPortraitDataPointersSection

    .here

    * = $0AB49A
    .logical $8AB49A

      .dsection DecompressWorldMapPortraitToSlotSection

    .here

    * = $0AB4EB
    .logical $8AB4EB

      .dsection PortraitSlotDecompressionPointersSection

    .here

    * = $0AB4F9
    .logical $8AB4F9

      aPortraitGraphicPointers .include "data/PortraitGraphicPointers.csv.asm" ; 8A/B4F9
      aPortraitPalettePointers .include "data/PortraitPalettePointers.csv.asm" ; 8A/B7E1

      ; 8A/BAC9

    .here

    * = $0ABB3E
    .logical $8ABB3E

      .dsection Unsorted8ABB3ESection

    .here

    * = $0ABE63
    .logical $8ABE63

      .dsection Unsorted8ABE63Section

    .here

    * = $0ABF27
    .logical $8ABF27

      .dsection Unsorted8ABF27Section

    .here

    * = $0AC003
    .logical $8AC003

      .dsection Unsorted8AC003Section

    .here

    * = $0AC08F
    .logical $8AC08F

      .dsection Table8AC08FSection

    .here

    * = $0AC0B9
    .logical $8AC0B9

      .dsection Unsorted8AC0B9Section

    .here

    * = $0AC457
    .logical $8AC457

      .dsection Unsorted8AC457Section

    .here

    * = $0AC50D
    .logical $8AC50D

      .dsection Unsorted8AC50DSection
      .dsection Unsorted8AC524Section
      .dsection Unsorted8AC68ESection
      .dsection Unsorted8AC6BASection
      .dsection Unsorted8AC785Section
      .dsection Unsorted8AC81ESection
      .dsection Unsorted8AC853Section

    .here

    * = $0AC8A2
    .logical $8AC8A2

      .dsection Unsorted8AC8A2Section

    .here

    * = $0AC984
    .logical $8AC984

      .dsection Unsorted8AC984Section
      .dsection Unsorted8ACA53Section

    .here

    * = $0ACAD2
    .logical $8ACAD2

      .dsection Unsorted8ACAD2Section

    .here

    * = $0ACBF2
    .logical $8ACBF2

      .dsection Unsorted8ACBF2Section

    .here

    * = $0ACC43
    .logical $8ACC43

      .dsection Unsorted8ACC43Section

    .here

    * = $0ACC58
    .logical $8ACC58

      .dsection Unsorted8ACC58Section
      .dsection Unsorted8ACD53Section
      .dsection Unsorted8ACD94Section
      .dsection Unsorted8ACDABSection

    .here

    * = $0ACE2B
    .logical $8ACE2B

      .dsection Unsorted8ACE2BSection

    .here

    * = $0ACE3A
    .logical $8ACE3A

      .dsection Unsorted8ACE3ASection

    .here

    * = $0ACE50
    .logical $8ACE50

      .dsection Unsorted8ACE50Section

    .here

    * = $0ACEB3
    .logical $8ACEB3

      .dsection Unsorted8ACEB3Section

    .here

    * = $0ACFBE
    .logical $8ACFBE

      .dsection Unsorted8ACFBESection

    .here

    * = $0AD092
    .logical $8AD092

      .dsection Unsorted8AD092Section

    .here

    * = $0AD81B
    .logical $8AD81B

      .dsection Unsorted8AD81BSection

    .here

    * = $0AD95A
    .logical $8AD95A

      .dsection Unsorted8AD95ASection

    .here

    * = $0AD975
    .logical $8AD975

      .dsection Unsorted8AD975Section

    .here

    * = $0AD9FE
    .logical $8AD9FE

      .dsection Unsorted8AD9FESection

    .here

    * = $0ADA16
    .logical $8ADA16

      .dsection Unsorted8ADA16Section

    .here

    * = $0ADA83
    .logical $8ADA83

      .dsection Unsorted8ADA83Section

    .here

    * = $0ADB04
    .logical $8ADB04

      .dsection Unsorted8ADB04Section

    .here

    * = $0ADB37
    .logical $8ADB37

      .dsection Unsorted8ADB37Section

    .here

    * = $0ADB63
    .logical $8ADB63

      .dsection DisplayDialogueAPressArrowsSection

    .here

    * = $0ADBBD
    .logical $8ADBBD

      .dsection Unsorted8ADBBDSection

    .here

    * = $0ADBFF
    .logical $8ADBFF

      .dsection Unsorted8ADBFFSection

    .here

    * = $0ADC25
    .logical $8ADC25

      .dsection Unsorted8ADC25Section

    .here

    * = $0ADCDD
    .logical $8ADCDD

      .dsection Unsorted8ADCDDSection

    .here

    * = $0ADCDE
    .logical $8ADCDE

      .dsection Unsorted8ADCDESection

    .here

    * = $0ADCF9
    .logical $8ADCF9

      .dsection Unsorted8ADCF9Section

    .here

    * = $0AE05E
    .logical $8AE05E

      .dsection Unsorted8AE05ESection

    .here

    * = $0AE0C7
    .logical $8AE0C7

      .dsection Table8AE0C7Section

    .here

    * = $0AE147
    .logical $8AE147

      .dsection ProcScript8AE147Section

    .here

    * = $0AE14F
    .logical $8AE14F

      .dsection Unsorted8AE14FSection

    .here

    * = $0AE197
    .logical $8AE197

      .dsection ProcScript8AE197Section

    .here

    * = $0AE199
    .logical $8AE199

      .dsection Unsorted8AE199Section

    .here

    * = $0AE1A1
    .logical $8AE1A1

      .dsection ProcUnknown8AE199InitSection

    .here

    * = $0AE1C1
    .logical $8AE1C1

      .dsection Unsorted8AE1C1Section

    .here

    * = $0AE1EB
    .logical $8AE1EB

      .dsection Unsorted8AE1EBSection

    .here

    * = $0AE1F3
    .logical $8AE1F3

      .dsection Unsorted8AE1F3Section

    .here

    * = $0AE243
    .logical $8AE243

      .dsection ProcScript8AE243Section

    .here

    * = $0AE245
    .logical $8AE245

      .dsection Unsorted8AE245Section

    .here

    * = $0AE29F
    .logical $8AE29F

      .dsection Unsorted8AE29FSection

    .here

    * = $0AE2F8
    .logical $8AE2F8

      .dsection Unsorted8AE2F8Section

    .here

    * = $0AE4B9
    .logical $8AE4B9

      .dsection ArenaMenuSection

    .here

    * = $0AECEF
    .logical $8AECEF

      .dsection Unsorted8AECEFSection

    .here

    * = $0AEEB1
    .logical $8AEEB1

      .dsection Unsorted8AEEB1Section

    .here

    * = $0AEEF2
    .logical $8AEEF2

      .dsection Table8AEEF2Section

    .here

    * = $0AEEFE
    .logical $8AEEFE

      .dsection Unsorted8AEEFESection

    .here

    * = $0AF048
    .logical $8AF048

      .dsection Unsorted8AF048Section
      .dsection Unsorted8AF0B4Section

    .here

    * = $0AF0D7
    .logical $8AF0D7

      .dsection Unsorted8AF0D7Section

    .here

    * = $0AF283
    .logical $8AF283

      .dsection Unsorted8AF283Section

    .here

    * = $0AF2C7
    .logical $8AF2C7

      .dsection Table8AF2C7Section

    .here

    * = $0AF2E1
    .logical $8AF2E1

      .dsection Unsorted8AF2E1Section

    .here

    * = $0AF4A1
    .logical $8AF4A1

      .dsection Unsorted8AF4A1Section
      .dsection Unsorted8AF4B8Section
      .dsection Unsorted8AF556Section
      .dsection Unsorted8AF634Section
      .dsection Unsorted8AF6A1Section
      .dsection Unsorted8AF6D5Section
      .dsection Unsorted8AF6ECSection
      .dsection Unsorted8AF791Section
      .dsection Unsorted8AF818Section

    .here

    * = $0AF885
    .logical $8AF885

      .dsection Unsorted8AF885Section

    .here

    * = $0AFA34
    .logical $8AFA34

      .dsection Unsorted8AFA34Section

    .here

    * = $0AFA6F
    .logical $8AFA6F

      .dsection Table8AFA6FSection

    .here

    * = $0AFA7F
    .logical $8AFA7F

      .dsection Unsorted8AFA7FSection

    .here

    * = $0AFC52
    .logical $8AFC52

      .dsection Unsorted8AFC52Section

    .here

    * = $0AFC78
    .logical $8AFC78

      .dsection Unsorted8AFC78Section

    .here

    * = $0AFCD5
    .logical $8AFCD5

      .dsection Unsorted8AFCD5Section

    .here

    * = $0B8000
    .logical $8B8000

      .dsection Unsorted8B8000Section

    .here

    * = $0B806D
    .logical $8B806D

      .dsection Unsorted8B806DSection

    .here

    * = $0B80CB
    .logical $8B80CB

      .dsection Unsorted8B80CBSection

    .here

    * = $0B818D
    .logical $8B818D

      .dsection Unsorted8B818DSection

    .here

    * = $0B821F
    .logical $8B821F

      .dsection FadeInWorldMapPortraitSlotSection

    .here

    * = $0B8345
    .logical $8B8345

      .dsection WorldMapPortraitSection

      ; 8b83a7

    .here


    * = $0B84E5
    .logical $8B84E5

      .dsection WorldMapMarkers1Section

      ; 8B/87E5

    .here

    * = $0B87E5
    .logical $8B87E5

      .dsection Unsorted8B87E5Section

    .here

    * = $0B88CE
    .logical $8B88CE

      .dsection WorldMapHighlightCodeSection

      ; 8b8a58

    .here

    * = $0B8A84
    .logical $8B8A84

      .dsection ClearHighlightWorldMapPartSection

    .here

    * = $0B8AAB
    .logical $8B8AAB

      .dsection Unsorted8B8AABSection

    .here

    * = $0B8B59
    .logical $8B8B59

      .dsection WorldMapMarkerShadowFadeInSection

    .here

    * = $0B8BB5
    .logical $8B8BB5

      .dsection Unsorted8B8BB5Section

    .here

    * = $0B8BF4
    .logical $8B8BF4

      .dsection WorldMapMarkerShadowFadeOutSection

    .here

    * = $0B8C42
    .logical $8B8C42

      .dsection Unsorted8B8C42Section

    .here

    * = $0B8C83
    .logical $8B8C83

      .dsection FadeInWorldMapPortraitSlot8B8C83Section

    .here

    * = $0B8C98
    .logical $8B8C98

      .dsection ProcFadeInWorldMapPortraitSlotCycleSection

    .here

    * = $0B8E17
    .logical $8B8E17

      .dsection ProcFadeInWorldMapPortraitSlotCodeSection

    .here

    * = $0B912A
    .logical $8B912A

      .dsection Unsorted8B912ASection

    .here

    * = $0B91F6
    .logical $8B91F6

      .dsection Unsorted8B91F6Section

    .here

    * = $0B9451
    .logical $8B9451

      .dsection Unsorted8B9451Section

    .here

    * = $0B9458
    .logical $8B9458

      .dsection Unsorted8B9458Section

    .here

    * = $0B959C
    .logical $8B959C

      .dsection Unsorted8B959CSection

    .here

    * = $0B95A3
    .logical $8B95A3

      .dsection Unsorted8B95A3Section

    .here

    * = $0B96CF
    .logical $8B96CF

      .dsection Unsorted8B96CFSection

    .here

    * = $0B972C
    .logical $8B972C

      .dsection Unsorted8B972CSection

    .here

    * = $0B9759
    .logical $8B9759

      .dsection Unsorted8B9759Section

    .here

    * = $0B977D
    .logical $8B977D

      .dsection WorldMapMarkers2Section

      aPortraitDataIDs .include "data/character/PortraitDataIDs.csv.asm" ; 8B/9A88
      aClassPortraitDataIDs .include "data/class/ClassPortraitDataIDs.csv.asm" ; 8B/9FF8

      ; 8B/A088
      ; 4 different HDMA structs

    .here

    * = $0BA0B4
    .logical $8BA0B4

      .dsection Unsorted8BA0B4Section

    .here

    * = $0BA7CB
    .logical $8BA7CB

      .dsection Unsorted8BA7CBSection

    .here

    * = $0BA7F2
    .logical $8BA7F2

      .dsection Unsorted8BA7F2Section

    .here

    * = $0BA851
    .logical $8BA851

      .dsection Unsorted8BA851Section

    .here

    * = $0BAC7F
    .logical $8BAC7F

      .dsection Unsorted8BAC7FSection

    .here

    * = $0BADF1
    .logical $8BADF1

      .dsection Unsorted8BADF1Section

    .here

    * = $0BAE12
    .logical $8BAE12

      .dsection UnitWindowPageDrawersSection

    .here

    * = $0BAE1E
    .logical $8BAE1E

      .dsection Unsorted8BAE1ESection

    .here

    * = $0BAF3B
    .logical $8BAF3B

      .dsection UnitWindowDrawPagesSection

    .here

    * = $0BB45D
    .logical $8BB45D

      .dsection Unsorted8BB45DSection

    .here

    * = $0BB469
    .logical $8BB469

      .dsection Unsorted8BB469Section

    .here

    * = $0BB50D
    .logical $8BB50D

      .dsection Unsorted8BB50DSection

    .here

    * = $0BB54F
    .logical $8BB54F

      .dsection Unsorted8BB54FSection

    .here

    * = $0BB596
    .logical $8BB596

      .dsection Unsorted8BB596Section

    .here

    * = $0BB63B
    .logical $8BB63B

      .dsection Unsorted8BB63BSection

    .here

    * = $0BB71F
    .logical $8BB71F

      .dsection Unsorted8BB71FSection

    .here

    * = $0BB871
    .logical $8BB871

      .dsection Unsorted8BB871Section

    .here

    * = $0BB8B6
    .logical $8BB8B6

      .dsection Unsorted8BB8B6Section

    .here

    * = $0BBAA4
    .logical $8BBAA4

      .dsection Unsorted8BBAA4Section

    .here

    * = $0BBAE9
    .logical $8BBAE9

      .dsection Unsorted8BBAE9Section

    .here

    * = $0BBDA7
    .logical $8BBDA7

      .dsection Unsorted8BBDA7Section

    .here

    * = $0BBDF0
    .logical $8BBDF0

      .dsection UnitWindowDrawWeaponRankSection

    .here

    * = $0BBE68
    .logical $8BBE68

      .dsection Unsorted8BBE68Section

    .here

    * = $0BBFED
    .logical $8BBFED

      .dsection Table8BBFEDSection

    .here

    * = $0BC030
    .logical $8BC030

      .dsection Unsorted8BC030Section

    .here

    * = $0BC08F
    .logical $8BC08F

      .dsection Table8BC08FSection

    .here

    * = $0BC0F0
    .logical $8BC0F0

      .dsection Unsorted8BC0F0Section

    .here

    * = $0BC21F
    .logical $8BC21F

      .dsection Unsorted8BC21FSection

    .here

    * = $0BC391
    .logical $8BC391

      .dsection Unsorted8BC391Section

    .here

    * = $0BC43A
    .logical $8BC43A

      .dsection Unsorted8BC43ASection

    .here

    * = $0BC457
    .logical $8BC457

      .dsection Table8BC457Section

    .here

    * = $0BC467
    .logical $8BC467

      .dsection Unsorted8BC467Section

    .here

    * = $0BC484
    .logical $8BC484

      .dsection Unsorted8BC484Section

    .here

    * = $0BC518
    .logical $8BC518

      .dsection Table8BC518Section

    .here

    * = $0BC52A
    .logical $8BC52A

      .dsection Unsorted8BC52ASection

    .here

    * = $0BC5C6
    .logical $8BC5C6

      .dsection Unsorted8BC5C6Section

    .here

    * = $0BC668
    .logical $8BC668

      .dsection Unsorted8BC668Section

    .here

    * = $0BC9B6
    .logical $8BC9B6

      .dsection Unsorted8BC9B6Section

    .here

    * = $0BCA1A
    .logical $8BCA1A

      .dsection Unsorted8BCA1ASection

    .here

    * = $0BCA7F
    .logical $8BCA7F

      .dsection Unsorted8BCA7FSection

    .here

    * = $0BCAB4
    .logical $8BCAB4

      .dsection Unsorted8BCAB4Section

    .here

    * = $0BCD20
    .logical $8BCD20

      .dsection Unsorted8BCD20Section

    .here

    * = $0BCD89
    .logical $8BCD89

      .dsection Unsorted8BCD89Section

    .here

    * = $0BCDD8
    .logical $8BCDD8

      .dsection JoinOrderSection

      ; 8B/CE29

    .here

    * = $0BCE29
    .logical $8BCE29

      .dsection Unsorted8BCE29Section

    .here

    * = $0BCE71
    .logical $8BCE71

      .dsection Unsorted8BCE71Section

    .here

    * = $0BCF0A
    .logical $8BCF0A

      .dsection DataWindowShowSection

    .here











    * = $0BD794
    .logical $8BD794

      .dsection Unsorted8BD794Section

    .here

    * = $0BD7BD
    .logical $8BD7BD

      .dsection Unsorted8BD7BDSection

    .here

    * = $0BD8FE
    .logical $8BD8FE

      .dsection Unsorted8BD8FESection

    .here

    * = $0BD90B
    .logical $8BD90B

      .dsection Unsorted8BD90BSection

    .here

    * = $0BDAB4
    .logical $8BDAB4

      .dsection Unsorted8BDAB4Section

    .here

    * = $0BDB54
    .logical $8BDB54

      .dsection Unsorted8BDB54Section

    .here

    * = $0BDBA2
    .logical $8BDBA2

      .dsection Unsorted8BDBA2Section

    .here

    * = $0BDC92
    .logical $8BDC92

      .dsection Unsorted8BDC92Section

    .here

    * = $0BDECD
    .logical $8BDECD

      .dsection Unsorted8BDECDSection

    .here

    * = $0CDC00
    .logical $8CDC00

      .dsection Table8CDC00Section

    .here

    * = $0CDC30
    .logical $8CDC30

      .dsection Table8CDC30Section

    .here

    * = $0CDE00
    .logical $8CDE00

      .dsection Table8CDE00Section

    .here

    * = $0CED00
    .logical $8CED00

      .dsection Unsorted8CED00Section

    .here

    * = $0CED4F
    .logical $8CED4F

      .dsection Unsorted8CED4FSection

    .here

    * = $0CEDD0
    .logical $8CEDD0

      .dsection Unsorted8CEDD0Section

    .here

    * = $0CF06A
    .logical $8CF06A

      .dsection Unsorted8CF06ASection

    .here

    * = $0D863F
    .logical $8D863F

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

    .here

    * = $0D9B65
    .logical $8D9B65

      .dsection Table8D9B65Section

    .here

    * = $0D9FB1
    .logical $8D9FB1

      dialogueGen1HomeCastleSeized .include "text/dialogue/General/Gen1HomeCastleSeized.dialogue.txt" ; 8D9FB1
      dialogueGen2HomeCastleSeized .include "text/dialogue/General/Gen2HomeCastleSeized.dialogue.txt" ; 8D9FED
      dialogueSigurdDeathReaction .include "text/dialogue/General/SigurdDeathReaction.dialogue.txt" ; 8DA022
      dialogueSeliphDeathReaction .include "text/dialogue/General/SeliphDeathReaction.dialogue.txt" ; 8DA047

      ; 8da06a

    .here

    * = $0DA06A
    .logical $8DA06A

      .dsection Unsorted8DA06ASection

    .here

    * = $0DA0C6
    .logical $8DA0C6

      .dsection Unsorted8DA0C6Section

    .here

    * = $0DA2AA
    .logical $8DA2AA

      .dsection Unsorted8DA2AASection
      .dsection Unsorted8DA34DSection

    .here

    * = $0DA3DE
    .logical $8DA3DE

      .dsection Unsorted8DA3DESection

    .here

    * = $0DA4B3
    .logical $8DA4B3

      .dsection Unsorted8DA4B3Section

    .here

    * = $0DA50F
    .logical $8DA50F

      .dsection Unsorted8DA50FSection

    .here

    * = $0DA624
    .logical $8DA624

      .dsection Unsorted8DA624Section

    .here

    * = $0DA755
    .logical $8DA755

      .dsection Unsorted8DA755Section

    .here

    * = $0DAD73
    .logical $8DAD73

      .dsection Unsorted8DAD73Section

    .here

    * = $0DAE85
    .logical $8DAE85

      .dsection Unsorted8DAE85Section

    .here

    * = $0DAEC2
    .logical $8DAEC2

      .dsection Unsorted8DAEC2Section
      .dsection Unsorted8DAF33Section

    .here

    * = $0DAFA5
    .logical $8DAFA5

      .dsection Unsorted8DAFA5Section

    .here

    * = $0DB06E
    .logical $8DB06E

      .dsection Unsorted8DB06ESection
      .dsection Unsorted8DB150Section
      .dsection Unsorted8DB1DDSection
      .dsection Unsorted8DB217Section
      .dsection Unsorted8DB252Section
      .dsection Unsorted8DB276Section

    .here

    * = $0DB2B8
    .logical $8DB2B8

      .dsection Unsorted8DB2B8Section

    .here

    * = $0DB4F1
    .logical $8DB4F1

      .dsection Unsorted8DB4F1Section

    .here

    * = $0DB4F6
    .logical $8DB4F6

      .dsection Unsorted8DB4F6Section

    .here

    * = $0DB53A
    .logical $8DB53A

      .dsection Unsorted8DB53ASection

    .here

    * = $0DB63D
    .logical $8DB63D

      .dsection EpilogueDialogueWorldMapCodeSection

      ; 8D/C964

    .here

    * = $0DD041
    .logical $8DD041

      .dsection Unsorted8DD041Section

    .here

    * = $0DDCA7
    .logical $8DDCA7

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

      ; 90e8ce

    .here

    * = $10EBCA
    .logical $90EBCA

      .dsection Unsorted90EBCASection

    .here

    * = $118000
    .logical $918000

      .dsection DialogueEngineSection

      ; 91/A3AB

    .here

    * = $11A3AB
    .logical $91A3AB

      .dsection Unsorted91A3ABSection

    .here

    * = $11A3D9
    .logical $91A3D9

      .dsection Unsorted91A3D9Section

    .here

    * = $11A3DE
    .logical $91A3DE

      .dsection Unsorted91A3DESection

    .here

    * = $11A40E
    .logical $91A40E

      .dsection EventScriptEngineSection
      .dsection FadeProcClearSection

      ; 91a7bc

    .here

    * = $11A7BC
    .logical $91A7BC

      .dsection Unsorted91A7BCSection

    .here

    * = $11A7DF
    .logical $91A7DF

      .dsection Unsorted91A7DFSection

    .here

    * = $11A80D
    .logical $91A80D

      .dsection Unsorted91A80DSection

    .here

    * = $11A863
    .logical $91A863

      .dsection DialogueEventCommandSection

      ; 91/A8E4

    .here

    * = $11A928
    .logical $91A928

      .dsection Unsorted91A928Section

    .here

    * = $11A984
    .logical $91A984

      .dsection DialogueUnknownSection

      ; 91/A9BB

    .here

    * = $11A9BB
    .logical $91A9BB

      .dsection Unsorted91A9BBSection

    .here

    * = $11AA15
    .logical $91AA15

      .dsection Unsorted91AA15Section

    .here

    * = $11AA6F
    .logical $91AA6F

      .dsection Unsorted91AA6FSection

    .here

    * = $11AAE2
    .logical $91AAE2

      .dsection Unsorted91AAE2Section

    .here

    * = $11AB91
    .logical $91AB91

      .dsection Unsorted91AB91Section

    .here

    * = $11ABEE
    .logical $91ABEE

      .dsection Unsorted91ABEESection

    .here

    * = $11AC79
    .logical $91AC79

      .dsection Unsorted91AC79Section

    .here

    * = $11AC96
    .logical $91AC96

      .dsection Unsorted91AC96Section

    .here

    * = $11ACE2
    .logical $91ACE2

      .dsection Unsorted91ACE2Section

    .here

    * = $11AD0B
    .logical $91AD0B

      .dsection DeathQuoteSection

      ; 91b11c

    .here

    * = $11B131
    .logical $91B131

      .dsection Unsorted91B131Section

    .here

    * = $11B164
    .logical $91B164

      .dsection Unsorted91B164Section

    .here

    * = $11B1FC
    .logical $91B1FC

      .dsection Unsorted91B1FCSection

    .here

    * = $11B2E5
    .logical $91B2E5

      .dsection Unsorted91B2E5Section

    .here

    * = $11B496
    .logical $91B496

      .dsection Unsorted91B496Section

    .here

    * = $11BA46
    .logical $91BA46

      .dsection Unsorted91BA46Section

    .here

    * = $11BA9C
    .logical $91BA9C

      .dsection EpilogueDialogueCodeSection

      ; 91bd42

    .here

    * = $11BD94
    .logical $91BD94

      .dsection ASMCStatUpDisplaySection

    .here

    * = $11BDD2
    .logical $91BDD2

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

    .here

    * = $11D616
    .logical $91D616

      .dsection Unsorted91D616Section

    .here

    * = $11D683
    .logical $91D683

      .dsection Unsorted91D683Section

    .here

    * = $11D69B
    .logical $91D69B

      .dsection Unsorted91D69BSection

    .here

    * = $11D6BB
    .logical $91D6BB

      .dsection Unsorted91D6BBSection

    .here

    * = $11D6EC
    .logical $91D6EC

      .dsection Unsorted91D6ECSection

    .here

    * = $11D7F8
    .logical $91D7F8

      .dsection Unsorted91D7F8Section

    .here

    * = $11D7F9
    .logical $91D7F9

      .dsection Unsorted91D7F9Section

    .here

    * = $11D839
    .logical $91D839

      .dsection Unsorted91D839Section

    .here

    * = $11D844
    .logical $91D844

      .dsection Unsorted91D844Section

    .here

    * = $11D8A0
    .logical $91D8A0

      .dsection Unsorted91D8A0Section

    .here

    * = $11D921
    .logical $91D921

      .dsection Unsorted91D921Section

    .here

    * = $11D9C5
    .logical $91D9C5

      .dsection SaveFileSection

      ; 91/D9FA

    .here

    * = $11D9FA
    .logical $91D9FA

      .dsection Unsorted91D9FASection

    .here

    * = $11DA25
    .logical $91DA25

      .dsection Unsorted91DA25Section

    .here

    * = $11DA64
    .logical $91DA64

      .dsection Unsorted91DA64Section

    .here

    * = $11DB17
    .logical $91DB17

      .dsection Unsorted91DB17Section

    .here

    * = $11DB6D
    .logical $91DB6D

      .dsection Unsorted91DB6DSection

    .here

    * = $11DBD0
    .logical $91DBD0

      .dsection Unsorted91DBD0Section

    .here

    * = $11DBEE
    .logical $91DBEE

      .dsection Unsorted91DBEESection

    .here

    * = $11DC6D
    .logical $91DC6D

      .dsection Unsorted91DC6DSection

    .here

    * = $11DC92
    .logical $91DC92

      .dsection Unsorted91DC92Section

    .here

    * = $11DCDE
    .logical $91DCDE

      .dsection Unsorted91DCDESection

    .here

    * = $11DCF8
    .logical $91DCF8

      .dsection Unsorted91DCF8Section

    .here

    * = $11DD9B
    .logical $91DD9B

      .dsection Unsorted91DD9BSection

    .here

    * = $11DDD5
    .logical $91DDD5

      .dsection Table91DDD5Section

    .here

    * = $11DDF1
    .logical $91DDF1

      .dsection Unsorted91DDF1Section

    .here

    * = $11DE4C
    .logical $91DE4C

      .dsection Unsorted91DE4CSection

    .here

    * = $11DEA1
    .logical $91DEA1

      .dsection Unsorted91DEA1Section

    .here

    * = $11DF32
    .logical $91DF32

      .dsection Unsorted91DF32Section

    .here

    * = $11DF6D
    .logical $91DF6D

      .dsection Unsorted91DF6DSection

    .here

    * = $11E07A
    .logical $91E07A

      .dsection Unsorted91E07ASection

    .here

    * = $11E095
    .logical $91E095

      .dsection Unsorted91E095Section

    .here

    * = $11E275
    .logical $91E275

      .dsection Unsorted91E275Section

    .here

    * = $11E2AA
    .logical $91E2AA

      .dsection Unsorted91E2AASection

    .here

    * = $11E397
    .logical $91E397

      .dsection Table91E397Section

    .here

    * = $11E405
    .logical $91E405

      .dsection Unsorted91E405Section

    .here

    * = $11E4B3
    .logical $91E4B3

      .dsection Table91E4B3Section

    .here

    * = $11E52B
    .logical $91E52B

      .dsection Unsorted91E52BSection

    .here

    * = $11E55A
    .logical $91E55A

      .dsection Unsorted91E55ASection

    .here

    * = $11E583
    .logical $91E583

      .dsection Unsorted91E583Section

    .here

    * = $11E793
    .logical $91E793

      .dsection Unsorted91E793Section

    .here

    * = $11E915
    .logical $91E915

      .dsection Unsorted91E915Section

    .here

    * = $11E92E
    .logical $91E92E

      .dsection Unsorted91E92ESection

    .here

    * = $11E932
    .logical $91E932

      .dsection Unsorted91E932Section

    .here

    * = $11E940
    .logical $91E940

      .dsection Unsorted91E940Section

    .here

    * = $11E95F
    .logical $91E95F

      .dsection SaveSlotSection

      ; 91/F748

    .here

    * = $11F748
    .logical $91F748

      .dsection Unsorted91F748Section

    .here

    * = $11F759
    .logical $91F759

      .dsection Unsorted91F759Section

    .here

    * = $11F813
    .logical $91F813

      .dsection Unsorted91F813Section

    .here

    * = $11F88A
    .logical $91F88A

      .dsection Unsorted91F88ASection

    .here

    * = $11F89F
    .logical $91F89F

      .dsection Unsorted91F89FSection

    .here

    * = $11F935
    .logical $91F935

      .dsection Unsorted91F935Section

    .here

    * = $11F959
    .logical $91F959

      .dsection Unsorted91F959Section

    .here

    * = $11F9AD
    .logical $91F9AD

      .dsection Table91F9ADSection

    .here

    * = $11F9DD
    .logical $91F9DD

      .dsection Unsorted91F9DDSection

    .here

    * = $11FA27
    .logical $91FA27

      .dsection Table91FA27Section

    .here

    * = $11FA57
    .logical $91FA57

      .dsection Unsorted91FA57Section

    .here

    * = $11FA9A
    .logical $91FA9A

      .dsection Unsorted91FA9ASection

    .here

    * = $128000
    .logical $928000

      g2bppDialogueFont .text ROM[$128000:$130000] ; 92/8000

    .here

    * = $158000
    .logical $958000

      .dsection Unsorted958000Section

    .here

    * = $1582D8
    .logical $9582D8

      .dsection Unsorted9582D8Section

    .here

    * = $1582F7
    .logical $9582F7

      .dsection Unsorted9582F7Section

    .here

    * = $158B07
    .logical $958B07

      .dsection Unsorted958B07Section

    .here

    * = $158CB9
    .logical $958CB9

      .dsection Unsorted958CB9Section

    .here

    * = $1590F2
    .logical $9590F2

      .dsection Unsorted9590F2Section

    .here

    * = $15938C
    .logical $95938C

      .dsection Unsorted95938CSection

    .here

    * = $1594F8
    .logical $9594F8

      .dsection Unsorted9594F8Section

    .here

    * = $1595CA
    .logical $9595CA

      .dsection Unsorted9595CASection

    .here

    * = $15968E
    .logical $95968E

      .dsection Unsorted95968ESection

    .here

    * = $1597FA
    .logical $9597FA

      .dsection Unsorted9597FASection

    .here

    * = $159890
    .logical $959890

      .dsection Table959890Section

    .here

    * = $159895
    .logical $959895

      .dsection Unsorted959895Section

    .here

    * = $1598E7
    .logical $9598E7

      .dsection Unsorted9598E7Section

    .here

    * = $159902
    .logical $959902

      .dsection Unsorted959902Section

    .here

    * = $1599E7
    .logical $9599E7

      .dsection Unsorted9599E7Section

    .here

    * = $159B49
    .logical $959B49

      .dsection Unsorted959B49Section

    .here

    * = $159B84
    .logical $959B84

      .dsection Unsorted959B84Section

    .here

    * = $159BC1
    .logical $959BC1

      .dsection Unsorted959BC1Section

    .here

    * = $159C14
    .logical $959C14

      .dsection Unsorted959C14Section

    .here

    * = $159C3E
    .logical $959C3E

      .dsection Unsorted959C3ESection

    .here

    * = $159C64
    .logical $959C64

      .dsection Unsorted959C64Section

    .here

    * = $159DAC
    .logical $959DAC

      .dsection Unsorted959DACSection

    .here

    * = $159F43
    .logical $959F43

      .dsection Unsorted959F43Section

    .here

    * = $15A086
    .logical $95A086

      .dsection Unsorted95A086Section

    .here

    * = $15A0F7
    .logical $95A0F7

      .dsection Unsorted95A0F7Section

    .here

    * = $15A114
    .logical $95A114

      .dsection Unsorted95A114Section

    .here

    * = $15A167
    .logical $95A167

      .dsection Unsorted95A167Section

    .here

    * = $15A3FB
    .logical $95A3FB

      .dsection DecompressSingleSection

    .here

    * = $15A414
    .logical $95A414

      .dsection Unsorted95A414Section

    .here

    * = $15A481
    .logical $95A481

      .dsection Unsorted95A481Section

    .here

    * = $15A53E
    .logical $95A53E

      .dsection Unsorted95A53ESection

    .here

    * = $15A65F
    .logical $95A65F

      .dsection Unsorted95A65FSection

    .here

    * = $15AAFF
    .logical $95AAFF

      .dsection Unsorted95AAFFSection

    .here

    * = $15ABBB
    .logical $95ABBB

      .dsection Unsorted95ABBBSection

    .here

    * = $15AC41
    .logical $95AC41

      .dsection Unsorted95AC41Section

    .here

    * = $15ACAE
    .logical $95ACAE

      .dsection Unsorted95ACAESection

    .here

    * = $15ACF6
    .logical $95ACF6

      .dsection Unsorted95ACF6Section

    .here

    * = $15ADD6
    .logical $95ADD6

      .dsection Unsorted95ADD6Section

    .here

    * = $15AE8B
    .logical $95AE8B

      .dsection Unsorted95AE8BSection

    .here

    * = $15AEA2
    .logical $95AEA2

      .dsection Unsorted95AEA2Section

    .here

    * = $15B184
    .logical $95B184

      .dsection Unsorted95B184Section

    .here

    * = $15B2DF
    .logical $95B2DF

      .dsection Unsorted95B2DFSection

    .here

    * = $15B362
    .logical $95B362

      .dsection Unsorted95B362Section

    .here

    * = $15B475
    .logical $95B475

      .dsection Unsorted95B475Section

    .here

    * = $15B530
    .logical $95B530

      .dsection Unsorted95B530Section

    .here

    * = $15B554
    .logical $95B554

      .dsection Unsorted95B554Section

    .here

    * = $15B5D0
    .logical $95B5D0

      .dsection Unsorted95B5D0Section

    .here

    * = $15B6D0
    .logical $95B6D0

      .dsection Unsorted95B6D0Section

    .here

    * = $15B7F8
    .logical $95B7F8

      .dsection Unsorted95B7F8Section

    .here

    * = $15B81B
    .logical $95B81B

      .dsection Unsorted95B81BSection

    .here

    * = $15B884
    .logical $95B884

      .dsection Unsorted95B884Section

    .here

    * = $15B96F
    .logical $95B96F

      .dsection Unsorted95B96FSection

    .here

    * = $15B993
    .logical $95B993

      .dsection Unsorted95B993Section

    .here

    * = $15C368
    .logical $95C368

      .dsection Unsorted95C368Section

    .here

    * = $15C43E
    .logical $95C43E

      .dsection Unsorted95C43ESection

    .here

    * = $15CA81
    .logical $95CA81

      .dsection Unsorted95CA81Section

    .here

    * = $15CA88
    .logical $95CA88

      .dsection Unsorted95CA88Section

    .here

    * = $15CEBF
    .logical $95CEBF

      .dsection Unsorted95CEBFSection

    .here

    * = $15CFA0
    .logical $95CFA0

      .dsection Unsorted95CFA0Section

    .here

    * = $15D078
    .logical $95D078

      .dsection Unsorted95D078Section

    .here

    * = $15D1C5
    .logical $95D1C5

      .dsection Unsorted95D1C5Section

    .here

    * = $15D2A4
    .logical $95D2A4

      .dsection Unsorted95D2A4Section

    .here

    * = $15DA0B
    .logical $95DA0B

      .dsection Unsorted95DA0BSection

    .here

    * = $15DA1D
    .logical $95DA1D

      .dsection Unsorted95DA1DSection

    .here

    * = $15DC54
    .logical $95DC54

      .dsection Unsorted95DC54Section

    .here

    * = $15DCA3
    .logical $95DCA3

      .dsection Unsorted95DCA3Section

    .here

    * = $15DE8C
    .logical $95DE8C

      .dsection Unsorted95DE8CSection

    .here

    * = $15E0C5
    .logical $95E0C5

      .dsection Unsorted95E0C5Section

    .here

    * = $15E1C9
    .logical $95E1C9

      .dsection Unsorted95E1C9Section

    .here

    * = $15E372
    .logical $95E372

      .dsection Unsorted95E372Section

    .here

    * = $15E3DF
    .logical $95E3DF

      .dsection Unsorted95E3DFSection

    .here

    * = $15E6AA
    .logical $95E6AA

      .dsection Unsorted95E6AASection

    .here

    * = $15E7B3
    .logical $95E7B3

      .dsection Unsorted95E7B3Section

    .here

    * = $15E834
    .logical $95E834

      .dsection Unsorted95E834Section

    .here

    * = $15E888
    .logical $95E888

      .dsection Unsorted95E888Section

    .here

    * = $15EA47
    .logical $95EA47

      .dsection Unsorted95EA47Section

    .here

    * = $15ED4E
    .logical $95ED4E

      .dsection Unsorted95ED4ESection

    .here

    * = $15EE73
    .logical $95EE73

      .dsection Unsorted95EE73Section

    .here

    * = $15EF54
    .logical $95EF54

      .dsection Unsorted95EF54Section

    .here

    * = $15F0E9
    .logical $95F0E9

      .dsection Unsorted95F0E9Section

    .here

    * = $15F12A
    .logical $95F12A

      .dsection Unsorted95F12ASection

    .here

    * = $15F248
    .logical $95F248

      .dsection Unsorted95F248Section

    .here

    * = $15F256
    .logical $95F256

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

    .here

    * = $15F7F7
    .logical $95F7F7

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

    * = $168008
    .logical $968008

      .dsection Unsorted968008Section

    .here

    * = $168017
    .logical $968017

      .dsection Unsorted968017Section

    .here

    * = $168058
    .logical $968058

      .dsection Unsorted968058Section

    .here

    * = $168080
    .logical $968080

      .dsection Unsorted968080Section

    .here

    * = $16809D
    .logical $96809D

      .dsection Unsorted96809DSection

    .here

    * = $1680AC
    .logical $9680AC

      .dsection Unsorted9680ACSection

    .here

    * = $1680BB
    .logical $9680BB

      .dsection Unsorted9680BBSection

    .here

    * = $1680C2
    .logical $9680C2

      .dsection Unsorted9680C2Section

    .here

    * = $16881F
    .logical $96881F

      .dsection Unsorted96881FSection

    .here

    * = $16890E
    .logical $96890E

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

    .here

    * = $16941C
    .logical $96941C

      .dsection Unsorted96941CSection

    .here

    * = $16947D
    .logical $96947D

      .dsection Unsorted96947DSection

    .here

    * = $1694C7
    .logical $9694C7

      .dsection Unsorted9694C7Section

    .here

    * = $16957D
    .logical $96957D

      .dsection Unsorted96957DSection

    .here

    * = $169603
    .logical $969603

      .dsection Unsorted969603Section

    .here

    * = $169617
    .logical $969617

      .dsection Unsorted969617Section

    .here

    * = $16961F
    .logical $96961F

      .dsection Unsorted96961FSection

    .here

    * = $169665
    .logical $969665

      .dsection Unsorted969665Section

    .here

    * = $1696AA
    .logical $9696AA

      .dsection Unsorted9696AASection

    .here

    * = $1697FA
    .logical $9697FA

      .dsection Unsorted9697FASection

    .here

    * = $169861
    .logical $969861

      .dsection Unsorted969861Section

    .here

    * = $169872
    .logical $969872

      .dsection Unsorted969872Section

    .here

    * = $16989E
    .logical $96989E

      .dsection Unsorted96989ESection

    .here

    * = $16994B
    .logical $96994B

      .dsection Unsorted96994BSection

    .here

    * = $1699DD
    .logical $9699DD

      .dsection Unsorted9699DDSection

    .here

    * = $169C63
    .logical $969C63

      .dsection Unsorted969C63Section

    .here

    * = $169EF9
    .logical $969EF9

      .dsection Unsorted969EF9Section

    .here

    * = $169F7D
    .logical $969F7D

      .dsection Unsorted969F7DSection

    .here

    * = $16A05C
    .logical $96A05C

      .dsection Unsorted96A05CSection

    .here

    * = $16A20E
    .logical $96A20E

      .dsection Unsorted96A20ESection

    .here

    * = $16A28B
    .logical $96A28B

      .dsection BattleSceneScriptSection

    .here


    * = $16A4B2
    .logical $96A4B2

      .dsection Unsorted96A4B2Section

    .here

    * = $16A4FC
    .logical $96A4FC

      .dsection Unsorted96A4FCSection

    .here

    * = $16A532
    .logical $96A532

      .dsection Unsorted96A532Section

    .here

    * = $16ABF6
    .logical $96ABF6

      .dsection BattleSceneCommand96ABF6Section

    .here

    * = $16AC1F
    .logical $96AC1F

      .dsection Unsorted96AC1FSection

    .here

    * = $16ACAB
    .logical $96ACAB

      .dsection Unsorted96ACABSection

    .here

    * = $16AD07
    .logical $96AD07

      .dsection Unsorted96AD07Section

    .here

    * = $16AD39
    .logical $96AD39

      .dsection Unsorted96AD39Section

    .here

    * = $16ADE9
    .logical $96ADE9

      .dsection Unsorted96ADE9Section

    .here

    * = $16B0E1
    .logical $96B0E1

      .dsection Unsorted96B0E1Section

    .here

    * = $16B852
    .logical $96B852

      .dsection Unsorted96B852Section

    .here

    * = $16B945
    .logical $96B945

      .dsection Unsorted96B945Section

    .here

    * = $16BA68
    .logical $96BA68

      .dsection BattleSceneCommand96BA68Section

    .here

    * = $16BB0C
    .logical $96BB0C

      .dsection Unsorted96BB0CSection

    .here

    * = $16BB70
    .logical $96BB70

      .dsection BattleSceneCommand96BB70Section

    .here

    * = $16BBC2
    .logical $96BBC2

      .dsection Unsorted96BBC2Section

    .here

    * = $16BBE2
    .logical $96BBE2

      .dsection Unsorted96BBE2Section

    .here

    * = $16BC4C
    .logical $96BC4C

      .dsection Unsorted96BC4CSection

    .here

    * = $16BCAF
    .logical $96BCAF

      .dsection BattleSceneCommand96BCAFSection

    .here

    * = $16BCEC
    .logical $96BCEC

      .dsection Unsorted96BCECSection

    .here

    * = $16BCF1
    .logical $96BCF1

      .dsection Unsorted96BCF1Section

    .here

    * = $16BD1A
    .logical $96BD1A

      .dsection Unsorted96BD1ASection

    .here

    * = $16BD74
    .logical $96BD74

      .dsection Unsorted96BD74Section

    .here

    * = $16BE28
    .logical $96BE28

      .dsection Unsorted96BE28Section

    .here

    * = $16BFE5
    .logical $96BFE5

      .dsection Unsorted96BFE5Section

    .here

    * = $16C7DB
    .logical $96C7DB

      .dsection Unsorted96C7DBSection

    .here

    * = $16C8A1
    .logical $96C8A1

      .dsection Unsorted96C8A1Section

    .here

    * = $16C942
    .logical $96C942

      .dsection Unsorted96C942Section

    .here

    * = $16C9AD
    .logical $96C9AD

      .dsection Unsorted96C9ADSection

    .here

    * = $16C9D9
    .logical $96C9D9

      .dsection Unsorted96C9D9Section

    .here

    * = $16CB44
    .logical $96CB44

      .dsection Unsorted96CB44Section

    .here

    * = $16CD23
    .logical $96CD23

      .dsection Unsorted96CD23Section

    .here

    * = $16CDB7
    .logical $96CDB7

      .dsection BattleSceneCommand96CDB7Section

    .here

    * = $16CECE
    .logical $96CECE

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

    .here

    * = $16D5DB
    .logical $96D5DB

      .dsection Unsorted96D5DBSection

    .here

    * = $16D659
    .logical $96D659

      .dsection Unsorted96D659Section

    .here

    * = $16D67B
    .logical $96D67B

      .dsection Unsorted96D67BSection

    .here

    * = $16D695
    .logical $96D695

      .dsection Unsorted96D695Section

    .here

    * = $16D774
    .logical $96D774

      .dsection Unsorted96D774Section

    .here

    * = $16D912
    .logical $96D912

      .dsection Unsorted96D912Section

    .here

    * = $16D95E
    .logical $96D95E

      .dsection Unsorted96D95ESection

    .here

    * = $16DB20
    .logical $96DB20

      .dsection Unsorted96DB20Section

    .here

    * = $16DB58
    .logical $96DB58

      .dsection Unsorted96DB58Section

    .here

    * = $16DB94
    .logical $96DB94

      .dsection Unsorted96DB94Section

    .here

    * = $16DC7C
    .logical $96DC7C

      .dsection Unsorted96DC7CSection

    .here

    * = $16DD39
    .logical $96DD39

      .dsection Unsorted96DD39Section

    .here

    * = $16DD6E
    .logical $96DD6E

      .dsection Unsorted96DD6ESection

    .here

    * = $16DEC0
    .logical $96DEC0

      .dsection Unsorted96DEC0Section

    .here

    * = $16DFBB
    .logical $96DFBB

      .dsection Unsorted96DFBBSection

    .here

    * = $16E01F
    .logical $96E01F

      .dsection Unsorted96E01FSection

    .here

    * = $16E50E
    .logical $96E50E

      .dsection Unsorted96E50ESection

    .here

    * = $16E612
    .logical $96E612

      .dsection Unsorted96E612Section

    .here

    * = $16E716
    .logical $96E716

      .dsection Unsorted96E716Section

    .here

    * = $16E803
    .logical $96E803

      .dsection Unsorted96E803Section

    .here

    * = $16E9B8
    .logical $96E9B8

      .dsection Unsorted96E9B8Section

    .here

    * = $16EA99
    .logical $96EA99

      .dsection Unsorted96EA99Section

    .here

    * = $16EBE3
    .logical $96EBE3

      .dsection Unsorted96EBE3Section

    .here

    * = $16EC4A
    .logical $96EC4A

      .dsection BattleSceneCommand96EC4ASection

    .here

    * = $16EC91
    .logical $96EC91

      .dsection Unsorted96EC91Section

    .here

    * = $16ECAB
    .logical $96ECAB

      .dsection Unsorted96ECABSection

    .here

    * = $16EDC0
    .logical $96EDC0

      .dsection Unsorted96EDC0Section

    .here

    * = $16EE32
    .logical $96EE32

      .dsection Unsorted96EE32Section

    .here

    * = $16EE8A
    .logical $96EE8A

      .dsection Unsorted96EE8ASection

    .here

    * = $16EE95
    .logical $96EE95

      .dsection Unsorted96EE95Section

    .here

    * = $16F1C2
    .logical $96F1C2

      .dsection BattleSceneCommand96F1C2Section

    .here

    * = $16F275
    .logical $96F275

      .dsection Unsorted96F275Section

    .here

    * = $16F28D
    .logical $96F28D

      .dsection Unsorted96F28DSection

    .here

    * = $16F315
    .logical $96F315

      .dsection Unsorted96F315Section

    .here

    * = $16F558
    .logical $96F558

      .dsection Unsorted96F558Section

    .here

    * = $16F676
    .logical $96F676

      .dsection Unsorted96F676Section

    .here

    * = $16F697
    .logical $96F697

      .dsection Unsorted96F697Section

    .here

    * = $16F7A8
    .logical $96F7A8

      .dsection Unsorted96F7A8Section

    .here

    * = $16F7D4
    .logical $96F7D4

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

    .here

    * = $178000
    .logical $978000

      .dsection Unsorted978000Section

    .here

    * = $17802C
    .logical $97802C

      .dsection Unsorted97802CSection

    .here

    * = $198D84
    .logical $998D84

      .dsection BattleBannerTableSection

      ; 99/8DD8

    .here

    * = $1BDC24
    .logical $9BDC24

      .dsection Unsorted9BDC24Section

    .here

    * = $1BDFAA
    .logical $9BDFAA

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

    .here

    * = $1BEAB1
    .logical $9BEAB1

      .dsection Unsorted9BEAB1Section

    .here

    * = $1BEAE8
    .logical $9BEAE8

      .dsection Unsorted9BEAE8Section

    .here

    * = $1BEEB4
    .logical $9BEEB4

      .dsection Unsorted9BEEB4Section

    .here

    * = $1BF179
    .logical $9BF179

      .dsection Unsorted9BF179Section

    .here

    * = $1BF23C
    .logical $9BF23C

      .dsection Unsorted9BF23CSection

    .here

    * = $1BF297
    .logical $9BF297

      .dsection Unsorted9BF297Section

    .here

    * = $1BF3F3
    .logical $9BF3F3

      .dsection Unsorted9BF3F3Section

    .here

    * = $1BF651
    .logical $9BF651

      .dsection Unsorted9BF651Section

    .here

    * = $1BF6B1
    .logical $9BF6B1

      .dsection Unsorted9BF6B1Section

    .here

    * = $1BF726
    .logical $9BF726

      .dsection Unsorted9BF726Section

    .here

    * = $1BFA58
    .logical $9BFA58

      .dsection Unsorted9BFA58Section

    .here

    * = $1BFA6E
    .logical $9BFA6E

      .dsection Unsorted9BFA6ESection

    .here

    * = $1BFA85
    .logical $9BFA85

      .dsection Unsorted9BFA85Section

    .here

    * = $1BFAA1
    .logical $9BFAA1

      .dsection Unsorted9BFAA1Section

    .here

    * = $1BFAB7
    .logical $9BFAB7

      .dsection Unsorted9BFAB7Section

    .here

    * = $1BFB5D
    .logical $9BFB5D

      .dsection Unsorted9BFB5DSection

    .here

    * = $1BFB7E
    .logical $9BFB7E

      .dsection Unsorted9BFB7ESection

    .here

    * = $1BFB9F
    .logical $9BFB9F

      .dsection Unsorted9BFB9FSection

    .here

    * = $1BFBA9
    .logical $9BFBA9

      .dsection Unsorted9BFBA9Section

    .here

    * = $1BFBC0
    .logical $9BFBC0

      .dsection Unsorted9BFBC0Section

    .here

    * = $1BFC8D
    .logical $9BFC8D

      .dsection Unsorted9BFC8DSection

    .here

    * = $1BFD71
    .logical $9BFD71

      .dsection Unsorted9BFD71Section

    .here

    * = $1CD95E
    .logical $9CD95E

      g4bppcBattleBannerLeonster   .text ROM[$1CD95E:$1CDA67] ; 9CD95E
      g4bppcBattleBannerDozel      .text ROM[$1CDA67:$1CDBB8] ; 9CDA67
      g4bppcBattleBannerYngvi      .text ROM[$1CDBB8:$1CDCEF] ; 9CDBB8
      g4bppcBattleBannerChalphy    .text ROM[$1CDCEF:$1CDE2B] ; 9CDCEF
      g4bppcBattleBannerNordion    .text ROM[$1CDE2B:$1CDF6F] ; 9CDE2B
      g4bppcBattleBannerIsaach     .text ROM[$1CDF6F:$1CE0C0] ; 9CDF6F
      g4bppcBattleBannerThracia    .text ROM[$1CE0C0:$1CE20F] ; 9CE0C0
      g4bppcBattleBannerVelthomer  .text ROM[$1CE20F:$1CE367] ; 9CE20F
      g4bppcBattleBannerFreege     .text ROM[$1CE367:$1CE494] ; 9CE367
      g4bppcBattleBannerSilesse    .text ROM[$1CE494:$1CE5D0] ; 9CE494
      g4bppcBattleBannerEdda       .text ROM[$1CE5D0:$1CE706] ; 9CE5D0
      g4bppcBattleBannerBelhalla   .text ROM[$1CE706:$1CE845] ; 9CE706
      g4bppcBattleBannerLoptr      .text ROM[$1CE845:$1CE98C] ; 9CE845
      g4bppcBattleBannerDefault    .text ROM[$1CE98C:$1CEAEE] ; 9CE98C

      ; Compressed. The original notes call these two tilemaps.
      ; rlUnknown91AFC2 decompresses the first along with a banner.
      aUnknown9CEAEE               .text ROM[$1CEAEE:$1CEBED] ; 9CEAEE
      aUnknown9CEBED               .text ROM[$1CEBED:$1CECA6] ; 9CEBED

      ; 9C/ECA6

    .here

    * = $1D7EAE
    .logical $DD7EAE

      .dsection TableDD7EAESection
      .dsection TableDD7F6ESection
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

    * = $1E8000
    .logical $9E8000

      .dsection Unsorted9E8000Section

    .here

    * = $1E800C
    .logical $9E800C

      .dsection Unsorted9E800CSection

    .here

    * = $1E805E
    .logical $9E805E

      .dsection Unsorted9E805ESection

    .here

    * = $1E80CB
    .logical $9E80CB

      .dsection Table9E80CBSection

    .here

    * = $1E80F2
    .logical $9E80F2

      .dsection Unsorted9E80F2Section

    .here

    * = $1E811F
    .logical $9E811F

      .dsection Unsorted9E811FSection

    .here

    * = $1E826B
    .logical $9E826B

      .dsection Table9E826BSection

    .here

    * = $1E8271
    .logical $9E8271

      .dsection Unsorted9E8271Section

    .here

    * = $1E82AA
    .logical $9E82AA

      .dsection Unsorted9E82AASection

    .here

    * = $1E832C
    .logical $9E832C

      .dsection Unsorted9E832CSection

    .here

    * = $1E838B
    .logical $9E838B

      .dsection Unsorted9E838BSection

    .here

    * = $1E85A4
    .logical $9E85A4

      .dsection Unsorted9E85A4Section

    .here

    * = $1E85DF
    .logical $9E85DF

      .dsection Unsorted9E85DFSection

    .here

    * = $1E86CF
    .logical $9E86CF

      .dsection Unsorted9E86CFSection

    .here

    * = $1E8792
    .logical $9E8792

      .dsection Table9E8792Section
      .dsection Table9E879CSection

    .here

    * = $1E87A4
    .logical $9E87A4

      .dsection Unsorted9E87A4Section

    .here

    * = $1E87CA
    .logical $9E87CA

      .dsection Unsorted9E87CASection

    .here

    * = $1E8863
    .logical $9E8863

      .dsection Table9E8863Section

    .here

    * = $1E8867
    .logical $9E8867

      .dsection Unsorted9E8867Section

    .here

    * = $1E88CE
    .logical $9E88CE

      .dsection Unsorted9E88CESection

    .here

    * = $1E88F4
    .logical $9E88F4

      .dsection Unsorted9E88F4Section

    .here

    * = $1E88FA
    .logical $9E88FA

      .dsection Unsorted9E88FASection

    .here

    * = $1E89F1
    .logical $9E89F1

      .dsection Unsorted9E89F1Section

    .here

    * = $1E8D25
    .logical $9E8D25

      .dsection Unsorted9E8D25Section

    .here

    * = $1E8D6C
    .logical $9E8D6C

      .dsection Unsorted9E8D6CSection

    .here

    * = $1E8EC4
    .logical $9E8EC4

      .dsection Table9E8EC4Section
      .dsection Table9E8F3ESection

    .here

    * = $1E8F6A
    .logical $9E8F6A

      .dsection Unsorted9E8F6ASection

    .here

    * = $1E8FB2
    .logical $9E8FB2

      .dsection Table9E8FB2Section

    .here

    * = $1E8FB3
    .logical $9E8FB3

      .dsection Unsorted9E8FB3Section

    .here

    * = $1E9123
    .logical $9E9123

      .dsection Table9E9123Section
      .dsection Table9E914BSection

    .here

    * = $1E915B
    .logical $9E915B

      .dsection Unsorted9E915BSection

    .here

    * = $1E9320
    .logical $9E9320

      .dsection Unsorted9E9320Section

    .here

    * = $1E9342
    .logical $9E9342

      .dsection Unsorted9E9342Section

    .here

    * = $1E9480
    .logical $9E9480

      .dsection Table9E9480Section
      .dsection Table9E94B6Section
      .dsection Table9E94EASection
      .dsection Table9E9504Section

    .here

    * = $1E950A
    .logical $9E950A

      .dsection Unsorted9E950ASection

    .here

    * = $1E964C
    .logical $9E964C

      .dsection Table9E964CSection

    .here

    * = $1E965E
    .logical $9E965E

      .dsection Unsorted9E965ESection

    .here

    * = $1E973D
    .logical $9E973D

      .dsection Table9E973DSection
      .dsection Table9E9787Section

    .here

    * = $1E978D
    .logical $9E978D

      .dsection Unsorted9E978DSection

    .here

    * = $1E98C4
    .logical $9E98C4

      .dsection Unsorted9E98C4Section

    .here

    * = $1E9928
    .logical $9E9928

      .dsection Unsorted9E9928Section

    .here

    * = $1E9967
    .logical $9E9967

      .dsection Unsorted9E9967Section

    .here

    * = $1E99A4
    .logical $9E99A4

      .dsection Unsorted9E99A4Section

    .here

    * = $1E99F7
    .logical $9E99F7

      .dsection Unsorted9E99F7Section

    .here

    * = $1E9A34
    .logical $9E9A34

      .dsection Unsorted9E9A34Section

    .here

    * = $1E9A43
    .logical $9E9A43

      .dsection ProcScript9E9A43Section

    .here

    * = $1E9A4B
    .logical $9E9A4B

      .dsection Unsorted9E9A4BSection

    .here

    * = $1E9B50
    .logical $9E9B50

      .dsection Table9E9B50Section

    .here

    * = $1E9B68
    .logical $9E9B68

      .dsection Unsorted9E9B68Section

    .here

    * = $1E9B82
    .logical $9E9B82

      .dsection Unsorted9E9B82Section

    .here

    * = $1E9BE1
    .logical $9E9BE1

      .dsection ProcScript9E9BE1Section

    .here

    * = $1E9C70
    .logical $9E9C70

      .dsection Unsorted9E9C70Section

    .here

    * = $1E9CB9
    .logical $9E9CB9

      .dsection Unsorted9E9CB9Section

    .here

    * = $1E9D3B
    .logical $9E9D3B

      .dsection Unsorted9E9D3BSection

    .here

    * = $1E9D76
    .logical $9E9D76

      .dsection Unsorted9E9D76Section

    .here

    * = $1E9DB9
    .logical $9E9DB9

      .dsection Table9E9DB9Section

    .here

    * = $1E9DD9
    .logical $9E9DD9

      .dsection Unsorted9E9DD9Section

    .here

    * = $1E9E61
    .logical $9E9E61

      .dsection Unsorted9E9E61Section

    .here

    * = $1E9F26
    .logical $9E9F26

      .dsection Unsorted9E9F26Section

    .here

    * = $1EA085
    .logical $9EA085

      .dsection Table9EA085Section

    .here

    * = $1EA096
    .logical $9EA096

      .dsection Unsorted9EA096Section

    .here

    * = $1EA1D7
    .logical $9EA1D7

      .dsection Unsorted9EA1D7Section

    .here

    * = $1EA238
    .logical $9EA238

      .dsection Unsorted9EA238Section

    .here

    * = $1EA334
    .logical $9EA334

      .dsection ProcScript9EA334Section

    .here

    * = $1EA33C
    .logical $9EA33C

      .dsection Unsorted9EA33CSection

    .here

    * = $1EA404
    .logical $9EA404

      .dsection ProcScript9EA404Section

    .here

    * = $1EA417
    .logical $9EA417

      .dsection Unsorted9EA417Section

    .here

    * = $1EA50F
    .logical $9EA50F

      .dsection Table9EA50FSection

    .here

    * = $1EA67C
    .logical $9EA67C

      .dsection Unsorted9EA67CSection

    .here

    * = $1EA84A
    .logical $9EA84A

      .dsection Table9EA84ASection

    .here

    * = $1EA850
    .logical $9EA850

      .dsection Unsorted9EA850Section

    .here

    * = $1EA873
    .logical $9EA873

      .dsection Table9EA873Section

    .here

    * = $1EA89F
    .logical $9EA89F

      .dsection Unsorted9EA89FSection

    .here

    * = $1EAA61
    .logical $9EAA61

      .dsection Table9EAA61Section

    .here

    * = $1EAB21
    .logical $9EAB21

      .dsection Unsorted9EAB21Section

    .here

    * = $1EABBD
    .logical $9EABBD

      .dsection Table9EABBDSection

    .here

    * = $1EABE9
    .logical $9EABE9

      .dsection Unsorted9EABE9Section

    .here

    * = $1EAC49
    .logical $9EAC49

      .dsection Unsorted9EAC49Section

    .here

    * = $1EAC5A
    .logical $9EAC5A

      .dsection Unsorted9EAC5ASection

    .here

    * = $1EACAF
    .logical $9EACAF

      .dsection Unsorted9EACAFSection

    .here

    * = $1EAD7B
    .logical $9EAD7B

      .dsection Unsorted9EAD7BSection

    .here

    * = $1EADD1
    .logical $9EADD1

      .dsection Unsorted9EADD1Section

    .here

    * = $1EAEAF
    .logical $9EAEAF

      .dsection Table9EAEAFSection

    .here

    * = $1EAECF
    .logical $9EAECF

      .dsection Unsorted9EAECFSection

    .here

    * = $1EAF24
    .logical $9EAF24

      .dsection Table9EAF24Section

    .here

    * = $1EAF44
    .logical $9EAF44

      .dsection Unsorted9EAF44Section

    .here

    * = $1EAF98
    .logical $9EAF98

      .dsection ProcScript9EAF98Section

    .here

    * = $1EAFA0
    .logical $9EAFA0

      .dsection Unsorted9EAFA0Section

    .here

    * = $1EAFF8
    .logical $9EAFF8

      .dsection ProcScript9EAFF8Section

    .here

    * = $1EB01B
    .logical $9EB01B

      .dsection Unsorted9EB01BSection

    .here

    * = $1EB0EC
    .logical $9EB0EC

      .dsection Table9EB0ECSection

    .here

    * = $1EB0F2
    .logical $9EB0F2

      .dsection Unsorted9EB0F2Section

    .here

    * = $1EB15A
    .logical $9EB15A

      .dsection Table9EB15ASection

    .here

    * = $1EB160
    .logical $9EB160

      .dsection Unsorted9EB160Section

    .here

    * = $1EB2BA
    .logical $9EB2BA

      .dsection Unsorted9EB2BASection

    .here

    * = $1EB345
    .logical $9EB345

      .dsection Unsorted9EB345Section

    .here

    * = $1EB3DE
    .logical $9EB3DE

      .dsection Unsorted9EB3DESection

    .here

    * = $1EB491
    .logical $9EB491

      .dsection Unsorted9EB491Section

    .here

    * = $1EB4BB
    .logical $9EB4BB

      .dsection Unsorted9EB4BBSection

    .here

    * = $1EB4C9
    .logical $9EB4C9

      .dsection Table9EB4C9Section
      .dsection Table9EB4CDSection
      .dsection Table9EB4D7Section
      .dsection Table9EB4DBSection
      .dsection Table9EB4DFSection

    .here

    * = $1EB50D
    .logical $9EB50D

      .dsection BattleMapSpriteDataSection

    .here

    * = $1EC70B
    .logical $9EC70B

      .dsection Unsorted9EC70BSection

    .here

    * = $1EC776
    .logical $9EC776

      .dsection Unsorted9EC776Section

    .here

    * = $1EC79B
    .logical $9EC79B

      .dsection Unsorted9EC79BSection

    .here

    * = $1EC7B3
    .logical $9EC7B3

      .dsection Unsorted9EC7B3Section

    .here

    * = $1EC899
    .logical $9EC899

      .dsection Unsorted9EC899Section

    .here

    * = $1EC8B3
    .logical $9EC8B3

      .dsection Unsorted9EC8B3Section

    .here

    * = $1EC91A
    .logical $9EC91A

      .dsection Unsorted9EC91ASection

    .here

    * = $1EC98A
    .logical $9EC98A

      .dsection Unsorted9EC98ASection

    .here

    * = $1EC9FD
    .logical $9EC9FD

      .dsection Unsorted9EC9FDSection

    .here

    * = $1ECABB
    .logical $9ECABB

      .dsection Unsorted9ECABBSection

    .here

    * = $1ECAD2
    .logical $9ECAD2

      .dsection ProcScript9ECAD2Section

    .here

    * = $1ECEA0
    .logical $9ECEA0

      .dsection Unsorted9ECEA0Section

    .here

    * = $1ECEDD
    .logical $9ECEDD

      .dsection ProcScript9ECEDDSection

    .here

    * = $1ECEE5
    .logical $9ECEE5

      .dsection Unsorted9ECEE5Section

    .here

    * = $1ECF72
    .logical $9ECF72

      .dsection Table9ECF72Section

    .here

    * = $1ECF7A
    .logical $9ECF7A

      .dsection Unsorted9ECF7ASection

    .here

    * = $1ECF7B
    .logical $9ECF7B

      .dsection ProcScript9ECF7BSection

    .here

    * = $1ECFCD
    .logical $9ECFCD

      .dsection Unsorted9ECFCDSection

    .here

    * = $1ED07A
    .logical $9ED07A

      .dsection Unsorted9ED07ASection

    .here

    * = $1ED089
    .logical $9ED089

      .dsection Unsorted9ED089Section

    .here

    * = $1ED1A1
    .logical $9ED1A1

      .dsection Unsorted9ED1A1Section

    .here

    * = $1ED2B5
    .logical $9ED2B5

      .dsection Unsorted9ED2B5Section

    .here

    * = $1ED337
    .logical $9ED337

      .dsection Unsorted9ED337Section

    .here

    * = $1ED372
    .logical $9ED372

      .dsection Unsorted9ED372Section

    .here

    * = $1ED3C1
    .logical $9ED3C1

      .dsection Unsorted9ED3C1Section

    .here

    * = $1ED401
    .logical $9ED401

      .dsection Unsorted9ED401Section

    .here

    * = $1ED42A
    .logical $9ED42A

      .dsection Unsorted9ED42ASection

    .here

    * = $1ED449
    .logical $9ED449

      .dsection Unsorted9ED449Section

    .here

    * = $1ED535
    .logical $9ED535

      .dsection Unsorted9ED535Section

    .here

    * = $1ED609
    .logical $9ED609

      .dsection Unsorted9ED609Section

    .here

    * = $1ED68B
    .logical $9ED68B

      .dsection Unsorted9ED68BSection

    .here

    * = $1ED6BA
    .logical $9ED6BA

      .dsection Unsorted9ED6BASection

    .here

    * = $1ED742
    .logical $9ED742

      .dsection Unsorted9ED742Section

    .here

    * = $1ED78B
    .logical $9ED78B

      .dsection ProcScript9ED78BSection

    .here

    * = $1ED793
    .logical $9ED793

      .dsection Unsorted9ED793Section

    .here

    * = $1ED79F
    .logical $9ED79F

      .dsection ProcScript9ED79FSection

    .here

    * = $1ED7B7
    .logical $9ED7B7

      .dsection Unsorted9ED7B7Section

    .here

    * = $1ED7E8
    .logical $9ED7E8

      .dsection Table9ED7E8Section

    .here

    * = $1ED808
    .logical $9ED808

      .dsection Unsorted9ED808Section

    .here

    * = $1EDAE7
    .logical $9EDAE7

      .dsection Unsorted9EDAE7Section

    .here

    * = $1EDAF6
    .logical $9EDAF6

      .dsection ProcScript9EDAF6Section

    .here

    * = $1EDAFE
    .logical $9EDAFE

      .dsection Unsorted9EDAFESection

    .here

    * = $1EDC15
    .logical $9EDC15

      .dsection ProcScript9EDC15Section

    .here

    * = $1EDCD2
    .logical $9EDCD2

      .dsection Unsorted9EDCD2Section

    .here

    * = $1EDDC8
    .logical $9EDDC8

      .dsection Table9EDDC8Section

    .here

    * = $1EDDE8
    .logical $9EDDE8

      .dsection Unsorted9EDDE8Section

    .here

    * = $1EDF7F
    .logical $9EDF7F

      .dsection Unsorted9EDF7FSection

    .here

    * = $1EDF8E
    .logical $9EDF8E

      .dsection ProcScript9EDF8ESection

    .here

    * = $1EDF96
    .logical $9EDF96

      .dsection Unsorted9EDF96Section

    .here

    * = $1EDFF8
    .logical $9EDFF8

      .dsection Unsorted9EDFF8Section

    .here

    * = $1EE011
    .logical $9EE011

      .dsection ProcScript9EE011Section

    .here

    * = $1EE021
    .logical $9EE021

      .dsection Unsorted9EE021Section

    .here

    * = $1EE02D
    .logical $9EE02D

      .dsection Unsorted9EE02DSection

    .here

    * = $1EE03C
    .logical $9EE03C

      .dsection ProcScript9EE03CSection

    .here

    * = $1EE044
    .logical $9EE044

      .dsection Unsorted9EE044Section

    .here

    * = $1EE092
    .logical $9EE092

      .dsection ProcScript9EE092Section

    .here

    * = $1EE0F1
    .logical $9EE0F1

      .dsection Unsorted9EE0F1Section

    .here

    * = $1EE11B
    .logical $9EE11B

      .dsection Table9EE11BSection

    .here

    * = $1EE127
    .logical $9EE127

      .dsection Unsorted9EE127Section

    .here

    * = $1EE228
    .logical $9EE228

      .dsection Unsorted9EE228Section

    .here

    * = $1EE2B2
    .logical $9EE2B2

      .dsection Table9EE2B2Section

    .here

    * = $1EE2BE
    .logical $9EE2BE

      .dsection Unsorted9EE2BESection

    .here

    * = $1EEC95
    .logical $9EEC95

      .dsection Unsorted9EEC95Section

    .here

    * = $1EECA4
    .logical $9EECA4

      .dsection ProcScript9EECA4Section

    .here

    * = $1EECAC
    .logical $9EECAC

      .dsection Unsorted9EECACSection

    .here

    * = $1EED31
    .logical $9EED31

      .dsection ProcScript9EED31Section

    .here

    * = $1EED7C
    .logical $9EED7C

      .dsection Unsorted9EED7CSection

    .here

    * = $1EEDB5
    .logical $9EEDB5

      .dsection Unsorted9EEDB5Section

    .here

    * = $1EEFF1
    .logical $9EEFF1

      .dsection Unsorted9EEFF1Section

    .here

    * = $1EF1B5
    .logical $9EF1B5

      .dsection Unsorted9EF1B5Section

    .here

    * = $1EF1FA
    .logical $9EF1FA

      .dsection Unsorted9EF1FASection

    .here

    * = $1EF37F
    .logical $9EF37F

      .dsection Unsorted9EF37FSection

    .here

    * = $1EF55B
    .logical $9EF55B

      .dsection Unsorted9EF55BSection

    .here

    * = $1EF5D0
    .logical $9EF5D0

      .dsection Unsorted9EF5D0Section

    .here

    * = $1EF60F
    .logical $9EF60F

      .dsection Unsorted9EF60FSection
      .dsection BelhallaMagesAttackSection

    .here

    * = $1EF791
    .logical $9EF791

      .dsection Unknown9EF791Section

    .here

    * = $1EF79D
    .logical $9EF79D

      .dsection Unsorted9EF79DSection

    .here

    * = $1EF811
    .logical $9EF811

      .dsection BelhallaAttackingMagePositionsSection

    .here

    * = $1EF81D
    .logical $9EF81D

      .dsection BelhallaAttackingMageDirectionsSection

    .here

    * = $1EF83F
    .logical $9EF83F

      .dsection ProcUnknown9EF837InitSection

    .here

    * = $1EF9DF
    .logical $9EF9DF

      .dsection Unsorted9EF9DFSection

    .here

    * = $1EF9E0
    .logical $9EF9E0

      .dsection Unsorted9EF9E0Section

    .here

    * = $1EFA17
    .logical $9EFA17

      .dsection Unsorted9EFA17Section

    .here

    * = $1EFC47
    .logical $9EFC47

      .dsection Unsorted9EFC47Section

    .here

    * = $1F8020
    .logical $9F8020

      .dsection Unsorted9F8020Section

    .here

    * = $1F805D
    .logical $9F805D

      .dsection ProcScript9F805DSection

    .here

    * = $1F8065
    .logical $9F8065

      .dsection Unsorted9F8065Section

    .here

    * = $1F8253
    .logical $9F8253

      .dsection Unsorted9F8253Section

    .here

    * = $1F82A7
    .logical $9F82A7

      .dsection Unsorted9F82A7Section

    .here

    * = $1F82D7
    .logical $9F82D7

      .dsection Unsorted9F82D7Section

    .here

    * = $1F8349
    .logical $9F8349

      .dsection Unsorted9F8349Section

    .here

    * = $1F83D0
    .logical $9F83D0

      .dsection Unsorted9F83D0Section

    .here

    * = $1F83F1
    .logical $9F83F1

      .dsection Unsorted9F83F1Section

    .here

    * = $1F8414
    .logical $9F8414

      .dsection Unsorted9F8414Section

    .here

    * = $1F86B0
    .logical $9F86B0

      .dsection Unsorted9F86B0Section

    .here

    * = $1F86BF
    .logical $9F86BF

      .dsection Unsorted9F86BFSection

    .here

    * = $1F8900
    .logical $9F8900

      .dsection Unsorted9F8900Section

    .here

    * = $1F8943
    .logical $9F8943

      .dsection Unsorted9F8943Section

    .here

    * = $1F8999
    .logical $9F8999

      .dsection Unsorted9F8999Section

    .here

    * = $1F8A34
    .logical $9F8A34

      .dsection Unsorted9F8A34Section

    .here

    * = $1F8A97
    .logical $9F8A97

      .dsection Unsorted9F8A97Section

    .here

    * = $1F8B7A
    .logical $9F8B7A

      .dsection Unsorted9F8B7ASection

    .here

    * = $1F8E6C
    .logical $9F8E6C

      .dsection SavePaletteBufferColorsToRAMSection

    .here

    * = $1F8EC0
    .logical $9F8EC0

      .dsection Unsorted9F8EC0Section

    .here

    * = $1F8EE1
    .logical $9F8EE1

      .dsection FadePaletteToColorsSection

    .here

    * = $1F8F4F
    .logical $9F8F4F

      .dsection FadePaletteToBlackSection

    .here

    * = $1F8FE3
    .logical $9F8FE3

      .dsection FadeFromToColorByStepSection

    .here

    * = $1F9090
    .logical $9F9090

      .dsection Unsorted9F9090Section

    .here

    * = $1F90F2
    .logical $9F90F2

      .dsection Unsorted9F90F2Section

    .here

    * = $1F910A
    .logical $9F910A

      .dsection Unsorted9F910ASection

    .here

    * = $1F9217
    .logical $9F9217

      .dsection Unsorted9F9217Section

    .here

    * = $1F9253
    .logical $9F9253

      .dsection Unsorted9F9253Section

    .here

    * = $1F926E
    .logical $9F926E

      .dsection Unsorted9F926ESection

    .here

    * = $1F92D2
    .logical $9F92D2

      .dsection Unsorted9F92D2Section

    .here

    * = $1F92F3
    .logical $9F92F3

      .dsection Unsorted9F92F3Section

    .here

    * = $1F9341
    .logical $9F9341

      .dsection Unsorted9F9341Section

    .here

    * = $1F9378
    .logical $9F9378

      .dsection Unsorted9F9378Section

    .here

    * = $1F94FE
    .logical $9F94FE

      .dsection Unsorted9F94FESection

    .here

    * = $1F9570
    .logical $9F9570

      .dsection Unsorted9F9570Section

    .here

    * = $1F95E1
    .logical $9F95E1

      .dsection Unsorted9F95E1Section

    .here

    * = $1F9691
    .logical $9F9691

      .dsection Unsorted9F9691Section

    .here

    * = $1F9954
    .logical $9F9954

      .dsection Unsorted9F9954Section

    .here

    * = $1F9976
    .logical $9F9976

      .dsection Unsorted9F9976Section

    .here

    * = $1F999E
    .logical $9F999E

      .dsection Unsorted9F999ESection

    .here

    * = $1F99CE
    .logical $9F99CE

      .dsection Unsorted9F99CESection

    .here

    * = $1F9ABF
    .logical $9F9ABF

      .dsection Unsorted9F9ABFSection

    .here

    * = $1FBD6B
    .logical $9FBD6B

      .dsection Unsorted9FBD6BSection

    .here

    * = $1FDB68
    .logical $9FDB68

      .dsection Unsorted9FDB68Section

    .here

    * = $1FDB8B
    .logical $9FDB8B

      .dsection Unsorted9FDB8BSection

    .here

    * = $1FDBC4
    .logical $9FDBC4

      .dsection Unsorted9FDBC4Section

    .here

    * = $1FDBFD
    .logical $9FDBFD

      .dsection Unsorted9FDBFDSection

    .here

    * = $1FDC40
    .logical $9FDC40

      .dsection Unsorted9FDC40Section

    .here

    * = $1FDC83
    .logical $9FDC83

      .dsection Unsorted9FDC83Section

    .here

    * = $1FDEE3
    .logical $9FDEE3

      .dsection Unsorted9FDEE3Section

    .here

    * = $1FE006
    .logical $9FE006

      .dsection Unsorted9FE006Section

    .here

    * = $1FEA52
    .logical $9FEA52

      .dsection Unsorted9FEA52Section

    .here

    * = $1FEBA7
    .logical $9FEBA7

      .dsection Unsorted9FEBA7Section

    .here

    * = $1FEBA9
    .logical $9FEBA9

      .dsection ProcScript9FEBA9Section

    .here

    * = $1FECB2
    .logical $9FECB2

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

    * = $1FF250
    .logical $9FF250

      .dsection Unsorted9FF250Section

    .here

    * = $1FF376
    .logical $9FF376

      .dsection Unsorted9FF376Section

    .here

    * = $1FF3ED
    .logical $9FF3ED

      .dsection Unsorted9FF3EDSection

    .here

    * = $20283F
    .logical $E0283F

      .dsection TableE0283FSection

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

    * = $010000
    .logical $C10000

      g4bppcMageFemaleMapMovementSprite         .binary "gfx/MapMovementSprites/MageFemale.4bpp.comp"
      g4bppcMageMapMovementSprite               .binary "gfx/MapMovementSprites/Mage.4bpp.comp"
      g4bppcPriestFemaleMapMovementSprite       .binary "gfx/MapMovementSprites/PriestFemale.4bpp.comp"
      g4bppcJuniorLordMapMovementSprite         .binary "gfx/MapMovementSprites/JuniorLord.4bpp.comp"
      g4bppcMyrmidonMapMovementSprite           .binary "gfx/MapMovementSprites/Myrmidon.4bpp.comp"
      g4bppcLanceArmorMapMovementSprite         .binary "gfx/MapMovementSprites/LanceArmor.4bpp.comp"
      g4bppcBarbarianMapMovementSprite          .binary "gfx/MapMovementSprites/Barbarian.4bpp.comp"
      g4bppcArcherMapMovementSprite             .binary "gfx/MapMovementSprites/Archer.4bpp.comp"
      g4bppcSoldierMapMovementSprite            .binary "gfx/MapMovementSprites/Soldier.4bpp.comp"
      g4bppcArcherFemaleMapMovementSprite       .binary "gfx/MapMovementSprites/ArcherFemale.4bpp.comp"
      g4bppcAxeArmorMapMovementSprite           .binary "gfx/MapMovementSprites/AxeArmor.4bpp.comp"
      g4bppcBowSoldierMapMovementSprite         .binary "gfx/MapMovementSprites/BowSoldier.4bpp.comp"
      g4bppcDancerMapMovementSprite             .binary "gfx/MapMovementSprites/Dancer.4bpp.comp"
      g4bppcMyrmidonFemaleMapMovementSprite     .binary "gfx/MapMovementSprites/MyrmidonFemale.4bpp.comp"
      g4bppcPrincessMapMovementSprite           .binary "gfx/MapMovementSprites/Princess.4bpp.comp"
      g4bppcThiefMapMovementSprite              .binary "gfx/MapMovementSprites/Thief.4bpp.comp"
      g4bppcGeneralMapMovementSprite            .binary "gfx/MapMovementSprites/General.4bpp.comp"
      g4bppcPriestessMapMovementSprite          .binary "gfx/MapMovementSprites/Priestess.4bpp.comp"
      g4bppcFighterMapMovementSprite            .binary "gfx/MapMovementSprites/Fighter.4bpp.comp"
      g4bppcWindMageMapMovementSprite           .crossbank.start "gfx/MapMovementSprites/WindMage.4bpp.comp"

    .here

    * = $020000
    .logical $C20000

      .crossbank.end
      g4bppcWindMageFemaleMapMovementSprite     .binary "gfx/MapMovementSprites/WindMageFemale.4bpp.comp"
      g4bppcPriestMapMovementSprite             .binary "gfx/MapMovementSprites/Priest.4bpp.comp"
      g4bppcHunterMapMovementSprite             .binary "gfx/MapMovementSprites/Hunter.4bpp.comp"
      g4bppcSwordmasterMapMovementSprite        .binary "gfx/MapMovementSprites/Swordmaster.4bpp.comp"
      g4bppcHeroMapMovementSprite               .binary "gfx/MapMovementSprites/Hero.4bpp.comp"
      g4bppcWarriorMapMovementSprite            .binary "gfx/MapMovementSprites/Warrior.4bpp.comp"
      g4bppcBrigandMapMovementSprite            .binary "gfx/MapMovementSprites/Brigand.4bpp.comp"
      g4bppcPirateMapMovementSprite             .binary "gfx/MapMovementSprites/Pirate.4bpp.comp"
      g4bppcHeroFemaleMapMovementSprite         .binary "gfx/MapMovementSprites/HeroFemale.4bpp.comp"
      g4bppcBaronMapMovementSprite              .binary "gfx/MapMovementSprites/Baron.4bpp.comp"
      g4bppcHighPriestFemaleMapMovementSprite   .binary "gfx/MapMovementSprites/HighPriestFemale.4bpp.comp"
      g4bppcSwordmasterFemaleMapMovementSprite  .binary "gfx/MapMovementSprites/SwordmasterFemale.4bpp.comp"
      g4bppcSniperFemaleMapMovementSprite       .binary "gfx/MapMovementSprites/SniperFemale.4bpp.comp"
      g4bppcSniperMapMovementSprite             .binary "gfx/MapMovementSprites/Sniper.4bpp.comp"
      g4bppcEmperorMapMovementSprite            .binary "gfx/MapMovementSprites/Emperor.4bpp.comp"
      g4bppcSwordSoldierMapMovementSprite       .binary "gfx/MapMovementSprites/SwordSoldier.4bpp.comp"
      g4bppcAxeSoldierMapMovementSprite         .binary "gfx/MapMovementSprites/AxeSoldier.4bpp.comp"
      g4bppcSpearSoldierMapMovementSprite       .binary "gfx/MapMovementSprites/SpearSoldier.4bpp.comp"
      g4bppcSwordArmorMapMovementSprite         .crossbank.start "gfx/MapMovementSprites/SwordArmor.4bpp.comp"

    .here

    * = $030000
    .logical $C30000

      .crossbank.end
      g4bppcBowArmorMapMovementSprite           .binary "gfx/MapMovementSprites/BowArmor.4bpp.comp"
      g4bppcFireMageFemaleMapMovementSprite     .binary "gfx/MapMovementSprites/FireMageFemale.4bpp.comp"
      g4bppcFireMageMapMovementSprite           .binary "gfx/MapMovementSprites/FireMage.4bpp.comp"
      g4bppcThunderMageFemaleMapMovementSprite  .binary "gfx/MapMovementSprites/ThunderMageFemale.4bpp.comp"
      g4bppcThunderMageMapMovementSprite        .binary "gfx/MapMovementSprites/ThunderMage.4bpp.comp"
      g4bppcHighPriestMapMovementSprite         .binary "gfx/MapMovementSprites/HighPriest.4bpp.comp"
      g4bppcWarMageFemaleMapMovementSprite      .binary "gfx/MapMovementSprites/WarMageFemale.4bpp.comp"
      g4bppcDarkBishopMapMovementSprite         .binary "gfx/MapMovementSprites/DarkBishop.4bpp.comp"
      g4bppcDarkMageMapMovementSprite           .binary "gfx/MapMovementSprites/DarkMage.4bpp.comp"
      g4bppcPrinceMapMovementSprite             .binary "gfx/MapMovementSprites/Prince.4bpp.comp"
      g4bppcWarMageMapMovementSprite            .binary "gfx/MapMovementSprites/WarMage.4bpp.comp"
      g4bppcChildFemaleMapMovementSprite        .binary "gfx/MapMovementSprites/ChildFemale.4bpp.comp"
      g4bppcChildMapMovementSprite              .binary "gfx/MapMovementSprites/Child.4bpp.comp"
      g4bppcQueenMapMovementSprite              .binary "gfx/MapMovementSprites/Queen.4bpp.comp"
      g4bppcBishopMapMovementSprite             .binary "gfx/MapMovementSprites/Bishop.4bpp.comp"
      g4bppcCivilianMapMovementSprite           .binary "gfx/MapMovementSprites/Civilian.4bpp.comp"
      g4bppcCivilianFemaleMapMovementSprite     .binary "gfx/MapMovementSprites/CivilianFemale.4bpp.comp"
      g4bppcRogueFemaleMapMovementSprite        .binary "gfx/MapMovementSprites/RogueFemale.4bpp.comp"
      g4bppcBardMapMovementSprite               .binary "gfx/MapMovementSprites/Bard.4bpp.comp"
      g4bppcThiefFemaleMapMovementSprite        .binary "gfx/MapMovementSprites/ThiefFemale.4bpp.comp"
      g4bppcRogueMapMovementSprite              .crossbank.start "gfx/MapMovementSprites/Rogue.4bpp.comp"

    .here

    * = $040000
    .logical $C40000

      .crossbank.end
      g4bppcSageMapMovementSprite               .binary "gfx/MapMovementSprites/Sage.4bpp.comp"
      g4bppcSageFemaleMapMovementSprite         .binary "gfx/MapMovementSprites/SageFemale.4bpp.comp"
      g4bppcDarkPrinceMapMovementSprite         .binary "gfx/MapMovementSprites/DarkPrince.4bpp.comp"
      g4bppcSmallOifeyMapMovementSprite         .binary "gfx/MapMovementSprites/SmallOifey.4bpp.comp"
      g4bppcShortEmptyMapMovementSprite         .binary "gfx/MapMovementSprites/ShortEmpty.4bpp.comp"

      g4bppcDragonRiderMapMovementSprite        .binary "gfx/MapMovementSprites/DragonRider.4bpp.comp"
      g4bppcCavalierMapMovementSprite           .binary "gfx/MapMovementSprites/Cavalier.4bpp.comp"
      g4bppcDukeKnightMapMovementSprite         .binary "gfx/MapMovementSprites/DukeKnight.4bpp.comp"
      g4bppcPegasusRiderMapMovementSprite       .binary "gfx/MapMovementSprites/PegasusRider.4bpp.comp"
      g4bppcAxeKnightMapMovementSprite          .binary "gfx/MapMovementSprites/AxeKnight.4bpp.comp"
      g4bppcFreeKnightMapMovementSprite         .binary "gfx/MapMovementSprites/FreeKnight.4bpp.comp"
      g4bppcLanceKnightMapMovementSprite        .binary "gfx/MapMovementSprites/LanceKnight.4bpp.comp"
      g4bppcBowKnightMapMovementSprite          .crossbank.start "gfx/MapMovementSprites/BowKnight.4bpp.comp"

    .here

    * = $050000
    .logical $C50000

      .crossbank.end
      g4bppcKnightLordSeliphMapMovementSprite   .binary "gfx/MapMovementSprites/KnightLordSeliph.4bpp.comp"
      g4bppcTroubadourMapMovementSprite         .binary "gfx/MapMovementSprites/Troubadour.4bpp.comp"
      g4bppcKnightLordSigurdMapMovementSprite   .binary "gfx/MapMovementSprites/KnightLordSigurd.4bpp.comp"
      g4bppcPaladinMapMovementSprite            .binary "gfx/MapMovementSprites/Paladin.4bpp.comp"
      g4bppcDragonMasterMapMovementSprite       .binary "gfx/MapMovementSprites/DragonMaster.4bpp.comp"
      g4bppcArchKnightMapMovementSprite         .binary "gfx/MapMovementSprites/ArchKnight.4bpp.comp"
      g4bppcGreatKnightMapMovementSprite        .binary "gfx/MapMovementSprites/GreatKnight.4bpp.comp"
      g4bppcMageKnightMapMovementSprite         .binary "gfx/MapMovementSprites/MageKnight.4bpp.comp"
      g4bppcDragonKnightMapMovementSprite       .binary "gfx/MapMovementSprites/DragonKnight.4bpp.comp"
      g4bppcPegasusKnightMapMovementSprite      .crossbank.start "gfx/MapMovementSprites/PegasusKnight.4bpp.comp"

    .here

    * = $060000
    .logical $C60000

      .crossbank.end
      g4bppcFalconKnightMapMovementSprite       .binary "gfx/MapMovementSprites/FalconKnight.4bpp.comp"
      g4bppcMasterKnightMapMovementSprite       .binary "gfx/MapMovementSprites/MasterKnight.4bpp.comp"
      g4bppcRangerMapMovementSprite             .binary "gfx/MapMovementSprites/Ranger.4bpp.comp"
      g4bppcBallisticianMapMovementSprite       .binary "gfx/MapMovementSprites/Ballistician.4bpp.comp"
      g4bppcIronBallisticianMapMovementSprite   .binary "gfx/MapMovementSprites/IronBallistician.4bpp.comp"
      g4bppcKillerBallisticianMapMovementSprite .binary "gfx/MapMovementSprites/KillerBallistician.4bpp.comp"
      g4bppcGreatBallisticianMapMovementSprite  .binary "gfx/MapMovementSprites/GreatBallistician.4bpp.comp"
      g4bppcDragonRiderFemaleMapMovementSprite  .binary "gfx/MapMovementSprites/DragonRiderFemale.4bpp.comp"
      g4bppcDragonKnightFemaleMapMovementSprite .binary "gfx/MapMovementSprites/DragonKnightFemale.4bpp.comp"
      g4bppcDragonMasterFemaleMapMovementSprite .binary "gfx/MapMovementSprites/DragonMasterFemale.4bpp.comp"
      g4bppcPaladinFemaleMapMovementSprite      .binary "gfx/MapMovementSprites/PaladinFemale.4bpp.comp"
      g4bppcMageKnightFemaleMapMovementSprite   .crossbank.start "gfx/MapMovementSprites/MageKnightFemale.4bpp.comp"

    .here

    * = $070000
    .logical $C70000

      .crossbank.end
      g4bppcMasterKnightFemaleMapMovementSprite .binary "gfx/MapMovementSprites/MasterKnightFemale.4bpp.comp"
      g4bppcTallEmptyMapMovementSprite          .binary "gfx/MapMovementSprites/TallEmpty.4bpp.comp"

      ; C7/0C6C

    .here

    * = $112E50
    .logical $D12E50

      aVerdaneMapHighlightTilemap          .text ROM[$112E50:$113019] ; D12E50
      aAgustriaMapHighlightTilemap         .text ROM[$113019:$113193] ; D13019
      aSilesseMapHighlightTilemap          .text ROM[$113193:$113300] ; D13193
      aAedMapHighlightTilemap              .text ROM[$113300:$11345D] ; D13300
      aIsaachMapHighlightTilemap           .text ROM[$11345D:$11360F] ; D1345D
      aMunsterMapHighlightTilemap          .text ROM[$11360F:$1137AC] ; D1360F
      aThraciaMapHighlightTilemap          .text ROM[$1137AC:$113977] ; D137AC
      aMiletosMapHighlightTilemap          .text ROM[$113977:$113AAC] ; D13977
      aGrannvaleMapHighlightTilemap        .text ROM[$113AAC:$113C01] ; D13AAC

      ; D1/3C01

    .here

    * = $113C85
    .logical $D13C85

      aWorldMapMarkerShadowTilemap .text ROM[$113C85:$113D09]

      ; D1/3D09

    .here


    * = $1468A3
    .logical $D468A3

      aUnitedGrannvaleMapHighlightTilemap  .text ROM[$1468A3:$14699E] ; D468A3
      aUnifiedThraciaMapHighlightTilemap   .text ROM[$14699E:$146B27] ; D4699E

      ; D4/6B27

    .here

    * = $377C00
    .logical $F77C00

      .dsection TableF77C00Section
      .dsection TableF77C08Section
      .dsection TableF77C0CSection

    .here
